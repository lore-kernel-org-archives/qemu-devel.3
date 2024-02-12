Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C479C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZDo-000056-2q; Mon, 12 Feb 2024 11:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZZDk-0008WN-GF
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:31:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZZDi-0004y8-7F
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:31:52 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYVHt0Swxz689sn;
 Tue, 13 Feb 2024 00:28:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 321A5140B73;
 Tue, 13 Feb 2024 00:31:45 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 16:31:44 +0000
Date: Mon, 12 Feb 2024 16:31:43 +0000
To: <linuxarm@huawei.com>, <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, <linux-cxl@vger.kernel.org>
CC: Mattias Nissler <mnissler@rivosinc.com>
Subject: Bug: physmem: address_space_read_cached_slow() accesses wrong
 MemoryRegion on latter part of large reads.
Message-ID: <20240212163143.0000690a@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi All,

The continuing saga of a getting CXL emulation to play well with using the
memory as normal RAM ran into (hopefully) a last issue.

When running my boot image via virtio-blk-pci and having deliberately forced some
buffers to end up in the CXL memory via
$ numactl --membind=1 ls
then on shut down I was getting a failure to allocate a large enough DMA buffer
even with Mattias' set to increase the size and an extra patch to apply that to
the main system memory (as virtio ignores iommu and PCI address space).
gdb/bt pointed at virtqueue_split_pop() bt pointed later than the actual problem
as descriptors were loaded but corrupt here:
https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L1573
https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L306

After a chase (via a highly suspicious read size of 0xffffffff it turns
out it was issuing a 16 byte read via address_space_read_cached_slow() and
getting a very odd answer.

The first 8 bytes was the correct virtio descriptor content the second 8
were coming from the flash region at physical address 0 onwards on arm-virt.

With those breadcrumbs the problem was (I think) easy to find.

https://elixir.bootlin.com/qemu/latest/source/include/exec/memory.h#L3029
address_space_read_cached_slow() operates on a MemoryRegionCache with the
hwaddr being relative to the start of that cached region.

However it calls flatview_read_continue()  That's fine as long as we can
do the read in one go.


For normal memory flatview_read_continue() will deal with splitting a read up
but on each iteration it loads the mr via
mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
to cope with reads that cross MemoryRegions.
https://elixir.bootlin.com/qemu/latest/source/system/physmem.c#L2737

Unfortunately the addr passed in here is the one addressing into the
MemoryRegionCache offset by whatever we already read.
Which for this bug example that was 0x8 (in the flash memory).

Assuming I have correctly identified the problem.
One potential fix is to define a new

MemtxResult address_space_read_cached_continue(MemoryRegionCache *cache,
                                               hwaddr addr, MemTxAttr attrs,
                                               void *ptr, hwaddr len,
                                               hwaddr addr1, hwaddr l,
                                               MemoryRegion *mr)

That is nearly identical to flatview_read_continue() but with the 
mr = flatview_translate() replaced with
mr = address_space_translate_cached(cache, addr, &addr1, &l, false, attrs)

That's a bit ugly though given the duplicated code but any other change
is going to involve some more invasive splitting out of utility functions
to share all but the outer loop.

I don't currently have a test hitting it but assume
flatview_write_continue() in address_space_write_cached_slow() has the
same problem.

Jonathan

p.s. Will tidy this and the rest of my house of cards up then post it.
I suspect we'll carry on hitting QEMU limitations with the CXL emulation
but for now I have x86 and ARM setups that work with TCG.
Hmm. Need to spend some time getting regressions tests in place :(


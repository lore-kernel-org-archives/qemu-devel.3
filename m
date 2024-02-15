Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40DFC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racjL-0003IT-11; Thu, 15 Feb 2024 09:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1racjG-0003I7-1t
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:28:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1raciy-0001hr-MZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:28:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbHQ95f2Sz6K8xj;
 Thu, 15 Feb 2024 22:24:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8ABB31400CD;
 Thu, 15 Feb 2024 22:28:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 14:28:17 +0000
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 0/3] physmem: Fix MemoryRegion for second access to cached
 MMIO Address Space 
Date: Thu, 15 Feb 2024 14:28:14 +0000
Message-ID: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

Issue seen testing virtio-blk-pci with CXL emulated interleave memory.
Tests were done on arm64, but the issue isn't architecture specific.
Note that some additional fixes are needed to TCG to be able to run far
enough to hit this on arm64 or x86. They are issues so I'll post separate
series shortly.

The address_space_read_cached_slow() and address_space_write_cached_slow()
functions query the MemoryRegion for the cached address space correctly
using address_space_translate_cached() but then call into
flatview_read_continue() / flatview_write_continue()
If the access is to a MMIO MemoryRegion and is bigger than the MemoryRegion
supports, the loop will query the MemoryRegion for the next access to use.
That query uses flatview_translate() but the address passed is suitable
for the cache, not the flatview. On my test setup that mean the second
8 bytes and onwards of the virtio descriptor was read from flash memory
at the beginning of the system address map, not the CXL emulated memory
where the descriptor was found.  Result happened to be all fs so easy to
spot.

Changes these calls to use address_space_translate_cached() to get the
correct MemoryRegion for the cache. To avoid duplicating most of the
code, the first 2 patches factor out the common parts of
flatview_read_continue() and flatview_write_continue() so they can
be reused.

Write path has not been tested but it so similar to the read path I've
included it here.

Jonathan Cameron (3):
  physmem: Reduce local variable scope in flatview_read/write_continue()
  physmem: Factor out body of flatview_read/write_continue() loop
  physmem: Fix wrong MR in large address_space_read/write_cached_slow()

 system/physmem.c | 245 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 170 insertions(+), 75 deletions(-)

-- 
2.39.2



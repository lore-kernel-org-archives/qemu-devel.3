Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65600C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 17:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYUr0-0001pv-75; Fri, 09 Feb 2024 12:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rYUqy-0001pn-Ud
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:39:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rYUqw-00024w-5t
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:39:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TWgxw6DdFz6K8tX;
 Sat, 10 Feb 2024 01:36:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9B1D41400CF;
 Sat, 10 Feb 2024 01:39:40 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 9 Feb
 2024 17:39:40 +0000
Date: Fri, 9 Feb 2024 17:39:39 +0000
To: Mattias Nissler <mnissler@rivosinc.com>
CC: <stefanha@redhat.com>, <jag.raman@oracle.com>, <qemu-devel@nongnu.org>,
 <peterx@redhat.com>, <john.levon@nutanix.com>, David Hildenbrand
 <david@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "Elena
 Ufimtseva" <elena.ufimtseva@oracle.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 0/5] Support message-based DMA in vfio-user server
Message-ID: <20240209173939.0000538f@huawei.com>
In-Reply-To: <20231101131611.775299-1-mnissler@rivosinc.com>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed,  1 Nov 2023 06:16:06 -0700
Mattias Nissler <mnissler@rivosinc.com> wrote:

> This series adds basic support for message-based DMA in qemu's vfio-user
> server. This is useful for cases where the client does not provide file
> descriptors for accessing system memory via memory mappings. My motivating use
> case is to hook up device models as PCIe endpoints to a hardware design. This
> works by bridging the PCIe transaction layer to vfio-user, and the endpoint
> does not access memory directly, but sends memory requests TLPs to the hardware
> design in order to perform DMA.
> 
> Note that more work is needed to make message-based DMA work well: qemu
> currently breaks down DMA accesses into chunks of size 8 bytes at maximum, each
> of which will be handled in a separate vfio-user DMA request message. This is
> quite terrible for large DMA accesses, such as when nvme reads and writes
> page-sized blocks for example. Thus, I would like to improve qemu to be able to
> perform larger accesses, at least for indirect memory regions. I have something
> working locally, but since this will likely result in more involved surgery and
> discussion, I am leaving this to be addressed in a separate patch.
> 
Hi Mattias,

I was wondering what the status of this patch set is - seems no outstanding issues
have been raised?

I'd run into a similar problem with multiple DMA mappings using the bounce buffer
when using the emulated CXL memory with virtio-blk-pci accessing it.

In that particular case virtio-blk is using the "memory" address space, but
otherwise your first 2 patches work for me as well so I'd definitely like
to see those get merged!

Thanks,

Jonathan

> Changes from v1:
> 
> * Address Stefan's review comments. In particular, enforce an allocation limit
>   and don't drop the map client callbacks given that map requests can fail when
>   hitting size limits.
> 
> * libvfio-user version bump now included in the series.
> 
> * Tested as well on big-endian s390x. This uncovered another byte order issue
>   in vfio-user server code that I've included a fix for.
> 
> Changes from v2:
> 
> * Add a preparatory patch to make bounce buffering an AddressSpace-specific
>   concept.
> 
> * The total buffer size limit parameter is now per AdressSpace and can be
>   configured for PCIDevice via a property.
> 
> * Store a magic value in first bytes of bounce buffer struct as a best effort
>   measure to detect invalid pointers in address_space_unmap.
> 
> Changes from v3:
> 
> * libvfio-user now supports twin-socket mode which uses separate sockets for
>   client->server and server->client commands, respectively. This addresses the
>   concurrent command bug triggered by server->client DMA access commands. See
>   https://github.com/nutanix/libvfio-user/issues/279 for details.
> 
> * Add missing teardown code in do_address_space_destroy.
> 
> * Fix bounce buffer size bookkeeping race condition.
> 
> * Generate unmap notification callbacks unconditionally.
> 
> * Some cosmetic fixes.
> 
> Changes from v4:
> 
> * Fix accidentally dropped memory_region_unref, control flow restored to match
>   previous code to simplify review.
> 
> * Some cosmetic fixes.
> 
> Changes from v5:
> 
> * Unregister indirect memory region in libvfio-user dma_unregister callback.
> 
> I believe all patches in the series have been reviewed appropriately, so my
> hope is that this will be the final iteration. Stefan, Peter, Jag, thanks for
> your feedback, let me know if there's anything else needed from my side before
> this can get merged.
> 
> Mattias Nissler (5):
>   softmmu: Per-AddressSpace bounce buffering
>   softmmu: Support concurrent bounce buffers
>   Update subprojects/libvfio-user
>   vfio-user: Message-based DMA support
>   vfio-user: Fix config space access byte order
> 
>  hw/pci/pci.c                  |   8 ++
>  hw/remote/trace-events        |   2 +
>  hw/remote/vfio-user-obj.c     | 104 +++++++++++++++++++++----
>  include/exec/cpu-common.h     |   2 -
>  include/exec/memory.h         |  41 +++++++++-
>  include/hw/pci/pci_device.h   |   3 +
>  subprojects/libvfio-user.wrap |   2 +-
>  system/dma-helpers.c          |   4 +-
>  system/memory.c               |   8 ++
>  system/physmem.c              | 141 ++++++++++++++++++----------------
>  10 files changed, 226 insertions(+), 89 deletions(-)
> 



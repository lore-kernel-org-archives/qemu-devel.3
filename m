Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179E8C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radgE-0001Xt-0q; Thu, 15 Feb 2024 10:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1radgC-0001Xf-2g
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:29:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1radg7-0000di-EO
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:29:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbJmV5CxNz689PV;
 Thu, 15 Feb 2024 23:25:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 416521402CD;
 Thu, 15 Feb 2024 23:29:31 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 15:29:30 +0000
Date: Thu, 15 Feb 2024 15:29:29 +0000
To: Peter Maydell <peter.maydell@linaro.org>, <linuxarm@huawei.com>, Dimitrios
 Palyvos <dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: Gregory Price <gregory.price@memverge.com>, Alex =?ISO-8859-1?Q?Benn?=
 =?ISO-8859-1?Q?=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
 <sajjanr@gmail.com>, <richard.henderson@linaro.org>, <mst@redhat.com>,
 <david@redhat.com>, Mattias Nissler <mnissler@rivosinc.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240215152929.00007e8d@huawei.com>
In-Reply-To: <20240208145042.0000065f@huawei.com>
References: <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com>
 <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com>
 <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com>
 <20240202162633.0000453c@huawei.com>
 <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
 <Zb0dXy72lyglchJa@memverge.com>
 <CAFEAcA9KG9mF2KRS_Z2XdfD6b-aaNssZ7HCL_JKymyRkCJMq0A@mail.gmail.com>
 <20240207173415.00000125@huawei.com>
 <20240208145042.0000065f@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Thu, 8 Feb 2024 14:50:59 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 7 Feb 2024 17:34:15 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Fri, 2 Feb 2024 16:56:18 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> > > On Fri, 2 Feb 2024 at 16:50, Gregory Price <gregory.price@memverge.com> wrote:    
> > > >
> > > > On Fri, Feb 02, 2024 at 04:33:20PM +0000, Peter Maydell wrote:      
> > > > > Here we are trying to take an interrupt. This isn't related to the
> > > > > other can_do_io stuff, it's happening because do_ld_mmio_beN assumes
> > > > > it's called with the BQL not held, but in fact there are some
> > > > > situations where we call into the memory subsystem and we do
> > > > > already have the BQL.      
> > >     
> > > > It's bugs all the way down as usual!
> > > > https://xkcd.com/1416/
> > > >
> > > > I'll dig in a little next week to see if there's an easy fix. We can see
> > > > the return address is already 0 going into mmu_translate, so it does
> > > > look unrelated to the patch I threw out - but probably still has to do
> > > > with things being on IO.      
> > > 
> > > Yes, the low level memory accessors only need to take the BQL if the thing
> > > being accessed is an MMIO device. Probably what is wanted is for those
> > > functions to do "take the lock if we don't already have it", something
> > > like hw/core/cpu-common.c:cpu_reset_interrupt() does.  
> 
> Got back to x86 testing and indeed not taking the lock in that one path
> does get things running (with all Gregory's earlier hacks + DMA limits as
> described below).  Guess it's time to roll some cleaned up patches and
> see how much everyone screams :)
> 

3 series sent out:
(all also on gitlab.com/jic23/qemu cxl-2024-02-15 though I updated patch descriptions
a little after pushing that out)

Main set of fixes (x86 'works' under my light testing after this one)
https://lore.kernel.org/qemu-devel/20240215150133.2088-1-Jonathan.Cameron@huawei.com/

ARM FEAT_HADFS (access and dirty it updating in PTW) workaround for missing atomic CAS
https://lore.kernel.org/qemu-devel/20240215151804.2426-1-Jonathan.Cameron@huawei.com/T/#t

DMA / virtio fix:
https://lore.kernel.org/qemu-devel/20240215142817.1904-1-Jonathan.Cameron@huawei.com/

Last thing I need to do is propose a suitable flag to make 
Mattias' bounce buffering size parameter apply to "memory" address space.  Currently
I'm carrying this: (I've no idea how much is need but it's somewhere between 4k and 1G)

diff --git a/system/physmem.c b/system/physmem.c
index 43b37942cf..49b961c7a5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2557,6 +2557,7 @@ static void memory_map_init(void)
     memory_region_init(system_memory, NULL, "system", UINT64_MAX);
     address_space_init(&address_space_memory, system_memory, "memory");

+    address_space_memory.max_bounce_buffer_size = 1024 * 1024 * 1024;
     system_io = g_malloc(sizeof(*system_io));
     memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
                           65536);

Please take a look. These are all in areas of QEMU I'm not particularly confident
about so relying on nice people giving feedback even more than normal!

Thanks to all those who helped with debugging and suggestions.

Thanks,

Jonathan

> Jonathan
> 
> 
> > > 
> > > -- PMM    
> > 
> > Still a work in progress but I thought I'd give an update on some of the fun...
> > 
> > I have a set of somewhat dubious workarounds that sort of do the job (where
> > the aim is to be able to safely run any workload on top of any valid
> > emulated CXL device setup).
> > 
> > To recap, the issue is that for CXL memory interleaving we need to have
> > find grained routing to each device (16k Max Gran).  That was fine whilst
> > pretty much all the testing was DAX based so software wasn't running out
> > of it.  Now the kernel is rather more aggressive in defaulting any volatile
> > CXL memory it finds to being normal memory (in some configs anyway) people
> > started hitting problems. Given one of the most important functions of the
> > emulation is to check data ends up in the right backing stores, I'm not
> > keen to drop that feature unless we absolutely have to.
> > 
> > 1) For the simple case of no interleave I have working code that just
> >    shoves the MemoryRegion in directly and all works fine.  That was always
> >    on the todo list for virtualization cases anyway were we pretend the
> >    underlying devices aren't interleaved and frig the reported perf numbers
> >    to present aggregate performance etc.  I'll tidy this up and post it.
> >    We may want a config parameter to 'reject' address decoder programming
> >    that would result in interleave - it's not remotely spec compliant, but
> >    meh, it will make it easier to understand.  For virt case we'll probably
> >    present locked down decoders (as if a FW has set them up) but for emulation
> >    that limits usefulness too much.
> >    
> > 2) Unfortunately, for the interleaved case can't just add a lot of memory
> >    regions because even at highest granularity (16k) and minimum size
> >    512MiB it takes for ever to eventually run into an assert in
> >    phys_section_add with the comment:
> >    "The physical section number is ORed with a page-aligned
> >     pointer to produce the iotlb entries.  Thus it should
> >     never overflow into the page-aligned value."
> >     That sounds hard to 'fix' though I've not looked into it.
> > 
> > So back to plan (A) papering over the cracks with TCG.
> > 
> > I've focused on arm64 which seems a bit easier than x86 (and is arguably
> > part of my day job)
> > 
> > Challenges
> > 1) The atomic updates of accessed and dirty bits in
> >    arm_casq_ptw() fail because we don't have a proper address to do them
> >    on.  However, there is precedence for non atomic updates in there
> >    already (used when the host system doesn't support big enough cas)
> >    I think we can do something similar under the bql for this case.
> >    Not 100% sure I'm writing to the correct address but a simple frig
> >    superficially appears to work.
> > 2) Emulated devices try to do DMA to buffers in the CXL emulated interleave
> >    memory (virtio_blk for example).  Can't do that because there is no
> >    actual translation available - just read and write functions.
> > 
> >    So should be easy to avoid as we know how to handle DMA limitations.
> >    Just set the max dma address width to 40 bits (so below the CXL Fixed Memory
> >    Windows and rely on Linux to bounce buffer with swiotlb). For a while
> >    I couldn't work out why changing IORT to provide this didn't work and
> >    I saw errors for virtio-pci-blk. So digging ensued.
> >    Virtio devices by default (sort of) bypass the dma-api in linux.
> >    vring_use_dma_api() in Linux. That is reasonable from the translation
> >    point of view, but not the DMA limits (and resulting need to use bounce
> >    buffers).  Maybe could put a sanity check in linux on no iommu +
> >    a DMA restriction to below 64 bits but I'm not 100% sure we wouldn't
> >    break other platforms.
> >    Alternatively just use emulated real device and all seems fine
> >    - I've tested with nvme.
> > 
> > 3) I need to fix the kernel handling for CXL CDAT table originated
> >    NUMA nodes on ARM64. For now I have a hack in place so I can make
> >    sure I hit the memory I intend to when testing. I suspect we need
> >    some significant work to sort 
> > 
> > Suggestions for other approaches would definitely be welcome!
> > 
> > Jonathan
> >   
> 
> 



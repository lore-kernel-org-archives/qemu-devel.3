Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED500C87FCA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 12:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufeMk-0000jH-Lx; Sat, 26 Jul 2025 08:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <engguopeng@buaa.edu.cn>)
 id 1ufeMg-0000ik-F2
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 08:51:02 -0400
Received: from azure-sdnproxy.icoremail.net ([52.229.205.26])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <engguopeng@buaa.edu.cn>) id 1ufeMb-00056L-HM
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 08:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To; bh=PNFerZVdr2mLQkd+9Phexr03FUsp
 45TrLh1utCgeVrU=; b=wBzQcSjO8ReFgavmM3l2FZi78nScxf7yqQlEKZz3xSeK
 zil0W93qzhY9CYY/IrW1R4Sya6eeB+Gto2SBXouKvJNEdkIHqpGtuHISX+RR7I22
 feJxDHP9/ZWo34A6Y97+S+dJj53gcPpqchNUBIWP3ZQ1onMDcbJtyxL3BCokUJ0=
Received: from localhost (unknown [139.227.252.237])
 by coremail-app2 (Coremail) with SMTP id Nyz+CgDHwHEbz4RoW6UaAA--.6253S2;
 Sat, 26 Jul 2025 20:50:37 +0800 (CST)
Date: Sat, 26 Jul 2025 20:50:35 +0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <aITPG_ZeM_PqsFgh@gp-VMware-Virtual-Platform>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
 <20250725145337.00003c91@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725145337.00003c91@huawei.com>
X-CM-TRANSID: Nyz+CgDHwHEbz4RoW6UaAA--.6253S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rXr1UuF1xXFyrWw1UAwb_yoWrAr1rpr
 yDJa4UKaykXryxGFZ2vF9YyF1UuF4vk3WUCFn3Kw1I9rnxGrn8A34vyrWFva48Xrs3GFyx
 XFZ8tas3tw4DZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUylb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW7tr1U
 Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc9mRUUUUU
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/
Received-SPF: pass client-ip=52.229.205.26;
 envelope-from=engguopeng@buaa.edu.cn; helo=azure-sdnproxy.icoremail.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  peng guo <engguopeng@buaa.edu.cn>
From:  peng guo via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 25, 2025 at 02:53:37PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Jul 2025 21:35:45 +0800
> peng guo <engguopeng@buaa.edu.cn> wrote:
> 
> > When using a CXL Type 3 device together with a virtio 9p device in QEMU, the
> > 9p device fails to initialize properly. The kernel reports the following:
> > 
> >     virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
> >     9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22
> > 
> > Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
> > device was overlapped by the memory window allocated for the CXL devices. As a
> > result, the kernel could not correctly access the BAR region, causing the
> > virtio device to malfunction.
> > 
> > An excerpt from /proc/iomem shows:
> > 
> >     480010000-cffffffff : CXL Window 0
> >       480010000-4bfffffff : PCI Bus 0000:00
> >       4c0000000-4c01fffff : PCI Bus 0000:0c
> >         4c0000000-4c01fffff : PCI Bus 0000:0d
> >       4c0200000-cffffffff : PCI Bus 0000:00
> >         4c0200000-4c0203fff : 0000:00:03.0
> >           4c0200000-4c0203fff : virtio-pci-modern
> > 
> > To address this issue, this patch uses the value of `cxl_resv_end` to reserve
> > sufficient address space and ensure that CXL memory windows are allocated
> > beyond all PCI 64-bit BARs. This prevents overlap with 64-bit BARs regions such 
> > as those used by virtio or other pcie devices, resolving the conflict.
> > 
> > QEMU Build Configuration:
> > 
> >     ./configure --prefix=/home/work/qemu_master/build/ \
> >                 --target-list=x86_64-softmmu \
> >                 --enable-kvm \
> >                 --enable-virtfs
> > 
> > QEMU Boot Command:
> > 
> >     sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
> >         -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
> >         -hda /home/work/gp_qemu/rootfs.img \
> >         -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
> >         -kernel /home/work/linux_output/arch/x86/boot/bzImage \
> >         --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
> >         -object memory-backend-ram,id=vmem0,share=on,size=4096M \
> >         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >         -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> >         -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
> >         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> > 
> > Tested in a QEMU setup with a CXL Type 3 device and a 9pnet virtio device.
> > 
> > Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> Analysis looks good.
> 
> For the patch I wonder if we should match the check that follows
> for pcms->cxl_devices_state.is_enabled rather than checking cxl_resv_end
> (which is only set to non 0 if that is_enabled is set).
> 
> Probably better to use a consistent condition for checking if CXL is
> there or not.
> 
> We also ideally need a suitable fixes tag.  I couldn't immediately find one
> so maybe it goes a long way back.
> 

Checking `is_enabled` instead of `cxl_resv_end` makes sense.

Building on that, I wonder if it would be worthwhile to move the assignment of 
`res_mem_end` outside the conditional block. Then simply use `res_mem_end` 
itself as the condition. That would eliminate the need to check `is_enabled` 
directly in this spot and simplify the logic slighly. The benefit may 
be minor, but it might help unify the logic around how `res_mem_end` is used.

I will make an effort to identify the appropriate fixes tags related to this. My 
guess is that it relates to the patch where the CXL windows were originally 
introduced and activated in the system.

> > ---
> >  hw/i386/pc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2f58e73d3347..180bc615f3f0 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -975,7 +975,7 @@ void pc_memory_init(PCMachineState *pcms,
> >  
> >      rom_set_fw(fw_cfg);
> >  
> > -    if (machine->device_memory) {
> > +    if (machine->device_memory || cxl_resv_end) {
> >          uint64_t *val = g_malloc(sizeof(*val));
> >          uint64_t res_mem_end;
> >  



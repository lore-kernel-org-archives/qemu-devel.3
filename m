Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451DBCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGG7i-0003IC-DU; Tue, 04 Nov 2025 07:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <engguopeng@buaa.edu.cn>)
 id 1vGG7g-0003Hu-KY; Tue, 04 Nov 2025 07:26:53 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <engguopeng@buaa.edu.cn>)
 id 1vGG7Z-0002Se-Cg; Tue, 04 Nov 2025 07:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=7T
 tS86eDeuZm5/mYpZ1tV/WPwv58WO1xWeUSy8VZHic=; b=y356CdBX6EMY/UNAXV
 dgFWaR0rAOCbcVB66wNXGCYjWk5ocUVQ55aStTPkcHfrGWnsj7AMMK1AjR36rWIH
 biNclfjyc5RMzs02k0Z3zZqeLcTiEzvp0qF/mpUPNOUN1zDzaRrc2sBF9Zm3a+ib
 Bmez/lUVN1BXFJCO2wD6y6LKE=
Received: from localhost (unknown [223.166.13.12])
 by coremail-app1 (Coremail) with SMTP id OCz+CgBHCAvs8AlpPAIiAA--.18765S2;
 Tue, 04 Nov 2025 20:26:21 +0800 (CST)
Date: Tue, 4 Nov 2025 20:26:20 +0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 33/75] hw/i386/pc: Avoid overlap between CXL window and
 PCI 64bit BARs in QEMU
Message-ID: <aQnw7IyrIZy1x_zw@gp-VMware-Virtual-Platform>
References: <cover.1759691708.git.mst@redhat.com>
 <d1193481dee63442fc41e47ca6ebc4cd34f1f69c.1759691708.git.mst@redhat.com>
 <26067051-421d-44ed-9c7e-13ed0bdac18b@tls.msk.ru>
 <949000e9-ac59-4bc9-ad00-861c3a9a08c9@tls.msk.ru>
 <20251029110113.000028ca@huawei.com>
 <d224e9ff-4a4d-4c53-8875-eb05b3b51768@tls.msk.ru>
 <20251031101315.000037f8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031101315.000037f8@huawei.com>
X-CM-TRANSID: OCz+CgBHCAvs8AlpPAIiAA--.18765S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1UJF47WF4kGr45ZFyUAwb_yoW7Gr4xpr
 yktFyUKFWrGr1xJr12q3WDJryUtr1DA3WDXr1DJF18GFsrtr1Yqr1UXr1jgryUtr4rJr17
 Jry5Jry2vr1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
 0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_Xr1l
 42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW7tr1UJr1l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
 42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
 evJa73UjIFyTuYvjxUcWE_DUUUU
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/
Received-SPF: pass client-ip=206.189.21.223;
 envelope-from=engguopeng@buaa.edu.cn;
 helo=zg8tmja2lje4os4yms4ymjma.icoremail.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 31, 2025 at 10:13:15AM +0000, Jonathan Cameron wrote:
> On Wed, 29 Oct 2025 17:10:55 +0300
> Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
> > 29.10.2025 14:01, Jonathan Cameron via пишет:
> > > On Tue, 28 Oct 2025 22:26:12 +0300
> > > Michael Tokarev <mjt@tls.msk.ru> wrote:
> > >   
> > >> On 10/6/25 20:08, Michael Tokarev wrote:  
> > >>> On 10/5/25 22:17, Michael S. Tsirkin wrote:  
> > >>>> From: peng guo <engguopeng@buaa.edu.cn>
> > >>>>
> > >>>> When using a CXL Type 3 device together with a virtio 9p device in
> > >>>> QEMU on a
> > >>>> physical server, the 9p device fails to initialize properly. The
> > >>>> kernel reports
> > >>>> the following error:
> > >>>>
> > >>>>       virtio: device uses modern interface but does not have
> > >>>> VIRTIO_F_VERSION_1
> > >>>>       9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with
> > >>>> error -22
> > >>>>
> > >>>> Further investigation revealed that the 64-bit BAR space assigned to
> > >>>> the 9pnet
> > >>>> device was overlapped by the memory window allocated for the CXL
> > >>>> devices. As a
> > >>>> result, the kernel could not correctly access the BAR region, causing the
> > >>>> virtio device to malfunction.
> > >>>>
> > >>>> An excerpt from /proc/iomem shows:
> > >>>>
> > >>>>       480010000-cffffffff : CXL Window 0
> > >>>>         480010000-4bfffffff : PCI Bus 0000:00
> > >>>>         4c0000000-4c01fffff : PCI Bus 0000:0c
> > >>>>           4c0000000-4c01fffff : PCI Bus 0000:0d
> > >>>>         4c0200000-cffffffff : PCI Bus 0000:00
> > >>>>           4c0200000-4c0203fff : 0000:00:03.0
> > >>>>             4c0200000-4c0203fff : virtio-pci-modern
> > >>>>
> > >>>> To address this issue, this patch adds the reserved memory end
> > >>>> calculation
> > >>>> for cxl devices to reserve sufficient address space and ensure that
> > >>>> CXL memory
> > >>>> windows are allocated beyond all PCI 64-bit BARs. This prevents
> > >>>> overlap with
> > >>>> 64-bit BARs regions such as those used by virtio or other pcie devices,
> > >>>> resolving the conflict.
> > >>>>
> > >>>> QEMU Build Configuration:
> > >>>>
> > >>>>       ./configure --prefix=/home/work/qemu_master/build/ \
> > >>>>                   --target-list=x86_64-softmmu \
> > >>>>                   --enable-kvm \
> > >>>>                   --enable-virtfs
> > >>>>
> > >>>> QEMU Boot Command:
> > >>>>
> > >>>>       sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
> > >>>>           -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
> > >>>>           -hda /home/work/gp_qemu/rootfs.img \
> > >>>>           -virtfs local,path=/home/work/gp_qemu/
> > >>>> share,mount_tag=host0,security_model=passthrough,id=host0 \
> > >>>>           -kernel /home/work/linux_output/arch/x86/boot/bzImage \
> > >>>>           --append "console=ttyS0 crashkernel=256M root=/dev/sda
> > >>>> rootfstype=ext4 rw loglevel=8" \
> > >>>>           -object memory-backend-ram,id=vmem0,share=on,size=4096M \
> > >>>>           -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > >>>>           -device cxl-
> > >>>> rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > >>>>           -device cxl-type3,bus=root_port13,volatile-
> > >>>> memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
> > >>>>           -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> > >>>>
> > >>>> Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a
> > >>>> machine parameter")
> > >>>> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> > >>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >>>> Message-ID: <20250805142300.15226-1-engguopeng@buaa.edu.cn>
> > >>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >>>> ---
> > >>>>    hw/i386/pc.c | 20 +++++++++++---------
> > >>>>    1 file changed, 11 insertions(+), 9 deletions(-)  
> > >>>
> > >>> Hi!
> > >>>
> > >>> Is it qemu-stable material (10.0.x & 10.1.x)?  
> > > 
> > > I think it does make sense for stable.  
> > 
> > Aha.  I remember now why I had this question to begin with.
> > 
> > If it should be applied to 10.0.x series too (which is an LTS series),
> > I need help back-porting it before commit 8b1c560937467d0d9
> > "hw/i386/pc: Remove PCMachineClass::broken_reserved_end field"
> > which touches the same code.
> 
> I don't have strong opinions either way. peng guo, if you happen
> to be in a position to backport and test with QEMU LTS that would be
> great.
> 
> Jonathan
Hi Jonathan,

I'll move forward with back-porting and testing with the QEMU LTS as
soon as possible.

Apologies for the delayed reply. I didn't have a computer and env before
because i was on vacation.

BR
Peng.

> 
> > 
> > If it's worth the effort to begin with.
> > 
> > Meanwhile I picked it up for 10.1.x.
> > 
> > Thank you!
> > 
> > /mjt



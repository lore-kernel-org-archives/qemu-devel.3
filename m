Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A0BCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEm8P-00068O-1e; Fri, 31 Oct 2025 06:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vEm8N-000689-NB; Fri, 31 Oct 2025 06:13:27 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vEm8I-0003Eh-Ff; Fri, 31 Oct 2025 06:13:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cycFn3HTvz6K64S;
 Fri, 31 Oct 2025 18:11:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id ACC3014037D;
 Fri, 31 Oct 2025 18:13:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 31 Oct
 2025 10:13:16 +0000
Date: Fri, 31 Oct 2025 10:13:15 +0000
To: Michael Tokarev <mjt@tls.msk.ru>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, "Peter
 Maydell" <peter.maydell@linaro.org>, peng guo <engguopeng@buaa.edu.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 33/75] hw/i386/pc: Avoid overlap between CXL window and
 PCI 64bit BARs in QEMU
Message-ID: <20251031101315.000037f8@huawei.com>
In-Reply-To: <d224e9ff-4a4d-4c53-8875-eb05b3b51768@tls.msk.ru>
References: <cover.1759691708.git.mst@redhat.com>
 <d1193481dee63442fc41e47ca6ebc4cd34f1f69c.1759691708.git.mst@redhat.com>
 <26067051-421d-44ed-9c7e-13ed0bdac18b@tls.msk.ru>
 <949000e9-ac59-4bc9-ad00-861c3a9a08c9@tls.msk.ru>
 <20251029110113.000028ca@huawei.com>
 <d224e9ff-4a4d-4c53-8875-eb05b3b51768@tls.msk.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 29 Oct 2025 17:10:55 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 29.10.2025 14:01, Jonathan Cameron via =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, 28 Oct 2025 22:26:12 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
> >  =20
> >> On 10/6/25 20:08, Michael Tokarev wrote: =20
> >>> On 10/5/25 22:17, Michael S. Tsirkin wrote: =20
> >>>> From: peng guo <engguopeng@buaa.edu.cn>
> >>>>
> >>>> When using a CXL Type 3 device together with a virtio 9p device in
> >>>> QEMU on a
> >>>> physical server, the 9p device fails to initialize properly. The
> >>>> kernel reports
> >>>> the following error:
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 virtio: device uses modern interface but d=
oes not have
> >>>> VIRTIO_F_VERSION_1
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 9pnet_virtio virtio0: probe with driver 9p=
net_virtio failed with
> >>>> error -22
> >>>>
> >>>> Further investigation revealed that the 64-bit BAR space assigned to
> >>>> the 9pnet
> >>>> device was overlapped by the memory window allocated for the CXL
> >>>> devices. As a
> >>>> result, the kernel could not correctly access the BAR region, causin=
g the
> >>>> virtio device to malfunction.
> >>>>
> >>>> An excerpt from /proc/iomem shows:
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 480010000-cffffffff : CXL Window 0
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 480010000-4bfffffff : PCI Bus =
0000:00
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4c0000000-4c01fffff : PCI Bus =
0000:0c
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4c0000000-4c01ffff=
f : PCI Bus 0000:0d
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4c0200000-cffffffff : PCI Bus =
0000:00
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4c0200000-4c0203ff=
f : 0000:00:03.0
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4c0200=
000-4c0203fff : virtio-pci-modern
> >>>>
> >>>> To address this issue, this patch adds the reserved memory end
> >>>> calculation
> >>>> for cxl devices to reserve sufficient address space and ensure that
> >>>> CXL memory
> >>>> windows are allocated beyond all PCI 64-bit BARs. This prevents
> >>>> overlap with
> >>>> 64-bit BARs regions such as those used by virtio or other pcie devic=
es,
> >>>> resolving the conflict.
> >>>>
> >>>> QEMU Build Configuration:
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 ./configure --prefix=3D/home/work/qemu_mas=
ter/build/ \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --target-list=3Dx86_64-softmmu \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable-kvm \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable-virtfs
> >>>>
> >>>> QEMU Boot Command:
> >>>>
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0 sudo /home/work/qemu_master/qemu/build/qem=
u-system-x86_64 \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -nographic -machin=
e q35,cxl=3Don -enable-kvm -m 16G -smp 8 \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -hda /home/work/gp=
_qemu/rootfs.img \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -virtfs local,path=
=3D/home/work/gp_qemu/
> >>>> share,mount_tag=3Dhost0,security_model=3Dpassthrough,id=3Dhost0 \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -kernel /home/work=
/linux_output/arch/x86/boot/bzImage \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --append "console=
=3DttyS0 crashkernel=3D256M root=3D/dev/sda
> >>>> rootfstype=3Dext4 rw loglevel=3D8" \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -object memory-bac=
kend-ram,id=3Dvmem0,share=3Don,size=3D4096M \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device pxb-cxl,bu=
s_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device cxl-
> >>>> rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device cxl-type3,=
bus=3Droot_port13,volatile-
> >>>> memdev=3Dvmem0,id=3Dcxl-vmem0,sn=3D0x123456789 \
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -M cxl-fmw.0.targe=
ts.0=3Dcxl.1,cxl-fmw.0.size=3D4G
> >>>>
> >>>> Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup=
 a
> >>>> machine parameter")
> >>>> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> >>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> Message-ID: <20250805142300.15226-1-engguopeng@buaa.edu.cn>
> >>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> ---
> >>>>  =C2=A0 hw/i386/pc.c | 20 +++++++++++---------
> >>>>  =C2=A0 1 file changed, 11 insertions(+), 9 deletions(-) =20
> >>>
> >>> Hi!
> >>>
> >>> Is it qemu-stable material (10.0.x & 10.1.x)? =20
> >=20
> > I think it does make sense for stable. =20
>=20
> Aha.  I remember now why I had this question to begin with.
>=20
> If it should be applied to 10.0.x series too (which is an LTS series),
> I need help back-porting it before commit 8b1c560937467d0d9
> "hw/i386/pc: Remove PCMachineClass::broken_reserved_end field"
> which touches the same code.

I don't have strong opinions either way. peng guo, if you happen
to be in a position to backport and test with QEMU LTS that would be
great.

Jonathan

>=20
> If it's worth the effort to begin with.
>=20
> Meanwhile I picked it up for 10.1.x.
>=20
> Thank you!
>=20
> /mjt



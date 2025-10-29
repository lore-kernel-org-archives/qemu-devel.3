Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C13CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 11:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3w2-0007eU-Gx; Wed, 29 Oct 2025 07:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vE3vs-0007dh-FW
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:01:36 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vE3vj-0003YA-8h
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:01:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxPMn0p8Sz6M4Yx;
 Wed, 29 Oct 2025 18:57:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id B3587140278;
 Wed, 29 Oct 2025 19:01:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 11:01:14 +0000
Date: Wed, 29 Oct 2025 11:01:13 +0000
To: Michael Tokarev <mjt@tls.msk.ru>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, "Peter
 Maydell" <peter.maydell@linaro.org>, peng guo <engguopeng@buaa.edu.cn>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 33/75] hw/i386/pc: Avoid overlap between CXL window and
 PCI 64bit BARs in QEMU
Message-ID: <20251029110113.000028ca@huawei.com>
In-Reply-To: <949000e9-ac59-4bc9-ad00-861c3a9a08c9@tls.msk.ru>
References: <cover.1759691708.git.mst@redhat.com>
 <d1193481dee63442fc41e47ca6ebc4cd34f1f69c.1759691708.git.mst@redhat.com>
 <26067051-421d-44ed-9c7e-13ed0bdac18b@tls.msk.ru>
 <949000e9-ac59-4bc9-ad00-861c3a9a08c9@tls.msk.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 28 Oct 2025 22:26:12 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> On 10/6/25 20:08, Michael Tokarev wrote:
> > On 10/5/25 22:17, Michael S. Tsirkin wrote: =20
> >> From: peng guo <engguopeng@buaa.edu.cn>
> >>
> >> When using a CXL Type 3 device together with a virtio 9p device in=20
> >> QEMU on a
> >> physical server, the 9p device fails to initialize properly. The=20
> >> kernel reports
> >> the following error:
> >>
> >> =A0=A0=A0=A0 virtio: device uses modern interface but does not have=20
> >> VIRTIO_F_VERSION_1
> >> =A0=A0=A0=A0 9pnet_virtio virtio0: probe with driver 9pnet_virtio fail=
ed with=20
> >> error -22
> >>
> >> Further investigation revealed that the 64-bit BAR space assigned to=20
> >> the 9pnet
> >> device was overlapped by the memory window allocated for the CXL=20
> >> devices. As a
> >> result, the kernel could not correctly access the BAR region, causing =
the
> >> virtio device to malfunction.
> >>
> >> An excerpt from /proc/iomem shows:
> >>
> >> =A0=A0=A0=A0 480010000-cffffffff : CXL Window 0
> >> =A0=A0=A0=A0=A0=A0 480010000-4bfffffff : PCI Bus 0000:00
> >> =A0=A0=A0=A0=A0=A0 4c0000000-4c01fffff : PCI Bus 0000:0c
> >> =A0=A0=A0=A0=A0=A0=A0=A0 4c0000000-4c01fffff : PCI Bus 0000:0d
> >> =A0=A0=A0=A0=A0=A0 4c0200000-cffffffff : PCI Bus 0000:00
> >> =A0=A0=A0=A0=A0=A0=A0=A0 4c0200000-4c0203fff : 0000:00:03.0
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4c0200000-4c0203fff : virtio-pci-modern
> >>
> >> To address this issue, this patch adds the reserved memory end=20
> >> calculation
> >> for cxl devices to reserve sufficient address space and ensure that=20
> >> CXL memory
> >> windows are allocated beyond all PCI 64-bit BARs. This prevents=20
> >> overlap with
> >> 64-bit BARs regions such as those used by virtio or other pcie devices,
> >> resolving the conflict.
> >>
> >> QEMU Build Configuration:
> >>
> >> =A0=A0=A0=A0 ./configure --prefix=3D/home/work/qemu_master/build/ \
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 --target-list=3Dx86_6=
4-softmmu \
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 --enable-kvm \
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 --enable-virtfs
> >>
> >> QEMU Boot Command:
> >>
> >> =A0=A0=A0=A0 sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64=
 \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -nographic -machine q35,cxl=3Don -enable-kvm =
-m 16G -smp 8 \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -hda /home/work/gp_qemu/rootfs.img \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -virtfs local,path=3D/home/work/gp_qemu/=20
> >> share,mount_tag=3Dhost0,security_model=3Dpassthrough,id=3Dhost0 \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -kernel /home/work/linux_output/arch/x86/boot=
/bzImage \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 --append "console=3DttyS0 crashkernel=3D256M =
root=3D/dev/sda=20
> >> rootfstype=3Dext4 rw loglevel=3D8" \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -object memory-backend-ram,id=3Dvmem0,share=
=3Don,size=3D4096M \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=
=3Dcxl.1 \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -device cxl-=20
> >> rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=3D2 \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -device cxl-type3,bus=3Droot_port13,volatile-=
=20
> >> memdev=3Dvmem0,id=3Dcxl-vmem0,sn=3D0x123456789 \
> >> =A0=A0=A0=A0=A0=A0=A0=A0 -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=
=3D4G
> >>
> >> Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a=
=20
> >> machine parameter")
> >> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> Message-ID: <20250805142300.15226-1-engguopeng@buaa.edu.cn>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >> =A0 hw/i386/pc.c | 20 +++++++++++---------
> >> =A0 1 file changed, 11 insertions(+), 9 deletions(-) =20
> >=20
> > Hi!
> >=20
> > Is it qemu-stable material (10.0.x & 10.1.x)? =20
>=20
> A friendly ping for the stable series?

I think it does make sense for stable.

Thanks,

Jonathan

>=20
> Thanks,
>=20
> /mjt
>=20



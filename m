Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26091CED25D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 03:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy10L-00084R-VG; Mon, 07 Oct 2024 23:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1sy10H-00084B-Fr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:35:18 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zuoboqun@baidu.com>)
 id 1sy10E-0004Qk-Hk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:35:17 -0400
To: Junjie Mao <junjie.mao@hotmail.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Gao,Shiyuan" <gaoshiyuan@baidu.com>,
 "david@redhat.com" <david@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>, 
 "alxndr@bu.edu" <alxndr@bu.edu>, "peterx@redhat.com" <peterx@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Thread-Topic: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Thread-Index: AdsZL+fnbeIMvx7hS4K1J5o2R2S6yQ==
Date: Tue, 8 Oct 2024 03:19:11 +0000
Message-ID: <62225479bf3f476496df7c5fbb0b9aa9@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.84.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.54
X-FE-Last-Public-Client-IP: 100.100.100.49
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185; envelope-from=zuoboqun@baidu.com;
 helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zuo,Boqun" <zuoboqun@baidu.com>
From:  "Zuo,Boqun" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On Wed, Sep 25, 2024 8:58 PM Junjie Mao wrote:
> > As shown below, if a virtio PCI device is attached under a pci-bridge,
> > the MR of VirtIOPCIRegion does not belong to any address space. So
> > memory_region_find cannot be used to search for this MR.
> >
> > Introduce the virtio-pci and pci_bridge_pci address spaces to solve thi=
s
> problem.
> >
> > Before:
> > memory-region: pci_bridge_pci
> >   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
> >     00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msi=
x
> >       00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
> >       00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
> >     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-commo=
n-
> virtio-blk
> >       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-v=
irtio-
> blk
> >       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-devic=
e-
> virtio-blk
> >       000000a000403000-000000a000403fff (prio 0, i/o):
> > virtio-pci-notify-virtio-blk
> >
> > After:
> > address-space: pci_bridge_pci
> >   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
> >     00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msi=
x
> >       00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
> >       00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
> >     000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >       000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-commo=
n-
> virtio-blk
> >       000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-v=
irtio-
> blk
> >       000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-devic=
e-
> virtio-blk
> >       000000a000403000-000000a000403fff (prio 0, i/o):
> > virtio-pci-notify-virtio-blk
> >
> > address-space: virtio-pci
> >   000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >     000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-
> virtio-blk
> >     000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-vir=
tio-blk
> >     000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-
> virtio-blk
> >     000000a000403000-000000a000403fff (prio 0, i/o):
> > virtio-pci-notify-virtio-blk
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> > Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion
> > MR")
> >
> > Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> > Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> > ---
> >  hw/pci/pci_bridge.c            | 2 ++
> >  hw/virtio/virtio-pci.c         | 3 +++
> >  include/hw/pci/pci_bridge.h    | 1 +
> >  include/hw/virtio/virtio-pci.h | 1 +
> >  4 files changed, 7 insertions(+)
> >
> > diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c index
> > 6a4e38856d..74683e7445 100644
> > --- a/hw/pci/pci_bridge.c
> > +++ b/hw/pci/pci_bridge.c
> > @@ -380,6 +380,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char
> *typename)
> >      sec_bus->map_irq =3D br->map_irq ? br->map_irq :
> pci_swizzle_map_irq_fn;
> >      sec_bus->address_space_mem =3D &br->address_space_mem;
> >      memory_region_init(&br->address_space_mem, OBJECT(br),
> > "pci_bridge_pci", UINT64_MAX);
> > +    address_space_init(&br->as_mem, &br->address_space_mem,
> > + "pci_bridge_pci");
>=20
> I don't think this "pci_bridge_pci" address space is necessary. The
> VirtIOPCIProxy.modern_as AddressSpace is sufficient for
> memory_region_add() to work.

This is because memory_region_find_rcu () and memory_region_to_address_spac=
e() will find the memory container
on the top level and then get the corresponding address space of it.
If we only add "VirtIOPCIProxy.modern_as AddressSpace", memory_region_find(=
) still cannot find a address space.
Because "pci_bridge_pci" is the memory container on top level and it doesn'=
t have a corresponding address space.


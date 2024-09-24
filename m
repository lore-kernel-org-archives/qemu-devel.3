Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4BFCF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5KP-0007CW-0s; Tue, 24 Sep 2024 09:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1st5KK-0006bk-5l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:11:36 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1st5KG-0001Nn-NC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:11:35 -0400
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: "Zuo,Boqun" <zuoboqun@baidu.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "alxndr@bu.edu" <alxndr@bu.edu>, "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Thread-Topic: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Thread-Index: AQHbDoMZs/5ZAuajc0SkLcgCqoFn/Q==
Date: Tue, 24 Sep 2024 13:10:16 +0000
Message-ID: <8878123399e34a90bbac9a618be5c674@baidu.com>
References: <20240924011156.48252-1-gaoshiyuan@baidu.com>,
 <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
In-Reply-To: <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.160]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.57
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> Make sure to version your patch series. For example, via
> =A0=A0=A0=A0=A0=A0=A0 $ git format-patch -v1 ...

Thanks, the first version forgot to CC qemu-devel, I resent it. I'll add ve=
rsion to
next version.

>
> > As shown below, if a virtio PCI device is attached under a pci-bridge, =
the MR
> > of VirtIOPCIRegion does not belong to any address space. So memory_regi=
on_find
> > cannot be used to search for this MR.
>
> I'm starting to wonder if memory_region_find() is really the right fun
>
> >
> > Introduce the virtio-pci and pci_bridge_pci address spaces to solve thi=
s problem.
> >
> > Before:
> > memory-region: pci_bridge_pci
> >=A0=A0=A0 0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pc=
i
> >=A0=A0=A0=A0=A0 00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-=
blk-pci-msix
> >=A0=A0=A0=A0=A0=A0=A0 00000000fe200000-00000000fe20016f (prio 0, i/o): m=
six-table
> >=A0=A0=A0=A0=A0=A0=A0 00000000fe200800-00000000fe200807 (prio 0, i/o): m=
six-pba
> >=A0=A0=A0=A0=A0 000000a000400000-000000a000403fff (prio 1, i/o): virtio-=
pci
> >=A0=A0=A0=A0=A0=A0=A0 000000a000400000-000000a000400fff (prio 0, i/o): v=
irtio-pci-common-virtio-blk
> >=A0=A0=A0=A0=A0=A0=A0 000000a000401000-000000a000401fff (prio 0, i/o): v=
irtio-pci-isr-virtio-blk
> >=A0=A0=A0=A0=A0=A0=A0 000000a000402000-000000a000402fff (prio 0, i/o): v=
irtio-pci-device-virtio-blk
> >=A0=A0=A0=A0=A0=A0=A0 000000a000403000-000000a000403fff (prio 0, i/o): v=
irtio-pci-notify-virtio-blk
> >
> > After:
> > address-space: pci_bridge_pci
> >=A0=A0=A0 0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pc=
i
> >=A0=A0=A0=A0=A0 00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-=
blk-pci-msix
> >=A0=A0=A0=A0=A0=A0=A0 00000000fe200000-00000000fe20016f (prio 0, i/o): m=
six-table
> >=A0=A0=A0=A0=A0=A0=A0 00000000fe200800-00000000fe200807 (prio 0, i/o): m=
six-pba
> >=A0=A0=A0=A0=A0 000000a000400000-000000a000403fff (prio 1, i/o): virtio-=
pci
> >=A0=A0=A0=A0=A0=A0=A0 000000a000400000-000000a000400fff (prio 0, i/o): v=
irtio-pci-common-virtio-blk
> >=A0=A0=A0=A0=A0=A0=A0 000000a000401000-000000a000401fff (prio 0, i/o): v=
irtio-pci-isr-virtio-blk
> >=A0=A0=A0=A0=A0=A0=A0 000000a000402000-000000a000402fff (prio 0, i/o): v=
irtio-pci-device-virtio-blk
> >=A0=A0=A0=A0=A0=A0=A0 000000a000403000-000000a000403fff (prio 0, i/o): v=
irtio-pci-notify-virtio-blk
> >
> > address-space: virtio-pci
> >=A0=A0=A0 000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >=A0=A0=A0=A0=A0 000000a000400000-000000a000400fff (prio 0, i/o): virtio-=
pci-common-virtio-blk
> >=A0=A0=A0=A0=A0 000000a000401000-000000a000401fff (prio 0, i/o): virtio-=
pci-isr-virtio-blk
> >=A0=A0=A0=A0=A0 000000a000402000-000000a000402fff (prio 0, i/o): virtio-=
pci-device-virtio-blk
> >=A0=A0=A0=A0=A0 000000a000403000-000000a000403fff (prio 0, i/o): virtio-=
pci-notify-virtio-blk
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> > Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR=
")
>
> Commit id is not unique. Use 12 digits please.

Thanks, I will make changes in the next version.

>
> I'm still not quite sure if memory_region_find() is really the right
> thing to use here, but I'm no expert on that so I'm hoping virtio/PCI
> people can review.
>

Directly traversing the subregions of VirtIOPCIRegion's MR is a relatively
simple method(Now only notify region MR has subregion and only has one laye=
r).

But if want to be more general, we need to consider multiple layers and
the priority of subregions, which adds complexity.

I think it would be better to use memory_region_find.

Does anyone have any opinions?=


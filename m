Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6541FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewAG-0000aP-68; Fri, 16 Aug 2024 08:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sewAE-0000Zp-8u
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:34:42 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sewAB-0008Nq-77
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:34:41 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Tiwei Bie <tiwei.bie@intel.com>, "Zuo,Boqun" <zuoboqun@baidu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jason Wang
 <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] virtio-pci: return RAM device MR when set host
 notifier success
Thread-Topic: [PATCH 1/1] virtio-pci: return RAM device MR when set host
 notifier success
Thread-Index: AQHa79h8kMwNuA90aUCU0hYz26+iiw==
Date: Fri, 16 Aug 2024 12:33:24 +0000
Message-ID: <da2b25fa238945dcbdc53b91e0519330@baidu.com>
References: <20240812122027.65600-1-gaoshiyuan@baidu.com>,
 <20240816061647-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240816061647-mutt-send-email-mst@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.129]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.47
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> > When vhost-user backend register memory region based host notifiers,
> > we should return RAM device MR of notify region MR's subregion in
> > virtio_address_space_lookup.
> >
> > In seabios, it will use virtio PCI Configration Access Capability
> > access notify region when assign notify region above 4GB. This will
> > exit to QEMU and invoke virtio_address_space_write. When vhost-user
> > backend register memory region based host notifiers, return RAM device
> > MR instead of notify region MR is suitable.
>
>
> I can't really parse this.
>

When booting from disk, SeaBIOS will invoke the INT 0x13 interrupt handler
to load the MBR. The interrupt handler will eventually utilize the virtio
block driver in SeaBIOS when the disk is a virtio block device,
and after notifying the backend via `vp_notify`, the MBR will be loaded.

When assign the address of notify region in the modern bar above 4G, the
`vp_notify` in SeaBIOS will use PCI Configuration Access Capability to
write notify region. This will trap into QEMU and be handled by the
host bridge when we don't enable mmconfig. QEMU will call
`virtio_write_config`, and since it writes to the BAR region through
the PCI Configuration Access capability, it will call
`virtio_address_space_write`.

When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER protocol feature has been
successfully negotiated and vhost-user backend registers memory region base=
d
host notifiers, QEMU need write the mmap address instead of eventfd notify
the hardware accelerator at the vhost-user backend.

So virtio_address_space_lookup in virtio_address_space_write need return a
host-notifier subregion of notify MR.


> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -610,13 +610,22 @@ static MemoryRegion *virtio_address_space_lookup(=
VirtIOPCIProxy *proxy,
> >=A0 {
> >=A0=A0=A0=A0=A0 int i;
> >=A0=A0=A0=A0=A0 VirtIOPCIRegion *reg;
> > +=A0=A0=A0 MemoryRegion *mr, *submr;
> >
> >=A0=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(proxy->regs); ++i) {
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &proxy->regs[i];
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (*off >=3D reg->offset &&
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off + len <=3D reg->offset + re=
g->size) {
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off -=3D reg->offset;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return &reg->mr;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mr =3D &reg->mr;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QTAILQ_FOREACH(submr, &mr->subregion=
s, subregions_link) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (*off >=3D submr->add=
r &&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off + len <=
 submr->addr + submr->size) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off -=3D su=
bmr->addr;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return submr=
;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return mr;
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >=A0=A0=A0=A0=A0 }
>
> Poking at internals of MR like this is not nice.
> Doesn't memory_region_find work for this?

It seems fine, I=92ll try it out.=


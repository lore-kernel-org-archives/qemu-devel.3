Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082C7C83F15
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeyJ-0006V5-36; Thu, 29 Aug 2024 09:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sjeyD-0006A2-AR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:13:49 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sjeyB-0005ok-AE
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:13:49 -0400
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zuo,Boqun" <zuoboqun@baidu.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Subject: Re: [PATCH V2 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Thread-Topic: [PATCH V2 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Thread-Index: AQHa+hVGeA080NFOGUeMhnIJ/Cpn+g==
Date: Thu, 29 Aug 2024 13:13:43 +0000
Message-ID: <9766b5a2ca8c43f3be60b2bfd0fc5226@baidu.com>
References: <20240820115631.52522-1-gaoshiyuan@baidu.com>,
 <qrb7lbdypu2ctim57dxn7copcbmclpxnb4k2uadnm5v6ehawwc@xzhkhvs46xhw>
In-Reply-To: <qrb7lbdypu2ctim57dxn7copcbmclpxnb4k2uadnm5v6ehawwc@xzhkhvs46xhw>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.151]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.12
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> >--- a/hw/virtio/virtio-pci.c
> >+++ b/hw/virtio/virtio-pci.c
> >@@ -610,19 +610,29 @@ static MemoryRegion *virtio_address_space_lookup(V=
irtIOPCIProxy *proxy,
> > {
> >=A0=A0=A0=A0 int i;
> >=A0=A0=A0=A0 VirtIOPCIRegion *reg;
> >+=A0=A0=A0 MemoryRegion *mr =3D NULL;
>
> `mr` looks unused.
>
> >+=A0=A0=A0 MemoryRegionSection mrs;
>
> Please, can you move this declaration in the inner block where it's
> used?

ok, I will move to inner block and remove unused `mr`.

>
> >
> >=A0=A0=A0=A0 for (i =3D 0; i < ARRAY_SIZE(proxy->regs); ++i) {
> >=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &proxy->regs[i];
> >=A0=A0=A0=A0=A0=A0=A0=A0 if (*off >=3D reg->offset &&
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off + len <=3D reg->offset + reg->=
size) {
> >-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off -=3D reg->offset;
> >-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return &reg->mr;
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mrs =3D memory_region_find(&reg->mr, =
*off - reg->offset,
> >len);
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!mrs.mr) {
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("Failed to f=
ind memory region for address"
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "0x%" PRIx64 "", *off);
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL;
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *off =3D mrs.offset_within_region;
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memory_region_unref(mrs.mr);
> >+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return mrs.mr;
> >=A0=A0=A0=A0=A0=A0=A0=A0 }
> >=A0=A0=A0=A0 }
> >
> >=A0=A0=A0=A0 return NULL;
> > }
> >
> >+
>
> Unrelated change.

Perhaps this would be clearer but not universal in Version 1.

Without this patch, Only lookup common/isr/device/notify MR and
exclude their subregions.

When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
host-notifier subregions and we need use host-notifier MR to
notify the hardware accelerator directly.

Further more, maybe common/isr/device MR also has subregions in
the future, so need memory_region_find for each MR incluing
their subregions and this will be more universal.

@@ -610,13 +610,22 @@ static MemoryRegion *virtio_address_space_lookup(Virt=
IOPCIProxy *proxy,
 {
     int i;
     VirtIOPCIRegion *reg;
+    MemoryRegion *mr, *submr;

     for (i =3D 0; i < ARRAY_SIZE(proxy->regs); ++i) {
         reg =3D &proxy->regs[i];
         if (*off >=3D reg->offset &&
             *off + len <=3D reg->offset + reg->size) {
             *off -=3D reg->offset;
-            return &reg->mr;
+            mr =3D &reg->mr;
+            QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
+                if (*off >=3D submr->addr &&
+                    *off + len < submr->addr + submr->size) {
+                    *off -=3D submr->addr;
+                    return submr;
+                }
+            }
+            return mr;
         }
     }=


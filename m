Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E0CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXd5W-0000Yn-9b; Thu, 11 Jun 2026 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXd5U-0000YW-Ho
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:56:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXd5R-00050f-RI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 06:56:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so68076435e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781175395; x=1781780195; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VtwHaLfCnHyHiJG+UD9PmpqS9ZcpqJ06sNwHvYyeQW0=;
 b=Ph4fMU4PGHA/3r/15fPgQFrqBbXYngmW+LzzIFwwF9h0QCPbAztM0n7qu4O1WQEd2N
 txcpQ963gcLMi3KgYgvRQz0vNaAnXrJqIZq+qtGfusXOe9wqIA0l0rDvE8oDXmuX7hLT
 0mWIO1qGSB4JI+OsGvW5I5uE5wU1M6UbprEM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781175395; x=1781780195;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VtwHaLfCnHyHiJG+UD9PmpqS9ZcpqJ06sNwHvYyeQW0=;
 b=eNww2WkpNaNMT8Yw6QfWgUdW/VGrvuQpKbM/5Z0dRiAsTsDIVCpmztLUNLPXlDRH30
 oxAd/oYWrsbBOcMK3DJ8bS4i1s4XBa2kx3XX7QRKX/EG4Y38f2Y+ZBwSMcIVinDNgRvZ
 SRE+X4KBeE01tzE9zmliaB3mT0FAusZ+IuKl31Io0xXNw5S2c8IDU+2AsF/zLD14aMw6
 xdGeAt+F71eZsmiWORuhIrOv9CcK00+QTuzQ/NdPBaP2HVyW+dnXC1hzbiXqsH/we6Fe
 WMx9flI06ewWoHS1plAoQ7EXlajLyFFUjPARPrUIjh4eF2mJyXSYIkBCJsFGxULz8dnn
 MDJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/smb38Hi0R/hJPXr6f7aew4+VcVvAiYz7hKS7DDS85CRz5y3x1JswUVeoYxZI/MyguK8FQG4EH757e@nongnu.org
X-Gm-Message-State: AOJu0YwabUaRa1Upk80ocXjjN8fDNDddJj+Kh5aj30Cpc2Y4vX/fLuLP
 sjgpo0v4lvT7zRarjwBDYrqaHDveYYYf57cviS9l/01mDcP5MFf6/8tX4ooH1/krobw=
X-Gm-Gg: Acq92OEhXKDu8tcl28ItySrspmPQoheuntHDQVIX/lYfb1gwaSYuS2aZUrcMs49fJt4
 HSlumsfCQLnfsCXuaRhO1y0zLwPXXGxqmfTdfU1FbaZ1GnCX5WFU3YT8MfsYJ95YGJaou98ahjw
 zHN916m2zYp2XXEEw57dtsFWQvVl2AtN/9f+4oVqZMThuYBuzGz5UpEyXrQwDff2H+4dRJJDDYF
 jzBeGNj0eHoeVkEv/B06iggIaKEbOABpy08SqHrUk5RTViAhRpIsRzSPpupCKeaQfErqkzi/KrE
 db7+m0ZkF+748oH0bFSoYaQTTWw/buf78pBrY+d7pjVc6RW8mhDmHWzJpUk7zbrIG/S2rCucIb3
 m3EvDNQHcJOSy+PjXBQKssXevCeCboSHZ2mhZcHf4cSMiA4xRtCkgjHqgIJ55ky8FnfvfHZuaN5
 K3iNl7ysQEhwCSjx4spmTfGUeeF+Cuad3EpWPxogZf5uNKKTEnOK8/ykVGDd7qOrfwIstWeTaAc
 XV831g7/iGAEyrCy02ChjmD/mZ5Mt/SNqN0V8bMigu4eztFcZEaRLpLy6eBlcjiNlkksET2FTzJ
 L/Xz
X-Received: by 2002:a05:600c:3550:b0:490:e5c1:b897 with SMTP id
 5b1f17b1804b1-490e5d0fe68mr25476445e9.20.1781175395132; 
 Thu, 11 Jun 2026 03:56:35 -0700 (PDT)
Received: from ?IPv6:2003:cf:570f:fe00:65c9:7c06:8cb4:c6f?
 (p200300cf570ffe0065c97c068cb40c6f.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:65c9:7c06:8cb4:c6f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e52ac9aasm41531355e9.4.2026.06.11.03.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:56:34 -0700 (PDT)
Message-ID: <25c00af8f9b54c9c39ff3bf806744d2c2ec745c5.camel@mihalicyn.com>
Subject: Re: [PATCH v5 04/11] tests/qtest: Enable spapr dma with linear
 iommu map
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: stgraber@stgraber.org, aleksandr.mikhalitsyn@futurfusion.io, Akihiko
 Odaki	 <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>, Harsh
 Prateek Bora	 <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier	 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Date: Thu, 11 Jun 2026 12:56:33 +0200
In-Reply-To: <20250502030446.88310-5-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
 <20250502030446.88310-5-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicholas,

I was working on a qtest for a NVMe emulated device [1] and noticed
that test fails on ppc64 with spapr bus. After small research I found out t=
hat
the issue is that pci_dma_read() fails on a perfectly valid physical addres=
s...

I wonder if you are going to continue working on this patchset?

It looks like this change is what I need to fix it (haven't yet tried, but =
happy to do so).

[1] https://lore.kernel.org/qemu-devel/20260526113301.91492-9-alexander@mih=
alicyn.com/

Kind regards,
Alex

On Fri, 2025-05-02 at 13:04 +1000, Nicholas Piggin wrote:
> qtests spapr dma was broken because the iommu was not set up.
>=20
> spapr requires hypercalls to set up the iommu (TCE tables), but
> there is no support for that or a side-channel to the iommu in
> qtests at the moment, so add a quick workaround in QEMU to have
> the spapr iommu provide a linear map to memory when running
> qtests.
>=20
> The buggy msix checks can all be removed since the tests all work
> now.
>=20
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> =C2=A0tests/qtest/libqos/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ----
> =C2=A0hw/ppc/spapr_iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++++-
> =C2=A0tests/qtest/e1000e-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ---------------------
> =C2=A0tests/qtest/igb-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ---------------------
> =C2=A0tests/qtest/libqos/generic-pcihost.c |=C2=A0 1 -
> =C2=A0tests/qtest/libqos/pci-pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 ---
> =C2=A0tests/qtest/libqos/pci-spapr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 7 ++++---
> =C2=A0tests/qtest/libqos/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 --------------
> =C2=A0tests/qtest/vhost-user-blk-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0 6 -----=
-
> =C2=A0tests/qtest/virtio-blk-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 ------------
> =C2=A010 files changed, 13 insertions(+), 86 deletions(-)
>=20
> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
> index 9f8f154c301..ef40a6917d3 100644
> --- a/tests/qtest/libqos/pci.h
> +++ b/tests/qtest/libqos/pci.h
> @@ -51,7 +51,6 @@ struct QPCIBus {
> =C2=A0=C2=A0=C2=A0=C2=A0 QTestState *qts;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t pio_alloc_ptr, pio_limit;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t mmio_alloc_ptr, mmio_limit;
> -=C2=A0=C2=A0=C2=A0 bool has_buggy_msi; /* TRUE for spapr, FALSE for pci =
*/
> =C2=A0=C2=A0=C2=A0=C2=A0 bool not_hotpluggable; /* TRUE if devices cannot=
 be hotplugged */
> =C2=A0
> =C2=A0};
> @@ -83,9 +82,6 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
> =C2=A0void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *a=
ddr);
> =C2=A0int qpci_secondary_buses_init(QPCIBus *bus);
> =C2=A0
> -bool qpci_has_buggy_msi(QPCIDevice *dev);
> -bool qpci_check_buggy_msi(QPCIDevice *dev);
> -
> =C2=A0void qpci_device_enable(QPCIDevice *dev);
> =C2=A0uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t s=
tart_addr);
> =C2=A0void qpci_msix_enable(QPCIDevice *dev);
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index c2432a0c00c..c89ccc87d71 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -22,6 +22,8 @@
> =C2=A0#include "qemu/log.h"
> =C2=A0#include "qemu/module.h"
> =C2=A0#include "system/kvm.h"
> +#include "system/qtest.h"
> +#include "exec/target_page.h"
> =C2=A0#include "kvm_ppc.h"
> =C2=A0#include "migration/vmstate.h"
> =C2=A0#include "system/dma.h"
> @@ -125,7 +127,13 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMU=
MemoryRegion *iommu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .perm =3D IOMMU_NONE,
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if ((addr >> tcet->page_shift) < tcet->nb_table) {
> +=C2=A0=C2=A0=C2=A0 if (qtest_enabled()) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* spapr qtests does not set =
up the IOMMU, shortcut a linear map */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret.iova =3D addr & TARGET_PA=
GE_MASK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret.translated_addr =3D addr =
& TARGET_PAGE_MASK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret.addr_mask =3D ~TARGET_PAG=
E_MASK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret.perm =3D IOMMU_RW;
> +=C2=A0=C2=A0=C2=A0 } else if ((addr >> tcet->page_shift) < tcet->nb_tabl=
e) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Check if we are in bo=
und */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr page_mask =3D IOM=
MU_PAGE_MASK(tcet->page_shift);
> =C2=A0
> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
> index de9738fdb74..8300bf5a5b3 100644
> --- a/tests/qtest/e1000e-test.c
> +++ b/tests/qtest/e1000e-test.c
> @@ -139,13 +139,6 @@ static void test_e1000e_tx(void *obj, void *data, QG=
uestAllocator * alloc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E_PCI *e1000e =3D obj;
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E *d =3D &e1000e->e1000e;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *e_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *dev =3D e_object->get_driver(e_object, "p=
ci-device");
> -
> -=C2=A0=C2=A0=C2=A0 /* FIXME: add spapr support */
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 e1000e_send_verify(d, data, alloc);
> =C2=A0}
> @@ -154,13 +147,6 @@ static void test_e1000e_rx(void *obj, void *data, QG=
uestAllocator * alloc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E_PCI *e1000e =3D obj;
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E *d =3D &e1000e->e1000e;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *e_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *dev =3D e_object->get_driver(e_object, "p=
ci-device");
> -
> -=C2=A0=C2=A0=C2=A0 /* FIXME: add spapr support */
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 e1000e_receive_verify(d, data, alloc);
> =C2=A0}
> @@ -173,13 +159,6 @@ static void test_e1000e_multiple_transfers(void *obj=
, void *data,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E_PCI *e1000e =3D obj;
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E *d =3D &e1000e->e1000e;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *e_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *dev =3D e_object->get_driver(e_object, "p=
ci-device");
> -
> -=C2=A0=C2=A0=C2=A0 /* FIXME: add spapr support */
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < iterations; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e1000e_send_verify(d, da=
ta, alloc);
> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
> index 3d397ea6973..1b3b5aa6c76 100644
> --- a/tests/qtest/igb-test.c
> +++ b/tests/qtest/igb-test.c
> @@ -142,13 +142,6 @@ static void test_igb_tx(void *obj, void *data, QGues=
tAllocator * alloc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E_PCI *e1000e =3D obj;
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E *d =3D &e1000e->e1000e;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *e_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *dev =3D e_object->get_driver(e_object, "p=
ci-device");
> -
> -=C2=A0=C2=A0=C2=A0 /* FIXME: add spapr support */
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 igb_send_verify(d, data, alloc);
> =C2=A0}
> @@ -157,13 +150,6 @@ static void test_igb_rx(void *obj, void *data, QGues=
tAllocator * alloc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E_PCI *e1000e =3D obj;
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E *d =3D &e1000e->e1000e;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *e_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *dev =3D e_object->get_driver(e_object, "p=
ci-device");
> -
> -=C2=A0=C2=A0=C2=A0 /* FIXME: add spapr support */
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 igb_receive_verify(d, data, alloc);
> =C2=A0}
> @@ -176,13 +162,6 @@ static void test_igb_multiple_transfers(void *obj, v=
oid *data,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E_PCI *e1000e =3D obj;
> =C2=A0=C2=A0=C2=A0=C2=A0 QE1000E *d =3D &e1000e->e1000e;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *e_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *dev =3D e_object->get_driver(e_object, "p=
ci-device");
> -
> -=C2=A0=C2=A0=C2=A0 /* FIXME: add spapr support */
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < iterations; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 igb_send_verify(d, data,=
 alloc);
> diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/ge=
neric-pcihost.c
> index 4bbeb5ff508..568897e0ecc 100644
> --- a/tests/qtest/libqos/generic-pcihost.c
> +++ b/tests/qtest/libqos/generic-pcihost.c
> @@ -182,7 +182,6 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestSta=
te *qts,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->gpex_pio_base =3D 0x3eff0000;
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.not_hotpluggable =3D !hotpluggable;
> -=C2=A0=C2=A0=C2=A0 qpci->bus.has_buggy_msi =3D false;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.pio_readb =3D qpci_generic_pio_readb;
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.pio_readw =3D qpci_generic_pio_readw;
> diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
> index 147009f4f44..8b79d858bd5 100644
> --- a/tests/qtest/libqos/pci-pc.c
> +++ b/tests/qtest/libqos/pci-pc.c
> @@ -124,9 +124,6 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, Q=
GuestAllocator *alloc)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 assert(qts);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* tests can use pci-bus */
> -=C2=A0=C2=A0=C2=A0 qpci->bus.has_buggy_msi =3D false;
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.pio_readb =3D qpci_pc_pio_readb;
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.pio_readw =3D qpci_pc_pio_readw;
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.pio_readl =3D qpci_pc_pio_readl;
> diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spap=
r.c
> index 0f1023e4a73..dfa2087a599 100644
> --- a/tests/qtest/libqos/pci-spapr.c
> +++ b/tests/qtest/libqos/pci-spapr.c
> @@ -20,6 +20,10 @@
> =C2=A0 * PCI devices are always little-endian
> =C2=A0 * SPAPR by default is big-endian
> =C2=A0 * so PCI accessors need to swap data endianness
> + *
> + * The spapr iommu model has a qtest_enabled() check that short-cuts
> + * the TCE table and provides a linear map for DMA, since qtests does
> + * not have a way to make hcalls to set up the TCE table.
> =C2=A0 */
> =C2=A0
> =C2=A0static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
> @@ -155,9 +159,6 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *=
qts,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 assert(qts);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* tests cannot use spapr, needs to be fixed first */
> -=C2=A0=C2=A0=C2=A0 qpci->bus.has_buggy_msi =3D true;
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->alloc =3D alloc;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci->bus.pio_readb =3D qpci_spapr_pio_readb;
> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> index 773fd1fb6cf..2bae119bfca 100644
> --- a/tests/qtest/libqos/pci.c
> +++ b/tests/qtest/libqos/pci.c
> @@ -53,20 +53,6 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, =
int device_id,
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -bool qpci_has_buggy_msi(QPCIDevice *dev)
> -{
> -=C2=A0=C2=A0=C2=A0 return dev->bus->has_buggy_msi;
> -}
> -
> -bool qpci_check_buggy_msi(QPCIDevice *dev)
> -{
> -=C2=A0=C2=A0=C2=A0 if (qpci_has_buggy_msi(dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_test_skip("Skipping due to =
incomplete support for MSI");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> -=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0 return false;
> -}
> -
> =C2=A0static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devf=
n)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 g_assert(dev);
> diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-b=
lk-test.c
> index ea90d41232e..3e71fdb9d78 100644
> --- a/tests/qtest/vhost-user-blk-test.c
> +++ b/tests/qtest/vhost-user-blk-test.c
> @@ -554,14 +554,8 @@ static void idx(void *obj, void *u_data, QGuestAlloc=
ator *t_alloc)
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t desc_idx;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t status;
> =C2=A0=C2=A0=C2=A0=C2=A0 char *data;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *blk_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *pci_dev =3D blk_object->get_driver(blk_ob=
ject, "pci-device");
> =C2=A0=C2=A0=C2=A0=C2=A0 QTestState *qts =3D global_qtest;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(pci_dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci_msix_enable(pdev->pdev);
> =C2=A0=C2=A0=C2=A0=C2=A0 qvirtio_pci_set_msix_configuration_vector(pdev, =
t_alloc, 0);
> =C2=A0
> diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.=
c
> index 98c906ebb4a..3a005d600c1 100644
> --- a/tests/qtest/virtio-blk-test.c
> +++ b/tests/qtest/virtio-blk-test.c
> @@ -474,14 +474,8 @@ static void msix(void *obj, void *u_data, QGuestAllo=
cator *t_alloc)
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t free_head;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t status;
> =C2=A0=C2=A0=C2=A0=C2=A0 char *data;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *blk_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *pci_dev =3D blk_object->get_driver(blk_ob=
ject, "pci-device");
> =C2=A0=C2=A0=C2=A0=C2=A0 QTestState *qts =3D global_qtest;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(pci_dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci_msix_enable(pdev->pdev);
> =C2=A0=C2=A0=C2=A0=C2=A0 qvirtio_pci_set_msix_configuration_vector(pdev, =
t_alloc, 0);
> =C2=A0
> @@ -584,14 +578,8 @@ static void idx(void *obj, void *u_data, QGuestAlloc=
ator *t_alloc)
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t desc_idx;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t status;
> =C2=A0=C2=A0=C2=A0=C2=A0 char *data;
> -=C2=A0=C2=A0=C2=A0 QOSGraphObject *blk_object =3D obj;
> -=C2=A0=C2=A0=C2=A0 QPCIDevice *pci_dev =3D blk_object->get_driver(blk_ob=
ject, "pci-device");
> =C2=A0=C2=A0=C2=A0=C2=A0 QTestState *qts =3D global_qtest;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if (qpci_check_buggy_msi(pci_dev)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> -=C2=A0=C2=A0=C2=A0 }
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 qpci_msix_enable(pdev->pdev);
> =C2=A0=C2=A0=C2=A0=C2=A0 qvirtio_pci_set_msix_configuration_vector(pdev, =
t_alloc, 0);
> =C2=A0


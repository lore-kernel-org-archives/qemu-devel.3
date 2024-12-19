Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79810E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4i2-00065J-UZ; Wed, 18 Dec 2024 19:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tO4i1-000657-Kf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 19:48:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tO4hz-0002YX-2l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 19:48:09 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso181932f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734569284; x=1735174084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGTHJPYbDv9tltyldkH3p9eNfvUvCZBSeH10dpM1wIY=;
 b=f5qR/cGxBa2YZfGWJjaRLQ8WyGipJZ5OdGyv55cSrxW+9fKE4yoGLQArRyDV+gClSZ
 23g78s7LzIFuH42X9rTIUoLZo6V5+mG8rbXr3cnX7UZW9pC8PoL1z2MpNlYSbyjrZCSr
 fqv3lxfbRqE60X8q++YtxWlLfSmsyRoExBjgW1Sv/0F5chMysTx6ZNq5QsU7PBOW5WNS
 stmA67HHSavYYSHQ/1ORf2cJlksYooFySO9WX/HdirKZa0IOsGbvRMwc0VUCCTkYBes9
 dc3WQ/U8HwnR0qLx/pxF+0MD12pK+lmhkK7y+HmEos4sBTr1lbfo8NLHW7JxI0S6742R
 g8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734569284; x=1735174084;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGTHJPYbDv9tltyldkH3p9eNfvUvCZBSeH10dpM1wIY=;
 b=tTjMlD9gGuZzvS0yk+4huj8ybqL1j8jPkPLa+xX8URReIouaoGQLzwY6gxmfcldglv
 HQHExAvcyQXbWCD5M33c2jNTGTPcQjXwYAIRLkN5e6VhQ8v6aVte0/L5CECr+EeY6i2n
 J+HzlOv8TD3eEul2IteqEsujt9kXouZO1K+q6xLpgclMyoDR6ISAwDFffXG1970XmJqU
 ULNj47T2ZuiF0XvGPM+nJeGMSsKS6fRh5DSLyhgppds2eOjow8XTVdmlkSGmtu5kMCXL
 v3R6HJW6kwRGEyRNAnoLJYG/VCjNoOQPzGw+gF0VxwgrtfJD+IR3xU1k0PXt+zXkvZ1j
 wYwA==
X-Gm-Message-State: AOJu0YxrdEtUhnQ9AzB6fNzr/TxlXGjQa4VRtAvaBJSRwdkEFUFn63k4
 Fu010x4IgHwuXKVwfPigcZoemHGVGN+nkd02SKzx7Rp2a5yiVAqNvW5ePw==
X-Gm-Gg: ASbGncte6S06EmBA2TVQb89RgA9OljMPi/+nezD/Hdesw86pcaJENfykCn7k5OiYw/u
 XYpsX/Bm9gQYIJRaolg1ScE7+43w/mRDL6C7UIo3VimaccIxBo0Q2r+6cTwxh3S2K0mhrTvVYB3
 7RxDmZIEaVm2UmjlFTttJnEBdFJDaze30yq/VV3OA5+P2TaUEJbbSMVdU0grI8aCWmFeP/pg+l3
 cNTOPKXzoOWNKW/53CBRonHZWW7606KSYEBXTUx2GRFmzRJXcG6V/x3/TTv2w750Smr5DpCsRmm
 aIgPjDiLuQcFanOe9S+wFQflNbxT6a4I
X-Google-Smtp-Source: AGHT+IH/OJVr/cM08hbGMwV0G6+ETkg3OqGmBDHdD0VZiC9/rJcdw+gPBxd/7QCsbqZIaKHrzXLGjA==
X-Received: by 2002:a5d:64ee:0:b0:385:e2d5:cdf2 with SMTP id
 ffacd0b85a97d-38a19b05162mr1358846f8f.19.1734569284014; 
 Wed, 18 Dec 2024 16:48:04 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-019-174.93.128.pool.telefonica.de.
 [93.128.19.174]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm190354f8f.77.2024.12.18.16.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:48:03 -0800 (PST)
Date: Thu, 19 Dec 2024 00:48:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
CC: Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_hw/usb/hcd-xhci-pci?=
 =?US-ASCII?Q?=3A_Add_TI_TUSB73X0_XHCI_controller_model?=
In-Reply-To: <20241212085207.1439501-3-npiggin@gmail.com>
References: <20241212085207.1439501-1-npiggin@gmail.com>
 <20241212085207.1439501-3-npiggin@gmail.com>
Message-ID: <B6A151CF-47E4-4E6A-BAD6-7C5BE8C35F52@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 12=2E Dezember 2024 08:52:07 UTC schrieb Nicholas Piggin <npiggin@gmail=
=2Ecom>:
>The TI TUSB73X0 controller has some interesting differences from NEC,
>notably a separate BAR for MSIX, and PM capabilities=2E The spec is freel=
y
>available without sign-up=2E
>
>This controller is accepted by IBM Power proprietary firmware and
>software (when the subsystem IDs are set to Power servers, which is not
>done here)=2E IBM code is picky about device support, so the NEC device
>can not be used=2E
>
>Signed-off-by: Nicholas Piggin <npiggin@gmail=2Ecom>
>---
> include/hw/pci/pci_ids=2Eh        |  1 +
> include/hw/usb/xhci=2Eh           |  1 +
> hw/usb/hcd-xhci-ti=2Ec            | 92 +++++++++++++++++++++++++++++++++
> tests/qtest/usb-hcd-xhci-test=2Ec | 21 +++++---
> hw/usb/Kconfig                  |  5 ++
> hw/usb/meson=2Ebuild              |  1 +
> 6 files changed, 115 insertions(+), 6 deletions(-)
> create mode 100644 hw/usb/hcd-xhci-ti=2Ec
>
>diff --git a/include/hw/pci/pci_ids=2Eh b/include/hw/pci/pci_ids=2Eh
>index f1a53fea8d6=2E=2Efdb692db513 100644
>--- a/include/hw/pci/pci_ids=2Eh
>+++ b/include/hw/pci/pci_ids=2Eh
>@@ -182,6 +182,7 @@
> #define PCI_VENDOR_ID_HP                 0x103c
>=20
> #define PCI_VENDOR_ID_TI                 0x104c
>+#define PCI_DEVICE_ID_TI_TUSB73X0        0x8241
>=20
> #define PCI_VENDOR_ID_MOTOROLA           0x1057
> #define PCI_DEVICE_ID_MOTOROLA_MPC106    0x0002
>diff --git a/include/hw/usb/xhci=2Eh b/include/hw/usb/xhci=2Eh
>index 5c90e1373e5=2E=2E203ec1fca32 100644
>--- a/include/hw/usb/xhci=2Eh
>+++ b/include/hw/usb/xhci=2Eh
>@@ -3,6 +3,7 @@
>=20
> #define TYPE_XHCI "base-xhci"
> #define TYPE_NEC_XHCI "nec-usb-xhci"
>+#define TYPE_TI_XHCI "ti-usb-xhci"
> #define TYPE_QEMU_XHCI "qemu-xhci"
> #define TYPE_XHCI_SYSBUS "sysbus-xhci"
>=20
>diff --git a/hw/usb/hcd-xhci-ti=2Ec b/hw/usb/hcd-xhci-ti=2Ec
>new file mode 100644
>index 00000000000=2E=2E6d4b44f6aaf
>--- /dev/null
>+++ b/hw/usb/hcd-xhci-ti=2Ec
>@@ -0,0 +1,92 @@
>+/*
>+ * USB xHCI controller emulation
>+ * Datasheet https://www=2Eti=2Ecom/product/TUSB7340
>+ *
>+ * Copyright (c) 2011 Securiforest
>+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft=2Ecom>
>+ * Based on usb-xhci-nec=2Ec, emulates TI TUSB73X0
>+ *
>+ * This library is free software; you can redistribute it and/or
>+ * modify it under the terms of the GNU Lesser General Public
>+ * License as published by the Free Software Foundation; either
>+ * version 2=2E1 of the License, or (at your option) any later version=
=2E
>+ *
>+ * This library is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the GNU
>+ * Lesser General Public License for more details=2E
>+ *
>+ * You should have received a copy of the GNU Lesser General Public
>+ * License along with this library; if not, see <http://www=2Egnu=2Eorg/=
licenses/>=2E
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/usb=2Eh"
>+#include "qemu/module=2Eh"
>+#include "hw/pci/pci=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+
>+#include "hcd-xhci-pci=2Eh"
>+
>+OBJECT_DECLARE_SIMPLE_TYPE(XHCITiState, TI_XHCI)
>+
>+struct XHCITiState {
>+    /*< private >*/
>+    XHCIPciState parent_obj;
>+    /*< public >*/

These markers are obsolete=2E Instead, a blank line after parent_obj shoul=
d be inserted=2E

>+    uint32_t intrs;
>+    uint32_t slots;
>+};
>+
>+static Property ti_xhci_properties[] =3D {

s/static Property/static const Property/ as of recent tree-wide changes=2E

Best regards,
Bernhard

>+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
>+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO=
),
>+    DEFINE_PROP_UINT32("intrs", XHCITiState, intrs, 8),
>+    DEFINE_PROP_UINT32("slots", XHCITiState, slots, XHCI_MAXSLOTS),
>+    DEFINE_PROP_END_OF_LIST(),
>+};
>+
>+static void ti_xhci_instance_init(Object *obj)
>+{
>+    XHCIPciState *pci =3D XHCI_PCI(obj);
>+    XHCITiState *ti =3D TI_XHCI(obj);
>+
>+    pci->xhci=2Enumintrs =3D ti->intrs;
>+    pci->xhci=2Enumslots =3D ti->slots;
>+
>+    pci->cache_line_size =3D 0x0;
>+    pci->pm_cap_off =3D 0x40;
>+    pci->pcie_cap_off =3D 0x70;
>+    pci->msi_cap_off =3D 0x48;
>+    pci->msix_cap_off =3D 0xc0;
>+    pci->msix_bar_nr =3D 0x2;
>+    pci->msix_bar_size =3D 0x800000;
>+    pci->msix_table_off =3D 0x0;
>+    pci->msix_pba_off =3D 0x1000;
>+}
>+
>+static void ti_xhci_class_init(ObjectClass *klass, void *data)
>+{
>+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+
>+    device_class_set_props(dc, ti_xhci_properties);
>+    k->vendor_id    =3D PCI_VENDOR_ID_TI;
>+    k->device_id    =3D PCI_DEVICE_ID_TI_TUSB73X0;
>+    k->revision     =3D 0x02;
>+}
>+
>+static const TypeInfo ti_xhci_info =3D {
>+    =2Ename          =3D TYPE_TI_XHCI,
>+    =2Eparent        =3D TYPE_XHCI_PCI,
>+    =2Einstance_size =3D sizeof(XHCITiState),
>+    =2Einstance_init =3D ti_xhci_instance_init,
>+    =2Eclass_init    =3D ti_xhci_class_init,
>+};
>+
>+static void ti_xhci_register_types(void)
>+{
>+    type_register_static(&ti_xhci_info);
>+}
>+
>+type_init(ti_xhci_register_types)
>diff --git a/tests/qtest/usb-hcd-xhci-test=2Ec b/tests/qtest/usb-hcd-xhci=
-test=2Ec
>index 93614e55461=2E=2Ed4a0d8cc217 100644
>--- a/tests/qtest/usb-hcd-xhci-test=2Ec
>+++ b/tests/qtest/usb-hcd-xhci-test=2Ec
>@@ -59,6 +59,9 @@ typedef struct XHCIQState {
> #define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
>                      PCI_VENDOR_ID_NEC)
>=20
>+#define XHCI_TI_ID  (PCI_DEVICE_ID_TI_TUSB73X0 << 16 | \
>+                     PCI_VENDOR_ID_TI)
>+
> /**
>  * Locate, verify, and return a handle to the XHCI device=2E
>  */
>@@ -78,6 +81,8 @@ static QPCIDevice *get_xhci_device(QTestState *qts, uin=
t32_t *fingerprint)
>     switch (xhci_fingerprint) {
>     case XHCI_NEC_ID:
>         break;
>+    case XHCI_TI_ID:
>+        break;
>     default:
>         /* Unknown device=2E */
>         g_assert_not_reached();
>@@ -134,11 +139,12 @@ static XHCIQState *xhci_boot(const char *cli, =2E=
=2E=2E)
>         va_end(ap);
>     } else {
>         s =3D xhci_boot("-M q35 "
>-                      "-device nec-usb-xhci,id=3Dxhci,bus=3Dpcie=2E0,add=
r=3D1d=2E0 "
>+                      "-device %s,id=3Dxhci,bus=3Dpcie=2E0,addr=3D1d=2E0=
 "
>                       "-drive id=3Ddrive0,if=3Dnone,file=3Dnull-co://,"
>-                          "file=2Eread-zeroes=3Don,format=3Draw");
>+                          "file=2Eread-zeroes=3Don,format=3Draw",
>+                      qtest_has_device("ti-usb-xhci") ?
>+                          "ti-usb-xhci" : "nec-usb-xhci");
>     }
>-
>     return s;
> }
>=20
>@@ -392,10 +398,12 @@ static void pci_xhci_stress_rings(void)
>     int i;
>=20
>     s =3D xhci_boot("-M q35 "
>-            "-device nec-usb-xhci,id=3Dxhci,bus=3Dpcie=2E0,addr=3D1d=2E0=
 "
>+            "-device %s,id=3Dxhci,bus=3Dpcie=2E0,addr=3D1d=2E0 "
>             "-device usb-storage,bus=3Dxhci=2E0,drive=3Ddrive0 "
>             "-drive id=3Ddrive0,if=3Dnone,file=3Dnull-co://,"
>-                "file=2Eread-zeroes=3Don,format=3Draw "
>+                "file=2Eread-zeroes=3Don,format=3Draw ",
>+            qtest_has_device("ti-usb-xhci") ?
>+                "ti-usb-xhci" : "nec-usb-xhci"
>             );
>=20
>     hcsparams1 =3D xhci_cap_readl(s, 0x4); /* HCSPARAMS1 */
>@@ -567,7 +575,8 @@ int main(int argc, char **argv)
>         return 0;
>     }
>=20
>-    if (!qtest_has_device("nec-usb-xhci")) {
>+    if (!qtest_has_device("nec-usb-xhci") &&
>+        !qtest_has_device("ti-usb-xhci")) {
>         return 0;
>     }
>=20
>diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>index 5fbecd2f43b=2E=2E8e5c4747af9 100644
>--- a/hw/usb/Kconfig
>+++ b/hw/usb/Kconfig
>@@ -49,6 +49,11 @@ config USB_XHCI_NEC
>     default y if PCI_DEVICES
>     select USB_XHCI_PCI
>=20
>+config USB_XHCI_TI
>+    bool
>+    default y if PCI_DEVICES
>+    select USB_XHCI_PCI
>+
> config USB_XHCI_SYSBUS
>     bool
>     select USB_XHCI
>diff --git a/hw/usb/meson=2Ebuild b/hw/usb/meson=2Ebuild
>index 1b4d1507e41=2E=2Eb874a93f16e 100644
>--- a/hw/usb/meson=2Ebuild
>+++ b/hw/usb/meson=2Ebuild
>@@ -23,6 +23,7 @@ system_ss=2Eadd(when: 'CONFIG_USB_XHCI', if_true: files=
('hcd-xhci=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_USB_XHCI_PCI', if_true: files('hcd-xhci-pc=
i=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_USB_XHCI_SYSBUS', if_true: files('hcd-xhci=
-sysbus=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-ne=
c=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_USB_XHCI_TI', if_true: files('hcd-xhci-ti=
=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3=2Ec'))
>=20


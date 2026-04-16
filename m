Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DE4F8A142
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDHeZ-0004Yp-5r; Thu, 16 Apr 2026 04:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDHeX-0004YW-4r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:00:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDHeU-0005w3-CK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:00:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so52965455e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776326440; x=1776931240; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sbDZolMShqp6MfbBZTH0s4blYMYuL54CKjxI3W12a64=;
 b=nvJqYOwzkbIHpS7t/K5ESaDHzpgrWls3WM3v3uYjfTnJwsex030/YMGgL4ikOViE2c
 UqxKTHYIYqdC2UNvI9HE46KCyrtR1/MsndNAM2xRW2BrsmT6FzmumZMkrSv365R61BQ3
 RkRS+N/quUitZ9a4Uy/olxZQ+SPAuHa8WJ/1mHKSTRCKPzIUof4RtwrdOo4u3I0FCeGW
 8HW5avXbAqbn9EAocXUxiLnCkQYuILZ6Jb4J6r18EsKu3YPiPEJQ2Zbg0HghHQSlZDQK
 2qZdiivwn3GZHBfPhhDXTzpv/bq9t3NAV2PzyoA+j39uOi6K/aFeNUFzgC83Yr4kVmzT
 jRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776326440; x=1776931240;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbDZolMShqp6MfbBZTH0s4blYMYuL54CKjxI3W12a64=;
 b=mveWLBHdNiBXDe8jGv4/fhVdg6JakwghuF6zf5txYEdqXnAqJuZwfNpLInNsCPUVN7
 DSq/HYEHWsPoMZtul3belyd3LnoddJXJKjgOndI51zcoiDHvax+l3AkCtnXJEG6iHhT/
 AcJuvXDzrPn//7S2bMv5UHipm56M1QjYjB7ZiquQsXl+CKt8+y8jdroyXX7ifV82L+5X
 snX+wgQlYu4DTKV5jLcCoe8J/ttyoFMpsv22cLqD/WDUs0VpESN192ZvELqy5q9Ul55p
 pJoGg+j8C3hM8JEdhr72r4v7l1AoTSY82wtvCmCV5/g9NdxaaucDqZE7Osabarc1Qb2h
 mdsg==
X-Gm-Message-State: AOJu0Yx8pFFFthy0Z9v7AQpMPBOWzEgZ7ylRbPH8/dALJ4gmwVZ6ALsH
 1n/qUsmo8hQNjlOIBKzdljnHHefIJK8QEM3fhsAAEs7zl8cnIlvQoyie7XazFMHI6Uo=
X-Gm-Gg: AeBDieus9QzPQoYaw+3U3Mllz9bxFCnEDc2l6QQLqUOPMSeAqyoDixhrvLtQeEDTMS4
 HkYJQg/SZ0tCGM+lwqQvBoOmIGVbhkBmDwwA3GkSm9l65LxVESdBzB1X1Zzlbp3ycOStjaBsEcM
 /smUBIhe3+4a/LKwfDQC9LCmc/kKjfkjI4TAHAVU9zSeOJRIWgtNq/54snrPXTjuHLa6vNx1jXl
 DFbiwHpW9EYcA/oCUlMpUtNPeje0ObhBrOKjHgGknM3WBBu8CPuPC6bK6QuwUnAEDGkR3ByLh6X
 ccFf63Y7lvfdo3iEk2wyZVQRFISANcN9sFueNgAPF2sR4DAmZz3UCITU3LyqSpx9Y4uBvRoHyMM
 hThkpk4+aVGhE2Xd1iiFKbEKBxRutsbGBMi6k1j2bM4EoI7SOQ+rXaLHQbGtz3+Wt3Ny6HkWgBm
 Rt12tv9Rz/x34dAnPP6p33U3E8OAE6FkFDJH1aP1eRkIovUeSOR90E6dOclQa9jZNu1ZJcwNCqs
 CLWr/+SwLt1468d/+O92J4yn2hzPQ3L4k9KVEYC
X-Received: by 2002:a05:600c:a109:b0:488:af7f:7751 with SMTP id
 5b1f17b1804b1-488d6836508mr238620235e9.15.1776326439668; 
 Thu, 16 Apr 2026 01:00:39 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f095e68dsm66010615e9.2.2026.04.16.01.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:00:39 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 16 Apr 2026 11:00:34 +0300
Subject: [PATCH v2] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-vhost-user-rtc-v2-1-100a53bfc6ce@linaro.org>
X-B4-Tracking: v=1; b=H4sIACGX4GkC/3WMwQ7CIBAFf6XZsxhKkaIn/8P0UCmUTQyYBYmm4
 d/F3s07zUtmNkiW0Ca4dBuQLZgwhgbi0IHxc1gtw6UxCC4Ul71ixceU2atpjLJhxmrn+DCOw0l
 Bk55kHb734G1q7DHlSJ+9X/rf+zdVetZ2F4uUjhutz9cHhpniMdIKU631C8IVzUitAAAA
X-Change-ID: 20260416-vhost-user-rtc-ce8ff0377356
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Mitsuya_Ikuya_=28=E4=B8=89=E3=83=84=E5=B1=8B_=E9=83=81=E5=93=89=29?=
 <mitsuya.ikuya@jp.panasonic.com>, 
 =?utf-8?q?KUZU_KAZUKI_=28=E8=91=9B=E7=94=9F_=E4=B8=80=E6=A8=B9=29?=
 <kuzu.kazuki@jp.panasonic.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9402;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=GTPfy8d/1NH/oEqhRnnj3TBvPcVEKQMY/rS5xbxeyPU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0SmNtdXZMS3Q0NDc5R1dzN1dkckk4Qkl5NWRqCnRITC9tWXp5a0hLQkR3UytK
 SjZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVDWEpnQUt
 DUkIzS2Nkd2YzNEowTnNiRC9zRlhEVW9BVTZjbTlhaE1NTUdWdlZvY25SZ1R6cXI0cEhFMGh1QQ
 pEQzBpVERhcG50cThyemJjVTd6MEN3SVNWcHROeGNqZk5ReXUrN1VtUGxUY0NjeHU0STBmSTJFZ
 mJHTmo0VlErCm1nWjVsQUJmYS95b2ZuU3AxaVgrN2s4ZUQ0cmJrSUU1TVhDUEFoeVc2TTNtZHhI
 V0tBYWhLNVZaWCtDZ2hETzQKQVZNNENxY2ZJNUJoMEhNSUFjN290MVpzMWV3VDZkUkRwamZuQzh
 JSFIrdm5PcWVjd3N4TzBvRXREVTJ6MW9IbgppekxyWHQ1WlRqTGh3T0ZCamZkM0J1blRXc0hZVD
 RDaER3dUgvc0xSb2QzQVVaLzRNSitmWW00MWkwVEJzMVVRCkd5czBObG16MS9VOS83TGVwT1lZV
 ExRdjBnNVcvamgyQ0pNZy96ejhxTE1sYzgvV1MyVDFlcjdJd3hYK2tzakMKbjB2ZGhmSTRpVDZ4
 TFUzeG9mRFBYSlJCWERrWmhrQzQrT0RVSklNQml4S0Ywbit5SWJWSmNlOG00Z0Y5Um45TwpoOVR
 YZlV6UElxZ1RGL0wyelJxVGVyKzgrK0RlUVUrUit5YVJ0ZnNlZ1RHeHY4bUZQL2VtNm5RNk1qdG
 V2MXY5ClBjcXg1Z2xaMm9ES3JDcTZaNGpHaHpmMHZOaUl3aGszcjl2YnoxMVRHb21QWktaRWNHb
 mdTZW9tWmt5UC8yMmEKSHpaUjNEY2VmWTlJOUVrNlVUOGtaRmM0TjBaN0FCK0JvQ29yZVJyVGVw
 OUpCd2Z3M2htQ1R5VXBaZWNQWnE3YQpsdFFuYXkwNUpKV0VmOTVwNGJScUl1ZGViZVZOR0lkMkl
 NTmR2NkpsdzVtMnMzYlRrTldUV0VCRFNVTndoUCs5Cm5wdmVZZz09Cj1tL05rCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

Authored solely by me for Panasonic Automotive Systems Co., Ltd., but
based on existing vhost-user devices I wrote in 2025, so the copyright
is mixed.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Explain "unusual" authorship situation
- Link to v1: https://lore.kernel.org/qemu-devel/20260416-vhost-user-rtc-v1-1-1b2d44f0c889@linaro.org
---
 include/hw/virtio/vhost-user-rtc.h        | 22 ++++++++++
 MAINTAINERS                               |  6 +++
 docs/system/devices/virtio/vhost-user.rst |  3 ++
 hw/virtio/Kconfig                         |  5 +++
 hw/virtio/meson.build                     |  3 ++
 hw/virtio/vhost-user-rtc-pci.c            | 70 +++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-rtc.c                | 64 ++++++++++++++++++++++++++++
 7 files changed, 173 insertions(+)

diff --git a/include/hw/virtio/vhost-user-rtc.h b/include/hw/virtio/vhost-user-rtc.h
new file mode 100644
index 0000000000000000000000000000000000000000..6b7b53c28f93032886d82687199585aba0edd917
--- /dev/null
+++ b/include/hw/virtio/vhost-user-rtc.h
@@ -0,0 +1,22 @@
+/*
+ * Vhost-user RTC virtio device
+ *
+ * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VHOST_USER_RTC_H
+#define QEMU_VHOST_USER_RTC_H
+
+#include "hw/virtio/vhost-user-base.h"
+
+#define TYPE_VHOST_USER_RTC "vhost-user-rtc"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRTC, VHOST_USER_RTC)
+
+struct VHostUserRTC {
+    VHostUserBase parent_obj;
+};
+
+#endif /* QEMU_VHOST_USER_RTC_H */
diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced84d1ac58956ea374ee012acbb3cbd18..da6376b0f5e6fa99495504e88da9fef5a7a969e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2573,6 +2573,12 @@ S: Maintained
 F: include/hw/virtio/vhost-user-spi.h
 F: hw/virtio/vhost-user-spi*
 
+vhost-user-rtc
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Supported
+F: include/hw/virtio/vhost-user-rtc.h
+F: hw/virtio/vhost-user-rtc*
+
 virtio-crypto
 M: Gonglei <arei.gonglei@huawei.com>
 S: Supported
diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
index 2806d81ca201551a91246a10e0d98fd36d74200b..acfbd609d0f9c87e3af684797adf156a8a61bc88 100644
--- a/docs/system/devices/virtio/vhost-user.rst
+++ b/docs/system/devices/virtio/vhost-user.rst
@@ -61,6 +61,9 @@ platform details for what sort of virtio bus to use.
   * - vhost-user-spi
     - Proxy spi devices to host
     - `vhost-device-spi <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-spi>`_
+  * - vhost-user-rtc
+    - Real time clock
+    - `vhost-device-rtc <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc>`_
 
 The referenced *daemons* are not exhaustive, any conforming backend
 implementing the device and using the vhost-user protocol should work.
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 8895682c619402eb3c9cd7269d3319f39711b4bd..2ebdac16b31aec3ec283c0285a4dcfa67f0a5157 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -136,3 +136,8 @@ config VHOST_USER_TEST
     bool
     default y
     depends on VIRTIO && VHOST_USER
+
+config VHOST_USER_RTC
+    bool
+    default y
+    depends on VIRTIO && VHOST_USER
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 415e359e9fc79b6b1adbbcfc4f87a7106ef1d4a6..e0566a60de7989c4048956e268f151659467fe34 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -27,6 +27,7 @@ if have_vhost
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
     system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('vhost-user-spi.c'))
+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RTC', if_true: files('vhost-user-rtc.c'))
 
     # PCI Stubs
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
@@ -43,6 +44,8 @@ if have_vhost
                          if_true: files('vhost-user-input-pci.c'))
     system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
                          if_true: files('vhost-user-spi-pci.c'))
+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RTC'],
+                         if_true: files('vhost-user-rtc-pci.c'))
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
diff --git a/hw/virtio/vhost-user-rtc-pci.c b/hw/virtio/vhost-user-rtc-pci.c
new file mode 100644
index 0000000000000000000000000000000000000000..449368d27009acde20aa4af2542a912ac8b82cbc
--- /dev/null
+++ b/hw/virtio/vhost-user-rtc-pci.c
@@ -0,0 +1,70 @@
+/*
+ * Vhost-user RTC virtio device PCI glue
+ *
+ * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/vhost-user-rtc.h"
+#include "hw/virtio/virtio-pci.h"
+
+struct VHostUserRTCPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserRTC vdev;
+};
+
+typedef struct VHostUserRTCPCI VHostUserRTCPCI;
+
+#define TYPE_VHOST_USER_RTC_PCI "vhost-user-rtc-pci-base"
+
+DECLARE_INSTANCE_CHECKER(VHostUserRTCPCI, VHOST_USER_RTC_PCI,
+                         TYPE_VHOST_USER_RTC_PCI)
+
+static void vhost_user_rtc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostUserRTCPCI *dev = VHOST_USER_RTC_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    vpci_dev->nvectors = 1;
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_rtc_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = vhost_user_rtc_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_SYSTEM_RTC;
+}
+
+static void vhost_user_rtc_pci_instance_init(Object *obj)
+{
+    VHostUserRTCPCI *dev = VHOST_USER_RTC_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_USER_RTC);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_rtc_pci_info = {
+    .base_name = TYPE_VHOST_USER_RTC_PCI,
+    .non_transitional_name = "vhost-user-rtc-pci",
+    .instance_size = sizeof(VHostUserRTCPCI),
+    .instance_init = vhost_user_rtc_pci_instance_init,
+    .class_init = vhost_user_rtc_pci_class_init,
+};
+
+static void vhost_user_rtc_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_rtc_pci_info);
+}
+
+type_init(vhost_user_rtc_pci_register);
diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
new file mode 100644
index 0000000000000000000000000000000000000000..88b0c70b903363fc9ac7ccb65a1b1755e095c6bc
--- /dev/null
+++ b/hw/virtio/vhost-user-rtc.c
@@ -0,0 +1,64 @@
+/*
+ * Vhost-user RTC virtio device
+ *
+ * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
+ *
+ * Simple wrapper of the generic vhost-user-device.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/virtio/vhost-user-rtc.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+static const VMStateDescription vu_rtc_vmstate = {
+    .name = "vhost-user-rtc",
+    .unmigratable = 1,
+};
+
+static const Property vrtc_properties[] = {
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+};
+
+static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(dev);
+    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
+
+    vub->virtio_id = VIRTIO_ID_CLOCK;
+    vub->num_vqs = 2;
+    vub->config_size = 0;
+    vub->vq_size = 1024;
+
+    vubs->parent_realize(dev, errp);
+}
+
+static void vu_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
+
+    dc->vmsd = &vu_rtc_vmstate;
+    device_class_set_props(dc, vrtc_properties);
+    device_class_set_parent_realize(dc, vu_rtc_base_realize,
+                                    &vubc->parent_realize);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo vu_rtc_info = {
+    .name = TYPE_VHOST_USER_RTC,
+    .parent = TYPE_VHOST_USER_BASE,
+    .instance_size = sizeof(VHostUserRTC),
+    .class_init = vu_rtc_class_init,
+};
+
+static void vu_rtc_register_types(void)
+{
+    type_register_static(&vu_rtc_info);
+}
+
+type_init(vu_rtc_register_types)

---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260416-vhost-user-rtc-ce8ff0377356

--
γαῖα πυρί μιχθήτω



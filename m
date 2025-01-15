Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAF9C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCkQ-000460-OK; Wed, 15 Jan 2025 18:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkO-0003wQ-9r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:28 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkK-0003zn-Po
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:28 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so233867f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983463; x=1737588263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+EUM/dGaTmpBqRyvcVhqEGwu4Bbc6dUevtMJGPZQoI=;
 b=tg8Xj0Qsmtfti74oI+XOnrBLJTAXGknRRwtWfewBKMHaeoWi4gZETuzUEGkx2m5tAS
 GCvSauQdVAzkZXjUS+sqAmV8LUR5421KQtN2mt3eWklpTija7DgSZvhkjaVrLIfnpRXR
 JukvNsEpQlTX/tD/xzXshZiW/mbfgT258tC5MFPu94z1RVQkY/WWW4q+B6aFXnxEd1S+
 jr39JkXCQerywCHAdPZFLJvUwVXcb9+wWRGa+zems3k61/LcGQZIjOt53qszdy++tOBW
 LeijegRLrkqlAgl56OliEzHdbkeAFETwPGeQhQLfAgjH9izQ291APDJWoSFBEdKZxZb9
 OSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983463; x=1737588263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+EUM/dGaTmpBqRyvcVhqEGwu4Bbc6dUevtMJGPZQoI=;
 b=wWyewSE+EKlw3k6nv+RFsT/5yS/X8k4muEncxLk2XPPfFlApFZwi2Eqhy4kOdwIbP2
 0IIZ1GYgpwwER3X24u5G+22ksf7hTm4Chzfjw80eCI20OKvoukfs1DhOAq617g14H8tz
 VGoqbGhcQHDCesZ4Hjx2HMpAmABA5goq1+/f6gc6vsTCZerGnhXMBXGt6kat1a8835q/
 Ep04jfXyHNBI3Ji8fA0bH/bfpjkpaKfDcaG2KA0O1UN79G4p0gXykufLThfKu53HwL7x
 q3tETrH0schcxm3mM1yykKsVZOvzTfhmQmi+rHP6C/Gyu9Nr3ybv1PL8QF8xnzGGOSNK
 bh8A==
X-Gm-Message-State: AOJu0Yw/WEBn7ZJWT/5mmXtMUROYr/VrDj6kUTr6t8oKr+quzw0regdD
 0vslc0vDg3D+8LtXmwCUCDYLL4A2Qb2nHpjhJA2FKCm4O/zg0XTC2bJ8IbkGMZUcupQa4ewJykq
 +9+E=
X-Gm-Gg: ASbGnctH4ypAgLp16b3i9N2CzQhvzr2xkZVd0FLRDErUyLRbiZpSqbPDoGkRUyd3QO6
 /SQYoO9tiVpqBjpfn9WVGNjguQBABETvo28QY0WoFKM34LB25bM5lthyfAeZ21eJu95ehQSaJYV
 EBeo38eVRZ9Z+ZP3d/A3bwfrZTfK70umro0JW7lRvhB/ETf7+Zr0IIBiz+OfIQSSw+0uquQuT6G
 +mWVWpa9MFORG8cEGrkrLIzpajMMjrAYU903JeLOs1jrNcTKN28OlaruVwd/UEXJ17DY3u4FWeA
 P7Innii4WDkaasRgIIfguYF+Lk5W1P0=
X-Google-Smtp-Source: AGHT+IHXtT+t92dBv7aDszdTResZLPnWtvBmArCTjujgUpNgaR1Nls1qjM1O8hUbJZMM5WxHoxhkiA==
X-Received: by 2002:a5d:6482:0:b0:38a:87cd:6d67 with SMTP id
 ffacd0b85a97d-38bec3b45b2mr464731f8f.0.1736983462834; 
 Wed, 15 Jan 2025 15:24:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e59fasm39329265e9.34.2025.01.15.15.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 17/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
Date: Thu, 16 Jan 2025 00:22:43 +0100
Message-ID: <20250115232247.30364-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around PVSCSI_COMPAT_DISABLE_PCIE_BIT.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/vmw_pvscsi.c | 44 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 8c793b4188d..4c95794ba1e 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -68,11 +68,6 @@ struct PVSCSIClass {
 OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
 
 
-/* Compatibility flags for migration */
-#define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
-#define PVSCSI_COMPAT_DISABLE_PCIE \
-    (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
-
 #define PVSCSI_MSI_OFFSET    (0x7c)
 #define PVSCSI_EXP_EP_OFFSET (0x40)
 
@@ -1152,15 +1147,11 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     trace_pvscsi_state("init");
 
     /* PCI subsystem ID, subsystem vendor ID, revision */
-    if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, 0x1000);
-    } else {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
-                     PCI_VENDOR_ID_VMWARE);
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
-                     PCI_DEVICE_ID_VMWARE_PVSCSI);
-        pci_config_set_revision(pci_dev->config, 0x2);
-    }
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
+                 PCI_VENDOR_ID_VMWARE);
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
+                 PCI_DEVICE_ID_VMWARE_PVSCSI);
+    pci_config_set_revision(pci_dev->config, 0x2);
 
     /* PCI latency timer = 255 */
     pci_dev->config[PCI_LATENCY_TIMER] = 0xff;
@@ -1228,21 +1219,8 @@ pvscsi_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pvscsi_vmstate_need_pcie_device(void *opaque)
-{
-    PVSCSIState *s = PVSCSI(opaque);
-
-    return !(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE);
-}
-
-static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
-{
-    return !pvscsi_vmstate_need_pcie_device(opaque);
-}
-
 static const VMStateDescription vmstate_pvscsi_pcie_device = {
     .name = "pvscsi/pcie",
-    .needed = pvscsi_vmstate_need_pcie_device,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
         VMSTATE_END_OF_LIST()
@@ -1256,9 +1234,8 @@ static const VMStateDescription vmstate_pvscsi = {
     .pre_save = pvscsi_pre_save,
     .post_load = pvscsi_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
-                            pvscsi_vmstate_test_pci_device, 0,
-                            vmstate_pci_device, PCIDevice),
+        VMSTATE_STRUCT(parent_obj, PVSCSIState, 0,
+                       vmstate_pci_device, PCIDevice),
         VMSTATE_UINT8(msi_used, PVSCSIState),
         VMSTATE_UINT32(resetting, PVSCSIState),
         VMSTATE_UINT64(reg_interrupt_status, PVSCSIState),
@@ -1292,19 +1269,14 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
 
 static void pvscsi_realize(DeviceState *qdev, Error **errp)
 {
     PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
-    PVSCSIState *s = PVSCSI(qdev);
 
-    if (!(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE)) {
-        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    }
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 
     pvs_c->parent_dc_realize(qdev, errp);
 }
-- 
2.47.1



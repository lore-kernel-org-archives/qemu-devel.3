Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75908C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWT-00065v-U0; Tue, 06 May 2025 10:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJT7-00081C-NR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJT6-0001q4-0a
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so4294005f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542422; x=1747147222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeAsbqePxiywrZL8I2fb4NnneFfbsTioEZQtZ2IfobE=;
 b=yMD5433gysByjVKfogYhws5fOFLg3vMfE1Ruv9ejKeLFwG+wPRx24xZAmcL/scY2hN
 BWB22s5yDiLj1kx5lAI/wq5QZqLhKMK+GrBKMKHYaEuF5HgvH1BVU06isjpFMj97jzrr
 7kBnibPx8i94PmqYFlvQGA1oxqJa26ZpWiDsLfEATorlEq/LuRL3YhHD8Y95czp3Uttm
 PsLtQu6LnRlR6ddZWX23yj2iY6fy+I6NJiSmr6jvf9BlgORk1hNaYskfVo7jDRG8b8X8
 8P9MKjeqMnX4vBdcX+j8+hY+8p5IuNC7JrdODuyt+HlHKHeJKBd9xI3HqNMnmmOy77SZ
 Ij6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542422; x=1747147222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeAsbqePxiywrZL8I2fb4NnneFfbsTioEZQtZ2IfobE=;
 b=GXBwG0Xn6tNuM08yisD1XCWq+/QcASMtnio3QlPbMYs5sFfSNkrgSUfJfeJMzcEvJo
 WcxnpL6wuSIeAjtGU0dcEian2+cioCsH4p+ycEJuwA+CVR5Sq3jWnC2DQZIc4B/XaHVh
 QIwnOTSdktN0adeJrD/vsz3ZyKXQChqou95QCIjuWPrJnjLeF3BGQm81CmT/psuT9EQk
 3vtHgZ+Waztu2a5OgrvlVU2iFf9ux+hVvsS/qFVyqTuEXbRDSS2FgYoue2xlYysByyJc
 GBLGWj0FHO5FtjRpVmPEjkyyeyIZYkaJwXQCoV5ZrKE/G2XGz4TR94/GtwnELPQYwwr8
 3Yxg==
X-Gm-Message-State: AOJu0Yyr3WkjKIKAu2VOKNq0ouTZvDO3R5N+y+xkcnATy+WBis3Jz3uS
 ZQr3C8bDGcLogI+HHAyTTWNZ9y2Yk65I9/icZmy4EHlxuqujpwQVEamEy9l4gcOk3S+jt5yfBN7
 r
X-Gm-Gg: ASbGnct3bbXhok5nNza2LbJTv1he+gw5AcVKDj9VxNYwWXgocgMcpippZ4Hw85wrMOV
 5Yd2Q0E5ydbt7mo9SMs1PZOLU1DTX2NmfeNoSvQUUr/341Qk8mKBj0tqWV4OpMJ8pMxHY0maFHI
 PFaJf7IO+4PhBxLLP3JGwXFQmYPdalRIfeK1e9eUZRK4Givc1yylI3C7Iu4dY5EUNQkyL5MiYTj
 R/c8FykH866gVZoGJbBQK/m8Q6qZNT6OpA+blJlw01+F7lusDmoJWql4LxqViSkCiyRhyEts9NN
 QvyiaDCtLgyyu8QNxDLBSoEy9bmquEfUYlKejXd11FAraActCGE3P6jpwAf40xOSugR/ZAazTrG
 Vpa5WkBIvqQXqKzWwc41m
X-Google-Smtp-Source: AGHT+IHrmFjr420kSR9jDSx1GPtsFNcTWF5qi/UnwFdTwpLLmKGBDrbtNOQsdDKecWbnHKXOxtnNCw==
X-Received: by 2002:adf:f1d1:0:b0:3a0:ad55:ca0c with SMTP id
 ffacd0b85a97d-3a0ad55cb14mr2258955f8f.1.1746542422140; 
 Tue, 06 May 2025 07:40:22 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae35fcsm14158475f8f.32.2025.05.06.07.40.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 15/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
Date: Tue,  6 May 2025 16:39:01 +0200
Message-ID: <20250506143905.4961-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
code around PVSCSI_COMPAT_DISABLE_PCIE_BIT, including the now
unused PVSCSIState::compat_flags field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 34de59a7cf6..e163023d14c 100644
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
 
@@ -123,8 +118,6 @@ struct PVSCSIState {
     uint8_t msi_used;                    /* For migration compatibility      */
     PVSCSIRingInfo rings;                /* Data transfer rings manager      */
     uint32_t resetting;                  /* Reset in progress                */
-
-    uint32_t compat_flags;
 };
 
 typedef struct PVSCSIRequest {
@@ -1224,21 +1217,8 @@ pvscsi_post_load(void *opaque, int version_id)
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
@@ -1252,9 +1232,6 @@ static const VMStateDescription vmstate_pvscsi = {
     .pre_save = pvscsi_pre_save,
     .post_load = pvscsi_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
-                            pvscsi_vmstate_test_pci_device, 0,
-                            vmstate_pci_device, PCIDevice),
         VMSTATE_UINT8(msi_used, PVSCSIState),
         VMSTATE_UINT32(resetting, PVSCSIState),
         VMSTATE_UINT64(reg_interrupt_status, PVSCSIState),
@@ -1288,19 +1265,14 @@ static const VMStateDescription vmstate_pvscsi = {
 
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



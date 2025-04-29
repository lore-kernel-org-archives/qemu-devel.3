Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A805C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lfP-0004MK-Mr; Tue, 29 Apr 2025 10:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lep-0003VJ-Q8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:10:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9lem-0006UP-IR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so38649105e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935785; x=1746540585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1t2rS7sMqGG0jQ3p7FyGRdjclg6gvnu3KRb1lwZ8q+A=;
 b=VF6ETirT9sv+EJE1mPItdBkgv8i2P4DHQq3gA1hAE/a5C48LzXEk03OobOhO8qqBQ/
 E0HRL/gv4pYJApCg86Yrw+1jXQ9SuInlOlUAmiKl3J02Tk/pVumRaoti/0qn7HNwLf3u
 tYbYnGxUtOpnQyx+QmJ1akxGQ+gcWudj/0tJ891Mm+jONRTV6oUkeD7MVN6oZ0ONngep
 Qh5lUiy/09L+pcgAnb1L0+tebINs9jBOHj5oK38UJmacAGWCtqe5x9FrNEsudCPeBUMy
 RQOd9C2mAM7K0c8JOEf7hTuWSYt5i/lXZebWeIRfm6ZE0Oif+EKAvBlGRdRl5A1oFpx2
 Uf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935785; x=1746540585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1t2rS7sMqGG0jQ3p7FyGRdjclg6gvnu3KRb1lwZ8q+A=;
 b=rBP4uKtsbIrmz1cM/udX5tRCqolgf9lwyD5w6VIcGwSsf/5rRcNtWzzWZ6sNxkqIX4
 b5Q/H99Ameuzpma7K/ieMkHYE+u4sATmItpLiCnEc3v4vJcm94UtbnOS0nEOnA2V7kra
 Mc3EMqXbfN0iTz9oV/vkxGtNkfo8Dqv99tiz+jjozyfD+Lz3I1vpusCQjFVuYqOvNLND
 v/fYTcZtzfvUWq8lofEwX6MoN39JCLYqLDr3S3UkH4DCPJPT3efkWmqg/f1w7JRqMQhY
 4P/pliHVcLcgN6navAiPCQpQh1x2Z7F0GhlmtcpJK664qiJ8USNX9WPo4ERG94pZa0gH
 WpIg==
X-Gm-Message-State: AOJu0YxYKhHD6/W6VhxCzBI7UB1UsmrrkoFibqC5qIGHDIZDMBMDC5xt
 SChNV4t9RzSkKQTLTd5mL+3AutQyANhvN2m6vtnouWog5KF7ygZJkvsiDa662sNPQZ2wZ3ipDgf
 x
X-Gm-Gg: ASbGncuPdnCpAiNnT4ZI/ZYUUXI4y5AElbBmosFWkpMAqQCufPabqPWCORNfXFwoxgi
 f+r9dn9IHYOJEe+xYdrwitdiS+nKdA+3YX8qkhpx4MMIiJW2vTBUhKDAJX67WMCCE0gIxOCf+GB
 DuEcIWOPkvSwXVvTYehMC4Z8aXFrjm21zEBIc8pbvmCWGU76Zu29sCX1LPCaDoSywgOMEDVPpoo
 KG+aMwGNCnjWd73run3tdz4XLSWeiKoWXp7rFr4TJYazz+Jn6ZMS7YPiGJ6jgOeaz6ijUrV2C5w
 nAGiCpOA4KDcq4oJlw60v3Wh7M2JF47yQiWVQ9B47Ar1Sqqop81HQyK5fndX9zcgzuswbPD/FOG
 l7WhVkHbSU3QKGPEcOhHn
X-Google-Smtp-Source: AGHT+IE8XcOPfdl7iFneLDxHpg2ev2e3ba7JmOD8DPG+iVefvLC+e6qg6d0yARL12f59X6FJf25TiA==
X-Received: by 2002:a05:600c:384d:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-440ab848aa3mr108657535e9.26.1745935783582; 
 Tue, 29 Apr 2025 07:09:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2dfde6sm188177025e9.36.2025.04.29.07.09.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 15/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
Date: Tue, 29 Apr 2025 16:08:21 +0200
Message-ID: <20250429140825.25964-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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



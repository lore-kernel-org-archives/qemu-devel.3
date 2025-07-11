Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C3C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuz-0006iT-0I; Fri, 11 Jul 2025 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu4-0004X3-QC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu1-0003AP-O5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4537fdec39fso6622065e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240900; x=1752845700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SmuGdusT+795T8OqqPDbbZnsjy/qkrk4vaiaLtn1uU8=;
 b=cNr9ZriCYfUY5lBqdqqOL+9NTxZsNyL0zEczLsX80fiuJL2e+dU82bPGrm7zgTxZSR
 PMIGHze2pfgS0Je422ZdFA1uxwGxS5hVS13Pd4OzPBrTOoyfebvv/R3O4S3Ej7GpaFnM
 JUWOqagpGzhQYUVwyDmn3Uu7V5p7lsGlFevNNAanULvBK+iNa3Guhx/zScdfhgsvUKiB
 AuOC/JxwC4cgdBAp6r9uAjbkETY0H6FmhFeaJccQuA+PlfYAzTGWcqz5Kn9CZt90kRCu
 0J+knDZJgBTvsbJk5j6Jp8yIkkEOujT+3l0w2TUJF/ZbPJdCWGF/tEH9+WDHaj+4rgme
 IdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240900; x=1752845700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmuGdusT+795T8OqqPDbbZnsjy/qkrk4vaiaLtn1uU8=;
 b=MUlmpt2K3EwHklJPqQJU9kUnJqq9Jbr8DMcLRrH+gPnnOfw19zTXy2ZG996ZP9Avqi
 7zK/zA5xv41SV8VG5+OKVKLgEokBSVk/UnRldPGisgj2ZhcOtWywsfYmpc6N/2U9Wlkc
 alGBMmHkvRDM4RmNNJymsAlx+7ZVUUHxvu5UZIpCJxHiyXAIUlmynWf7r+NGU8pEeHCP
 uvdGks5RUYW2u8hOGt9uDFESrdsmV6BKv9+uMSDXujODamwRAjEFBHdQAbKlDPq/nUSs
 Y+LcFYM6eWslcrUAVheUn1/38IOTzlk9RLUfr/NU+FdM4UyCa7WEvZaK5ETMWcgvyX5U
 e+fg==
X-Gm-Message-State: AOJu0YzIDrhAX3I6yGVXeO/QmA58E3BniPDeX6sL26sOqdFZIpTWtSPN
 HBKq9oPcLqYcaPVigKQJeiSH5nWzUBSM+k3Dj2rI5eja5fTJd9Y4OUcZF22q61mKhYc838vaiQf
 CwvWF
X-Gm-Gg: ASbGncu8eCLEjXAWo2zrvc9j4Y41ureUWZe6EqUtFXYnFQyvGCp2hLIblLAJ//bQcwC
 nHAlC1TaBJKEeW4Hnz8hlktbBlOQVpeEs4VgfZ3AygSyEjrjdHA1Zy+jU8raBGOaL1AEh1utkfq
 BxkSMnb5qwZBJHOBmGHt/7SjaLJsTIeoDAekklkgtnmbfIhjBigI1PmSuWx1yFn+KOLgfxUhryG
 d2riE1YxfdTt9xIKpRzwotfjZFyNN7NwrLbhcA1m6lxiJitHm3S/6NC7S+325TxzBjxyrpLqdyY
 PLp7dXBzm7uW/D3OD4kxDbsqSB6dv26Px0QYRl6931lmKPXCPgHt9MpHJjmMeY7WQQgEDg6EZgc
 UJ3Ha2dLOIvVFtoblQynbnNdNEPq8
X-Google-Smtp-Source: AGHT+IEG3I4h/1toVgrwbxsnGVl5zJoGzVEayRUUaBgx/H/LtoScrm9SFwuA7srgnvWhxGETf4lZhQ==
X-Received: by 2002:a05:600c:3b05:b0:450:cd50:3c64 with SMTP id
 5b1f17b1804b1-454f4274eb3mr34040715e9.31.1752240899935; 
 Fri, 11 Jul 2025 06:34:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/36] hw/arm: Allow setting KVM vGIC maintenance IRQ
Date: Fri, 11 Jul 2025 14:34:20 +0100
Message-ID: <20250711133429.1423030-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Haibo Xu <haibo.xu@linaro.org>

Allow virt arm machine to set the interrupt ID for the KVM
GIC maintenance interrupt.

This setting must be done before the KVM_DEV_ARM_VGIC_CTRL_INIT
hence the choice to perform the setting in the GICv3 realize
instead of proceeding the same way as kvm_arm_pmu_set_irq().

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20250707164129.1167837-2-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h |  1 +
 hw/arm/virt.c                      |  3 +++
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_kvm.c            | 21 +++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a3d6a0e5077..c18503869f9 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -231,6 +231,7 @@ struct GICv3State {
     uint32_t num_cpu;
     uint32_t num_irq;
     uint32_t revision;
+    uint32_t maint_irq;
     bool lpi_enable;
     bool nmi_support;
     bool security_extn;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 394e8b53018..c9f39919370 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -833,6 +833,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                          OBJECT(mem), &error_fatal);
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
             }
+        } else if (vms->virt) {
+            qdev_prop_set_uint32(vms->gic, "maintenance-interrupt-id",
+                                 ARCH_GIC_MAINT_IRQ);
         }
     } else {
         if (!kvm_irqchip_in_kernel()) {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 1cee68193ca..e438d8c042d 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -612,6 +612,7 @@ static const Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_BOOL("has-lpi", GICv3State, lpi_enable, 0),
     DEFINE_PROP_BOOL("has-nmi", GICv3State, nmi_support, 0),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
+    DEFINE_PROP_UINT32("maintenance-interrupt-id", GICv3State, maint_irq, 0),
     /*
      * Compatibility property: force 8 bits of physical priority, even
      * if the CPU being emulated should have fewer.
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28d..b30aac7aee1 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/arm/virt.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
@@ -825,6 +826,26 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->maint_irq) {
+        int ret;
+
+        ret = kvm_device_check_attr(s->dev_fd,
+                                    KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0);
+        if (!ret) {
+            error_setg_errno(errp, errno,
+                             "VGICv3 setting maintenance IRQ is not "
+                             "supported by this host kernel");
+            return;
+        }
+
+        ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0,
+                                &s->maint_irq, true, errp);
+        if (ret) {
+            error_setg_errno(errp, errno, "Failed to set VGIC maintenance IRQ");
+            return;
+       }
+    }
+
     multiple_redist_region_allowed =
         kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
                               KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
-- 
2.43.0



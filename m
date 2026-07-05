Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNvs-0005BB-NI; Sun, 05 Jul 2026 10:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvr-0005B0-KE
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvp-00016J-Um
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfP5ZteIZuG9MnPCQQceIltovRko4AplCnjjhfUb6nY=;
 b=K758yidreKpnAfc8ohGoa3T7XS+gO/KqybKiNwZLwpe/lSch+Ig9KLt58eorJlvUaebcl0
 KCt70nF4fYtCvf+8nnXa4xyYyTlnuHl4wF6p5gdFaMpj6dcBS89ptnzkrvPTsHfiIvLgFy
 8M0Ab18upAh+xFbzDQmCyvTW5LBADfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-MNVOAvd5NeqBItOLfg3DvQ-1; Sun, 05 Jul 2026 10:34:50 -0400
X-MC-Unique: MNVOAvd5NeqBItOLfg3DvQ-1
X-Mimecast-MFC-AGG-ID: MNVOAvd5NeqBItOLfg3DvQ_1783262089
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c1bc7a70so17070015e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262089; x=1783866889; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SfP5ZteIZuG9MnPCQQceIltovRko4AplCnjjhfUb6nY=;
 b=e1eUuVAUpgn8Q+PAj3CR0VrlEffc5GHQ6AF3nbhaxaO0p5OUX5lyvskFLFRM2VhBHx
 o7d5PryUbqegQqThwJyEmf9hM5QcMTVYS0ADPWzBo77DvVAeY8p3ESMKYEmdBdkMDGAU
 8X3nJrNBagX9TJpHDJdFA/MzgJl1XlXQ0GsjQ6d/S1ORTg4yHbxJkCB+GGbrjqmWIQ04
 p31sT5WIpdZCIRwBEDI9ix4JYC/9u8nijA/XTpZBXa4NOpe+/YaPFsLH/VDQTyFvfQTl
 EiuzMp31l2OZFesGIJJxZggTyYqifImUalEP6J9+X9AlRWZ4BM49qgSgI69elfuR06DI
 /vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262089; x=1783866889;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SfP5ZteIZuG9MnPCQQceIltovRko4AplCnjjhfUb6nY=;
 b=aL4m33Rn03POx11OAiToJ+4xWyfqOnTO235JCOtWAmG8kEvHqjTP92xsYKjHpkgFlw
 ZLBxuDPts8Oi2L1a/WuRhiBADKLGbotV3EEO2zVWNlpdMHrDHEUkcEqhxBUlUFqUHdrg
 Idc2x6Kka65D5fd0y7zECQTKCyDVt9lXe3RdHpbzPNh/Zl7uAPZneMwbxPdaAMrLVb9d
 d9i/anvkNtdjc/eWUaGeJwFremlZiMrRFoMTJvY+77r7Q0y9b9dUlZLdM1wU7o+z5Ghw
 2bva9tB0RB3r3kKhPK+G+bFZGD1KRgrAFdO94emWoZ/lf1ZDyMMHosj8RDRMKTeMVazP
 gTJA==
X-Gm-Message-State: AOJu0YwNn2PMtflyLExty4ORVfjdEtGGHnN6UWfjLi9GU/5BSJzqp+cj
 lCpeDf05FOesmibeJOivlg8ANQ83raIrpa1ILja0DtZHOnF/C13MCP/CcHIPzpVD9wJXg137YiO
 Ctp/3ahkU5N0PhMS+VHY8aavVl7H4GG05/W+5Lqpf0xoUapPp+EY1G698sJ23zNTe8hcaOFLu1H
 HqLzEL0pOmhTH0EREgIF1Reo0XzInqxO5cUA==
X-Gm-Gg: AfdE7cn+iUWdrutNL0gR7vzlG64ETqaCU8UBBGXCV7eT+fH+QDLkZr1ykH+byNrLMat
 Nq6amrbS8wCdqxCw7TGvLdsvdsrnp68CaeIeeZL3YyNy0cJ9UhN+SZl08eSxh+RJxDKhvhC9LKs
 9E3lCkAIgZur2iDyL8OOzuc9YQfgfMZpJf1hL5Rw/7ZeHPuLYbSE45WtCroDJYuUxX++85lUUlF
 vS5ZU7TFa2JgzJl/idgVMnbNDIRCEclihtNRlRhvxkyPBlKaznA38xvBQyl6evVbupPckeuKK6u
 JTJmrzqGLYGEIzhgaHVHH3wfAUuR6Kgjm3LJHPozGuCg8iCXxEKS5Omo8VkuBSI9pJcot4Q9c7S
 uxLOIse6gsgaoxSMzcDWZ+LHwEnpr5MI8
X-Received: by 2002:a05:600c:1992:b0:493:b91c:6bf with SMTP id
 5b1f17b1804b1-493d11f149emr72442505e9.18.1783262088585; 
 Sun, 05 Jul 2026 07:34:48 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:493:b91c:6bf with SMTP id
 5b1f17b1804b1-493d11f149emr72442215e9.18.1783262088059; 
 Sun, 05 Jul 2026 07:34:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdb566csm198342605e9.7.2026.07.05.07.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:47 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/44] amd_iommu: Decode XT interrupt control register without
 bitfields
Message-ID: <83ec1c7fcb243c232186df790f5847808cc26982.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The XT IOMMU General Interrupt Control Register is a guest-visible MMIO
register. Decoding it with bitfields depends on host bitfield layout and is
not portable to big-endian hosts.

Fix this by removing union mmio_xt_intr and explicitly extracting fields
with FIELD_EX64() from the full register value returned by amdvi_readq(),
which has already been converted to host endianness.

Using a designated initializer for X86IOMMUIrq also ensures fields not
provided by the XT register (e.g. msi_addr_last_bits) are initialized before
x86_iommu_irq_to_msi_message() uses them.

CID: 1660056
Fixes: cf0210df65aa ("amd_iommu: Generate XT interrupts when xt support is enabled")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630220806.1758748-4-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 14 --------------
 hw/i386/amd_iommu.c | 28 ++++++++++++++++++----------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 3cab04a6d4..ca4440a4c1 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -340,20 +340,6 @@ struct irte_ga {
   union irte_ga_hi hi;
 };
 
-union mmio_xt_intr {
-    uint64_t val;
-    struct {
-        uint64_t rsvd_1:2,
-                 destination_mode:1,
-                 rsvd_2:5,
-                 destination_lo:24,
-                 vector:8,
-                 delivery_mode:1,
-                 rsvd_3:15,
-                 destination_hi:8;
-    };
-};
-
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a0835a20d7..291cb368a9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -34,6 +34,7 @@
 #include "hw/core/qdev-properties.h"
 #include "kvm/kvm_i386.h"
 #include "qemu/iova-tree.h"
+#include "hw/core/registerfields.h"
 
 struct AMDVIAddressSpace {
     PCIBus *bus;                /* PCIBus (for bus number)              */
@@ -88,6 +89,13 @@ typedef struct AMDVIIOTLBKey {
     uint16_t devid;
 } AMDVIIOTLBKey;
 
+/* XT IOMMU General Interrupt Control Register layout */
+FIELD(AMDVI_XT_GEN_INTR, DEST_MODE, 2, 1)
+FIELD(AMDVI_XT_GEN_INTR, DEST_LO, 8, 24)
+FIELD(AMDVI_XT_GEN_INTR, VECTOR, 32, 8)
+FIELD(AMDVI_XT_GEN_INTR, DELIVERY_MODE, 40, 1)
+FIELD(AMDVI_XT_GEN_INTR, DEST_HI, 56, 8)
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -194,17 +202,17 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
 
 static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
 {
-    union mmio_xt_intr xt_reg;
-    struct X86IOMMUIrq irq;
+    uint64_t xt_reg = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
 
-    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
-
-    irq.vector = xt_reg.vector;
-    irq.delivery_mode = xt_reg.delivery_mode;
-    irq.dest_mode = xt_reg.destination_mode;
-    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
-    irq.trigger_mode = 0;
-    irq.redir_hint = 0;
+    X86IOMMUIrq irq = {
+        .vector = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, VECTOR),
+        .delivery_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DELIVERY_MODE),
+        .dest_mode = FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_MODE),
+        .dest = (FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_HI) << 24) |
+                 FIELD_EX64(xt_reg, AMDVI_XT_GEN_INTR, DEST_LO),
+        .trigger_mode = 0,
+        .redir_hint = 0,
+    };
 
     x86_iommu_irq_to_msi_message(&irq, msg);
 }
-- 
MST



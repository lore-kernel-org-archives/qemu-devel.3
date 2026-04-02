Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F30D6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q23-0008GD-Sp; Thu, 02 Apr 2026 17:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q21-0008Dq-4l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:53 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1z-00073l-H1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:52 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso419697866b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167010; x=1775771810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etfciyFx/DN7OMzbyp+X0A8fa1no60agscIjAwvrx08=;
 b=dxx55HgPvEnRDTqUZ5mKfQIKV72sExb/WL+0Vm+x9yAIAA3h7fUciYVESp/zt/rToc
 hifgj8fjU1DGfaPF7QdeD1PlbqZGFrQ/URuPEhqOdolGyLnXgzXLRM/vpMRhaLLOrtIW
 +3s1lNpe/ESRmqyzANZQacUl1CSQ1yayJaASMOiggSUScf5xIqi6fJBTnurQbOubaM5O
 y+WkMvQKdXNzo9R6KRwGWL1go+bxIqRetvFtds6iPdnKNNvfK0mjUwerYQ2KQUI4Q/pJ
 hcBIxENikIwNT3AuN6mNeP/Mui71fehX5ZybTewnE8a8pyJm2GGDY16nOqFX4Yw2cac9
 hiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167010; x=1775771810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=etfciyFx/DN7OMzbyp+X0A8fa1no60agscIjAwvrx08=;
 b=ib8FXlrZpkgDLBGa4ZUAL+lTqVSL8JkXTFvAFVcOCQh2Lp8SpB5Tney8xTi0QIe/1N
 RxoKgkeiUA6CRXRpJ1UhM3Qw+JPFSrdFyXAe5mc01AGoztbSSgjcTixH9pkzfzbWa94T
 GT4uD3lUoB9ook3rGxJ30b6eQvrkjcib5T/UIhU6j9sSPEf5K/BKE8+i+TGYlRFvI+aG
 bt9ExywsXBGf9qgjlHQ+5MiA9uaOjCs88ltOFTIoBvrQCxqMfBcbNraX6hCoGyUZJOXJ
 WXGqx6XjssuiI0Zlby1ktLMKbIX4TX/f1Y3EGXizwEbpK4Brl2VgkSfaiv7JjdHMGxBR
 L0dA==
X-Gm-Message-State: AOJu0Yxl1QiHypr2xqDOdwpf8mYVRGjecUnAfxGfLh9R11Stb3VDz1gA
 xcz3iTxdXIvoQKIQqomZOPuFwdAFXKqLqqtOo23MbpNLsz/qvSTHv2VVcHa/vXOv
X-Gm-Gg: AeBDievxTIrBudmIKHGQ05kDnEmNs8NiX6lD5ey9hqoyVQrCFy9tenTL8Ds4UMV2xy2
 vLmfBcW4QBXubTFSh1T+CPUJbngZ9hQcVhuXhVbE20iwSrRF7gAG6tqdgYW/4GjBUU6g+SITpjd
 2RR+UC1KJyS2j7lQaBtQsCKdpHYKGfLKINRwMrxRiGY3dkUAh9tYrag1hnJ49cUSNKotYGur/ob
 PiFNoU8an+eXxV7Zzr21mD5HXqFgzYp7c/4JXAtVS2TVQc3fobsjl4trg80UXo51qfz4c+5zNjK
 wH7y1RTVTVM57JTAT2od2wwTmO8mi27QajmuiiUi9Nxwx3WvPhC8Czxdj+zFu5y2kLuhG7liNoV
 qyTZiqjfpshBKyORi8g8V0NdgoB6joN7UpIW16/Nnrp3mG8TSY/Ly+FjxdHRYuBpS1lL0hvqSKA
 4HCqUKqYP/FWi3dbxuPrUy1AQPGvEdFX7ShGPonZlC9+4LdrE0hn48rVbvBZVaOfCp7oTy+w==
X-Received: by 2002:a17:907:a0c9:b0:b97:b88c:386b with SMTP id
 a640c23a62f3a-b9c4713ebbcmr232362766b.29.1775167009646; 
 Thu, 02 Apr 2026 14:56:49 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:49 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 05/33] hw/core/fdt_generic: implement FDT machine creation
 helpers
Date: Thu,  2 Apr 2026 23:55:50 +0200
Message-ID: <20260402215629.745866-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch adds infrastructure to parse device tree
and associate fdt nodes and created objects.

This will be used during instantiating machine from the
devices tree.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic.c         | 71 +++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h | 42 ++++++++++++++++++++-
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/hw/core/fdt_generic.c b/hw/core/fdt_generic.c
index 65e3c1efa3..da60de7a26 100644
--- a/hw/core/fdt_generic.c
+++ b/hw/core/fdt_generic.c
@@ -29,7 +29,10 @@
 #include "qemu/osdep.h"
 #include "hw/core/fdt_generic.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/coroutine.h"
 #include "qemu/log.h"
+#include "system/reset.h"
 
 
 #define FDT_GENERIC_MAX_PATTERN_LEN 1024
@@ -108,3 +111,71 @@ int fdt_init_inst_bind(char *node_path, FDTMachineInfo *fdti,
 {
     return fdt_init_search_table(node_path, fdti, name, &inst_bind_list_head);
 }
+
+void fdt_init_yield(FDTMachineInfo *fdti)
+{
+    static int yield_index;
+    int this_yield = yield_index++;
+
+    qemu_log_mask(LOG_FDT, "Yield #%d\n", this_yield);
+    qemu_co_queue_wait(fdti->cq, NULL);
+    qemu_log_mask(LOG_FDT, "Unyield #%d\n", this_yield);
+}
+
+void fdt_init_set_opaque(FDTMachineInfo *fdti, const char *node_path,
+                         void *opaque)
+{
+    FDTDevOpaque *dp;
+    for (dp = fdti->dev_opaques;
+        dp->node_path && strcmp(dp->node_path, node_path);
+        dp++)
+        ;
+    if (!dp->node_path) {
+        dp->node_path = strdup(node_path);
+    }
+    dp->opaque = opaque;
+}
+
+int fdt_init_has_opaque(FDTMachineInfo *fdti, const char *node_path)
+{
+    FDTDevOpaque *dp;
+    for (dp = fdti->dev_opaques; dp->node_path; dp++) {
+        if (!strcmp(dp->node_path, node_path)) {
+            return 1;
+         }
+    }
+    return 0;
+}
+
+void *fdt_init_get_opaque(FDTMachineInfo *fdti, const char *node_path)
+{
+    FDTDevOpaque *dp;
+    for (dp = fdti->dev_opaques; dp->node_path; dp++) {
+        if (!strcmp(dp->node_path, node_path)) {
+            return dp->opaque;
+        }
+    }
+    return NULL;
+}
+
+FDTMachineInfo *fdt_init_new_fdti(void *fdt)
+{
+    FDTMachineInfo *fdti = g_malloc0(sizeof(*fdti));
+    fdti->fdt = fdt;
+    fdti->cq = g_malloc0(sizeof(*(fdti->cq)));
+    qemu_co_queue_init(fdti->cq);
+    fdti->dev_opaques = g_malloc0(sizeof(*(fdti->dev_opaques)) *
+        (devtree_get_num_nodes(fdt) + 1));
+    return fdti;
+}
+
+void fdt_init_destroy_fdti(FDTMachineInfo *fdti)
+{
+    FDTDevOpaque *dp;
+
+    for (dp = fdti->dev_opaques; dp->node_path; dp++) {
+        g_free(dp->node_path);
+    }
+    g_free(fdti->dev_opaques);
+    g_free(fdti);
+}
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index 3d8ec2f7ff..d204ceda43 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -9,9 +9,33 @@
 #define FDT_GENERIC_H
 
 #include "qemu/help-texts.h"
+#include "hw/core/irq.h"
 #include "system/device_tree.h"
+#include "qemu/coroutine.h"
+
+typedef struct FDTDevOpaque {
+    char *node_path;
+    void *opaque;
+} FDTDevOpaque;
+
+typedef struct FDTMachineInfo {
+    /* the fdt blob */
+    void *fdt;
+    /* irq descriptors for top level int controller */
+    qemu_irq *irq_base;
+    /* per-device specific opaques */
+    FDTDevOpaque *dev_opaques;
+    /* recheck coroutine queue */
+    CoQueue *cq;
+} FDTMachineInfo;
 
-typedef struct FDTMachineInfo FDTMachineInfo;
+/*
+ * create a new FDTMachineInfo. The client is responsible for setting irq_base.
+ * Client must call fdt_init_destroy_fdti to cleanup
+ */
+
+FDTMachineInfo *fdt_init_new_fdti(void *fdt);
+void fdt_init_destroy_fdti(FDTMachineInfo *fdti);
 
 typedef int (*FDTInitFn)(char *, FDTMachineInfo *, void *);
 
@@ -32,6 +56,22 @@ int fdt_init_compat(char *, FDTMachineInfo *, const char *);
 void add_to_inst_bind_table(FDTInitFn, const char *, void *);
 int fdt_init_inst_bind(char *, FDTMachineInfo *, const char *);
 
+/*
+ * Called from FDTInitFn's to inform the framework that a dependency is
+ * unresolved and the calling context needs to wait for another device to
+ * instantiate first. The calling thread will suspend until a change in state
+ * in the argument fdt machine is detected.
+ */
+
+void fdt_init_yield(FDTMachineInfo *);
+
+/* set, check and get per device opaques. Keyed by fdt node_paths */
+
+void fdt_init_set_opaque(FDTMachineInfo *fdti, const char *node_path,
+                         void *opaque);
+int fdt_init_has_opaque(FDTMachineInfo *fdti, const char *node_path);
+void *fdt_init_get_opaque(FDTMachineInfo *fdti, const char *node_path);
+
 /* statically register a FDTInitFn as being associate with a compatibility */
 
 #define fdt_register_compatibility_opaque(function, compat, n, opaque) \
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07578D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd7-0001dI-OI; Mon, 26 Jan 2026 12:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcg-0001Jw-VX
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:36 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQce-0008Ub-2v
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:33 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso3716864f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449409; x=1770054209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8yNhC/wLEa7fASbIBAu9wYYVDvJXbZkz7Puc+eeldo=;
 b=DRti4nUwdfm6hfILt0DbDlDQ7H9se688vk+JFIh84WTil5eOcOcjQxV/IobyfcsWsv
 zwHI71bXjX/R0rC7LvAyw8iiUuOiqnMrNGNziZ8hhSjvI/TUlWiTC5K5geeWzz7pBDr/
 lQhKtGZUIcXeak+DQ/yjqwE54XhumM6TVK9gvfsZabRPYbhF9pqWuyznHibEDPNKdhDm
 MbrlCrmNqMKPu8EQvmi4UCYWr/VtYWKlQuDUFHnsUJ9GhiNRfcGbsDfNKKVxorZKV0t6
 //2IwHE3Evq0RoOrIbKHEKUwuTzCEBgTcRv76Iky/chwsB3PEPl7r+76NKpOuGVR8OsZ
 td/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449409; x=1770054209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8yNhC/wLEa7fASbIBAu9wYYVDvJXbZkz7Puc+eeldo=;
 b=XSmUXG9msuUWfg9PPd3wrTr7HswqkJ+IUO7dczWTuvjA/RzH070hWSbZ86watwURFQ
 YR3wU/1jvJbp4NMzz8MDgbFsi+3QmEmb8BKmrqmw01LxcuWfaknsHfzqffTHMj0sswvY
 oykRaSiDeYDZpvZPhiQHSZLwUYI5vYXhxakIbjiGSccRNK69B+jEHvj9vAvnpSTgFOE0
 jkgRCI96oXtFf4hkwkHrwFXOIB+5BJ5nfbL3R7ZsHAXXqeNxNYMltKS7fFpLngZ0UPDW
 9ItQkDgA+SNFQ/qrIxzkzN+uwu0TVrLV5POVt+zpdCNs7tWB7IR7g7D+OBETS3/cOZOk
 vG1Q==
X-Gm-Message-State: AOJu0YxcZ149f9N4SaMtuC/8z9AGEjqssCJsOKuKEpmKtl4CYSoHIEUD
 KOiPumlwDTLnoaEXYoKCG7yeE3O8/bjNkK5C/8E3IkOUc+8c0v5QXJzLZ4oTHwuzcys=
X-Gm-Gg: AZuq6aLHgmHLILQc1S8qi1ZPxHoMOydJBiDlooaPGXqH0LqtjkRt2JJlmVsmpaFavT6
 O19RLVAbnRRIgI3g2roFhIjOlYLGaPZ7/8t0VSmCnjJSFzzlOZT4JAPcJR1beO1/HUDwLe+/RRf
 WuVklF0UN4pnz2qZl6Y65onoPFa4/zw7Z1Kh4NLFxjghnZ//gnOlE1k5bscWKAWjayugQqRfCJL
 8G2dUhp2nDRjjadKfwyppKm69M4kR8t8UtoPH/I/RA+znEzNqFYF+6YHd50Qku4zlbU4YYev05g
 z6byvPrsFGD3OMv1f+EFZBV0lJAXZAA/Gu/MljBvw478sMfCeRS5OHgrQcPVhmrfNJ18QbB0+z7
 rgkSedmThvFJe5V8l6vH/UknfYiB949EHLoojiybPcR4dzDiOBaMcpK1SsBDMrYe3kYShPeKq6P
 wO7p99Ior2zMXumx+q6un3gO87lrrgYkxBCk31KyCbdD3voh/fZUxk3g==
X-Received: by 2002:a5d:448e:0:b0:435:96a1:ee4d with SMTP id
 ffacd0b85a97d-435c9b1af20mr6651340f8f.14.1769449409218; 
 Mon, 26 Jan 2026 09:43:29 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:28 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 05/27] hw/core/fdt_generic: implement FDT machine creation
 helpers
Date: Mon, 26 Jan 2026 18:42:51 +0100
Message-ID: <20260126174313.1418150-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x444.google.com
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
 hw/core/fdt_generic.c         | 70 +++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h | 26 ++++++++++++-
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/hw/core/fdt_generic.c b/hw/core/fdt_generic.c
index d3ab8f9132..b3ef0b7d0a 100644
--- a/hw/core/fdt_generic.c
+++ b/hw/core/fdt_generic.c
@@ -28,7 +28,10 @@
 #include "qemu/osdep.h"
 #include "hw/core/fdt_generic.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/coroutine.h"
 #include "qemu/log.h"
+#include "system/reset.h"
 
 #ifndef FDT_GENERIC_ERR_DEBUG
 #define FDT_GENERIC_ERR_DEBUG 0
@@ -137,3 +140,70 @@ void dump_inst_bind_table(void)
     printf("FDT INSTANCE BINDING TABLE:\n");
     dump_table(inst_bind_list_head);
 }
+
+void fdt_init_yield(FDTMachineInfo *fdti)
+{
+    static int yield_index;
+    int this_yield = yield_index++;
+
+    DB_PRINT(1, "Yield #%d\n", this_yield);
+    qemu_co_queue_wait(fdti->cq, NULL);
+    DB_PRINT(1, "Unyield #%d\n", this_yield);
+}
+
+void fdt_init_set_opaque(FDTMachineInfo *fdti, char *node_path, void *opaque)
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
+int fdt_init_has_opaque(FDTMachineInfo *fdti, char *node_path)
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
+void *fdt_init_get_opaque(FDTMachineInfo *fdti, char *node_path)
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
index 614a234868..a21e3c2440 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -8,9 +8,33 @@
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
 
-- 
2.43.0



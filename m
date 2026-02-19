Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0509DE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt57B-000055-5O; Thu, 19 Feb 2026 09:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt579-0008VH-NT
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt577-0002wn-H3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so10837325e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511684; x=1772116484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8yNhC/wLEa7fASbIBAu9wYYVDvJXbZkz7Puc+eeldo=;
 b=VKybzSFbYkj8TvtwYVtaCrax9hwcD+qj5SmZ5R68QDu/GQHsh86pvLQt04TEaHtdsE
 FvEicCpnz7o1dF4a3pQMOfnN5tIuDsVR/Yp2p8xJO8aBQ0wOp17ALHI3li9C4r3OGhMS
 9lU8zSJScJRSJ8bGDHHYkTV13euw78qfP+9xcH1uSDCNKa1Sol+/Ce5/t7tKEmWKPB1v
 2WRrSVNY6+yQ+bqIeSlAkcmLgbUzxF+7fiho6258jhHjNkkaWKY8WSVpfCBcRZP+eojs
 wcoWwJSHCdc1D+maZ6Q8Oy3u1k2vrdaBY1GmAIXmqZV7gg3maEUycPW+6y3Qv82HsGyQ
 lNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511684; x=1772116484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8yNhC/wLEa7fASbIBAu9wYYVDvJXbZkz7Puc+eeldo=;
 b=C6FVz/apCIFi7iOqCE8lgZiSWUD6FkrceQOYYxIu8uLZXV+zVfwIypgBQW9dRkB0fN
 wATqaw/nZv5q7KiLDR8W/ZbUxEXzmoCIOblHjGkt9MhHcPhS6U1SKNpwbMW/0+EMMEnD
 z7ayZRK/MrFCXpiDDd/HlVL1R98CbAuBJYAZ1Y3+vtMcKtJWQHgrl9/q/g7QVcXCSjUh
 +qCA6+md0w5dGit1Yv1FI44hjRNhD/0cU7xuDnCXKPmCcV3Bl0Fcy2QR4HxdoyP0FIFc
 ZfwX9t024QFepfTU1CDxBCacnhehKHUYRuOgp9mft8rp423YJ07+/o5XX0wi7Sesa5xy
 lzEA==
X-Gm-Message-State: AOJu0YyNgwSBTtuLyofFl70VoM4NGBVsY+dGqGu6ARZu//nijqBErFet
 RCRWTNGzQ5HzLFC2FjrzST33mw1NuEagXtV/HcPsfsOBtBYu/eTWUAaotUfEaIqbcZY=
X-Gm-Gg: AZuq6aI49Qqf5PRc/uNjznJZwkQHN6M0fcWP0UKgY47YTU9HkhZONynXKICF0xQnLKb
 aucz1WrJxJkJpnzlUUqHkkq5j8axZocicf6GzJvnk9RoetHOogQh77pPp/TDabBC/zJ3zLx+ZxV
 klplr/2g0NBmTh2cyIyZczmnQqdmYH2oxTMWBP93gZ7XROlYvZN+l2wsvpxInmrJvb4YJnmqRdH
 v+VaTp7KJku3P9pvrSYoFY5EdgdSCyfsK3bTnWxqd34yRMErYOqdp89z8XaYELeJBhe8FXtRM2L
 FwE9D1ZP71AOtcPpKo5/fn0TH39LTwJtm+i3vyWqWgfyWqYiBkoadOkXjQXcOROJJ0uAMygTDdh
 PtXsu35tV92YrbFiS253JCK4RbFuiwu+htWVo+6Cfh9rGEz4d7gUXhH/y8LnMzgs+CxwVMVjL/A
 gsWHmfBgH9CA/R+wPnAxRGFgtKfnXl1Os40nyp1nT7J5yCTU8CmPosXMd19EXU329cTSzAwkYSh
 ZRh04U=
X-Received: by 2002:a05:600c:1da1:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-48371085905mr361369525e9.22.1771511683632; 
 Thu, 19 Feb 2026 06:34:43 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:43 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 05/33] hw/core/fdt_generic: implement FDT machine creation
 helpers
Date: Thu, 19 Feb 2026 15:33:04 +0100
Message-ID: <20260219143332.3316679-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x341.google.com
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



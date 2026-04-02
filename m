Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBC0D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q3A-000137-Fv; Thu, 02 Apr 2026 17:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2m-0000IY-7F
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:40 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2j-0007HS-Co
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:38 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso189496166b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167055; x=1775771855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oujEPxX53I9dv7z2k7DZb4M01rXo06zxwhP7XQBPers=;
 b=E3QsiglyqzSGEBIUujyHcbOv9bFMgt/YeONixxn4vJG3m9vPK4FJc4GMFx5AEzaNNk
 AXHkgx+TZBNSNkdUgoAnfvKZS1uau+sZUK6LBSrIW14a7xwLYdARC3Z4kYq1sZXQSDWz
 KD7uobaQw0MRltFbEBgC9+d5JH/kZN8j+iQa/Q18UVCTkbX6WfrjN9eODgAXacNmduiQ
 aVW9atAywUxMEaKzVf6YhRJ+EpXrxVOeGL7x2f0WVwSJd0+IsKpgWn1255H6B0UnZc5j
 vV4OVSmgaygZShFUL/+nR0z3ynYB6s6gtO1QjZPmZKIYobW9EEH6BqDGyt18kcrf7FCM
 sDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167055; x=1775771855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oujEPxX53I9dv7z2k7DZb4M01rXo06zxwhP7XQBPers=;
 b=sVICDpShMAV4DHDfHB+XYkdP6ljzHePSN+rFfu24U+n0nsqwM/sOhFdupz4CrReQ6I
 abSL/YGHgAiXbqfcn3f6KYtc4ojhdtdA5ftZYvaEbtR0QME5lvwfuxyScnfDaov8M2b/
 UsnqCuEej5eGNG9Azp3pd4T76bTpnCRpV2P92tB/VKvN6ce5BrnvhxgcEXNIrmYnaC8D
 62u/U8AsygqejXbnh+sXi0lTxhQbdsRyMHkCdKgKNhvk9IhijNJvoyF8kLKvfn8PLKCs
 zAk6PsgABjnoY9tiBIj/Wu6K+d5k6br1Xzsk1UINDvqMQU0b6/CMMoZ57S8phVUR1Bt4
 h/Jg==
X-Gm-Message-State: AOJu0Yz7WQ4zFvIyP2/hE67Xfrd0WndcY5gOIpyDSqxXmMnG70PC5QRJ
 YvcfaK0O42B9c83CRhmMG7EYz/dc2HtypNomDl8AF/rTMgi2ekldZ7XofsLt11ew
X-Gm-Gg: ATEYQzwJDgYogeFwvKwx3hm8YXFQA+tIBsHyPLYjY6tM9faGHk1UNSktJemBDLTLJMz
 b8YkUkUCXkmBwYwv5D0pNJQOz/MkbnwPRYLe9H5HrrRyde6o563atxeNmQteKPccS3XFjRSG6x2
 eCo/FbNHNxcVedKoZIQrkBKVWSVxEq+xGC7bfhGXgKFuoAUl00mjYZKAbYFovSfTO0t9dJCdWsJ
 FUBoDh9aDbHuXpeNJpXneL8p3oT6lSh0XaKF7pL2neISM2leWywJV9uUHNGEaFlnH0mkH7V6Mwq
 2uC0igo4GWwxq/JelpfevhO7hAAonQBpUeuMwjJraDc5fW6orUEfwTvxY4NMGDifbnixXE0z9HA
 LfsCqwLkPHw7baj+ZFHSN7FH38kZzv8/74pg+3o632uQi+M979I41Wvaj3q878mEnRmBZud9kCS
 Fng2O0H3ryvKoYROYj392cnhHJhcYi+NZADlRKFN0/HxhqBCFAzhofwDbFQ/BUIJ58XWF0cQ==
X-Received: by 2002:a17:907:1c13:b0:b98:4246:8e6e with SMTP id
 a640c23a62f3a-b9c67b9c30bmr24678366b.53.1775167055104; 
 Thu, 02 Apr 2026 14:57:35 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:34 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 30/33] hw/core/fdt_generic_util: Add deferred device
 initialization support
Date: Thu,  2 Apr 2026 23:56:15 +0200
Message-ID: <20260402215629.745866-31-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x632.google.com
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

Add a mechanism to defer device initialization
until after the main FDT traversal.

This introduces a deferred queue in FDTMachineInfo.
Devices in this queue are processed in fdt_init_deferred(),
which handles their realization, reset registration,
and resource parsing (interrupts and memory regions).

This allows resolving initialization where devices need to
be realized on latest stages or outside of co-routine context.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c    | 28 ++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index c92b5c287b..ae54ada11d 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -93,6 +93,13 @@ static bool qemu_irq_shared_or_handler(bool *inputs, int n)
     return false;
 }
 
+static void fdt_parse_node_reg_prop(FDTMachineInfo *fdti, char *node_path,
+                             Object *dev);
+static void fdt_parse_node_irq_prop(FDTMachineInfo *fdti, char *node_path,
+                             Object *dev);
+static void fdt_init_device_realize(FDTMachineInfo *fdti,  char *node_path,
+                                   Object *dev);
+
 static void qemu_irq_shared_handler(void *opaque, int n, int level)
 {
     QEMUIRQSharedState *s = opaque;
@@ -162,6 +169,26 @@ static void fdt_init_cpu_clusters(FDTMachineInfo *fdti)
     }
 }
 
+static void fdt_init_deferred(FDTMachineInfo *fdti)
+{
+    while (fdti->deferred) {
+        FDTDeferredNode *dnode = fdti->deferred;
+
+        fdt_debug("FDT: Deferred realize node: %s\n",
+                 dnode->node_path);
+
+        fdt_init_device_realize(fdti, dnode->node_path, OBJECT(dnode->dev));
+
+        fdt_parse_node_reg_prop(fdti, dnode->node_path, OBJECT(dnode->dev));
+
+        fdt_parse_node_irq_prop(fdti, dnode->node_path, OBJECT(dnode->dev));
+
+        fdti->deferred = dnode->next;
+        g_free(dnode->node_path);
+        g_free(dnode);
+    }
+}
+
 FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
 {
     FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
@@ -175,6 +202,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
     while (qemu_co_enter_next(fdti->cq, NULL)) {
         ;
     }
+    fdt_init_deferred(fdti);
     fdt_init_cpu_clusters(fdti);
     fdt_init_all_irqs(fdti);
     memory_region_transaction_commit();
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index 3961615a9c..2d507392fa 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -35,6 +35,12 @@ typedef struct FDTIRQConnection {
     void *next;
 } FDTIRQConnection;
 
+typedef struct FDTDeferredNode {
+    DeviceState *dev;
+    char *node_path;
+    void *next;
+} FDTDeferredNode;
+
 typedef struct FDTMachineInfo {
     /* the fdt blob */
     void *fdt;
@@ -48,6 +54,8 @@ typedef struct FDTMachineInfo {
     FDTIRQConnection *irqs;
     /* list of all CPU clusters */
     FDTCPUCluster *clusters;
+    /* list of devices for deferred init */
+    FDTDeferredNode *deferred;
 } FDTMachineInfo;
 
 /*
-- 
2.43.0



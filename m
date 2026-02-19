Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D11E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MR-000473-CJ; Thu, 19 Feb 2026 09:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M5-0003mN-Qa
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:20 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lx-00085v-Qz
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:10 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4359a302794so847448f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512596; x=1772117396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kotv4mGzhzG39NnElKpEZYatBNMpC+cFV0bOnYfhcf8=;
 b=amoPnJPXw2q6LfJRCPA8nMCvmNYWnqRwWnepQsj1zFLYefG8NrLw16SBGYjqAMO+DH
 Vziz15HQid+uaqN6lbIWK7JO3pyAgMwhQcKTxoqtDhXaqcSNeXDiSuhTMlWxTEbKdijK
 UspFaRYLhnxYnO8zAyZYHWSA2YEgvZgshIjavqXYTx/uqcKt3rAunQJZb9SNNH/2ieZV
 JQuuA2smZnUDyBZSyDuvR/7KEs80qWt/xD9ANj/Mii5nrc5GTEBPZX/jg1iquc1jrbPh
 qfKtLD+cNEG3iyHJaKKii/trGAvIAux3UaCGVBKsarTJsCHY/NAO3YxMeo3ZzoZ524Gy
 Vv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512596; x=1772117396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kotv4mGzhzG39NnElKpEZYatBNMpC+cFV0bOnYfhcf8=;
 b=kYcMk6Hk2k9imVeFRnFi8u0YoNIuq5lA0MEApbo5o9nAHqVow66TjRAZdRefQaswKp
 ESjyR3GsnvbDu15yTHyYKSqvojcJ4qyPcTn5VjPSP1QFUnEcZEiFn6RjY0ZZjRqn/HvU
 RsJFI4p0LWvQRbnb0bsLJfKCYgDuF1cgCqHI+NN76yn5W+AmcBkKpR3c70HRUSvAXHFX
 kg2JNmYhuX9TOpiD1cAbwOAr6WJULpc6lXYq3foOgYYBKujnyFTwbTuxjJ4njHxQmq1m
 N9D9Athcq7LAePKD+sbtes/aVrsb3gJtDgQ38NE3rCAiTTceVmWoxd+EwBHNC04gtw5S
 ZE4Q==
X-Gm-Message-State: AOJu0YwSVbG9svsaEZoZ+c8RD7/1ClBgJutnSIRLH3JYTmjsPvaQ65d2
 TRg3OQ10ClTosMNwrB1pjMDabOYlQk4ZPQ+bsw71Cqa2da+kJWZci89GN0vUzcLL
X-Gm-Gg: AZuq6aL21iSWVCCnufZX279T5nPhaABWvDbY1Q3jgi7s50hz0+F8aJKIMcxGdl9sTfx
 trJkZPaIwXadVhyJciQnXyQs/OmOcKCZCaZkWDUXmv671xnYV5lz8L3jPpZnMvnSQxcVdax6cbH
 8C+9UTXhepTPo5cT593qRsKu9R0phhdjlR5VWCtDjIQxislRRO9gDkkSAfC1sPzOVRvtIkjTHQE
 APJvNY21MvfzBi46SpFpHwNrSHNhqSIpKFX6pERphagkg/wkU9pg/FBx4ZcLRidJj3iGR2FZ+Kb
 sA742lOrG1s5zXy7zS1kthJMsz4ZvLdtA8qPPZfLFmm26vZNGrkvnRGkvTVW/Pez3g/HOv+l9Tz
 i4LdxWRj6ZfSwMrvKz83FuLkMi2DJffT/bq/Lq2pi9qRd+NLji7vgyc+s+Zb5nxc1RUi5IKCvxp
 U96/7gvA56h/9iPOb11N7uXThAWePml7ODVS+JnVP6IkBU63Cseyqv9R14PHO3B4JYfFVP
X-Received: by 2002:a05:6000:2c0c:b0:437:8ff8:fea3 with SMTP id
 ffacd0b85a97d-4379db66593mr31515861f8f.21.1771512595669; 
 Thu, 19 Feb 2026 06:49:55 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:55 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 30/33] hw/core/fdt_generic_util: Add deferred device
 initialization support
Date: Thu, 19 Feb 2026 15:48:58 +0100
Message-ID: <20260219144901.3317747-12-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42d.google.com
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
 hw/core/fdt_generic_util.c    | 45 +++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h |  8 +++++++
 2 files changed, 53 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index c58a9ccdc7..4ed9602d47 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -99,6 +99,11 @@ static bool qemu_irq_shared_or_handler(bool *inputs, int n)
     return false;
 }
 
+static void fdt_parse_node_reg_prop(FDTMachineInfo *fdti, char *node_path,
+                             Object *dev);
+static void fdt_parse_node_irq_prop(FDTMachineInfo *fdti, char *node_path,
+                             Object *dev);
+
 static void qemu_irq_shared_handler(void *opaque, int n, int level)
 {
     QEMUIRQSharedState *s = opaque;
@@ -168,6 +173,45 @@ static void fdt_init_cpu_clusters(FDTMachineInfo *fdti)
     }
 }
 
+static void fdt_init_deferred(FDTMachineInfo *fdti)
+{
+    while (fdti->deferred) {
+        FDTDeferredNode *dnode = fdti->deferred;
+        DeviceClass *dc = DEVICE_GET_CLASS(dnode->dev);
+        int length = 0;
+
+        int offset = fdt_path_offset(fdti->fdt, dnode->node_path);
+        if (offset < 0) {
+            error_report("%s Couldn't find node %s: %s", __func__,
+                         dnode->node_path, fdt_strerror(offset));
+        }
+        const char *blockdev = fdt_stringlist_get(fdti->fdt, offset,
+                                              "blockdev-node-name", 0, &length);
+
+        DB_PRINT(0, "FDT: Deferred realize node: %s\n",
+                 dnode->node_path);
+
+        if (blockdev && object_property_find(OBJECT(dnode->dev), "drive")) {
+            fdt_attach_blockdev(fdti, dnode->node_path, OBJECT(dnode->dev));
+        }
+
+        object_property_set_bool(OBJECT(dnode->dev), "realized", true,
+                                &error_fatal);
+        if (dc->legacy_reset) {
+            qemu_register_reset((void (*)(void *))dc->legacy_reset,
+                                dnode->dev);
+        }
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
     char node_path[DT_PATH_LENGTH];
@@ -183,6 +227,7 @@ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
         while (qemu_co_enter_next(fdti->cq, NULL)) {
             ;
         }
+        fdt_init_deferred(fdti);
         fdt_init_cpu_clusters(fdti);
         fdt_init_all_irqs(fdti);
         memory_region_transaction_commit();
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index ad9e249156..dc2d7a8876 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -34,6 +34,12 @@ typedef struct FDTIRQConnection {
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
@@ -47,6 +53,8 @@ typedef struct FDTMachineInfo {
     FDTIRQConnection *irqs;
     /* list of all CPU clusters */
     FDTCPUCluster *clusters;
+    /* list of devices for deferred init */
+    FDTDeferredNode *deferred;
 } FDTMachineInfo;
 
 /*
-- 
2.43.0



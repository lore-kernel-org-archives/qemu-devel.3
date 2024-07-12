Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996B5C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0i-0000Y9-9t; Fri, 12 Jul 2024 08:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0a-00085M-T3; Fri, 12 Jul 2024 08:04:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0W-0005nF-Kt; Fri, 12 Jul 2024 08:04:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b0ebd1ef9so1492684b3a.2; 
 Fri, 12 Jul 2024 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785850; x=1721390650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjHzbLt8jHoeH3N+MwM+HnAEB76eFaxTqHRzPHz1NO8=;
 b=OpZlBS3TqTqxs+d7sKmq0JAFqHOsxiHcM0g7M2DEb/m7yjxXIi+e1bxfwOA6d13APK
 6mQiabVwmSFcJdl5w4RDO4BBKNMR7fwH65AoYwrckMbLb0mMdju87E1obe86GU0CCPzn
 NyiRt2MQ16mk1ByEUp3UXEDXHtLaDWPcVHUtgZ9peotOjT2B0/5KLf3Orerskwt5Pa/e
 be2HzEFGepZMqUCj3CNwtm6beE9RprtlUcJOk0HT6Y/kxM6XCfR/i0vHXwGQw9JNKVCG
 SxmTbWhL0I5xzLzyOke2+2lDRVH8tauo3fTtmlOj5XXfi5pxMJA1zUg3jK+aG3ccX1BD
 NIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785850; x=1721390650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjHzbLt8jHoeH3N+MwM+HnAEB76eFaxTqHRzPHz1NO8=;
 b=JB5sIueO4lFUYLqboJ4GQqpfaxpPF4fq8QTfq1n5hx44QuSVQYVL0twS6CeAjjQetP
 qDcDaGYg6EN/zdME9HfZ775mn6olgbARVQu2Y3vEtCo0zxaKMITY6bdBjSQCJAzCg/8n
 XLcBx4VT0V1rI/g2n3yq3him8/TFAzNTpkAyZtExJphqiGK1Qfcih6EOM8rhVPcxysLU
 g7v5xl0dEfm6xtDlp8GeyemYOLAFSKcpzETxICOOlwUNU9h79JDfa9jELf0sDWs4y8Am
 3QAKfA845+lT+ujlxXD/yWsnZiotLUaHGeX0RLTVBOP+TG2127ymIO39cfpIgzi/Wrcs
 nxQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz+4nGvIMu44emu7x015MYxu0DTLX93Rlb+Bxv/KXT4n/g6BB6I770OigPR+TOtZ+ODvZd0bmotENWSTI5VbruseyGVNA=
X-Gm-Message-State: AOJu0YwZok8lo8FzaWt7NEGN+921Szkl2VcHoGE3oO3eVIE+tKhOD8ti
 MXN9c1hvYP7vZ1Q4OUrq9t49To8oQKJLvzcZy8TkSQ+3p4VNYrzgEvjfXQ==
X-Google-Smtp-Source: AGHT+IGFwoNCbZqWaPSonUMwf0Z/Vn7mJfbc5VAjopuBH3wEtoZBVBbg3UCataG7O6UZUtwFTpBAyQ==
X-Received: by 2002:a05:6a00:1955:b0:70a:f5c5:135d with SMTP id
 d2e1a72fcca58-70b43667750mr12801681b3a.32.1720785849619; 
 Fri, 12 Jul 2024 05:04:09 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 11/19] ppc/pnv: Add allow for big-core differences in DT
 generation
Date: Fri, 12 Jul 2024 22:02:38 +1000
Message-ID: <20240712120247.477133-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

device-tree building needs to account for big-core mode, because it is
driven by qemu cores (small cores). Every second core should be skipped,
and every core should describe threads for both small-cores that make
up the big core.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 555a983536..fdf66323b8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -141,9 +141,9 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
-    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
+    uint32_t *servers_prop;
     int i;
-    uint32_t pir;
+    uint32_t pir, tir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = PNV_TIMEBASE_FREQ;
@@ -154,7 +154,10 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, NULL);
+    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, &tir);
+
+    /* Only one DT node per (big) core */
+    g_assert(tir == 0);
 
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
@@ -235,12 +238,28 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     }
 
     /* Build interrupt servers properties */
-    for (i = 0; i < smt_threads; i++) {
-        pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
-        servers_prop[i] = cpu_to_be32(pir);
+    if (pc->big_core) {
+        servers_prop = g_new(uint32_t, smt_threads * 2);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+            servers_prop[i * 2] = cpu_to_be32(pir);
+
+            pnv_cc->get_pir_tir(chip, pc->hwid + 1, i, &pir, NULL);
+            servers_prop[i * 2 + 1] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads
+                                        * 2)));
+    } else {
+        servers_prop = g_new(uint32_t, smt_threads);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+            servers_prop[i] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads)));
     }
-    _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
-                       servers_prop, sizeof(*servers_prop) * smt_threads)));
+    g_free(servers_prop);
 
     return offset;
 }
@@ -389,6 +408,10 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_300, sizeof(pa_features_300))));
+
+        if (pnv_core->big_core) {
+            i++; /* Big-core groups two QEMU cores */
+        }
     }
 
     if (chip->ram_size) {
@@ -450,6 +473,10 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_31, sizeof(pa_features_31))));
+
+        if (pnv_core->big_core) {
+            i++; /* Big-core groups two QEMU cores */
+        }
     }
 
     if (chip->ram_size) {
-- 
2.45.1



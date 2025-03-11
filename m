Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52FDC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJ0-0003Rl-2y; Tue, 11 Mar 2025 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDi-0004sr-5x; Tue, 11 Mar 2025 09:00:42 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDc-0008Lt-JW; Tue, 11 Mar 2025 09:00:29 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so10792609a91.3; 
 Tue, 11 Mar 2025 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698016; x=1742302816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NFBpDCgw8d0BEXG761d1mgdF1JZURhwF8ApqY/UDtY=;
 b=PGc90jcxSmvqXURPRKwYdAgyLdM+WmjwRvILUPHG3UwzCH7dw/z+k+F8aZsnKN7tIA
 dNKtQV1Hkpm0LLlfjFSievC7lOfzThmq9Rt8elpwjnF0aiGipwSE/FRmwveYz7SN3Qgv
 hnNKcpU5yzfgbXDWO4DS33ztXkVfjfD9POmAOQ4dmtTTclw2FayfEHA1keWE+7V5Mtcq
 rt5KzJg3KP5I/4FJb/ygmL8/ZJkVx1KjCNdK0r1oR/ecP20BCCxRFJk4jiCxoztAls04
 lY14HPsvpPJOSi+JkVm0xnQb/rLP0cMgPF8eM+Y4fIwUBA94zv0F9MaAkHMqXlqe9d75
 9AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698016; x=1742302816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NFBpDCgw8d0BEXG761d1mgdF1JZURhwF8ApqY/UDtY=;
 b=ddPNVrfO4UPp8HltRS7xVFVzHI18FGVOE4jgqsXGo7a+3R4tBtA2OexxJPfiW7f7Rm
 pWXj9i2sQ8Uscb0kEE/38gOjr81RqmYBHY0qJaIuJUozq48ZVe1iKrSPlkYFBBLcYTb/
 IfgxH01lzfgGt4ftf1vEpPsnyAtss86Ov2rWnS21u3bQs3CPbb0fh4gaOMyJjJRrXXAX
 XSiREtFr1m/nc1mqIU70Z3TUj7BMMjFQiFnAIHiqXjVlFUJKYw9VfoL4Hw6KoFVSl810
 mS0n8qTD/CBDNBfLj1XtGHnwqD+kJfWfC9S2v7V+xdRCu2DqHGGnXrVsrEhWNEKNpaHx
 SvRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUfzyHkhQQPSpmfxZ2KDKI2l47DUMI8IdAM5LvWb4TmRjuNSE4ePXPARaQERDsHe9THoup3lBlqg==@nongnu.org
X-Gm-Message-State: AOJu0YwABmbfYbFUcgho14LnjiQQiMUqroxXl+Ok10gGP32jksE5MxUZ
 x4cvUhTsSTRRXHQShX8EWD8/js0afcO7XnCOGit3R0EvVEAooXPJDiP/vQ==
X-Gm-Gg: ASbGncvdsuJX1orqFL0Dm14hz7+Yg2KPGHpcM5sbB+QtXYHeCBDAyWXQxRwMCBP7mcz
 XQ1WsGMI0PO/WMSWARVn2QYcrQNlMUndhsaHrCRHbv6OZ7VI7Sog1c/4uzZuvKWgNA2trAM7FBM
 89jDvaAq4+cPbSUB9h3KYPhup4UmE7HnkZV+4OBI/moRP4lM1e+i/G7c9IbU7eHz3n45cZ+TZY/
 a5lucpcIzJHprd68oQ1IdDbh4mlAS/WukqlUDRH00puDUKhwfsWR25cGtxFXoPO5H60IupqStEJ
 PwTBp7Y3nN8p7/oNYP0jSWWSDUJ3jG2qPIGv5jFhIavm/j0mye0=
X-Google-Smtp-Source: AGHT+IF43HxN2P31K8G+t/cSb3/L+nf1oz6ZZpz33m3yXYQtvJY/YH4lsoJRQnrudacpP+fLG3ehKw==
X-Received: by 2002:a17:90b:1d0a:b0:2fe:a614:5cf7 with SMTP id
 98e67ed59e1d1-2ff7ce7b451mr24523889a91.3.1741698015593; 
 Tue, 11 Mar 2025 06:00:15 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 35/72] qtest/xive: Change printf to g_test_message
Date: Tue, 11 Mar 2025 22:57:29 +1000
Message-ID: <20250311125815.903177-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

Change all printf() in pnv-xive2-* qtests to g_test_message()

[npiggin: split from pool qtest]
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/pnv-xive2-flush-sync.c |  6 +++---
 tests/qtest/pnv-xive2-nvpg_bar.c   |  7 +++----
 tests/qtest/pnv-xive2-test.c       | 22 ++++++++++++----------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/pnv-xive2-flush-sync.c b/tests/qtest/pnv-xive2-flush-sync.c
index 3b32446adb..142826bad0 100644
--- a/tests/qtest/pnv-xive2-flush-sync.c
+++ b/tests/qtest/pnv-xive2-flush-sync.c
@@ -178,14 +178,14 @@ void test_flush_sync_inject(QTestState *qts)
     int test_nr;
     uint8_t byte;
 
-    printf("# ============================================================\n");
-    printf("# Starting cache flush/queue sync injection tests...\n");
+    g_test_message("=========================================================");
+    g_test_message("Starting cache flush/queue sync injection tests...");
 
     for (test_nr = 0; test_nr < sizeof(xive_inject_tests);
          test_nr++) {
         int op_type = xive_inject_tests[test_nr];
 
-        printf("# Running test %d\n", test_nr);
+        g_test_message("Running test %d", test_nr);
 
         /* start with status byte set to 0 */
         clr_sync(qts, src_pir, ic_topo_id, op_type);
diff --git a/tests/qtest/pnv-xive2-nvpg_bar.c b/tests/qtest/pnv-xive2-nvpg_bar.c
index 028512bddc..6ac8d36c82 100644
--- a/tests/qtest/pnv-xive2-nvpg_bar.c
+++ b/tests/qtest/pnv-xive2-nvpg_bar.c
@@ -4,8 +4,7 @@
  *
  * Copyright (c) 2024, IBM Corporation.
  *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * later. See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 #include "libqtest.h"
@@ -78,8 +77,8 @@ void test_nvpg_bar(QTestState *qts)
     uint32_t count, delta;
     uint8_t i;
 
-    printf("# ============================================================\n");
-    printf("# Testing NVPG BAR operations\n");
+    g_test_message("=========================================================");
+    g_test_message("Testing NVPG BAR operations");
 
     set_nvg(qts, group_target, 0);
     set_nvp(qts, nvp_target, 0x04);
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index a0e9f19313..7e7b1e79c0 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -4,6 +4,7 @@
  *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
  *  - Test irq to hardware group
  *  - Test irq to hardware group going through backlog
+ *  - Test irq to pool thread
  *
  * Copyright (c) 2024, IBM Corporation.
  *
@@ -220,8 +221,8 @@ static void test_hw_irq(QTestState *qts)
     uint16_t reg16;
     uint8_t pq, nsr, cppr;
 
-    printf("# ============================================================\n");
-    printf("# Testing irq %d to hardware thread %d\n", irq, target_pir);
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to hardware thread %d", irq, target_pir);
 
     /* irq config */
     set_eas(qts, irq, end_index, irq_data);
@@ -278,8 +279,9 @@ static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
     uint32_t cl_word;
     uint32_t word2;
 
-    printf("# ============================================================\n");
-    printf("# Testing 'Pull Thread Context to Odd Thread Reporting Line'\n");
+    g_test_message("=========================================================");
+    g_test_message("Testing 'Pull Thread Context to Odd Thread Reporting " \
+                   "Line'");
 
     /* clear odd cache line prior to pull operation */
     memset(cl_pair, 0, sizeof(cl_pair));
@@ -330,8 +332,8 @@ static void test_hw_group_irq(QTestState *qts)
     uint16_t reg16;
     uint8_t pq, nsr, cppr;
 
-    printf("# ============================================================\n");
-    printf("# Testing irq %d to hardware group of size 4\n", irq);
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to hardware group of size 4", irq);
 
     /* irq config */
     set_eas(qts, irq, end_index, irq_data);
@@ -395,10 +397,10 @@ static void test_hw_group_irq_backlog(QTestState *qts)
     uint16_t reg16;
     uint8_t pq, nsr, cppr, lsmfb, i;
 
-    printf("# ============================================================\n");
-    printf("# Testing irq %d to hardware group of size 4 going through " \
-           "backlog\n",
-           irq);
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to hardware group of size 4 going " \
+                   "through backlog",
+                   irq);
 
     /*
      * set current priority of all threads in the group to something
-- 
2.47.1



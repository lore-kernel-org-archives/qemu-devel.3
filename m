Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5762FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzEg-0005UY-5M; Tue, 11 Mar 2025 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDQ-0004Lp-1C; Tue, 11 Mar 2025 09:00:15 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDH-00084T-Ld; Tue, 11 Mar 2025 09:00:10 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so1881870a91.0; 
 Tue, 11 Mar 2025 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697999; x=1742302799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWZ6jXzWeTg9f0TMcRn568DCYUVFZ/Q8jdAM6fw8ow0=;
 b=U1bfh1OOCKIZzbHXzVSR4BpSIYP2qUSkVsw3KG0t/WE50B5KkPh0MbOK3BrsVRoT4K
 8KtL2XLs9d4QtKzvuHx6h/3kZCKBD9F30A9qo2IhnDBtztOXc0R1gppsrMoPnwUWV7qI
 2i0E/Eto/uZr/dPkVwDslT2eMOFKg04VOfCbs0Y7GbmKvlNeVN00UNOiRGlliyR66UXR
 Adul+2e+oynEd2lrVIIBNeBMldeuow6xfNPE0k061bC0JEU5JV8GNcFDojAJPwBTFsnn
 Y5D13qSOH+5T8MdvN2AUlz8wbp59WWGVpBr8AtuZqci6nYL2TKfDaLOJeLoERCMo2rQG
 A1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697999; x=1742302799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWZ6jXzWeTg9f0TMcRn568DCYUVFZ/Q8jdAM6fw8ow0=;
 b=L661rPbGNnbiPXpxNvqMMlfl29XlzUrh/CJvl7G23178qsaJmQ+b1va2GBDlQq9Noz
 AK5fCBw4muRAf9cy+TDCB96VLV+vFn0K/cDsNoit4ieTlMhDaqIZlhxD++cEwIA/YcmD
 eNxTCy+T23Np9RUYRipfIzmEtB8grcj+ORENzB/dgoufZSMS8wGAWF8sFFh1hBAiboVg
 2K66T8FW4lauE/Uvk1RjwMzlQsr7N88CLM3+hQH4jtpBOabObm8POf7dGe06okCCBQpE
 ZEaiSJT0VHesg3BMoMXe4MCRv+HnyGQiARtN+vyw+z0V1NOeEFhcVFXY+9oE7TZNIlu1
 mqHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7eYhW58Rrek6Z+EMOTfCrpcDiQVEXZh3JofbVJZPTXRENNwuH7iP7vMGzvcwTEOTFAWFxamAQKQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw3fri5JD9Mpf3NUjOGQe395nSxQxFifCbdN4qHX8+ms69XB6C4
 hLYHFBL+FFBROHPY1sMdndqu3ykwzqKhRW+kpK0RY2QcAgPQobQjvAtXLA==
X-Gm-Gg: ASbGncsdJsoSS8EJQSSFtJyIuHBc/YC4ctbaTjfOJQc0PC9/CG5mtlu9HVzdLYn2DTI
 vw0BUPvno7UXTm39m5ehtSeW6RyWdD+eXGoeAZmezAG0iy2m5IPJNCBPU1gukWMuvU29lcJmkzM
 qJBJ+9vSKV991gf4GgeRNa3kAMmbcMJH5n71txYCzBDBDaAbUOXF3heZEGnJysI3VuHA+YfKtUC
 SM6S+Y/qjvnsPO4Z97bAUgdz4PoLxIzj8/Isu44AAGUQpSk736Fna1P+JnGOyFKbFdF1/RAyiUi
 7imclgU1EG7bbYXz1TE6XrukurrysOeasOdSwCls/xfng1+MWm4=
X-Google-Smtp-Source: AGHT+IFis6Ard7BrObSIFYYxBdA/Z2a3tRl3ETjHPZW5AOeookzEcW5d3AEBe22dGlAf8OZzt0TyTA==
X-Received: by 2002:a17:90b:264e:b0:2fe:a336:fe65 with SMTP id
 98e67ed59e1d1-300ff0ca8c9mr4849182a91.10.1741697999464; 
 Tue, 11 Mar 2025 05:59:59 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 30/72] qtest/xive: Add group-interrupt test
Date: Tue, 11 Mar 2025 22:57:24 +1000
Message-ID: <20250311125815.903177-31-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Add XIVE2 tests for group interrupts and group interrupts that have
been backlogged.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/pnv-xive2-test.c | 160 +++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index dd19e88861..a4d06550ee 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -2,6 +2,8 @@
  * QTest testcase for PowerNV 10 interrupt controller (xive2)
  *  - Test irq to hardware thread
  *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
+ *  - Test irq to hardware group
+ *  - Test irq to hardware group going through backlog
  *
  * Copyright (c) 2024, IBM Corporation.
  *
@@ -315,6 +317,158 @@ static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
     word2 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD2);
     g_assert_cmphex(xive_get_field32(TM_QW3W2_VT, word2), ==, 0);
 }
+
+static void test_hw_group_irq(QTestState *qts)
+{
+    uint32_t irq = 100;
+    uint32_t irq_data = 0xdeadbeef;
+    uint32_t end_index = 23;
+    uint32_t chosen_one;
+    uint32_t target_nvp = 0x81; /* group size = 4 */
+    uint8_t priority = 6;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr;
+
+    printf("# ============================================================\n");
+    printf("# Testing irq %d to hardware group of size 4\n", irq);
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, true /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    /* find the targeted vCPU */
+    for (chosen_one = 0; chosen_one < SMT; chosen_one++) {
+        reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+        nsr = reg32 >> 24;
+        if (nsr == 0x82) {
+            break;
+        }
+    }
+    g_assert_cmphex(chosen_one, <, SMT);
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, 0xFF);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, chosen_one, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+}
+
+static void test_hw_group_irq_backlog(QTestState *qts)
+{
+    uint32_t irq = 31;
+    uint32_t irq_data = 0x01234567;
+    uint32_t end_index = 129;
+    uint32_t target_nvp = 0x81; /* group size = 4 */
+    uint32_t chosen_one = 3;
+    uint8_t blocking_priority, priority = 3;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr, lsmfb, i;
+
+    printf("# ============================================================\n");
+    printf("# Testing irq %d to hardware group of size 4 going through " \
+           "backlog\n",
+           irq);
+
+    /*
+     * set current priority of all threads in the group to something
+     * higher than what we're about to trigger
+     */
+    blocking_priority = priority - 1;
+    for (i = 0; i < SMT; i++) {
+        set_tima8(qts, i, TM_QW3_HV_PHYS + TM_CPPR, blocking_priority);
+    }
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, true /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    /* check no interrupt is pending on the 2 possible targets */
+    for (i = 0; i < SMT; i++) {
+        reg32 = get_tima32(qts, i, TM_QW3_HV_PHYS + TM_WORD0);
+        nsr = reg32 >> 24;
+        cppr = (reg32 >> 16) & 0xFF;
+        lsmfb = reg32 & 0xFF;
+        g_assert_cmphex(nsr, ==, 0x0);
+        g_assert_cmphex(cppr, ==, blocking_priority);
+        g_assert_cmphex(lsmfb, ==, priority);
+    }
+
+    /* lower priority of one thread */
+    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, priority + 1);
+
+    /* check backlogged interrupt is presented */
+    reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, priority + 1);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, chosen_one, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    lsmfb = reg32 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+    g_assert_cmphex(lsmfb, ==, 0xFF);
+}
+
 static void test_xive(void)
 {
     QTestState *qts;
@@ -330,6 +484,12 @@ static void test_xive(void)
     /* omit reset_state here and use settings from test_hw_irq */
     test_pull_thread_ctx_to_odd_thread_cl(qts);
 
+    reset_state(qts);
+    test_hw_group_irq(qts);
+
+    reset_state(qts);
+    test_hw_group_irq_backlog(qts);
+
     reset_state(qts);
     test_flush_sync_inject(qts);
 
-- 
2.47.1



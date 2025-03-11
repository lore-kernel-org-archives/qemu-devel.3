Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0798C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzFb-00073e-3R; Tue, 11 Mar 2025 09:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDi-0004su-Ka; Tue, 11 Mar 2025 09:00:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDd-0008Ne-UU; Tue, 11 Mar 2025 09:00:30 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso9410930a91.0; 
 Tue, 11 Mar 2025 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698019; x=1742302819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bW/i37H/kqxxMLYWVFi5dKIqqFLw8+mO4T5YC2Hj02M=;
 b=jtjUL4Yd9Ncb3H4IGqQnecw3gAh45sv4Bg9B4V1S7Pp/llsv8bnn7MUCLWcSV5cV+m
 zRa8Yvp176Z+seKf7UCDQUaaGLZuPFWLoM2qyvhO+UBqehf/Fz/kkdzwDJky5vspHBvV
 VYpl+xWUvHjfJPhWOqWaBKMpbfp8mNUl5Q3xCMOOKSxZSRmnP04rpBbdOZfJjPu9jpO3
 +pqBZAriXYqqIzEeJuRY0wrtU9B28q+Ha/xj+eMrkeKTOYoUbpbK/HGtpVIvCeOn3DQG
 zzfsyVjnQzLBYvraoKdRi7dMbfIwg0iHP1DBlLxiFUSobEibmaNXyqg+yBa4vcyzV2Zs
 xiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698019; x=1742302819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bW/i37H/kqxxMLYWVFi5dKIqqFLw8+mO4T5YC2Hj02M=;
 b=ZkaN0374zydXStFn8C7pkTdvQZYq+OsS8XSRAqa3eqSATYEzGBntd4re9+hwANj9SQ
 XizaOSOQ0bMx29APtwMQnb1cWmdtaUEKi6SJJV/LbnTUmryGJupgllsUXfFGHdmQnP/C
 M0Cw3n+Z0eoE7kA6VOS9KO43Iel2XYh0BZkKyxZLZu15+jFVXmc0ciMmdSUS6DiylImV
 50b2kq3kl0o3++98uwKWkcOzEnjLwYLTQ2oV/VjaHRXynPVLUNlm0iSAlKjrKZrrEOtS
 BRpqMcPL5B3J1c4uNO9mUzPpjt8QoCdab3Oy4cmRkHujav2HP0djkSAkxeeaEC8RhRXT
 +Q6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHrdZ1yuPU66Rn4sxinrmE+bOdxvAkEyksCW1BiBxRcqlmvUj8wLBXsibwUK/+suMvrI6O9qKY8Q==@nongnu.org
X-Gm-Message-State: AOJu0YxHhhfziUUKifmWlepdi7KNQG3CQYxZNqmfBd08Z6xSjFCVIX8J
 GGZTzosswkOPQBTU5oK8rrXNRfIeByEu6TB/KgqcbgWOB4ZcVKc9DHhChw==
X-Gm-Gg: ASbGncuFGXY8wKSgv9FDALvqclRrYFZsIobl2Iup7D15zrhP3BYYDFlOu0Ko0OrynVB
 bO83X9LFRjJ+RjHwERAjEwJOXUnRWP9ic6gERij3MFH1fB5gdxkkrvptHKqN/fxjvmX+CVfawyA
 XUcJ70qxc50GuY1IgUdbdLPZlJUTqGnnY/NmnS+RT2LOHtaV9Z4xtIT0AaNLJhcfco5aPlBgljT
 jLfq8qC+YacgaWD9Lnf9WZcSGT2slmq7BguWXyvIitF6nBUjzJouVn3rzcB2Ax3nxxr1mWgb7CU
 PnJTPesnDb6lmG5qZ/sA2GFWwe7+4ko8mLFQ1NVPBZ2im1ed0K4=
X-Google-Smtp-Source: AGHT+IFht5oBBKw3ggcDUXirydsLyedSR5nBJcEZkoJgMjN3aHGigSX5ctDGNbRB5dM+InUV0kr0Kg==
X-Received: by 2002:a17:90b:1d46:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-3010051f268mr4508383a91.6.1741698018880; 
 Tue, 11 Mar 2025 06:00:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 36/72] qtest/xive: Add test of pool interrupts
Date: Tue, 11 Mar 2025 22:57:30 +1000
Message-ID: <20250311125815.903177-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Glenn Miles <milesg@linux.ibm.com>

Added new test for pool interrupts.  Removed all printfs from pnv-xive2-* qtests.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/pnv-xive2-test.c | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 7e7b1e79c0..5313d4ef18 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -267,6 +267,79 @@ static void test_hw_irq(QTestState *qts)
     g_assert_cmphex(cppr, ==, 0xFF);
 }
 
+static void test_pool_irq(QTestState *qts)
+{
+    uint32_t irq = 2;
+    uint32_t irq_data = 0x600d0d06;
+    uint32_t end_index = 5;
+    uint32_t target_pir = 1;
+    uint32_t target_nvp = 0x100 + target_pir;
+    uint8_t priority = 5;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr, ipb;
+
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to pool thread %d", irq, target_pir);
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, false /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    /* check TIMA values in the PHYS ring (shared by POOL ring) */
+    reg32 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x40);
+    g_assert_cmphex(cppr, ==, 0xFF);
+
+    /* check TIMA values in the POOL ring */
+    reg32 = get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    ipb = (reg32 >> 8) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0);
+    g_assert_cmphex(cppr, ==, 0);
+    g_assert_cmphex(ipb, ==, 0x80 >> priority);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, target_pir, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x40);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* check IPB is cleared in the POOL ring */
+    reg32 = get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD0);
+    ipb = (reg32 >> 8) & 0xFF;
+    g_assert_cmphex(ipb, ==, 0);
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, target_pir, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+}
+
 #define XIVE_ODD_CL 0x80
 static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
 {
@@ -486,6 +559,9 @@ static void test_xive(void)
     /* omit reset_state here and use settings from test_hw_irq */
     test_pull_thread_ctx_to_odd_thread_cl(qts);
 
+    reset_state(qts);
+    test_pool_irq(qts);
+
     reset_state(qts);
     test_hw_group_irq(qts);
 
-- 
2.47.1



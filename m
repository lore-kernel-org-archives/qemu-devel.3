Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4107AF55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8T5-0005e4-OL; Sun, 08 Mar 2026 03:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Rx-0002xA-TM
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:18 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Rv-0003OG-NA
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:17 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-126ea4e9694so4374397c88.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954474; x=1773559274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcvnvVJoE5XYpkkYLdY/36Vds/J4Eu0RKogC8hkAKYU=;
 b=MJKha3SgFA5Tj2E5mB0OtcpX8zF2A7DgBp3skZEcTSIGW0KjcVZbcDwjxo/6rbHYIO
 SFraSPqEEQwI8RFk0jUjFOY0XNpQg+sGIsYBv1IPgXf5myRTtVcnbtAj74aftMyCkATH
 /Md8RKfgXRWUOmhZ7Jn/h9V/9/+CucUZTDkBszfKUbDdkKxtE8qN6/mHf/mMGVnkGrZY
 d1Li8HL10O0iftxk1xTgumGktrtimIfmrIL13eZI6aHauxW2gM88qgYyl0kP3Ra66cfN
 Jc6aiproqN9F80PHWLnftI4Bpwa9+eJ+j7zSh55k+tSSGHEBPLVkeKU7U7qoJE2eBPAW
 YYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954474; x=1773559274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bcvnvVJoE5XYpkkYLdY/36Vds/J4Eu0RKogC8hkAKYU=;
 b=GjKfi+aTzEi+nVdhU8BtZ4rjIlCfwG2YxyH71uU6Ji62XmnTjxrNzlPgzr+d64PdHn
 ePw6MgXZO/R0OsWhXAk5KIm+E6siQjnqzc0UD4d/WuhrJfdppBxroCPPKUa771dsuCQT
 Fii9p7kqnrUcGhwJZSkZ7Lt++2MxJjLr9PR2VWkMWhlwApJi/lztBxsnE03MYS3qtcSi
 MlNZtyDVyAlxBU1qzLPJ/sdI8H/aFWZVb5+xB5JxT8/sth0NaYvT0cx2GA/QxRwsHkPH
 SGqwmK65z0XYqI9Tgj9kY8U38s6PLwHxNfs3t4G5o5pBObg0FsENPNJZWYs9X3y2GB1M
 rbIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ZtxUwhUGCZtp98RQi38LUcaNCOfh7jkJiSPPwRHzyawtUNAv+ApS4CplXEIHR2iXzBVBPRzaBx+J@nongnu.org
X-Gm-Message-State: AOJu0YyhNFEqpp+Sa4oYE5bIRTkQLYJk/kcVPLTjgQittgxyvpYpbOEC
 t80ZZRCqum8yV0Ug15an73s5+2x/pRQB9/x7qkv2UQBcDMnvrlgraPzR
X-Gm-Gg: ATEYQzxkv282bfVDCI/SnNqwp/sokDz3jS3l/G4yOTfynECP7+vWp/CbmaaHtu95WvI
 kDOJXL+ILxOIqoz2B08i5rWbno0Ls3sB6Kk1OzukaRemBn/l6Sgm/4cI26ipv1OFi5z8dTerupR
 K67bTQQJUjAUnCbPBQnUmDzWL3hCaY89zqJPzEU8DKO7QbjmQMh19iRitBrydH7GYiKrpH3BqA+
 Z/USMuel6TtxfOXXUjaIX7DnPwICQ6B1BqNv+tOmlyXQhIy1ZD/0jHCiSKe+rtiKnORWsN/3N/U
 VSHTwVzYW8/XedD8/UfCV71iX50UxSkgXqducCWGJonP3RvEMExk0Gu11yPa4JiSv9W1+tniNs5
 fS6LQURfOWomX50HIvQuKZkRpfOp4R60PN7rngLikbKZ+d9SH8a9oTYKzluCDpt6t+8db6DxcGr
 EWWnnuaRH2buQY0ej+2r/pH7OHJZ3o4v2a3X9u/dTFSdkIi5P/IUcn+V4MFFUQmkZUdyGR82YNf
 uZRL33GVt2oFJ5DvQG0VtTQQAE=
X-Received: by 2002:a05:7022:b81:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-128d4be781dmr204892c88.19.1772954474197; 
 Sat, 07 Mar 2026 23:21:14 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:21:13 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 27/28] tests/qtest: add DM TCG halt and register access
 tests
Date: Sun,  8 Mar 2026 15:17:30 +0800
Message-ID: <e49545f7d00d9b4010ab4e5ad8fe0c3d05d6b501.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
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

Add TCG-mode helper functions that boot a real CPU and interact
with the Debug Module through clock stepping, then add the first
batch of TCG tests:

  tcg/halt-dpc              – halt via HALTREQ, verify DPC/DCSR
  tcg/resethaltreq-priority – resethaltreq takes effect on reset
  tcg/gpr-rw                – read/write GPRs via abstract cmds
  tcg/fpr-rw                – read/write FPRs via abstract cmds
  rv32-gpr64-notsup         – 64-bit GPR access rejected on RV32
  tcg/command-ignored-on-cmderr – sticky cmderr blocks new cmds

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 tests/qtest/riscv-dm-test.c | 355 ++++++++++++++++++++++++++++++++++++
 1 file changed, 355 insertions(+)

diff --git a/tests/qtest/riscv-dm-test.c b/tests/qtest/riscv-dm-test.c
index 1b1ab02284..2e7c29ed7c 100644
--- a/tests/qtest/riscv-dm-test.c
+++ b/tests/qtest/riscv-dm-test.c
@@ -213,6 +213,139 @@ static void sim_cpu_exception(QTestState *qts)
     rom_write32(qts, ROM_EXCP, 0);
 }
 
+/* TCG-mode helpers: real CPU execution with clock stepping. */
+
+static QTestState *tcg_dm_init(void)
+{
+    const char *arch = qtest_get_arch();
+    const char *cpu_type = strstr(arch, "64") ? "rv64" : "rv32";
+    g_autofree char *args = g_strdup_printf(
+        "-machine virt -accel tcg -smp 1 -cpu %s,sdext=true", cpu_type);
+    QTestState *qts = qtest_init(args);
+
+    /* Check VM status */
+    QDict *resp = qtest_qmp(qts, "{'execute': 'query-status'}");
+    const QDict *ret = qdict_get_qdict(resp, "return");
+    bool running = qdict_get_bool(ret, "running");
+    const char *vm_status = qdict_get_str(ret, "status");
+    g_test_message("VM status: %s running=%d", vm_status, running);
+    qobject_unref(resp);
+
+    if (!running) {
+        resp = qtest_qmp(qts, "{'execute': 'cont'}");
+        g_test_message("Sent cont");
+        qobject_unref(resp);
+    }
+
+    /* Let the CPU boot via MTTCG thread */
+    g_usleep(TCG_BOOT_US);
+
+    dm_set_active(qts);
+    return qts;
+}
+
+static bool tcg_wait_for_halt(QTestState *qts)
+{
+    for (int t = 0; t < TCG_POLL_TIMEOUT_US; t += TCG_POLL_STEP_US) {
+        g_usleep(TCG_POLL_STEP_US);
+        uint32_t st = dm_read(qts, A_DMSTATUS);
+        if (t < TCG_POLL_STEP_US * 5) {
+            g_test_message("halt poll: DMSTATUS=0x%08x", st);
+        }
+        if (st & DMSTATUS_ALLHALTED) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool tcg_wait_for_cmd_done(QTestState *qts)
+{
+    for (int t = 0; t < TCG_POLL_TIMEOUT_US; t += TCG_POLL_STEP_US) {
+        g_usleep(TCG_POLL_STEP_US);
+        if (!(dm_read(qts, A_ABSTRACTCS) & ABSTRACTCS_BUSY)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool tcg_halt_hart(QTestState *qts)
+{
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+    return tcg_wait_for_halt(qts);
+}
+
+static bool tcg_resume_hart(QTestState *qts)
+{
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_RESUMEREQ);
+    for (int t = 0; t < TCG_POLL_TIMEOUT_US; t += TCG_POLL_STEP_US) {
+        g_usleep(TCG_POLL_STEP_US);
+        if (dm_read(qts, A_DMSTATUS) & DMSTATUS_ALLRESUMEACK) {
+            return true;
+        }
+    }
+    return false;
+}
+
+
+/*
+ * Read a register via Access Register abstract command.
+ * Returns true on success, false on error or timeout.
+ */
+static bool tcg_abstract_read_reg(QTestState *qts, uint32_t regno,
+                                  uint32_t *val)
+{
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    uint32_t cmd = (0u << 24) |     /* cmdtype = Access Register */
+                   (1u << 17) |     /* transfer = 1 */
+                   (2u << 20) |     /* aarsize = 32-bit */
+                   (regno & 0xFFFF);
+    dm_write(qts, A_COMMAND, cmd);
+
+    if (!tcg_wait_for_cmd_done(qts)) {
+        return false;
+    }
+
+    uint32_t acs = dm_read(qts, A_ABSTRACTCS);
+    if (acs & ABSTRACTCS_CMDERR_MASK) {
+        return false;
+    }
+
+    *val = dm_read(qts, A_DATA0);
+    return true;
+}
+
+/*
+ * Write a register via Access Register abstract command.
+ * Returns true on success, false on error or timeout.
+ */
+static bool tcg_abstract_write_reg(QTestState *qts, uint32_t regno,
+                                   uint32_t val)
+{
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+    dm_write(qts, A_DATA0, val);
+
+    uint32_t cmd = (0u << 24) |     /* cmdtype = Access Register */
+                   (1u << 17) |     /* transfer = 1 */
+                   (1u << 16) |     /* write = 1 */
+                   (2u << 20) |     /* aarsize = 32-bit */
+                   (regno & 0xFFFF);
+    dm_write(qts, A_COMMAND, cmd);
+
+    if (!tcg_wait_for_cmd_done(qts)) {
+        return false;
+    }
+
+    uint32_t acs = dm_read(qts, A_ABSTRACTCS);
+    return !(acs & ABSTRACTCS_CMDERR_MASK);
+}
+
+/*
+ * Write a 64-bit register via Access Register abstract command (aarsize=3).
+ * DATA1 holds high 32 bits, DATA0 holds low 32 bits.
+ */
 
 /*
  * Test: dmactive gate.
@@ -930,6 +1063,218 @@ static void test_haltsum1_window(void)
  * 4. Read DPC via abstract command → verify it's a valid address
  * 5. Resume CPU, then re-halt to verify the cycle works
  */
+static void test_tcg_halt_dpc(void)
+{
+    QTestState *qts = tcg_dm_init();
+
+    /* Halt the CPU */
+    g_assert_true(tcg_halt_hart(qts));
+
+    uint32_t status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==, 0);
+
+    /* Read DCSR: verify cause = HALTREQ (3) */
+    uint32_t dcsr;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    uint32_t cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_HALTREQ);
+
+    /* Read DPC: implementation dependent, but it must stay aligned. */
+    uint32_t dpc;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &dpc));
+    g_assert_cmpuint(dpc & 1u, ==, 0);
+
+    /* Resume the CPU */
+    g_assert_true(tcg_resume_hart(qts));
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLRESUMEACK, ==,
+                     DMSTATUS_ALLRESUMEACK);
+
+    /* Let it run a bit, then re-halt */
+    g_usleep(TCG_BOOT_US);
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    /* DPC after re-halt is also execution dependent; only assert alignment */
+    uint32_t dpc2;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &dpc2));
+    g_assert_cmpuint(dpc2 & 1u, ==, 0);
+
+    /* DCSR cause should be HALTREQ again */
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_HALTREQ);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: reset-haltreq and haltreq asserted together.
+ *
+ * Priority per Debug Spec v1.0 Table 4.2 requires reset-haltreq (cause=5)
+ * to win over haltreq (cause=3).
+ */
+static void test_tcg_resethaltreq_priority(void)
+{
+    QTestState *qts = tcg_dm_init();
+    uint32_t status, dcsr, cause;
+
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_SETRESETHALTREQ);
+
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE |
+                               DMCONTROL_HARTRESET | DMCONTROL_HALTREQ);
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+
+    g_assert_true(tcg_wait_for_halt(qts));
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_RESET);
+
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE |
+                               DMCONTROL_CLRRESETHALTREQ | DMCONTROL_HALTREQ);
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: Read/Write all 32 GPR registers via abstract commands (TCG).
+ *
+ * For each GPR x0..x31:
+ * - x0: hardwired to 0, read should return 0
+ * - x1..x31: write a test pattern, read back and verify
+ */
+static void test_tcg_gpr_rw(void)
+{
+    QTestState *qts = tcg_dm_init();
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    /* x0 is hardwired to 0 */
+    uint32_t val;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_GPR(0), &val));
+    g_assert_cmpuint(val, ==, 0);
+
+    /* x1..x31: write test patterns and read back */
+    for (int i = 1; i < 32; i++) {
+        uint32_t pattern = 0xA5000000u | (uint32_t)i;
+
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_GPR(i), pattern));
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_GPR(i), &val));
+        g_assert_cmpuint(val, ==, pattern);
+    }
+
+    /* Verify x0 is still 0 after all writes */
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_GPR(0), &val));
+    g_assert_cmpuint(val, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: Read/Write all 32 FPR registers via abstract commands (TCG).
+ *
+ * For each FPR f0..f31:
+ * - Write a 32-bit test pattern (single-precision view)
+ * - Read back and verify
+ */
+static void test_tcg_fpr_rw(void)
+{
+    QTestState *qts = tcg_dm_init();
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    uint32_t val;
+
+    for (int i = 0; i < 32; i++) {
+        uint32_t pattern = 0x3F800000u + (uint32_t)i; /* 1.0f + i */
+
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_FPR(i), pattern));
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_FPR(i), &val));
+        g_assert_cmpuint(val, ==, pattern);
+    }
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: RV32 rejects 64-bit GPR abstract accesses at command decode time.
+ */
+static void test_rv32_gpr64_notsup(void)
+{
+    QTestState *qts;
+    uint32_t acs;
+    const char *arch = qtest_get_arch();
+
+    if (!strstr(arch, "32")) {
+        g_test_skip("RV32-only");
+        return;
+    }
+
+    qts = qtest_init("-machine virt");
+
+    dm_set_active(qts);
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+    sim_cpu_halt_ack(qts, 0);
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    dm_write(qts, A_COMMAND,
+             (0u << 24) | (1u << 17) | (3u << 20) | REGNO_GPR(1));
+
+    acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, 0);
+    g_assert_cmpuint((acs & ABSTRACTCS_CMDERR_MASK) >>
+                     ABSTRACTCS_CMDERR_SHIFT, ==, 2);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: COMMAND writes are ignored while CMDERR is non-zero.
+ */
+static void test_tcg_command_ignored_on_cmderr(void)
+{
+    QTestState *qts = tcg_dm_init();
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    /* Baseline last command: read x0, result must be 0. */
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+    dm_write(qts, A_COMMAND,
+             (0u << 24) | (1u << 17) | (2u << 20) | REGNO_GPR(0));
+    g_assert_true(tcg_wait_for_cmd_done(qts));
+    g_assert_cmpuint(dm_read(qts, A_DATA0), ==, 0);
+
+    /* Latch cmderr with an unsupported command. */
+    dm_write(qts, A_COMMAND, 0xFF000000);
+    uint32_t acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint((acs & ABSTRACTCS_CMDERR_MASK) >>
+                     ABSTRACTCS_CMDERR_SHIFT, ==, 2);
+
+    /*
+     * This command must be ignored because cmderr != 0.
+     * If it incorrectly overwrites last_cmd, later autoexec will read DCSR.
+     */
+    dm_write(qts, A_COMMAND,
+             (0u << 24) | (1u << 17) | (2u << 20) | REGNO_DCSR);
+
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+    dm_write(qts, A_ABSTRACTAUTO, 0x1);    /* autoexec on data0 */
+    dm_write(qts, A_DATA0, 0xDEADBEEF);    /* triggers autoexec of last_cmd */
+
+    g_assert_true(tcg_wait_for_cmd_done(qts));
+    acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint((acs & ABSTRACTCS_CMDERR_MASK) >>
+                     ABSTRACTCS_CMDERR_SHIFT, ==, 2);
+    g_assert_cmpuint(dm_read(qts, A_DATA0), ==, 0xDEADBEEF);
+
+    qtest_quit(qts);
+}
+
 
 /*
  * Test: Halt and resume cycle via ROM simulation.
@@ -1008,5 +1353,15 @@ int main(int argc, char *argv[])
     qtest_add_func("/riscv-dm/abstract-cmd-exception",
                    test_abstract_cmd_exception);
 
+    /* TCG-mode tests: real CPU execution */
+    qtest_add_func("/riscv-dm/tcg/halt-dpc", test_tcg_halt_dpc);
+    qtest_add_func("/riscv-dm/tcg/resethaltreq-priority",
+                   test_tcg_resethaltreq_priority);
+    qtest_add_func("/riscv-dm/tcg/gpr-rw", test_tcg_gpr_rw);
+    qtest_add_func("/riscv-dm/tcg/fpr-rw", test_tcg_fpr_rw);
+    qtest_add_func("/riscv-dm/rv32-gpr64-notsup", test_rv32_gpr64_notsup);
+    qtest_add_func("/riscv-dm/tcg/command-ignored-on-cmderr",
+                   test_tcg_command_ignored_on_cmderr);
+
     return g_test_run();
 }
-- 
2.53.0



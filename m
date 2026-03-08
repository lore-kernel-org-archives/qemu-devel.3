Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE03F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Sy-0004n2-La; Sun, 08 Mar 2026 03:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8S8-00039L-5B
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:29 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8S2-0003Uc-AG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:25 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2be3bdfda8eso3687646eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954481; x=1773559281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3qLbUC44VdhutdRCzgiU5V4BeYTIqYuq+q3+7FdlOk=;
 b=P91mV6/Pyhvm99zyrWaGsHc8cyCK8rqZ1JnEmEVdEnDSUe0B/Jwtywr8AdLrGk7Ym9
 w35IYUYAEYc91zQrfdloc/tDlZLX2g3CoZEYUdQByyVvYgf487mm5tqcKajVnOqXO96f
 uwYhAiOBOgMclsNLJOZNh++hpup0hgCiCX4f4fn5vnv/XwJIBSG/98QBiCjxPjneBM8i
 pQRZgyFRGK8APw08dM4xY4QDJ5tHcOZPx9urhQfUP1+U3GKJNH/AHVWSjN09L9eLih9M
 F+Pw3Fc36XaThT5Bz4rXCYEa+qgpYoIdLRbvAzt46r9idI+NzBIeV1iA++kibtbpNxF/
 unhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954481; x=1773559281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a3qLbUC44VdhutdRCzgiU5V4BeYTIqYuq+q3+7FdlOk=;
 b=QznY4czdGmQtEkMK43Mp/te3eMxJ8oArxGBh9SJlgk/uMTnLGBSH5ER5mj9i3hv+s6
 l+UBHUplA+nwkZ/18SQXseToCdYa4+oMgW2TPiROTveLtwpfeW7IFWzABiIkCSqGd0wM
 9iUnxvXD4B61Yv4uqFNxld/K4qgr7qGM1YOsQrQalHLUQdCTlY8lv/o/70y3ovw9mDQ7
 7IFxwt+TJlzwQgV/5tO1742CSwPXFRgyszfChBTlrgZo4O8D/J3x+MLlcv+HTNPInqTr
 VJTEjpoowjAECuKVDe4c6DxvCDXP4pnRjngCZE9lO9Ljg7sDlXNbwuHf3FI2RfcRgk5r
 hlsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV661dtfILbgFNOG5r13AlWar9NPGkdvFBbnLgiUh+P83VOtIMjr3VMmN9djDFJB0FLmPPMH4ohGxoB@nongnu.org
X-Gm-Message-State: AOJu0Yx+BVwGrktpIU8D7yNwtcB46Pxp1pwFD06dh4PdJl9aNAfBX8Wh
 DFH6Pl0ODR5gpv/G9NYKrDjXziN37Tj/RRc4whoOcFMjA7qDibY4bHQk
X-Gm-Gg: ATEYQzx4Px04/aoM0vR7w73S3RR7yNnHKUdA7WjBo3S7zKqxj+47pzyM/IWxtzdNKw5
 OAFTIyp7Eb87dR5Z65B8WNaALcX+Rc6NbBQ2foIFmS2CyscEfdgNLTZIoLmaBO+EgEnK2wqjIOg
 CvZRh7Sf7LHJmvMaAM7UcTLEMaMwvDU+9LDwdrXMiEGpdRChtxapDP41PLfOzadGasEdeSRxMAW
 4Cr/vJvG1NYAHCC/YE7rNOj4td9l4RU189EtDKv+ZWmS3awWZZVWYQMe6W+3aR09PqO/nFayfe4
 YjUiJArUGBpqpZpzlf+/7/A+UZhPz1zox2FGDzHog6qzmbD6E7RTHd6B4ySPmBl266n0bxm20TI
 xRkSdUNRkO3Nha8C1KVALqsSaEHPba6QylXS5PJN5NiHNF/XWgp34WJE37hBCw1gmXt3FdTMzB8
 fkoTB80eFUPFcWfnwnfvkesLOql1nclJrpfZek2OoEi8oxmFdpoTlQxY2ky3a+oFh9eL3aGFHG9
 /UhMgYmoN5LqkmsGwgjBMqi+WI=
X-Received: by 2002:a05:7301:608a:b0:2be:1946:8587 with SMTP id
 5a478bee46e88-2be4de8f969mr2620151eec.9.1772954480839; 
 Sat, 07 Mar 2026 23:21:20 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:21:20 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 28/28] tests/qtest: add DM TCG single-step and trigger tests
Date: Sun,  8 Mar 2026 15:17:31 +0800
Message-ID: <815a1695c1a8f39d2d4e131612602c07244bf80e.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

Add the remaining TCG-mode helpers (64-bit register access,
resume-and-run, is_rv64) and the second batch of TCG tests:

  tcg/single-step               – single-step via DCSR.step
  tcg/postexec-impebreak        – postexec with implicit ebreak
  tcg/postexec-exception        – abstract cmd exception path
  tcg/trigger-debug-mode        – mcontrol6 breakpoint fires
  tcg/load-trigger-debug-mode   – load watchpoint enters debug
  tcg/store-trigger-debug-mode  – store watchpoint enters debug
  tcg/itrigger-debug-mode       – instruction trigger enters debug

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 tests/qtest/riscv-dm-test.c | 547 ++++++++++++++++++++++++++++++++++++
 1 file changed, 547 insertions(+)

diff --git a/tests/qtest/riscv-dm-test.c b/tests/qtest/riscv-dm-test.c
index 2e7c29ed7c..b2fb47e8f0 100644
--- a/tests/qtest/riscv-dm-test.c
+++ b/tests/qtest/riscv-dm-test.c
@@ -288,6 +288,15 @@ static bool tcg_resume_hart(QTestState *qts)
     return false;
 }
 
+static bool tcg_resume_hart_and_run(QTestState *qts)
+{
+    if (!tcg_resume_hart(qts)) {
+        return false;
+    }
+
+    g_usleep(TCG_BOOT_US);
+    return true;
+}
 
 /*
  * Read a register via Access Register abstract command.
@@ -346,6 +355,62 @@ static bool tcg_abstract_write_reg(QTestState *qts, uint32_t regno,
  * Write a 64-bit register via Access Register abstract command (aarsize=3).
  * DATA1 holds high 32 bits, DATA0 holds low 32 bits.
  */
+static bool tcg_abstract_write_reg64(QTestState *qts, uint32_t regno,
+                                     uint64_t val)
+{
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+    dm_write(qts, A_DATA0, (uint32_t)val);
+    dm_write(qts, A_DATA1, (uint32_t)(val >> 32));
+
+    uint32_t cmd = (0u << 24) |     /* cmdtype = Access Register */
+                   (1u << 17) |     /* transfer = 1 */
+                   (1u << 16) |     /* write = 1 */
+                   (3u << 20) |     /* aarsize = 64-bit */
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
+ * Read a 64-bit register via Access Register abstract command (aarsize=3).
+ * DATA0 holds low 32 bits, DATA1 holds high 32 bits.
+ */
+static bool tcg_abstract_read_reg64(QTestState *qts, uint32_t regno,
+                                    uint64_t *val)
+{
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    uint32_t cmd = (0u << 24) |     /* cmdtype = Access Register */
+                   (1u << 17) |     /* transfer = 1 */
+                   (3u << 20) |     /* aarsize = 64-bit */
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
+    uint32_t lo = dm_read(qts, A_DATA0);
+    uint32_t hi = dm_read(qts, A_DATA1);
+    *val = ((uint64_t)hi << 32) | lo;
+    return true;
+}
+
+static bool is_rv64(void)
+{
+    return strstr(qtest_get_arch(), "64") != NULL;
+}
 
 /*
  * Test: dmactive gate.
@@ -1275,6 +1340,475 @@ static void test_tcg_command_ignored_on_cmderr(void)
     qtest_quit(qts);
 }
 
+/*
+ * Test: Single-step via DM.
+ *
+ * Verifies the Sdext single-step mechanism end-to-end:
+ * 1. Halt the hart via HALTREQ
+ * 2. Read DPC (save initial PC)
+ * 3. Set DCSR.step = 1 via abstract command
+ * 4. Resume the hart → CPU executes one instruction → re-enters debug mode
+ * 5. Verify DCSR.cause = STEP (4)
+ * 6. Verify DPC advanced from the initial value
+ * 7. Step again to confirm repeatability
+ * 8. Clear DCSR.step, resume, verify hart stays running
+ */
+static void test_tcg_single_step(void)
+{
+    QTestState *qts = tcg_dm_init();
+
+    /* Step 1: Halt the hart */
+    g_assert_true(tcg_halt_hart(qts));
+    uint32_t status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+
+    /* Step 2: Read initial DPC */
+    uint32_t dpc0;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &dpc0));
+    g_test_message("initial DPC = 0x%08x", dpc0);
+
+    /* Step 3: Set DCSR.step = 1 */
+    uint32_t dcsr;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    g_test_message("DCSR before step = 0x%08x", dcsr);
+    dcsr |= DCSR_STEP;
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_DCSR, dcsr));
+
+    /* Verify step bit is set */
+    uint32_t dcsr_check;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr_check));
+    g_assert_cmpuint(dcsr_check & DCSR_STEP, ==, DCSR_STEP);
+
+    /* Step 4: Resume → hart executes one instruction → re-halts */
+    g_assert_true(tcg_resume_hart_and_run(qts));
+    g_assert_true(tcg_wait_for_halt(qts));
+
+    /* Step 5: Verify DCSR.cause = STEP (4) */
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    uint32_t cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_test_message("DCSR after step = 0x%08x, cause = %u", dcsr, cause);
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_STEP);
+
+    /* Step 6: Verify DPC advanced */
+    uint32_t dpc1;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &dpc1));
+    g_test_message("DPC after step = 0x%08x", dpc1);
+    g_assert_cmpuint(dpc1, !=, dpc0);
+
+    /* Step 7: Step again to confirm repeatability */
+    uint32_t dpc_prev = dpc1;
+    g_assert_true(tcg_resume_hart_and_run(qts));
+    g_assert_true(tcg_wait_for_halt(qts));
+
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_STEP);
+
+    uint32_t dpc2;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &dpc2));
+    g_test_message("DPC after 2nd step = 0x%08x", dpc2);
+    g_assert_cmpuint(dpc2, !=, dpc_prev);
+
+    /* Step 8: Clear step bit, resume, verify hart stays running */
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    dcsr &= ~DCSR_STEP;
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_DCSR, dcsr));
+
+    g_assert_true(tcg_resume_hart(qts));
+
+    /* Give CPU time to run freely, then verify it's still running */
+    g_usleep(TCG_BOOT_US);
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==, DMSTATUS_ANYRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: POSTEXEC completes via the implicit ebreak after Program Buffer.
+ */
+static void test_tcg_postexec_impebreak(void)
+{
+    QTestState *qts = tcg_dm_init();
+    uint32_t cmd, acs, status;
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    for (int i = 0; i < 8; i++) {
+        dm_write(qts, A_PROGBUF0 + i * 4, 0x00000013);
+    }
+
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    cmd = (0u << 24) | (1u << 18);
+    dm_write(qts, A_COMMAND, cmd);
+
+    g_assert_true(tcg_wait_for_cmd_done(qts));
+
+    acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, 0);
+    g_assert_cmpuint(acs & ABSTRACTCS_CMDERR_MASK, ==, 0);
+
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: POSTEXEC illegal instruction in Program Buffer.
+ *
+ * The hart is in Debug Mode and executes Program Buffer from DM ROM.
+ * If the first progbuf instruction is illegal, CPU should vector to the
+ * DM ROM exception entry and DM should latch CMDERR=EXCEPTION.
+ */
+static void test_tcg_postexec_exception(void)
+{
+    QTestState *qts = tcg_dm_init();
+    uint32_t cmd, acs, cmderr, status;
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    /* 0x00000000 is an illegal instruction encoding. */
+    dm_write(qts, A_PROGBUF0, 0x00000000);
+    for (int i = 1; i < 8; i++) {
+        dm_write(qts, A_PROGBUF0 + i * 4, 0x00000013);
+    }
+
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    cmd = (0u << 24) | (1u << 18);
+    dm_write(qts, A_COMMAND, cmd);
+
+    g_assert_true(tcg_wait_for_cmd_done(qts));
+
+    acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, 0);
+    cmderr = (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    g_assert_cmpuint(cmderr, ==, 3);
+
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: Trigger with action=debug_mode halts the hart via DM.
+ *
+ * Configures an mcontrol (type 2) trigger on the current DPC address with
+ * action=1 (enter debug mode).  After resume the CPU hits the trigger and
+ * re-enters debug mode.  Verifies DCSR.cause = TRIGGER and DPC matches.
+ */
+static void test_tcg_trigger_debug_mode(void)
+{
+    QTestState *qts = tcg_dm_init();
+    bool rv64 = is_rv64();
+    const uint64_t code_addr = 0x80400000ULL;
+    const uint32_t nop_insn = 0x00000013;
+    const uint32_t loop_insn = 0x0000006f;
+
+    /* Halt the hart */
+    g_assert_true(tcg_halt_hart(qts));
+
+    /*
+     * Use a fixed code location so the test does not depend on where the CPU
+     * happened to be halted during boot.
+     */
+    qtest_writel(qts, code_addr, nop_insn);
+    qtest_writel(qts, code_addr + 4, loop_insn);
+
+    uint64_t dpc = code_addr;
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_DPC, dpc));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_DPC, (uint32_t)dpc));
+    }
+    g_test_message("DPC before trigger = 0x%lx", (unsigned long)dpc);
+
+    /* Select trigger 1 to verify non-zero trigger index handling */
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_TSELECT, 1));
+
+    /*
+     * Configure mcontrol type 2 trigger:
+     * - type=2, action=1 (DBG_ACTION_DBG_MODE)
+     * - match on EXEC in M/S/U modes
+     * - exact address match (match=0)
+     *
+     * On RV64 the type field is at bits[63:60] and tdata2 is 64-bit,
+     * so both require 64-bit abstract commands to avoid sign-extension.
+     */
+    uint64_t tdata1_lo = TDATA1_TYPE2_ACTION_DBG |
+                         TDATA1_TYPE2_M | TDATA1_TYPE2_S | TDATA1_TYPE2_U |
+                         TDATA1_TYPE2_EXEC;
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA2, dpc));
+        uint64_t tdata1_64 = (2ULL << 60) | tdata1_lo;
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA1, tdata1_64));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA2, (uint32_t)dpc));
+        uint32_t tdata1 = TDATA1_TYPE2_TYPE | (uint32_t)tdata1_lo;
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA1, tdata1));
+    }
+
+    /* Verify trigger configuration was accepted (low 32 bits) */
+    uint32_t td1_rb;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_TDATA1, &td1_rb));
+    g_test_message("tdata1 readback low = 0x%08x", td1_rb);
+    g_assert_cmpuint(td1_rb & TDATA1_TYPE2_EXEC, ==, TDATA1_TYPE2_EXEC);
+
+    /* Resume -> CPU tries to execute at DPC -> trigger fires -> debug mode */
+    g_assert_true(tcg_resume_hart_and_run(qts));
+    g_assert_true(tcg_wait_for_halt(qts));
+
+    /* Verify DCSR.cause = TRIGGER (2) */
+    uint32_t dcsr;
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    uint32_t cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_test_message("DCSR after trigger = 0x%08x, cause = %u", dcsr, cause);
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_TRIGGER);
+
+    /* Verify DPC is the trigger address */
+    uint64_t dpc_after;
+    if (rv64) {
+        g_assert_true(tcg_abstract_read_reg64(qts, REGNO_DPC, &dpc_after));
+    } else {
+        uint32_t tmp;
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &tmp));
+        dpc_after = tmp;
+    }
+    g_test_message("DPC after trigger = 0x%lx", (unsigned long)dpc_after);
+    g_assert_cmpuint(dpc_after, ==, dpc);
+
+    /* Disable trigger: write tdata1 with type=2 but no EXEC/LOAD/STORE bits */
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_TSELECT, 1));
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA1,
+                                                2ULL << 60));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA1,
+                                              TDATA1_TYPE2_TYPE));
+    }
+
+    /*
+     * Advance DPC past the trigger address so resume doesn't re-trigger.
+     * The loop instruction keeps the hart running at a stable address.
+     */
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_DPC, dpc + 4));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_DPC,
+                                              (uint32_t)(dpc + 4)));
+    }
+
+    /* Resume and verify hart stays running */
+    g_assert_true(tcg_resume_hart(qts));
+    g_usleep(TCG_BOOT_US);
+    uint32_t status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==, DMSTATUS_ANYRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==, 0);
+
+    qtest_quit(qts);
+}
+
+
+static void test_tcg_watchpoint_trigger_debug_mode(bool store)
+{
+    QTestState *qts = tcg_dm_init();
+    bool rv64 = is_rv64();
+    const uint64_t code_addr = 0x80400000ULL;
+    const uint64_t data_addr = 0x80401000ULL;
+    const uint32_t load_insn = 0x0002a383;  /* lw x7, 0(x5) */
+    const uint32_t store_insn = 0x0062a023; /* sw x6, 0(x5) */
+    const uint32_t loop_insn = 0x0000006f;  /* j . */
+    const uint32_t data_init = 0x11223344;
+    const uint32_t store_val = 0x55667788;
+    const uint32_t trigger_idx = store ? 3 : 2;
+    uint32_t dcsr, cause, status;
+    uint64_t tdata1_lo = TDATA1_TYPE2_ACTION_DBG |
+                         TDATA1_TYPE2_M | TDATA1_TYPE2_S | TDATA1_TYPE2_U |
+                         (store ? TDATA1_TYPE2_STORE : TDATA1_TYPE2_LOAD);
+
+    g_assert_true(tcg_halt_hart(qts));
+
+    qtest_writel(qts, code_addr, store ? store_insn : load_insn);
+    qtest_writel(qts, code_addr + 4, loop_insn);
+    qtest_writel(qts, data_addr, data_init);
+
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_GPR(5), data_addr));
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_GPR(6), store_val));
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_GPR(7), 0));
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_DPC, code_addr));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_GPR(5),
+                                             (uint32_t)data_addr));
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_GPR(6), store_val));
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_GPR(7), 0));
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_DPC,
+                                             (uint32_t)code_addr));
+    }
+
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_TSELECT, trigger_idx));
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA2, data_addr));
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA1,
+                                               (2ULL << 60) | tdata1_lo));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA2,
+                                             (uint32_t)data_addr));
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA1,
+                                             TDATA1_TYPE2_TYPE |
+                                             (uint32_t)tdata1_lo));
+    }
+
+    g_assert_true(tcg_resume_hart_and_run(qts));
+    g_assert_true(tcg_wait_for_halt(qts));
+
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_TRIGGER);
+
+    if (rv64) {
+        uint64_t dpc;
+        g_assert_true(tcg_abstract_read_reg64(qts, REGNO_DPC, &dpc));
+        g_assert_cmpuint(dpc, ==, code_addr);
+    } else {
+        uint32_t dpc;
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &dpc));
+        g_assert_cmpuint(dpc, ==, (uint32_t)code_addr);
+    }
+
+    if (store) {
+        g_assert_cmpuint(qtest_readl(qts, data_addr), ==, data_init);
+    }
+
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_TSELECT, trigger_idx));
+    if (rv64) {
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA1, 2ULL << 60));
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_DPC, code_addr));
+    } else {
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA1,
+                                             TDATA1_TYPE2_TYPE));
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_DPC,
+                                             (uint32_t)code_addr));
+    }
+
+    g_assert_true(tcg_resume_hart(qts));
+    g_usleep(TCG_BOOT_US);
+
+    if (store) {
+        g_assert_cmpuint(qtest_readl(qts, data_addr), ==, store_val);
+        status = dm_read(qts, A_DMSTATUS);
+        g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==, DMSTATUS_ANYRUNNING);
+    } else {
+        uint64_t load_val;
+
+        g_assert_true(tcg_halt_hart(qts));
+        if (rv64) {
+            g_assert_true(tcg_abstract_read_reg64(qts, REGNO_GPR(7),
+                                                  &load_val));
+        } else {
+            uint32_t tmp;
+
+            g_assert_true(tcg_abstract_read_reg(qts, REGNO_GPR(7), &tmp));
+            load_val = tmp;
+        }
+        g_assert_cmpuint(load_val, ==, data_init);
+        status = dm_read(qts, A_DMSTATUS);
+        g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_tcg_load_trigger_debug_mode(void)
+{
+    test_tcg_watchpoint_trigger_debug_mode(false);
+}
+
+static void test_tcg_store_trigger_debug_mode(void)
+{
+    test_tcg_watchpoint_trigger_debug_mode(true);
+}
+
+/*
+ * Test: itrigger with action=debug_mode enters Debug Mode.
+ *
+ * Configures an itrigger with count=1 so the hart executes one instruction,
+ * re-enters debug mode with cause=TRIGGER, and clears the count.
+ */
+static void test_tcg_itrigger_debug_mode(void)
+{
+    QTestState *qts = tcg_dm_init();
+    bool rv64 = is_rv64();
+    uint64_t dpc;
+    uint64_t dpc_after;
+    uint64_t tdata1;
+    uint32_t dcsr;
+    uint32_t status;
+    uint32_t cause;
+
+    g_assert_true(tcg_halt_hart(qts));
+    g_assert_true(tcg_abstract_write_reg(qts, REGNO_TSELECT, 1));
+
+    if (rv64) {
+        g_assert_true(tcg_abstract_read_reg64(qts, REGNO_DPC, &dpc));
+        tdata1 = (3ULL << 60) |
+                 TDATA1_ITRIGGER_ACTION_DBG |
+                 TDATA1_ITRIGGER_U |
+                 TDATA1_ITRIGGER_S |
+                 TDATA1_ITRIGGER_M |
+                 TDATA1_ITRIGGER_COUNT(1);
+        g_assert_true(tcg_abstract_write_reg64(qts, REGNO_TDATA1, tdata1));
+    } else {
+        uint32_t tmp;
+
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &tmp));
+        dpc = tmp;
+        tdata1 = TDATA1_ITRIGGER_TYPE |
+                 TDATA1_ITRIGGER_ACTION_DBG |
+                 TDATA1_ITRIGGER_U |
+                 TDATA1_ITRIGGER_S |
+                 TDATA1_ITRIGGER_M |
+                 TDATA1_ITRIGGER_COUNT(1);
+        g_assert_true(tcg_abstract_write_reg(qts, REGNO_TDATA1,
+                                             (uint32_t)tdata1));
+    }
+
+    g_assert_true(tcg_resume_hart(qts));
+    g_assert_true(tcg_wait_for_halt(qts));
+
+    g_assert_true(tcg_abstract_read_reg(qts, REGNO_DCSR, &dcsr));
+    cause = (dcsr & DCSR_CAUSE_MASK) >> DCSR_CAUSE_SHIFT;
+    g_assert_cmpuint(cause, ==, DCSR_CAUSE_TRIGGER);
+
+    if (rv64) {
+        g_assert_true(tcg_abstract_read_reg64(qts, REGNO_DPC, &dpc_after));
+        g_assert_true(tcg_abstract_read_reg64(qts, REGNO_TDATA1, &tdata1));
+    } else {
+        uint32_t tmp;
+
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_DPC, &tmp));
+        dpc_after = tmp;
+        g_assert_true(tcg_abstract_read_reg(qts, REGNO_TDATA1, &tmp));
+        tdata1 = tmp;
+    }
+
+    g_assert_cmpuint(dpc_after, !=, dpc);
+    g_assert_cmpuint(tdata1 & TDATA1_ITRIGGER_COUNT_MASK, ==, 0);
+
+    g_assert_true(tcg_resume_hart(qts));
+    g_usleep(TCG_BOOT_US);
+    status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ANYRUNNING, ==, DMSTATUS_ANYRUNNING);
+    g_assert_cmpuint(status & DMSTATUS_ANYHALTED, ==, 0);
+
+    qtest_quit(qts);
+}
 
 /*
  * Test: Halt and resume cycle via ROM simulation.
@@ -1362,6 +1896,19 @@ int main(int argc, char *argv[])
     qtest_add_func("/riscv-dm/rv32-gpr64-notsup", test_rv32_gpr64_notsup);
     qtest_add_func("/riscv-dm/tcg/command-ignored-on-cmderr",
                    test_tcg_command_ignored_on_cmderr);
+    qtest_add_func("/riscv-dm/tcg/single-step", test_tcg_single_step);
+    qtest_add_func("/riscv-dm/tcg/postexec-impebreak",
+                   test_tcg_postexec_impebreak);
+    qtest_add_func("/riscv-dm/tcg/postexec-exception",
+                   test_tcg_postexec_exception);
+    qtest_add_func("/riscv-dm/tcg/trigger-debug-mode",
+                   test_tcg_trigger_debug_mode);
+    qtest_add_func("/riscv-dm/tcg/load-trigger-debug-mode",
+                   test_tcg_load_trigger_debug_mode);
+    qtest_add_func("/riscv-dm/tcg/store-trigger-debug-mode",
+                   test_tcg_store_trigger_debug_mode);
+    qtest_add_func("/riscv-dm/tcg/itrigger-debug-mode",
+                   test_tcg_itrigger_debug_mode);
 
     return g_test_run();
 }
-- 
2.53.0



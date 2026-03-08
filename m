Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB8FF55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Sh-0003l4-4W; Sun, 08 Mar 2026 03:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Rt-0002ry-KJ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:14 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Rr-0003J9-8p
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:21:13 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2bdfc4b191fso6050025eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954468; x=1773559268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJZ+rBevmOiRZs5yFHqYuEbMVHGXG6seK7boNd+RNkY=;
 b=aQ4jGbjuyLZgSxfnOMk0Q7hnk/N3DVn6HBNT4ypKEdTyuqIlJstNae6AJJXEEGRUQy
 YY9rpBV1VeWZfL3ZDP5iQBsZWrsJaotuVDmTgvdXs9u6adBQVced9b+eBiWyH/m/mcob
 +cMiCKN3Kt3+tdHVp/UfoPKlXY7OqHMospqmOSfk//1QPiuLeFm/D3niMeBlzJDAJ6Ap
 krIWSuRYcOwOJic1lZOH9zkeHBZUNfdy+6at/74PXWkCaxX0ysrvHmZsfklobI8apz3w
 jQWDAqJ8KQubZroKgpYyEDRT6S2xRdy+rqR61UnOy5PxlCK/i92R1Zw7V+Mfh3ENUFQG
 MAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954468; x=1773559268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJZ+rBevmOiRZs5yFHqYuEbMVHGXG6seK7boNd+RNkY=;
 b=cMuBf720oinG1OwV33YwcSuKgtz1NoCv3cQz6UdA+cEAmQAP62+iqaHCeGOlp2ylLj
 9/KYBGAkdkX+cd9XhMiVXinMIOuypzHgNqDigSpryjbwuY2gd2DU1CCUcL6o6P/XglK0
 wjRJtb6dU5A5VIdR0hxJgFzFT5mhpGvXRn+SMx2QcBdy4Kl2NUYAviWM4DdoOITNft5s
 Napz0LHROmBEm7M72Y/I7v5MV3W+TfG7QmzX22v7zXJJI8tTe12GLDVniOmeXyAkKh4H
 eJG3DGTnhAl9eKIPOBl9ixOKv4hmQYOVcMqSNu5QNBQqvkwHh3VcAIKw2iWWEwIIZgyd
 6e0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7WyoPwXNcX90ViaRlzO60rQRSNo9KsuV+DPbvleLVDnSNQBYMGcviPKOib+p0ShLXMrpipo0VmJs6@nongnu.org
X-Gm-Message-State: AOJu0YzQEXXz9o6dy169Sfl69U6JDtdBzID3tOP46DnubtL0rj0OGBSP
 eEuVrmQDkD/wG6XvmwqhEk5fKWSCnSvzzg3hJM4I4nGIfrmkJASwElVB
X-Gm-Gg: ATEYQzx9ONanA9c+KTtEpLNKQWdEq+8Z10YhEJzxL3tFwccDL/OYA9WFA9veiDuBKtU
 wlo4qavXLtEgqUPvAAcbYAwnUq+uT4cxKDdIrAtOP08/0AT8P/+bjXkEoSIgiciZr+l30F0W0Sp
 mPFnwRAbIQJUYCxQwM2oAPd/rMVPU0ZTE0HDyf0SgvlTH2/NtpztY4eFL4BClPw0nWdMg8wqih1
 e0U8wgV77XPEAPBiulpKhCF97rQ0kEw6GoASNpxy1a+M5LUj0+CzU3KTXHKxinlOTZDzQvY66Ku
 uJtwsy1itiTPZx8o697eq2+5svvQSnRALnZCpVG+3LDJWVncrfcRkup8/O0+HdaeQTCwy2FOleI
 iiEl4iCmYpkvS9c3XF7BbZka0foti46ltUNsWn+kZu/QecB4IuonZn1plSb+s3xuCW58Cturxnb
 q6M4YsA0j3FnwI6XKpOvMZ+PiEN8NZn+0iaSIybBigF10jL4GNOCgAM++SCUBeWBUr/UB+a4hrD
 YyYmXH1gaE2S/VlqtxdqCGkBsZjlVENpV56Sg==
X-Received: by 2002:a05:7300:320a:b0:2bd:fb12:9a01 with SMTP id
 5a478bee46e88-2be4deab763mr2883909eec.12.1772954468286; 
 Sat, 07 Mar 2026 23:21:08 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:21:06 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 26/28] tests/qtest: add DM abstract command and halt/resume
 tests
Date: Sun,  8 Mar 2026 15:17:29 +0800
Message-ID: <c728e790d60d1d066e1c4de935afe8ee53e47ec2.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

Add the ROM simulation helpers (sim_cpu_going_ack,
sim_cpu_exception) and tests that exercise the abstract command
interface and hart-window registers in qtest mode:

  abstractauto              – auto-execute on data/progbuf write
  command-not-halted        – command rejected when hart running
  invalid-regno-exception   – out-of-range register access
  abstract-cmd-flow         – SMP abstract read/write cycle
  abstract-cmd-exception    – exception during abstract command
  hawindow                  – hart array window register
  haltsum0-window           – haltsum0 with 64-hart SMP
  haltsum1-window           – haltsum1 with 64-hart SMP

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 tests/qtest/riscv-dm-test.c | 315 ++++++++++++++++++++++++++++++++++++
 1 file changed, 315 insertions(+)

diff --git a/tests/qtest/riscv-dm-test.c b/tests/qtest/riscv-dm-test.c
index 3a0dd1cbd4..1b1ab02284 100644
--- a/tests/qtest/riscv-dm-test.c
+++ b/tests/qtest/riscv-dm-test.c
@@ -195,6 +195,24 @@ static void sim_cpu_resume_ack(QTestState *qts, uint32_t hartid)
     rom_write32(qts, ROM_RESUME, hartid);
 }
 
+/*
+ * Simulate the CPU executing the GOING acknowledgment.
+ * ROM code: detects GOING flag → writes 0 to GOING offset → jumps to cmd.
+ */
+static void sim_cpu_going_ack(QTestState *qts)
+{
+    rom_write32(qts, ROM_GOING, 0);
+}
+
+/*
+ * Simulate CPU hitting exception during abstract command.
+ * ROM exception handler writes 0 to EXCP offset.
+ */
+static void sim_cpu_exception(QTestState *qts)
+{
+    rom_write32(qts, ROM_EXCP, 0);
+}
+
 
 /*
  * Test: dmactive gate.
@@ -626,6 +644,293 @@ static void test_ackhavereset(void)
     qtest_quit(qts);
 }
 
+/*
+ * Test: Unsupported register numbers report CMDERR=EXCEPTION.
+ */
+static void test_invalid_regno_exception(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    uint32_t cmd, acs, cmderr;
+
+    dm_set_active(qts);
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+    sim_cpu_halt_ack(qts, 0);
+
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    cmd = (0u << 24) | (1u << 17) | (2u << 20) | 0x1040u;
+    dm_write(qts, A_COMMAND, cmd);
+
+    acs = dm_read(qts, A_ABSTRACTCS);
+    cmderr = (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    g_assert_cmpuint(cmderr, ==, 3);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: ABSTRACTAUTO read/write.
+ */
+static void test_abstractauto(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    dm_set_active(qts);
+
+    /* Write autoexec pattern */
+    dm_write(qts, A_ABSTRACTAUTO, 0x00030003);
+    g_assert_cmpuint(dm_read(qts, A_ABSTRACTAUTO), ==, 0x00030003);
+
+    /* Clear */
+    dm_write(qts, A_ABSTRACTAUTO, 0);
+    g_assert_cmpuint(dm_read(qts, A_ABSTRACTAUTO), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: COMMAND write when hart is not halted should set CMDERR.
+ */
+static void test_command_not_halted(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    dm_set_active(qts);
+
+    /* Clear any existing CMDERR */
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    /*
+     * Issue Access Register command (cmdtype=0, transfer=1, regno=0x1000)
+     * to a running hart. Should fail with HALTRESUME error (4).
+     */
+    uint32_t cmd = (0u << 24) |     /* cmdtype = Access Register */
+                   (1u << 17) |     /* transfer = 1 */
+                   (2u << 20) |     /* aarsize = 32-bit */
+                   0x1000;          /* regno = x0 */
+    dm_write(qts, A_COMMAND, cmd);
+
+    uint32_t acs = dm_read(qts, A_ABSTRACTCS);
+    uint32_t cmderr = (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    /* HALTRESUME error = 4 */
+    g_assert_cmpuint(cmderr, ==, 4);
+
+    /* Clear CMDERR */
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+    acs = dm_read(qts, A_ABSTRACTCS);
+    cmderr = (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    g_assert_cmpuint(cmderr, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: Abstract command execution flow (Access Register).
+ *
+ * With hart halted, issue an Access Register command:
+ * 1. Hart must be halted first
+ * 2. Write COMMAND → DM sets BUSY=1, writes instructions to CMD space,
+ *    sets FLAGS=GOING
+ * 3. Hart can keep reporting HALTED in the park loop before consuming GO
+ * 4. CPU ROM detects GOING → writes to GOING offset (ack) → jumps to cmd
+ * 5. CPU executes cmd → hits ebreak → re-enters ROM → writes HARTID
+ * 6. DM only completes after the selected hart returns to the park loop
+ */
+static void test_abstract_cmd_flow(void)
+{
+    QTestState *qts = qtest_init("-machine virt -smp 2");
+    dm_set_active(qts);
+
+    /* Halt both harts first. */
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+    sim_cpu_halt_ack(qts, 0);
+    sim_cpu_halt_ack(qts, 1);
+
+    uint32_t status = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(status & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+
+    /* Clear any latched CMDERR */
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    /*
+     * Issue Access Register command:
+     * cmdtype=0 (Access Register), transfer=1, write=0 (read),
+     * aarsize=2 (32-bit), regno=0x1000 (x0)
+     */
+    uint32_t cmd = (0u << 24) |     /* cmdtype = Access Register */
+                   (1u << 17) |     /* transfer = 1 */
+                   (2u << 20) |     /* aarsize = 32-bit */
+                   0x1000;          /* regno = x0 */
+    dm_write(qts, A_COMMAND, cmd);
+
+    /* BUSY should be set */
+    uint32_t acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, ABSTRACTCS_BUSY);
+
+    /*
+     * A different halted hart must not complete the command, and the selected
+     * hart must not complete it before GO has been consumed.
+     */
+    sim_cpu_halt_ack(qts, 1);
+    g_assert_cmpuint(dm_read(qts, A_ABSTRACTCS) & ABSTRACTCS_BUSY, ==,
+                     ABSTRACTCS_BUSY);
+    sim_cpu_halt_ack(qts, 0);
+    g_assert_cmpuint(dm_read(qts, A_ABSTRACTCS) & ABSTRACTCS_BUSY, ==,
+                     ABSTRACTCS_BUSY);
+
+    /* Simulate CPU: ROM detects GOING flag → writes GOING ack. */
+    sim_cpu_going_ack(qts);
+
+    /* Simulate CPU: execute cmd, hit ebreak, then re-enter ROM. */
+    sim_cpu_halt_ack(qts, 0);
+
+    /* BUSY should be cleared, no error */
+    acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, 0);
+    uint32_t cmderr =
+        (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    g_assert_cmpuint(cmderr, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: Abstract command exception path.
+ *
+ * When CPU hits an exception during abstract cmd execution:
+ * 1. ROM exception handler writes to EXCP offset
+ * 2. DM latches CMDERR=EXCEPTION(3) and stays busy until the hart parks again
+ * 3. CPU ebreak → re-enters ROM → writes HARTID (re-halt)
+ */
+static void test_abstract_cmd_exception(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    dm_set_active(qts);
+
+    /* Halt hart 0 */
+    dm_write(qts, A_DMCONTROL, DMCONTROL_DMACTIVE | DMCONTROL_HALTREQ);
+    sim_cpu_halt_ack(qts, 0);
+
+    /* Clear CMDERR */
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+
+    /* Issue Access Register command */
+    uint32_t cmd = (0u << 24) | (1u << 17) | (2u << 20) | 0x1000;
+    dm_write(qts, A_COMMAND, cmd);
+
+    g_assert_cmpuint(dm_read(qts, A_ABSTRACTCS) & ABSTRACTCS_BUSY, ==,
+                     ABSTRACTCS_BUSY);
+
+    /* CPU acknowledges going */
+    sim_cpu_going_ack(qts);
+
+    /* CPU hits exception during cmd execution → ROM exception handler */
+    sim_cpu_exception(qts);
+
+    /* BUSY stays set until the hart re-enters the park loop. */
+    uint32_t acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, ABSTRACTCS_BUSY);
+    uint32_t cmderr =
+        (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    g_assert_cmpuint(cmderr, ==, 3);  /* EXCEPTION */
+
+    /* CPU ebreak in exception handler → re-enters ROM → writes HARTID */
+    sim_cpu_halt_ack(qts, 0);
+
+    acs = dm_read(qts, A_ABSTRACTCS);
+    g_assert_cmpuint(acs & ABSTRACTCS_BUSY, ==, 0);
+
+    /* Hart should still be halted */
+    uint32_t st = dm_read(qts, A_DMSTATUS);
+    g_assert_cmpuint(st & DMSTATUS_ALLHALTED, ==, DMSTATUS_ALLHALTED);
+
+    /* Clear CMDERR for cleanup */
+    dm_write(qts, A_ABSTRACTCS, ABSTRACTCS_CMDERR_MASK);
+    acs = dm_read(qts, A_ABSTRACTCS);
+    cmderr = (acs & ABSTRACTCS_CMDERR_MASK) >> ABSTRACTCS_CMDERR_SHIFT;
+    g_assert_cmpuint(cmderr, ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: HAWINDOWSEL and HAWINDOW read/write.
+ */
+static void test_hawindow(void)
+{
+    QTestState *qts = qtest_init("-machine virt");
+    dm_set_active(qts);
+
+    /* Select window 0 */
+    dm_write(qts, A_HAWINDOWSEL, 0);
+    g_assert_cmpuint(dm_read(qts, A_HAWINDOWSEL), ==, 0);
+
+    /* Write a mask to HAWINDOW */
+    dm_write(qts, A_HAWINDOW, 0x5);
+    g_assert_cmpuint(dm_read(qts, A_HAWINDOW), ==, 0x5);
+
+    /* Clear */
+    dm_write(qts, A_HAWINDOW, 0);
+    g_assert_cmpuint(dm_read(qts, A_HAWINDOW), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: HALTSUM0 window follows hartsel[19:5].
+ */
+static void test_haltsum0_window(void)
+{
+    QTestState *qts = qtest_init("-machine virt -smp 64");
+    dm_set_active(qts);
+
+    /* Mark hart 40 halted. */
+    sim_cpu_halt_ack(qts, 40);
+
+    /* Window base 0: hart 40 is out of range 0..31. */
+    dm_write(qts, A_DMCONTROL,
+             DMCONTROL_DMACTIVE | (0u << DMCONTROL_HARTSELLO_SHIFT));
+    g_assert_cmpuint(dm_read(qts, A_HALTSUM0), ==, 0);
+
+    /* Window base 32: hart 40 maps to bit 8. */
+    dm_write(qts, A_DMCONTROL,
+             DMCONTROL_DMACTIVE | (32u << DMCONTROL_HARTSELLO_SHIFT));
+    g_assert_cmpuint(dm_read(qts, A_HALTSUM0), ==, (1u << 8));
+
+    qtest_quit(qts);
+}
+
+/*
+ * Test: HALTSUM1 window follows hartsel[19:10].
+ */
+static void test_haltsum1_window(void)
+{
+    QTestState *qts = qtest_init("-machine virt -smp 64");
+
+    dm_set_active(qts);
+
+    sim_cpu_halt_ack(qts, 33);
+
+    g_assert_cmpuint(dm_read(qts, A_HALTSUM1), ==, (1u << 1));
+
+    dm_write(qts, A_DMCONTROL,
+             DMCONTROL_DMACTIVE | (1u << DMCONTROL_HARTSELHI_SHIFT));
+    g_assert_cmpuint(dm_read(qts, A_HALTSUM1), ==, 0);
+
+    qtest_quit(qts);
+}
+
+/* TCG-mode tests: real CPU execution. */
+
+/*
+ * Test: Halt CPU with TCG and verify DPC/DCSR.
+ *
+ * With real CPU execution:
+ * 1. Boot CPU, let it run briefly
+ * 2. Send HALTREQ → CPU enters debug mode
+ * 3. Read DCSR via abstract command → verify cause = HALTREQ (3)
+ * 4. Read DPC via abstract command → verify it's a valid address
+ * 5. Resume CPU, then re-halt to verify the cycle works
+ */
+
 /*
  * Test: Halt and resume cycle via ROM simulation.
  *
@@ -691,7 +996,17 @@ int main(int argc, char *argv[])
     qtest_add_func("/riscv-dm/optional-regs-absent", test_optional_regs_absent);
     qtest_add_func("/riscv-dm/deactivate", test_deactivate);
     qtest_add_func("/riscv-dm/ackhavereset", test_ackhavereset);
+    qtest_add_func("/riscv-dm/abstractauto", test_abstractauto);
+    qtest_add_func("/riscv-dm/command-not-halted", test_command_not_halted);
+    qtest_add_func("/riscv-dm/invalid-regno-exception",
+                   test_invalid_regno_exception);
+    qtest_add_func("/riscv-dm/hawindow", test_hawindow);
+    qtest_add_func("/riscv-dm/haltsum0-window", test_haltsum0_window);
+    qtest_add_func("/riscv-dm/haltsum1-window", test_haltsum1_window);
     qtest_add_func("/riscv-dm/halt-resume", test_halt_resume);
+    qtest_add_func("/riscv-dm/abstract-cmd-flow", test_abstract_cmd_flow);
+    qtest_add_func("/riscv-dm/abstract-cmd-exception",
+                   test_abstract_cmd_exception);
 
     return g_test_run();
 }
-- 
2.53.0



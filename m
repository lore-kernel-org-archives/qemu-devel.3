Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CC9CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgc-0005Z3-16; Tue, 16 Jun 2026 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgX-0005Mx-7P
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:23 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgU-00037a-Kj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c858014845aso1730300a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604376; x=1782209176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsXPmccwUkq4P2yZLnV0pu8qbIMKOYnwmYV+wIhyJA8=;
 b=sgHa7st5mlNSNmG6JxUYK94d8o4PwUliXVJ8BQbBPxPSxkLKe9hiUAUzT/R0fTnKey
 h0rEMY3fGIJMeIry6QkAyhmUKgSnhhPtbqmbp7PiqVDhN85joaJgRwj+uXqChsGuRPOF
 8KFTwiJDd534xf6q7MGtS0mhoctYF6VPcx+KdlwruUmauWU14YL3Q7qDOTP9t9ScpE53
 TGqz+8T0vLrzLbR8MPZu/jh0oDgDM4hGW5bsvZKxumwckvPLdq9Ay7s1f4t3uMW+F40H
 4hkww7TamVyz3aY5qKq+g782Gnh7IAfxB88tgDSSEU8+48TkpNtREuWuOO8Gsbgp3z25
 0RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604376; x=1782209176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZsXPmccwUkq4P2yZLnV0pu8qbIMKOYnwmYV+wIhyJA8=;
 b=PKBcRvfyrBAd2yrRyacTmd5uKMXfmj5xMeaiCU+HGCKBPw7UurZnh6N86cuXm3O+rS
 yxw+34RiulS89ZhtxLU7yT10mXIU/Wb/RjxrrvKuTA+nq2w0kEePsLNUZYquI5bODaKk
 HebibIlP5PzZRxu+l1S9tIrtBkPZ470aKlX3dz0NSoQXg48uJz0u/v3RHXCuG080vaOh
 6fx2a2fU7wzRCDaSK6eaQOpOXBSYLdAeMt0shFY6/zpjJUyOqzdqtKC6YmoJ+Xlhe7OK
 lAo5nH6RuURK3YIMZ5YEjUTV9sgOvyFC4KNU3sfDUpH828N4+90Mo3f+a1aEfeazZwJP
 9i5w==
X-Gm-Message-State: AOJu0YzrRKcfXo+3OWawhLL+33GmzMACPnLPBqKcZZyv6r9SnA9ycIfx
 qI6qR9LlgD3fWFdqqeFE/eovEIDYp4rEbOmCPvsZmfyEn9/e3ey1JLHuah0yqJ3f
X-Gm-Gg: Acq92OFMAJea4td1P0DDo7ILkcehujLu6E5/ubYrzj81VGqlhvGyJZl2M0PAScMiQ42
 mp+XXoH7elSm5uUoujIh7zndAu6wcwQkoOZmJUwmaWMh5B+HbRsZ8ibIA9fG46FM2dbuLaREB4u
 BbUNvj5JvsVOMzwrOKgV2XwCYV67PoBwjsBbfOtmq898vfg49GykfYTvD9JfvxXrw0r1XeMO2pO
 bQZv62GPKwZSfZNpTAbu7F6gltMjM7SuBLYEKI21+yCtG+vWPwmvb6Ui2odtYCxsCmoxx9Ut3X/
 nTyYB+CW66shHIVJe8mSEoIAqHw1ielGtJ7BUhfdqIv0F7Uiv+yXkX9YNbG3yMYE5EAfEADppmp
 uiqfKgnvKuH5mPtRF9GuLg+0nqA4wZfnD47bH7xiWpW0oxxtEeTxCcMXzxMV2yFWj+nV2KWlp8P
 0TFsBqzlOQ6eHmWn+QUylsy+qQJ2Hk4LLxDAnGJuq/
X-Received: by 2002:a05:6a20:eec2:20b0:3b3:26fd:6cc7 with SMTP id
 adf61e73a8af0-3b7e225d78fmr1706651637.9.1781604376371; 
 Tue, 16 Jun 2026 03:06:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/83] target/riscv: Fix size of gpr and gprh
Date: Tue, 16 Jun 2026 20:04:15 +1000
Message-ID: <20260616100527.1939565-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
fixing their size to 64 bits makes sense.

gpr is also fixed to 64 bits since all direct uses of env->gpr
correctly zero extend/truncate to/from target_ulong, meaning
!TARGET_RISCV64 will behave as expected.

We do however need to be a bit careful when mapping 64-bit fields to
32-bit TCGv globals on big endian hosts.

Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260520125406.28693-2-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |  4 ++--
 target/riscv/cpu.c       |  2 +-
 target/riscv/machine.c   |  8 ++++----
 target/riscv/monitor.c   |  2 +-
 target/riscv/translate.c | 16 ++++++++++++++--
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f7d8a08c08..a440b03071 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -214,8 +214,8 @@ typedef struct PMUFixedCtrState {
 } PMUFixedCtrState;
 
 struct CPUArchState {
-    target_ulong gpr[32];
-    target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
+    uint64_t gpr[32];
+    uint64_t gprh[32]; /* 64 top bits of the 128-bit registers */
 
     /* vector coprocessor state. */
     uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5903df9954..a57884dbc9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -612,7 +612,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, " %-8s " TARGET_FMT_lx,
+        qemu_fprintf(f, " %-8s %" PRIx64,
                      riscv_int_regnames[i], env->gpr[i]);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index b92e38b11a..358320a7fe 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -178,11 +178,11 @@ static bool rv128_needed(void *opaque)
 
 static const VMStateDescription vmstate_rv128 = {
     .name = "cpu/rv128",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = rv128_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.gprh, RISCVCPU, 32),
         VMSTATE_UINT64(env.mscratchh, RISCVCPU),
         VMSTATE_UINT64(env.sscratchh, RISCVCPU),
         VMSTATE_END_OF_LIST()
@@ -449,7 +449,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
         VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 6380600241..9edac0533c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -248,7 +248,7 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
     const char * const *reg_names;
-    target_ulong *vals;
+    uint64_t *vals;
 
     if (is_gprh) {
         reg_names = riscv_int_regnamesh;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1e4f340256..640691e1c5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1469,12 +1469,24 @@ void riscv_translate_init(void)
      */
     cpu_gpr[0] = NULL;
     cpu_gprh[0] = NULL;
+    /*
+     * Be careful with big endian hosts when mapping 64-bit CPUArchState fields
+     * to 32-bit TCGv globals.  An offset of 4 bytes is applied so the least
+     * significant bytes are correctly written to.
+     */
+#if HOST_BIG_ENDIAN && !defined(TARGET_RISCV64)
+    size_t field_offset = 4;
+#else
+    size_t field_offset = 0;
+#endif
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPURISCVState, gpr[i]), riscv_int_regnames[i]);
+            offsetof(CPURISCVState, gpr[i]) + field_offset,
+            riscv_int_regnames[i]);
         cpu_gprh[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPURISCVState, gprh[i]), riscv_int_regnamesh[i]);
+            offsetof(CPURISCVState, gprh[i]) + field_offset,
+            riscv_int_regnamesh[i]);
     }
 
     for (i = 0; i < 32; i++) {
-- 
2.54.0



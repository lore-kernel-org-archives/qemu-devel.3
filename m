Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E63CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dJ-0006uM-6l; Tue, 26 Aug 2025 21:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cd-0004oU-KH
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cT-0007NC-DS
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-770530175b2so2642648b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256780; x=1756861580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1H6nYK+rCUktWEjNC8YJ7MqEHw0W3aRE6kWYyzhr2A=;
 b=kNw/4pLxb6refZUEMi4WPJ7cpDjJ5jqqWVPC2lzlA+7M1GWD8lvEmy41+PIBPiKcni
 aEtdU5r+pFtQ9+0yD1twFCJgRqQ/jcoKZwISsacSVZGmRKx1TJhR5ZiY9HLqY5c3sY7f
 gWv9NtV3BFsHY5/WfJ3vD72nrSfLTd7wUpVQyShI2W1EbExOEuTu3gCNrlpjqf5/cD9R
 Ku/qf+3BIr4kMIgfV6LBg4vK6H4Nfli0nax9ypvTUw18LV4KmOBq0szWeBY/KIANmeOF
 xnxKXI+QdlrcXOKagFXq4Qp5bzI7FmLSLa6IwghyERuuE8iU9Sho89rK7J4bLjwJCXlp
 5aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256780; x=1756861580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1H6nYK+rCUktWEjNC8YJ7MqEHw0W3aRE6kWYyzhr2A=;
 b=OcnoJwOFQm4BYytLgu8NK43fBgBJdSYlFoImM8D18wlQMD12L9gO1lVAbcrK3SMzyV
 BsEvuPGu62SAyGsdBcxZUmxDnpA9PiHBprVusmkyVXrNmiGmtujlqUpcX0f/MDDBVIAm
 QXCTMa798MmanbiSljhw7lJUOWuXy679vO3BbhjMQkymPh4ycJgezvhDzm31SoKO2Sex
 R3x31muuwNjMZ/+oPUmIiDSjzlhoQxGvWvIRGqRG4Irf7wg4zpLhfKYdS6TbVc2WAiKr
 Cf9kK49z0apLtGebIs20mn0m3RnxGGF9xfKxzXLuB1XEmg+EY8+VldfBI/2iFLI+lVpe
 +8cQ==
X-Gm-Message-State: AOJu0YxENu8F3KPtH7ZhM3+AWBHhZP3HyZ/cYI5n91svfGXbQQPi3YxW
 m7krPxZPIpZeEDOHbfai5N6DI31A0u/xRK89yFfL1HRlcAmgH+jsI0bOPiZrn3gqA4YR0RNKFVa
 3oRWrL00=
X-Gm-Gg: ASbGncuRmPydfwt+uuyFSH+WyHM6q6Gx+ubatOqWjvZmTRQ4QEo8nrVkYwkdSWjDUJ0
 jfpAc57MhU8pgS0PY5lldZtYIm4+znuS5iTnbsvvoA6RorvCB9DuY6qaDpn2pJltwGjkQm6vFy2
 8cEMVaNm5aHE+XAzIQqG0SVT3QMSAc2Dgr5bjdaexxJK0tWyu7MTCdLCf67swbxktmIEfLuF2/B
 cSx5qMCPhgG7IywkoFKL00kB9JhF3/BWc470ZgLln5kLczdPACykw5zm2w6pmmGAUz0VpiGACnQ
 xFaKD5F1dKh+DB+1kiicPSnTuVgbQoaNh3UQy7VJREEWa/9Ub/dQOEEDb3zR6an52dkU0sxOJiE
 PCxe6AFMQUe5Syzctn615QkGvWw==
X-Google-Smtp-Source: AGHT+IHMpZwZDyFEn5jj/pdWH7/Ienk5W6xylM9w1m52cMeEm0NG6/64zKrtAwvLQ/RHrMEZ57tNXg==
X-Received: by 2002:a05:6a00:b87:b0:771:e842:1de7 with SMTP id
 d2e1a72fcca58-771e85179b4mr11578843b3a.32.1756256780379; 
 Tue, 26 Aug 2025 18:06:20 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/61] target/arm: Replace cpreg_field_is_64bit with
 cpreg_field_type
Date: Wed, 27 Aug 2025 11:04:05 +1000
Message-ID: <20250827010453.4059782-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prepare for 128-bit fields by using a better query api.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h  | 10 ++++++----
 target/arm/gdbstub.c |  7 +++++--
 target/arm/helper.c  | 18 +++++++++++++-----
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 812fb1340a..b6c8eff0dd 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -22,6 +22,7 @@
 #define TARGET_ARM_CPREGS_H
 
 #include "hw/registerfields.h"
+#include "exec/memop.h"
 #include "target/arm/kvm-consts.h"
 #include "cpu.h"
 
@@ -1053,12 +1054,13 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
 void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
 
 /*
- * Return true if this reginfo struct's field in the cpu state struct
- * is 64 bits wide.
+ * Return MO_32 if the field in CPUARMState is uint32_t or
+ * MO_64 if the field in CPUARMState is uint64_t.
  */
-static inline bool cpreg_field_is_64bit(const ARMCPRegInfo *ri)
+static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)
 {
-    return (ri->state == ARM_CP_STATE_AA64) || (ri->type & ARM_CP_64BIT);
+    return (ri->state == ARM_CP_STATE_AA64 || (ri->type & ARM_CP_64BIT)
+            ? MO_64 : MO_32);
 }
 
 static inline bool cp_access_ok(int current_el,
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c..e2fc389170 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -247,10 +247,13 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
-        if (cpreg_field_is_64bit(ri)) {
+        switch (cpreg_field_type(ri)) {
+        case MO_64:
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
-        } else {
+        case MO_32:
             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
+        default:
+            g_assert_not_reached();
         }
     }
     return 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3a9d8f0ddc..c4103d958a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -63,20 +63,28 @@ int compare_u64(const void *a, const void *b)
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
-    if (cpreg_field_is_64bit(ri)) {
+    switch (cpreg_field_type(ri)) {
+    case MO_64:
         return CPREG_FIELD64(env, ri);
-    } else {
+    case MO_32:
         return CPREG_FIELD32(env, ri);
+    default:
+        g_assert_not_reached();
     }
 }
 
 void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     assert(ri->fieldoffset);
-    if (cpreg_field_is_64bit(ri)) {
+    switch (cpreg_field_type(ri)) {
+    case MO_64:
         CPREG_FIELD64(env, ri) = value;
-    } else {
+        break;
+    case MO_32:
         CPREG_FIELD32(env, ri) = value;
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2748,7 +2756,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
     /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
-    if (cpreg_field_is_64bit(ri) &&
+    if (cpreg_field_type(ri) == MO_64 &&
         extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
         ARMCPU *cpu = env_archcpu(env);
         tlb_flush(CPU(cpu));
-- 
2.43.0



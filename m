Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C364EEC2B0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXw-0008M2-QZ; Mon, 23 Feb 2026 18:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXu-00086I-IH
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:58 -0500
Received: from qs-2003c-snip4-11.eps.apple.com ([57.103.86.33]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXr-0004Vt-5c
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:57 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 7833618000BD; Mon, 23 Feb 2026 23:40:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890054; x=1774482054;
 bh=9dhd5fHzSOBpg7XkWlWLkc9SOXPVIZnS8i4FgPjGXEs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dAnjrOBAXpbENhDtBc/u6ZpHWs9H3pRmA7uZhcvWLdGMEI5hqDyTOZFzC7hmxeR0o7UPXbX6SCa60jgQnwBsvUcrC0N9StmzRxbIylZpsiFz435EOIqZ+2/4VLZBIMMb27s/6B2eqNdmvelNtkoyvajiwXKKKljpnOxHfPsiJr4EtzASR+SrNORwVKzTpGtgleEycyS4CPMAY6UAg6VMr89jcbzpUUoyqqBoCv6EdCtIDr0IQwEJcQt2xRFpuDnH0pzN4af7ub0Ep4TF3qGgllQnWANJ3syAYVHqUt5HIicCdYJkwXCWF0AaSm9s+RGeP84UWksc+T7aibsIN/N0bg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 B96BA18003A5; Mon, 23 Feb 2026 23:40:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 28/28] target/i386: emulate: propagate errors all the way
 and stop early
Date: Tue, 24 Feb 2026 00:39:50 +0100
Message-ID: <20260223233950.96076-29-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UDnoxqFzbEL_Zb5XF68hDwBLnBi6Anb_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfXyL4uUS6YFnM+
 mHeAlNH+ulBHQY7yNyyo7XP3Vb+rgXAH48cT08MgEXBsHkcT6ac5I3paTA+v5X3X1KoElChnboP
 KMNEgmS8HqES/gf3o/soVrAgZGsg6kZ0x5l38cD1z5Ratff9ymRzMNPoGuvaaiSUfbrTH9rP/1/
 xo+H3G3GEFX1eJrFoBujGPvOW8VxoxQiMw1ozp93y/HtDLLamenX2RiF2VCmCeaeALr00pOlK6C
 xvxDb0/wk0PtX4IlqyM4CY/GurFlzkDaE0oEmWUsk2LbLJvnUlkMfeadYG9JUZ8AaFFD6iwGMCn
 cRzB5py3enuKdGvHcqsxk1v8tRy514UWywKsGPXS7pQi/uF7wf6spid3IBdCBw=
X-Authority-Info-Out: v=2.4 cv=Tv/rRTXh c=1 sm=1 tr=0 ts=699ce584
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NosfXZAncUfFzFm2AdAA:9
X-Proofpoint-GUID: UDnoxqFzbEL_Zb5XF68hDwBLnBi6Anb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=823 adultscore=0
 lowpriorityscore=0 clxscore=1030 mlxscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABUtWIJe0RhnjQahhKaBD3OXztWDWq6CYYlgXDtd10PjYANYhMoJ4FTmKpnmVuY7qtu4/0vEqEsUC79l2GOuqhjeM2PbKTn/sTaF8czcFqzLp5fOYvdPrh7qpShn7IqSpY0AYpcpLo/aLPFpr4rRE/PJ73zCmDk4ub8O6Nn9dorYOUZj3IzDVq+MoU+60BxXgz5V0cgdJxFdSVqDKb3Qs0wAyPUQ9NBdERv3cPiA+H402+WNcd9j7cv0XqjXb+e58uP8m8W8LlT+m+vZqiGMbqOMrwx/zfh52I+OQpABqqaehm3bm/hUTzjBnxXm2rc7xZTwb7x9n/WkQeQpU5WKrKAByAnvGl4Uqrn1l/6vHwxPXN869GEfz81EnJeXhqpEtudhijOtfZcL2ffbd/X5fqcP0yIHB5bpCzJIxhwDCwbkYHLN4/xikyfOqU0uLmXSBNPeYm9KtFN2MG04BEcHC2MXo2CUdnkYgukg1nu+SWs/7ob47UrKimainD3A8dmL4YIhmFhA4TX7a+hxMT2qaNHxXF6Z09uV1xIjOYNzMXH2BEBKt4kjk54ScOyU6z93nZoOHdcwL/kmfKkAhcxV3vlgyT6MOYEPwFXJa5JH55W5HDyCGwVQ+VWlPx7T85NBlxZhAIra6RB6HXVVXe4xlNvnEku21dPbhhzgC5YFjW42dXzn/S7evfJh+dF0nYi3lLhbXsOHXI80sHfXyzC6wrrBE9pfm6f82cyuh8khYoIRpllQzyswvB2LIM89R04uSCDxO6YBookRfN5FIqUlXzYIBoTfdkI+ryvRo=
Received-SPF: pass client-ip=57.103.86.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This ended up being a bigger patch than I thought it'd be...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 227 ++++++++++++++++++++++------------
 target/i386/emulate/x86_emu.h |  18 +--
 2 files changed, 160 insertions(+), 85 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index ec6bc798a4..8d35f3338c 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -47,7 +47,9 @@
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
-    fetch_operands(env, decode, 2, true, true, false);  \
+    if (fetch_operands(env, decode, 2, true, true, false))  {\
+        return 1; \
+    }\
     switch (decode->operand_size) {                     \
     case 1:                                         \
     {                                               \
@@ -55,7 +57,7 @@
         uint8_t v2 = (uint8_t)decode->op[1].val;    \
         uint8_t diff = v1 cmd v2;                   \
         if (save_res) {                              \
-            write_val_ext(env, &decode->op[0], diff, 1);  \
+            if (write_val_ext(env, &decode->op[0], diff, 1)) { return 1; }  \
         } \
         FLAGS_FUNC##8(env, v1, v2, diff);           \
         break;                                      \
@@ -66,7 +68,7 @@
         uint16_t v2 = (uint16_t)decode->op[1].val;  \
         uint16_t diff = v1 cmd v2;                  \
         if (save_res) {                              \
-            write_val_ext(env, &decode->op[0], diff, 2); \
+            if (write_val_ext(env, &decode->op[0], diff, 2)) { return 1; } \
         } \
         FLAGS_FUNC##16(env, v1, v2, diff);          \
         break;                                      \
@@ -77,7 +79,7 @@
         uint32_t v2 = (uint32_t)decode->op[1].val;  \
         uint32_t diff = v1 cmd v2;                  \
         if (save_res) {                              \
-            write_val_ext(env, &decode->op[0], diff, 4); \
+            if (write_val_ext(env, &decode->op[0], diff, 4)) { return 1; } \
         } \
         FLAGS_FUNC##32(env, v1, v2, diff);          \
         break;                                      \
@@ -167,13 +169,20 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
     }
 }
 
-void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
+bool write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
 {
     if (decode->type == X86_VAR_REG) {
         write_val_to_reg(decode->regptr, val, size);
     } else {
-        x86_write_mem(env_cpu(env), &val, decode->addr, size);
+        MMUTranslateResult res = x86_write_mem(env_cpu(env), &val, decode->addr, size);
+        if (res) {
+            if (res == MMU_TRANSLATE_GPA_UNMAPPED) {
+                return 0;
+            }
+            return 1;
+        }
     }
+    return 0;
 }
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
@@ -218,20 +227,19 @@ static bool read_val_from_mem(CPUX86State *env, target_long ptr, int size, targe
     return 0;
 }
 
-target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size)
+bool read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size, target_ulong* val)
 {
-    target_ulong val;
     if (decode->type == X86_VAR_REG) {
-        return read_val_from_reg(decode->regptr, size);
+        *val = read_val_from_reg(decode->regptr, size);
     } else {
-        if (read_val_from_mem(env, decode->addr, size, &val)) {
-            error_report("target/i386/emulate: read_val_ext: reading from unmapped address.");
+        if (read_val_from_mem(env, decode->addr, size, val)) {
+            return 1;
         }
-        return val;
     }
+    return 0;
 }
 
-static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
+static bool fetch_operands(CPUX86State *env, struct x86_decode *decode,
                            int n, bool val_op0, bool val_op1, bool val_op2)
 {
     int i;
@@ -251,8 +259,10 @@ static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
         case X86_VAR_RM:
             calc_modrm_operand(env, decode, &decode->op[i]);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_ext(env, &decode->op[i],
-                                                 decode->operand_size);
+                if (read_val_ext(env, &decode->op[i],decode->operand_size,
+                                                            &decode->op[i].val)) {
+                    return 1;
+                }
             }
             break;
         case X86_VAR_OFFSET:
@@ -260,68 +270,81 @@ static void fetch_operands(CPUX86State *env, struct x86_decode *decode,
                                                     decode->op[i].addr,
                                                     R_DS);
             if (calc_val[i]) {
-                decode->op[i].val = read_val_ext(env, &decode->op[i],
-                                                 decode->operand_size);
+                if (read_val_ext(env, &decode->op[i], decode->operand_size,
+                                                 &decode->op[i].val)) {
+                    return 1;
+                }
             }
             break;
         default:
             break;
         }
     }
+    return 0;
 }
 
-static void exec_mov(CPUX86State *env, struct x86_decode *decode)
+static bool exec_mov(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 2, false, true, false);
-    write_val_ext(env, &decode->op[0], decode->op[1].val,
-                  decode->operand_size);
+    if (write_val_ext(env, &decode->op[0], decode->op[1].val,
+                  decode->operand_size)) {
+        return 1;
+    }
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_add(CPUX86State *env, struct x86_decode *decode)
+static bool exec_add(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_or(CPUX86State *env, struct x86_decode *decode)
+static bool exec_or(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_adc(CPUX86State *env, struct x86_decode *decode)
+static bool exec_adc(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_sbb(CPUX86State *env, struct x86_decode *decode)
+static bool exec_sbb(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_and(CPUX86State *env, struct x86_decode *decode)
+static bool exec_and(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_sub(CPUX86State *env, struct x86_decode *decode)
+static bool exec_sub(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_xor(CPUX86State *env, struct x86_decode *decode)
+static bool exec_xor(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_neg(CPUX86State *env, struct x86_decode *decode)
+static bool exec_neg(CPUX86State *env, struct x86_decode *decode)
 {
     /*EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);*/
     int32_t val;
@@ -342,15 +365,17 @@ static void exec_neg(CPUX86State *env, struct x86_decode *decode)
 
     /*lflags_to_rflags(env);*/
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_cmp(CPUX86State *env, struct x86_decode *decode)
+static bool exec_cmp(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_inc(CPUX86State *env, struct x86_decode *decode)
+static bool exec_inc(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = 0;
@@ -358,33 +383,37 @@ static void exec_inc(CPUX86State *env, struct x86_decode *decode)
     EXEC_2OP_FLAGS_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_dec(CPUX86State *env, struct x86_decode *decode)
+static bool exec_dec(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = 0;
 
     EXEC_2OP_FLAGS_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_tst(CPUX86State *env, struct x86_decode *decode)
+static bool exec_tst(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_not(CPUX86State *env, struct x86_decode *decode)
+static bool exec_not(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 1, true, false, false);
 
     write_val_ext(env, &decode->op[0], ~decode->op[0].val,
                   decode->operand_size);
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_movzx(CPUX86State *env, struct x86_decode *decode)
+bool exec_movzx(CPUX86State *env, struct x86_decode *decode)
 {
     int src_op_size;
     int op_size = decode->operand_size;
@@ -398,13 +427,16 @@ void exec_movzx(CPUX86State *env, struct x86_decode *decode)
     }
     decode->operand_size = src_op_size;
     calc_modrm_operand(env, decode, &decode->op[1]);
-    decode->op[1].val = read_val_ext(env, &decode->op[1], src_op_size);
+    if (read_val_ext(env, &decode->op[1], src_op_size, &decode->op[1].val)) {
+        return 1;
+    }
     write_val_ext(env, &decode->op[0], decode->op[1].val, op_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_out(CPUX86State *env, struct x86_decode *decode)
+static bool exec_out(CPUX86State *env, struct x86_decode *decode)
 {
     switch (decode->opcode[0]) {
     case 0xe6:
@@ -426,9 +458,10 @@ static void exec_out(CPUX86State *env, struct x86_decode *decode)
         break;
     }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_in(CPUX86State *env, struct x86_decode *decode)
+static bool exec_in(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong val = 0;
     switch (decode->opcode[0]) {
@@ -463,6 +496,7 @@ static void exec_in(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 static inline void string_increment_reg(CPUX86State *env, int reg,
@@ -523,7 +557,7 @@ static bool exec_ins_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_ins(CPUX86State *env, struct x86_decode *decode)
+static bool exec_ins(CPUX86State *env, struct x86_decode *decode)
 {
     bool res;
     if (decode->rep) {
@@ -533,9 +567,10 @@ static void exec_ins(CPUX86State *env, struct x86_decode *decode)
     }
 
     if (res) {
-        return;
+        return 1;
     }
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_outs_single(CPUX86State *env, struct x86_decode *decode)
@@ -551,7 +586,7 @@ static bool exec_outs_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_outs(CPUX86State *env, struct x86_decode *decode)
+static bool exec_outs(CPUX86State *env, struct x86_decode *decode)
 {
     bool res;
     if (decode->rep) {
@@ -561,9 +596,10 @@ static void exec_outs(CPUX86State *env, struct x86_decode *decode)
     }
 
     if (res) {
-        return;
+        return 1;
     }
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_movs_single(CPUX86State *env, struct x86_decode *decode)
@@ -590,7 +626,7 @@ static bool exec_movs_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_movs(CPUX86State *env, struct x86_decode *decode)
+static bool exec_movs(CPUX86State *env, struct x86_decode *decode)
 {
     bool res;
     if (decode->rep) {
@@ -600,9 +636,10 @@ static void exec_movs(CPUX86State *env, struct x86_decode *decode)
     }
 
     if (res) {
-        return;
+        return 1;
     }
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
@@ -630,7 +667,7 @@ static bool exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
+static bool exec_cmps(CPUX86State *env, struct x86_decode *decode)
 {
     if (decode->rep) {
         string_rep(env, decode, exec_cmps_single, decode->rep);
@@ -638,6 +675,7 @@ static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
         exec_cmps_single(env, decode);
     }
     env->eip += decode->len;
+    return 0;
 }
 
 
@@ -660,7 +698,7 @@ static bool exec_stos_single(CPUX86State *env, struct x86_decode *decode)
 }
 
 
-static void exec_stos(CPUX86State *env, struct x86_decode *decode)
+static bool exec_stos(CPUX86State *env, struct x86_decode *decode)
 {
     if (decode->rep) {
         string_rep(env, decode, exec_stos_single, 0);
@@ -669,6 +707,7 @@ static void exec_stos(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
@@ -685,7 +724,7 @@ static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_scas(CPUX86State *env, struct x86_decode *decode)
+static bool exec_scas(CPUX86State *env, struct x86_decode *decode)
 {
     decode->op[0].type = X86_VAR_REG;
     decode->op[0].reg = R_EAX;
@@ -696,6 +735,7 @@ static void exec_scas(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
@@ -711,7 +751,7 @@ static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     return 0;
 }
 
-static void exec_lods(CPUX86State *env, struct x86_decode *decode)
+static bool exec_lods(CPUX86State *env, struct x86_decode *decode)
 {
     if (decode->rep) {
         string_rep(env, decode, exec_lods_single, 0);
@@ -720,6 +760,7 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     }
 
     env->eip += decode->len;
+    return 0;
 }
 
 void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_code)
@@ -730,23 +771,25 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
     env->exception_injected = 1;
 }
 
-static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
+static bool exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
     emul_ops->simulate_rdmsr(env_cpu(env));
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
+static bool exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
     emul_ops->simulate_wrmsr(env_cpu(env));
     env->eip += decode->len;
+    return 0;
 }
 
 /*
  * flag:
  * 0 - bt, 1 - btc, 2 - bts, 3 - btr
  */
-static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
+static bool do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
 {
     int32_t displacement;
     uint8_t index;
@@ -755,7 +798,9 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
 
     VM_PANIC_ON(decode->rex.rex);
 
-    fetch_operands(env, decode, 2, false, true, false);
+    if (fetch_operands(env, decode, 2, false, true, false)) {
+        return 1;
+    }
     index = decode->op[1].val & mask;
 
     if (decode->op[0].type != X86_VAR_REG) {
@@ -769,14 +814,16 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
             VM_PANIC("bt 64bit\n");
         }
     }
-    decode->op[0].val = read_val_ext(env, &decode->op[0],
-                                     decode->operand_size);
+    if (read_val_ext(env, &decode->op[0],
+                                     decode->operand_size, &decode->op[0].val)) {
+        return 1;
+    }
     cf = (decode->op[0].val >> index) & 0x01;
 
     switch (flag) {
     case 0:
         set_CF(env, cf);
-        return;
+        return 0;
     case 1:
         decode->op[0].val ^= (1u << index);
         break;
@@ -787,41 +834,58 @@ static void do_bt(CPUX86State *env, struct x86_decode *decode, int flag)
         decode->op[0].val &= ~(1u << index);
         break;
     }
-    write_val_ext(env, &decode->op[0], decode->op[0].val,
-                  decode->operand_size);
+    if (write_val_ext(env, &decode->op[0], decode->op[0].val,
+                  decode->operand_size)) {
+        return 1;
+    }
     set_CF(env, cf);
+    return 0;
 }
 
-static void exec_bt(CPUX86State *env, struct x86_decode *decode)
+static bool exec_bt(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 0);
+    if (do_bt(env, decode, 0)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_btc(CPUX86State *env, struct x86_decode *decode)
+static bool exec_btc(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 1);
+    if (do_bt(env, decode, 1)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_btr(CPUX86State *env, struct x86_decode *decode)
+static bool exec_btr(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 3);
+    if (do_bt(env, decode, 3)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_bts(CPUX86State *env, struct x86_decode *decode)
+static bool exec_bts(CPUX86State *env, struct x86_decode *decode)
 {
-    do_bt(env, decode, 2);
+    if (do_bt(env, decode, 2)) {
+        return 1;
+    }
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_shl(CPUX86State *env, struct x86_decode *decode)
+bool exec_shl(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
     int of = 0, cf = 0;
 
-    fetch_operands(env, decode, 2, true, true, false);
+    if (fetch_operands(env, decode, 2, true, true, false)) {
+        return 1;
+    }
 
     count = decode->op[1].val;
     count &= 0x1f;      /* count is masked to 5 bits*/
@@ -878,12 +942,14 @@ void exec_shl(CPUX86State *env, struct x86_decode *decode)
 exit:
     /* lflags_to_rflags(env); */
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_movsx(CPUX86State *env, struct x86_decode *decode)
+bool exec_movsx(CPUX86State *env, struct x86_decode *decode)
 {
     int src_op_size;
     int op_size = decode->operand_size;
+    target_ulong val;
 
     fetch_operands(env, decode, 2, false, false, false);
 
@@ -895,15 +961,18 @@ void exec_movsx(CPUX86State *env, struct x86_decode *decode)
 
     decode->operand_size = src_op_size;
     calc_modrm_operand(env, decode, &decode->op[1]);
-    decode->op[1].val = sign(read_val_ext(env, &decode->op[1], src_op_size),
-                             src_op_size);
+    if (read_val_ext(env, &decode->op[1], src_op_size, &val)) {
+        return 1;
+    }
+    decode->op[1].val = sign(val, src_op_size);
 
     write_val_ext(env, &decode->op[0], decode->op[1].val, op_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_ror(CPUX86State *env, struct x86_decode *decode)
+bool exec_ror(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
 
@@ -979,9 +1048,10 @@ void exec_ror(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_rol(CPUX86State *env, struct x86_decode *decode)
+bool exec_rol(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
 
@@ -1060,10 +1130,11 @@ void exec_rol(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
 
-void exec_rcl(CPUX86State *env, struct x86_decode *decode)
+bool exec_rcl(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
     int of = 0, cf = 0;
@@ -1146,9 +1217,10 @@ void exec_rcl(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
-void exec_rcr(CPUX86State *env, struct x86_decode *decode)
+bool exec_rcr(CPUX86State *env, struct x86_decode *decode)
 {
     uint8_t count;
     int of = 0, cf = 0;
@@ -1221,9 +1293,10 @@ void exec_rcr(CPUX86State *env, struct x86_decode *decode)
         }
     }
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_xchg(CPUX86State *env, struct x86_decode *decode)
+static bool exec_xchg(CPUX86State *env, struct x86_decode *decode)
 {
     fetch_operands(env, decode, 2, true, true, false);
 
@@ -1233,20 +1306,22 @@ static void exec_xchg(CPUX86State *env, struct x86_decode *decode)
                   decode->operand_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
-static void exec_xadd(CPUX86State *env, struct x86_decode *decode)
+static bool exec_xadd(CPUX86State *env, struct x86_decode *decode)
 {
     EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
     write_val_ext(env, &decode->op[1], decode->op[0].val,
                   decode->operand_size);
 
     env->eip += decode->len;
+    return 0;
 }
 
 static struct cmd_handler {
     enum x86_decode_cmd cmd;
-    void (*handler)(CPUX86State *env, struct x86_decode *ins);
+    bool (*handler)(CPUX86State *env, struct x86_decode *ins);
 } handlers[] = {
     {X86_DECODE_CMD_INVL, NULL,},
     {X86_DECODE_CMD_MOV, exec_mov},
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 6b69111822..0f284b0c3d 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -44,15 +44,15 @@ target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
 target_ulong read_val_from_reg(void *reg_ptr, int size);
 void write_val_to_reg(void *reg_ptr, target_ulong val, int size);
-void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
+bool write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size);
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes);
-target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size);
+bool read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size, target_ulong* val);
 
-void exec_movzx(CPUX86State *env, struct x86_decode *decode);
-void exec_shl(CPUX86State *env, struct x86_decode *decode);
-void exec_movsx(CPUX86State *env, struct x86_decode *decode);
-void exec_ror(CPUX86State *env, struct x86_decode *decode);
-void exec_rol(CPUX86State *env, struct x86_decode *decode);
-void exec_rcl(CPUX86State *env, struct x86_decode *decode);
-void exec_rcr(CPUX86State *env, struct x86_decode *decode);
+bool exec_movzx(CPUX86State *env, struct x86_decode *decode);
+bool exec_shl(CPUX86State *env, struct x86_decode *decode);
+bool exec_movsx(CPUX86State *env, struct x86_decode *decode);
+bool exec_ror(CPUX86State *env, struct x86_decode *decode);
+bool exec_rol(CPUX86State *env, struct x86_decode *decode);
+bool exec_rcl(CPUX86State *env, struct x86_decode *decode);
+bool exec_rcr(CPUX86State *env, struct x86_decode *decode);
 #endif
-- 
2.50.1 (Apple Git-155)



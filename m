Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F8EEC2AF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXo-0007Uk-UB; Mon, 23 Feb 2026 18:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXh-0007CA-EX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:45 -0500
Received: from qs-2003e-snip4-11.eps.apple.com ([57.103.86.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXf-0004So-CU
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:45 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 DE93F180013D; Mon, 23 Feb 2026 23:40:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890042; x=1774482042;
 bh=8lWyOuVCcGGioNbVw71HVs6bSP2v/9u2T1YesulTLJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g4hhUEv6lj7pHihZ6bp7WKpUUUPpBGb19LcolL+h6mzPArZy0F6zqVpG04XBJTgeNxWSWJYiSlar1yGUylwEFKtsyloYFc5DJOq1V0uX36C7hkrjiMz/zIlJ8Y8WEiGdcAiR5TvgpQD7OfHXGstSIYn0j/+ml8YCYfHK24PcFw1k5VQFAKWtkT/RvKFuyvJd2S1+9Qkmr4UGvEogjJrQnCs8pdPehaLqpe+7Xj2y6eXg+ZS+VjlsnH0q5OAc4iBye9fmPsI19WKBlo7yLEndpkmOP+EL8WX6FyB2W06ob4Xx2PofQTM/ImiGOLpgQRH2mYVsSX56wPEig4DnEkfUTQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 F1B9318000BD; Mon, 23 Feb 2026 23:40:39 +0000 (UTC)
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
Subject: [PATCH v6 24/28] target/i386: emulate: propagate memory errors on
 most reads/writes
Date: Tue, 24 Feb 2026 00:39:46 +0100
Message-ID: <20260223233950.96076-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N_OyOp_tIbdH682L17foWDMHRM_m68iW
X-Authority-Info-Out: v=2.4 cv=D79K6/Rj c=1 sm=1 tr=0 ts=699ce57a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yuK-eIj46yw4D_dHqGMA:9
X-Proofpoint-GUID: N_OyOp_tIbdH682L17foWDMHRM_m68iW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX0umWNwi2hk/z
 +yGVJOx43F2dNX0my63VYWR2HOFg6wWjCvFMoxpJ30efKQca+s6SGOXiDae2TGljSrbjN+purfV
 LL6qagUbsCj+M+mbl1nk7P3aTR5hm6K4OS/Sv460r4SO4Na00xrfvMfVPhob/xR+YRt2IhTKYzs
 lRJck/JcTZxtaRVRKwdq+vooN+KGDkQ2ImjhrXiFx4ehLNOB3RbbQIasSxXZV5oqY1pleDFSS8y
 UNkYzEDq+awcmgVUjX0PxOpSwRZguP51/lo//4P9euLUH053I5TtQ/c6TaxuDaAKyqE5Wg0TZpJ
 gOxmRK1wKSy/Ax2T7sL+2NML2rZB1tAJx+HDdAzbrm47tSkr1+0RWg4zNknP7I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=974 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABLmFbh5V5N80jNAGzd/7493y9bHFm3o2og5Rh28v+1BhBnNsCjbcUX3x4Fgri6OdFTzwXW4t+QD1ElA+524xXb8XfdXtbch7kW9Lc3Qk01A8G5RUKZyFuZoZLpIYOPNXYVdItQ8k21WJE3e81PKUi4Or/lA7aOUwIa3OERJgc/pgKztHNIwPjOBZZ1ARpLQ9frWWJWpxgGHnOf4Hhez2cawbU9bze33uVYbRxgR21eet494WE3xPm4nFYkGh+MJzFC6wPo5aJaN7EZWB9DARYccRtm6Vhdw3vcwhwDpC65xcO+wGwBbGCXdQTSQ+BR/NKEgyJcLsnwcmQC7ZSFyKpitALwsTlzzPZWh8cpkC9zFbksmyEiY+5rNsyiRla8m2YCT8Ih5fncN1uwtypdn0rpXc6pbxVXRVZMLNV1xthTWC2lWnSActKfNHWpDL90GQGKi1+jAJ1Jz0bLdhvH0G079ac/xsH/FqSG07bAuuH5i6QLqvlBMVmN+XOcFw3SB6BcrOAHNeh1TKANuMl3sRuKQ/tJdPfF09VZ4eiaI7qlVZmHWwXMzlSzkXIMdZFvoNtVy99eSG1s9R2p6qFv+pvCcYhN21z7QncEq438DXh2SJeV+gPFv41xEKmgPLhtHlbd79//5SO143gRJVA3b0N3CJzi/7bwin5NSNgMDZKJ/vNx0kC6j5zbhNhTtESOkPf0WKdHhJrLKJKj9atm2a7Ra+pegF7M7PjMXwJgDmcCmE2740AjZ8CAgJbdKBglg/luOFxlXMgM6vs166F1+lNpNK3Ha6BiFJFW/QB
Received-SPF: pass client-ip=57.103.86.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use that to not bump RIP for those cases.

Warn on read/write from/to unmapped MMIO, but not consider that as an exception.
For reads, return 0xFF(s) as the register value in that case.

Leaves a coverage gap for read_val_ext(), to be handled in a later commit.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 119 +++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 31 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 3aedd638a1..ec6bc798a4 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -36,11 +36,14 @@
 /////////////////////////////////////////////////////////////////////////
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "panic.h"
 #include "x86_decode.h"
 #include "x86.h"
 #include "x86_emu.h"
 #include "x86_flags.h"
+#include "x86_mmu.h"
+
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
@@ -175,43 +178,56 @@ void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    MMUTranslateResult res = x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    if (res) {
+        if (res == MMU_TRANSLATE_GPA_UNMAPPED) {
+            memset(env->emu_mmio_buf, 0xFF, bytes);
+            return env->emu_mmio_buf;
+        }
+        return NULL;
+    }
     return env->emu_mmio_buf;
 }
 
 
-static target_ulong read_val_from_mem(CPUX86State *env, target_long ptr, int size)
+static bool read_val_from_mem(CPUX86State *env, target_long ptr, int size, target_ulong* val)
 {
-    target_ulong val;
     uint8_t *mmio_ptr;
 
     mmio_ptr = read_mmio(env, ptr, size);
+    if (mmio_ptr == NULL) {
+        return 1;
+    }
     switch (size) {
     case 1:
-        val = *(uint8_t *)mmio_ptr;
+        *val = *(uint8_t *)mmio_ptr;
         break;
     case 2:
-        val = *(uint16_t *)mmio_ptr;
+        *val = *(uint16_t *)mmio_ptr;
         break;
     case 4:
-        val = *(uint32_t *)mmio_ptr;
+        *val = *(uint32_t *)mmio_ptr;
         break;
     case 8:
-        val = *(uint64_t *)mmio_ptr;
+        *val = *(uint64_t *)mmio_ptr;
         break;
     default:
         VM_PANIC("bad size\n");
         break;
     }
-    return val;
+    return 0;
 }
 
 target_ulong read_val_ext(CPUX86State *env, struct x86_decode_op *decode, int size)
 {
+    target_ulong val;
     if (decode->type == X86_VAR_REG) {
         return read_val_from_reg(decode->regptr, size);
     } else {
-        return read_val_from_mem(env, decode->addr, size);
+        if (read_val_from_mem(env, decode->addr, size, &val)) {
+            error_report("target/i386/emulate: read_val_ext: reading from unmapped address.");
+        }
+        return val;
     }
 }
 
@@ -465,15 +481,17 @@ static inline int get_ZF(CPUX86State *env) {
     return env->cc_dst ? 0 : CC_Z;
 }
 
-static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
-                              void (*func)(CPUX86State *env,
+static inline bool string_rep(CPUX86State *env, struct x86_decode *decode,
+                              bool (*func)(CPUX86State *env,
                                            struct x86_decode *ins), int rep)
 {
     target_ulong rcx = read_reg(env, R_ECX, decode->addressing_size);
 
     while (rcx != 0) {
         bool is_cmps_or_scas = decode->cmd == X86_DECODE_CMD_CMPS || decode->cmd == X86_DECODE_CMD_SCAS;
-        func(env, decode);
+        if (func(env, decode)) {
+            return 1;
+        }
         rcx--;
         write_reg(env, R_ECX, rcx, decode->addressing_size);
         if ((PREFIX_REP == rep) && !get_ZF(env) && is_cmps_or_scas) {
@@ -483,33 +501,44 @@ static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
             break;
         }
     }
+    return 0;
 }
 
-static void exec_ins_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_ins_single(CPUX86State *env, struct x86_decode *decode)
 {
+    MMUTranslateResult res;
+
     target_ulong addr = linear_addr_size(env_cpu(env), RDI(env),
                                          decode->addressing_size, R_ES);
 
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 0,
                         decode->operand_size, 1);
-    x86_write_mem(env_cpu(env), env->emu_mmio_buf, addr,
+    res = x86_write_mem(env_cpu(env), env->emu_mmio_buf, addr,
                         decode->operand_size);
+    if (res) {
+        return 1;
+    }
 
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_ins(CPUX86State *env, struct x86_decode *decode)
 {
+    bool res;
     if (decode->rep) {
-        string_rep(env, decode, exec_ins_single, 0);
+        res = string_rep(env, decode, exec_ins_single, 0);
     } else {
-        exec_ins_single(env, decode);
+        res = exec_ins_single(env, decode);
     }
 
+    if (res) {
+        return;
+    }
     env->eip += decode->len;
 }
 
-static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
@@ -519,48 +548,64 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
                         decode->operand_size, 1);
 
     string_increment_reg(env, R_ESI, decode);
+    return 0;
 }
 
 static void exec_outs(CPUX86State *env, struct x86_decode *decode)
 {
+    bool res;
     if (decode->rep) {
-        string_rep(env, decode, exec_outs_single, 0);
+        res = string_rep(env, decode, exec_outs_single, 0);
     } else {
-        exec_outs_single(env, decode);
+        res = exec_outs_single(env, decode);
     }
 
+    if (res) {
+        return;
+    }
     env->eip += decode->len;
 }
 
-static void exec_movs_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_movs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong src_addr;
     target_ulong dst_addr;
     target_ulong val;
+    MMUTranslateResult res;
 
     src_addr = decode_linear_addr(env, decode, RSI(env), R_DS);
     dst_addr = linear_addr_size(env_cpu(env), RDI(env),
                                 decode->addressing_size, R_ES);
 
-    val = read_val_from_mem(env, src_addr, decode->operand_size);
-    x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
+    if (read_val_from_mem(env, src_addr, decode->operand_size, &val)) {
+        return 1;
+    }
+    res = x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
+    if (res) {
+        return 1;
+    }
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_movs(CPUX86State *env, struct x86_decode *decode)
 {
+    bool res;
     if (decode->rep) {
-        string_rep(env, decode, exec_movs_single, 0);
+        res = string_rep(env, decode, exec_movs_single, 0);
     } else {
-        exec_movs_single(env, decode);
+        res = exec_movs_single(env, decode);
     }
 
+    if (res) {
+        return;
+    }
     env->eip += decode->len;
 }
 
-static void exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong src_addr;
     target_ulong dst_addr;
@@ -570,14 +615,19 @@ static void exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
                                 decode->addressing_size, R_ES);
 
     decode->op[0].type = X86_VAR_IMMEDIATE;
-    decode->op[0].val = read_val_from_mem(env, src_addr, decode->operand_size);
+    if (read_val_from_mem(env, src_addr, decode->operand_size, &decode->op[0].val)) {
+        return 1;
+    }
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    decode->op[1].val = read_val_from_mem(env, dst_addr, decode->operand_size);
+    if (read_val_from_mem(env, dst_addr, decode->operand_size, &decode->op[1].val)) {
+        return 1;
+    }
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
@@ -591,17 +641,22 @@ static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
 }
 
 
-static void exec_stos_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_stos_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
     target_ulong val;
+    MMUTranslateResult res;
 
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     val = read_reg(env, R_EAX, decode->operand_size);
-    x86_write_mem(env_cpu(env), &val, addr, decode->operand_size);
+    res = x86_write_mem(env_cpu(env), &val, addr, decode->operand_size);
+    if (res) {
+        return 1;
+    }
 
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 
@@ -616,7 +671,7 @@ static void exec_stos(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
 
@@ -627,6 +682,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_scas(CPUX86State *env, struct x86_decode *decode)
@@ -642,7 +698,7 @@ static void exec_scas(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
     target_ulong val = 0;
@@ -652,6 +708,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
+    return 0;
 }
 
 static void exec_lods(CPUX86State *env, struct x86_decode *decode)
-- 
2.50.1 (Apple Git-155)



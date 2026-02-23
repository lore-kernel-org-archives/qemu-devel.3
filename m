Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE19E98E08
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSz-0001IA-Jm; Mon, 23 Feb 2026 03:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSh-0000uj-HD
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:41 -0500
Received: from p-east2-cluster3-host10-snip4-8.eps.apple.com ([57.103.77.149]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSf-0002KJ-MU
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:39 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 BB601180022A; Mon, 23 Feb 2026 08:38:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835917; x=1774427917;
 bh=A0kv8WcUrfCI0eP6NvMQADwHXSg1hEvtsUz+NsukzMg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A8rRUPy+C0zZo0i3JytokBFWvcNXxuM7+pQE21Q6y5KYTDd1t2iS0DppdG4hj1iPKVPuBZxAEvfphqLPc7g35t6StjekXmNW/UtEUmjmfPDEvOBuJw39mZvuy45i41mAO1CYANLRSs0kbcU/ROMugL+UhiYXlqyhj93JPQGCBLfvFkU3tXZwwbymRtjr/cIbkpsGv0IiZp71sc6WN0IRBiF0dxAHUPmycau4OiJwDaT0POT4kkUmBHo6lJpAaov+jZxoVmRBKPYCuFaHDOTgYvG70QH95l5rwdOknXBD5Gp2mbfA4O+YO6itjcMjhaWikN81Q/0ZfpvLMmNaOboQ4A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 7FFD11800215; Mon, 23 Feb 2026 08:38:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 24/27] target/i386: emulate: propagate memory errors on
 most reads/writes
Date: Mon, 23 Feb 2026 09:37:30 +0100
Message-ID: <20260223083734.48533-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXzX4UOWoBgOzA
 4ebSoRXnoGQdiWQ7RHifmESWZsmTInGs4grjti3TSzAdWaKkl42cvXlhNtzEkZ10Ag9qQjLNg8E
 VuJzQsQwDlsD7pcTTLZP2JP64fXyMst5IEmNdEnY9k/PwaTexBOdR6kGJrq5daHfPrT4nvgnNQz
 EM2+YXWenY2RRPK/7IL7pg9kE8Ul6EG2zRYb0HaXhgZ4blNBcrSZKquqMTvPwUG4kDoXOQq75yZ
 geOh0w5gEswwzCntRAR7IKchOirOFJ1uia5jreqwDFIbFhXJfAB33ugNj+Q83S9IHfjTMVdrCKL
 Vgbs6ks1Iy+mF7pr697pRRkodqdAfielfvWMYvdtQBqDWLXtyYHC2RO45JvI7s=
X-Proofpoint-GUID: R6IpnaC2gLFJPyOONrViqSWUpvkw3p-4
X-Authority-Info-Out: v=2.4 cv=RYadyltv c=1 sm=1 tr=0 ts=699c120c
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yuK-eIj46yw4D_dHqGMA:9
X-Proofpoint-ORIG-GUID: R6IpnaC2gLFJPyOONrViqSWUpvkw3p-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 suspectscore=0 adultscore=0
 mlxlogscore=979 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAAB+2m3PclqCc3IVA4xOzyufGRnKJooG/abyZetovkTW/aY4LRV/0xAHcdwWXnAh1HiB1iqJinuxRnUPcsXD+7krOsdeey4TjbW0ZWihVn6iAezv5HBlvm5b7HPdIjlF9hii9nsItXWN7tUeSs0GRqSMHhYMmSuo9A8MRuFbDAkMhiT69lOall7j9MFrV9YEy7pHyqCEw8kGdQZ1QFBls//SyMRDJdbVlcFFSt9mqwj2OECUpwjji5Wai/PoRDn45dwdWpX32x9Qo8XuIVt6dLTNM/3FvYw5+VVIVGfBsBPOhR13I8do3RcGdXzMNiIfhSEO7IF+JjwpJzhIM0LvAKvgmHgylp7muhNBBBVBkOZtLXyuABNC5xxnmJ8HOXoNOg0o1upXRKB227SvTen3lEDnmUgEUzbkviecV1dkAJ4E0Y61opYEN+rlVuwxh3jgMwsVpm6vtTFwa9ZpfV0HLaIwj0rRVQHjQe7M9BhJkg+N7K0qS1sQ2USnKebP6lcqvKfqm9MAMfi5PVz0mZS4iv+tVXbI5XjpW3foel9AOGzUgjPs5s30ACghrN3ec2iGIKD/++WW9CwjsbPCPoDe059e3KQjBmYQkNYjxH0UZEKB7Y5BNqQCa58XeRT6CawL9W0DXKKQPk4uALFQKkr06/GInHAWFIuiK8wql0Hn1fnQVmw079P4qG40sxIb1Lq+Xcb+V71PIJiMPPk4IVAosp1phXatuG7Jx9arBFvrMT1wfUlLqyYHdc3evN8wNJh6m19OdvcAJ5eO7hR8hiMSK51pUOlY6KmkBUAiHCmcwb98R2NsdlGIdyzG+Rt
Received-SPF: pass client-ip=57.103.77.149;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

Leaves a coverage gap for read_val_ext(), to be handled in a later commit.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 115 +++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 31 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 3aedd638a1..f5359d3a45 100644
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
@@ -175,43 +178,52 @@ void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    MMUTranslateResult res = x86_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    if (res) {
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
 
@@ -465,15 +477,17 @@ static inline int get_ZF(CPUX86State *env) {
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
@@ -483,33 +497,44 @@ static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
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
 
@@ -519,48 +544,64 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
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
@@ -570,14 +611,19 @@ static void exec_cmps_single(CPUX86State *env, struct x86_decode *decode)
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
@@ -591,17 +637,22 @@ static void exec_cmps(CPUX86State *env, struct x86_decode *decode)
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
 
 
@@ -616,7 +667,7 @@ static void exec_stos(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_scas_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
 
@@ -627,6 +678,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
+    return 0;
 }
 
 static void exec_scas(CPUX86State *env, struct x86_decode *decode)
@@ -642,7 +694,7 @@ static void exec_scas(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
+static bool exec_lods_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr;
     target_ulong val = 0;
@@ -652,6 +704,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
+    return 0;
 }
 
 static void exec_lods(CPUX86State *env, struct x86_decode *decode)
-- 
2.50.1 (Apple Git-155)



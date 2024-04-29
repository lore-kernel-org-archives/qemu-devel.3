Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF1AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ws5-0000wT-MJ; Mon, 29 Apr 2024 15:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s1Ws1-0000kx-4l
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:41:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1s1Wrw-0001jn-Qv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:41:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TGFx7P011419;
 Mon, 29 Apr 2024 19:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=qcppdkim1; bh=yPjnMTz
 9/AUvpWRo7iSUQiYg42PuDsiaYu8I50/VKr0=; b=VSCiuoPQcVqKB/pWqLk/HaV
 EMtp8iEotw95mFZV1Ynk7q9n6ebttrmin0N9bVVtp2hNMr+Z4j1bGNwSE35BjwBp
 OTZiNuN6WFQINhLLTYJ7cyAbxejZKBJflbRqLy5nYBfUX5OkDw7BTgx/l6JgpAwp
 PLAHYDBW+9Yvsp3A9lb8zehxKBvl67OChrJVDj8yluR0ZYvngOjy9Xw4BHaL9itv
 HQHUyxOs9EJiuZUpTA9UtatJ47JnmKiuvRaPSs8Ckq/dOapOJh5QZ0SM4ljfjlB6
 lhaKHu2zdNS79EwoExVBtrBYGeq7MVcn4JeIFsO8q5m+mXtRdNa/CDoJFCeVXEw=
 =
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8khmwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 19:40:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TJeoEM015974
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 19:40:50 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 12:40:49 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <ltaylorsimpson@gmail.com>, <richard.henderson@linaro.org>
Subject: [PATCH v2] Hexagon: add PC alignment check and exception
Date: Mon, 29 Apr 2024 16:40:37 -0300
Message-ID: <e559b521d1920f804df10244c8c07564431aeba5.1714419461.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Mj0CjisbylAZ6qnw5HRBSn2PJA4jqWrV
X-Proofpoint-ORIG-GUID: Mj0CjisbylAZ6qnw5HRBSn2PJA4jqWrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_17,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The Hexagon Programmer's Reference Manual says that the exception 0x1e
should be raised upon an unaligned program counter. Let's implement that
and also add tests for both the most common case as well as packets with
multiple change-of-flow instructions.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
v1: https://lore.kernel.org/qemu-devel/c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com/

Changes in v2:
- Moved PC alignment check from gen_write_new_pc_addr to
  cpu_get_tb_cpu_state, in order to get the right PC address at
  exception handling. (And also include relative PC instructions)
- Added test for endloop.
- Updated pkt_raises_exception for A_COF instructions.

 target/hexagon/cpu.h                       |  7 +++++++
 target/hexagon/cpu_bits.h                  |  4 ++++
 target/hexagon/macros.h                    |  3 ---
 target/hexagon/op_helper.c                 |  9 ++++-----
 target/hexagon/translate.c                 |  5 +++--
 tests/tcg/hexagon/Makefile.target          | 16 ++++++++++++++++
 tests/tcg/hexagon/unaligned_pc.S           | 10 ++++++++++
 tests/tcg/hexagon/unaligned_pc_endloop.S   |  8 ++++++++
 tests/tcg/hexagon/unaligned_pc_multi_cof.S | 13 +++++++++++++
 9 files changed, 65 insertions(+), 10 deletions(-)
 create mode 100644 tests/tcg/hexagon/unaligned_pc.S
 create mode 100644 tests/tcg/hexagon/unaligned_pc_endloop.S
 create mode 100644 tests/tcg/hexagon/unaligned_pc_multi_cof.S

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 3eef58fe8f..764f3c38cc 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -134,6 +134,10 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
+G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
+                                            uint32_t exception,
+                                            uintptr_t pc);
+
 static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
@@ -144,6 +148,9 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
         hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
     }
     *flags = hex_flags;
+    if (*pc & PCALIGN_MASK) {
+        hexagon_raise_exception_err(env, HEX_EXCP_PC_NOT_ALIGNED, 0);
+    }
 }
 
 typedef HexagonCPU ArchCPU;
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 96fef71729..4279281a71 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -20,9 +20,13 @@
 
 #include "qemu/bitops.h"
 
+#define PCALIGN 4
+#define PCALIGN_MASK (PCALIGN - 1)
+
 #define HEX_EXCP_FETCH_NO_UPAGE  0x012
 #define HEX_EXCP_INVALID_PACKET  0x015
 #define HEX_EXCP_INVALID_OPCODE  0x015
+#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
 #define HEX_EXCP_PRIV_NO_UREAD   0x024
 #define HEX_EXCP_PRIV_NO_UWRITE  0x025
 
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 1376d6ccc1..f375471a98 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -22,9 +22,6 @@
 #include "hex_regs.h"
 #include "reg_fields.h"
 
-#define PCALIGN 4
-#define PCALIGN_MASK (PCALIGN - 1)
-
 #define GET_FIELD(FIELD, REGIN) \
     fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
                    reg_field_info[FIELD].offset)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index da10ac5847..ae5a605513 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -36,10 +36,9 @@
 #define SF_MANTBITS    23
 
 /* Exceptions processing helpers */
-static G_NORETURN
-void do_raise_exception_err(CPUHexagonState *env,
-                            uint32_t exception,
-                            uintptr_t pc)
+G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
+                                            uint32_t exception,
+                                            uintptr_t pc)
 {
     CPUState *cs = env_cpu(env);
     qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
@@ -49,7 +48,7 @@ void do_raise_exception_err(CPUHexagonState *env,
 
 G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
 {
-    do_raise_exception_err(env, excp, 0);
+    hexagon_raise_exception_err(env, excp, 0);
 }
 
 void log_store32(CPUHexagonState *env, target_ulong addr,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 47a870f42d..26e6809976 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -346,8 +346,9 @@ static void mark_implicit_pred_writes(DisasContext *ctx)
 static bool pkt_raises_exception(Packet *pkt)
 {
     if (check_for_attrib(pkt, A_LOAD) ||
-        check_for_attrib(pkt, A_STORE)) {
-        return true;
+        check_for_attrib(pkt, A_STORE) ||
+        check_for_attrib(pkt, A_COF)) {
+            return true;
     }
     return false;
 }
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f839b2c0d5..36d6e1f1d4 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,22 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
+HEX_TESTS += unaligned_pc
+HEX_TESTS += unaligned_pc_endloop
+HEX_TESTS += unaligned_pc_multi_cof
+
+run-unaligned_pc: unaligned_pc
+run-unaligned_pc_endloop: unaligned_pc_endloop
+run-unaligned_pc_multi_cof: unaligned_pc_multi_cof
+
+run-unaligned_pc run-unaligned_pc_endloop run-unaligned_pc_multi_cof:
+	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on $(TARGET_NAME)"); \
+	if [ $$? -ne 1 ] ; then \
+		return 1; \
+	fi
+	$(call quiet-command, \
+		grep -q "exception 0x1e" $<.stderr, \
+		"GREP", "exception 0x1e");
 
 run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
 	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr)
diff --git a/tests/tcg/hexagon/unaligned_pc.S b/tests/tcg/hexagon/unaligned_pc.S
new file mode 100644
index 0000000000..39d6b2060b
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc.S
@@ -0,0 +1,10 @@
+test:
+	allocframe(#0x8)
+	r0 = #0xffffffff
+	framekey = r0
+	dealloc_return
+
+.global _start
+_start:
+	call test
+	jump pass
diff --git a/tests/tcg/hexagon/unaligned_pc_endloop.S b/tests/tcg/hexagon/unaligned_pc_endloop.S
new file mode 100644
index 0000000000..d6a4edc262
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc_endloop.S
@@ -0,0 +1,8 @@
+.global _start
+_start:
+	loop0(loop, #2)
+loop:
+	r0 = #0x3
+	sa0 = r0
+	{ nop }:endloop0
+	jump pass
diff --git a/tests/tcg/hexagon/unaligned_pc_multi_cof.S b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
new file mode 100644
index 0000000000..a83e248ece
--- /dev/null
+++ b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
@@ -0,0 +1,13 @@
+.org 0x3
+test:
+	nop
+	jumpr r31
+
+.global _start
+_start:
+	p0 = cmp.eq(r0, r0)
+	{
+		if (p0) jump test
+		jump pass
+	}
+	jump pass
-- 
2.37.2



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD8606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YRibkchG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBg-0007VQ-8s; Thu, 29 Oct 2026 13:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qD-8W
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bL-01
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDFpY542882; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aBzongN3Tco
 CCrfna0eVQKv/3zqAcYtc2fZiz7KBiv8=; b=YRibkchG+wFg/latWMK0q6n0VVQ
 L3hEU5LWLPEcyr3OGKmQPOOMooPXrjK8zCGt2CDLziq0vzqDGwo6ffjfibdEoy+1
 zt+EFdnJ4J8GTEKnB8yzxQ7kLE9DhlxwVD9Er2NABR54Y+wKfbT/xJYibwTj9UAK
 F0wbABWjPp4UieXSIiV2QEAcBAO+nPQ8F3mZjkbQQsaT9vPLwFZDzlpsIoMzT9FT
 cjYtBG5lRX8zca85vwCqKc17r4/pG2mDJkigxWt9fGOfY+Fo8hlAdwZ4WVYobJWg
 kPZSGyZtoiGor4FDPoh0D+oF6FhxeBD0a7x1Ba/AFHfAg94S3Z6wFTuqgMQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshuu8w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEh52474604; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69THiEI42474578
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 8622F25831; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 06/20] target/hexagon: add HLX helper support
Date: Thu, 29 Oct 2026 10:43:59 -0700
Message-ID: <20261029174413.643130-7-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: BLEvANJ3GUINMMtPoyQeFM9dCt3HwgxI
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=rpK6tlnHYXnTJ3qEWdAA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX47Yqe30xw9g1
 mNxqFkVLjgDV9DXhyHLpkH0nDxapUUD6Nc4oCCzvSFVQFmvcXi2fRIVIbnNm0mZSY/rPLfBqRg4
 QUqe87h+X9x8RTAs1K1fzWuZStOMwFY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX5sVHPvng+kWI
 AbnpYadlFxt88qah1K/fTpVLWd6W9ErCaewdM0cb8CmwNwZtdq3V88tcbQkJ9WQ5Urh+AhFBfgV
 UoffoR6y1tAiigIGgH8H4RMU0LlCOmzlwnJsPonklGPCX5p3Q3TD1rxF1UxISpOwuj53G0Pwbp+
 hO+GSeDWdros6vAePgrDKuG9EE/v5LRyAEo0kIZaPClYwl7N48M5q0+oXLfTqpY+FkXy7wWtOt/
 PLlP7hBigGAURDjeEVYVQVoPV7AdGdKZhp3l5BpB8dC7ErmiZlyghZ0fkA6Pl12qCHA2drWOSLW
 zijUh7MLMp+G93VNb2UPrGAbh88hiehv4u0wYbt0BLLVv6lqh0+LjPsbZp72WfHdJ62phBkp1cR
 runA+NObtAwVtSV9mEDmds1e93Kg8A==
X-Proofpoint-ORIG-GUID: BLEvANJ3GUINMMtPoyQeFM9dCt3HwgxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add HLX vector load, store, copy and commit helpers plus generator
support for L register arguments and register pairs.

HLX accesses are limited to VTCM. V85 defines no exception for an
access outside it, so the helpers do not check the address.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h                |  4 ++
 target/hexagon/gen_helper_funcs.py  | 86 ++++++++++++++++++++++++--
 target/hexagon/gen_helper_protos.py |  7 ++-
 target/hexagon/helper.h             |  6 ++
 target/hexagon/hlx_helper.c         | 95 +++++++++++++++++++++++++++++
 target/hexagon/macros.h             | 56 +++++++++++++++++
 target/hexagon/meson.build          |  1 +
 7 files changed, 246 insertions(+), 9 deletions(-)
 create mode 100644 target/hexagon/hlx_helper.c

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 904dcc2e7d..7524ab8769 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -204,6 +204,10 @@ typedef struct CPUArchState {
 
     HLXVector future_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
     HLXVector tmp_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
+    /* Pending HLX store. */
+    HLXVector hlx_store_data QEMU_ALIGNED(16);
+    target_ulong hlx_store_va;
+    bool hlx_store_pending;
 
     /* Temporaries used within instructions */
     MMVectorPair VuuV QEMU_ALIGNED(16);
diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
index 1629ebc0e1..a53a57df12 100755
--- a/target/hexagon/gen_helper_funcs.py
+++ b/target/hexagon/gen_helper_funcs.py
@@ -55,24 +55,28 @@ def gen_helper_function(f, tag, tagregs, tagimms):
     if not hex_common.is_predicated(tag):
         for regtype, regid in regs:
             reg = hex_common.get_register(tag, regtype, regid)
-            if reg.is_writeonly() and not reg.is_hvx_reg():
+            is_vector = reg.is_hvx_reg() or reg.is_hlx_reg()
+            if reg.is_writeonly() and not is_vector:
                 f.write(hex_common.code_fmt(f"""\
                     {reg.helper_arg_type()} {reg.helper_arg_name()} = 0;
                 """))
 
-    ## Print useful information about HVX registers
+    ## Print useful information about HVX and HLX registers.
     for regtype, regid in regs:
         reg = hex_common.get_register(tag, regtype, regid)
         if reg.is_hvx_reg():
             reg.helper_hvx_desc(f)
+        if reg.is_hlx_reg():
+            reg.helper_hlx_desc(f)
 
     if hex_common.need_slot(tag):
         if "A_LOAD" in hex_common.attribdict[tag]:
             f.write(hex_common.code_fmt(f"""\
-                bool pkt_has_scalar_store_s1 = slotval & 0x1;
+                bool pkt_has_scalar_store_s1 __attribute__((unused)) = \
+                    slotval & 0x1;
             """))
         f.write(hex_common.code_fmt(f"""\
-            uint32_t slot = slotval >> 1;
+            uint32_t slot __attribute__((unused)) = slotval >> 1;
         """))
 
     if "A_FPOP" in hex_common.attribdict[tag]:
@@ -80,14 +84,84 @@ def gen_helper_function(f, tag, tagregs, tagimms):
             arch_fpop_start(env);
         """))
 
+    ## Define HLX register variables.
+    has_hlx_reg = False
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_hlx_reg():
+            has_hlx_reg = True
+            if reg.is_pair():
+                tmp_name = f"_{reg.reg_tcg()}_tmp"
+                f.write(hex_common.code_fmt(f"""\
+                    HLXVectorPair {tmp_name};
+                """))
+                if reg.is_read():
+                    f.write(hex_common.code_fmt(f"""\
+                        hlx_interleave_pair(&{tmp_name},
+                            (const HLXVector *)({reg.helper_arg_name()}),
+                            (const HLXVector *)({reg.helper_arg_name()}) + 1);
+                    """))
+                else:
+                    f.write(hex_common.code_fmt(f"""\
+                        memset(&{tmp_name}, 0, sizeof({tmp_name}));
+                    """))
+                f.write(hex_common.code_fmt(f"""\
+                    #define {reg.reg_tcg()} {tmp_name}
+                """))
+            else:
+                reg_def = f"(*(HLXVector *)({reg.helper_arg_name()}))"
+                f.write(hex_common.code_fmt(f"""\
+                    #define {reg.reg_tcg()} {reg_def}
+                """))
+
+    ## Declare fLVFOREACH loop variables.
+    semantics = hex_common.semdict[tag]
+    if has_hlx_reg and "fLVFOREACH" in semantics:
+        f.write(hex_common.code_fmt(f"""\
+            int i;
+        """))
+        # Remove nested fHIDE() wrappers.
+        while 'fHIDE(' in semantics:
+            # Find the matching closing parenthesis.
+            start = semantics.find('fHIDE(')
+            paren_count = 0
+            end = -1
+            for pos in range(start + len('fHIDE('), len(semantics)):
+                if semantics[pos] == '(':
+                    paren_count += 1
+                elif semantics[pos] == ')':
+                    if paren_count == 0:
+                        end = pos
+                        break
+                    paren_count -= 1
+            if end < 0:
+                raise Exception(f"unbalanced fHIDE( in {tag}")
+            semantics = semantics[:start] + semantics[end + 1:]
+
     f.write(hex_common.code_fmt(f"""\
-        {hex_common.semdict[tag]}
+        {semantics};
     """))
 
+    ## Undefine HLX registers and deinterleave written pairs.
+    for regtype, regid in regs:
+        reg = hex_common.get_register(tag, regtype, regid)
+        if reg.is_hlx_reg():
+            if reg.is_pair() and reg.is_written():
+                tmp_name = f"_{reg.reg_tcg()}_tmp"
+                f.write(hex_common.code_fmt(f"""\
+                    hlx_deinterleave_pair(
+                        (HLXVector *)({reg.helper_arg_name()}),
+                        (HLXVector *)({reg.helper_arg_name()}) + 1,
+                        &{tmp_name});
+                """))
+            f.write(hex_common.code_fmt(f"""\
+                #undef {reg.reg_tcg()}
+            """))
+
     ## Return the scalar result
     for regtype, regid in regs:
         reg = hex_common.get_register(tag, regtype, regid)
-        if reg.is_written() and not reg.is_hvx_reg():
+        if reg.is_written() and not reg.is_hvx_reg() and not reg.is_hlx_reg():
             f.write(hex_common.code_fmt(f"""\
                 return {reg.helper_arg_name()};
             """))
diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
index 59c8bdd05c..00dddaeb90 100755
--- a/target/hexagon/gen_helper_protos.py
+++ b/target/hexagon/gen_helper_protos.py
@@ -42,9 +42,10 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
     arguments = ", ".join(declared)
 
     ## Add the TCG_CALL_NO_RWG_SE flag to helpers that don't take the env
-    ## argument and aren't HVX instructions.  Since HVX instructions take
-    ## pointers to their arguments, they will have side effects.
-    if hex_common.need_env(tag) or hex_common.is_hvx_insn(tag):
+    ## argument and are not vector instructions. Vector pointer arguments
+    ## have side effects.
+    if (hex_common.need_env(tag) or hex_common.is_hvx_insn(tag) or
+            "A_HLX" in hex_common.attribdict[tag]):
         f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n")
     else:
         f.write(f"DEF_HELPER_FLAGS_{len(declared) - 1}({tag}, "
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 245cd50b89..766995fae3 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
 
 /* HLX helpers */
+DEF_HELPER_5(hlx_load_vec, void, env, ptr, tl, i32, i32)
+DEF_HELPER_5(hlx_store_vec, void, env, tl, ptr, i32, i32)
+DEF_HELPER_1(hlx_commit_store, void, env)
 DEF_HELPER_FLAGS_2(hlx_trace_op, TCG_CALL_NO_RWG, void, env, i32)
 
 /* Floating point */
@@ -154,3 +157,6 @@ DEF_HELPER_3(modify_ccr, void, env, i32, i32)
 DEF_HELPER_1(pending_interrupt, void, env)
 DEF_HELPER_2(tlbinvasid, void, env, i32)
 #endif
+DEF_HELPER_2(hlx_copy_live_to_future, void, env, i32)
+DEF_HELPER_2(hlx_copy_live_to_tmp,    void, env, i32)
+DEF_HELPER_2(hlx_commit_reg,          void, env, i32)
diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
new file mode 100644
index 0000000000..6525abfb2c
--- /dev/null
+++ b/target/hexagon/hlx_helper.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "exec/helper-proto.h"
+#include "hlx/hlx.h"
+#include "hw/hexagon/hexagon_hlx.h"
+#include "accel/tcg/probe.h"
+#include "tcg/tcg-gvec-desc.h"
+
+#define HLX_MEM_ALIGN_MASK (~(HLX_VEC_SIZE_BYTES - 1))
+
+/* Align down to 2KB. Above and below are unused in V85. */
+void HELPER(hlx_load_vec)(CPUHexagonState *env, void *dst_void,
+                          target_ulong ea, uint32_t above, uint32_t below)
+{
+    HLXVector *dst = (HLXVector *)dst_void;
+    target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
+    uintptr_t raddr = GETPC();
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+
+    /* A 2KB-aligned access stays within one page. */
+    void *host = probe_read(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx,
+                            raddr);
+
+    if (host) {
+        memcpy(dst, host, HLX_VEC_SIZE_BYTES);
+    } else {
+        for (int i = 0; i < HLX_VEC_SIZE_BYTES; i += 8) {
+            uint64_t val = cpu_ldq_le_data_ra(env, aligned_ea + i, raddr);
+            memcpy(&dst->ub[i], &val, 8);
+        }
+    }
+}
+
+void HELPER(hlx_store_vec)(CPUHexagonState *env, target_ulong ea,
+                           void *src_void, uint32_t above, uint32_t below)
+{
+    target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+
+    probe_write(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, GETPC());
+    memcpy(&env->hlx_store_data, src_void, sizeof(HLXVector));
+    env->hlx_store_va = aligned_ea;
+    env->hlx_store_pending = true;
+}
+
+void HELPER(hlx_commit_store)(CPUHexagonState *env)
+{
+    target_ulong va = env->hlx_store_va;
+    uintptr_t raddr = GETPC();
+    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    void *host;
+
+    if (!env->hlx_store_pending) {
+        return;
+    }
+    env->hlx_store_pending = false;
+
+    host = probe_write(env, va, HLX_VEC_SIZE_BYTES, mmu_idx, raddr);
+    if (host) {
+        memcpy(host, &env->hlx_store_data, HLX_VEC_SIZE_BYTES);
+    } else {
+        for (int i = 0; i < HLX_VEC_SIZE_BYTES; i += 8) {
+            uint64_t val;
+            memcpy(&val, &env->hlx_store_data.ub[i], 8);
+            cpu_stq_le_data_ra(env, va + i, val, raddr);
+        }
+    }
+}
+
+void HELPER(hlx_copy_live_to_future)(CPUHexagonState *env, uint32_t rnum)
+{
+    g_assert(env->hlx_ctx != NULL);
+    memcpy(&env->future_LRegs[rnum], &env->hlx_ctx->LRegs[rnum],
+           sizeof(HLXVector));
+}
+
+void HELPER(hlx_copy_live_to_tmp)(CPUHexagonState *env, uint32_t rnum)
+{
+    g_assert(env->hlx_ctx != NULL);
+    memcpy(&env->tmp_LRegs[rnum], &env->hlx_ctx->LRegs[rnum],
+           sizeof(HLXVector));
+}
+
+void HELPER(hlx_commit_reg)(CPUHexagonState *env, uint32_t rnum)
+{
+    g_assert(env->hlx_ctx != NULL);
+    memcpy(&env->hlx_ctx->LRegs[rnum], &env->future_LRegs[rnum],
+           sizeof(HLXVector));
+}
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 195bd6a0c9..2748e26d6c 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -703,4 +703,60 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 
 #define fPREDUSE_TIMING()
 
+#define fLVECSIZE() (2048)
+/* Unlike HVX, COUNT is an element count. */
+#define fLVFOREACH(COUNT, VAR) for (VAR = 0; VAR < (COUNT); VAR++)
+
+#define fLMPY16UU(A, B) \
+    ((uint64_t)((uint32_t)(uint16_t)(A) * (uint32_t)(uint16_t)(B)))
+#define fLMPY16SU(A, B) ((int64_t)(int32_t)((int16_t)(A) * (uint16_t)(B)))
+#define fLMPY16SS(A, B) ((int64_t)(int32_t)((int16_t)(A) * (int16_t)(B)))
+
+#define fLSHIFT(VAL, SHAMT) \
+    ((SHAMT) <= 0 ? ((int64_t)(VAL) << fMIN(32, -(SHAMT))) : \
+                    ((int64_t)(VAL) >> fMIN(32, (SHAMT))))
+#define fLSHIFT_RND(VAL, SHAMT) \
+    ((SHAMT) <= 0 ? ((int64_t)(VAL) << fMIN(32, -(SHAMT))) : \
+                    ((((int64_t)(VAL) >> fMIN(32, (SHAMT) - 1)) + 1) >> 1))
+#define fLSHIFTU(VAL, SHAMT) \
+    ((SHAMT) <= 0 ? ((uint64_t)(VAL) << fMIN(32, -(SHAMT))) : \
+                    ((uint64_t)(VAL) >> fMIN(32, (SHAMT))))
+#define fLSHIFTU_RND(VAL, SHAMT) \
+    ((SHAMT) <= 0 ? ((uint64_t)(VAL) << fMIN(32, -(SHAMT))) : \
+                    ((((uint64_t)(VAL) >> fMIN(32, (SHAMT) - 1)) + 1) >> 1))
+
+#define fABSW(A) (((int64_t)(A) < 0) ? (-(int64_t)(A)) : ((int64_t)(A)))
+#define fBIT_WIDTH(SIZE, VAL) \
+    ((uint32_t)(VAL) ? \
+     (SIZE) - (__builtin_clz((uint32_t)(VAL)) - (32 - (SIZE))) : 0)
+
+#define HLX_MEM_ALIGN_MASK (~(HLX_VEC_SIZE_BYTES - 1))
+
+#ifdef QEMU_GENERATE
+#define fLOADMML(EA, DST, ABOVE, BELOW) \
+    gen_helper_hlx_load_vec(tcg_env, tcg_constant_ptr((intptr_t)&(DST)), \
+                            EA, tcg_constant_i32(ABOVE), \
+                            tcg_constant_i32(BELOW))
+#else
+#define fLOADMML(EA, DST, ABOVE, BELOW) \
+    do { HELPER(hlx_load_vec)(env, &(DST), (EA), (ABOVE), (BELOW)); } while (0)
+#endif
+
+/* The helper logs the store for packet commit. */
+#ifdef QEMU_GENERATE
+#define fSTOREMML(EA, SRC, ABOVE, BELOW) \
+    gen_helper_hlx_store_vec(tcg_env, EA, tcg_constant_ptr((intptr_t)&(SRC)), \
+                             tcg_constant_i32(ABOVE), tcg_constant_i32(BELOW))
+#else
+#define fSTOREMML(EA, SRC, ABOVE, BELOW) \
+    do { HELPER(hlx_store_vec)(env, (EA), &(SRC), (ABOVE), (BELOW)); } while (0)
+#endif
+
+/* Helpers receive .new registers in future_LRegs. */
+#define fNEWLREG(LNUM) (LNUM)
+
+#define fMPY3216UU(A, B) (fZE32_64(A) * fZXTN(16, 64, B))
+#define check_ilog2_compliance(RESULT, INPUT, OFFSET) do {} while (0)
+#define f64BIT_SCALAR_MASK(REG) do {} while (0)
+
 #endif
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 429317a658..1aa4df7ac7 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -265,6 +265,7 @@ hexagon_ss.add(files(
     'mmvec/system_ext_mmvec.c',
     'mmvec/hvx_ieee_fp.c',
     'mmvec/hvx_qfloat.c',
+    'hlx_helper.c',
 ))
 
 hexagon_softmmu_ss.add(files(
-- 
2.43.0



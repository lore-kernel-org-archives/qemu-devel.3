Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30069606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TBliHDy9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBu-00008v-Mj; Thu, 29 Oct 2026 13:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qC-7L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bd-JP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGCxFp1619564; Thu, 29 Oct 2026 17:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NLSyyVXCjDt
 z87WPyQSmhn/LH7tppajORchgpn9IPwE=; b=TBliHDy95zrwPxbDv2o/8T+N6fq
 HYp/khD3TkZazsXLwhnNeSq1VpxX8dkA9uWPHUIaxZ/Xf8bCbMPGBAP18OZXuvta
 PDiPj0lc748M2w+BBZRcHwQzFFQ7+QKjd4uGtXia7B0lKZg8nfZzsw/Rsh8dw6Kn
 5DA/Es5M3+8A0B9EieZDq9zSGv9ioxcGAYvZxSqlyTQdlu+soD3U7jrmT+a9J+7u
 ey5px5Ye27LmTLqn1ny69gDkPwLLCVk6Cy2q8BCiE87iO+EN+KNkfDZERnkNBVXJ
 EGOM9t+QOE20otKcuHn9paB1yjxDtwY8ACvw/x8zeIP6fDCXiVQA8tIkxPA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9wuv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEdx2516195; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69THiDqG2516187
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:13 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 7BF5825828; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 04/20] target/hexagon: generate the opcode translator table
Date: Thu, 29 Oct 2026 10:43:57 -0700
Message-ID: <20261029174413.643130-5-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX4bc3HJPc1+lG
 hZr6tZJan8ot+v8XAm+GMtLAPVgl3r01vnXcX9GJxyN/3WmQO/1nE2WDxogYx0rUZtm+wVF5THR
 F0Wi/8uvnPCAddNnow5Jdex71w9fEoQ=
X-Proofpoint-ORIG-GUID: soF-Qh2FgvpWPop6h_X2qtB2T6bVTMaF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXxRYdmNCj4hzF
 svufBJTCwBiCF8a4iQufUxGoQeU+IcfWHVXBTUhAtIZNBpXPUi7blu9QkeLI77ag1oPbnPL8HfS
 Fs9uoD/hiUW6Eq2jiCCQ+BvihadDtBIhYWT8SeoKKLui9uUzVToPiQCAtqL/ul4ugC84dAffj5G
 dGm4lnq7N91vgthcEdpmCrr5fcYYYgPKzDahQlzQvFukpsRMLkaXajbOvGNngwstyKWU7+PTZwA
 GXq8vcAbl36FnUQzvOavHpg/6woMJO5Kmyog+dz1CI7dVMOkZkl8aDy9Zh+bBCkkAgr88F5d5ms
 tHcTDz21efhSpCprLBTW/q897xZJogaaldq9bw1RFJeFy0I14xHxvS/iRDfBh0nxLG0f7G1b/hS
 fOdyKu4kmQGs7fG2g6AmlyeCNs5wpK+NYx5V/BjLru+R75toee6Em1tJbTvJIeOxdsnGhfEiQ2J
 xCSIoYm/XjHYywllCfQ==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae385ee cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=u07vF7o28y_ET1bF0n0A:9
X-Proofpoint-GUID: soF-Qh2FgvpWPop6h_X2qtB2T6bVTMaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Generate the opcode translator table instead of listing it in genptr.c.
Skip empty translators and inline the helper slot value.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_func_table.py | 29 ++++++++++++++++++++++++++++
 target/hexagon/gen_tcg_funcs.py      |  4 ----
 target/hexagon/genptr.c              | 15 +-------------
 target/hexagon/hex_common.py         |  3 ++-
 target/hexagon/meson.build           | 11 +++++++++++
 5 files changed, 43 insertions(+), 19 deletions(-)
 create mode 100755 target/hexagon/gen_tcg_func_table.py

diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
new file mode 100755
index 0000000000..ba56ede568
--- /dev/null
+++ b/target/hexagon/gen_tcg_func_table.py
@@ -0,0 +1,29 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import hex_common
+
+
+def main():
+    args = hex_common.parse_common_args(
+        "Emit the table of instruction translation functions"
+    )
+
+    with open(args.out, "w") as f:
+        f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
+        f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
+        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {\n")
+
+        for tag in hex_common.tags:
+            if hex_common.tag_ignore(tag):
+                continue
+            f.write(f"    [{tag}] = generate_{tag},\n")
+
+        f.write("};\n\n")
+        f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
+
+
+if __name__ == "__main__":
+    main()
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index 61effa38cf..4305eda996 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -173,11 +173,7 @@ def main():
 
         for tag in hex_common.tags:
             if hex_common.tag_ignore(tag):
-                f.write(f"static void generate_{tag}"
-                        f"(DisasContext *ctx)\n")
-                f.write("{\n}\n\n")
                 continue
-
             gen_def_tcg_func(f, tag, tagregs, tagimms)
 
         f.write("#endif    /* HEXAGON_TCG_FUNCS_H */\n")
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index d0aabacf35..fd3f6a1edf 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -752,15 +752,6 @@ void gen_vframecheck(DisasContext *ctx, TCGv vsp)
     tcg_gen_mov_tl(hex_gpr[HEX_REG_VSP], vsp);
 }
 
-#ifndef CONFIG_HEXAGON_IDEF_PARSER
-static TCGv gen_slotval(DisasContext *ctx)
-{
-    int slotval =
-        (ctx->pkt.pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1);
-    return tcg_constant_tl(slotval);
-}
-#endif
-
 void gen_store32(TCGv vaddr, TCGv src, uint32_t width, uint32_t slot)
 {
     tcg_gen_mov_tl(hex_store_addr[slot], vaddr);
@@ -1855,8 +1846,4 @@ void gen_add_sat_i64(DisasContext *ctx, TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 }
 
 #include "tcg_funcs_generated.c.inc"
-const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {
-#define OPCODE(X)    [X] = generate_##X
-#include "opcodes_def_generated.h.inc"
-#undef OPCODE
-};
+#include "tcg_func_table_generated.c.inc"
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 94e70b8657..a4807bed7b 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1520,7 +1520,8 @@ def helper_args(tag, regs, imms):
     if need_slot(tag):
         args.append(HelperArg(
             "i32",
-            "gen_slotval(ctx)",
+            "tcg_constant_i32((ctx->pkt.pkt_has_scalar_store_s1 & 1) | "
+            "(ctx->insn->slot << 1))",
             "uint32_t slotval"
         ))
     if need_part1(tag):
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 0633852321..429317a658 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -42,10 +42,21 @@ hexagon_ss.add(semantics_generated)
 #
 # Step 2
 # We use Python scripts to generate the following files
+#     tcg_func_table_generated.c.inc
 #     printinsn_generated.h.inc
 #     op_attribs_generated.h.inc
 #     opcodes_def_generated.h.inc
 #
+tcg_func_table_generated = custom_target(
+    'tcg_func_table_generated.c.inc',
+    output: 'tcg_func_table_generated.c.inc',
+    depends: [semantics_generated],
+    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
+    command: [python, files('gen_tcg_func_table.py'), semantics_generated,
+              gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h, '@OUTPUT@'],
+)
+hexagon_ss.add(tcg_func_table_generated)
+
 printinsn_generated = custom_target(
     'printinsn_generated.h.inc',
     output: 'printinsn_generated.h.inc',
-- 
2.43.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89825606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KV22BTiY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCf-0000lF-6o; Thu, 29 Oct 2026 13:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006q9-6G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003b9-IR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDLMO227483; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rizyXyN5Yin
 CPOcFpeyAj8IA77rHfS+8kq4hlylJzts=; b=KV22BTiYCXEUeJIHlLYWVKF5hdr
 e6JBBGf0r+454eGhhHme/Q0wq7UAWXpUo6tq1nTIgezxdUGzvk3gXPtg1IS/wf6d
 CatTYgvc4vXKbTCuXTZlF+I0SsruU3y22a5kQ6Pib1LyR6mIS/HdQmH4c/CksNYE
 EjhVKBF8/vsOXOEkXpg/xIR/wJyHFG2a1oVa5GtDBgYcStCly26rO/NFL5NaTBec
 0mqfvM1yb8/JFSXDAA0ayCUBVxZOl24yPYRB0Xd1GmR4T1IA159Y8H+BPuiir3bV
 LERG1DywmwNSKydIYKmEFqFD39QEs23unCIrd8t/OnJDhrMFxD54a76DfQA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fjjq0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEm02474603; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69THiEUx2474579
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 907AF25833; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 08/20] target/hexagon: add HLX unsigned saturating gvec
 operations
Date: Thu, 29 Oct 2026 10:44:01 -0700
Message-ID: <20261029174413.643130-9-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8knOzysiHoYT
 vXOWKzGTzXeWNYTWLYRaHxQSY4NCSR9oNr9ytzfPr39AhxPGXCiUFyieDXTuCVK1HHis/df13/b
 Sf73dwCuUuTu73RArFUAwCIBine8y4OXVpaL8EuyZgVOmCWv2zxRgrjLXlnndkDk0swPBOD8aOe
 8izA/VOREVIcBfz/IAKvl+csqJGM1lwAXxf0kqIXzcwrmoAkQbBlJEmUebGRFq8fhi8imchxvfX
 J6biW0YxD1bykjswwOHL9tldNYPcgUwATner+vfNNBD9nRst6D6AhnPZuPioh2A6uHnDJgyK3C6
 D2aQK9yjYCs0Ai2I+ZbvwcgF38UcVLUNUkKnSbhBk8qnJ27FHOPVoGWFiNWyeEmksu/KSJEigNz
 OYq6+7JPvf9fG1vRqQ+M4dtDM86q3w==
X-Proofpoint-GUID: sl_6etC1zubKT5w_XYa7f06y2Vkpk136
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX72Tor+SYvuL8
 c/mWGaBrYswvlfzkRIeFQXBP3L/Kgb5IOFZP899FwA0/EIGhAiomzMIbAiztFVjUx1xTOGc68pf
 Hpd3CleIoSIB4QKsBNRvmroxWytXG+c=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=y0w5Q98WqDb3bp2lnDwA:9
X-Proofpoint-ORIG-GUID: sl_6etC1zubKT5w_XYa7f06y2Vkpk136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290069
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

Add out-of-line gvec helpers for signed-to-unsigned halfword saturation
and saturating absolute value.

HLX vectors exceed the gvec unroll limit, so these helpers run.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/genptr.c          |   2 +-
 target/hexagon/helper.h          |   7 ++
 target/hexagon/hex_common.py     |  10 +++
 target/hexagon/hlx_gvec_tables.c | 113 +++++++++++++++++++++++++++++++
 target/hexagon/hlx_gvec_tables.h |  15 ++++
 target/hexagon/hlx_helper.c      |  50 ++++++++++++++
 target/hexagon/meson.build       |   1 +
 7 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 target/hexagon/hlx_gvec_tables.c
 create mode 100644 target/hexagon/hlx_gvec_tables.h

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 808caf4289..b57f255b24 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -36,7 +36,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "gen_tcg_sys.h"
 #endif
-
+#include "hlx_gvec_tables.h"
 #include "genptr.h"
 
 static void gen_sabsdiff_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 766995fae3..471ef0903b 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -37,6 +37,13 @@ DEF_HELPER_5(hlx_store_vec, void, env, tl, ptr, i32, i32)
 DEF_HELPER_1(hlx_commit_store, void, env)
 DEF_HELPER_FLAGS_2(hlx_trace_op, TCG_CALL_NO_RWG, void, env, i32)
 
+/* GVec helpers for signed-to-unsigned MO_16 saturation. */
+DEF_HELPER_FLAGS_4(hlx_gvec_ushsat_add16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(hlx_gvec_ushsat_sub16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(hlx_gvec_abs_uh_sat16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 /* Floating point */
 DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
 DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index a6ac84d792..3f4d796a98 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -378,6 +378,16 @@ def skip_qemu_helper(tag):
                       "vece": "MO_16"},
     "LX_abs_uhp":    {"op": "gvec2_fn", "fn": "abs",
                       "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_add_uhh_sat":   {"op": "gvec3", "table": "hlx_ushsat_add_op",
+                         "vece": "MO_16"},
+    "LX_sub_uhh_sat":   {"op": "gvec3", "table": "hlx_ushsat_sub_op",
+                         "vece": "MO_16"},
+    "LX_add_uhp_h_sat": {"op": "gvec3", "table": "hlx_ushsat_add_op",
+                         "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_sub_uhp_h_sat": {"op": "gvec3", "table": "hlx_ushsat_sub_op",
+                         "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_abs_uh_sat":    {"op": "gvec2", "table": "hlx_abs_uh_sat_op",
+                         "vece": "MO_16"},
 }
 
 def is_hlx_inline_tag(tag):
diff --git a/target/hexagon/hlx_gvec_tables.c b/target/hexagon/hlx_gvec_tables.c
new file mode 100644
index 0000000000..dd5aa788e0
--- /dev/null
+++ b/target/hexagon/hlx_gvec_tables.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op-common.h"
+#include "tcg/tcg-op-gvec-common.h"
+#include "hlx_gvec_tables.h"
+#include "exec/helper-gen.h"
+
+/* Saturate signed halfword results to uint16_t. */
+
+static const TCGOpcode hlx_vecop_ushsat_add[] = {
+    INDEX_op_add_vec,
+    INDEX_op_ssadd_vec,
+    INDEX_op_smax_vec,
+    INDEX_op_cmp_vec,
+    0
+};
+
+static const TCGOpcode hlx_vecop_ushsat_sub[] = {
+    INDEX_op_sub_vec,
+    INDEX_op_sssub_vec,
+    INDEX_op_smax_vec,
+    INDEX_op_cmp_vec,
+    0
+};
+
+static const TCGOpcode hlx_vecop_abs_uh_sat[] = {
+    INDEX_op_abs_vec,
+    INDEX_op_umin_vec,
+    0
+};
+
+static void hlx_fniv_ushsat_add(unsigned vece, TCGv_vec r,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec wrap    = tcg_temp_new_vec_matching(r);
+    TCGv_vec ssat    = tcg_temp_new_vec_matching(r);
+    TCGv_vec pos_ovf = tcg_temp_new_vec_matching(r);
+    TCGv_vec pa      = tcg_temp_new_vec_matching(r);
+    TCGv_vec pb      = tcg_temp_new_vec_matching(r);
+    TCGv_vec zero    = tcg_constant_vec_matching(r, vece, 0);
+
+    tcg_gen_add_vec(vece, wrap, a, b);
+
+    tcg_gen_ssadd_vec(vece, ssat, a, b);
+    tcg_gen_smax_vec(vece, ssat, ssat, zero);
+
+    tcg_gen_cmp_vec(TCG_COND_GE, vece, pa, a, zero);
+    tcg_gen_cmp_vec(TCG_COND_GE, vece, pb, b, zero);
+    tcg_gen_cmp_vec(TCG_COND_LT, vece, pos_ovf, wrap, zero);
+    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, pa);
+    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, pb);
+
+    tcg_gen_bitsel_vec(vece, r, pos_ovf, wrap, ssat);
+}
+
+static void hlx_fniv_ushsat_sub(unsigned vece, TCGv_vec r,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec wrap    = tcg_temp_new_vec_matching(r);
+    TCGv_vec ssat    = tcg_temp_new_vec_matching(r);
+    TCGv_vec pos_ovf = tcg_temp_new_vec_matching(r);
+    TCGv_vec pa      = tcg_temp_new_vec_matching(r);
+    TCGv_vec nb      = tcg_temp_new_vec_matching(r);
+    TCGv_vec zero    = tcg_constant_vec_matching(r, vece, 0);
+
+    tcg_gen_sub_vec(vece, wrap, a, b);
+
+    tcg_gen_sssub_vec(vece, ssat, a, b);
+    tcg_gen_smax_vec(vece, ssat, ssat, zero);
+
+    /* Positive subtraction overflow needs a >= 0 and b < 0. */
+    tcg_gen_cmp_vec(TCG_COND_GE, vece, pa, a, zero);
+    tcg_gen_cmp_vec(TCG_COND_LT, vece, nb, b, zero);
+    tcg_gen_cmp_vec(TCG_COND_LT, vece, pos_ovf, wrap, zero);
+    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, pa);
+    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, nb);
+
+    tcg_gen_bitsel_vec(vece, r, pos_ovf, wrap, ssat);
+}
+
+static void hlx_fniv_abs_uh_sat(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    /* Clamp abs(INT16_MIN) to INT16_MAX. */
+    TCGv_vec imax = tcg_constant_vec_matching(r, vece, 0x7FFF);
+    tcg_gen_abs_vec(vece, r, a);
+    tcg_gen_umin_vec(vece, r, r, imax);
+}
+
+const GVecGen3 hlx_ushsat_add_op = {
+    .fniv    = hlx_fniv_ushsat_add,
+    .opt_opc = hlx_vecop_ushsat_add,
+    .fno     = gen_helper_hlx_gvec_ushsat_add16,
+    .vece    = MO_16,
+};
+
+const GVecGen3 hlx_ushsat_sub_op = {
+    .fniv    = hlx_fniv_ushsat_sub,
+    .opt_opc = hlx_vecop_ushsat_sub,
+    .fno     = gen_helper_hlx_gvec_ushsat_sub16,
+    .vece    = MO_16,
+};
+
+const GVecGen2 hlx_abs_uh_sat_op = {
+    .fniv    = hlx_fniv_abs_uh_sat,
+    .opt_opc = hlx_vecop_abs_uh_sat,
+    .fno     = gen_helper_hlx_gvec_abs_uh_sat16,
+    .vece    = MO_16,
+};
diff --git a/target/hexagon/hlx_gvec_tables.h b/target/hexagon/hlx_gvec_tables.h
new file mode 100644
index 0000000000..55ab6bb63f
--- /dev/null
+++ b/target/hexagon/hlx_gvec_tables.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HLX_GVEC_TABLES_H
+#define HLX_GVEC_TABLES_H
+
+#include "tcg/tcg-op-gvec-common.h"
+
+extern const GVecGen3 hlx_ushsat_add_op;
+extern const GVecGen3 hlx_ushsat_sub_op;
+extern const GVecGen2 hlx_abs_uh_sat_op;
+
+#endif /* HLX_GVEC_TABLES_H */
diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
index 6525abfb2c..906f31ba17 100644
--- a/target/hexagon/hlx_helper.c
+++ b/target/hexagon/hlx_helper.c
@@ -93,3 +93,53 @@ void HELPER(hlx_commit_reg)(CPUHexagonState *env, uint32_t rnum)
     memcpy(&env->hlx_ctx->LRegs[rnum], &env->future_LRegs[rnum],
            sizeof(HLXVector));
 }
+
+/* HLX vectors exceed the gvec inline limit. */
+void HELPER(hlx_gvec_ushsat_add16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int32_t r = (int32_t)(*(int16_t *)((char *)a + i))
+                  + (int32_t)(*(int16_t *)((char *)b + i));
+        if (r < 0) {
+            r = 0;
+        } else if (r > 0xFFFF) {
+            r = 0xFFFF;
+        }
+        *(uint16_t *)((char *)d + i) = (uint16_t)r;
+    }
+}
+
+void HELPER(hlx_gvec_ushsat_sub16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int32_t r = (int32_t)(*(int16_t *)((char *)a + i))
+                  - (int32_t)(*(int16_t *)((char *)b + i));
+        if (r < 0) {
+            r = 0;
+        } else if (r > 0xFFFF) {
+            r = 0xFFFF;
+        }
+        *(uint16_t *)((char *)d + i) = (uint16_t)r;
+    }
+}
+
+void HELPER(hlx_gvec_abs_uh_sat16)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t v = *(int16_t *)((char *)a + i);
+        int32_t r = (v < 0) ? -(int32_t)v : (int32_t)v;
+        if (r > INT16_MAX) {
+            r = INT16_MAX;
+        }
+        *(int16_t *)((char *)d + i) = (int16_t)r;
+    }
+}
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 1aa4df7ac7..fd4983343d 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -266,6 +266,7 @@ hexagon_ss.add(files(
     'mmvec/hvx_ieee_fp.c',
     'mmvec/hvx_qfloat.c',
     'hlx_helper.c',
+    'hlx_gvec_tables.c',
 ))
 
 hexagon_softmmu_ss.add(files(
-- 
2.43.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BE606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NM9fJicD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUCx-0001D9-8U; Thu, 29 Oct 2026 13:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006qF-8W
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bc-IR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDPkN594481; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vgCRQvpoAoq
 lkRUju1N9d1ldLB0nSBmvwr+U7TyW2K4=; b=NM9fJicDZaqk7z8h945PFDmYlnk
 eIqw569bEzcqXzgHc7ilLBeND5FfRECvzFqmCXYLPQmCRyqPWjdtNhGOXsFGLOaZ
 Tdx4ZRC5qPf+YSBgeJnZv1vSA+6RQMFfuknxA0j9I5ZmS+YRsxr+SvgXxx+gcD4a
 SDqnEsdCGABx+t4N2OBZm867bhKH295TmQVid64mRwlJa+z3FL8KGmBHD2mWIKiC
 bt/xsv2BD78wYq3XEHFSDwk71z4rs03Xola0vWFuJRiPy8MBa1CJv7IlMy9ivOw4
 bJ0uPR2Xw5pwK7tyJ7DWv/ahUbR3ioyx9HTI8F/BWq67eDXYLDfXN6KsHCQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3kt8x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEo72516240; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69THiEKi2516205
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 99EFD2583C; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 10/20] target/hexagon: add HLX absdiff and sign-fill gvec
 operations
Date: Thu, 29 Oct 2026 10:44:03 -0700
Message-ID: <20261029174413.643130-11-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXy8TQKBrj27lm
 hcUfjsPyH7Gij1r57AXvLNjCWATGrqME9zyxyJCdAkHw8Li6oi6vT7eTBjd2cgtJnDuKioSJA9H
 ARzTfskb3B134vdGXtcIhTHx3sVDuWc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXywVRJN+mB3fB
 uDhwnw7VWGaasTQM1xSxQcnY/PVWv8D4F0beR/XQHsuekA/FglabNQAKX46TWvdI+PwQOQMXdcz
 urhOGxg/tV8dzOTEB2gqOrKWufCu8BmJamJn/eRlfmJcDzEjMi1TJWypyCsIcjEp6/R6r50CpVt
 woxCC/yzCA3GMbSGooteWiVV3Z7I3XC8gxZTGWQBGO+HA4YRTVflQb/DpehG9VyK4wYh68yOFKZ
 MHx+SNdxNVER+Ke3brzkJ/QkDautDHw6XMvndjWEgc4veW+wZ3zZZ2oZ7VTmqpuFpz0hAWmVUPa
 WuzRazfJ+Hzj3ux5ROp9Zg9xntnlSoK7+mH5ARAtdnOQDpyYfqbxd8nzc1bKVa/nVC5/njAh6YG
 EzHHzeWnn6upVewhBNTJ2c0o8TH3voiuGrfYVcpX2BGXiQwtAMlPLwDvWLfJFWoQJ5szokZN/Ma
 kXBNhHZd1rzP9EzcUGA==
X-Proofpoint-ORIG-GUID: 0PWfkQcECKE5nuYw6TRylmlZA2NRwYFb
X-Proofpoint-GUID: 0PWfkQcECKE5nuYw6TRylmlZA2NRwYFb
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=0GoE0hK8fztsA7g0gbMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
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

Add gvec helpers for halfword absolute difference and sign fill.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/helper.h          |  9 +++++
 target/hexagon/hex_common.py     | 10 +++++
 target/hexagon/hlx_gvec_tables.c | 68 ++++++++++++++++++++++++++++++++
 target/hexagon/hlx_gvec_tables.h |  5 +++
 target/hexagon/hlx_helper.c      | 39 ++++++++++++++++++
 5 files changed, 131 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index f42cb8d9b6..1ced8c5651 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -54,6 +54,15 @@ DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16_rnd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 
+/* GVec helpers for MO_16 absolute differences. */
+DEF_HELPER_FLAGS_4(hlx_gvec_absdiff_sh16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(hlx_gvec_absdiff_uh16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+
+/* GVec helper for a halfword arithmetic shift by 15. */
+DEF_HELPER_FLAGS_3(hlx_gvec_sari15_h16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 /* Floating point */
 DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
 DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index d0b36b8e06..fc6f69b411 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -404,6 +404,16 @@ def skip_qemu_helper(tag):
                          "vece": "MO_16"},
     "LX_avg_uh_rnd":    {"op": "gvec3", "table": "hlx_avg_uh_rnd_op",
                          "vece": "MO_16"},
+    "LX_absdiff_h":     {"op": "gvec3", "table": "hlx_absdiff_sh_op",
+                         "vece": "MO_16"},
+    "LX_absdiff_uh":    {"op": "gvec3", "table": "hlx_absdiff_uh_op",
+                         "vece": "MO_16"},
+
+    # These use one source register, not a pair destination.
+    "LX_conv_uw_uh":    {"op": "conv_h_to_w_pair", "sign_extend": False,
+                         "vece": "MO_16"},
+    "LX_conv_w_h":      {"op": "conv_h_to_w_pair", "sign_extend": True,
+                         "vece": "MO_16", "table": "hlx_sari15_h_op"},
 }
 
 def is_hlx_inline_tag(tag):
diff --git a/target/hexagon/hlx_gvec_tables.c b/target/hexagon/hlx_gvec_tables.c
index a5d40e149c..f1e36bd20b 100644
--- a/target/hexagon/hlx_gvec_tables.c
+++ b/target/hexagon/hlx_gvec_tables.c
@@ -216,3 +216,71 @@ const GVecGen3 hlx_avg_uh_rnd_op = {
     .fno     = gen_helper_hlx_gvec_avg_uh16_rnd,
     .vece    = MO_16,
 };
+
+/* Halfword absolute difference as uint16_t. */
+static void hlx_fniv_absdiff_sh(unsigned vece, TCGv_vec r,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec mx = tcg_temp_new_vec_matching(r);
+    TCGv_vec mn = tcg_temp_new_vec_matching(r);
+    tcg_gen_smax_vec(vece, mx, a, b);
+    tcg_gen_smin_vec(vece, mn, a, b);
+    tcg_gen_sub_vec(vece, r, mx, mn);
+}
+
+static void hlx_fniv_absdiff_uh(unsigned vece, TCGv_vec r,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec mx = tcg_temp_new_vec_matching(r);
+    TCGv_vec mn = tcg_temp_new_vec_matching(r);
+    tcg_gen_umax_vec(vece, mx, a, b);
+    tcg_gen_umin_vec(vece, mn, a, b);
+    tcg_gen_sub_vec(vece, r, mx, mn);
+}
+
+static const TCGOpcode hlx_vecop_absdiff_sh[] = {
+    INDEX_op_smax_vec,
+    INDEX_op_smin_vec,
+    INDEX_op_sub_vec,
+    0
+};
+
+static const TCGOpcode hlx_vecop_absdiff_uh[] = {
+    INDEX_op_umax_vec,
+    INDEX_op_umin_vec,
+    INDEX_op_sub_vec,
+    0
+};
+
+const GVecGen3 hlx_absdiff_sh_op = {
+    .fniv    = hlx_fniv_absdiff_sh,
+    .opt_opc = hlx_vecop_absdiff_sh,
+    .fno     = gen_helper_hlx_gvec_absdiff_sh16,
+    .vece    = MO_16,
+};
+
+const GVecGen3 hlx_absdiff_uh_op = {
+    .fniv    = hlx_fniv_absdiff_uh,
+    .opt_opc = hlx_vecop_absdiff_uh,
+    .fno     = gen_helper_hlx_gvec_absdiff_uh16,
+    .vece    = MO_16,
+};
+
+/* Fill LX_conv_w_h's high register with sign bits. */
+
+static void hlx_fniv_sari15_h(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    tcg_gen_sari_vec(vece, r, a, 15);
+}
+
+static const TCGOpcode hlx_vecop_sari15_h[] = {
+    INDEX_op_sari_vec,
+    0
+};
+
+const GVecGen2 hlx_sari15_h_op = {
+    .fniv    = hlx_fniv_sari15_h,
+    .opt_opc = hlx_vecop_sari15_h,
+    .fno     = gen_helper_hlx_gvec_sari15_h16,
+    .vece    = MO_16,
+};
diff --git a/target/hexagon/hlx_gvec_tables.h b/target/hexagon/hlx_gvec_tables.h
index e01c853eb1..4375bf3ff8 100644
--- a/target/hexagon/hlx_gvec_tables.h
+++ b/target/hexagon/hlx_gvec_tables.h
@@ -17,4 +17,9 @@ extern const GVecGen3 hlx_avg_sh_rnd_op;
 extern const GVecGen3 hlx_avg_uh_op;
 extern const GVecGen3 hlx_avg_uh_rnd_op;
 
+extern const GVecGen3 hlx_absdiff_sh_op;
+extern const GVecGen3 hlx_absdiff_uh_op;
+
+extern const GVecGen2 hlx_sari15_h_op;
+
 #endif /* HLX_GVEC_TABLES_H */
diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
index c624b66f83..c063706cfa 100644
--- a/target/hexagon/hlx_helper.c
+++ b/target/hexagon/hlx_helper.c
@@ -195,3 +195,42 @@ void HELPER(hlx_gvec_avg_uh16_rnd)(void *d, void *a, void *b, uint32_t desc)
         *(uint16_t *)((char *)d + i) = r;
     }
 }
+
+void HELPER(hlx_gvec_absdiff_sh16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t av = *(int16_t *)((char *)a + i);
+        int16_t bv = *(int16_t *)((char *)b + i);
+        int16_t mx = (av > bv) ? av : bv;
+        int16_t mn = (av > bv) ? bv : av;
+        *(uint16_t *)((char *)d + i) = (uint16_t)(mx - mn);
+    }
+}
+
+void HELPER(hlx_gvec_absdiff_uh16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint16_t av = *(uint16_t *)((char *)a + i);
+        uint16_t bv = *(uint16_t *)((char *)b + i);
+        uint16_t mx = (av > bv) ? av : bv;
+        uint16_t mn = (av > bv) ? bv : av;
+        *(uint16_t *)((char *)d + i) = mx - mn;
+    }
+}
+
+void HELPER(hlx_gvec_sari15_h16)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t av = *(int16_t *)((char *)a + i);
+        *(uint16_t *)((char *)d + i) = (uint16_t)(av >> 15);
+    }
+}
-- 
2.43.0



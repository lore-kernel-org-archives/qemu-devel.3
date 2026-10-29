Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jSf+/clX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUC9-0000M2-JQ; Thu, 29 Oct 2026 13:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUBC-0006u6-M2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB8-0003be-G2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXZH3234256; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rESNXueu3Wb
 1frkCuEzcplEzDTtL5aj/Mc2cYQHQQBc=; b=jSf+/clXS8sqUAGdqVDiYO3r8Uz
 L+y50qfQnrLeGo8AW+47Y9KCD2k6N6enWsA5s3tHfw+lCNeF/YFTMj3dJT2ZZQQz
 rG0FHF2wjbdCJXZ0VYU3DVeOn2geNEQa5FzWo0zQjv84/uxT9NJQsFjRH9Yblb6e
 tmKDxwoPIRqCuE1VgqzbbNTCs0hqriea+VixE7rW4v9JsxsMK9/+DvJ3NhFUbsQR
 60zxmqCvBzw2JNQijFyluU21OBhudcJXOSoTBfkjhNPDJT2Gm5/b/Cc4wdoNvPfx
 mEVEQ01nblGx6F4zftgMJCewHNwlHdSDVNHYgF2HPPKuAF3pkHFOa2wG+1w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b28cv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiEQN2516234; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69THiEaZ2516199
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 951F42583A; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 09/20] target/hexagon: add HLX compare and average gvec
 operations
Date: Thu, 29 Oct 2026 10:44:02 -0700
Message-ID: <20261029174413.643130-10-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX1PwICpnw90NL
 72uTaTLmVZKL3nYHtJEevv44xWzFrXdeuzJV/FFncQuafToWmrbGedi1iDhm3qN3wq5YpgBUbEf
 C+yx8vznhnepWyJYgUW0qxS67g/mk7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXxb9GcgnQLuQn
 4u0XPfsN9uDNbnZDIAvzX4psfVUsa3dJtMwLFvmFQKBI7cJ9bH2+pSyS0cwuV71E/JwI9V27YG+
 hJCKB0bxMJQQPft6als+xm2VYYZlAunvSXwWDNMECvtgUXQ7EQM+2pSQsgIugCx6gdRbBz8izXu
 zWfEMOmVIGQp9l0z13j+0LzJveLLV9zqiHgQxvxk7SmLSJaW23QzOJurzJByY4hOUd6TtSnfsnU
 +9wyvkYsFj+ZFqQR5jDPpL59pM79WZdI+4HAO7kN8qt7gTvtZlPB+vXXnoL5FiXk+F0wnuN4bhh
 H7jGjZx2HOmxVUJdSyLjL5LSrypwvu30KTW0LpSdIfx7iur7f+8Cx67Zu79galKO6cVcE2Zhe7L
 AT0gGKFaZ+5tfW4nomtZdW1YkLBvg8XC89uiChRwqH/wyVKXA/+Q7N1M2z1lD3W6n2UWuuFixVG
 Mj5X84mCBm47BfK0W+g==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=nO8VWNwolxpQ2wceXOEA:9
X-Proofpoint-GUID: Sud7t6GZqJSOfSpeXtEObZh37lOk4bVy
X-Proofpoint-ORIG-GUID: Sud7t6GZqJSOfSpeXtEObZh37lOk4bVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 phishscore=0
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

Add halfword greater-than compares and out-of-line helpers for
truncating and rounding halfword averages.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/helper.h          |  10 +++
 target/hexagon/hex_common.py     |  16 +++++
 target/hexagon/hlx_gvec_tables.c | 105 +++++++++++++++++++++++++++++++
 target/hexagon/hlx_gvec_tables.h |   5 ++
 target/hexagon/hlx_helper.c      |  52 +++++++++++++++
 5 files changed, 188 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 471ef0903b..f42cb8d9b6 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -44,6 +44,16 @@ DEF_HELPER_FLAGS_4(hlx_gvec_ushsat_sub16, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(hlx_gvec_abs_uh_sat16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+/* GVec helpers for MO_16 averages. */
+DEF_HELPER_FLAGS_4(hlx_gvec_avg_sh16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(hlx_gvec_avg_sh16_rnd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16_rnd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+
 /* Floating point */
 DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
 DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 3f4d796a98..d0b36b8e06 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -388,6 +388,22 @@ def skip_qemu_helper(tag):
                          "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
     "LX_abs_uh_sat":    {"op": "gvec2", "table": "hlx_abs_uh_sat_op",
                          "vece": "MO_16"},
+    "LX_cmp_gt_h":   {"op": "cmp",    "cond": "TCG_COND_GT",
+                      "vece": "MO_16"},
+    "LX_cmp_gt_uh":  {"op": "cmp",    "cond": "TCG_COND_GTU",
+                      "vece": "MO_16"},
+    "LX_cmp_gt_hp":  {"op": "cmp",    "cond": "TCG_COND_GT",
+                      "vece": "MO_16",   "size": "2 * sizeof(HLXVector)"},
+    "LX_cmp_gt_uhp": {"op": "cmp",    "cond": "TCG_COND_GTU",
+                      "vece": "MO_16",   "size": "2 * sizeof(HLXVector)"},
+    "LX_avg_h":         {"op": "gvec3", "table": "hlx_avg_sh_op",
+                         "vece": "MO_16"},
+    "LX_avg_h_rnd":     {"op": "gvec3", "table": "hlx_avg_sh_rnd_op",
+                         "vece": "MO_16"},
+    "LX_avg_uh":        {"op": "gvec3", "table": "hlx_avg_uh_op",
+                         "vece": "MO_16"},
+    "LX_avg_uh_rnd":    {"op": "gvec3", "table": "hlx_avg_uh_rnd_op",
+                         "vece": "MO_16"},
 }
 
 def is_hlx_inline_tag(tag):
diff --git a/target/hexagon/hlx_gvec_tables.c b/target/hexagon/hlx_gvec_tables.c
index dd5aa788e0..a5d40e149c 100644
--- a/target/hexagon/hlx_gvec_tables.c
+++ b/target/hexagon/hlx_gvec_tables.c
@@ -111,3 +111,108 @@ const GVecGen2 hlx_abs_uh_sat_op = {
     .fno     = gen_helper_hlx_gvec_abs_uh_sat16,
     .vece    = MO_16,
 };
+
+/* Halfword averages. The shift is arithmetic or logical by signedness. */
+static void hlx_fniv_avg_sh(unsigned vece, TCGv_vec r,
+                             TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec ta = tcg_temp_new_vec_matching(r);
+    TCGv_vec tb = tcg_temp_new_vec_matching(r);
+    tcg_gen_and_vec(vece, ta, a, b);
+    tcg_gen_xor_vec(vece, tb, a, b);
+    tcg_gen_sari_vec(vece, tb, tb, 1);
+    tcg_gen_add_vec(vece, r, ta, tb);
+}
+
+static void hlx_fniv_avg_sh_rnd(unsigned vece, TCGv_vec r,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec ta = tcg_temp_new_vec_matching(r);
+    TCGv_vec tb = tcg_temp_new_vec_matching(r);
+    tcg_gen_or_vec(vece, ta, a, b);
+    tcg_gen_xor_vec(vece, tb, a, b);
+    tcg_gen_sari_vec(vece, tb, tb, 1);
+    tcg_gen_sub_vec(vece, r, ta, tb);
+}
+
+static void hlx_fniv_avg_uh(unsigned vece, TCGv_vec r,
+                             TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec ta = tcg_temp_new_vec_matching(r);
+    TCGv_vec tb = tcg_temp_new_vec_matching(r);
+    tcg_gen_and_vec(vece, ta, a, b);
+    tcg_gen_xor_vec(vece, tb, a, b);
+    tcg_gen_shri_vec(vece, tb, tb, 1);
+    tcg_gen_add_vec(vece, r, ta, tb);
+}
+
+static void hlx_fniv_avg_uh_rnd(unsigned vece, TCGv_vec r,
+                                  TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec ta = tcg_temp_new_vec_matching(r);
+    TCGv_vec tb = tcg_temp_new_vec_matching(r);
+    tcg_gen_or_vec(vece, ta, a, b);
+    tcg_gen_xor_vec(vece, tb, a, b);
+    tcg_gen_shri_vec(vece, tb, tb, 1);
+    tcg_gen_sub_vec(vece, r, ta, tb);
+}
+
+static const TCGOpcode hlx_vecop_avg_sh[] = {
+    INDEX_op_and_vec,
+    INDEX_op_xor_vec,
+    INDEX_op_sari_vec,
+    INDEX_op_add_vec,
+    0
+};
+
+static const TCGOpcode hlx_vecop_avg_sh_rnd[] = {
+    INDEX_op_or_vec,
+    INDEX_op_xor_vec,
+    INDEX_op_sari_vec,
+    INDEX_op_sub_vec,
+    0
+};
+
+static const TCGOpcode hlx_vecop_avg_uh[] = {
+    INDEX_op_and_vec,
+    INDEX_op_xor_vec,
+    INDEX_op_shri_vec,
+    INDEX_op_add_vec,
+    0
+};
+
+static const TCGOpcode hlx_vecop_avg_uh_rnd[] = {
+    INDEX_op_or_vec,
+    INDEX_op_xor_vec,
+    INDEX_op_shri_vec,
+    INDEX_op_sub_vec,
+    0
+};
+
+const GVecGen3 hlx_avg_sh_op = {
+    .fniv    = hlx_fniv_avg_sh,
+    .opt_opc = hlx_vecop_avg_sh,
+    .fno     = gen_helper_hlx_gvec_avg_sh16,
+    .vece    = MO_16,
+};
+
+const GVecGen3 hlx_avg_sh_rnd_op = {
+    .fniv    = hlx_fniv_avg_sh_rnd,
+    .opt_opc = hlx_vecop_avg_sh_rnd,
+    .fno     = gen_helper_hlx_gvec_avg_sh16_rnd,
+    .vece    = MO_16,
+};
+
+const GVecGen3 hlx_avg_uh_op = {
+    .fniv    = hlx_fniv_avg_uh,
+    .opt_opc = hlx_vecop_avg_uh,
+    .fno     = gen_helper_hlx_gvec_avg_uh16,
+    .vece    = MO_16,
+};
+
+const GVecGen3 hlx_avg_uh_rnd_op = {
+    .fniv    = hlx_fniv_avg_uh_rnd,
+    .opt_opc = hlx_vecop_avg_uh_rnd,
+    .fno     = gen_helper_hlx_gvec_avg_uh16_rnd,
+    .vece    = MO_16,
+};
diff --git a/target/hexagon/hlx_gvec_tables.h b/target/hexagon/hlx_gvec_tables.h
index 55ab6bb63f..e01c853eb1 100644
--- a/target/hexagon/hlx_gvec_tables.h
+++ b/target/hexagon/hlx_gvec_tables.h
@@ -12,4 +12,9 @@ extern const GVecGen3 hlx_ushsat_add_op;
 extern const GVecGen3 hlx_ushsat_sub_op;
 extern const GVecGen2 hlx_abs_uh_sat_op;
 
+extern const GVecGen3 hlx_avg_sh_op;
+extern const GVecGen3 hlx_avg_sh_rnd_op;
+extern const GVecGen3 hlx_avg_uh_op;
+extern const GVecGen3 hlx_avg_uh_rnd_op;
+
 #endif /* HLX_GVEC_TABLES_H */
diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
index 906f31ba17..c624b66f83 100644
--- a/target/hexagon/hlx_helper.c
+++ b/target/hexagon/hlx_helper.c
@@ -143,3 +143,55 @@ void HELPER(hlx_gvec_abs_uh_sat16)(void *d, void *a, uint32_t desc)
         *(int16_t *)((char *)d + i) = (int16_t)r;
     }
 }
+
+void HELPER(hlx_gvec_avg_sh16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t av = *(int16_t *)((char *)a + i);
+        int16_t bv = *(int16_t *)((char *)b + i);
+        int16_t r = (int16_t)((av & bv) + ((av ^ bv) >> 1));
+        *(int16_t *)((char *)d + i) = r;
+    }
+}
+
+void HELPER(hlx_gvec_avg_sh16_rnd)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int16_t av = *(int16_t *)((char *)a + i);
+        int16_t bv = *(int16_t *)((char *)b + i);
+        int16_t r = (int16_t)((av | bv) - ((av ^ bv) >> 1));
+        *(int16_t *)((char *)d + i) = r;
+    }
+}
+
+void HELPER(hlx_gvec_avg_uh16)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint16_t av = *(uint16_t *)((char *)a + i);
+        uint16_t bv = *(uint16_t *)((char *)b + i);
+        uint16_t r = (uint16_t)((av & bv) + ((av ^ bv) >> 1));
+        *(uint16_t *)((char *)d + i) = r;
+    }
+}
+
+void HELPER(hlx_gvec_avg_uh16_rnd)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint16_t av = *(uint16_t *)((char *)a + i);
+        uint16_t bv = *(uint16_t *)((char *)b + i);
+        uint16_t r = (uint16_t)((av | bv) - ((av ^ bv) >> 1));
+        *(uint16_t *)((char *)d + i) = r;
+    }
+}
-- 
2.43.0



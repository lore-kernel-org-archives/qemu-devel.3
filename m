Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RHZ0Z5us
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUD7-0001t1-87; Thu, 29 Oct 2026 13:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006pq-4G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003bi-Mg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDDVA1086989; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5Ol8R07k7Cb
 U8/47pDWrI0QMxBbsMZ8UMcUZTXjjOjQ=; b=RHZ0Z5usB5T5r5eG1nyoNv1KHbs
 xgvRZtUUt4gyNH9Lf+YtB8WeoG9k9RHkKHFSTkBCnuL6zDbQMpDlgQSBFWPuAn5Z
 rZ5/FbxGUC/pwaK5NdGwWq7xtu/SJlUa0uNqJMv5LCIkNf3zZUgpNHIP5JzbsM1E
 jz0PMabLGXI7N1me5xnzdp/fk0iFpyK0CcOV+Awzp52jcRPiRCU9kbIx/yQai274
 lvPvwuw+4O0y9KTtvOSelFTTDPiMRFC7upvSaqMZ9cX/jJd3wT2pPtVjf20cf8Uv
 CTo+Tqfd4Zw7EaeE+68+v15Z7089acIthM0U3RsNabddeU2Q6NN8uPa9PaA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmpcg47-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiE8l2619260; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69THiEqw2619252
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 8B8AB25832; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
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
Subject: [PATCH 07/20] target/hexagon: emit basic HLX vector operations inline
Date: Thu, 29 Oct 2026 10:44:00 -0700
Message-ID: <20261029174413.643130-8-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX/3JQZH7WCAuy
 qMan7npIOSzYoOJucHfvin/RcTA54TcgbsBCzncJIJtF7tNa+HpJFKcBAS0oRJZv8gvlBjpsvo6
 GUHEmLg9JpOmLUNnLndHOYma7jXaGC3P/JsPvtKpFLBO5hxhItJgeGSe9Bz2FJBd/Y8KjwkTfaX
 sGqjTUA+UxuGc4E2WRQiVLxkUC37LHNH/W2RHk/73CYfR4qIm8StG8enK4ZSntctbsphLxhxrpU
 3PyrgW8Awt0QrIAC0gGU89829GFTr0MVL4vHbJZb4k/vfCdr7WGiMjAkxaxMElUxuyt6kRonjey
 lnXiB1u+gsnqKcwQ11nnGjEkiYd9D5TyIanoAPdztTOA4yuGJ31JOWy+xjWDhhiQYrm+PBjsQit
 Hr+DKtIjLbv52hsJpwvxEan065M3Tg==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=tyIk8DHfsFUIbu5kUnIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX4Q1DLDgdS/Mw
 DLs1ga/wfHi5GW7W7KvFnnLDvtLrkJSudCP5wSiv/71Xa7LuIrDzX7xD2I0cy1TJPFvfi5MnIzm
 v8eR8xtzAZrFNb8camMT2tBsh43FbXA=
X-Proofpoint-GUID: tUsASJJ4VTMIuK2O1FHkTsFFM3pULOU7
X-Proofpoint-ORIG-GUID: tUsASJJ4VTMIuK2O1FHkTsFFM3pULOU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Emit basic HLX arithmetic, logical, min, max, and abs operations with
gvec instead of helpers.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/genptr.c      |   1 +
 target/hexagon/hex_common.py | 149 +++++++++++++++++++++++++----------
 2 files changed, 107 insertions(+), 43 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index fd3f6a1edf..808caf4289 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
+#include "hw/hexagon/hexagon_hlx.h"
 #include "internal.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 091c1bf7ef..a6ac84d792 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -321,6 +321,63 @@ def skip_qemu_helper(tag):
     "LX_assign_w":   {"op": "mov",          "vece": "MO_64",
                       "size": "2 * sizeof(HLXVector)"},
     "LX_combine_w":  {"op": "combine_pair", "vece": "MO_64"},
+    "LX_add_h_sat":  {"op": "gvec3_fn", "fn": "ssadd",
+                      "vece": "MO_16"},
+    "LX_add_uh_sat": {"op": "gvec3_fn", "fn": "usadd",
+                      "vece": "MO_16"},
+    "LX_sub_h_sat":  {"op": "gvec3_fn", "fn": "sssub",
+                      "vece": "MO_16"},
+    "LX_sub_uh_sat": {"op": "gvec3_fn", "fn": "ussub",
+                      "vece": "MO_16"},
+    # Word forms use helpers because their halfwords are split.
+    "LX_add_hp_sat": {"op": "gvec3_fn", "fn": "ssadd",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_add_uhp_sat":{"op": "gvec3_fn", "fn": "usadd",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_sub_hp_sat": {"op": "gvec3_fn", "fn": "sssub",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_sub_uhp_sat":{"op": "gvec3_fn", "fn": "ussub",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_and":        {"op": "gvec3_fn",     "fn": "and",
+                      "vece": "MO_64"},
+    "LX_or":         {"op": "gvec3_fn",     "fn": "or",
+                      "vece": "MO_64"},
+    "LX_xor":        {"op": "gvec3_fn",     "fn": "xor",
+                      "vece": "MO_64"},
+    "LX_andn":       {"op": "gvec3_fn",     "fn": "andc",
+                      "vece": "MO_64"},
+    "LX_orn":        {"op": "gvec3_fn",     "fn": "orc",
+                      "vece": "MO_64"},
+    "LX_and_w":      {"op": "gvec3_fn",     "fn": "and",
+                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
+    "LX_or_w":       {"op": "gvec3_fn",     "fn": "or",
+                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
+    "LX_xor_w":      {"op": "gvec3_fn",     "fn": "xor",
+                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
+    "LX_andn_w":     {"op": "gvec3_fn",     "fn": "andc",
+                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
+    "LX_orn_w":      {"op": "gvec3_fn",     "fn": "orc",
+                      "vece": "MO_64", "size": "2 * sizeof(HLXVector)"},
+    "LX_min_h":      {"op": "gvec3_fn", "fn": "smin",
+                      "vece": "MO_16"},
+    "LX_max_h":      {"op": "gvec3_fn", "fn": "smax",
+                      "vece": "MO_16"},
+    "LX_min_uh":     {"op": "gvec3_fn", "fn": "umin",
+                      "vece": "MO_16"},
+    "LX_max_uh":     {"op": "gvec3_fn", "fn": "umax",
+                      "vece": "MO_16"},
+    "LX_min_hp":     {"op": "gvec3_fn", "fn": "smin",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_max_hp":     {"op": "gvec3_fn", "fn": "smax",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_min_uhp":    {"op": "gvec3_fn", "fn": "umin",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_max_uhp":    {"op": "gvec3_fn", "fn": "umax",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
+    "LX_abs_uh":     {"op": "gvec2_fn", "fn": "abs",
+                      "vece": "MO_16"},
+    "LX_abs_uhp":    {"op": "gvec2_fn", "fn": "abs",
+                      "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
 }
 
 def is_hlx_inline_tag(tag):
@@ -449,27 +506,29 @@ def reg(i):
                                    {b}_base, {b}_off,
                                    {oprsz}, {maxsz}, &{table});
             """))
-    elif op == "gvec3_arr":
-        # Like gvec3, but table is a GVecGen3[4] indexed by vece.
+    elif op == "gvec3_fn":
         d, a, b = reg(0), reg(1), reg(2)
-        table = desc["table"]
+        fn = desc["fn"]
         if pair_dst:
             f.write(code_fmt(f"""\
-                tcg_gen_gvec_3_var({d}_base, {d}_off,
-                                   {a}_base, {a}_off,
-                                   {b}_base, {b}_off,
-                                   {oprsz}, {maxsz}, &{table}[{vece}]);
-                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
-                                   {a}_base, {a}_off + sizeof(HLXVector),
-                                   {b}_base, {b}_off + sizeof(HLXVector),
-                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+                tcg_gen_gvec_{fn}_var({vece},
+                                      {d}_base, {d}_off,
+                                      {a}_base, {a}_off,
+                                      {b}_base, {b}_off,
+                                      {oprsz}, {maxsz});
+                tcg_gen_gvec_{fn}_var({vece},
+                                      {d}_base, {d}_off + sizeof(HLXVector),
+                                      {a}_base, {a}_off + sizeof(HLXVector),
+                                      {b}_base, {b}_off + sizeof(HLXVector),
+                                      {oprsz}, {maxsz});
             """))
         else:
             f.write(code_fmt(f"""\
-                tcg_gen_gvec_3_var({d}_base, {d}_off,
-                                   {a}_base, {a}_off,
-                                   {b}_base, {b}_off,
-                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+                tcg_gen_gvec_{fn}_var({vece},
+                                      {d}_base, {d}_off,
+                                      {a}_base, {a}_off,
+                                      {b}_base, {b}_off,
+                                      {oprsz}, {maxsz});
             """))
     elif op == "combine_pair":
         dd, u, v = reg(0), reg(1), reg(2)
@@ -486,7 +545,7 @@ def reg(i):
                                  {single}, {single});
         """))
     elif op == "gvec2":
-        # Two-operand op: dest and one source.  table is a const GVecGen2.
+        # Two-operand op: dest and one source. table is a const GVecGen2.
         d, a = reg(0), reg(1)
         table = desc["table"]
         if pair_dst:
@@ -504,46 +563,50 @@ def reg(i):
                                    {a}_base, {a}_off,
                                    {oprsz}, {maxsz}, &{table});
             """))
-    elif op == "gvec2_arr":
-        # Like gvec2, but table is a GVecGen2[4] indexed by vece.
+    elif op == "gvec2_fn":
         d, a = reg(0), reg(1)
-        table = desc["table"]
+        fn = desc["fn"]
         if pair_dst:
             f.write(code_fmt(f"""\
-                tcg_gen_gvec_2_var({d}_base, {d}_off,
-                                   {a}_base, {a}_off,
-                                   {oprsz}, {maxsz}, &{table}[{vece}]);
-                tcg_gen_gvec_2_var({d}_base, {d}_off + sizeof(HLXVector),
-                                   {a}_base, {a}_off + sizeof(HLXVector),
-                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+                tcg_gen_gvec_{fn}_var({vece},
+                                      {d}_base, {d}_off,
+                                      {a}_base, {a}_off,
+                                      {oprsz}, {maxsz});
+                tcg_gen_gvec_{fn}_var({vece},
+                                      {d}_base, {d}_off + sizeof(HLXVector),
+                                      {a}_base, {a}_off + sizeof(HLXVector),
+                                      {oprsz}, {maxsz});
             """))
         else:
             f.write(code_fmt(f"""\
-                tcg_gen_gvec_2_var({d}_base, {d}_off,
-                                   {a}_base, {a}_off,
-                                   {oprsz}, {maxsz}, &{table}[{vece}]);
+                tcg_gen_gvec_{fn}_var({vece},
+                                      {d}_base, {d}_off,
+                                      {a}_base, {a}_off,
+                                      {oprsz}, {maxsz});
             """))
-    elif op == "cmp_gt":
-        # a > b is done as b < a, with the less-than descriptor in "table"
+    elif op == "cmp":
         d, a, b = reg(0), reg(1), reg(2)
-        table = desc["table"]
+        cond = desc["cond"]
         if pair_dst:
             f.write(code_fmt(f"""\
-                tcg_gen_gvec_3_var({d}_base, {d}_off,
-                                   {b}_base, {b}_off,
-                                   {a}_base, {a}_off,
-                                   {oprsz}, {maxsz}, &{table});
-                tcg_gen_gvec_3_var({d}_base, {d}_off + sizeof(HLXVector),
-                                   {b}_base, {b}_off + sizeof(HLXVector),
-                                   {a}_base, {a}_off + sizeof(HLXVector),
-                                   {oprsz}, {maxsz}, &{table});
+                tcg_gen_gvec_cmp_var({cond}, {vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {b}_base, {b}_off,
+                                     {oprsz}, {maxsz});
+                tcg_gen_gvec_cmp_var({cond}, {vece},
+                                     {d}_base, {d}_off + sizeof(HLXVector),
+                                     {a}_base, {a}_off + sizeof(HLXVector),
+                                     {b}_base, {b}_off + sizeof(HLXVector),
+                                     {oprsz}, {maxsz});
             """))
         else:
             f.write(code_fmt(f"""\
-                tcg_gen_gvec_3_var({d}_base, {d}_off,
-                                   {b}_base, {b}_off,
-                                   {a}_base, {a}_off,
-                                   {oprsz}, {maxsz}, &{table});
+                tcg_gen_gvec_cmp_var({cond}, {vece},
+                                     {d}_base, {d}_off,
+                                     {a}_base, {a}_off,
+                                     {b}_base, {b}_off,
+                                     {oprsz}, {maxsz});
             """))
     elif op == "conv_h_to_w_pair":
         # lo = the source; hi = zeros (zxt) or the source >> 15 (sxt)
-- 
2.43.0



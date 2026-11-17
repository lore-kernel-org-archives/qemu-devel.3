Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0721606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b5E8sEWU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3T-0001Ks-F1; Tue, 17 Nov 2026 13:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2o-0001Fj-KQ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2j-0000oh-81
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:38 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR2To3503877
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IOrkzouhIHl
 kwFBM9iK/Kdo/GamgaotfpPdQ/NuS8rc=; b=b5E8sEWUA4zPUH/JDq+qnAZmla9
 1Bzy7UpS4EuvIR0ddDieojQkqygdfcGBfv6xQq93lHu7yJ2twD1Um4YA7/gBnXLo
 iJ6F4pRen4t5E1QLTM1Ck9ac47tTFqW+xgT2JbOe9jOYZ0bvjS/g/yNy8tBGB4Ft
 82eQVDhdsjPpMiR56x6ZOIAAXL719sRkL6hppm1FPWzhyvTkU5koLiDCkgviMN32
 UELRw/XdrFqtGKwzCKJFivsugvpL/EZ979Myk3stMQ6e/nvDVhMywSuapV24gBLb
 12VShOzuSph3lziBnQyES1kFIkOeZY7PJCJQN244VoZd6mkwln/qaKRmNmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv125ex-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUQ13129170; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6AHIaTli3129158
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:29 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 930D624FAD; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 02/14] target/hexagon: allow writes to V85 USR coprocessor
 fields
Date: Tue, 17 Nov 2026 10:36:17 -0800
Message-ID: <20261117183629.2002840-3-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 2jfc-1H6OAOK-IfcmlbR2yFJwOSfvvsd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX42jn1dU1A9hw
 SeNlpfBfmS1HCVkJca5aFqmLrmO36ZTWRwZtGID//NfHCXtBW6cXbO/fudOhZ0//V/ZHT7b1UCg
 z5NB1vJqK309n2I91oXWJn6cd0IqoIQ=
X-Proofpoint-ORIG-GUID: 2jfc-1H6OAOK-IfcmlbR2yFJwOSfvvsd
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc9eae cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pwpJZb41pcAE4D4LGfYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXy0ZVGrXz8AlE
 QpxLyrN60fMQsa9nteyeiMHJlBhAQVWxV0p8Yp747vgoc/vQ83UO6NZTFsm9wU48R2UyaFmVsw3
 OQfCoyqZHOnn22kLi9AekkPT8hX6OZWo8Vupzng0ky2Ja7uBXIH0ZYLryG1KFW3qU1DgAHwx0OT
 gJv2QPWSXo3kO+1+wHQannyEjelS9B++psXNyFtslKNuhadLrxj+70q8/gk46yBVHSWlV4KywvI
 3ff7Lttit7sZgO8yOFD1ooks5TPHKiwgl0xuMdaQ9uSOkCY6/fO0g2HLE0v+ptSBUBzF2qcp6/f
 h2B1BTyM9j7aMko3A3+rfPpxuc5xt++xjysneyOIrTJ9sCNXL6SFTVhtSLaw2y4GLfkBQYT/ve8
 FjmXLMaaigujcIygCnNZj0lAyivpkrmyDKvfglGPg1qoiV5nwRzK8G4yk7/G5vSt30U3d1Pctpj
 YySWFttSw3m+u0Swk2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

NPC and FPCOPROC are writable on V85. Remove them from the immutable
mask for that revision, without changing older CPU models.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/genptr.c             |  6 ++++++
 target/hexagon/reg_fields_def.h.inc |  2 ++
 tests/tcg/hexagon/meson.build       |  3 ++-
 tests/tcg/hexagon/packet_user.c     | 18 ++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 52615628e3..d226cc4ebb 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -562,6 +562,12 @@ static inline void gen_write_ctrl_reg(DisasContext *ctx, int reg_num,
             /* USR.FPSAT is reserved before v79 */
             reg_mask &= ~fGET_REG_FIELD_MASK(USR_FPSAT);
         }
+        if (reg_num == HEX_REG_USR &&
+            ctx->hex_def->hex_version >= HEX_VER_V85) {
+            /* V85 permits writes to NPC and FPCOPROC. */
+            reg_mask &= ~(fGET_REG_FIELD_MASK(USR_NPC) |
+                          fGET_REG_FIELD_MASK(USR_FPCOPROC));
+        }
         gen_masked_reg_write(val, hex_gpr[reg_num], reg_mask);
         tcg_gen_mov_tl(get_result_gpr(ctx, reg_num), val);
         if (reg_num == HEX_REG_QEMU_PKT_CNT) {
diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
index 32dbb2da30..4c0bd4674a 100644
--- a/target/hexagon/reg_fields_def.h.inc
+++ b/target/hexagon/reg_fields_def.h.inc
@@ -29,10 +29,12 @@ DEF_REG_FIELD(USR_FPDBZF,         2, 1)
 DEF_REG_FIELD(USR_FPOVFF,         3, 1)
 DEF_REG_FIELD(USR_FPUNFF,         4, 1)
 DEF_REG_FIELD(USR_FPINPF,         5, 1)
+DEF_REG_FIELD(USR_NPC,            6, 1)
 
 DEF_REG_FIELD(USR_LPCFG,          8, 2)
 
 DEF_REG_FIELD(USR_FPDAZ,         17, 1)
+DEF_REG_FIELD(USR_FPCOPROC,      20, 2)
 
 DEF_REG_FIELD(USR_FPRND,         22, 2)
 DEF_REG_FIELD(USR_FPSAT,         24, 1)
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index b3635be3fc..cb2e7e68b2 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -96,7 +96,8 @@ tests += {
   'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
   'multiple-writes.c': {'cflags': [cflags, '-mhvx']},
   'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
-  'packet_user.c': {'cflags': [cflags, '-O2']},
+  'packet_user.c': {'cflags': [cflags, '-O2'],
+                    'qemu_args': ['-cpu', 'v85']},
   'preg_alias.c': {'cflags': cflags},
   'dual_stores.c': {'cflags': cflags},
   'framekey.c': {'cflags': cflags},
diff --git a/tests/tcg/hexagon/packet_user.c b/tests/tcg/hexagon/packet_user.c
index acc77202ef..1343a0287a 100644
--- a/tests/tcg/hexagon/packet_user.c
+++ b/tests/tcg/hexagon/packet_user.c
@@ -30,9 +30,27 @@ static void test_predicate_read(void)
     check32(new, 0xff);
 }
 
+static void test_usr_mask(void)
+{
+    unsigned old, value;
+
+    asm volatile(
+        "%[old] = usr\n"
+        "r0 = #-1\n"
+        "usr = r0\n"
+        "%[value] = usr\n"
+        "usr = %[old]\n"
+        : [old] "=&r"(old), [value] "=&r"(value)
+        : : "r0"
+    );
+    /* V85 USR writable bits. */
+    check32(value, 0x3fffff7f);
+}
+
 int main(void)
 {
     test_predicate_read();
+    test_usr_mask();
     puts(err ? "FAIL" : "PASS");
     return err != 0;
 }
-- 
2.43.0



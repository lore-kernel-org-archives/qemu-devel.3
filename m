Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FCBC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9GS-0001ag-4j; Tue, 09 Jul 2024 07:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sR9GP-0001Oc-53; Tue, 09 Jul 2024 07:44:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sR9GJ-0004tO-RJ; Tue, 09 Jul 2024 07:44:04 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469B8Odx007567;
 Tue, 9 Jul 2024 11:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=jSdduZ9Z/MkWV
 Knf00JM4b2UUd4vYFwMPWCVn5SBq6M=; b=XnUkCqfo4heBSykflz3xjTyWb0mDR
 GkGiAn93mO6KerlkW0kBAXBhpVXQcz+suoM9PVRjcHXvGepDugLubFSBKnmyUIb0
 XX5Ntlf3L2NLBj/4il6RBLULBbcrDV/Dek+FFl35L+MA2VtS4O+t+pQ0Dgn6qIkj
 cRlYhrUUBR8aRgrPl2kCXDbrfnPj9tg9UDfMcXqhGTv6mI+bd+VYJgQVT5yCDZvU
 +Yj8wDRGcF4TK23lKpvOOO0NdplaJkrv50gF8pLRywQWzPDacwn5a3/qUp9r9HLt
 Bg4UxOULY6/Rrs4WEhEWyA1bES2DSCRFkeq145YKiSn1xSKGUbmqu1NIg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4093x903jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:56 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469BgKOx027482;
 Tue, 9 Jul 2024 11:43:55 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4093x903jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4699TlGZ006903; Tue, 9 Jul 2024 11:43:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jfmbyc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jul 2024 11:43:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 469BhpvO47055148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jul 2024 11:43:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34D3B2004D;
 Tue,  9 Jul 2024 11:43:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB44020040;
 Tue,  9 Jul 2024 11:43:49 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jul 2024 11:43:49 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v3 2/3] target/ppc: Update VMX storage access insns to use
 tcg_gen_qemu_ld/st_i128.
Date: Tue,  9 Jul 2024 17:13:40 +0530
Message-Id: <20240709114341.152175-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240709114341.152175-1-rathc@linux.ibm.com>
References: <20240709114341.152175-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t3QBYem2aCFDxMQtxnb8Kg28IUncJnRG
X-Proofpoint-ORIG-GUID: _rsxbxLd6n-g2QhXYqkbEdzAoN4kaMyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=736 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Updated instructions {l, st}vx to use tcg_gen_qemu_ld/st_i128,
instead of using 64 bits loads/stores in succession.
Introduced functions {get, set}_avr_full in vmx-impl.c.inc to
facilitate the above, and potential future usage.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate/vmx-impl.c.inc | 42 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index a182d2cf81..70d0ad2e71 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -24,25 +24,29 @@ static inline void set_avr64(int regno, TCGv_i64 src, bool high)
     tcg_gen_st_i64(src, tcg_env, avr64_offset(regno, high));
 }
 
+static inline void get_avr_full(TCGv_i128 dst, int regno)
+{
+    tcg_gen_ld_i128(dst, tcg_env, avr_full_offset(regno));
+}
+
+static inline void set_avr_full(int regno, TCGv_i128 src)
+{
+    tcg_gen_st_i128(src, tcg_env, avr_full_offset(regno));
+}
+
 static bool trans_LVX(DisasContext *ctx, arg_X *a)
 {
     TCGv EA;
-    TCGv_i64 avr;
+    TCGv_i128 avr;
     REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
     REQUIRE_VECTOR(ctx);
     gen_set_access_type(ctx, ACCESS_INT);
-    avr = tcg_temp_new_i64();
+    avr = tcg_temp_new_i128();
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_andi_tl(EA, EA, ~0xf);
-    /*
-     * We only need to swap high and low halves. gen_qemu_ld64_i64
-     * does necessary 64-bit byteswap already.
-     */
-    gen_qemu_ld64_i64(ctx, avr, EA);
-    set_avr64(a->rt, avr, !ctx->le_mode);
-    tcg_gen_addi_tl(EA, EA, 8);
-    gen_qemu_ld64_i64(ctx, avr, EA);
-    set_avr64(a->rt, avr, ctx->le_mode);
+    tcg_gen_qemu_ld_i128(avr, EA, ctx->mem_idx,
+                         DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR));
+    set_avr_full(a->rt, avr);
     return true;
 }
 
@@ -56,22 +60,16 @@ static bool trans_LVXL(DisasContext *ctx, arg_LVXL *a)
 static bool trans_STVX(DisasContext *ctx, arg_STVX *a)
 {
     TCGv EA;
-    TCGv_i64 avr;
+    TCGv_i128 avr;
     REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
     REQUIRE_VECTOR(ctx);
     gen_set_access_type(ctx, ACCESS_INT);
-    avr = tcg_temp_new_i64();
+    avr = tcg_temp_new_i128();
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_andi_tl(EA, EA, ~0xf);
-    /*
-     * We only need to swap high and low halves. gen_qemu_st64_i64
-     * does necessary 64-bit byteswap already.
-     */
-    get_avr64(avr, a->rt, !ctx->le_mode);
-    gen_qemu_st64_i64(ctx, avr, EA);
-    tcg_gen_addi_tl(EA, EA, 8);
-    get_avr64(avr, a->rt, ctx->le_mode);
-    gen_qemu_st64_i64(ctx, avr, EA);
+    get_avr_full(avr, a->rt);
+    tcg_gen_qemu_st_i128(avr, EA, ctx->mem_idx,
+                         DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR));
     return true;
 }
 
-- 
2.39.3



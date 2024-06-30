Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D279CC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 12:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNtGJ-0000Ls-Ke; Sun, 30 Jun 2024 08:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sNtGH-0000LN-W4; Sun, 30 Jun 2024 08:02:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sNtGG-00053n-9o; Sun, 30 Jun 2024 08:02:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UBv9Q9012010;
 Sun, 30 Jun 2024 12:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=ska4IztgQJK5p
 Xf4qaZ+wAkTN8VjzoERiXMS4oNbkXQ=; b=U/1PvIwC0GiPgywT8ZM614QUy9C3l
 zFVyhFYawQIRZ14TiZfaxlX0RgcueyObIWFFFLhSoQPN8I12ByEqZWGrD6tp6kLG
 CDcGblHPB6RBQvMafJdDnOj9MvHNegpeExtRX/DKaXQvUcFRdkqjJqQPIxvyE8PU
 wS5+x2hTvHFXXM6gl6ReosYrhdo+d/v7EOp5PAgTEdUiy4iyMwkndzY7lryQzV1h
 bz56Gyr5mlpzPT0AIbLU6QdL/UbIZxZTj7LiRkDOH0LrCzltJZveUtNIBgjiT9uQ
 MYuErqT4kc6aEsBybQk6DlOOdKFXN656hh9CvkFXoV6WwwTxXdOdmu5Kg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4030t80kbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:26 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UC2Px2021116;
 Sun, 30 Jun 2024 12:02:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4030t80kbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45UB3LEm029146; Sun, 30 Jun 2024 12:02:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3mhx1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45UC2LQY27787784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 12:02:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F07EA2004E;
 Sun, 30 Jun 2024 12:02:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4963B2004B;
 Sun, 30 Jun 2024 12:02:18 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.58.130])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Jun 2024 12:02:17 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 2/3] target/ppc: Update VMX storage access insns to use
 tcg_gen_qemu_ld/st_i128.
Date: Sun, 30 Jun 2024 17:31:56 +0530
Message-Id: <20240630120157.259233-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240630120157.259233-1-rathc@linux.ibm.com>
References: <20240630120157.259233-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R26DSODpX1sYS3cYKqUhPlZIKTNIvWqZ
X-Proofpoint-ORIG-GUID: QHj4g2a8Ic4YOJdU2oUrY9OrsPHbbSgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=719 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406300094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



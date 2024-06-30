Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC298C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 12:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNtHB-0000du-5P; Sun, 30 Jun 2024 08:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sNtGX-0000OZ-VG; Sun, 30 Jun 2024 08:02:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sNtGJ-00058Z-Ky; Sun, 30 Jun 2024 08:02:42 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UBvZAn011698;
 Sun, 30 Jun 2024 12:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=L2Ni7+s4AHsWc
 9XyWKiN5DFMYSLwN0/qpGzf42g/yc4=; b=H0TQi3hYGdhQtbGKMrb7CD8TOSnUf
 sU8MwaCC8kIbKA2fkLwWnMI03pruYhj6UYLKy0Pkqo/jFfx7oV/LadCpzfrYicWq
 1OGlQoCO5ClqO3+feE2qEnVUEpF1inPeXeWd8gu0MuyxhFrgbgR2eKWn7xeAchBU
 3VHBbiny8dSCwhkHWpD9yOT429sSB5OV+zNOf8EDzTo9otMEcq6ff8VZ+pDVdpCF
 6IDxHVXePiTZQi1fJji67Pba99EJ8FW8AvmPsbXNgBnyiKufo2GiS2cZlat09nCP
 g0er1UoWqK4DOejb8MhZZ5PKZjZFYVieuvWjNmf8RgSpSYTGYiqoU9yYg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4035mx04f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:28 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UC2S6u020105;
 Sun, 30 Jun 2024 12:02:28 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4035mx04ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45U7sfOT024077; Sun, 30 Jun 2024 12:02:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya31nxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45UC2NR942598906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 12:02:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2C012004E;
 Sun, 30 Jun 2024 12:02:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 833832005A;
 Sun, 30 Jun 2024 12:02:21 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.58.130])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Jun 2024 12:02:21 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 3/3] target/ppc : Update VSX storage access insns to use
 tcg_gen_qemu _ld/st_i128.
Date: Sun, 30 Jun 2024 17:31:57 +0530
Message-Id: <20240630120157.259233-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240630120157.259233-1-rathc@linux.ibm.com>
References: <20240630120157.259233-1-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ii-rird4qtU4mh36x48o505YI-P3d-el
X-Proofpoint-GUID: 0MYvyk7GWAmvabRg5XOTKwRZut3g-9ll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 mlxlogscore=754 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300094
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

Updated many VSX instructions to use tcg_gen_qemu_ld/st_i128, instead of using
tcg_gen_qemu_ld/st_i64 consecutively.
Introduced functions {get,set}_vsr_full to facilitate the above & for future use.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 target/ppc/translate/vsx-impl.c.inc | 70 +++++++++++++----------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 26ebf3fedf..b622831a73 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -10,6 +10,16 @@ static inline void set_cpu_vsr(int n, TCGv_i64 src, bool high)
     tcg_gen_st_i64(src, tcg_env, vsr64_offset(n, high));
 }
 
+static inline void get_vsr_full(TCGv_i128 dst, int reg)
+{
+    tcg_gen_ld_i128(dst, tcg_env, vsr_full_offset(reg));
+}
+
+static inline void set_vsr_full(int reg, TCGv_i128 src)
+{
+    tcg_gen_st_i128(src, tcg_env, vsr_full_offset(reg));
+}
+
 static inline TCGv_ptr gen_vsr_ptr(int reg)
 {
     TCGv_ptr r = tcg_temp_new_ptr();
@@ -196,20 +206,17 @@ static bool trans_LXVH8X(DisasContext *ctx, arg_LXVH8X *a)
 static bool trans_LXVB16X(DisasContext *ctx, arg_LXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xth, xtl;
+    TCGv_i128 data;
 
     REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    xth = tcg_temp_new_i64();
-    xtl = tcg_temp_new_i64();
+    data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
-    tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEUQ);
-    tcg_gen_addi_tl(EA, EA, 8);
-    tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEUQ);
-    set_cpu_vsr(a->rt, xth, true);
-    set_cpu_vsr(a->rt, xtl, false);
+    tcg_gen_qemu_ld_i128(data, EA, ctx->mem_idx,
+                         MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR);
+    set_vsr_full(a->rt, data);
     return true;
 }
 
@@ -385,20 +392,17 @@ static bool trans_STXVH8X(DisasContext *ctx, arg_STXVH8X *a)
 static bool trans_STXVB16X(DisasContext *ctx, arg_STXVB16X *a)
 {
     TCGv EA;
-    TCGv_i64 xsh, xsl;
+    TCGv_i128 data;
 
     REQUIRE_VSX(ctx);
     REQUIRE_INSNS_FLAGS2(ctx, ISA300);
 
-    xsh = tcg_temp_new_i64();
-    xsl = tcg_temp_new_i64();
-    get_cpu_vsr(xsh, a->rt, true);
-    get_cpu_vsr(xsl, a->rt, false);
+    data = tcg_temp_new_i128();
     gen_set_access_type(ctx, ACCESS_INT);
     EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
-    tcg_gen_qemu_st_i64(xsh, EA, ctx->mem_idx, MO_BEUQ);
-    tcg_gen_addi_tl(EA, EA, 8);
-    tcg_gen_qemu_st_i64(xsl, EA, ctx->mem_idx, MO_BEUQ);
+    get_vsr_full(data, a->rt);
+    tcg_gen_qemu_st_i128(data, EA, ctx->mem_idx,
+                         MO_BE | MO_128 | MO_ATOM_IFALIGN_PAIR);
     return true;
 }
 
@@ -2175,13 +2179,13 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
                      int rt, bool store, bool paired)
 {
     TCGv ea;
-    TCGv_i64 xt;
+    TCGv_i128 data;
     MemOp mop;
     int rt1, rt2;
 
-    xt = tcg_temp_new_i64();
+    data = tcg_temp_new_i128();
 
-    mop = DEF_MEMOP(MO_UQ);
+    mop = DEF_MEMOP(MO_128 | MO_ATOM_IFALIGN_PAIR);
 
     gen_set_access_type(ctx, ACCESS_INT);
     ea = do_ea_calc(ctx, ra, displ);
@@ -2195,32 +2199,20 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
     }
 
     if (store) {
-        get_cpu_vsr(xt, rt1, !ctx->le_mode);
-        tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
-        gen_addr_add(ctx, ea, ea, 8);
-        get_cpu_vsr(xt, rt1, ctx->le_mode);
-        tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
+        get_vsr_full(data, rt1);
+        tcg_gen_qemu_st_i128(data, ea, ctx->mem_idx, mop);
         if (paired) {
             gen_addr_add(ctx, ea, ea, 8);
-            get_cpu_vsr(xt, rt2, !ctx->le_mode);
-            tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
-            gen_addr_add(ctx, ea, ea, 8);
-            get_cpu_vsr(xt, rt2, ctx->le_mode);
-            tcg_gen_qemu_st_i64(xt, ea, ctx->mem_idx, mop);
+            get_vsr_full(data, rt2);
+            tcg_gen_qemu_st_i128(data, ea, ctx->mem_idx, mop);
         }
     } else {
-        tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-        set_cpu_vsr(rt1, xt, !ctx->le_mode);
-        gen_addr_add(ctx, ea, ea, 8);
-        tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-        set_cpu_vsr(rt1, xt, ctx->le_mode);
+        tcg_gen_qemu_ld_i128(data, ea, ctx->mem_idx, mop);
+        set_vsr_full(rt1, data);
         if (paired) {
             gen_addr_add(ctx, ea, ea, 8);
-            tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-            set_cpu_vsr(rt2, xt, !ctx->le_mode);
-            gen_addr_add(ctx, ea, ea, 8);
-            tcg_gen_qemu_ld_i64(xt, ea, ctx->mem_idx, mop);
-            set_cpu_vsr(rt2, xt, ctx->le_mode);
+            tcg_gen_qemu_ld_i128(data, ea, ctx->mem_idx, mop);
+            set_vsr_full(rt2, data);
         }
     }
     return true;
-- 
2.39.3



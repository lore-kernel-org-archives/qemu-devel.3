Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A379FC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDO1-0007HI-JE; Fri, 12 Apr 2024 05:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDNz-0007GX-AC; Fri, 12 Apr 2024 05:39:55 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDNw-0005Wb-6E; Fri, 12 Apr 2024 05:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712914783; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=JwaMqiHOkzXwc6HLXGIISXAQVZZqsuqU7z1zj4QhC1U=;
 b=HyYQ4XQKpdmB3lAbgAGZxmfswsraichiQ5UH6SAbD0/ffoVHilzoWwpodN8h4XLDio94AgRgz88O4b6XAmQu0suJPW2xvia3c//d8CyrtHze3TqSk1xVG2nLqMLK4WrYl5eZ26lq2j3eNd1l27JZSyHLTrxumfWzDx8+yBjiU8E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NtKZ-_1712914781; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NtKZ-_1712914781) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:39:42 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 52/65] target/riscv: Add single-width floating-point reduction
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:22 +0800
Message-ID: <20240412073735.76413-53-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

The instructions have the same function as RVV1.0. Overall there are only
general differences between XTheadVector and RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/helper.h                         | 10 ++++
 .../riscv/insn_trans/trans_xtheadvector.c.inc |  8 +--
 target/riscv/xtheadvector_helper.c            | 49 +++++++++++++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 2cd4a7401f..24bb8479a4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -2276,3 +2276,13 @@ DEF_HELPER_6(th_vwredsumu_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vwredsum_vs_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vwredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(th_vwredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(th_vfredsum_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredsum_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredsum_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredmax_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredmax_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredmax_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredmin_vs_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredmin_vs_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(th_vfredmin_vs_d, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 8a1f0e1e74..f77d76dc5e 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2397,15 +2397,17 @@ GEN_OPIVV_TRANS_TH(th_vredxor_vs, reduction_check_th)
 GEN_OPIVV_WIDEN_TRANS_TH(th_vwredsum_vs, reduction_check_th)
 GEN_OPIVV_WIDEN_TRANS_TH(th_vwredsumu_vs, reduction_check_th)
 
+/* Vector Single-Width Floating-Point Reduction Instructions */
+GEN_OPFVV_TRANS_TH(th_vfredsum_vs, reduction_check_th)
+GEN_OPFVV_TRANS_TH(th_vfredmax_vs, reduction_check_th)
+GEN_OPFVV_TRANS_TH(th_vfredmin_vs, reduction_check_th)
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfredsum_vs)
-TH_TRANS_STUB(th_vfredmin_vs)
-TH_TRANS_STUB(th_vfredmax_vs)
 TH_TRANS_STUB(th_vfwredsum_vs)
 TH_TRANS_STUB(th_vmand_mm)
 TH_TRANS_STUB(th_vmnand_mm)
diff --git a/target/riscv/xtheadvector_helper.c b/target/riscv/xtheadvector_helper.c
index f802b2c5ac..2a241aed65 100644
--- a/target/riscv/xtheadvector_helper.c
+++ b/target/riscv/xtheadvector_helper.c
@@ -3410,3 +3410,52 @@ GEN_TH_RED(th_vwredsum_vs_w, int64_t, int32_t, H8, H4, TH_ADD, clearq_th)
 GEN_TH_RED(th_vwredsumu_vs_b, uint16_t, uint8_t, H2, H1, TH_ADD, clearh_th)
 GEN_TH_RED(th_vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, TH_ADD, clearl_th)
 GEN_TH_RED(th_vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, TH_ADD, clearq_th)
+
+/* Vector Single-Width Floating-Point Reduction Instructions */
+#define GEN_TH_FRED(NAME, TD, TS2, HD, HS2, OP, CLEAR_FN)  \
+void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
+                  void *vs2, CPURISCVState *env,           \
+                  uint32_t desc)                           \
+{                                                          \
+    uint32_t mlen = th_mlen(desc);                         \
+    uint32_t vm = th_vm(desc);                             \
+    uint32_t vl = env->vl;                                 \
+    uint32_t i;                                            \
+    uint32_t tot = env_archcpu(env)->cfg.vlenb;            \
+    TD s1 =  *((TD *)vs1 + HD(0));                         \
+                                                           \
+    for (i = env->vstart; i < vl; i++) {                   \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
+        if (!vm && !th_elem_mask(v0, mlen, i)) {           \
+            continue;                                      \
+        }                                                  \
+        s1 = OP(s1, (TD)s2, &env->fp_status);              \
+    }                                                      \
+    *((TD *)vd + HD(0)) = s1;                              \
+    env->vstart = 0;                                       \
+    CLEAR_FN(vd, 1, sizeof(TD), tot);                      \
+}
+
+/* Unordered sum */
+GEN_TH_FRED(th_vfredsum_vs_h, uint16_t, uint16_t, H2, H2,
+            float16_add, clearh_th)
+GEN_TH_FRED(th_vfredsum_vs_w, uint32_t, uint32_t, H4, H4,
+            float32_add, clearl_th)
+GEN_TH_FRED(th_vfredsum_vs_d, uint64_t, uint64_t, H8, H8,
+            float64_add, clearq_th)
+
+/* Maximum value */
+GEN_TH_FRED(th_vfredmax_vs_h, uint16_t, uint16_t, H2, H2,
+            float16_maxnum, clearh_th)
+GEN_TH_FRED(th_vfredmax_vs_w, uint32_t, uint32_t, H4, H4,
+            float32_maxnum, clearl_th)
+GEN_TH_FRED(th_vfredmax_vs_d, uint64_t, uint64_t, H8, H8,
+            float64_maxnum, clearq_th)
+
+/* Minimum value */
+GEN_TH_FRED(th_vfredmin_vs_h, uint16_t, uint16_t, H2, H2,
+            float16_minnum, clearh_th)
+GEN_TH_FRED(th_vfredmin_vs_w, uint32_t, uint32_t, H4, H4,
+            float32_minnum, clearl_th)
+GEN_TH_FRED(th_vfredmin_vs_d, uint64_t, uint64_t, H8, H8,
+            float64_minnum, clearq_th)
-- 
2.44.0



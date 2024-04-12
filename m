Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B595C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDfe-0000Wx-61; Fri, 12 Apr 2024 05:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDfd-0000Wa-1Y; Fri, 12 Apr 2024 05:58:09 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvDfa-0000Y5-1p; Fri, 12 Apr 2024 05:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712915876; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=1DFEJpDLU3j4QtHeAqrFTUn3BuZZzQrxuet5/p11QiA=;
 b=xCvrunsBzI3xYTaky0AdiKEgzT4a5nstcsqPzGhPOW/V9bjAWIATtJxuxEzUFT64Z1oE7tE0hJApmw+DlN9DZODnbXE3gehflie9Ha023M49nyX53rzd9Zhoh2ww8/BwP9tFCJCyyzqVLt5CBiIew8TjCvlmoZKn33761uNt54M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4NtPyw_1712915874; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4NtPyw_1712915874) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 17:57:55 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 61/65] target/riscv: Add floating-point scalar move
 instructions for XTheadVector
Date: Fri, 12 Apr 2024 15:37:31 +0800
Message-ID: <20240412073735.76413-62-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
References: <20240412073735.76413-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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

XTheadVector floating-point scalar move instructions diff from RVV1.0 in
the following points:
1. When src width < dst width, RVV1.0 checks whether the input value is a
   valid NaN-boxed value, in which case the least-significant dst-width bits
   are used, else the canonical NaN value is used. XTheadVector always use the
   least-significant bits.
2. different tail elements process policy.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 59 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index a8a1ec7b3f..54ccd933c0 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -2740,14 +2740,69 @@ static bool trans_th_vmv_s_x(DisasContext *s, arg_th_vmv_s_x *a)
     return false;
 }
 
+/* Floating-Point Scalar Move Instructions */
+static bool trans_th_vfmv_f_s(DisasContext *s, arg_th_vfmv_f_s *a)
+{
+    if (require_xtheadvector(s) &&
+        !s->vill && has_ext(s, RVF) &&
+        (s->mstatus_fs != 0) &&
+        (s->sew != 0)) {
+        unsigned int len = 8 << s->sew;
+
+        th_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
+        if (len < 64) {
+            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                            MAKE_64BIT_MASK(len, 64 - len));
+        }
+
+        mark_fs_dirty(s);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
+/* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
+static bool trans_th_vfmv_s_f(DisasContext *s, arg_th_vfmv_s_f *a)
+{
+    if (require_xtheadvector(s) &&
+        !s->vill && has_ext(s, RVF) &&
+        (s->sew != 0)) {
+        TCGv_i64 t1;
+        /* The instructions ignore LMUL and vector register group. */
+        uint32_t vlmax = s->cfg_ptr->vlenb;
+
+        /* if vl == 0, skip vector register write back */
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
+
+        /* zeroed all elements */
+        tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
+
+        /* NaN-box f[rs1] as necessary for SEW */
+        t1 = tcg_temp_new_i64();
+        if (s->sew == MO_64 && !has_ext(s, RVD)) {
+            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
+        } else {
+            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+        }
+        th_element_storei(s, a->rd, 0, t1);
+
+        gen_set_label(over);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+        return true;
+    }
+    return false;
+}
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vfmv_f_s)
-TH_TRANS_STUB(th_vfmv_s_f)
 TH_TRANS_STUB(th_vslideup_vx)
 TH_TRANS_STUB(th_vslideup_vi)
 TH_TRANS_STUB(th_vslide1up_vx)
-- 
2.44.0



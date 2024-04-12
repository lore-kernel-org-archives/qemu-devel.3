Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2237C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBiP-0005wj-Hw; Fri, 12 Apr 2024 03:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBiN-0005wU-72; Fri, 12 Apr 2024 03:52:51 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rvBiK-0002Hv-Vv; Fri, 12 Apr 2024 03:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712908363; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=5tfc8PGqT+1VwghlIxyvrrL4zcInwz7NCC0F/LFhNH0=;
 b=Clj2m8f83bpjeP/zBjk36RWQ6sAtzVhrJXCQh8+Ajs3tCI8lrVW33XqQN57C+CdB6j8ep2OVJf74KYoNuSDJNIIQJtNwtJfegxXc82NEvoMkzZKSjOG9qm+1aFA/wY2b/yqXHdbWhAoFN+4G4sFtGGGelZbAdAL93s5EUeG9xik=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W4Nacq2_1712908361; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W4Nacq2_1712908361) by smtp.aliyun-inc.com;
 Fri, 12 Apr 2024 15:52:42 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 07/65] target/riscv: implement th.vsetvl{i} for XTheadVector
Date: Fri, 12 Apr 2024 15:36:37 +0800
Message-ID: <20240412073735.76413-8-eric.huang@linux.alibaba.com>
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

In this patch, we implement the th.vetvl{i} instructions. In the th_vsetvl
function, some work has been done according to the difference between RVV1.0
and XTheadVector.

th.vsetvl{i} differs from vsetvl{i} in the following points:
1. th.vsetvl{i} does not have the option to maintain the existing vl.
2. XTheadVector has different vtype encoding from RVV1.0.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 .../riscv/insn_trans/trans_xtheadvector.c.inc | 93 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xtheadvector.c.inc b/target/riscv/insn_trans/trans_xtheadvector.c.inc
index 2dd77d74ab..0461b53893 100644
--- a/target/riscv/insn_trans/trans_xtheadvector.c.inc
+++ b/target/riscv/insn_trans/trans_xtheadvector.c.inc
@@ -25,14 +25,103 @@ static bool require_xtheadvector(DisasContext *s)
            s->mstatus_vs != EXT_STATUS_DISABLED;
 }
 
+/*
+ * XTheadVector has different vtype encoding from RVV1.0.
+ * We recode the value in RVV1.0 vtype format to reuse the RVV1.0 functions.
+ * In RVV1.0:
+ *   vtype[7] -> vma
+ *   vtype[6] -> vta
+ *   vtype[5:3] -> vsew
+ *   vtype[2:0] -> vlmul
+ * In XTheadVector:
+ *   vtype[6:5] -> vediv (reserved)
+ *   vtype[4:2] -> vsew
+ *   vtype[1:0] -> vlmul
+ *
+ * Also th_vsetvl does not have feature of keeping existing vl when
+ * (rd == 0 && rs1 == 0)
+ */
+static bool th_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
+{
+    TCGv temp = tcg_temp_new();
+    TCGv dst_s2 = tcg_temp_new();
+    /* illegal value check*/
+    TCGLabel *legal = gen_new_label();
+    tcg_gen_shri_tl(temp, s2, 5);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, temp, 0, legal);
+    /*
+     * if illegal, set unsupported value
+     * s2[8:5] == 0b111, which is reserved field in XTheadVector
+     */
+    tcg_gen_movi_tl(s2, 0xff);
+    gen_set_label(legal);
+    /* get vlmul, s2[1:0] -> dst_s2[2:0] */
+    tcg_gen_andi_tl(dst_s2, s2, 0x3);
+    /* get vsew, s2[4:2] -> dst_s2[5:3] */
+    tcg_gen_andi_tl(temp, s2, 0x1c);
+    tcg_gen_shli_tl(temp, temp, 1);
+    tcg_gen_or_tl(dst_s2, dst_s2, temp);
+    /*
+     * get reserved field when illegal, s2[7:5] -> dst_s2[10:8]
+     * avoid dst_s2[7:6], because dst_s2[7:6] are vma and vta.
+     *
+     * Make the dst_s2 an illegal value for RVV1.0, leads to the illegal
+     * operation processing flow.
+     */
+    tcg_gen_andi_tl(temp, s2, 0xe0);
+    tcg_gen_shli_tl(temp, temp, 3);
+    tcg_gen_or_tl(dst_s2, dst_s2, temp);
+
+    /*
+     * We can't reuse do_vsetvl for we don't have ext_zve32f
+     * The code below is almost copied from rvv do_vsetvl
+     * delete zve32f check and the situation when rd = rs1 = 0
+     */
+    TCGv s1, dst;
+    dst = dest_gpr(s, rd);
+    if (rs1 == 0) {
+        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
+        s1 = tcg_constant_tl(RV_VLEN_MAX);
+    } else {
+        s1 = get_gpr(s, rs1, EXT_ZERO);
+    }
+
+    gen_helper_vsetvl(dst, tcg_env, s1, dst_s2);
+    gen_set_gpr(s, rd, dst);
+    mark_vs_dirty(s);
+
+    gen_update_pc(s, s->cur_insn_len);
+    lookup_and_goto_ptr(s);
+    s->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+static bool trans_th_vsetvl(DisasContext *s, arg_th_vsetvl *a)
+{
+    if (!require_xtheadvector(s)) {
+        return false;
+    }
+
+    TCGv s2 = get_gpr(s, a->rs2, EXT_ZERO);
+    return th_vsetvl(s, a->rd, a->rs1, s2);
+}
+
+static bool trans_th_vsetvli(DisasContext *s, arg_th_vsetvli *a)
+{
+    if (!require_xtheadvector(s)) {
+        return false;
+    }
+
+    TCGv s2 = tcg_constant_tl(a->zimm);
+    return th_vsetvl(s, a->rd, a->rs1, s2);
+}
+
 #define TH_TRANS_STUB(NAME)                                \
 static bool trans_##NAME(DisasContext *s, arg_##NAME *a)   \
 {                                                          \
     return require_xtheadvector(s);                        \
 }
 
-TH_TRANS_STUB(th_vsetvli)
-TH_TRANS_STUB(th_vsetvl)
 TH_TRANS_STUB(th_vlb_v)
 TH_TRANS_STUB(th_vlh_v)
 TH_TRANS_STUB(th_vlw_v)
-- 
2.44.0



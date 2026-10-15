Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5486CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLm2-0000WT-0l; Thu, 15 Oct 2026 09:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1xHLm0-0000Uy-9W
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:45:32 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1xHLly-0000Dh-MY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792071924; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kbrQdrcFPuAUrpmZUMzDzFIwQ6myE/Xzj6l/GF1hrR8=;
 b=pqqmTUA4tgc12YdNLs0Wl6SftKBIMPJTadUlcntMN3Kj2AiZe8a+6dFg8ckYcyQQy4iu88
 XK1R23ORE+xej8XVrLHVMCfVBALbrWfmiDYQ5FSZ7fzpq/XQxbm9jQ+/+P01mzz7F7Rs6B
 HDWQ8oYjRgBCA5VhnilI94Hc5O8gsJYw82FsMp0VRnOPtuyJmyEGvtkzwcmFgIGu5gYS0n
 ZT2+CPj2LCgX5CoGSpCYz4akEJ15XIZrAvpsolkswUUasf31Q4fqiFDBkiuab7NT/PU7Uj
 UJI0GMl0G64pVaPuyZevRv0nU2j7liAfZT5yC7LCNk6M5e3PAyWAL0q00GwcPg==
From: "Mingliang Liu" <liumingliang.dev@bytedance.com>
In-Reply-To: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
X-Lms-Return-Path: <lba+26ad0d8f2+1b0860+nongnu.org+liumingliang.dev@bytedance.com>
References: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, 
 <Alistair.Francis@wdc.com>, <zhiwei_liu@linux.alibaba.com>, 
 <liwei1518@gmail.com>, <daniel.barboza@oss.qualcomm.com>, 
 <chao.liu@processmission.com>, <richard.henderson@linaro.org>, 
 "Mingliang Liu" <liumingliang.dev@bytedance.com>
Message-Id: <20261015134337.3354723-3-liumingliang.dev@bytedance.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5
Subject: [PATCH v4 2/3] disas/riscv: Support vabs.v pseudo-instruction
Date: Thu, 15 Oct 2026 21:43:36 +0800
Content-Transfer-Encoding: 7bit
X-Original-From: Mingliang Liu <liumingliang.dev@bytedance.com>
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=liumingliang.dev@bytedance.com; helo=va-1-112.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
---
 disas/riscv-op.c.inc | 3 ++-
 disas/riscv.c        | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 07b56f5d52..425473ee61 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -491,9 +491,10 @@ OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
-OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, rvcp_vabd_vx)
 OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vabs_v, "vabs.v", rv_codec_illegal, rv_fmt_vd_vs2_vm)
 OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
 OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
 OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
diff --git a/disas/riscv.c b/disas/riscv.c
index b0102e47bc..e349f521e8 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -103,6 +103,7 @@ static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
 static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
+static const rvc_constraint rvcc_vabs_v[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_true[] = { rvc_end };
 
 /* pseudo-instruction metadata */
@@ -242,6 +243,11 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
     { },
 };
 
+static const rv_comp_data rvcp_vabd_vx[] = {
+    { &op_vabs_v, rvcc_vabs_v },
+    { },
+};
+
 /* Convert compressed insns into normal insns via pseudo expansion. */
 #define DECOMP(X)  &(const rv_comp_data){ &X, rvcc_true }
 
-- 
2.39.5


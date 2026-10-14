Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCC9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqd-0005LF-Tw; Tue, 13 Oct 2026 23:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqW-0005D4-7h
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:06 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqU-0001PL-Fd
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:03 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so521972a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949201; x=1792554001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvphkF4ny4hilMG0LXNrctB7EvQsbDQqRw3lmDJLYb0=;
 b=V6Hqh9jgJgKhAEhas+ZaqiUY2hVQtH8atW+CutuRDhC3wOax0U8jbHOQZsTxXr09yg
 zMziLzFaZoJj/Dliuh0Mn9CcVy7QxfPkCTDayjqaN9+K9zQhuFiE0XoeIbxRvPJtAWgJ
 8hF0Fn3wWy92gngcH+aHDmfRGRDjsJw+5D+9yTflcRBzx71BafqAdJ7aC5MmWH634Apt
 10vzTTepUYFxrsX4d90zuLzghBPDsYp895nJ1LlxHw5QuybklsovxjNbqm8TwnPci/Vx
 KJHQbs0lCR+jE/pkXS+4RXwrGlF875nOw5Ie0zE3V+0mfpzOFGiEyUqsFKw+NZGtL6aX
 VKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949201; x=1792554001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bvphkF4ny4hilMG0LXNrctB7EvQsbDQqRw3lmDJLYb0=;
 b=sDnTKTiO75X1LNgqlQnTrmJShteDd7zsvQUEkIQuHKZ0dhyw0LYn70SVeu0yT72eTX
 L1HHTkocfJJlls7udwaxi+JzL7oMCj/GqA4M67DH9lB7N+AnbZkGRq0V053t6tFaeK7+
 ltSeOHQVbOoev1iM9JS8CsbZzkK8yxqDPgm+T5mB79bMrz4haOneqoZG6ua+O4tmd54k
 PV0Z0vHkZ7uPTQjQu3/A8ewUQ8QBsxZi/sGxnC2zTvV/n+KmilqkOyTTMMKNmjr+ruR6
 UyyYau05lY96HYCSBA6bTmedwgbN5qUu7l4rc1iVByUoyXZEPR8ivDJZANWrqnchi5Z/
 umOQ==
X-Gm-Message-State: AFq9FYJ/qM5F32AYnzrBJOGVNVt4Z7UgYw9t9pK8mX7tHhCM0YkP8esy
 yn1LugQfrxH+RfgeMqlOktUA7KztqN7zkucuZ+sN4B2YobPZg6ZKAowyBw0Cdg==
X-Gm-Gg: AYBFou3mHeaRFXFSVsQU4f5hJWdQJbbXN58KAEZXaZeEBtKcUWLgaEqkkTn9gwYr2R2
 NT6cGdBb2JBl6aXtRJ9Pag7wVwgc34BX7fFCs3nj9VafkujStNZgLfFLRK3TSZ8/p13SLugwPTR
 NT1IOIH1/VSNkGINlDKDcJoX75pd7GvvHlk1uscOmUV9l7RSqbpuvUgacGa4lSkBBmxWdgeiT2J
 sg9zBg7WkQrk40iJN4+QxjGQTUiaotwTzmDhAd96iVesZBd9mXqgtNv0P9eOWU3bdZAgr22ZnvZ
 Rov4Np3Coj2T7v/QbUFuIchVjOHrW96+Sqwt1PQ4exmE6XrlSrDLCL0VbMmX7owrAPeb1fuUeel
 f3U1le5HlL4cRR0tyAv1GS0jffNtuOzekYgfmo0Jec90fbTBWqSuyfZ1jt62u24+j9l2SJDMx1j
 P4OkjKO+3IW03EUR9gL+37oRGlVUpvupu4PhgJ0BTyP+tjJ9bWs4vDQn/JfuoXow4TCe90BPcfb
 Tn+78VFsx3pUQoB
X-Received: by 2002:a17:90b:4c4f:b0:3ab:27eb:338e with SMTP id
 98e67ed59e1d1-3ab3ac54a33mr11531985a91.52.1791949201033; 
 Tue, 13 Oct 2026 20:40:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Mingliang Liu <liumingliang.dev@bytedance.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/52] disas/riscv: Support vabs.v pseudo-instruction
Date: Wed, 14 Oct 2026 13:38:27 +1000
Message-ID: <20261014033907.3332383-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mingliang Liu <liumingliang.dev@bytedance.com>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Message-ID: <20260907152301.1701394-3-liumingliang.dev@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c        | 6 ++++++
 disas/riscv-op.c.inc | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 43d5a5255e..9645e19232 100644
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
-- 
2.55.0



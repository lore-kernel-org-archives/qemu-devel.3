Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9496DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtmD-0007lA-Q6; Wed, 19 Aug 2026 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm5-0007Zb-RZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:06 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm4-0004TI-6a
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:05 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1504415a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197743; x=1787802543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v1HHSGb013dDgNPZxkNVb6ZLlCJeWWRoZwdE2wte10s=;
 b=OdaH7noCcHyFaGp1i0FyyAkvaRrMx8+ChhAnDDbI1lH56EYmRm6nb96CglvdChnkws
 yllpRiPV4uiCIhM8iBhgusBmOAXed9dTBDk5WwAtr7r9mI2Odqvl8crhyZ2JJ1eD8OWC
 kG0oWyEvzFak2oMJvAeNpXZt3dAM3/CGrolWPZ7RQWJl7C71pmnO6Y1xPr68Ht6ty9jf
 f+hR5EnAu2J6mnzA+xYV70nb2s7Zh/W/t8GM7BQ0ZRz1xKKOcrD07CxxOsMBg9gDmofo
 GPbT1M7SPCpqtuRkcfnjG/mdnFyZXBZLQfe2H5a8EuDEETQBNkcbaptxMJW5M6XRyukT
 TadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197743; x=1787802543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v1HHSGb013dDgNPZxkNVb6ZLlCJeWWRoZwdE2wte10s=;
 b=X1bTAQCxGdQ1Mb0OJtYpbYmiKh7XHeNCnm0qYEKc26BiK4Lcy11DZFMB2MZI2IUet7
 LSIPZtHj0gFJJO7/6mhtxlyDsPRMYkgcSAllYbrx+dWQ+fu1uWMgalweLXS4Q4NtZ7sq
 FrmjOteptaofaIspLASthZXniTmAyvL/mYM+lHUhFFYC3fSpIKhwiRwEtcldDyY/qEGO
 a7nl+swcL8LZB41MIaUgj3kBsS5joMtqFDc4nlTxjGVxYXD2bhxW4XlSobD5gZa5LKUO
 xYa+knOgLbQ7MhBk7rNW+ZJgTJtiC3nKPbtaH7m3YCD8elAeX7VQB03T8WO5C+rLI8H8
 XZ4A==
X-Gm-Message-State: AFuF++n6m5drFtGmXOSAOXFks7yizSqRqucPL5+waoDmEHxv339quDnI
 A7tWtTbYu48VBiO8zGq0gDbvohu3Co3Z3oRMD9dlDB8jzQBKnOmnTy+u1X9TYA==
X-Gm-Gg: AR+sD10pMEqEy9Jayf18/FT2lxZBLWpInK2xP+cNS9wdKE1/xqQtgiPTfwfDQG4+s+H
 nnf31288yoKeFekVJKQtJM73WEneq/572cbfdFvLy8/CbXnJ6b18R/Y6StzuzVX68pz3Wqm1Y2a
 Aliyh4iUUpx+vHTNiU/yIe8LjzvRxa9QJUmv2UrWRKaEgmpR6uzuJydH/ein3GGmxMoksbS3dtP
 cCE5Ei5yattmDCM2AIzfyb00aewBMRxuO/Pu66iRqT23EMyFFgVqwzvItPEiSFTPyf4ms+hir+q
 bARPKXYAFQZ/59x2WMvIb5HRyt/K3k3PYkQodXd9ggzkUjm6NEEbivAnI3g4BFl1g+4cg98tFCT
 iqBgrFNftEVLZKaVZ7upLkFC9yR/7ZgvYNOJiIpfTcNejlZffiLbPgdVWdR6EP3tmCQ9fPApJ71
 XPMKkWCBPyA49hTAP2qZMoLvh5v7hQvFrotsYY0OLbf/WKE4gSUx6hDUmnSrxCL0KR1yW6rC7gu
 N1wJA==
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-39580a4d031mr18112202a91.3.1787197742705; 
 Wed, 19 Aug 2026 20:49:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:49:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 90/93] target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
Date: Thu, 20 Aug 2026 13:44:27 +1000
Message-ID: <20260820034430.1186695-91-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

Zfinx explicitly excludes the FMV transfer instructions, but
trans_fmv_x_w/trans_fmv_w_x used REQUIRE_ZFINX_OR_F so a Zfinx-only
CPU accepted them.  Require RVF instead so the transfers trap with
an illegal instruction when only Zfinx is present.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4108
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <36c7cfebd27b4b6e8bcdd00e09e9dda0@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvf.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
index 481f7282da..636dec1664 100644
--- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
@@ -434,7 +434,8 @@ static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a)
 {
     /* NOTE: This was FMV.X.S in an earlier version of the ISA spec! */
     REQUIRE_FPU;
-    REQUIRE_ZFINX_OR_F(ctx);
+    /* Zfinx explicitly excludes the FMV transfer instructions. */
+    REQUIRE_EXT(ctx, RVF);
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
@@ -537,7 +538,8 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 {
     /* NOTE: This was FMV.S.X in an earlier version of the ISA spec! */
     REQUIRE_FPU;
-    REQUIRE_ZFINX_OR_F(ctx);
+    /* Zfinx explicitly excludes the FMV transfer instructions. */
+    REQUIRE_EXT(ctx, RVF);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv src = get_gpr(ctx, a->rs1, EXT_ZERO);
-- 
2.54.0



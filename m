Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A25C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 07:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbwyY-0005Do-I1; Sun, 26 Jan 2025 02:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyO-00057R-EQ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:25 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1tbwyL-0004M7-Lp
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 02:22:24 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5fa2685c5c0so1541114eaf.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 23:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1737876140; x=1738480940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz1MxGS/m+B7rusrD5nYn9e+LaPbU4UbVw6Vgl0czKA=;
 b=XbX9BElYP2N5hVEwYD4Ev7bPGgR7GhQbzDpwXQeKptAkup4wzA0wENl+zIaP56Cuul
 k1dRpGx6d8SGkoLQltzdQLVx0YAUGeFzyi2DpScrHsvQRA7hczA0lx0YvMSDXA3vRcAV
 EYbp/rPKt5InS08sqNBnTHAENVnSgUtEFCR1pqd5e7+ZuKtJqXDaWKCEPT2PbgoPi0x8
 QA5F8F6v0VtJGizzyGSO0AwU5QDF0tf/ldmkKH9b5ahKuZv0EKdLrTLXCGDgFtr2h2fX
 Q3BhehfwAAIDjYfScMeeGVjw4oG22fAPyNzJ7HvkR7VeXJ6MguNySQ3Wys7uiRgrm3H7
 N7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737876140; x=1738480940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz1MxGS/m+B7rusrD5nYn9e+LaPbU4UbVw6Vgl0czKA=;
 b=OcgRNYs5T0y5gic+gOQYocKq0stSYmq76tU3LicZyeLnN5uE1L2jeaFsxvuJnrBLSn
 v3GlDh1lfJw4ARju7VICrtFxSvvm1xgn2MblbmTF2lQ6ry66ALFaX+kS5XRjGcNVi/oF
 gWMkuM4t8xUXP05keRbM6BQamqiw0/T8X4I+SlkdEOaGQDftQpIIs8OWL9T6IRwkjIzI
 Ab11XkWM/aQ56e3GpFMjs8CAbD/QEwspcPup6XXEGwv7qesm8eB8kr7x2U0rU91X5cE8
 JcwGYnSFvEoZpso9ux2mFuAHZpm0HUQoOzkZH9VHdnYgXNgibjzEhH9IMuGeU922v2Lg
 i0Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLJ2BfzTot8T1jI+X9lRH16GC/tB4sY3n5j9HvHSePC59Uu/L7pbUME6cPtEip1VRKDkxuYTSn7eAp@nongnu.org
X-Gm-Message-State: AOJu0YzGgdvu0kJV4PPHEr0ce1a5IcDKUd2JpofweHhXFJb/JitzbVtA
 ZLJeOgNbzhaIE6xDMB5tqB0mCEOOl10Xmp+AXlsKSViMWZKLCl92qZnu+BDIvd0=
X-Gm-Gg: ASbGncutoza69pupqvA9oMa8aInnVkdRJCIO10ZKlEvrDo3kkZChRDqgGuSz5HzCYGs
 fQU0HKXrlYqwlOmpmFtKjFHW0j9HXA1z8r/DD0WeKND7fCLDdi/2YEZzEXQJ74O0RMgyx/ZxRZa
 2V5A7fUp5SCjqv2jhfAD3H0pIUuZnDBYBMYodnNlvW8tGBIxPx1dKc9QXiDb/peBqlSWixrxkoJ
 te47uyhlALQi+oQt7dCp7an2EbcXZjEpqNqDcMwbQyTz7xH73X8Fk3M5MNT4PfiXczQk/aN9afo
 ZbFtxtm1V9r60qWxEWc2xPpnJMSHI6dfZHWWSzY=
X-Google-Smtp-Source: AGHT+IFW2fL7Au6aeZykeUHYJRJwUwLndMczM9WYpgKLQ444g/Qsy9LHosf9+ZLMCPLuGMOMu//Ilg==
X-Received: by 2002:a05:6871:10b:b0:29d:c832:7ef6 with SMTP id
 586e51a60fabf-2b1c0cddb72mr19774250fac.39.1737876140434; 
 Sat, 25 Jan 2025 23:22:20 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b28f1d887csm1814281fac.29.2025.01.25.23.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 23:22:20 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 12/12] target/riscv: handle overlap in widening instructions
 with overwrite
Date: Sun, 26 Jan 2025 07:20:56 +0000
Message-Id: <20250126072056.4004912-13-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126072056.4004912-1-antonb@tenstorrent.com>
References: <20250126072056.4004912-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=antonb@tenstorrent.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In these instructions vd is considered a source, so no overlap
is allowed between vd and vs1/vs2. See:

https://github.com/riscv/riscv-isa-manual/issues/1789

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 71 +++++++++++++++++++------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2741f8bd8e..715008db79 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1505,6 +1505,16 @@ static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
+/* OPIVV with overwrite and WIDEN */
+static bool opivv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul+1, 0), a->rs1, 1 << MAX(s->lmul, 0)) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul+1, 0), a->rs2, 1 << MAX(s->lmul, 0));
+}
+
 static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            gen_helper_gvec_4_ptr *fn,
                            bool (*checkfn)(DisasContext *, arg_rmrr *))
@@ -1552,6 +1562,15 @@ static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
+/* OPIVX with overwrite and WIDEN */
+static bool opivx_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul+1, 0), a->rs2, 1 << MAX(s->lmul, 0));
+}
+
 #define GEN_OPIVX_WIDEN_TRANS(NAME, CHECK) \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
 {                                                                         \
@@ -2023,13 +2042,13 @@ GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
 
 /* Vector Widening Integer Multiply-Add Instructions */
-GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_overwrite_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_overwrite_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_overwrite_widen_check)
 
 /* Vector Integer Merge and Move Instructions */
 static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
@@ -2370,6 +2389,18 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
+/* Vector Widening Floating-Point Add/Subtract Instructions with overwrite */
+static bool opfvv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul+1, 0), a->rs1, 1 << MAX(s->lmul, 0)) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul+1, 0), a->rs2, 1 << MAX(s->lmul, 0));
+}
+
 /* OPFVV with WIDEN */
 #define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
@@ -2409,6 +2440,16 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
+static bool opfvf_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           !is_overlapped(a->rd, 1 << MAX(s->lmul+1, 0), a->rs2, 1 << MAX(s->lmul, 0));
+}
+
 /* OPFVF with WIDEN */
 #define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
@@ -2533,14 +2574,14 @@ GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
 
 /* Vector Widening Floating-Point Fused Multiply-Add Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_overwrite_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.34.1



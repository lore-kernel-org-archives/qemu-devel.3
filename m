Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D2CCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoE-0006mQ-EX; Thu, 04 Jun 2026 19:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoD-0006kP-1D
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHo9-0007vL-Uf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso13168655ad.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616944; x=1781221744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjJQQllfaq+hXjgsv5QuP5O1r1aavIvt6gWsZvDwTv8=;
 b=ljTLWp4lk7m9Zmr55B9MekqUloKRPanBQuROrA+tVKBxuWBE8oVj6MH33i4skAo4ET
 e+VVQ4KU24doJEbZeIhYLXk+gF0an2HYnIwB85nynkQtjRLsOQ0NEQSwO66YH98RFhFY
 D7OMmfCN1bMschRSEsE/U6sSQgtilvGGFjrevezNqpd+VqtlCadoXsf4OUPFQqtLSP5k
 iLI0kv690QzKM/iEMWpYFvGJxmVq/qAkw+GOsBTS15TtjpjHVGhq2CuouweFPt9P3Ayy
 PBltw28yxjyM8dOrD9m13GHDX8meBvzfS7kuhsX5SQc2oOLjJVfUn5QEZShH7iBd13lc
 B3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616944; x=1781221744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CjJQQllfaq+hXjgsv5QuP5O1r1aavIvt6gWsZvDwTv8=;
 b=JnKE4/3vRTCwwCztKUeEPGZB33llLtiedJ8dt3YQese1IyOm5ugOAwxRo6vv8OFPZ1
 c7sxhdv1TFKzt2GTe8hNvR9S+HT74PYs6/x5iQj2qwGuyFQDcHLv2I6TBddpK7t0LmSE
 OPjMDcYrAnABLpqV3oHj61hXY0NtYfTbgiJ29digDhgfrp0RwmwZsfujl2nNW3Kd7Xr4
 aXMnv23HKLqyoded3IYp/JSUkml+n5NAtewVcGw6ZULl4kH1RSTPl87Y6iTWBp6v4r+Z
 Jl8i0gkRcSJkCehNKi2jlufkHCSFEgIGfpSWDp+IorDyXLOD/MaskdJHnvRMaoi5Bloo
 9OdQ==
X-Gm-Message-State: AOJu0YxVu6DImYkPn8NeNhvqkOtYLIk/f0VM9P6YPSp4B/z0MTvLlEiG
 gZgit3b7uD2noXFo+6/zVNGZk4LN2u7XuqPQDtvddBDQXnpn4KAnq1QkozUTH+/6lMA6OapSMqi
 yx8wD+R4=
X-Gm-Gg: Acq92OG5Snj3D2ShRf1kgMjIU7r1f0bj/x+8AB06io5mc17BeaR+QUYgaGfhGv1cUeO
 FtVYUq8HP0yDA8DB8qvbxherp1QcwSAkRE1eZBLRctm9Fv+6U1X5j/y59SUkeCcbljMJBfq7Lh0
 5VfymMPBOhKswjEyJSm9mBpQYLxMQaRX/EsLGwYvu8LK42eACHXGccVuk3HDbDc4ts+vYb9PW6U
 EZbgYKZYLVqYyNzrlAe4Xtf71r9jWWoIJa4Ko/MmHULj/gSY2axAWRmvVweG98Vb+fqOLSt5//R
 jvdM1e18fCdEHn5NL4vgV1JyKOMKzy8pFB3LZ/YSgahOCjsnCc92u8hr2mQDfxqCyEZ1om71eI7
 y6/9GU9s8ifB9Cb3CBorVBjnUiQZmycWfz8k/bY/BfsNLofz2fytSpupidBs/r2+MUegiSSTI9P
 R4sbtaB0eBkLmXO6EOIw4ygHmebqrQ+dmI/rgkIdg=
X-Received: by 2002:a17:902:e5d2:b0:2c0:cb90:1dfc with SMTP id
 d9443c01a7336-2c1e8219fccmr7361495ad.12.1780616944460; 
 Thu, 04 Jun 2026 16:49:04 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/25] target/arm: Implement SCVTF, UCVTF (predicated, zeroing)
Date: Thu,  4 Jun 2026 16:48:41 -0700
Message-ID: <20260604234852.573178-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      | 16 ++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9e0945252d..936396103f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4784,6 +4784,40 @@ TRANS_FEAT(UCVTF_sd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(UCVTF_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
+TRANS_FEAT(SCVTF_hh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_hh, a, 1, FPST_A64_F16)
+TRANS_FEAT(SCVTF_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_sh, a, 1, FPST_A64_F16)
+TRANS_FEAT(SCVTF_dh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_dh, a, 1, FPST_A64_F16)
+
+TRANS_FEAT(SCVTF_ss_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_ss, a, 1, FPST_A64)
+TRANS_FEAT(SCVTF_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_ds, a, 1, FPST_A64)
+
+TRANS_FEAT(SCVTF_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_sd, a, 1, FPST_A64)
+TRANS_FEAT(SCVTF_dd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_scvt_dd, a, 1, FPST_A64)
+
+TRANS_FEAT(UCVTF_hh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_hh, a, 1, FPST_A64_F16)
+TRANS_FEAT(UCVTF_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_sh, a, 1, FPST_A64_F16)
+TRANS_FEAT(UCVTF_dh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_dh, a, 1, FPST_A64_F16)
+
+TRANS_FEAT(UCVTF_ss_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_ss, a, 1, FPST_A64)
+TRANS_FEAT(UCVTF_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_ds, a, 1, FPST_A64)
+TRANS_FEAT(UCVTF_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_sd, a, 1, FPST_A64)
+
+TRANS_FEAT(UCVTF_dd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_ucvt_dd, a, 1, FPST_A64)
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c39d80360f..7460eee4a9 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1283,6 +1283,22 @@ UCVTF_sd_m      01100101 11 010 00 1 101 ... ..... .....        @rd_pg_rn_e0
 UCVTF_ds_m      01100101 11 010 10 1 101 ... ..... .....        @rd_pg_rn_e0
 UCVTF_dd_m      01100101 11 010 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
+SCVTF_hh_z      01100100 01 011 10 0 110 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sh_z      01100100 01 011 10 1 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ss_z      01100100 10 011 10 1 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_sd_z      01100100 11 011 10 0 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dh_z      01100100 01 011 10 1 110 ... ..... .....        @rd_pg_rn_e0
+SCVTF_ds_z      01100100 11 011 10 1 100 ... ..... .....        @rd_pg_rn_e0
+SCVTF_dd_z      01100100 11 011 10 1 110 ... ..... .....        @rd_pg_rn_e0
+
+UCVTF_hh_z      01100100 01 011 10 0 111 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sh_z      01100100 01 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ss_z      01100100 10 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_sd_z      01100100 11 011 10 0 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dh_z      01100100 01 011 10 1 111 ... ..... .....        @rd_pg_rn_e0
+UCVTF_ds_z      01100100 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
+UCVTF_dd_z      01100100 11 011 10 1 111 ... ..... .....        @rd_pg_rn_e0
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.43.0



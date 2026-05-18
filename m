Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C17CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSh-0003ke-Jl; Sun, 17 May 2026 21:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSP-0003XJ-OE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:52 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0007LM-4t
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:45 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-366375c4076so486724a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066460; x=1779671260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up3XaHUoLKweGGBxg03QbOBi0vMWSTfOKYRAQhB0+O4=;
 b=bZzo6zNfvK/bY6SPY9mfIm3Klv255QsxaxPzd2kdq9WdVGBWU4cnd4qHO2sFr6AREd
 N0wWbKfuQwmyzejpg7SDQBMFhoEzSptSrQhfZs5TfsrAEm1Yxp6/wHd4lrezijDqbf2U
 FnD2gxRN59U1mZ+carDTFhlFrCCiiXdtRzIzIcANmJ8FIB1bogKxnY2Hmc0kJM1yAl2C
 F5A94LG+ggVvBeGzMrcJfd2sXMD9kMISa/W+DbLMVpqMp1VbAnpvcA6DoWTn30Ey4wz0
 0+7Eg3RfSMZ367q7iOj1jxARE3AAxuwgwbh42gUwDMHTGQkd9nlEHb1O3rgkd7uR3gX9
 7x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066460; x=1779671260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=up3XaHUoLKweGGBxg03QbOBi0vMWSTfOKYRAQhB0+O4=;
 b=GKEduDq9wfLjPPNb9wzfY0cTM3bJtbSxAT1lIt5MXiDTBIQQ/XhEd64IIjFmtw9+Kk
 yWLTs9ar1JUb1RCP2Zj6l6MisWD8EiUxTXJQuH3AUUwV/rIQs8twYec6ornuAGjyLWO7
 kYEi+VwMsZb4lJXMoWiTt4/O7U3/0PQWw/Wo3NkDZ0sPCksV3eDpc3/2md9E01Uu2h9e
 F1ffShBOy3sSRF4hmd8Gx7cKHjsfImVUBBcNfF9Kho/ESaN+Ad/xLfa2mmljDSJ+H9BM
 2AizcG+FDsmf4uFuyiXRKlkI5qkrWWgIXFYtZ1KpCXzafoBTr9esLgS2o09K3HYenNNm
 dn6A==
X-Gm-Message-State: AOJu0YwNiZdprcfaNgeqkFghGIlxHca5aeFVIbuOGEShxRRabshBovmX
 c+/xiKQ2Jzqes2d5TwkSjuHjstpC0MWsvRsfZ8FHj2g7WPYIma8b0kcfyuE5lpq/z9RT3Ll7B+M
 TeXIY
X-Gm-Gg: Acq92OGPAhatoqw31a4xOva1g65MrbSa8q7ED94kPOR+LzsJcgIPBnpTqmzlJqsi0zL
 ic9nFu0PMFKFiJ8RAaTzhpwAcLuGJXGpJ7QFfzGOaiB7TW6dwwJGTYI4T114w9q6R8sWI2C3D5M
 cHHm4TTicjiCm9iJ2ec9AVnvKKh0N8bmWxNMuBOoxPxZWQJuRWqiodejeiTeQf2aTLhnn4qk5Ow
 0qFINjScbq/vgX+umljYEvzMQYwEVjTSCFDlQRCo+rIKg80pI9LqPIwruyJdj9zjmUYts1Pmhks
 OB1N5ufWarUkIIHslh3NVMr0eIoZ8d4kaFJXIeOtx+Bck1kVaNpAWWerBSSUb3zXIesTIY+VYMz
 xxMjps/7ZmhraTp7uKKucdgDN/0vIXA7hNyLIW/ey22FA7Wh8ceG8AduWvK5WA1P9hC/7PUQnmw
 Yh2vIS3H84pxyGelTyydDKDjWaLXVi
X-Received: by 2002:a17:90b:1c82:b0:35f:b7f5:9cd with SMTP id
 98e67ed59e1d1-36951c9fad8mr12330965a91.20.1779066459691; 
 Sun, 17 May 2026 18:07:39 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 6/9] target/mips: add Octeon VMULU instruction
Date: Sun, 17 May 2026 18:07:30 -0700
Message-ID: <20260518010733.502237-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Add translator support for the two-limb accumulator operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260514-mips-octeon-missing-insns-v2-v7-21-226686be4ce1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 35 ++++++++++++++++++++++++++++++
 target/mips/tcg/octeon.decode      |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4c286b34b5..3539955d90 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -241,3 +241,38 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
+
+static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
+{
+    TCGv_i64 x[3], y[3], z[3];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    z[0] = y[0] = tcg_temp_new_i64();
+    z[1] = y[1] = tcg_temp_new_i64();
+    z[2] = y[2] = tcg_temp_new_i64();
+    x[0] = tcg_temp_new_i64();
+    x[1] = tcg_temp_new_i64();
+    x[2] = zero;
+
+    /* Z = rs * (mpl1 : mpl0) + rt */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    tcg_gen_mulu2_i64(x[0], x[1], tmp, oct_mpl[0]);
+    tcg_gen_mulu2_i64(y[1], y[2], tmp, oct_mpl[1]);
+    tcg_gen_addN_i64(3, z, y, x);
+
+    /* X == (0 : p1 : p0) */
+    x[0] = oct_p[0];
+    x[1] = oct_p[1];
+
+    /* Y == (p1 : p0 : tmp) */
+    y[0] = tmp;
+    y[1] = oct_p[0];
+    y[2] = oct_p[1];
+
+    /* (p1 : p0 : rd) = Z + (0 : p1 : p0) */
+    tcg_gen_addN_i64(3, y, z, x);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index eeed736c15..600e540539 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -52,6 +52,8 @@ MTP0         011100 ..... ..... 00000 00000 001001 @r2
 MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
-- 
2.43.0



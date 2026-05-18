Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FBDCD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSl-0003ry-EW; Sun, 17 May 2026 21:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSP-0003XL-SX
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0007LT-5Q
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:45 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36643b96b99so1600978a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066460; x=1779671260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ct0YZRw+BuP94nay1zFP0iAEFGK798J1s+C+AR0YaT4=;
 b=rb1VJgkFgW+sg639LZ1hi001nDwfisA216uGUOpBijnDEKP4l4L59xllVD5q77a65x
 P3Zy6ONWQOkByDHqp+gWm6VQATZqW4bX2qi9u3ekuq0mLfcUFwcxE2C/fUntYFvOYOgN
 PQRKF5qTzpWatukCDo9NdYoVhmicMdgT9PT34bH+v62marsaUZK0OJB9o9DCBU6uHKrT
 2hoDpyxwnsWKVOWc4Zz1E0RSUcthBzBxT/GR2Er1RsSDxA+Ll05rAc/YHQAoczbvcPtv
 hWo1dFZGhkr2B2cggPq2f2O/44kntbPCgkga16v2CH3KvavOvyPd3rIbAvO3MXVVgVWL
 HHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066460; x=1779671260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ct0YZRw+BuP94nay1zFP0iAEFGK798J1s+C+AR0YaT4=;
 b=LyIwe/cQ2YFPvSeaj0w8PO5drtMS48aiz2YUWBGY3A+T4k+BkrHeJPeRQshgcCXjGK
 WE/HsWiOc/S7O5MTz5LEK8ir4jH8qAD0rof2RF63vblAmuCX5jQt/mofG3DqscI84n+f
 Yu1RH62AgPCewXLwk1QjO4L7ChqzOTOKgAzthZZ1U5bKbSDDW9Qur70ks66wcvf7pxXx
 o+aI+Za7s/Nf2UjQS/vgNDMaRBtKj1RwVVX9w8avz1zBNZLLTlA3k9NrB8pjRwGHzOLY
 becgWQZyUs6zlTAkdYvS9t4Bp+YK14Cv16E0cqbPv3v9gO2EZ5RTQ1EJG0Ixj6O9aj5H
 c1Zg==
X-Gm-Message-State: AOJu0Yyx9aMYuS1cQhFJJ456Ga6i6HWeUbV1yZ4WSJGJ8tMBo+MKf2Al
 LdYkop/hCmQtem6+x+9Ylewgpvl9IRDAHleeF+fc8aKFITrQgjHVaemIqSDW2eG6Nsh7GPq1Sd8
 3j7H1
X-Gm-Gg: Acq92OFaFFcYcPYZgNYkZo0vna/bio+TRzxYhy0VF97dge9ZI42Uth2uStkWfwrFjxl
 PXiz/ZnmIMHiT7NbN6A0ss3o3jvYMjb+dbmpXM9jh1nHLWDYESPhrPkcsE2XF475i29IWjCOZc7
 y6HhJnferKqmpMUsldZ82ieq1blfpdVkEXkIzUNGNXUZ/yvAa8fDwjGAu7aRyF0o6VZ5xeU0Mb2
 qMAPbQZnw/FVNBWuqP/BDjoP6qYcsZLMmlTBev4qrCStCtodghu8pisHSgLOKPZlgoQMiVJQ/T5
 ickoSsp8srgd6HkkHiCs3QhHzsFXbL0BSj1QaRfQN3LVwU59BBG7HkT60jOBR41r+P6NNnsFXRN
 Re0Y+ixx8SRp3i9jO7n87HdfOqpv06KTX8yizfkkEEAgGorCX3hXHR7/prKr1CDp2v6ZA/gAzb/
 NcAuRPXK1OH+0+JK+qW1gWZWL9PNym
X-Received: by 2002:a17:90b:58cf:b0:364:8f64:49ea with SMTP id
 98e67ed59e1d1-36951dc8fe8mr13069616a91.27.1779066460441; 
 Sun, 17 May 2026 18:07:40 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 7/9] target/mips: add Octeon VMM0 instruction
Date: Sun, 17 May 2026 18:07:31 -0700
Message-ID: <20260518010733.502237-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

VMM0 performs the VMULU accumulation, returns the low result, then feeds
that result back into the MTM0 multiplier state with a zero high operand.
It sets MPL[1] to zero and clears partial products.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 18 ++++++++++++++++++
 target/mips/tcg/octeon.decode      |  1 +
 2 files changed, 19 insertions(+)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 3539955d90..8a4712a053 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -276,3 +276,21 @@ static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_load_gpr(tmp, a->rs);
+    tcg_gen_mul_i64(oct_mpl[0], oct_mpl[0], tmp);
+    gen_load_gpr(tmp, a->rt);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], tmp);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], oct_p[0]);
+    gen_store_gpr(oct_mpl[0], a->rd);
+
+    tcg_gen_movi_i64(oct_mpl[1], 0);
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+    return true;
+}
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 600e540539..c38201ca01 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -53,6 +53,7 @@ MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
-- 
2.43.0



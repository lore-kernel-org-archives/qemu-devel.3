Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B29CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZg-0006ql-Lx; Wed, 20 May 2026 15:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZe-0006g6-5v
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZc-0002o0-0r
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso70082845e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305238; x=1779910038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ulqIFdbjsPKjZC89ctv2e5sJux9Wn7qpOsmZ8ay+gJU=;
 b=CYV6DgC8RuISNwyOg0erQBknP6aUhj4STIesmKze4FqHM3FQ1w7nTbNl8bh+Hp3hxn
 EcTpF417tNCOal/AQeah7QNMPtCroHEn2e7VWU7N7b5wYHdNpXHc+t2MZkweN9JWeuL3
 mANfMX5PkQ6Q02EeDgomV0d4fE2hBM4zHg3L47IVCHXtj/BYY7H+j3/SSRbsyJWUFqDr
 Gfh6b90UlGukPW3ExvjwtEp5Gb+ZFNqGaznvBQv0RNwFHRdv/xur1aAF5mv24w6wf+8E
 8fD3mOWeizqLTVkvufOTNJniOXR6A5q/A0x1wXmrq/EJfBeVSNHIR3tlelbQpuKElu4g
 CkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305238; x=1779910038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ulqIFdbjsPKjZC89ctv2e5sJux9Wn7qpOsmZ8ay+gJU=;
 b=JB8N3EiJf/LCr8XQw4wV9dQ0SETWTPzlhxamDoC7fv4gfnLuL8J0dTXjXrpdXfXvNc
 TenwgLtepdB8XC8aTGVISIeEdaBRO/IzOz2Xgxc29dl441yZH6QTc9APuz2293yuGdcN
 /KyzliFLp5BKXjEArmCyZtjqY1Hb4m4UraV0R2tXhQE22o/EopUSKzSsg6Qid3Jk9hpH
 sNTWVSiQIlC2K7JkBJhSZp9uHzz0anniEf70PC39AEa7eVy4/ycOpDXGwCHS9BSYWSoy
 jqqNbdnUTx7A7l1hBKXooEDpHE3TxzNWlkszAQawfOE1bqPz9faW3nR1AC7QKndQl2XX
 WCoA==
X-Gm-Message-State: AOJu0YyDHr9aNTsKR441YusDsLcAUsd2NjNxPqy4IDPSJS0GI7JoZ+31
 kMe0iJtAXZgp0mJJeXN1ED0N+9gD7BKkA4ZDP7LRKY+1mBX8YZT7keHkodvRnMm+LY3FFIodMew
 DfegI5oM=
X-Gm-Gg: Acq92OGMqgZSrcM9jvqflUFJ9p2jzjIYrJuq9gw050U6NtHZSQJu36mIN2vWr4Ow7sW
 8+wQbRlC9/wkY3nwhy5DPtY+M+z4f2pYgJCn00tUMaAC6X9uWBH/0RHbkJDiXcXqfANo/l3Y7Tu
 ztzGv6CEZGBi3cq5RDMcSqKIU3v4plU8qDWwARVSduoAHA4lVyOCyMHd/1/iFMRnqX/VpWV3ghu
 wu8Axjp22WUL/sf91D+f8Aj+H0mRAVglGV4q9hgpS0FSmeivMNjxGjKLZQrSntbUEzI0f+wTV1E
 mFYI2Hl59Y/kHwj8/RFt+DgT5sWaj+JBxErW77mP6LEEHDydsk0MiU6rJabOcfzsozUEHjSZZ72
 UTzH8BzThmDolEd/p0TOwxlG29Vrn/tlRpO8sifeKZxy1MekLcy/Dy6F06hzV1cdRfsdOj/clWO
 h294L0vOb3RplJWhhDlmnf8aKLNcrLY9iuP0EwCwAfZjt1Rsr0Cw15bjgkS/x0O9tLuE8ccB2w
X-Received: by 2002:a05:600d:c:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48fe60eca75mr349028125e9.11.1779305238322; 
 Wed, 20 May 2026 12:27:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm53074286f8f.0.2026.05.20.12.27.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:27:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/33] target/mips: add Octeon V3MULU instruction
Date: Wed, 20 May 2026 21:23:36 +0200
Message-ID: <20260520192338.40036-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-23-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 40 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index f9c32e1dee1..4d0ad058347 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -57,6 +57,7 @@ MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 94f3cf9edd8..7ec942fa347 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -315,3 +315,43 @@ static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
     octeon_zero_partial_product_state();
     return true;
 }
+
+static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
+{
+    TCGv_i64 x[7], y[7], z[7];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    for (int i = 0; i < 7; ++i) {
+        z[i] = tcg_temp_new_i64();
+        y[i] = tcg_temp_new_i64();
+    }
+    memcpy(&x[0], z, 6 * sizeof(TCGv_i64));
+    x[6] = tcg_constant_i64(0);
+
+    /*
+     * Z = rs * mpl -- 64x384->448 bit multiply
+     * Compute even partial products into X and odd partial products into Y.
+     * Include RT into the odd partial products, which are 0 in bits [63:0].
+     */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    for (int i = 0; i < 6; i += 2) {
+        tcg_gen_mulu2_i64(x[i + 0], x[i + 1], tmp, oct_mpl[i]);
+        tcg_gen_mulu2_i64(y[i + 1], y[i + 2], tmp, oct_mpl[i + 1]);
+    }
+
+    /* Sum even and odd to produce final product, plus rt. */
+    tcg_gen_addN_i64(7, z, x, y);
+
+    /* X == (0 : p5 : p4 : p3 : p2 : p1 : p0) -- x[6] is still 0 */
+    memcpy(&x[0], oct_p, 6 * sizeof(TCGv_i64));
+
+    /* Y == (p5 : p4 : p3 : p2 : p1 : p0 : tmp) */
+    memcpy(&y[1], oct_p, 6 * sizeof(TCGv_i64));
+    y[0] = tmp;
+
+    /* (p* : rd) = (0 : p*) + (rs * mpl + rt) */
+    tcg_gen_addN_i64(7, y, x, z);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}
-- 
2.53.0



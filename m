Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20E9CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkgO-0007Dy-4g; Wed, 20 May 2026 13:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkgF-00074t-5Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkgD-0004MO-Ck
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso45619765e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297959; x=1779902759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5dlJjCibethqxS9LdN7+k719GiLxTJiHtOLjZHDypI=;
 b=AVr45Iuyspuc09RLrpgUJPBEnALWLykzr9//fk4s/R8gVgvTjtw28x34NDI2EcMh4W
 AnQw4794Ea+gy19SngrOwpI6VIsu/TyhkEsh9MJwmtJvI1jVtmMslcXT1KQ0Zo0YY8V2
 rV5Y14JcZE0vbNCX1MuIP6sxJZyenPKNH9g9FG/heqKlaNx6C+iLg2tt7xdOpcoU4NUb
 7r2/dWHs/RNiQ64l6R86FyYUjXbBeSF6H1OXnkMxHvRMcZJWRmgCGUcSS43XK/gBBE58
 b+8HwpeCFXZimUzWrlzTngS95cQgKCGHIyfzn86Fcno0xJMWNhu8tHmMwROr2GzOX05H
 0SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297959; x=1779902759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5dlJjCibethqxS9LdN7+k719GiLxTJiHtOLjZHDypI=;
 b=MR1KEyWPvq4L9T5BoqIjIq1JYXCihC5pQfJOkaBptxxDWFLJfygzZH25T6zUj7ooat
 RAa/q3hS7L36tzqqfOcUQTW+2TPzQR9cjxIA9yX7Wfj+mDJzibeBlvLYFxGJR+wsNTMW
 GcVTFaqjlVBqKzZ0+0s4xu9dGrrKO7HfdxmfhwhJmPTMU34BCcR0y8/zR/EPLeCuhjfr
 lL6COM+dzXiyRwUA5LDpQoR8a/51SyXL+p11RAzsY188D4U51Hi8GAzWTMzEPT42nomo
 QKGFIXJlBcLlPqHNnnAx8gths4EB5RsUBxEnK+Z4IHb4gqHYNahEzbZWs+ySHPqB9fEH
 3eeQ==
X-Gm-Message-State: AOJu0YxSx0MaNYORQJuQt8mv6pGF8oWAsD472OTLZILKKXEVmT9Kx0cv
 I1v0dSxlNjSwyoCw82hOBycC7io7meirR8Ukou90PNFbllicKN1YDcTkg6XmW1GBoSmSHIBHeJX
 rP8FailY=
X-Gm-Gg: Acq92OGZsBj+iH4Hj8Ykml35Hplg33+b4yJK3ZCvI47tmpFl4y538ogyXQ4isZAdy6W
 N2PpKeQ2TbtwITp4k4QXQacnq7u74yH+TqnYN41pBdC5DevGSu9N9Ka1JUtxsjnxr+sUBW/MTh1
 24sLENRZ7FdXjJ7gB3aTpoz9QsE7L8HFMgLx8spImWImQR+9ashlSprkma5B/R6oikDYhQmsI7w
 5HQ+ZDIex0vCzQbabLq0xIj6uDdMGPQiu2QIe5FdmAw7xlxhM+tB7qnL6fNlmhF9o4Ol6O6985R
 o7IpoPU/JwM43FXdBJkQNk1gKbmgIyGDD5JB4i868NF7JAxYcXPMbYO7sW0HdcndWaUuVUj7vJv
 35Fmcu94XIiE4cUOOnPvDzBeVtl/rVqCSXesRg1k/dh8mS+Be3Nqax/s8Beel772zWW22/sB8gw
 4pcGqQVCrGS2WrOWE1x1+dVxbavIsbyh3gIimangCLb210RudvE8NLx8joOSUKKXiUuMjH4MY/g
 NF+00gNx7w=
X-Received: by 2002:a05:600c:34cf:b0:48e:5990:9698 with SMTP id
 5b1f17b1804b1-48fe651588fmr397605155e9.24.1779297959096; 
 Wed, 20 May 2026 10:25:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e24bsm5710125e9.10.2026.05.20.10.25.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 22/24] target/mips: add Octeon V3MULU instruction
Date: Wed, 20 May 2026 19:23:10 +0200
Message-ID: <20260520172313.23777-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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



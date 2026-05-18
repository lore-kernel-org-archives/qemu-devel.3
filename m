Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2657CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSl-0003s5-F1; Sun, 17 May 2026 21:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSP-0003XK-Rt
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0007La-PP
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:45 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-369742178f8so738831a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066461; x=1779671261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKp4b0sjjMXMeudJqwIR0GfjeOidMo4BmhC9oyE0ygU=;
 b=oihTFTwF+lFca4we066cFPx4VfMuuvzbCZxGAiVBuDXs7EyTt/inw7g397vpRG4n+V
 QATYMEaCkgsBh3pjNz5ParJQ/KwKQ2rWHNFSJRz1vK6TV+M94dCo0JVWUxt5k0lzbRKG
 dqYqRpQDd2arQoAyb0MctgwPJG7yrbOGl38t1cp5kcnIaPBdajJJaOsz1UoqSlFKOp+A
 vb+XmN4VMTX5zMfpw3TnehNrUFyIZ7fJFL35XUWa45IfS7bkh+Rmbe0XZYDLwvKLb0YO
 TfkiIXEF7TEmAPabTdemkz73EKX2ghS2XWz6GNNVeKZvTqzgom7/XBF1VmKkMPv+Y1Rk
 kNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066461; x=1779671261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YKp4b0sjjMXMeudJqwIR0GfjeOidMo4BmhC9oyE0ygU=;
 b=JvqGurEnLxlRm2JhQisUgJOkZ38hXCwe+0Q3qb2vuv9JVfNDPPcsMaWpVKupDUVTvf
 nUVVMxzU3cuuZ/ACw9OoWDOHtM44oH6T1HtDIYR8MRRlyNtgn+1qEWp9rxMov/Td9HK+
 5QrJbKNamcJkEagq+erIX9pNB0UNAK2fAzsCtgos8vBu+FQIxWkgfeiLqfjbRCtJNjct
 0PGFTj9x4JaPIgYO/S/D7SFnnFqNTFxEmWs0wCdXDT9FCpGGnoQXixDUyRuSTAx+Ssvy
 OCOvyeyZKCpV+vOo0ZxYF8jYM7kogukw0IY/y2H4bqF5IJgR7kLm+SwZCsbYAp4fhBT4
 Bizw==
X-Gm-Message-State: AOJu0YxWq8A3j0x7msTnDsugFWMNJbSC21yCLi/1hgSYM8CGobbVEnyL
 1GPkkDKmEBOoBzUaOZ6EwqquvDB5hmNuwwmo1MpKBrrtVYLNLIk36mOkLcqPH/ISUuwpU8UG2U5
 sFpHg
X-Gm-Gg: Acq92OGFHBKuoUhdHNbHoprK0JLnJYQyJxzhN1+IxAGQRNjNNRoBWA4ggagle8fSJdT
 ARh089vpYIXpax4+7IaTxrmciCeI6ZUkL+mJaJQ6Mruia825AOWsJigNORLvKyYSJqgkP1AgLMW
 BdaEY7gVp1rgZseliG5A4euFiN5X9y4rB9L3CYZXcF/bxYYnhyr1OJEHjL0nHEGnZekEluTddeb
 UaWbTkMuHDLRxj0vaPFyJN3SSVOvJHfdAhShUc4Japy4eBcCWxPHEWEUJbvPbTfRcSBmEnyyoaz
 oMvYK4aVPjuu+fdnpBhYSAtGHjx0c3wGUlmld9Jl7uwcsRP8HJf0efBkmFy1S2aP+l6z52o5KtR
 ErHA85O2U23KQYbtpnYrFQpm+bwI52XDfNCjmsPT+kg28q3VqwmLKGB/1WRZWXC64115omkWvng
 12P20bYDMlzKlPYDRzn73Ht+UPPk4y
X-Received: by 2002:a17:90b:2f08:b0:369:996d:282c with SMTP id
 98e67ed59e1d1-369996d2ea1mr4664032a91.9.1779066461225; 
 Sun, 17 May 2026 18:07:41 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 8/9] target/mips: add Octeon V3MULU instruction
Date: Sun, 17 May 2026 18:07:32 -0700
Message-ID: <20260518010733.502237-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 40 ++++++++++++++++++++++++++++++
 target/mips/tcg/octeon.decode      |  1 +
 2 files changed, 41 insertions(+)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 8a4712a053..5bcea1de3b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -294,3 +294,43 @@ static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
     }
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
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index c38201ca01..15d3c79344 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -54,6 +54,7 @@ MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
-- 
2.43.0



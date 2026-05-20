Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176B9CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkeS-0004ep-3b; Wed, 20 May 2026 13:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeQ-0004ah-Gn
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeO-0003by-Si
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso68537995e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297847; x=1779902647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRLKVH14QDYQaVrfjU+onWCMIThdi8GoEYRTGd4kc9Y=;
 b=fVP9ZzpNtUgFQ5IAj+oMROq71YV3l9DHLkr3h1aupiHVupEhwno/X70BtAgbik+Jfb
 oAz6/UT0TIhF+RMC/qKruak5aSbQ9adYAWdevJ9zq4n7HbWmcbinXev4lUpn8E7+izTW
 luLYon/5mzQ19drCaNUkfUkandUb+7DKKT+wwbFD0TeMVwOlD+lII4Ev2E/au4iZqc7A
 Ab8CsrmHTP7xusn3U8RAS5rjyzu2a5QZ3MSwrWBgireEJ1revTFQKXOuBjE5V0vehfv5
 rpBvb7/DyiBI/OcVzCa1t56Ayy03cZvnB2p1ZseciRUWxEtknLJrNpLnNzlwd3Hd9+SQ
 xayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297847; x=1779902647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRLKVH14QDYQaVrfjU+onWCMIThdi8GoEYRTGd4kc9Y=;
 b=lBxGDuHIetHkHbYUsKerL8vpcasbZErU6wC5201KnMG1q5EpFQIHk90r9BGBsqkufM
 pQtaIi03tniiEQ/btNZo3WY8fwQmdj/P/UzrYb4XIvwi2e9M55shSX9W/GZhHNrWs0+g
 ba8UzXigBjin3Lwfz+c/5GQ4KrreXmnYx8eeAGHoY9gjiTU4d5rlAGZtrfvBA4MsModU
 XH75ehK3w7Xmbpyi7T3RsbSER46on+TnxleWNoX1FddMZTCwDV6utvSwyU4sMi2Y5+CG
 8dmC5fISJnUD7GnQj6X0nPjNtMriSvAwimzfyLWxRhzN4fk7pERYf5gsG+fzuhsNBdC7
 huMQ==
X-Gm-Message-State: AOJu0YwSqB+p/jXd5ncuHeh3dHz0Rftk8M9fFgKMiRZ3asttWPUGcGBL
 mLIawbfx/oHSmDvCwgRalJ8uwnx+EpT2uVxcx8j5C4aoh6N7gQcHgW2I1VhAC/e6gFNDAuyGd0b
 OTab+PzQ=
X-Gm-Gg: Acq92OHTkOXx2szQ0Ij1y0oLSKqFfXDyTriXWXIGDXqpp4CcKtxEIpov08OEDWNmAmG
 FUkDrqXsi1rIOexfop+T74ph71XqnYX7B8+vUDBpbN64bm2QuH6wAvRAAFDAIm+xXFeWJGt4kKs
 4FxV2XTlcxXp41Zvpi4rKZJVhWA24CG713eTQZ+bB3BENTxr0zGJvK4hxGsK1aw0hfAPAQLwSnq
 sSaw4AtdBweKA9CDSbb79jlo3ykWWpbRqyRv3WXZHuLDjQ208XD05lyohGe1frs2wLKtpsnjFYr
 HjDXtXyH9QeM+5YJdgvQQ7/2FpxjNaIV78QE3bksnf7skS385QD4nTnAxoBwwYMDcJ0JnCDwsg5
 ZRKHqvkSaikvA8ux7ppJKQzJyD0h0ehM5ANFQOPrPq8Z9grvI0FlwgCK8ZAnHO+YDzboe0lbj7p
 uHdigQ0GJ0hOEWNxzj/hL+wPFHfoTS46RGnfWquSr/RwgFnld3VpZ2Ei1TAz8IczrC4rgRlw+t
X-Received: by 2002:a05:600c:1f87:b0:48f:fe2a:1099 with SMTP id
 5b1f17b1804b1-48ffe2a1244mr286553695e9.5.1779297847267; 
 Wed, 20 May 2026 10:24:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e25bsm5567275e9.11.2026.05.20.10.24.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 07/24] target/mips: drop Octeon zero-register fast paths
Date: Wed, 20 May 2026 19:22:55 +0200
Message-ID: <20260520172313.23777-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon population count instruction paths.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon_translate.c            | 15 ---------------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd76268350..b7531653e58 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index b7610db812e..f406726fc11 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -39,10 +39,26 @@ static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
     assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
 
     return 0;
 }
-- 
2.53.0



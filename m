Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AF5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfEP-0003n6-Pq; Wed, 20 May 2026 07:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfDm-0003WY-AJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:36:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfDk-0006CE-Iw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:36:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6746d0b2b4aso8433828a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276974; x=1779881774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6pNcfHaTRa/5b8aBOv11Qwh7sxl5E8W3OHi3uNH/pc=;
 b=jMHzRkzkriR+v7sjbozDo7IZ5jblfOlItbZKH7F8mZqiiWVgQcB+eKCVNKfkOYE2qN
 lOJfEcuI5uOO/986QoCP4GlGWvVy94XVQ+qaPxFW7UnlBoe0sY2ArsNfGMDB/VpEtgIQ
 +hJF4nZXaKflZBd74bsWauMRX8y9yQMws+3mDXePREzKelNtiO9poPWJPq5c3afH2klg
 cAqAVK+7K83j1Cfmgkdg7BwWEnnu1wwAp1tsFwNYcXoClNhARja2dECKkT5M3nYDBZAm
 8xjj1hOwgqvio+EgZ79I7HN95lPfIn5gMOWkov/MKItEYgvZvs335B68K02LCjFGM5jP
 jq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276974; x=1779881774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y6pNcfHaTRa/5b8aBOv11Qwh7sxl5E8W3OHi3uNH/pc=;
 b=lJvg2gbK3CmRH+MCBXwY0YDSueoS1UxaM05hgDuL0NmxskEpNSHYDXpf1q0b+f7Cxn
 R4AzKd0KAqHmtWEiMbriCQ0CFVq3t5lCFQHZ5m0KaXbmrZZpXUmLX4wDuFJ+otE1KGJB
 13sAy2n2HZje6oI90E36fTkSE+6Fy4KGPiklaQWxUKlO6ZYJMXEndQIow7wmHnwY++aI
 DTH6QcfhzDv5Xr9X7SHBN92HqualHeugwgSSwOh6eDYGcSi8qUmVG2nhZF7jVYxoS2M2
 hsrrAukKG5LrcG4aJu+nEZ6sXd7F4j+VGqu8FIFG8wRZiq+0Vm4qoUjT+m8opfQNZ0JW
 9GAA==
X-Gm-Message-State: AOJu0YxmxnM33WEqFWCoP5EKw6K9MHbYfYsAnu5uRrl+Rs+bj5JqC0CW
 jmNLZzL0+0uqyzUNFLf8MbPrZhKjpLPB+sCrhvzv/1SqcJrazLKUG22pC68dhAHSGXFSHddhQZq
 Kr24vPx0=
X-Gm-Gg: Acq92OGXNPBPwSRoCvIcDa9BkCvzIowZ6GEMd/dgdptr/qsXi79b5rxmJdITJYfeLX9
 yHy+QpmPNYGRQGZzhLjsIUfpSWUnoGx6C4yf/y9swvqb2TJ3aOM+FKyh3A62cJChQoduc2TjY5b
 bBFD4nBLb6l+tyaGVbJGRvuz/a6C8Ea6Q8w0lAvhFLixb4aYSHBlM4gZlTekdJsgXOoVBK1m86B
 OUELRHhUnYtC7sUKh1FzqRlS37neuhCBPVvmvdHnFv5NK7VETVaUseIgCFSdBkqaow25yIi4TQL
 rdm8tZtrFkDYhsQotAlaHrVDZkuznbkvfqr8MWwdfCvsWwO/ey/VKdUvOlgZMogwhZcSobd5/c2
 M4z9BCyZaqS13Z4dLVZO7hNUo2lXxeFXHn3aoHmKAl7V0nByaoKKzMKBbUM3TjWCRALCN5BVXpH
 OB/j1t+orIpX2JZxTZf8UT9k0LjIIsNZMVREO1VOEBdurhxyu+YJ98cknrRyrMeFLJ4DBrh6koC
 1epgQ==
X-Received: by 2002:a05:600c:4692:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48fe632661bmr379121065e9.19.1779272335520; 
 Wed, 20 May 2026 03:18:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm127427805e9.13.2026.05.20.03.18.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:18:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 06/24] target/mips: fix Octeon arithmetic destination
 handling
Date: Wed, 20 May 2026 12:17:47 +0200
Message-ID: <20260520101807.9971-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon_translate.c            | 16 +++------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 35 +++++++++++++++++++
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444aa..4dd76268350 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index aef23fb9465..b7610db812e 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -7,7 +7,42 @@
 #include <assert.h>
 #include <stdint.h>
 
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+
     return 0;
 }
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D0ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgs-0001Fg-Fx; Wed, 20 May 2026 00:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgp-0001Dv-2g
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:51 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgm-0003rX-KU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:50 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479dc6d26e3so2675255b6e.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251866; x=1779856666; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=616bqmJMtxgdrwj6c9UkRD4vaulGvEtHPMYwNIUf+dE=;
 b=gOEvmjZ842CSk/skIySLFY1hQq9wNg22IhxD8845FcYlD/Gjph5XXOt9qonqjh4Vtb
 PmYSfXLkPB5foll3+XJRY+2tzjubRRGx+y7TFNEm4zoKoDEnau3gGCrthL6DeHuWcCkS
 Q8wk7HnY+Kk352lc6dycEt3kQN1MAoMVSVTGww0Kpu5j1h9MbQxnX2xJqbRNBrMpMHNV
 ZWCuwbpBxzdThjFUopvB2ZU64BHsl8IPlK7R6eSZo+oR2sOTb3gKwSJcL+GawoinbNIr
 8VARIKkM7sQVfaLry5Qh/z9wK+jtSllrklTmggy0k7QIymXepJa3N+L6eZ8X+5/KoS9N
 ZkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251866; x=1779856666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=616bqmJMtxgdrwj6c9UkRD4vaulGvEtHPMYwNIUf+dE=;
 b=AdrAMQoeyWMvNf75kJGXGRnKVIEzE8WH6SNP04CV3cYriHdmh1coV6IpaXM3iVcWKD
 DxtddVf6LemltKjQ9P8542jLl4Oz+bC6hOVA14Yvi8MtOWhqvJyBwCdsJPHybpx+gKON
 ejwKtwepvzSwMqfLumaL99AOWWbS014kixysgB6GUf0SYWejnNUWCMEc7/bLgQyvGwdj
 yUbnfscxH6uroakySglr+d0E8YQnW5wXVrifWAd3sD/QaYq1jypuZ6REHkuzbtLH63w1
 M67sFvVzwlefim8gsOvEyarp10QBNgWA558IslaTnA0nF4loWnj0vAmoiUsygo4FcnPQ
 y9mA==
X-Gm-Message-State: AOJu0YxlfuwHx6qVzN1doT40kO0JvBaHnrpe6qeoqYWaXtv2NHgnJKR4
 xMFirR8x5SytS+oOHDROr/hI95Jwb2A+t0QlCN/GXmYjpjQArzTAXpUN
X-Gm-Gg: Acq92OFkvdMN6sERqCOt7YlfFV7pp7sZ1VzOGa/40yAuh+EDHIXkiS/uzZ5igVm7Gtx
 Wld0z1jpi71n60S6FHe3N69/pXqxn2tN+J5XAAyIHbsaoliuaXqQSzWV0wVqyo1BlqFP17WVwXJ
 c/tNjjw3IOO0tB10eFC+RIrOBjvme43hZ1cp23vsDQrMphHSHOVYiqQqpnJfmidKOEb/npnKMW1
 okNsjGCyiw6PJ+j5v9hrfSJvGko5+s7i8rye7BeVjczYZu0HLoO5GIZEibyRorRJo95a0QSWXNJ
 7IWzk24UN18cUdvxT0lhyy9rns9yFjlXoq7V75N86BgeuwvcstFZ9EIDggubis+UCjHFavVMUSq
 v85Q0cZqGSEtv+iq/jou3pr3QCRTaKIoI2lyHBPFpEsxK/UF5AHMrrk9NTqS7uXJGDPV0Zu+eJW
 VpJuWKQA2dttPCkJOdrhz3SECXsuILIVWp19gxsgCV1Zo1tzpATVvEBybAdD4LWk6D7JSKxbg+0
 x9hOE278RcCJtVK/6yoakfDr6MZsgRxY0GjJ6L7oB5swDX/IME36S0KWOpxOeGyMpxsP9AJnNiE
 mdA=
X-Received: by 2002:a05:6808:e698:b0:45c:8fa8:7497 with SMTP id
 5614622812f47-482e5771dd9mr10734432b6e.34.1779251866386; 
 Tue, 19 May 2026 21:37:46 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:21 -0600
Subject: [PATCH v10 27/45] target/mips: add Octeon GFM COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-27-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

Add helper support for the Octeon GFM carryless multiply selectors. This
models the normal and reflected multiplication paths, including the
XOR-and-multiply forms that update the result/input state used by Octeon
crypto code.

Implement the reflected path with the same architectural 128-bit state
model as the normal GFM helpers, avoiding target-local shadow state or
a 64-bit reflected shortcut.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Preserve the 64-bit UIA2 GFM reduction path used by SNOW3G F9.
  - Rework reflected GFM helpers around the full 128-bit architectural state.
  - Use direct RESINP XOR operations instead of target-local XOR shadow state.

Changes v8 -> v9:
  - Split GFM selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 125 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e802f50fd6..7767556f79 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -38,6 +38,10 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xor0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 811f36f46a..d59bd8fdac 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -11,6 +11,7 @@
 #include "internal.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/clmul.h"
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
@@ -75,11 +76,135 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
     octeon_crc_set_state_reflect(crypto, crc);
 }
 
+static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
+                           uint16_t poly, uint64_t out[2])
+{
+    uint64_t zh = 0, zl = 0;
+    uint64_t vh = y[0], vl = y[1];
+    uint64_t rh = (uint64_t)poly << 48;
+    int i;
+
+    /*
+     * Keep the reflected-shift formulation used by Octeon software: the
+     * selector polynomial is pre-positioned at the top of the high word before
+     * each carry reduction.
+     */
+    for (i = 0; i < 128; i++) {
+        bool bit;
+        bool lsb;
+
+        if (i < 64) {
+            bit = (x[0] >> (63 - i)) & 1;
+        } else {
+            bit = (x[1] >> (127 - i)) & 1;
+        }
+        if (bit) {
+            zh ^= vh;
+            zl ^= vl;
+        }
+
+        lsb = vl & 1;
+        vl = (vh << 63) | (vl >> 1);
+        vh >>= 1;
+        if (lsb) {
+            vh ^= rh;
+        }
+    }
+
+    out[0] = zh;
+    out[1] = zl;
+}
+
+static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
+{
+    uint64_t lo = int128_getlo(product);
+    uint64_t hi = int128_gethi(product);
+
+    while (hi) {
+        int bit = 63 - clz64(hi);
+
+        hi ^= 1ULL << bit;
+        lo ^= (uint64_t)poly << bit;
+        if (bit > 56) {
+            hi ^= (uint64_t)poly >> (64 - bit);
+        }
+    }
+
+    return lo;
+}
+
+static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
+                                  uint8_t poly, uint64_t out[2])
+{
+    /*
+     * UIA2 uses the GFM datapath as a reflected 64-bit multiply in the low
+     * half of the 128-bit register pair.
+     */
+    uint64_t vx = revbit64(x[1]);
+    uint64_t vy = revbit64(y[0]);
+    Int128 product = clmul_64(vx, vy);
+    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
+
+    out[0] = 0;
+    out[1] = revbit64(res);
+}
+
+static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t in[2] = {
+        revbit64(crypto->gfm_reflect_resinp[0]),
+        revbit64(crypto->gfm_reflect_resinp[1]),
+    };
+    uint64_t mul[2] = {
+        revbit64(crypto->gfm_reflect_mul[0]),
+        revbit64(crypto->gfm_reflect_mul[1]),
+    };
+    uint64_t out[2];
+
+    octeon_gfm_mul(in, mul, crypto->gfm_poly, out);
+    crypto->gfm_reflect_resinp[0] = revbit64(out[0]);
+    crypto->gfm_reflect_resinp[1] = revbit64(out[1]);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
+void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_reflect_resinp[0] ^= value;
+}
+
+void helper_octeon_cp2_mt_gfm_xor0(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_resinp[0] ^= value;
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
+                                              uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->gfm_reflect_resinp[1] ^= value;
+    octeon_gfm_mul_reflect(crypto);
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->gfm_resinp[1] ^= value;
+    if (crypto->gfm_poly <= 0xff && crypto->gfm_mul[1] == 0 &&
+        crypto->gfm_resinp[0] == 0) {
+        octeon_gfm_mul64_uia2(crypto->gfm_resinp, crypto->gfm_mul,
+                              crypto->gfm_poly, crypto->gfm_resinp);
+    } else {
+        octeon_gfm_mul(crypto->gfm_resinp, crypto->gfm_mul, crypto->gfm_poly,
+                       crypto->gfm_resinp);
+    }
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



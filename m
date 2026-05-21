Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A29CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7mx-0000Cm-6p; Thu, 21 May 2026 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mr-0000AW-9e
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:25 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mp-000220-9B
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:24 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de7dc85b74so6257234a34.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386782; x=1779991582; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hiKG7vqkKtjgPdKX+1200Dw0BsCoKa6VofI0vBywP+g=;
 b=M/y12oXWJl+XHaU/F+9WrQnZ6hq38pj0J8IxmFF/rwumwAtrwc6NegvP+FK2BZb3yG
 7kzREwqAAsr76YKHU0RXvF3e+MO2ptc67QRXZT6dstWmi5YDkeafe2Gfp6SwK9vjtzo8
 yKJQjjkf8OWBTeFprTcvTp94GOMHYwFkKdXvNB6mK+KMRDcF7/7IjA5Ay6wX6F11wXYp
 BDdFzYtcOnvqC/vOdAEfEUgg1nK4XC1pfV8kjoUrpKDF3EejTyZ19Cjoex6Ca5J+jhVv
 1V0mg2xZ+gLlerIpfvsGAC8YGuXMVEqbWrjClQGOMJC2Oz3wcv0/tT51afgme7MRkA68
 ux5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386782; x=1779991582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hiKG7vqkKtjgPdKX+1200Dw0BsCoKa6VofI0vBywP+g=;
 b=SsWcvtKPmq9Mnq9PnmcaDLSMdiPBae7Lq3AOGHwc2C2XspIuA6QFmm83lhWb2boDWl
 VTIj5e2Exw7vILSCI+d6i2y5RmLygj91HOqz1ZfTsmWcQiGp8fPXo/dqSCLg7EWLndTH
 TjP5viS13xR2eb/Ly3YGbFkVNI7VEPA5BMHOJ7R1GGIUDRtuO46eQ+q16yfPo19aSRF6
 JD51u/wDG/c8J2l9HuUJ+EIbhzlSGzi8SP0fHA0gA6bKHq3K1ZhbqJWMg24J1gec3V6/
 9FLe+Q1mipqz8QqIcffsW3pcEVxaONXfkEiKKNW0zLBCZ0XHydJHMbQ2m1VDk6rH4iCr
 qubQ==
X-Gm-Message-State: AOJu0YxiqWfcN9HoZGIlMxazsDhnK1yBN0z9oY8+Bt1cIceomYN99stL
 pbvxqthZARWMMgJTDTFarorFYTwqy+Qe9LICDNp/l+Lrp3xUyLojll23
X-Gm-Gg: Acq92OE5ZSNb/EH6GePOM+V9StszHqzH/IYaJpuN96+8V53DKFzv6oYyiulslw3E157
 XL71sOwQL3cVqYZx9aDUjI6ZEVxWg0So9bRWnlzo6ojJQuc642wgf2ZEKyXWdBgOsNBbcXctmKv
 oFDzE+NxoUbpzokVXtguku6kAn79Phn8RCpw5kWXY0+jSZ4QM63x/YE9tfyGvhrf4r7OZRo4KIG
 W6TMXi6A9nSajOoraRb7nlWD7kxnXBIKFnyHvk3C0szS1ZmBNMKgD8z3+ioh9PuyTX1/97FwwGn
 FuXlGBnDgdbM2w3gYQRMv+E970SYRbeJQ/4MFwDRAzzrlNVhHmTo4iJ/casFa8Lgjn+8lAjC/I3
 /TJ/FVE0kUbp4cbNRdvmyV5KhZ1Py+ufETlm1rHAGyN3bLv5Fq7zOHv885GQdK4if9WhUqkwgsY
 HN2/9omsagpK7SWC9Bq5HNe2MWw0mjMc53DUGVbHLz+zQ8EQGEu34MhHyagjrNXZBB62D7yz0tJ
 lp/UZGok4XiUqsS264jntmRsneCFzHPeB0ixWPP+RFE2+gMPILOgx8ApcTYPJiW28QG
X-Received: by 2002:a05:6830:83b0:b0:7e3:fa31:1104 with SMTP id
 46e09a7af769-7e5fef61165mr123396a34.22.1779386781977; 
 Thu, 21 May 2026 11:06:21 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:05:58 -0600
Subject: [PATCH v13 05/22] target/mips: add Octeon GFM COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-5-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x329.google.com
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

Reflected selectors operate on the architectural GFM register bank using
bit-reflected register transfers rather than a separate shadow state.
Keep the 64-bit UIA2 reduction path used by SNOW3G F9.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v10 -> v13:
  - Map reflected GFM selectors directly onto the architectural GFM state
    in this patch instead of adding temporary reflected shadow state.
  - Preserve the 64-bit UIA2 GFM reduction path used by SNOW3G F9.

Changes v8 -> v9:
  - Split GFM selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  10 +++
 target/mips/tcg/octeon_crypto.c | 139 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e802f50fd6..9a6702ff60 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,10 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -38,6 +42,12 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xor0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 811f36f46a..b22474574c 100644
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
@@ -75,11 +76,149 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
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
+     * SNOW3G UIA2 uses the GFM datapath as a reflected 64-bit multiply in
+     * the low half of the 128-bit register pair.
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
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
+uint64_t helper_octeon_cp2_mf_gfm_mul_reflect0(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_mul[0]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_mul_reflect1(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_mul[1]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect0(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_resinp[0]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect1(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_resinp[1]);
+}
+
+void helper_octeon_cp2_mt_gfm_mul_reflect0(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_mul[0] = revbit64(value);
+}
+
+void helper_octeon_cp2_mt_gfm_mul_reflect1(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_mul[1] = revbit64(value);
+}
+
+void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_resinp[0] ^= revbit64(value);
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
+    crypto->gfm_resinp[1] ^= revbit64(value);
+    octeon_gfm_mul(crypto->gfm_resinp, crypto->gfm_mul, crypto->gfm_poly,
+                   crypto->gfm_resinp);
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



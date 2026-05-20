Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD445CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgs-0001Fh-V4; Wed, 20 May 2026 00:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgq-0001EY-EQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:52 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgn-0003rj-NF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:52 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e363c6141dso3668625a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251867; x=1779856667; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VvOEYbYQx4yLqf1C5vZlAY/usIq9VrwMWKsAkZ+uj44=;
 b=fdQNTy2YMh+84Rhog/WFrLc1WPqRTHROjGn43+UfV6dTsx7tCFv9dNPanp+n+zI/Hc
 vCN6XwgvqnQT9/x1Uq27xE+kiT+Bg3cpfollY0RE/WZSEpg1mElciWC3Ad2OpOIPnhq0
 gA/KYcymzEyDsW11pH0GtminCJX+rCGIlE8WM+J1RuajJPB1gE6TI1WGs/S4Wey+uyP0
 vJdSnyq4R5MGNMztixNVd3MmCaxJqsKAzfLQapbn0fGD9llTIDSmRECN8++nVT5Oxsip
 6lx4C+tfWiODKuzRN5qdMt2WK293HjdlZ53k/XnARKJkr5rg4Ybpn66gOKfo96PzJeVT
 oBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251867; x=1779856667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VvOEYbYQx4yLqf1C5vZlAY/usIq9VrwMWKsAkZ+uj44=;
 b=KE3xS0cyBBreJQcm41OZeIj++2Q+63uJ75l18o9kSMC26oEynwlaCr16pLLKRjZQv2
 O+u8tcrn2Cd0jqOktTSTw8R1FdSJIZ4PZANCHpaG5PsOtLMKhYlO5QfgWgeZtDo9lrcG
 xQP7KkuqZwMP3fM2zSgzMXdbBN3msvwhId6FVW1lmG3ItbQTy8OpYu3pOTX0QwVtHLNb
 sgqlwNjZqZzedp11Y4QSbaAOE5IAH786gziaiEr7/4PAUzONQG9+J6rZEanIMoTnclB+
 NGjRxYVp1nn7FTC6eVqFk7k7Fe+i7l0ZmW7yI2vgaVqzgdlw3MlUoxhXpCrrENKA9/N5
 /7gg==
X-Gm-Message-State: AOJu0YyjpKhRph4qP+1t6q9RPglGpjU+M7YGnCn+qktg+U/ezbfComOo
 yObkaZW6ORLl3ENEqlYQlOcIq6uH+6BDYrff48kmd74oO+3bRflofry5
X-Gm-Gg: Acq92OFHx/GmP4q++sBBczuoWkktTA/OuF/+zv9+LAtnc+3aGaMtCkXOq8QPNbA5Lgk
 fYZ5AE89q6HwHXBJVpCVLJFFVpgM/DhlxY50IFLrVDJ+KTxxzneoIwF0lNxHzWNNs6OpF3RsboV
 ci1RLZ1Ejkn/fUdVaeJc8+626qzYUWgkplO18jZo0aGZOCBwAGF/r1MnvaR9qnGgZPub5lD3mxG
 WeU3YiJcurFbC6vHsBsSuPFSMArJDxtJoKMtaBTHEyt1XNb7r5W4MbTZ1AxZFddKmUrQgDR5lhl
 ay0Oq/Zk1DwToPfgqRTKzyuR7Sk//3AUkoqwpacgDLU57dpvyZtaqUamHj7Rac5SvUp980ViqWM
 V1UlFzIrJzhxbw/s+/Zc/2WkSvhwhWRT1+TUy4g+D6WinlJ4fWCuvtHDlEcaN7aL5kqiXfo3kS9
 nZc3ZmgmDGI1J+Wk7SM3uKNGFg3n5vLFfxUnXaZN7I+IAtOuy84SXuBdHatvI5sWmGSqUtN+/Uv
 J7cI3zMz2oZAM2XEBmSM8euyPZM84x1BkovpE8IfSBkVOp1KsKQZqvk+Sx7lnIGZiOVuR4GYNl3
 DTs=
X-Received: by 2002:a05:6830:d11:b0:7d7:4002:1f21 with SMTP id
 46e09a7af769-7e4f2b6c3a7mr15243594a34.20.1779251867494; 
 Tue, 19 May 2026 21:37:47 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:22 -0600
Subject: [PATCH v10 28/45] target/mips: add Octeon SHA3 COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-28-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
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

Add the Octeon SHA3 register-window state and helper operations. Keep the
shared HSH/SHA3/SHA512 write path coherent, model the dedicated 25-lane
Keccak state, and implement the Keccak-f[1600] permutation for the
STARTOP selector.

The shared selector window still uses explicit selector-position
arithmetic internally because multiple COP2 engines alias the same numeric
window. Individual DMFC2/DMTC2 instruction decode stays outside the helper
implementation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split SHA3 selector operations into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation SHA3 helpers.
  - Use helper-local selector constants for shared-window position logic.
  - Add matching helper.h declarations with the helper implementation.

Changes v1 -> v2:
  - Use switch ranges and g_assert_not_reached() for SHA3 selector
    position decoding.  (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Rename SHA3 DAT15 selector aliases with MF/MT direction suffixes.
---
 target/mips/helper.h            |  22 +++++
 target/mips/tcg/octeon_crypto.c | 172 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 7767556f79..31363fb8dd 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,7 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_sha3_dat24, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -42,6 +43,27 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xor0, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_dat24, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_dat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat8, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat9, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat10, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat11, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat12, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat13, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat14, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat16, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_xordat17, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sha3_startop, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index d59bd8fdac..010baf3664 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -16,6 +16,8 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
+#define OCTEON_SHA3_DAT15 15
+
 static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
 {
     return bswap32(revbit32(v));
@@ -166,11 +168,129 @@ static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto)
     crypto->gfm_reflect_resinp[1] = revbit64(out[1]);
 }
 
+static const uint64_t octeon_sha3_round_constants[24] = {
+    0x0000000000000001ULL, 0x0000000000008082ULL,
+    0x800000000000808aULL, 0x8000000080008000ULL,
+    0x000000000000808bULL, 0x0000000080000001ULL,
+    0x8000000080008081ULL, 0x8000000000008009ULL,
+    0x000000000000008aULL, 0x0000000000000088ULL,
+    0x0000000080008009ULL, 0x000000008000000aULL,
+    0x000000008000808bULL, 0x800000000000008bULL,
+    0x8000000000008089ULL, 0x8000000000008003ULL,
+    0x8000000000008002ULL, 0x8000000000000080ULL,
+    0x000000000000800aULL, 0x800000008000000aULL,
+    0x8000000080008081ULL, 0x8000000000008080ULL,
+    0x0000000080000001ULL, 0x8000000080008008ULL,
+};
+
+static const uint8_t octeon_sha3_rotation_constants[24] = {
+     1,  3,  6, 10, 15, 21, 28, 36, 45, 55,  2, 14,
+    27, 41, 56,  8, 25, 43, 62, 18, 39, 61, 20, 44,
+};
+
+static const uint8_t octeon_sha3_pi_lanes[24] = {
+    10,  7, 11, 17, 18,  3,  5, 16,  8, 21, 24,  4,
+    15, 23, 19, 13, 12,  2, 20, 14, 22,  9,  6,  1,
+};
+
+static uint64_t octeon_sha3_reg_to_lane(uint64_t value)
+{
+    /*
+     * The COP2 register interface is consumed by big-endian MIPS code as
+     * 64-bit register values, while Keccak lanes are byte-little-endian.
+     */
+    return bswap64(value);
+}
+
+static uint64_t octeon_sha3_lane_to_reg(uint64_t value)
+{
+    return bswap64(value);
+}
+
+static uint64_t octeon_sha3_get_lane(MIPSOcteonCryptoState *crypto,
+                                     unsigned int index)
+{
+    if (index < 16) {
+        return octeon_sha3_reg_to_lane(crypto->hsh_dat[index]);
+    }
+    if (index < 24) {
+        return octeon_sha3_reg_to_lane(crypto->hsh_iv[index - 16]);
+    }
+    return octeon_sha3_reg_to_lane(crypto->sha3_dat24);
+}
+
+static void octeon_sha3_set_lane(MIPSOcteonCryptoState *crypto,
+                                 unsigned int index, uint64_t value)
+{
+    value = octeon_sha3_lane_to_reg(value);
+    if (index < 16) {
+        crypto->hsh_dat[index] = value;
+    } else if (index < 24) {
+        crypto->hsh_iv[index - 16] = value;
+    } else {
+        crypto->sha3_dat24 = value;
+    }
+}
+
+static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t state[25];
+
+    for (int i = 0; i < 25; i++) {
+        state[i] = octeon_sha3_get_lane(crypto, i);
+    }
+
+    for (int round = 0; round < 24; round++) {
+        uint64_t bc[5];
+        uint64_t temp;
+
+        for (int x = 0; x < 5; x++) {
+            bc[x] = state[x] ^ state[5 + x] ^ state[10 + x] ^
+                    state[15 + x] ^ state[20 + x];
+        }
+        for (int x = 0; x < 5; x++) {
+            temp = bc[(x + 4) % 5] ^ rol64(bc[(x + 1) % 5], 1);
+            for (int y = 0; y < 25; y += 5) {
+                state[y + x] ^= temp;
+            }
+        }
+
+        temp = state[1];
+        for (int i = 0; i < 24; i++) {
+            uint64_t next = state[octeon_sha3_pi_lanes[i]];
+
+            state[octeon_sha3_pi_lanes[i]] =
+                rol64(temp, octeon_sha3_rotation_constants[i]);
+            temp = next;
+        }
+
+        for (int y = 0; y < 25; y += 5) {
+            for (int x = 0; x < 5; x++) {
+                bc[x] = state[y + x];
+            }
+            for (int x = 0; x < 5; x++) {
+                state[y + x] = bc[x] ^ ((~bc[(x + 1) % 5]) & bc[(x + 2) % 5]);
+            }
+        }
+
+        state[0] ^= octeon_sha3_round_constants[round];
+    }
+
+    for (int i = 0; i < 25; i++) {
+        octeon_sha3_set_lane(crypto, i, state[i]);
+    }
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
+uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
+{
+    return env->octeon_crypto.sha3_dat24;
+}
+
 void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
 {
     env->octeon_crypto.gfm_reflect_resinp[0] ^= value;
@@ -205,6 +325,58 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     }
 }
 
+void helper_octeon_cp2_mt_sha3_dat24(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.sha3_dat24 = value;
+}
+
+void helper_octeon_cp2_mt_sha3_dat15(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[OCTEON_SHA3_DAT15] = value;
+}
+
+static void octeon_sha3_xordat(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint64_t value)
+{
+    uint64_t lane = octeon_sha3_get_lane(crypto, index);
+
+    octeon_sha3_set_lane(crypto, index,
+                         lane ^ octeon_sha3_reg_to_lane(value));
+}
+
+#define OCTEON_SHA3_XORDAT_HELPER(N) \
+void helper_octeon_cp2_mt_sha3_xordat ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_sha3_xordat(&env->octeon_crypto, N, value); \
+}
+OCTEON_SHA3_XORDAT_HELPER(0)
+OCTEON_SHA3_XORDAT_HELPER(1)
+OCTEON_SHA3_XORDAT_HELPER(2)
+OCTEON_SHA3_XORDAT_HELPER(3)
+OCTEON_SHA3_XORDAT_HELPER(4)
+OCTEON_SHA3_XORDAT_HELPER(5)
+OCTEON_SHA3_XORDAT_HELPER(6)
+OCTEON_SHA3_XORDAT_HELPER(7)
+OCTEON_SHA3_XORDAT_HELPER(8)
+OCTEON_SHA3_XORDAT_HELPER(9)
+OCTEON_SHA3_XORDAT_HELPER(10)
+OCTEON_SHA3_XORDAT_HELPER(11)
+OCTEON_SHA3_XORDAT_HELPER(12)
+OCTEON_SHA3_XORDAT_HELPER(13)
+OCTEON_SHA3_XORDAT_HELPER(14)
+OCTEON_SHA3_XORDAT_HELPER(15)
+OCTEON_SHA3_XORDAT_HELPER(16)
+OCTEON_SHA3_XORDAT_HELPER(17)
+#undef OCTEON_SHA3_XORDAT_HELPER
+
+void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    (void)value;
+    octeon_sha3_permute(crypto);
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



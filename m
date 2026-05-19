Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA078CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDu-0006ti-6B; Tue, 19 May 2026 12:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDl-0006k5-2B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:05 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDj-0000nC-EM
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:04 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43a1004f686so1443955fac.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207782; x=1779812582; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l6iO5cCPGOYFPb3KVLbGSJQx31T0/SdzlJO8X3IH9zk=;
 b=nm9fcCMQgELjaTJhSNFVDBZNF6i8DWmjsEVdlUyU7hkD9LP5opu+S7fruN8ELZeY1V
 YUd0HbVcv+OAELP2vQoSMuu8slhHd70ItSTCa0NJY69+zYQ4PBPFBSRhqSusH+ZKOGH/
 kZbAPRzbfJ7ICuANrKTOIO7AntMpVR7cN2/XJBUYefVO8rwiOsFUh/ZgeGv3jRD5a5vY
 89Tk4XBOt9uUMpguKtZkAeIBqGsFKv/HtkIdqi6gNRI3zkln19mkz0Yb/zC4Vp5B3dnc
 sInjepD1hQe+WM8zsGllIORcJs+uMgXB0OUuoq1SxxcqAwDYBwu4JjblExT0Zoj8C2OY
 gc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207782; x=1779812582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l6iO5cCPGOYFPb3KVLbGSJQx31T0/SdzlJO8X3IH9zk=;
 b=aH4yYpwk3IhN+Zc/SS14mRyG6xuBTwaVaoGJRY7XSPSJlnHrum37BSpHhO/OXENssZ
 4c2CiHYwsZJnO+aT95ntLbMGX934OZcdR6cC3ei0YnMA86ZGEwhs3HDuixm7eDodPE+i
 XgPNTJJ9tDVZCZ5ksTq1We0+buOF5s3ONQ51+PWjKh8Z4ljKR+d2gJ0+95iTOP7ERm6s
 duQV70MENJaI3iGIT5n+nOwVcsnNsyVU4TWMbdRZFG5jIuQjEf9p80KfFrR3eaHTp+N8
 TBV2F2i3Nd0O4K9fg4k1JAcIpQZ56bKA6gv9fVy+gzxc2WjrsDGtUFw+YwpTdJfa5AED
 ZtHw==
X-Gm-Message-State: AOJu0YzaF0nQ2PHhrNQxIiqoOfvGAGRMbehhD/QL4m6Ccak+7/VzNTQJ
 HFCX/jSVDwU8NDlOzsD+PAW19LS6T8WJE9xjHc0afM8zuqnBX+wU7wwF
X-Gm-Gg: Acq92OGWoerluON/Y+C6jY0IY/AE1I4rmDXWBhzhoJxuzYCKDxgRyn3TTaaT62L+q2d
 2qyl7Q1H5pe63gp5z3mfpM5+G8hYzYHFY5UEthJ0zqmm9IQTr1XohGdZrluzF6BbRs35yu0dSSp
 WKq8oPdvndMNkcLabdvG7nzen8R7H230PQ0Jz/F2NQJlbgJOMz3TFKszYNrm1D6qhI4rdDFuzKi
 /t9ZMXPWSxABHJA5klh5qB/dxCSae1Vyk05ZaLF3Q4wcPJjfhnKmlNuLsrIhi+cnpwcqweh5Qth
 fbZ1JJV0hnxYncC45snOUnlf5UIqjiQbv6nAkry4ztMyThbIpSHVzrE5CEk5pUVQQ4vhWyubdVf
 U6whP1qms9KASzMUmebvoy/Hs4OxPQsWJnhfNbvUp+GmXdVwLjCykKSdxCoJSUqZpKHF9BSTLrn
 VSi4HZUiSPlK8Gh63j4kYu0DoTQEpNmNNV3lNZvqoVJNflJ0DmT2bZJy1t9ul/nejxfv/9SLDur
 jCy4zN7dNvKbPgcYiVHpLmVDm0NeZV2Npp7u5oFkYNkASeVo341/NrXp1uLQEc3E2Fm
X-Received: by 2002:a05:6870:3264:b0:42c:1ba9:c1c1 with SMTP id
 586e51a60fabf-43a2d90ade6mr13318656fac.8.1779207782206; 
 Tue, 19 May 2026 09:23:02 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:29 -0600
Subject: [PATCH v9 27/40] target/mips: add Octeon GFM COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-27-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2e.google.com
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

Use QEMU's crypto/clmul helpers for the reflected 128-bit carryless
multiply operation instead of carrying a target-local multiply loop.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split GFM selector operations into their own COP2 helper patch.
  - Expose per-operation helpers instead of a generic selector helper.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  2 +
 target/mips/tcg/octeon_crypto.c | 98 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e802f50fd6..dac9dd8755 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -38,6 +38,8 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index b79ccdd162..7394108c54 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -94,10 +94,108 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
 
     octeon_crc_set_state_reflect(crypto, crc);
 }
+static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
+{
+    uint64_t lo = int128_getlo(product);
+    uint64_t hi = int128_gethi(product);
+
+    while (hi) {
+        int bit = 63 - clz64(hi);
+        uint64_t shifted_poly = (uint64_t)poly << bit;
+
+        hi ^= 1ULL << bit;
+        lo ^= shifted_poly;
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
+    uint64_t vx = revbit64(x[1]);
+    uint64_t vy = revbit64(y[0]);
+    Int128 product = clmul_64(vx, vy);
+    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
+
+    out[0] = 0;
+    out[1] = revbit64(res);
+}
+
+static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint64_t in[2] = {
+        crypto->gfm_reflect_resinp[0] ^ crypto->gfm_reflect_xor0,
+        crypto->gfm_reflect_resinp[1] ^ data,
+    };
+
+    octeon_gfm_mul64_uia2(in, crypto->gfm_reflect_mul,
+                          crypto->gfm_poly, crypto->gfm_reflect_resinp);
+    crypto->gfm_reflect_xor0 = 0;
+}
+static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
+                           uint16_t poly, uint64_t out[2])
+{
+    uint64_t zh = 0, zl = 0;
+    uint64_t vh = y[0], vl = y[1];
+    uint64_t rh = (uint64_t)poly << 48;
+    int i;
+
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
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
+void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
+                                              uint64_t value)
+{
+    octeon_gfm_mul_reflect(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+    uint64_t in[2] = {
+        crypto->gfm_resinp[0] ^ crypto->gfm_xor0,
+        crypto->gfm_resinp[1] ^ value,
+    };
+
+    if (crypto->gfm_poly <= 0xff && crypto->gfm_mul[1] == 0 && in[0] == 0) {
+        octeon_gfm_mul64_uia2(in, crypto->gfm_mul,
+                              crypto->gfm_poly, crypto->gfm_resinp);
+    } else {
+        octeon_gfm_mul(in, crypto->gfm_mul, crypto->gfm_poly,
+                       crypto->gfm_resinp);
+    }
+    crypto->gfm_xor0 = 0;
+}
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E92C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t3-0004PZ-Cv; Wed, 12 Aug 2026 08:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sw-0004Au-K0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7su-0008Ub-Da
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so10115565e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536998; x=1787141798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HH1Tjck6mfsSFkv7E1jUghmyvA+pXIFCdFnWrXtnkGc=;
 b=nncm0BOOTfUlrcC+NADhGnUSmsaF2f2BVDB1HvXNlcaEJ5+FOOfSitN/sbphS/lgl2
 d2Dqhl+iljLDnU10dQWcvcOunxrKxyrthau+IDMAVAoMZemI/0cOGwqe9HLDpXyDxc0A
 B/IzJBxKegdGHWSvC2MoP37Bdq0pTk+GdVzAlmo2JwSiRBodNufgrYzH0pXbA6qvYVm4
 15O89SAXUDcJ5H6JIqC5eX9pM02z5CnMGjigAayQi+6GvO+vCDONkCmh+74K2AQgm3pg
 dFmyM458w0oySB9J9smTVLV1N1V1NKw8WpFWg+ySJ3s0aRNwOVPVEWMAcN/KViLEMRk+
 RWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536998; x=1787141798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HH1Tjck6mfsSFkv7E1jUghmyvA+pXIFCdFnWrXtnkGc=;
 b=BdhYptjhEmPfHs/k2IjnJsDp0kj9RJYQ/HuSATAtzmFrhQ0+jJ5aHKi50+QHw0ICeE
 gqtejInRHZFSSgkS29RwESTrXDFfIZK/jh+cULJhqS3YTBpzab0ZwtCOZN0v2c2NM6HV
 4kewg48JO2tmSi/PFv2oV8OaOCWq4svsQuwNXn7DfBRR1z6FJxVpZWzc4i7+1cE9eIZt
 3Rt/sYs5XdHP52LzhX/dIY/gNJjvQeQm7tUcKz9+lUETnIFCVkUdo7iditjeMeU/Xk3I
 SB5UCPMOi1L6f6OSl8Oi698zr4hD3yxSyOfvxHjOortgnZVAfUBo91aPfASJV9JwFuYK
 Alig==
X-Gm-Message-State: AOJu0Yx6eORaVO8S7pSspcOyKHftuh8cCcCu1LrpkLUGOw+FlNVPoqCO
 +nAxYUqjASyox3hQmQzQbv3NL8B7hsPHpWJK2e329HKZM9LcOm7ZD3y8Bndjz4WWIg/MIyw+gij
 ZTdW3
X-Gm-Gg: AR+sD10E95ymZQ7ctlmJu+pqlulQpEV5zXBGkx1QRc7GNzFg0GYovTgs+/Y+0b5yO+n
 ZJTqFS1H8tn2sB4b0nQOvh7r91TLDwWA8ySGNuu6XrKndlvhSyzEDhg7KYOKUh2wu9n4kYaULHR
 Ve495AfVWkpy/oFfDskaIcYLo489b2W9D2AUmUW5U27+jcgw9a6wLhRsJjdS3rVhl4dKCjTL9xf
 iFcJoI27rFe+GIgwOAJ8wLC0D9ov/WVSHHOVOWULfxbLgijb6J+ltu4UoFb35lw0+uocqfJoF6l
 1ApgxnTo2Mdnf+k7EiT9HX6aFTHjr9RUX4I1CUAP+tpgpnR+SQtqKk0v3YuHaG4RE+E5HUD/RYS
 ouUifKv9pAWGr0IVO1lMfqU7a8e0HU343aI3aRIYPD1T5YCzf35rMS+nkZ6sN92o60jzf98TMDZ
 sQbapw9YFPsJ2neFWvF5156ClnOwD5iPjs4fVCfwzx2J/Ko2a7WjyhvFGuEGr0ymvwF0AP67diS
 ahaUit3kM8/3UES1MDr252waTapPhW0WxFJ7mWHzGNavA2xCCdExCguV8D/vExootsogw==
X-Received: by 2002:a05:600c:1991:b0:498:162a:dbda with SMTP id
 5b1f17b1804b1-4997c0df1f7mr45531085e9.5.1786536998381; 
 Wed, 12 Aug 2026 05:16:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/26] target/arm: Implement [SU]TMOPA (2-way)
Date: Wed, 12 Aug 2026 13:16:04 +0100
Message-ID: <20260812121622.649730-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  3 +++
 target/arm/tcg/sme.decode        |  3 +++
 target/arm/tcg/sme_helper.c      | 12 ++++++++++++
 target/arm/tcg/translate-sme.c   | 21 +++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 8a959447b2..1de72b7472 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -411,3 +411,6 @@ DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fps
 
 DEF_HELPER_FLAGS_6(sme_bftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_stmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme_utmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index eab1f7e8fb..08036c60c0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1151,3 +1151,6 @@ FTMOPA_sh       1000 0001 011 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 FTMOPA_hb       1000 0000 011 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_sb       1000 0000 011 ..... 000 ... .... .. 00 ..       @tmop_o2
+
+STMOPA_sh       1000 0000 010 ..... 100 ... .... .. 10 ..       @tmop_o2
+UTMOPA_sh       1000 0001 010 ..... 100 ... .... .. 10 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 3d7aefac5b..951cbbf58e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -3123,6 +3123,18 @@ IMOP4_2WAY(umop4s_sh, -, int32_t, uint16_t, uint16_t)
 
 #undef IMOP4_2WAY
 
+#define ITMOP_2WAY(TNAME, MNAME)                                        \
+void HELPER(sme_##TNAME)(void *vza, void *vzn, void *vzm,               \
+                         void *vzk, uint32_t desc)                      \
+{                                                                       \
+    sme_tmop_2way_sh(vza, vzn, vzm, vzk, NULL, desc, inner_##MNAME);    \
+}
+
+ITMOP_2WAY(stmopa_sh, smop4a_sh)
+ITMOP_2WAY(utmopa_sh, umop4a_sh)
+
+#undef ITMOP_2WAY
+
 #define IMOP4_4WAY(NAME, OP, TYPED, TYPEN, TYPEM)                       \
 static void inner_##NAME(void *vd, void *vn, void *vm, void *vinfo)     \
 {                                                                       \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ceed864da8..abdf98a40c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2181,3 +2181,24 @@ TRANS_FEAT(FTMOPA_hb, aa64_sme_tmop_f8f16, do_tmop_fp8,
            a, MO_16, gen_helper_sme_ftmopa_hb)
 TRANS_FEAT(FTMOPA_sb, aa64_sme_tmop_f8f32, do_tmop_fp8,
            a, MO_32, gen_helper_sme_ftmopa_sb)
+
+static bool do_tmop_int(DisasContext *s, arg_tmop *a, MemOp esz,
+                        gen_helper_gvec_4 *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        uint32_t desc = simd_desc(svl, svl, a->idx);
+        TCGv_ptr za = get_tile(s, esz, a->zad);
+        TCGv_ptr zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr zk = vec_full_reg_ptr(s, a->zm);
+
+        fn(za, zn, zm, zk, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(STMOPA_sh, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_stmopa_sh)
+TRANS_FEAT(UTMOPA_sh, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_utmopa_sh)
-- 
2.43.0



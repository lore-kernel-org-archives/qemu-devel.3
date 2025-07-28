Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DB3C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSTi-0001DZ-2X; Mon, 28 Jul 2025 14:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPQ-0004rn-Gg
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:28 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPJ-0002oq-Q3
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:07 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af51596da56so3408221a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726624; x=1754331424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr+K2+F1aavaDbM6++RkYv5Mwqi57uFiJLafqJkzES0=;
 b=Nx6rB6E75v5GzD9EKPl9TB513gz2eRRTR2trhe6PGaBC7iufLyMVzaFkXiT/pcAQJQ
 OgX8u3i6PjHBmvZt3kzX9BBbYFrI7ZLjqYENua30iWFKmiM+4kLVNCTMUP3CYkcFfnLF
 /hx9D53e7gvP01UPUEaXEz4z3StBgO6e7SMONh3LuRa07Al5L6XS0INNkTD/OxZF6+gQ
 t31IxJwt23jJ0wEjFSa9D6iOby7IuIPUmNNAIiXPPxKoSwWfaTlEfX1sOUrbksgaGpll
 G2KILveMdN9USDPhfp7bJJmDGtkzpJDDARcH3fmXdpy/OCIJ8Eq7gEMPu5ygyIF5Ossl
 XhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726624; x=1754331424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nr+K2+F1aavaDbM6++RkYv5Mwqi57uFiJLafqJkzES0=;
 b=kKkkZ/+ncb5MMYaC6PTqNqcFRkwU1tcwQHhlLwgfQ+XnQho6VHt0j5cUAqtWD2HT9h
 VEkS7Qzoh3cgc+L36Ib1/+oox2ZIOp6+qIHAEPnO3hFS6ux/uJx3rq7kVXDWEs+UwDWw
 ETy1n7K69TrPCXeqXXmNuN4y65S4/L9dhJeN2+ouOZGB2kK5leecNTvAgxKcpz8rVqQE
 BDwUrITlujjxCGTqP30hSVlstTlDKcOnvJJyBQ7L5ZwV7FG0Q+/4XqpQcsbt7BAEAAa+
 nhkTrfq+b7xa8E8ikdMf05oXpbvBjUEYNJ87TI90egXaTHIF/Ucz+2Tj4nx5On257/55
 2vew==
X-Gm-Message-State: AOJu0YwTYc9SzDoYJ4hitk22p8v/GtsgssUi8qrioKZ963CRtAxYVfBK
 bgzLiKa6FcVHJUVez5/B5BTlopYN/8lqCpEFChxhjegtNT0pi5ktGOq6kPAR8xwBNzh9Fn1upAT
 WEnJw
X-Gm-Gg: ASbGncsENitXF4NTsy/irWXlWdRRtvO+ZVBJmrgctBSdjmFddcKJaIVOqjxii4C02I4
 WsmxK5zfWkdVltWOetZ1D8LtKtzjl7Bu2f5kYbFK2MzJxUiwPZKQudviexPJNKFd1h2VTNnCiSP
 ailu6jByNoQSgjaA4OqmRGLfTELEz5RVYTJVUKdyGT6ZV8LtxznmLC9+PD/opgbDKYL8i/MFP+Q
 12nDeQwCh4vG5NPr3xTr1JT2dHCqLqEtSYB0xbnoZfUg6LamtCCI+4sBAlKxk0yla5FVFG9q40H
 SdDOGsfSbpuY7fXc/obZnkl1E7VzIaIVMFQSUOat79tIwMxRgW3HXqt7UGvGG0Vcs0J7aFEANHV
 uZP0bbVY0yoaFingFxYXilIu3g2iN+dyHQlqNJ5YvUdjVMLTwEXR3T4v5y1S3oC5nAGi3U5ns3d
 zR0rO9De44jA==
X-Google-Smtp-Source: AGHT+IFy/UFTiN+jriuQqkC7rXA7gRp26m5ppAA+bmGT18lgeD09Mzl2XeRRVwl/jHUO4PnyP7MFJw==
X-Received: by 2002:a05:6a20:6a09:b0:234:cd25:735 with SMTP id
 adf61e73a8af0-23d701d6270mr20307773637.38.1753726624023; 
 Mon, 28 Jul 2025 11:17:04 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:17:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 7/9] target/arm/sme: Unify set_pstate() SM/ZA helpers as
 set_svcr()
Date: Mon, 28 Jul 2025 08:16:48 -1000
Message-ID: <20250728181650.165114-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Unify the two helper_set_pstate_{sm,za} in this function.
Do not call helper_* functions from svcr_write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-8-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 5c922ec5b136b452fe9d21e7581c99554ce650ed)
---
 target/arm/helper-sme.h    |  3 +--
 target/arm/helper.c        |  2 --
 target/arm/sme_helper.c    |  9 ++-------
 target/arm/translate-a64.c | 10 ++--------
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/target/arm/helper-sme.h b/target/arm/helper-sme.h
index d33fbcd8fd..d22bf9d21b 100644
--- a/target/arm/helper-sme.h
+++ b/target/arm/helper-sme.h
@@ -17,8 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-DEF_HELPER_FLAGS_2(set_pstate_sm, TCG_CALL_NO_RWG, void, env, i32)
-DEF_HELPER_FLAGS_2(set_pstate_za, TCG_CALL_NO_RWG, void, env, i32)
+DEF_HELPER_FLAGS_3(set_svcr, TCG_CALL_NO_RWG, void, env, i32, i32)
 
 DEF_HELPER_FLAGS_3(sme_zero, TCG_CALL_NO_RWG, void, env, i32, i32)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bc1c5a1f17..cd501929d7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6469,8 +6469,6 @@ void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
 static void svcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    helper_set_pstate_sm(env, FIELD_EX64(value, SVCR, SM));
-    helper_set_pstate_za(env, FIELD_EX64(value, SVCR, ZA));
     aarch64_set_svcr(env, value, -1);
 }
 
diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index bbda651974..3b7c6cd317 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -29,14 +29,9 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
-void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
+void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
-    aarch64_set_svcr(env, 0, R_SVCR_SM_MASK);
-}
-
-void helper_set_pstate_za(CPUARMState *env, uint32_t i)
-{
-    aarch64_set_svcr(env, 0, R_SVCR_ZA_MASK);
+    aarch64_set_svcr(env, val, mask);
 }
 
 void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fa568aa647..9830fe70cf 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1861,14 +1861,8 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
 
             if ((old ^ new) & msk) {
                 /* At least one bit changes. */
-                bool i = crm & 1;
-
-                if ((crm & 2) && i != s->pstate_sm) {
-                    gen_helper_set_pstate_sm(cpu_env, tcg_constant_i32(i));
-                }
-                if ((crm & 4) && i != s->pstate_za) {
-                    gen_helper_set_pstate_za(cpu_env, tcg_constant_i32(i));
-                }
+                gen_helper_set_svcr(cpu_env, tcg_constant_i32(new),
+                                    tcg_constant_i32(msk));
             } else {
                 s->base.is_jmp = DISAS_NEXT;
             }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0A8C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag1R-0004yH-Qb; Thu, 15 Feb 2024 12:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag14-0004Wv-Hz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:23 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0w-0001jy-Mt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:59:22 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d0fd07ba8bso13657991fa.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019952; x=1708624752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KRNAN7J6jVrW+a5YkWZvl2JIbNfjxd3JGHRrNe6AUc=;
 b=XwckSceFGVkZ5LLhJ+dnl+6hw9goj7dHawTxXt8MhWaOJ/0EVV/R7XCVpeRzEja8+D
 uMVxDtGZooeYAR71+3Mj13ETEbwG9eRyEGs5byjkJGV7x8XS5X5H9kT8W0YOR79GFMdS
 ZdQ+bOAm3bzA82my1ye1Ov8jq7TM8aJve9QhDtqnRmlKU1iqHlhmJ594aQw0Ye1+XbXn
 viVA2/P6s0T0SIzftbff8Oyj0aomOn2i8QmHjA5IcK4hpqVV6rL8x3Q+runs1FIJmWk1
 ezwElO45+IcNVzm8hbaddoAUkJYs8+drb9BWcqNchvGzscf3mkuztvJ96HXPqDvx0i5N
 2sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019952; x=1708624752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KRNAN7J6jVrW+a5YkWZvl2JIbNfjxd3JGHRrNe6AUc=;
 b=u48TqCNgALL9didzSrLo0JAZo/sEH5FUhffdLUINWPoGm6ylXqZZNH55TuK0JLA8fS
 Xn71FH03/mKaPnezD9+o/ZsAzgnibf4m4IhJD9QbWp1CnGHMj+pqpsvwf8/EKxBkE04w
 HPPzoxoWdJcX054nbvQVJC/97HttSyavlrhSaJop01XhQ0Ag78vikelw5KnV4NbODgcZ
 Hx5p3x8qRrYtWEbMhZmENbwsJTMVBjREo1F4CzOE/5xmhVgknod5v9W36JH5KglHTqvE
 dMHLtfhPs4+FmVcoc4yLzguqa1wNZYUyaycOLNrsJe02EV/jDKykdf48Dd0R7dLdTnXD
 F7wQ==
X-Gm-Message-State: AOJu0YxoxoJCQvZOtei5GDN8lLVjgGJekiFUJO40f1nS2pb4IxnwgJdf
 HGMi0MX/CcANlnJ2dsB/Kk4zLLq/s3H6PvoUEw5c7DXRtdyaM5lSUVO0TcU4wTeVH8N+vhwsv7x
 3nVU=
X-Google-Smtp-Source: AGHT+IH3/9vfy51nEfjPBJcvZnTjuHpLd3xnzU+bNsH4pJmDzZXEZv1HebGRW9cW2tNttpIwoFOlqw==
X-Received: by 2002:a2e:8018:0:b0:2d0:d3ec:a545 with SMTP id
 j24-20020a2e8018000000b002d0d3eca545mr1850052ljg.50.1708019952746; 
 Thu, 15 Feb 2024 09:59:12 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b00410ab50f70fsm5604008wmj.15.2024.02.15.09.59.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:59:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 12/56] target/mips: Remove helpers accessing SAARI register
Date: Thu, 15 Feb 2024 18:57:06 +0100
Message-ID: <20240215175752.82828-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

DisasContext::saar boolean is never set, so this code
is not reachable. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-9-philmd@linaro.org>
---
 target/mips/tcg/sysemu_helper.h.inc |  1 -
 target/mips/tcg/sysemu/cp0_helper.c |  8 --------
 target/mips/tcg/translate.c         | 20 --------------------
 3 files changed, 29 deletions(-)

diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index 78f7272208..1861d538de 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/sysemu_helper.h.inc
@@ -100,7 +100,6 @@ DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
 DEF_HELPER_2(mtc0_hwrena, void, env, tl)
 DEF_HELPER_2(mtc0_pwctl, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
-DEF_HELPER_2(mtc0_saari, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
 DEF_HELPER_2(mtc0_compare, void, env, tl)
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index f8883a3515..ded6c78e9a 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -1077,14 +1077,6 @@ void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
     cpu_mips_store_count(env, arg1);
 }
 
-void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
-{
-    uint32_t target = arg1 & 0x3f;
-    if (target <= 1) {
-        env->CP0_SAARI = target;
-    }
-}
-
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 173b19a090..3ba2101647 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5653,11 +5653,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6374,11 +6369,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(tcg_env, arg);
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mtc0_saari(tcg_env, arg);
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7143,11 +7133,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7850,11 +7835,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(tcg_env, arg);
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mtc0_saari(tcg_env, arg);
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26CED3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7W-0002kW-Ao; Tue, 26 Nov 2024 09:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7M-0002hv-Ui
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7L-0005A0-3O
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:40 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38248b810ffso4296064f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629637; x=1733234437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kF7mSY0O5qPkOg956lvsP5sIb9mfyEZh01tqlgPBlGA=;
 b=joXi0HUUj9ymuxWCtB/d2OIr7sr3AoXcNtCaqLpaDs0N8mtRBA06ksKfhQcOHaa9A5
 4gpCjZwrlvSA5pSv+lLmUEt+cF8OoELbnhhXWHX5rM7mDwqlvDFb6s7Rp2QaZY+tsji9
 WdFGotHFrBdXrZhK0ZCxRQMsM2aci8RO5bKrD1i7w7CzCst0rLForC0nmvLsFfdNTQQR
 Ho8sMdWB9aXvJaDGQ+hvSM+UdKDkJDlzeMPcul8xkSQSvA0/lpVHtVRDey6vphigbmKs
 JILLS/o5GWPkakNwgvF5So5skQuv3ZoI13Hksa9leoYJ9oFbyYVzvcma56jxx8gvYqye
 vmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629637; x=1733234437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kF7mSY0O5qPkOg956lvsP5sIb9mfyEZh01tqlgPBlGA=;
 b=wuXVz2Az4CzdzdV5p/cMHW0Y+q50sRcYOSbQqjHrSzpgkdsQsEgKNAWf9UGV6T80uu
 KltqS+702ocMRQ6utDaroy6U6GzzIV7TDnpgRr7vn85TnrneiAoM80Ht11tqZvjvRUk0
 MxLxnizPVJmxgjACR2GRbe/AXpNecsUGoM16BoFKMZWhkLhwBCou2ccX65bRSpY9y2Ra
 TBp6hBjX39pzhYTwCRkGX6ckg2iPADHrnht8WTJ+t8Xr6qDbM+dR5LIlVfSamdy/qU3Z
 bjPsu1wKokXarJPiESkPijjxO4rxE0PyLAZbIfI8Av/xj6wp2zQB4p5XwB7bEP5ZQLY3
 OS8w==
X-Gm-Message-State: AOJu0YxOxc5NuEk3bcG9Qw1ctti2YlE1nlEKZwo4ee0GiUDlKb1qfSDi
 lAbHlyPT04XfRXwV4nrJE3p40KBmSspGnX2ZE0F0ix3nLelayzMmqz18nhS8AOspuwHG9EAl7aH
 U
X-Gm-Gg: ASbGnctTDDEaoMSfhOa4YQim2tpC+rsW6K5Ji0h1jHGjC0aWeDzGuKCOgsOvTBqoRpi
 qPky0WrRGTObBqhaAcGxThaV3W9xkKP/aX4ngD1sm9sy7vrmrQtZEUK0fhoS93wduWBJiNdQbZB
 bG9igNvacT83YfA8PDXvb2Jnm2jjX3FVHXE8Aw3KZ94KP8+rv7qDTCINI+HLCjKWODoYsBar4/1
 SFstJGjFhoIRu6W79lSPM/9fCWn3He7d4UsPrZXMv+X3XviAdUoirnASBlE8m0Ogqy1vo8HPNa7
 OA==
X-Google-Smtp-Source: AGHT+IFm/IDoGEGKvaso/ogCqBYs5W0ZwhEdK9UiVokaHapcYooc8g8vHBNaNk5zkVgwloIipGA3pw==
X-Received: by 2002:a5d:6d08:0:b0:382:4a66:f517 with SMTP id
 ffacd0b85a97d-38260b452e2mr13627856f8f.4.1732629637050; 
 Tue, 26 Nov 2024 06:00:37 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a6459f0dsm24286725e9.23.2024.11.26.06.00.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 05/16] target/mips: Have gen_[d]lsa() callers add 1 to
 shift amount argument
Date: Tue, 26 Nov 2024 14:59:51 +0100
Message-ID: <20241126140003.74871-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Having the callee add 1 to shift amount is misleading (see the
NM_LSA case in decode_nanomips_32_48_opc() where we have to
manually substract 1). Rather have the callers pass a modified
$sa.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-4-philmd@linaro.org>
---
 target/mips/tcg/msa_translate.c           | 4 ++--
 target/mips/tcg/rel6_translate.c          | 4 ++--
 target/mips/tcg/translate_addr_const.c    | 4 ++--
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 target/mips/tcg/nanomips_translate.c.inc  | 7 +------
 5 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 75cf80a20ed..82b149922fa 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 59f237ba3ba..363bc864912 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -23,7 +23,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -31,5 +31,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
 }
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 6f4b39f715b..1d140e918da 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,7 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa + 1);
+    tcg_gen_shli_tl(t0, t0, sa);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
@@ -47,7 +47,7 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa + 1);
+    tcg_gen_shli_tl(t0, t0, sa);
     tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
     return true;
 }
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 98a00125520..26006f84df7 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1795,7 +1795,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             return;
         case LSA:
             check_insn(ctx, ISA_MIPS_R6);
-            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
+            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
             break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 6ee0c4fca3b..e0a920bdb3a 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3626,12 +3626,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
             case NM_LSA:
-                /*
-                 * In nanoMIPS, the shift field directly encodes the shift
-                 * amount, meaning that the supported shift values are in
-                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6).
-                 */
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) - 1);
+                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
                 break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
-- 
2.45.2



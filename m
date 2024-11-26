Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81778D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvQU-0008DY-0X; Tue, 26 Nov 2024 08:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQS-00087Y-Ny
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:20 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQN-0003bV-SM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:19 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3822ec43fb0so4326650f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626974; x=1733231774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oAuoX6wuxWz3vmPjCvqWsYQJc7jnJ87JuaD5eKYWgM=;
 b=titvYtcDRrOCtA2UbSRBHCDHN4TxOsYVOh6XlNELgQms3239YbCkCGCOOsK6tWGDd9
 uT8uIp5/mAolX87IVyEiLioe4uKMwsVkumpZxhpK3J6W8SjHfOjerito98VJhpW50Dy9
 b6aHnp2dYDet+foq+BkyIp+L4hV4nb0jj4FA7mykubvTdpEJ5Qj3rK8NUApb8rjGn5Ki
 PQ767ZJrk4wpzH2zITUWTysoO0lhr+I1jnf13CLiZDBUphbakjTTHovFQdOj+SSzmIPG
 JBQP3Sbyn8TlOC1A60CFKh8NCJocv+kvUkXPVMDkymrtNRp4AOgHM6F6L2QmzGOraEDA
 nMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626974; x=1733231774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oAuoX6wuxWz3vmPjCvqWsYQJc7jnJ87JuaD5eKYWgM=;
 b=HeNxwRiFKkWsVSPEZix97t4Pjun76AMILW+jLl1Au9v76yFF+PTLM4bcV9fEXc2ajE
 Ve9lDs7W/LvYLgTr0qgS1UNoIMcE7Z2f0m3HSLWeoNLZLoWiXHUMfecqySD+x7QESmYT
 UcJN+f+lwILqbLC519YCJl3vDdW7Z8cHWo934VYDfOSlsmCcqCJz/Whvo23DHc33zUVd
 SoDgb4sKVP5LAO2x3riEf8G6Kr1nmwLASilN0+DCp1htOPI0HNDG7EL+i/ORzlVp5o/u
 fR+cGfmYWcMhkW1rIrZbsEBDQfUt9KfuLHO8D5oiH+9vn0iHLNddljD/LS8iAmWsrc5p
 ZKcA==
X-Gm-Message-State: AOJu0Yw5zoL3Byz52/EnQgV2c/yQCfcEPkgFOyai9AZlMDHTcg3MSUog
 DKqkLVaMODDXH6+cU22m/xQ9Is3j5HutA9EEcWV9ufnBkheNCOm0VV8dOxVbunQh/4s9mS4df4N
 t
X-Gm-Gg: ASbGnctZDyHSEVoQ+MieYMjjnUM+StQr2lmPZnwvOCnvMPgRge6EbJnuJxqYQQXedUf
 5HHE0VxOZOS8BCj3tRbpUYKMXfjJMMdVUmmjLTemvoBlIhSzYyf8WsJfUUx/6+Niop5DcqueiVc
 oEExS8OQduoHnwbvaGXexHyKXV5r7niSQL4svRxwZS0Hj1JDXEWpVX0VmrjDjWwLZYd5iKgxgBa
 +iUhgZw3E/KIWgvb5gwDveHF3BoFOxwYWGs3HPbb27hxGkPCJn5qpnUUE7aOsleQhC50QAF
X-Google-Smtp-Source: AGHT+IGGXZ9bRopaNI9ttg7m5cBaEgZ050iMO81mMejaXgjReQ2ymfXEOvIQ2gSMzV+YRU9djZcL1w==
X-Received: by 2002:a5d:5f47:0:b0:382:542d:39ab with SMTP id
 ffacd0b85a97d-38260b449f2mr15672781f8f.3.1732626973871; 
 Tue, 26 Nov 2024 05:16:13 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad61b0sm13546159f8f.7.2024.11.26.05.16.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 04/13] target/mips: Rename gen_move_high32() ->
 gen_move_high32_tl()
Date: Tue, 26 Nov 2024 14:15:36 +0100
Message-ID: <20241126131546.66145-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

MIPS gen_move_high32() takes a target-specific TCGv argument.
Rename it as gen_move_high32_tl() to clarify, like other TCG
core helpers.

Mechanical change doing:

  $ sed -i -e 's/gen_move_high32/gen_move_high32_tl/' \
     $(git grep -l gen_move_high32)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h              |  2 +-
 target/mips/tcg/mxu_translate.c          |  2 +-
 target/mips/tcg/translate.c              | 14 +++++++-------
 target/mips/tcg/nanomips_translate.c.inc |  8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 6437180d891..90b8ac0e5b1 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -154,7 +154,7 @@ void check_cop1x(DisasContext *ctx);
 
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
 void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
-void gen_move_high32(TCGv ret, TCGv_i64 arg);
+void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
 void gen_store_gpr_tl(TCGv t, int reg);
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 94aa137cb25..20b8314b478 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -4386,7 +4386,7 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
             tcg_gen_add_i64(t3, t3, t2);
         }
         gen_move_low32_tl(t1, t3);
-        gen_move_high32(t0, t3);
+        gen_move_high32_tl(t0, t3);
 
         tcg_gen_mov_tl(cpu_HI[0], t0);
         tcg_gen_mov_tl(cpu_LO[0], t1);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 5e776136f09..31907c75a62 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1462,7 +1462,7 @@ void gen_move_low32_tl(TCGv ret, TCGv_i64 arg)
 }
 
 /* Sign-extract the high 32-bits to a target_long.  */
-void gen_move_high32(TCGv ret, TCGv_i64 arg)
+void gen_move_high32_tl(TCGv ret, TCGv_i64 arg)
 {
 #if defined(TARGET_MIPS64)
     tcg_gen_sari_i64(ret, arg, 32);
@@ -3342,7 +3342,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
             gen_move_low32_tl(cpu_LO[acc], t2);
-            gen_move_high32(cpu_HI[acc], t2);
+            gen_move_high32_tl(cpu_HI[acc], t2);
         }
         break;
     case OPC_MADDU:
@@ -3358,7 +3358,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
             gen_move_low32_tl(cpu_LO[acc], t2);
-            gen_move_high32(cpu_HI[acc], t2);
+            gen_move_high32_tl(cpu_HI[acc], t2);
         }
         break;
     case OPC_MSUB:
@@ -3372,7 +3372,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_sub_i64(t2, t3, t2);
             gen_move_low32_tl(cpu_LO[acc], t2);
-            gen_move_high32(cpu_HI[acc], t2);
+            gen_move_high32_tl(cpu_HI[acc], t2);
         }
         break;
     case OPC_MSUBU:
@@ -3388,7 +3388,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_sub_i64(t2, t3, t2);
             gen_move_low32_tl(cpu_LO[acc], t2);
-            gen_move_high32(cpu_HI[acc], t2);
+            gen_move_high32_tl(cpu_HI[acc], t2);
         }
         break;
     default:
@@ -3483,7 +3483,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
             gen_move_low32_tl(cpu_LO[acc], t2);
-            gen_move_high32(cpu_HI[acc], t2);
+            gen_move_high32_tl(cpu_HI[acc], t2);
             if (rd) {
                 gen_move_low32_tl(cpu_gpr[rd], t2);
             }
@@ -3505,7 +3505,7 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
             gen_move_low32_tl(cpu_LO[acc], t2);
-            gen_move_high32(cpu_HI[acc], t2);
+            gen_move_high32_tl(cpu_HI[acc], t2);
             if (rd) {
                 gen_move_low32_tl(cpu_gpr[rd], t2);
             }
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 5a4a64f3609..b78381bcf54 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1817,7 +1817,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_add_i64(t2, t2, t3);
                 gen_move_low32_tl(cpu_LO[acc], t2);
-                gen_move_high32(cpu_HI[acc], t2);
+                gen_move_high32_tl(cpu_HI[acc], t2);
             }
             break;
         case NM_MULT:
@@ -1872,7 +1872,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_add_i64(t2, t2, t3);
                 gen_move_low32_tl(cpu_LO[acc], t2);
-                gen_move_high32(cpu_HI[acc], t2);
+                gen_move_high32_tl(cpu_HI[acc], t2);
             }
             break;
         case NM_MULTU:
@@ -1933,7 +1933,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_sub_i64(t2, t3, t2);
                 gen_move_low32_tl(cpu_LO[acc], t2);
-                gen_move_high32(cpu_HI[acc], t2);
+                gen_move_high32_tl(cpu_HI[acc], t2);
             }
             break;
         case NM_EXTRV_RS_W:
@@ -1974,7 +1974,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_sub_i64(t2, t3, t2);
                 gen_move_low32_tl(cpu_LO[acc], t2);
-                gen_move_high32(cpu_HI[acc], t2);
+                gen_move_high32_tl(cpu_HI[acc], t2);
             }
             break;
         case NM_EXTRV_S_H:
-- 
2.45.2



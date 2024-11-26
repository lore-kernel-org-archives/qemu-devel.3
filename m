Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A69AD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7i-00037b-KY; Tue, 26 Nov 2024 09:01:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7T-0002mI-52
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7R-0005BV-5U
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:46 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-382456c6597so3971856f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629643; x=1733234443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEVLJev568HOMNbO3XAojoNPEMi8j/7b1TkH5RlPnXI=;
 b=xBaU9O9T1pjvMBCmbPDIl6k3A+4buPKUl541txwOo2TV0zjlXz/cXGB0Y6a1BsrzDV
 fXjcm/wVs18SJiEQKmIWs5yw83splQEl5a+7V71S4mFMdR8TdM/nSpOl5jqNVb6Dkmeu
 w++1oQO2Ml2aHfdHtNb129NOQMBSIev24dS6T0SseAgbq8qQU0o0bwvkwFZfeIFrxQeo
 p/kkhXVRBI/e26/k02P1SzmlqjUrZCsJ2+uFsFIJ2uO+Y0La8yqxvY4TEWMyKAu8VvpB
 bHVjeaxYIx0A91wcPR7yICMClqGs3zWLDh3s+DAwdE5HqkYaAXpEwILJAPF6f+RndlDR
 WFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629643; x=1733234443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEVLJev568HOMNbO3XAojoNPEMi8j/7b1TkH5RlPnXI=;
 b=FZs+t8oQoOn1xxtGRXpj693yeI5dwjK4QcYV3+ZYpWT0WowEMgXPFqYxP/WYJ8nep6
 1WgVsp7lARuCaIf2ihuwMSPPdDrL+yc31enG1/mpIfhkWqo+e5qJCdQPIaaPcRJ4trDV
 oLvz3t6c0UrpXIP3/WrgsuQaH/A4EOpmzmLgp/W0xrRMkMwLi2TfedfT+TXOvpyzuSTl
 pCujUGFiKTE50zJBUXNRd8RCHrGVGRe8yFkKEX58M8WiNGicT81/BpIz01K2Ybbq8a/K
 wmn6iaqGo1c4uYpjvsJtzhhtYK7i6tsbkjSFCfodBvJNLSFdHeDlofdYa98jLAnwQHZg
 4udw==
X-Gm-Message-State: AOJu0YwRkxQf1NVp5NTWji+MC4NSnPlUSHct7/yAKN3G4LkcJx+2EoKk
 robWpWJaFFCN5hp23jdN958RdQIZR8h7ICvNexIzy3+YErJ1WDl34wHIpFsXKKJhm5OSw32BMRu
 D
X-Gm-Gg: ASbGncvjP5lZBqQ3yUK3cjJDP1XH5t6QOzJta2aX0kh3qPTpPwDJmO/4c/LOGBBK03X
 a7/DkAWUfnifE2I100j7dB01Nwe6u5DW7s0V7g/eLFWJI53kKG2ZhM+pSCicAPnSapCQpKZQC2W
 7mUFyDc7aRrhj38zbBNgbr4xmpwFKFKZ+2mWIkGlScXxMPa4+O2Rsoro3XDqFeLhzQlieZodhPz
 mwxzV90ojMgx/VetidabtvfjyPSZRO2La6BkB0WwqjeMkn684jddhZFXVypyCeE9TFA6UvQeCT7
 og==
X-Google-Smtp-Source: AGHT+IF8kFTTl5rAY6Enfwr2U4H6BNvLR5rSMmDb36mA4IbkheUHfbNNYqSg0upLKcd+EMvMoeOCog==
X-Received: by 2002:a05:6000:2ce:b0:37d:446a:4142 with SMTP id
 ffacd0b85a97d-38260b867a5mr13129310f8f.32.1732629643128; 
 Tue, 26 Nov 2024 06:00:43 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe98asm13274224f8f.39.2024.11.26.06.00.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 06/16] target/mips: Decode LSA shift amount using
 decodetree function
Date: Tue, 26 Nov 2024 14:59:52 +0100
Message-ID: <20241126140003.74871-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-5-philmd@linaro.org>
---
 target/mips/tcg/msa.decode       | 3 ++-
 target/mips/tcg/rel6.decode      | 4 +++-
 target/mips/tcg/msa_translate.c  | 4 ++--
 target/mips/tcg/rel6_translate.c | 9 +++++++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
index 4410e2a02e1..798e8c401ab 100644
--- a/target/mips/tcg/msa.decode
+++ b/target/mips/tcg/msa.decode
@@ -21,6 +21,7 @@
 &msa_elm_df         df  wd ws       n
 &msa_elm                wd ws
 
+%lsa_sa             6:2  !function=plus_1
 %elm_df             16:6 !function=elm_df
 %elm_n              16:6 !function=elm_n
 %bit_df             16:7 !function=bit_df
@@ -29,7 +30,7 @@
 %3r_df_h            21:1 !function=plus_1
 %3r_df_w            21:1 !function=plus_2
 
-@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
 @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
 @bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
 @bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index d6989cf56e8..a9031171b54 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -16,7 +16,9 @@
 
 &r                  rs rt rd sa
 
-@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+%lsa_sa             6:2  !function=plus_1
+
+@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
 
 LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
 DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 82b149922fa..75cf80a20ed 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 363bc864912..2522ecae2ba 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -11,6 +11,11 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int plus_1(DisasContext *ctx, int x)
+{
+    return x + 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-rel6.c.inc"
 
@@ -23,7 +28,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -31,5 +36,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
-- 
2.45.2



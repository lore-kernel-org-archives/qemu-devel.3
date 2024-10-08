Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A2CEFC42
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJh-0007Y5-NL; Tue, 08 Oct 2024 14:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJS-0007SR-S9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJP-0002Uc-G9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:52:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71df8585a42so2548693b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413515; x=1729018315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=421LbBczhN+7djkIM+80LiuWG1ET4qxsB+bV+/jUDAA=;
 b=o80o3xZQf0wmvDB/S97KNbXeaGPVjYVQev31/7sOBubGp77Z5Eg1XHZXHG634I/Awj
 1Okoh0mZP0MtVh/BGfwDeDLX2nNIdY7+GWcyxzA37yNj4r10484XAYNoJk6gJSxo9KrM
 SSEkJclqRT6hZyIJqR6UxKkvQTOqSygedJQvfZoxV2nWLUNKEmS/N9jlGBmBmvtk2ajc
 Jk+zbPYrdl+tyNDXXew6fIACzQWGpGwCdZRiGxvzOuxgyNojjjUi9KSN4kY/0na4Y5pc
 9ofIV5STK7RNCk8t5QG5KPxVk0fZkWJr8oXM8br8OkywKg9DfjXiYIc2M4U2/IwrFGuP
 /xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413515; x=1729018315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=421LbBczhN+7djkIM+80LiuWG1ET4qxsB+bV+/jUDAA=;
 b=pUXmj+S4/NuM69leVuPVCyU2vk4nBrkziaYuS2sRnMlmlqDesFjV9H9Des1XZMYK2Y
 ewTTwAEBaqSKueM80KuhVFzknAx0OoOoDOtGa90EnpPWJYxQL5qleF6+A4Rh+H/ICfFH
 P4d8aRv1FHHuJZW2lXUEfyirdhpBoflnt0W2RNzA1HIUqJhNm66laq6pzZfI5kuZR5P8
 BFO8ecW3dNzxWT6NGdC1k2MipgAN+R6uCH0b0nzN00M6FWE6eIvhyk7HaghNbkaRp4fh
 zsby5uW8Yw0PgGExUEHUFWn464hE7GVO3x/SScAbhD5KqsT24zmDJT9ylCTNI+hdtlK+
 hJgA==
X-Gm-Message-State: AOJu0YzOf/6xuKXJZuSRuznNH6zHqEkbdraN+Se89rRPQXvDP16Osvxo
 MeBiaAYFtHn6EzarYHDTH0qo2OeU2fEU2L+JDUAR1uWtQTBvPwv/lJHwnQXaLlnpGHXLJWP1IT+
 V
X-Google-Smtp-Source: AGHT+IFIqfSlo7K5fV0qmuQGX5zZ3paHeLNylBm779/MEKKiozPHCSLty7GokoI2bFW6wsyH3BBUvQ==
X-Received: by 2002:a05:6a20:c709:b0:1d2:bbd9:4646 with SMTP id
 adf61e73a8af0-1d6dfabb7bfmr25353858637.38.1728413515383; 
 Tue, 08 Oct 2024 11:51:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/14] target/m68k: Always return a temporary from gen_lea_mode
Date: Tue,  8 Oct 2024 11:51:40 -0700
Message-ID: <20241008185141.20057-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Returning a raw areg does not preserve the value if the areg
is subsequently modified.  Fixes, e.g. "jsr (sp)", where the
return address is pushed before the branch.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2483
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240813000737.228470-1-richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 445966fb6a..ad3ce34501 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -720,7 +720,9 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         }
         /* fallthru */
     case 2: /* Indirect register */
-        return get_areg(s, reg0);
+        tmp = tcg_temp_new();
+        tcg_gen_mov_i32(tmp, get_areg(s, reg0));
+        return tmp;
     case 4: /* Indirect predecrememnt.  */
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
@@ -747,20 +749,23 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         switch (reg0) {
         case 0: /* Absolute short.  */
             offset = (int16_t)read_im16(env, s);
-            return tcg_constant_i32(offset);
+            break;
         case 1: /* Absolute long.  */
             offset = read_im32(env, s);
-            return tcg_constant_i32(offset);
+            break;
         case 2: /* pc displacement  */
             offset = s->pc;
             offset += (int16_t)read_im16(env, s);
-            return tcg_constant_i32(offset);
+            break;
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(env, s, NULL_QREG);
         case 4: /* Immediate.  */
         default:
             return NULL_QREG;
         }
+        tmp = tcg_temp_new();
+        tcg_gen_movi_i32(tmp, offset);
+        return tmp;
     }
     /* Should never happen.  */
     return NULL_QREG;
-- 
2.43.0



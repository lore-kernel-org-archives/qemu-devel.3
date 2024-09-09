Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F9CECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBl-000426-HY; Mon, 09 Sep 2024 13:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBi-0003vo-K7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBf-00060B-Kd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2059204f448so37835715ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902906; x=1726507706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=421LbBczhN+7djkIM+80LiuWG1ET4qxsB+bV+/jUDAA=;
 b=klznt2Z71KXb3dqIFMYhEihMYsuCsMLQiNjNDWUNvrgPa7O/5RyHx8umZgivHbGezi
 5e9XG1dYJAxohcAeRR+0cEMm3iJhmYRmz4gMY7aN9Rty/4ipYXanllchThwjcfsKzpwO
 wwvUvhKpxoa9c4eA5abgvRXJy6fLET6rYO81/ozBgHhmozgweqWBtbu8azpj3OchZkEm
 NMZQxlPYRI+Mru2F07fEzq8nVYEPDt0ZllocAswFkRCTr59cyUMlBB/7zfQrTsn4Za7A
 fDuUJOSDUQcvHnD3RCIpLyASGOd5ZJQSciM4NB7KX/GJA2CVAXbbmciU/bux+BYKKI/j
 rr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902906; x=1726507706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=421LbBczhN+7djkIM+80LiuWG1ET4qxsB+bV+/jUDAA=;
 b=t3crpngO4H4UTimnjrcP2TcX3yJNBMYkV0WRlPSmsr8MKSb23NP2UAhilrhk5buZ4s
 6uO2Twvjr4r08HSt7s15RwjBCb+td51AiJ9UbFHsB123hMwLh4JJbMxt5mPf+jeU1OdD
 rmipCctbmmF/weKQqvAAtmGjnN9LbmXcJAlC42mndr/fsdqTqRsYhVKvGSflwkpeGSA7
 EXTYr76lRxWJRL84pujHpOjXYK8qWPaPId0rddHN/jjb1XYNFDsFaODK2w5ds3aniD64
 GDi7S8gav/l5MI6/FxGHpdGVzwsnWCD/kzkmOC0ZBozmc77YQX/hQvI8dKYjnyRnkE70
 fJsQ==
X-Gm-Message-State: AOJu0YxQRCO58ygwLl1IQQt9PDsQWbdsJyaTvngLdaXC08aUMafrqDpv
 ZErRpzeWkDJWdsXiPqSCmcFt3YKocbmeCBYUu5iL5n4oHS+VVeSIbJLk5zVrUu9ID449KaC3wsr
 p
X-Google-Smtp-Source: AGHT+IGLhJLMt7eUmLZzk4JHabGBqk9QCHeUhmEWzn5gUOYZNu0OLicrjWerdp34QRZlojIwfkLWgQ==
X-Received: by 2002:a17:903:947:b0:1fd:67c2:f975 with SMTP id
 d9443c01a7336-206f056f059mr169959365ad.29.1725902906018; 
 Mon, 09 Sep 2024 10:28:26 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/26] target/m68k: Always return a temporary from
 gen_lea_mode
Date: Mon,  9 Sep 2024 10:27:58 -0700
Message-ID: <20240909172823.649837-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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



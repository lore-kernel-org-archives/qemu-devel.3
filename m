Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C278C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyn-00057R-3q; Fri, 03 May 2024 11:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyY-0004Wg-MD
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyX-0002o7-0m
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:30 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso1369678466b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750647; x=1715355447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7vgoVsqHzfmK76y1aCdJ7NQoyMwbf/Tg31Ldi1SHrk=;
 b=fjDJ1eaREp8S61eKv6ySeGpdsOO6aZoAXuH6+TU+rkyZtdwFJQdwuiNnWAA4GyqyEi
 eztYD9FjHQfRUNK13XJlXcna4R9KhE51WlRfL7c+mlvj46bRncNvFbz/32LbdZAtwS0k
 l2jeGR5MPlYLcybJMnPeRAOEh0NofHIBOaXiTP2n0J7dbTSFfU5n7lW9oI5qyHOHhksL
 e/mAvS7dx9Vd0aGwW917K2f8pw9hH13QHM+n1h6jYcsRd1KdqkUNaP9xGZFOdMvw+Z4k
 bxMK7boyxAFsIzLWCyvztZoRnw+ELwFeITHWUXjjm8RYtel6iNhLxhOoyemca3FO4tWI
 jZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750647; x=1715355447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7vgoVsqHzfmK76y1aCdJ7NQoyMwbf/Tg31Ldi1SHrk=;
 b=uhyhNlDDmOaclHMuoGR9A1cQ75hlKTBTDFn1hcmgxuIgjwzWEhWB4ckb23OwfVGK0m
 N+6Ov5KIM4f1tqLSMYq76NwLPDbeJ+iHqo7815xvGdjVEZJyh8GnaUI17ujWQWVpmsh8
 3sucW9XrBX8LvQdoY6qPBIHJ1owPIyUGPo6M+gAOYZ9hpXjPYgTASV5j8uLAghlDDUsv
 JZJDg0KbFZn8w7cPlmn7P7qKmg7mV8iHah8vIuBEGyt/kdHF1qDIqNQ/THlqxIRkivpi
 07vfd544msx9u2StFfFwYWtW2ZPQv8CC2gPw+fOjFlAqIVSMowVUuSdYC22RadkA6R6t
 b8ag==
X-Gm-Message-State: AOJu0YwLerWY5IC5/suT2EUGXkhz0dCAJdFqLL7HI+Jhf4WbXvFTZYRX
 uuNCJq/B5M9rSYWOlpl58ddDSa7xDtWHFE5BecD5kQSLi+9ayv+fJAVdVob4hJ3XwRPJ31WHiwk
 s
X-Google-Smtp-Source: AGHT+IFR+4Zuao0MN6F/jozyG1+IvmrxnadgWxyOvsroVfL4jAsBOD5EPWfgyudvhWd0vefe4juNwg==
X-Received: by 2002:a50:aa92:0:b0:56e:22bd:7e90 with SMTP id
 q18-20020a50aa92000000b0056e22bd7e90mr1502646edc.40.1714750647317; 
 Fri, 03 May 2024 08:37:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a056402028b00b00572bba6745esm1771484edv.81.2024.05.03.08.37.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:37:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/14] target/sh4: Rename TCGv variables as manual for SUBV
 opcode
Date: Fri,  3 May 2024 17:36:12 +0200
Message-ID: <20240503153613.38709-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

To easily compare with the SH4 manual, rename:

  REG(B11_8) -> Rn
  REG(B7_4) -> Rm
  t0 -> result

Mention how underflow is calculated.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240430163125.77430-5-philmd@linaro.org>
---
 target/sh4/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 47c0f3404e..e599ab9d1a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -933,16 +933,20 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x300b: /* subv Rm,Rn */
         {
-            TCGv t0, t1, t2;
-            t0 = tcg_temp_new();
-            tcg_gen_sub_i32(t0, REG(B11_8), REG(B7_4));
+            TCGv Rn = REG(B11_8);
+            TCGv Rm = REG(B7_4);
+            TCGv result, t1, t2;
+
+            result = tcg_temp_new();
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
-            tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
+            tcg_gen_sub_i32(result, Rn, Rm);
+            /* T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31 */
+            tcg_gen_xor_i32(t1, result, Rn);
+            tcg_gen_xor_i32(t2, Rn, Rm);
             tcg_gen_and_i32(t1, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, t1, 31);
-            tcg_gen_mov_i32(REG(B11_8), t0);
+            tcg_gen_mov_i32(Rn, result);
         }
         return;
     case 0x2008: /* tst Rm,Rn */
-- 
2.41.0



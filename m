Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyl-0004x0-O3; Fri, 03 May 2024 11:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyU-0004R0-JE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyS-0002mO-3s
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:25 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a599a298990so161696566b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750642; x=1715355442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoD/zlu+/4ZeapaLPXoxxdoWxm9OjKa8JA5CSHa74YE=;
 b=y51LGWB+01kHXcF1v6rilRC6wNhPNBpmtvzU+3WiOLL145Z4HEy2dW5yB/lKWdReDe
 T2DGpUnUHKZQLwJwEtMHBKI/VmTqAamlW60rXRRBeuArQEuQMBzJ3km3EEhSrSnrgh0y
 frZDypjmHDij2w6O1Bdn0L2LZfu5JOqQvlaSm2m5429v2KuuM1FhPq+wDOEyXp3rOotO
 8gy06JxE0a7lm+EnEl6Q1uILz7i4xyv+FPTIVcx7xCFNCC/vG0UCmH3toVEKfPtbkEMm
 WcZHk9VmijLep8eZQ9RyuyRXEKUPancrMl/Q+kOl+N6jAz/YV8JBEPyBYl6oLiL3lnFw
 cI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750642; x=1715355442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoD/zlu+/4ZeapaLPXoxxdoWxm9OjKa8JA5CSHa74YE=;
 b=vBenKx0WEHF8Sg47PLaG1G/vujb5jZqpfNn8ED6ETRhrSsMzGg6FO1jEpeCeBF5JG/
 SHLni781SWlmBxH+Axn9HcliIIWf0h1KzDQ8OtzhqAxY1S2fv5ARNi2Kq8qaYuw++BEc
 8nhY3rw7dgHViIZYaBTaR7jxHtFG/Dni0iYVEDPy65VP4rekuEaTSC2JdkPiVFptIEGh
 k/k91MIlgDordK37mMkV82ycVwNR/iLOVp5m7JCUkJVJvhhks5VRYtbr+el6jjL44Oyo
 jUai4Ve9Gt8bfl51PtshccUWzmWBl/RojlNOERTvOHeF2cwJBKcYaAmsRpnN1+UZl+hz
 UapQ==
X-Gm-Message-State: AOJu0YyWQx+KF9PulB2Yt4wjehzsZBEPUEm1e5Ttl+Iq+IbqkBG0TiPY
 fjD1FXKejutLKp5G3Z/0T1P59NWH3ZXeaZQ0cK+CkW3Ora6uYvIkzllqMTy8c8/XtogOKcRCMwz
 3
X-Google-Smtp-Source: AGHT+IEUVU8WVsg1py4st43oPY17gpsYRuLyvr8rYJvqUHB+pqWsmlUaaU+6VU1FAbouxrE4xY8DEw==
X-Received: by 2002:a17:907:766e:b0:a58:7ce0:8e13 with SMTP id
 kk14-20020a170907766e00b00a587ce08e13mr1942899ejc.34.1714750642044; 
 Fri, 03 May 2024 08:37:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a1709064f8300b00a58ea7cfeedsm1815768eju.62.2024.05.03.08.37.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:37:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL 12/14] target/sh4: Rename TCGv variables as manual for ADDV
 opcode
Date: Fri,  3 May 2024 17:36:11 +0200
Message-ID: <20240503153613.38709-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Mention how overflow is calculated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240430163125.77430-4-philmd@linaro.org>
---
 target/sh4/translate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 3e013b7c7c..47c0f3404e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -705,16 +705,20 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0x300f: /* addv Rm,Rn */
         {
-            TCGv t0, t1, t2;
-            t0 = tcg_temp_new();
-            tcg_gen_add_i32(t0, REG(B7_4), REG(B11_8));
+            TCGv Rn = REG(B11_8);
+            TCGv Rm = REG(B7_4);
+            TCGv result, t1, t2;
+
+            result = tcg_temp_new();
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
-            tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
+            tcg_gen_add_i32(result, Rm, Rn);
+            /* T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31 */
+            tcg_gen_xor_i32(t1, result, Rn);
+            tcg_gen_xor_i32(t2, Rm, Rn);
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B11_8), t0);
+            tcg_gen_mov_i32(Rn, result);
         }
         return;
     case 0x2009: /* and Rm,Rn */
-- 
2.41.0



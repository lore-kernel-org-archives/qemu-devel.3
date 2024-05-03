Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18868C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nDl-0000vy-Kj; Fri, 03 May 2024 03:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDg-0000qc-WE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDf-0001Jv-Fy
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41bab13ca4eso47319245e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720833; x=1715325633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsUohuRZS7qAWRTP4Ddk/BzlIY+4ubmA4ImrHbv8aR0=;
 b=wDtQuuOqJM0npisIlpNYTH+InvckwZLRz1xOeD0vGVuUCAmK1ttuDmLUS7Xs+kquXO
 clOdj6QUBPGc+i/2ZjdKSo87hAAOguXmltknGOZ2HoSFkKOcDTnMVzSF9sn7/S1a5sXZ
 J5uqT8iqqhwygFoBahDQoF5XhKm+XvXzTKaZz5r0YwWzW9s5NP1q9piqr5js1MqsdnUF
 T5Ial6H1jUjH2hniSk/VrWx3C/MgYPNCcgMV/6haKgPGmFfwY6UMuzclUZZh/3xifcig
 jVfAKVsGvKQpDcIO3+4Du6ozz87RMOcNXU/m0++X05e+u6FHGVbewNoExYiVyvj5KKym
 naEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720833; x=1715325633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsUohuRZS7qAWRTP4Ddk/BzlIY+4ubmA4ImrHbv8aR0=;
 b=YuZuGWIQLB9FWBSxMMdA6siyhyBAEc2z8royL4WJPKYMDMZCux0KGeSuIld5Ra0Iga
 JOCvaNyLiYhGLChG3wWSGaaqXzH/diIPfSJouMGbKUv5km3y/vJoc+qwqWl/tOEFUK5b
 +c16S2DVxPkp0oaZMQNB9Rj+PB/ETrkaFy5QP/BJI5MAd8iVBP7uMhdk0JRjTYeveOoH
 6Mysp5FnXR18gYVwUfUjrdDV4CnkjWteLQ2o0k3QrlN1R0XNi6CuGpIIcjOx53eU3ffb
 +KNdVxu9VuoZViBt5+xBN2R+Ue6wh6pDda9cv6AB684e9B3VXS7d9k7AQh7PdxRxed0a
 qe1w==
X-Gm-Message-State: AOJu0Yxghya53lZMft36vC9KlzPQ3Vc/0OjOWuYMd3RBjYpaKt4WqX4G
 AosHOSlnPi2mFMkjdXjzxGfPbDwn8tg9K0wGz6RxjP3J5y135aB+yWuc2MiCboLpYiR/tHibRZM
 H
X-Google-Smtp-Source: AGHT+IGGTxiOEu9QkkOju77VfPTN6btJoBaOvWPRgotA53tTtRDavLH0FimYCkTGSjRL+cheVmLh/A==
X-Received: by 2002:a05:600c:5118:b0:41a:34c3:2297 with SMTP id
 o24-20020a05600c511800b0041a34c32297mr1356974wms.5.1714720833657; 
 Fri, 03 May 2024 00:20:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a05600c0a4700b0041ba0439a78sm8317697wmq.45.2024.05.03.00.20.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/9] target/alpha: Use DISAS_NEXT definition instead of
 magic '0' value
Date: Fri,  3 May 2024 09:20:07 +0200
Message-ID: <20240503072014.24751-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 1/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 52c2e6248b..9ad7bf6e5f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -440,8 +440,10 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 
     /* Notice branch-to-next; used to initialize RA with the PC.  */
     if (disp == 0) {
-        return 0;
-    } else if (use_goto_tb(ctx, dest)) {
+        return DISAS_NEXT;
+    }
+
+    if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 0);
-- 
2.41.0



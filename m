Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BD2CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb6-0004xq-Cv; Fri, 22 May 2026 14:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb4-0004rN-CT
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb2-0005RD-3I
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so8570727a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474462; x=1780079262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTV+CLBxiOJvwZGNE9Pre6H8XgUGreJTp6/Amr+aefE=;
 b=ZHihVbn34nyjPlDUOszeis53qhwxV259ysTf7Khf+H4mhYa0ad/w21ZP5oWnOUUFqO
 bakzBCzhuZrgFngjdL97wAOl3SA49So6+HJol5+jL0fq/XwmpCAWMMulV3T6q7hczsh/
 FT3KHLWkdQO64j1OTrDDBjS/IHeBucmqI8jtfR+/iPBq7P+TIb64dFUkBWLs4Fdmt0xs
 FofNWfDkcbt/AuKywk2JAgs5WdIZ0p8pIepr81lIy99D3smeIkR8ISvwiGXEwrooJVdv
 5yyNv3JrT+PlixmJ5oFCNPO4bgUJXuiufya5VlNVJDm7/x5vB4s/FCtShSk3Jjy6vaFd
 pQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474462; x=1780079262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTV+CLBxiOJvwZGNE9Pre6H8XgUGreJTp6/Amr+aefE=;
 b=q2dQlvlCVisw+XqYxVV4YwppgZa/u+aZQ8ltT9fkzTBG+XOOOa2XjdQB6HBRj+3ioq
 sh3E6BXogV6HOeRwxUOzYW+k8aGmwo26ukBCVDWSz3ap0vyh51aCaRDGjVmOi/T5Z+30
 YlgyLsR2Y5DKeyjo683FvDQLgI3hYqwTchGCgYSG8140bQrx1ivaL4mpIgnrIUDcCcDt
 ZEDYo2ahbYqHwxK1bkTCOLV48GH/40JVyIvHWpSktnqKb298r1MbKoiCEZDHc5l9NRv9
 hJ3UskxW+uyK9dOxSDINGvYYlSjo4i5+k6jjsGCro4YRMJbzud3+bEp4lH8rtTQnFeoT
 5wnQ==
X-Gm-Message-State: AOJu0Yyc1besLBSF7wVorzIfq95xCVNhl4GNOWRXndIWQwrDE2i3ht+E
 utbH29QQFTbpwwxmCHjOMX5n0aqi4mtVzOZTTYLUCHMdH4TsUr6z6QP8ALZae+E5WF/iQIOvJwB
 LPzRy
X-Gm-Gg: Acq92OErDNCRRlsh9dLv+4H42yu6iusWfTqU1G/Maz6RVogbczhFBet7SVmFyDsy1Kw
 Kmiy/14W1wCYhFLhZSE4lDfWX0vS7eYBhzS+n0x3sgElKPShAmlv+kCx9gnzXucMRr61cRxPaVz
 D+AP5SLCaSzqDqMWVQzDrfL+AHPiEo/P4bDeY9VqARMJCSx0t/iiRiXf1ufd62faC9s3zC8E+M6
 PxMIZaszrl/liDJEdqrhMj3uJEgR/ptM//7j52KqHjac9fgDcWnjBDSMJogKOpQrzMc7uHOCGuT
 toRnd8rmm0HD8d7JwVbSKX2H//JuOMqB+J/jQgredPj94G5iqdWZDdBbMuOWGCGiUBEf4jN4Adv
 HGHAXfNs1YsHVJHQj2fzev+TeyYgA7uGB1AtMNNcy/JJ+SSM1wSX8EVR2/9UlMRLAf3kt3dThwm
 sIuLQ2myi93pc47cWCxSWRJL9z6g6ulTP1uaFo4Jg=
X-Received: by 2002:a17:903:41d2:b0:2bc:eea4:83c3 with SMTP id
 d9443c01a7336-2beb06fc96cmr52693805ad.25.1779474462431; 
 Fri, 22 May 2026 11:27:42 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/30] fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
Date: Fri, 22 May 2026 11:26:45 -0700
Message-ID: <20260522182658.184604-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index fd3e79fd3e..f40a950b41 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -53,7 +53,7 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
         return partsN(default_nan)(s);
     }
 
-    switch (s->float_2nan_prop_rule) {
+    switch (get_float_2nan_prop_rule(s)) {
     case float_2nan_prop_s_ab:
         if (have_snan) {
             ret = is_snan(a->cls) ? a : b;
-- 
2.43.0



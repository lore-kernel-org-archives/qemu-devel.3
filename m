Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D219CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb0-0004n6-OF; Fri, 22 May 2026 14:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUay-0004lZ-Ok
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:40 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUax-0005Pe-1I
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bc7b311e77so35021695ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474458; x=1780079258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Qae3c5BjQ+dTxdzUKGbagRfnMHB9QZdBYw5eqt/8KM=;
 b=MytyLUX/7cvlQlBizC50FuZDMkCrCjEYKlo9sMABu4lSlaje47Txt84vRsuQ3RoAGg
 aHRYW/Asf9TNjizZmUcJWut5eG3pbkpMmU7nNewAjmxg3RkouzwFuflGVceNTS5g/ILx
 wYeYapOgAT4jSK6/o4RGSGXMq32YKqa09Pi8MQ7/vDG2D4KVNVEa/LUg2HIoX77MfOC2
 Bj0+tX12jrIMczSmRsyuswxMfr4lEpXyZm1h+UR9TtoEGxym2v5gtuR6tdswOM1NBc9M
 22icumycaz2aNKbL4ncqn1l3fMSus/xPmLi7KtlHMx8JSvNruga2jqwgAfOZGGtR390B
 QJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474458; x=1780079258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Qae3c5BjQ+dTxdzUKGbagRfnMHB9QZdBYw5eqt/8KM=;
 b=Ws6eUWntXnEiAbJKqbPCdJ2Njrkc3Cvo7aOeZSxNTHgjTzs/kWY5tbqPMav8zMtbzu
 n4/EDsFWO1q//IZvYZDd29/9inldCEtICeGNiDW7XXgmisSeCTnVDm+HNa24fkLU7gSZ
 M4nuSJZLJwLD+p254soQthbfrkEQ6hczvLYRynM9xOXZdaqKAdBCH/b4Kspbwt/CU/Dh
 qoRrIyHzhun/qUvJo6O0d+T0zKSGFUrWbDhgSAbskLEk1jAYZenr0iEtkVxpjbD3SQLz
 zH835EcysTM8Vd2LwMw7ep0rCUKdRJbTtSXwuIMRwNgkkiRXNqI/j7meHpxHbrd03xCP
 zrxg==
X-Gm-Message-State: AOJu0YwKw4uByVmb990xgiLBpdufLvngt6MY7abU6C/cIJ3px3e5Elqb
 2VbHJoiWHiXlmr4kXYHIqkuTQAqaOubQaM5ImPN2iQ47k2cskdsZsXSU6do1DcBfa+V36OuIZBL
 UuIi/
X-Gm-Gg: Acq92OHudc0MAizsP9rvuXmjN0jVbA1SuTgALa0GQeK76pTLH6vNAErNJ90+wePNOmG
 h2dkZyF21fdGyWAdk5nE0M6hxU2FH0VHjV4SMnFepqDVvLAOg/AXIUAsUPpJ/5qBKmQilbQEAkz
 /DTNDas9SK6ftAYGEG3agzXbANOx77ItZk1Lupa3qYHsGDugr6w2F3/z/CaopSJL99rBLdjoBRt
 P3RmOuZO7kzWQywaEWakKi9GsxiT3JgeWpWx1xz1XH+nz0z9og4t/+OnWiSOrrv/erwNBvjWvvc
 wwb4PKY3wG/jG/1qdNrxaTFdLls2qczpakOFc5mSWtuDHpspP2+CPQCk5gC8OkoG/7byj7ZDwgX
 t1qFSNPO76Oty4RqF4gggS/QVRw8oSWPxQq+TpnD6ldhogNI6xWSLB5FqSBkR4fKv2CsgqJ9hGK
 svczigUI0XY97gq0VCdiasriVd/7kn
X-Received: by 2002:a17:903:11c9:b0:2b0:506b:e6f8 with SMTP id
 d9443c01a7336-2bea20a2d54mr78206775ad.5.1779474457526; 
 Fri, 22 May 2026 11:27:37 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/30] target/alpha: Use FloatExceptionFlags
Date: Fri, 22 May 2026 11:26:39 -0700
Message-ID: <20260522182658.184604-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Fixes a bug in which we were still using uint8_t.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/fpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 30f3c7fd18..9af77777da 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -40,7 +40,7 @@ void helper_setflushzero(CPUAlphaState *env, uint32_t val)
 
 static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
 {
-    uint8_t exc = get_float_exception_flags(&FP_STATUS);
+    FloatExceptionFlags exc = get_float_exception_flags(&FP_STATUS);
     uint32_t ret = 0;
 
     if (unlikely(exc)) {
@@ -455,7 +455,7 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
     float64 fa;
     int64_t ret;
     uint32_t exc = 0;
-    int flags;
+    FloatExceptionFlags flags;
 
     fa = t_to_float64(a);
     ret = float64_to_int64_modulo(fa, roundmode, &FP_STATUS);
-- 
2.43.0



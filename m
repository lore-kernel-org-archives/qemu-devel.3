Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7204FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUd-00008q-GB; Mon, 27 Apr 2026 08:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO7-0008D4-Ow
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0005lb-RW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so172756035e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294111; x=1777898911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0a1Ls59o9nhOOy82JK/fcbf0nGoU5bJBXvtu1cJOEwE=;
 b=cWmG8HUsVas1HJDA69LjDVCR7E/J1MKYqOJtgAjlpdOMfCPordwojFlu3ky1JAb2Nr
 rF6Oba9G1QjmBBTGccvmT+KgSq5F5jVEFPWSY+C8pxOZLMDNOl7V6HP2A26qmQnSTOwP
 htINKCu0RBXr2rTkesmuIzLEPrr8Zs3JJLe5twx/x/WGBe2m4C9N2hfoN5ItFsGEkTSh
 4EsVJM/8TO+5VDjzazeZGldLDNrx+wEqA61J6erEHHTJCyReUcgKZVXf74aZ9fyuHWzy
 VJtV33xqGdxnA7d8xHGbFRsLUexaTdrdXgHoGBaW8VmO8eddWCpzmZmTAHIKGBrMlAR+
 On3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294111; x=1777898911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0a1Ls59o9nhOOy82JK/fcbf0nGoU5bJBXvtu1cJOEwE=;
 b=PeT6Cx0zM172xFtPrF7eMnai6tGlYb/iKmLxXFmQPEoJgqlDsmi7BZ5jA06tCBjSn6
 iVO2ejw2Q5XIh96S4u800R0KhSmDgRPzG/Hdf3AyvuxKtJ9sDmCDKB6x5byDGn98idDs
 3x/vQwCY5xL2lDkeMqaj6tOY89ze8j1zbo8gU9y9bU2mswHqnQIwb3ySPi5ERHAuF4cP
 hPtaZ0HZKagO8AlN1ogJqThqWbecGJrpR55aXrQcI77rapbpCgA85daMrm3EKXfzeNSJ
 eT6M5txIYO59UoT/3H3mdPvVjWgUoDWRda8U1+6Eva3fqE5t4fdEvlwWVd1PWh5kBNZl
 MHFA==
X-Gm-Message-State: AOJu0Ywaq5KVUC8WbZ+Zm9Uf8gCo/ktAnDPNZTjJVhOQe/l3g+yTgm/Q
 75Puc2BI99h83q2u3WBQVnUa/7ZRswbm4jDBUoOcvs/j8gmAf2pLZtC+Lv8q/xx3jHVtKLjq5oy
 V6Alx
X-Gm-Gg: AeBDieuKabjcFgiesGb75ujWzUgLssgHItYJg5n3HN/CuDwAhxvfTiKz3NvLt4x9DmM
 qE8j207e7KGplfdvR+xbMnajzuysRtLVR4q7ptyoBoLXdeNG3nGXp7wSL+nsOmDhiIjsyJvN1R8
 v3fT0R6npioj2HYUwLsQlVgHKHqc0KbeA4+OYGNlQXK3NTS8OtzB25At9qVgbcAvskfgdvNGjHF
 OyYaHz85PNk/wp+1sdimhujaB8l3G8Y+F7I6AjX3/DHGuqAjaSxsF36D7OAwIARHcxVEPg2QI/O
 AYjSB6Ins/lfRMSAddOZM3I+1nQkTrvKT0u7+IlkgPcPDykRfL79/kTYCqSVBx344lGDdezSnFw
 yX8MmbtWINfEbpfxEeADq0E0LHcTAHUJOu6lDvXXalZkK/wsCGIZCn41Kl+6TFTrcjHK7ri/EgX
 RzNMYcT1PiH9w0UjPI3drKS3EfC/025ObXndtnJewAUhZQEI7AFbK4a8uomkJ9C/7mcXb6EcRBz
 7Th886vNZVq/TZP0WZmTS0gKdPZP08uzFZTxmwrUg==
X-Received: by 2002:a05:600c:3110:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-488fb7389dfmr639782675e9.6.1777294110575; 
 Mon, 27 Apr 2026 05:48:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/63] target/arm: use syndrome helpers in
 arm_cpu_do_interrupt_aarch32_hyp
Date: Mon, 27 Apr 2026 13:47:30 +0100
Message-ID: <20260427124738.966578-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

One more step towards dropping the old #defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-17-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ccd6353190..7e7677a584 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8844,9 +8844,9 @@ static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
              */
             if (cs->exception_index == EXCP_PREFETCH_ABORT ||
                 (cs->exception_index == EXCP_DATA_ABORT &&
-                 !(env->exception.syndrome & ARM_EL_ISV)) ||
+                 !FIELD_EX32(env->exception.syndrome, SYNDROME, IL)) ||
                 syn_get_ec(env->exception.syndrome) == EC_UNCATEGORIZED) {
-                env->exception.syndrome &= ~ARM_EL_IL;
+                env->exception.syndrome = FIELD_DP32(env->exception.syndrome, SYNDROME, IL, 0);
             }
         }
         env->cp15.esr_el[2] = env->exception.syndrome;
-- 
2.43.0



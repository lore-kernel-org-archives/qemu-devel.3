Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451D11098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZiL-0006Z4-Jq; Fri, 20 Mar 2026 09:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhr-0005ux-L3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:05 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhp-0000Lf-0D
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:02 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b980b35534eso352554566b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012559; x=1774617359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4b4g1ndm+NdlMFQZnj8OfDx+Y1WcTpX3//RVeDa+Hw=;
 b=LbDryekaMpdhy151zLdMoSjOiWN9HTe9u9iDPscOGtmrejApkZlpgbsKuCpH4V2VkK
 461TRahUlP4Jr1j53xj6UqvYviUg9wNDf6KPbACP/ZndkeV4xTtXjYuraV14Zs1I3FKj
 ut8vN8aqjaAIPou3UyG4mnnArrrcjUC8QoU8kYGWpUlnAXd86NNafTNXJfc27ASuK/aF
 wdcYBWK5yKLQr44lmq4QVQHqSlog0HCvJYcbPXdUmNzlKVMNWiOLXRgwl3LHeNKDK3Qb
 CJvBI23nG1ov7mpfZHc6jBS3hB1mAzZ8TA8p3q5h28WeLc4+6iQOmThf7MFeH+bMqhGH
 ycFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012559; x=1774617359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/4b4g1ndm+NdlMFQZnj8OfDx+Y1WcTpX3//RVeDa+Hw=;
 b=YW42Qq5qR0xzPIzv1TV3hNL1uHZnwu4d9ZyVDzcl+jo1xWzIjK447K5Gnv+mWCvSFE
 FsJtH8/Torvl9KfMBdPsU6ijXgPciSHGvUz8YHZfiSLMHhSMhxOwcWaU1obD+d9098z+
 vUHt6OXX0QfAibdJfsNFW37D93vAXa6SNo0nTCsAdl9Ze/WnXQmuGkTnsRdQJzCw3V7V
 cSNa3pkb9XOzsRc4nNkIueCtpy3fq/7v6bBHp2A5FaRe6wyS4ixAHxSvEkO7QRZwjVvY
 r6wQ9PHF3LEQBHNjaBKxCTuF5PdgNbaZnAp0OdBKMv07Uu2CLZlMc4ojQFXGtqoNaEhj
 y72g==
X-Gm-Message-State: AOJu0YyVjqkJW3Nxlz1Uied9M7O1WBtukwtq24566tG/UT57tkpDiLvK
 szFwNgoqfCKpf7fvoGXa8PSZHqaS1kCNAg4WaYbtD9vVF1nzHXldkRh58f5xdygPgd0=
X-Gm-Gg: ATEYQzwOtUPFDzhfNvkoErlDPDv10GW9ehvlG3AUyetapjb5DCxDDRF2hPRrEKsfG+z
 bNEkzpnZsxuO9VTZXqnrn409dam2pvveZE8MJ5U2u8dm05+hikBDjO14KsATEnkCSU/O74fWsGj
 OkTC60aq6ha9ftAY7Yin9Ued/DqAkAVqw5y7FTymYqnGQEyOZ58C27xKeRnm+ZzFN7Zr6rtb0ZK
 ISvdt0IH5fk6hZTP/NZdX7HAOfIRcUYno5zl/KbOkMfW36MKNu4thod55QV4wWlwJIn3RoOlvSl
 3DFef3H6v1yE2sI/v8Cc8gk6vBSMponwtSDklP4VtM61qRTm5evXXFJPQx2nCQc93aVtgzpHPpg
 sa8iKTS6XHdUloYU1IibZC4ifbRisL8r8axKqppMvbRuQ1XRAgowRoqbqEpdylngGT3jWUpuT9k
 Cu/j+ZJgJZgNj1kOUbz/oxkxA=
X-Received: by 2002:a17:907:1c09:b0:b97:bcac:2fd8 with SMTP id
 a640c23a62f3a-b980f950567mr536768866b.13.1774012558595; 
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8da12sm160740366b.21.2026.03.20.06.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0AC385F9D9;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 17/35] target/arm: use syndrome helpers to set SAME_EL EC
 bit
Date: Fri, 20 Mar 2026 13:05:48 +0000
Message-ID: <20260320130607.2071996-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This removes the last use of ARM_EL_EC_SHIFT.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 5214e3c08a8..07a52643e71 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
      * Similarly for watchpoint and breakpoint matches.
      */
     assert(debug_el >= cur_el);
-    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
+    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
     raise_exception(env, excp, syndrome, debug_el);
 }
 
-- 
2.47.3



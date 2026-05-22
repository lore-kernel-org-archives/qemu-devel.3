Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA6CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXym-00009n-6D; Fri, 22 May 2026 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxi-0007iS-5a
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxg-0007yJ-BC
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:21 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso4398974a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487399; x=1780092199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rn58yOh3c+VmSSUbLsskLhkkEXYk7fUpwHNTpFVDW6k=;
 b=m9xVDbp3x6eHTXE3uCQDG3dSIoj6361WDZ78UhZIgcgu8UyD3q2dP/eFpLOsmPAOFl
 XqKfS4bUl7hQfkJUl4IiJ2X9cuygxeHbxea/Gb5Jp65UwbcX5aiWxYEkhEKJEpvXgfdI
 OK2HmtmqmDGyBRqJsBUX7UA8oclxOqRHHcX8FDWK797YCT11mW14ZBov5L2qo5BoffCO
 qJklujn5ur03Eil+fLK/1+9buZdFzAuDU2ZrZCKpeer+/veP0w2J4Cw7qkiuTrD3wdBQ
 Z0OjPNxQrr+VJLcMdZVO0fW9LNUI4xOQeI9r91y/UuWl3JWvjcaD3ajjh5WiMYia22m1
 S09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487399; x=1780092199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rn58yOh3c+VmSSUbLsskLhkkEXYk7fUpwHNTpFVDW6k=;
 b=Snm3AB7wVvVeEjpPIIARHglh7BJU5maJJMDb57RZr5TdvEcuoy8rzMDYdNNMx/eqyU
 oBlCm7txZEYiv5ItERz3eGcjphMZvfvOIfICmyMdZXLobHeq7T/zx8lfQPyyzGTitqF2
 0z6XAsRzKHML1l/1XHiF5ssF/xOC1YC+DQjjh5UN4rpkhLh8o/EMrRyBuruvrYYjYbtx
 UK6+vDVw59jTtmJOGCQL1Pq1UVCt3gWMrKCl6APAy3T+FBOxwuQzIax6XJYkH9jx5a+7
 t9iaQVzEZf2FToMQTGqdWngzmfPUW/qQHEx3AIUJ75X3ShI4lKvh0rtx6Ifd7U8NocY7
 fIQg==
X-Gm-Message-State: AOJu0YzbwDMfb3QcfD45hmBaEGLB+QK8LUheoHZ7aQ/cMnGdKo1H/uyS
 onlTdNszSL56rmIXO/ycuN5plWv5Nx58GEuOMl0lhBji048kb+uEwZq7PRodstZJsqv6mx3072T
 cvfDK
X-Gm-Gg: Acq92OEYU2Nt9N+b4TvI2rtYwLKz+BtJRD3kP+f54QVQk72ZOl/8ReAXgdYJeo1Tq9F
 ZMB6p75jHqtkz4CEGB+xJBTpYVRkZ0E9aSyzPScSfm2L6rmcZVGflsh7zBBJbDSgRaXf40UlWES
 YyDpmhgoBc0Hg2Aj9vqQpgW1z6i2xzE13kQhPT39gcCbQh1qElSLyjEU/4paYg46pJRF7It5fTE
 7gA/JcmdGVaBGwdIZ6RXZQSvPMdr84su7IJNFboxAxVEeAUSmXAQy3wBoJaC1/jBHXX3akKs+AQ
 gsTK7gRv7M0xy+Gw3o5d/K82kpwsbLm9NOMb79to7IuUW1hxFcOTWBL/1uaFX6oKzKMbFya65Jh
 gkINKhdjFquC0F/ZpRY+iGuZtPtA7KxD5yjtZFuRfbYJI6Tog0yL7yiEJIJmt1LPrMv5b50vUWA
 g3eYpNod2X4NZIhSMYega26prkTA8P
X-Received: by 2002:a17:90b:1a84:b0:368:6998:b49e with SMTP id
 98e67ed59e1d1-36a6745ccccmr5366741a91.9.1779487398810; 
 Fri, 22 May 2026 15:03:18 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 11/64] target/arm: Clear FPMR on ResetSVEState
Date: Fri, 22 May 2026 15:02:13 -0700
Message-ID: <20260522220306.235200-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

FPMR is cleared when entering or exiting Streaming Mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7eb7031294..3d6e7f1ccc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4856,6 +4856,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
     vfp_set_fpsr(env, 0x0800009f);
+    env->vfp.fpmr = 0;
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.43.0



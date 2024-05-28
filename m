Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04505C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUf-0001UM-Tk; Tue, 28 May 2024 10:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUf-0001Tn-3b
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUd-00070M-45
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-354e0cc9c5cso756125f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905277; x=1717510077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EAAlRYMlBTnMK71N/Zu05HtnM34HblCxoLd1v+E1rkk=;
 b=EkGF+zQGRmrzicrr4ZUfs+Fx/hiQnBUEQd0IGzOdvK0Pf3VtPvBIFkaDpkKImKS9uX
 WJc0G2Keh/fRhvl9pemS1XVBQk9uuy4grRbm6dH3dd2FD2isJ3iVJteuloU+EyHq0Bvs
 yBM1KzTDJiTVbjtQUgOzfzGEJDyS+AADxqfQvj2b+C6VPgCSoORByEF940H6wafpgs0h
 ZdCeV5Cvmujlbt5Bqvt53Btm15NIPGaEdar/AblFNK8X2ObxMoJnnHRmKvw3DIQCQKlZ
 eM+NBMx21/m+XWudsMDFaTwzuUFPxuWLj+Hl9DVatAVKpc6av/A/0HRs7H1rWSQN/b2h
 zCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905277; x=1717510077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAAlRYMlBTnMK71N/Zu05HtnM34HblCxoLd1v+E1rkk=;
 b=qNHijZaUhdHc8ljweMHDA7/i9/9G1ud2qdet/md9cT/o3W578VhwZ5BJnFYkaS2iEg
 82l7Zr6fn4M/Mi+BxcPNybF6o6Rt/hGK49U00ZwB2wnopB7B0zRjHGFdCXZqGixUhxkx
 TwjpkZL9mSircbUpasT5sfr1YHZKx7CxtRvT6ZEj3SmH5lUcu0r0w8jbktqsBrorTg4w
 rdbCdm+NsYnBfec/5A+JMMmJ3JJzV8wsnqpAbn8OuEcVYPIqapxpe1WOU0LuQAzp1zG6
 7omDWK5o4qkVPYvllNPEXYUiqc3q6NHMlFgNyW7h87U7ykWVxQcgIfN8KpeeZMS88ra/
 j6BQ==
X-Gm-Message-State: AOJu0YwFuqQTYECDYLJwwiaAegsSIklyYKouEcRGtx8PvgA1t2p8I6c5
 c+g9LM4WPNgdmoZ5VqOteSSgj3RWayHLaBg6QdEh4I2+qIv5TemW0rDBXO1FI+qZnqyJiK5QcAx
 q
X-Google-Smtp-Source: AGHT+IF3r5oo6cmZr2OoyOeFQxnyXX8c8F74VC7x5bbnqexqtsx4iELupdBcjnD7ueE2yu4lIUEwtg==
X-Received: by 2002:a05:6000:1541:b0:359:733c:c8d6 with SMTP id
 ffacd0b85a97d-359733cc9fbmr4982633f8f.67.1716905277685; 
 Tue, 28 May 2024 07:07:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.07.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:07:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/42] hw/arm/npcm7xx: remove setting of mp-affinity
Date: Tue, 28 May 2024 15:07:14 +0100
Message-Id: <20240528140753.3620597-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

The value of the mp-affinity property being set in npcm7xx_realize is
always the same as the default value it would have when arm_cpu_realizefn
is called if the property is not set here. So there is no need to set
the property value in npcm7xx_realize function.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240504141733.14813-1-dorjoychy111@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 9f2d96c733a..cb7791301b4 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -487,9 +487,6 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
 
     /* CPUs */
     for (i = 0; i < nc->num_cpus; i++) {
-        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
-                                arm_build_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
-                                &error_abort);
         object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                 NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
         object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
-- 
2.34.1



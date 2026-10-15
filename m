Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFF3CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4Y-0002IN-Ca; Thu, 15 Oct 2026 06:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4W-0002Hx-QH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4V-0007p1-3E
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:28 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so2247443f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061545; x=1792666345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1WRu9HUAXGvWTLrdh67sYvl141SJGSr9PqklX78ITo8=;
 b=xeUqWRnM0rZ28cZVRj58KQcXXT7yJygv+xMOrSmHLJcvdKmniA9SFhTsIginP1a29y
 o5MqmwKRpH0mHLOEEK57zQM3nxWVuyTyVrVj4ghqA0G7jEEev/Gz6zT3TGksnb6eJRMD
 gmU9QWcfVPZZtjvWDA17Ybw3c3dB2Cvua9VC9x4eiCLkkXG6lrt0nq3Pff0mo+56yE9j
 sOxKDXhuF2m81kuCtB+nryjJCxRZC3KTryPCLRxVEuJYBxu9aJIq2l0jlLKv5EmzP9/D
 R7EopPkkpHW6GCw7dvzDphizHaHk8mf4liZzZsQ7ZKflcZrC/vzcTJt6DwNEBeqqE32f
 IH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061545; x=1792666345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1WRu9HUAXGvWTLrdh67sYvl141SJGSr9PqklX78ITo8=;
 b=P2aUpzdbRueC2so/B6RsBe1c3Hoq2Mk3rRF/JmvO+rwIRwj2jqUVJUvCcFMV+nSQmU
 30YPSlamyS1RT57Pje+UrRQYOAeS2HDskWCBZDOqQBXew7xTqOtlSZUIxY6WDsK/1p4z
 ky9E2uvtzxxacT6/Ql7PKDDlqANSV0WvrSwGdSadSYb+iNSlPhzpZ10wfRfXAg+ctK+x
 adn0BjrG8GKuVPdtgOUP++NXPy9DNDKodrKjHOT1pcN7nEeW3j7/57kI7o/m/eY2Wf+x
 Cu0EQB4ri1LWsWo/W1gSULZm1SGQjSCh1/93CzcW/ZF3NasWCmAQjowUMR9tPajgSr5m
 VDag==
X-Gm-Message-State: AFq9FYJHpqsuF9dKjV39bSglJHusZsXc6++OBH04pS1qiyP/v7PmnZdx
 DfUw6URvg4HL7kY9wh+zavp4TrrikWVSx9tscGa/F7FYrBNzR5idN+2+bGf4qo3xKvb4EoDFx7U
 uykZlsZU=
X-Gm-Gg: AYBFou2Kx7sMQH1qIFhYePUTi1djuns0Qovzq8gPxtxUy7ORSZbEEDmNyBcQmJjr0CY
 yjcgoeEItaAIVsfSCgDa2DI0cA/zK22ZGafi5pTfwBCxZtJaa5KQGglUTt6QYwIQr0GrjsonE6Y
 EOnSy9yTTN1CZgE/og1wVlUgXbVyn+LU0BOLz+g605UxPcSG0AzvP3ScId7mobgG+DOmBMH9ert
 gTSUqxDwuNZ672QLipdtVKjJQcF5kZh/ARkmXaW0W6L9UTiNpuOcv3m8s+PL/nj/TCGRewk3ulQ
 aTO+BJsDkjnrQlk0f6SLDwRc+ZS1IR7RDLxpMXd0+9vTJHqulqIkdmA753PboWQEDNv1GlRXIB5
 t/KP3o3gX1qoTuNHnXolTc/ov5ktkf82eHbT7v525y9s5ISH8SXqf6+jmbSL4OOwlB594yy1lWk
 PB7rMMUh9mcVuvm9c3scZUd0LCW5uX2sxRF5/P21gqwNHqb5Pyj/5gyl57ScywNC5EMvr9K7FPR
 8CDlVtpxHFzjNNx3wFcdZAxcX4XEsomjhQ5Mj/oB7N1N+KBZjjcBtEciqO25hHvtKfP9VqXnYr7
 Amz4
X-Received: by 2002:a05:6000:454f:b0:48c:69bd:e971 with SMTP id
 ffacd0b85a97d-48dbaadb133mr24434520f8f.16.1792061544908; 
 Thu, 15 Oct 2026 03:52:24 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 03/16] tcg/aarch64/tcg-target.c.inc: Correct register MIN/MAX
 instuctions
Date: Thu, 15 Oct 2026 12:51:55 +0200
Message-ID: <20261015105212.356392-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Some digits for these were one position off.

Fixes: 100ec60528d3 ("tcg/aarch64: Implement min/max with FEAT_CSSC")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4609
Reported-by: Ayoub Bourjilat <https://gitlab.com/Bourjilat>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261006-jmac-4609-cssc-fixes-v1-1-798505d4a4a5@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4ebdef7e077..273462ca615 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -549,10 +549,10 @@ typedef enum {
     Irrr_UMULH         = 0x9bc07c00,
     Irrr_UDIV          = 0x1ac00800,
     Irrr_SDIV          = 0x1ac00c00,
-    Irrr_SMAX          = 0x1ac00600,
-    Irrr_UMAX          = 0x1ac00640,
-    Irrr_SMIN          = 0x1ac00680,
-    Irrr_UMIN          = 0x1ac006c0,
+    Irrr_SMAX          = 0x1ac06000,
+    Irrr_UMAX          = 0x1ac06400,
+    Irrr_SMIN          = 0x1ac06800,
+    Irrr_UMIN          = 0x1ac06c00,
 
     /* Data-processing (3 source) instructions.  */
     Irrrr_MADD         = 0x1b000000,
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C04CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnHc-0000R1-OG; Mon, 20 Oct 2025 06:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHb-0000Pw-Hc
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAnHZ-0000Dj-L0
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:38:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711810948aso27444365e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956707; x=1761561507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH8+GFr3xguvK3YMgH40pVk9NXUnal96AS8GYRsqGP8=;
 b=ySPZ62kFT+PBALrGdUZqJDycO/YeHgOQNTq9aUo1Pb7v8f0LNfA/sfFOHhe2uj7xLc
 9MY8AAmllopJQy+6eGXLJle4Wx5xUYeTwR6pZJFtuC6ozN4DOvvssyUceco70WiWkkAR
 rW6gIYjf9qzn78zAnLNHTwN4XIVYlZRvXVOBLiG7MrfFoodz1OIYKhO1uxHLmaQvl7yQ
 R6bfL3R3JUauy601w6N0ygDoniDHiuvnoNqhfV+WTy6kiC2/aX0sGfLOGEnZ4R5I6IQs
 ycfpJ1rtHhsJd2N+HEMyMt71iRS+eagpkjiVUY6YQJwd9dVuo9uQ8dM6X5kDvBs8umEZ
 Yivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956707; x=1761561507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OH8+GFr3xguvK3YMgH40pVk9NXUnal96AS8GYRsqGP8=;
 b=JFHVAWErUpro+UHOjH1XoowVhmrgYfxZjrpILp+E2gQZwmqkhxpX1bs2Y/7IZjcSEo
 I5lbFXwuBIqr1K/RksthA5l/EczK4ZYTUO3ZODOjh7Zah1SFjBkyVRKlv60Fh1UwE/yJ
 tbhbQ7AAvG6I4cQmTwDrvhI7j0Z96G/oKqdmTdP5/+CmDwRZu2zZMc5HoJNt39/2B4Gk
 U3oaFp16xAioDqZA8h8O5TwTbG7cOshXWZYb1PRGoyHbM/Zbhl4MjE9g6TyggHY3IcKI
 CNGW5WpfuSLfh3MKvxr32nZHiHFbJ6qoCECTAO/dtWP9eQzj9dGLrSbEcCeVMGcgs/NB
 iSow==
X-Gm-Message-State: AOJu0YzRXPday4poJ2LcYXa/fZP+7ItrcE2Wvup4FDQ6z3+T6NVaqIzu
 nCxmJpGZfY7Ia9Il2tt082NOXMkspiKsbVD2HqrV1WQ7JZMAfSw3bYkniD60EYkxhvoxfoO/mBQ
 Y6Ugahjg=
X-Gm-Gg: ASbGncvtoThIK0Y1lCJBS42Qd0L/L33s2El9L93+dFB/xFO9uQDaDxPzE41BYyHyYt2
 Nh1bObSDZqi1j1n9dE5uKbP34O53f75WextmiNE7sFd8VsUOtBUdBfC4gsLl2W7EEQq+0Vz0mQk
 io3rhKRkYexacmIRA3EJ4KrxDfbYxEE3pBPR3lG0e9so1FZ7UFSPyDTHzdMksKmm5u8gRh1TfUZ
 5QU+FiEUsAFw6j292aDj91IZF1vB34f3vFc6D3o0n2f5HNocX5kmmsoPoYfZiinxSVFYIR8ogJ0
 gCMGOB7wtjN8TjbZuMRr4EEbUpdL8BkqvXMMDNNIeXP+Aedtt6H4rUzG/OR22fCIkcq0qC8dL36
 Y+biuZ/l7SaU1WpTYb7IRtMuokBOdQB8VK9Wo/IKbhHE16MBiCYRPLE8nHHeFUMV34QhhJLUlij
 NQ1NYRYoiZc2e/OC/trrnWPe0tGGDilbHxXmN3qOBbL5G4SmY5nK68R8/kihXn
X-Google-Smtp-Source: AGHT+IGxUCtLJns8ADc+1HMMtvl5A82E5LNFCmXiuMTK9tNnjkSI5PY25xr23c0GX4D7JFfhVYLyNw==
X-Received: by 2002:a05:600c:8b0c:b0:471:1717:41c with SMTP id
 5b1f17b1804b1-471179121f4mr77824755e9.24.1760956707510; 
 Mon, 20 Oct 2025 03:38:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82c9sm224080315e9.14.2025.10.20.03.38.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 03:38:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/18] hw/ppc/spapr: Remove
 SpaprMachineClass::spapr_irq_xics_legacy field
Date: Mon, 20 Oct 2025 12:37:58 +0200
Message-ID: <20251020103815.78415-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020103815.78415-1-philmd@linaro.org>
References: <20251020103815.78415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The SpaprMachineClass::spapr_irq_xics_legacy field was only used by the
pseries-3.0 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr_irq.h | 1 -
 hw/ppc/spapr.c             | 4 +---
 hw/ppc/spapr_irq.c         | 5 -----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index cb9a85f6575..5ddd1107c39 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -100,7 +100,6 @@ typedef struct SpaprIrq {
 } SpaprIrq;
 
 extern SpaprIrq spapr_irq_xics;
-extern SpaprIrq spapr_irq_xics_legacy;
 extern SpaprIrq spapr_irq_xive;
 extern SpaprIrq spapr_irq_dual;
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 85c27f36535..ebc8e84512a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3347,9 +3347,7 @@ static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
 
-    if (spapr->irq == &spapr_irq_xics_legacy) {
-        return g_strdup("legacy");
-    } else if (spapr->irq == &spapr_irq_xics) {
+    if (spapr->irq == &spapr_irq_xics) {
         return g_strdup("xics");
     } else if (spapr->irq == &spapr_irq_xive) {
         return g_strdup("xive");
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d6d368dd08c..363bfc00db4 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -588,11 +588,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
     return first + ics->offset;
 }
 
-SpaprIrq spapr_irq_xics_legacy = {
-    .xics        = true,
-    .xive        = false,
-};
-
 static void spapr_irq_register_types(void)
 {
     type_register_static(&spapr_intc_info);
-- 
2.51.0



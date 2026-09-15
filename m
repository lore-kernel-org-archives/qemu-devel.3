Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AF1C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdP-0005RQ-Ri; Tue, 15 Sep 2026 13:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdJ-0005Pl-Pg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:50 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdI-0003Vp-7V
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:49 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so363355e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492067; x=1790096867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MOtSxZrrjdbEdacF7VzlJXUvyavPDBMBn3SGwvN7DBE=;
 b=EAoPQerp/sbYcLKgJVg27/lM8dAph0fJFBGM6fpNiAcWTew+LNDrjHEJ0+x/jAFOSF
 gKL8pukXQx2U/cABp45ItKtEFNJQ8sjAx9/kHf8rQIyz+FOinxBesXpgUcwB6pU3j2Oj
 6ISIjTMW2ijkdhgR/sOtekOZKWi9OoUxI5MCiuk5DI7v3PFykczF8HoYPmn2JC6tejP5
 yPjNMTI/JNeUHk4tdPrJfTfr4/HlpVSyFBwQMw7kCbMBzUZQ1lOiFlnChI8wN+7vsLKD
 FrBg8ynLj6rlvmYrcfvPWD2ZbYMeA7hxHnFJlPkvf0ry5o3/NVAW5UnGPZq9rYS/fzaf
 R0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492067; x=1790096867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MOtSxZrrjdbEdacF7VzlJXUvyavPDBMBn3SGwvN7DBE=;
 b=nXGa2Jd2XsntDKfxSdRv++7FJBXWHPAt56BOmIyW9j2IvMkDf5izodjWpv0oMnpTK+
 9pcMLWCQ0zu7ruSXbzMbGo6VEiTPUtfHB+q32Kl1O4aqNU03MssXgZ6+GW3w3mzamMbs
 ca3bwJSdimFz3S6QtYOTHVPoVPKBfbeQ2w6ZC4W4lPT2NO2o+UJLtTR481Pp04DgzkbI
 gGTYWjbyq9r6HZO92OHtS4Zonf9BAox3BQneZuSxN2ZGg+BwsahLmxiATJMpLV3ar6vv
 rtVhDG7iDjhN+kTdZlZeadlklucX9HCcpTHMdHhv9MJlc9ZF6pAOhlcJ4ZwXeENDjJfP
 Au8g==
X-Gm-Message-State: AFuF++nMupYytkrpVW1wnJF9UUGyypmLwDJcw9/InqNoBNDmtt/MLH/Q
 fRBiBQuVQM9hyjYrvaWk7ybyDJMhK5Qtu3Pkgyubh4F2JUAYP1uU2gWKRJh9IqS0XwLOlMHr7LC
 Z8+AjYdA=
X-Gm-Gg: AYBFou0ACJX2KTjdcVsCZAEmS2FgWElWG4at4E229PAr0xCozwBrDmM2NN2x/n4u3ru
 q2t8nQYteP8Cpkl3yoxpMvkX8tsEdkTEIQHFURJwQTBRS70mWkFfdmIm6pRRBmrRagv/+eYj+wH
 abo4rcQr0y6rNIzwYddJTav6EnQE96qKMJ0ZSCUfgvNr5ZnkDP9BbN8Rp6nWj9nS/g4C95FqROQ
 uEeYOQKbi7PMt+RKUfKHbTCAv27skFiZrDcMgDWP5UlW3CsTkJXuDwp0eAR2SitdYrk4JRVA36/
 cLuTA6GclCZvbGYPbAIRqR66k/YNWkx/e4aktm4kLnK9p2UWslJ2z6LTwXjYkCqisXU6XQ3k/Ec
 ZMMV7mZyxJheGxjbqV0KzwZjXy5t4FDBmhZ5d3BHAQocDUIGEzKw5JPd5rwcHj/ci1st/gakt8N
 X9+b1x8mL7iMnoL+gdfxNAf+U0aR1OM0R9h3aXUq9qUrOxhqWdrridNs+FFjY/a8JjHnjarqt0D
 gIi8ajmcJRWpkCO67qmLYb2HqFRB4wb1uAkxrxP9f43upW+srQVMT/e/gfzIHSYzX/pxgcU2rVm
 gYxC
X-Received: by 2002:a05:600c:35c3:b0:49c:dada:f57f with SMTP id
 5b1f17b1804b1-49e821ffe2bmr32717405e9.7.1789492066650; 
 Tue, 15 Sep 2026 10:07:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] sbsa-gwdt: rename sbsa_gwdt_update_timer() to
 sbsa_gwdt_wor_update_timer()
Date: Tue, 15 Sep 2026 18:07:23 +0100
Message-ID: <20260915170735.425445-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
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

From: Igor Mammedov <imammedo@redhat.com>

The timer update helper computes the timeout from the WOR (watchdog
offset register). Rename it to sbsa_gwdt_wor_update_timer() to make room
for a separate WCV-based update helper added by a following patch.

No functional change.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20260902122646.2848464-5-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/sbsa_gwdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 0ed29faf13b..5b4f241fcb3 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -99,7 +99,7 @@ static uint64_t sbsa_gwdt_read(void *opaque, hwaddr addr, unsigned int size)
     return ret;
 }
 
-static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
+static void sbsa_gwdt_wor_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
 {
     uint64_t timeout = 0;
 
@@ -144,7 +144,7 @@ static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,
 
     trace_sbsa_gwdt_refresh_write(offset, data);
     if (offset == SBSA_GWDT_WRR) {
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame write :"
                         " 0x%x\n", (int)offset);
@@ -160,19 +160,19 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
     case SBSA_GWDT_WCS:
         s->wcs = data & SBSA_GWDT_WCS_EN;
         qemu_set_irq(s->irq, 0);
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WOR:
         s->worl = data;
         qemu_set_irq(s->irq, 0);
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WORU:
         s->woru = data & SBSA_GWDT_WOR_MASK;
         qemu_set_irq(s->irq, 0);
-        sbsa_gwdt_update_timer(s, EXPLICIT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, EXPLICIT_REFRESH);
         break;
 
     case SBSA_GWDT_WCV:
@@ -211,7 +211,7 @@ static void sbsa_gwdt_timer_sysinterrupt(void *opaque)
     if (!(s->wcs & SBSA_GWDT_WCS_WS0)) {
         s->wcs |= SBSA_GWDT_WCS_WS0;
         trace_sbsa_gwdt_ws0_asserted();
-        sbsa_gwdt_update_timer(s, TIMEOUT_REFRESH);
+        sbsa_gwdt_wor_update_timer(s, TIMEOUT_REFRESH);
         qemu_set_irq(s->irq, 1);
     } else {
         s->wcs |= SBSA_GWDT_WCS_WS1;
-- 
2.43.0



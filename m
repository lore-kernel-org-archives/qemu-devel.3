Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E59C02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZG3-0005Xa-Qi; Thu, 30 Jan 2025 13:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZG0-00058z-7s
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:27:16 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZFy-0001U3-Hw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:27:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso8499435e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261632; x=1738866432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQNs/MO88QA6DkNCjxkxynlmOBFAmoCxktVishKIMrs=;
 b=uMkq8ODrksmwCYvlOOvoohxo8L9ri9ru6iQJhmCWW1DG8WCtTSsy82rsCHpRZOWT3g
 iuBjzsxEiS3glSKiMRA5gxaF9vdn4vnU+ny7oL7eKagobtxZkcX9SQ2OcDCM0NDmbUAq
 P6SehN3p2SJqvZwJ/CMJAIMlU5abeuFrpFN4KsEH+3w+jojPugulTuNYM8mfuVJ4zBLm
 c4MhYUJVx2V6ZgW3L92KW8JjgyJhkN5h0mt62bNlvoaiTVwxXpX5kLWnfiu0lbM2FwN/
 TCvEBlftMFVqdEGaQzYFJwYttfwiSilIyngUPSQSgy1+wqHZkhyzuxQyFFYj5WOW9g/Z
 VuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261632; x=1738866432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQNs/MO88QA6DkNCjxkxynlmOBFAmoCxktVishKIMrs=;
 b=NNCwHyT7bbGoNTXqnYfJ2nQjnTXeBrB9o+V7BF0zgx15R4lYXAhMMlnMrch4QCyYu+
 MUZiC5PbliFXJiBUwSw1CyXBls2xc0mPlQrNHx9VVRcUtDrvQks2p9JVqdh0a2AcZJyu
 3e+E8pH4VFi7gNuUxF0VnqXBYvlc+6gM6xh9AC+tM9xV3ELsLsUXVpwrEgq1H8L7+hiC
 urwG5mrgEcj2raWJy/knLcIFp3kYKgL5jtGuubyCAptd3Z1GWL9kuIjeMNWOscKbjq7v
 g7tbN4ZotDe7aU1bT7tStQ1ZCrNklnPLVWbuFDLYgpkjWG+XCOfL9m8bnktByMHiWdJB
 FM/w==
X-Gm-Message-State: AOJu0YzEFHc8NM7Wf4fCzV/iIY/5o5I/ShPKTcomhuQpILHQ0NfpDB6i
 1WQ9XpmmAmZnGk1j8qgcb//mDkA5zjao10lkArc7IvxG9z3JqkkU7JXyUDDmyCIJeb/H7+GmaUL
 5r2w=
X-Gm-Gg: ASbGncs4mSf+iEHMmB01kHGmjpRtkxKjUQTD/nCi1kk+x6WHX2Pe17epxIKvm7FxyrG
 rMSipY4ZpZeIRhd6+vVuguccGTPdqqcvVaIpNa1TV+r+HSZCzJFEZwtm5k0JTu4kBlzjqfBXtyb
 Nr62rowk78g9B1xjSYCb62rr90ClsXkPaPrkMaFbp/eHEVpYsLU3SL0QPqNWXqA/ImrdJ0tRXoM
 yRkHoxRz84fQiI6Y7c8DSJ2/lHqOOHx8CSPH4JKKT+hLgqVitF7Ed9RDnyLwR+AwbSlIRiKK8LG
 0/Ed8dE50NJ31mHwqu0YRSx+GEssNz5wcYxsoKEAh9NxQyT9rOWLAjWHGUrH5kppzQ==
X-Google-Smtp-Source: AGHT+IEIBd3+ET4JHUQxgf6RyISaRZpd3bfhmGrq3dWHjkO2/YsqoyrmVAw3P/sJrGH5NUkReu3zKw==
X-Received: by 2002:a05:600c:4fc1:b0:434:9d62:aa23 with SMTP id
 5b1f17b1804b1-438dc40d296mr67137435e9.20.1738261632676; 
 Thu, 30 Jan 2025 10:27:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de2d6sm30922185e9.11.2025.01.30.10.27.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:27:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] hw/cpu/arm_mpcore: Remove default values for GIC external
 IRQs
Date: Thu, 30 Jan 2025 19:24:41 +0100
Message-ID: <20250130182441.40480-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Implicit default values are often hard to figure out, better
be explicit. Now that all boards explicitly set the number of
GIC external IRQs, remove the default values (displaying an
error message if it is not set).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cpu/a15mpcore.c | 13 ++++++-------
 hw/cpu/a9mpcore.c  | 14 +++++++-------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 3b0897e54ee..372b615178f 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -58,6 +58,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     bool has_el2 = false;
     Object *cpuobj;
 
+    if (!s->num_irq) {
+        error_setg(errp, "Property 'num-irq' not set");
+        return;
+    }
+
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
@@ -146,13 +151,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
 
 static const Property a15mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A15MPPrivState, num_cpu, 1),
-    /* The Cortex-A15MP may have anything from 0 to 224 external interrupt
-     * IRQ lines (with another 32 internal). We default to 128+32, which
-     * is the number provided by the Cortex-A15MP test chip in the
-     * Versatile Express A15 development board.
-     * Other boards may differ and should set this property appropriately.
-     */
-    DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 160),
+    DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 0),
 };
 
 static void a15mp_priv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 9671585b5f9..c522f8d4b05 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -56,6 +56,12 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     CPUState *cpu0;
     Object *cpuobj;
 
+
+    if (!s->num_irq) {
+        error_setg(errp, "Property 'num-irq' not set");
+        return;
+    }
+
     cpu0 = qemu_get_cpu(0);
     cpuobj = OBJECT(cpu0);
     if (strcmp(object_get_typename(cpuobj), ARM_CPU_TYPE_NAME("cortex-a9"))) {
@@ -160,13 +166,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
 static const Property a9mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9MPPrivState, num_cpu, 1),
-    /* The Cortex-A9MP may have anything from 0 to 224 external interrupt
-     * IRQ lines (with another 32 internal). We default to 64+32, which
-     * is the number provided by the Cortex-A9MP test chip in the
-     * Realview PBX-A9 and Versatile Express A9 development boards.
-     * Other boards may differ and should set this property appropriately.
-     */
-    DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
+    DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 0),
 };
 
 static void a9mp_priv_class_init(ObjectClass *klass, void *data)
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B0C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JH-00076T-1V; Thu, 20 Feb 2025 11:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JD-00074f-Gl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JB-0008E8-L3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso7457865e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068512; x=1740673312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O/XiTl783bAz5rJgPI//LorE7cXWW1yZR5SkkLi5r0c=;
 b=ZCbGG3WdtrXRkojh2OLV18GgJT01AreRzVJjjS0MGsr2U4Y/2b16zui/P5PjGlxXaA
 93OXo5os50jgNQ9IIf6Mvm0AYsf385daNftsMXPGX7wp+SmnWmviu1rt+OTsw8/tZb9z
 YaXySzIFe5kPQHB57edLUM9+0W1g4OtvU0s6UpUvE49WtGv5N19IUf2NAIm5ccztZNoM
 6i8rSzkC3TEYBvbI97QmADA0XWjwPrw9XW+VW394ymguuyHRUrdQ73oSW05P1upVShng
 pJRXYWoScGrtIqf7vhQMoDlQ8AoKvfzS0+bXCPTik0kXjnDsXHhrzYIOnX43npELlQta
 nYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068512; x=1740673312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/XiTl783bAz5rJgPI//LorE7cXWW1yZR5SkkLi5r0c=;
 b=s+uFJafuzNGMDA7LLHNyk8yra6dtVZ4RvjI+SeguzWxIYxv63A28Hk6ro6MAqEsg88
 wuIhAfTLpp2NTWq06JkO0rw+z1qiWf7vfv7Rn6qRtdBrCbrf6A6Ks+FRJh20fxc+ne5I
 lcdBmaWC8+zY2NR1Q1ZAYMYsTmffRh8ragCCt5NYcpRAYRTRarcUTAKKHoynvPTEfBEK
 B9Xq+RKBqtTbmxn60jvZyq47CD2nyKzR6H+PdJxIaIUoYnXHIKM4CEcMhlezobAgJRuJ
 tu79OlzWH6dMj32hcX+4gd7VgqMP3MenREIf1qReygQyOxvRtShtRhIq7x/Li536Lqij
 SnwA==
X-Gm-Message-State: AOJu0YyUY4fsM/rONnM2K6YxqhSd90eBMocyGwQqeTU/BaeOhTt63XbP
 ANl3BBpjbG+F5JPu54msIlT0kCbu1HD2nNJ8k6sVfG8xVSDSIZ4+CZCbHCxe1j1n1iuH4qXpEJw
 J
X-Gm-Gg: ASbGncvlHfMj05iYE2zgG9KhLXxYvHzK1EFakxifNKpwQVwZFF1KgDJDj0F3jcUQlVO
 md6fbknDuJKgV4Eupq/w+b0cfJ4mKIx0W4Adjlr97hnFLvF/CIOrrpyvd16lrztUXMHDWHl/jAA
 ICGZLk1aGsnipjdX4upR/wu+yI6/J4Izy4A1Fzd8NGZjKUpVq4mAeG8WSseswpPJqBvLxRwvsB6
 NUKj/F1XPX/C6s5dPHggcBhxdw/Avu/hGfBarWFCkPEcCWL5Vt5usDUGVvmwV3b62reEfDJjQS7
 PBuYnpUsziLhYqYhmmBcSA==
X-Google-Smtp-Source: AGHT+IEz2s8zviSroup4BivEG5S0WFIPSumbSDYIO34E3MAeZMIvAz+7SsYWevatI9A02Eu4F+xaJQ==
X-Received: by 2002:a05:600c:5246:b0:439:98fd:a4b6 with SMTP id
 5b1f17b1804b1-439a30e6a0dmr36494495e9.15.1740068512157; 
 Thu, 20 Feb 2025 08:21:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] hw/cpu/arm_mpcore: Remove default values for GIC
 external IRQs
Date: Thu, 20 Feb 2025 16:21:03 +0000
Message-ID: <20250220162123.626941-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Implicit default values are often hard to figure out, better
be explicit. Now that all boards explicitly set the number of
GIC external IRQs, remove the default values (displaying an
error message if it is out of range).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250212154333.28644-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a15mpcore.c | 18 ++++++++++++------
 hw/cpu/a9mpcore.c  | 18 ++++++++++++------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index d24ab0a6ab2..676f65a0af4 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -58,6 +58,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     bool has_el2 = false;
     Object *cpuobj;
 
+    if (s->num_irq < 32 || s->num_irq > 256) {
+        error_setg(errp, "Property 'num-irq' must be between 32 and 256");
+        return;
+    }
+
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
@@ -146,13 +151,14 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
 
 static const Property a15mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A15MPPrivState, num_cpu, 1),
-    /* The Cortex-A15MP may have anything from 0 to 224 external interrupt
-     * IRQ lines (with another 32 internal). We default to 128+32, which
-     * is the number provided by the Cortex-A15MP test chip in the
-     * Versatile Express A15 development board.
-     * Other boards may differ and should set this property appropriately.
+    /*
+     * The Cortex-A15MP may have anything from 0 to 224 external interrupt
+     * lines, plus always 32 internal IRQs. This property sets the total
+     * of internal + external, so the valid range is from 32 to 256.
+     * The board model must set this to whatever the configuration
+     * used for the CPU on that board or SoC is.
      */
-    DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 160),
+    DEFINE_PROP_UINT32("num-irq", A15MPPrivState, num_irq, 0),
 };
 
 static void a15mp_priv_class_init(ObjectClass *klass, void *data)
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 25416c5032b..1b9f2bef93c 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -56,6 +56,11 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     CPUState *cpu0;
     Object *cpuobj;
 
+    if (s->num_irq < 32 || s->num_irq > 256) {
+        error_setg(errp, "Property 'num-irq' must be between 32 and 256");
+        return;
+    }
+
     cpu0 = qemu_get_cpu(0);
     cpuobj = OBJECT(cpu0);
     if (strcmp(object_get_typename(cpuobj), ARM_CPU_TYPE_NAME("cortex-a9"))) {
@@ -160,13 +165,14 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
 static const Property a9mp_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", A9MPPrivState, num_cpu, 1),
-    /* The Cortex-A9MP may have anything from 0 to 224 external interrupt
-     * IRQ lines (with another 32 internal). We default to 64+32, which
-     * is the number provided by the Cortex-A9MP test chip in the
-     * Realview PBX-A9 and Versatile Express A9 development boards.
-     * Other boards may differ and should set this property appropriately.
+    /*
+     * The Cortex-A9MP may have anything from 0 to 224 external interrupt
+     * lines, plus always 32 internal IRQs. This property sets the total
+     * of internal + external, so the valid range is from 32 to 256.
+     * The board model must set this to whatever the configuration
+     * used for the CPU on that board or SoC is.
      */
-    DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
+    DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 0),
 };
 
 static void a9mp_priv_class_init(ObjectClass *klass, void *data)
-- 
2.43.0



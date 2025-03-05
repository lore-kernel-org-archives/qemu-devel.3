Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26CDC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWj-0005ue-JP; Tue, 04 Mar 2025 20:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVG-0004FP-3T
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:54 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVD-0007Ii-6W
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso40277125e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137889; x=1741742689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Set2sfoFc3dje2IS5PbM9swfOV79jqC6rF+zotZwAM0=;
 b=ZIDpw2OQJIARzgat3KsDPBCZjumOiSf9p/p7ORYZsWVw4so0bVD0fkrKUDhuH+zzY3
 HX8kjuG6P9lca2TeZH/e6YqEg6OtGCQbKcUGKDRxOZZoBTbgG+6rCB6yvj8kk5vtgg5/
 PMz/XZt/Vb/j+snbPrYUWVJpat/qVl/S1Zx7JjISgjIGkdHSA8HE3SAuuCXSBNMBbUeR
 X/1bqJMRNLrAlTfH8H1gAjKFrj2A14wFFRGVivmL//RLNbfbN+1ByGsO8KMzpz/WiYMh
 +3DfhI4XLjPcw6DNtslSZcboPvF+HhKMHae3EoY3mbrVeWP0usqh38DlywuxRNUHJoOP
 NJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137889; x=1741742689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Set2sfoFc3dje2IS5PbM9swfOV79jqC6rF+zotZwAM0=;
 b=O1r+hgqM6M+GAy5+Z+ONZZ2c7LVewWQBEFI3ImuJRGoL9R8U1OqvX0raK132ip2WV/
 IH7Ne0OXImfmFrvRbc0xUwlTwfU/xQ1BYKJt2v2BrryzLAcFpBkT/+8PrjGiJ8cnomkj
 JOcDhGHrRVwQXi45yEXVtlB/Ap65vXk3Z2ZKLrg4N5GqKQAxWP//MIEJTyyMX5RoR5Z6
 3QQzcr5/nsCysiWi+JTC5Vvd+xZvRC/R4GYqtfdufcj7N7xWI7LReF04ml3lRhvqv7Sf
 plCxztOq4DEuWG7osfQzU7ZXndXdW26POw1NRBDhekGTviIYKbtEjXxxdfxoZMvNcl0f
 Xm2g==
X-Gm-Message-State: AOJu0Yy3Sk+mGAkF/ifIech0oizXMjoj/aeNpo53HJ6lLZ3xGAVtJ6G3
 yP69uTT70V9XqwSRxUCUTvbJEvWsRphcEiIq4lV0NCHIeRzZB3w575PD9uVRJXgnHNbN2SiTe7G
 zdlA=
X-Gm-Gg: ASbGncvzReiz1RgA4vD3EOrYKepL+LeBqXsu4MbDeMQGiuYLlFDoHBZQXKHPK/MG7Am
 J2Jh3bUXWpxlbcLhii6WrqmzXYEa2G940Qf2ICT1/aiIA4APb/J6cx/W36uYy/3LPLPgyyAOFNk
 oaR/lN6OTYLSZR4rnaaQpvs9FxLQJtR/B8C4Wexb459GXaIxkTezSaQFL62REVFO8O4ozclDaGV
 UIIYL7NpQvZBHC4qYsMTdhTfj8esIZ1rlj9yEzQWfe4JYf4oQkCMgfzd5ryEcDbTyF9YWk9OsXn
 nhDa7W7M383+Pdw7lKfS1Wt6ZXEmefPIexldVTK0xzILGRDSC+jrqtTpUvjMFRj7rRAfmxREHzt
 6awGqvTeQbHLi5ElWNDE=
X-Google-Smtp-Source: AGHT+IGyHEhntCzA/vAaIHWu5e+fPZ/AED44DtJDLR6pookdHXzdq39lSo8nIjUj13xX+Jtqw9241g==
X-Received: by 2002:a05:6000:2cf:b0:391:6fd:bb8a with SMTP id
 ffacd0b85a97d-3911f740597mr682941f8f.14.1741137889349; 
 Tue, 04 Mar 2025 17:24:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a78sm18934099f8f.23.2025.03.04.17.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/41] hw/arm/omap1: Convert information printfs to tracepoints
Date: Wed,  5 Mar 2025 02:21:50 +0100
Message-ID: <20250305012157.96463-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The omap1 code uses raw printf() statements to print information
about some events; convert these to tracepoints.

In particular, this will stop the functional test for the sx1
from printing the not-very-helpful note
 "omap_clkm_write: clocking scheme set to synchronous scalable"
to the test's default.log.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250227170117.1726895-4-peter.maydell@linaro.org>
[PMD: Include component name (pwl/pwt/lpg) in trace events]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap1.c      | 26 ++++++++++++++------------
 hw/arm/trace-events |  7 +++++++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 8f5bb81c96a..3ee10b47770 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -42,6 +42,7 @@
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
 #include "target/arm/cpu-qom.h"
+#include "trace.h"
 
 static inline void omap_log_badwidth(const char *funcname, hwaddr addr, int sz)
 {
@@ -1731,7 +1732,7 @@ static void omap_clkm_write(void *opaque, hwaddr addr,
     case 0x18:	/* ARM_SYSST */
         if ((s->clkm.clocking_scheme ^ (value >> 11)) & 7) {
             s->clkm.clocking_scheme = (value >> 11) & 7;
-            printf("%s: clocking scheme set to %s\n", __func__,
+            trace_omap1_pwl_clocking_scheme(
                    clkschemename[s->clkm.clocking_scheme]);
         }
         s->clkm.cold_start &= value & 0x3f;
@@ -2335,7 +2336,7 @@ static void omap_pwl_update(struct omap_pwl_s *s)
 
     if (output != s->output) {
         s->output = output;
-        printf("%s: Backlight now at %i/256\n", __func__, output);
+        trace_omap1_pwl_backlight(output);
     }
 }
 
@@ -2470,8 +2471,8 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
         break;
     case 0x04:	/* VRC */
         if ((value ^ s->vrc) & 1) {
-            if (value & 1)
-                printf("%s: %iHz buzz on\n", __func__, (int)
+            if (value & 1) {
+                trace_omap1_pwt_buzz(
                                 /* 1.5 MHz from a 12-MHz or 13-MHz PWT_CLK */
                                 ((omap_clk_getrate(s->clk) >> 3) /
                                  /* Pre-multiplexer divider */
@@ -2487,8 +2488,9 @@ static void omap_pwt_write(void *opaque, hwaddr addr,
                                  /*  80/127 divider */
                                  ((value & (1 << 5)) ?  80 : 127) /
                                  (107 * 55 * 63 * 127)));
-            else
-                printf("%s: silence!\n", __func__);
+            } else {
+                trace_omap1_pwt_silence();
+            }
         }
         s->vrc = value & 0x7f;
         break;
@@ -3494,7 +3496,7 @@ static void omap_lpg_tick(void *opaque)
         timer_mod(s->tm, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->on);
 
     s->cycle = !s->cycle;
-    printf("%s: LED is %s\n", __func__, s->cycle ? "on" : "off");
+    trace_omap1_lpg_led(s->cycle ? "on" : "off");
 }
 
 static void omap_lpg_update(struct omap_lpg_s *s)
@@ -3514,11 +3516,11 @@ static void omap_lpg_update(struct omap_lpg_s *s)
     }
 
     timer_del(s->tm);
-    if (on == period && s->on < s->period)
-        printf("%s: LED is on\n", __func__);
-    else if (on == 0 && s->on)
-        printf("%s: LED is off\n", __func__);
-    else if (on && (on != s->on || period != s->period)) {
+    if (on == period && s->on < s->period) {
+        trace_omap1_lpg_led("on");
+    } else if (on == 0 && s->on) {
+        trace_omap1_lpg_led("off");
+    } else if (on && (on != s->on || period != s->period)) {
         s->cycle = 0;
         s->on = on;
         s->period = period;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7790db780e0..f49cae1656e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -1,5 +1,12 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# omap1.c
+omap1_pwl_clocking_scheme(const char *scheme) "omap1 CLKM: clocking scheme set to %s"
+omap1_pwl_backlight(int output) "omap1 PWL: backlight now at %d/256"
+omap1_pwt_buzz(int freq) "omap1 PWT: %dHz buzz on"
+omap1_pwt_silence(void) "omap1 PWT: buzzer silenced"
+omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
+
 # virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
 
-- 
2.47.1



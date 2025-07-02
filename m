Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57BC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2eF-0000R8-CC; Wed, 02 Jul 2025 14:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dx-000819-LD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dv-0002cb-Hl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453608ed113so49565785e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482633; x=1752087433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHMs7nmOn+MVUxcnTbQfOV+3h+SOD8dybVNBbhpVafQ=;
 b=egSYonxgi62P6pCkkZ5TPfkiVZyQgP/YeF3buw+M45/2QFTVor7QHy3naF179RUdyA
 H4ZsAyqRbMPqri3Jg3UGxlxa0zyHKwUgSLUuxxzITFNnOSE8NtL3Vgkzat5yspnM7e7r
 4v6lxkGl3N1MLfYy4seEkfOGqJFlNC1Lg0RyoBrt+eZbrjBrWEwQ2jH5YYHswiu9eRIj
 QyZgdEMo28No1UEqwDJOIZpiwfvMtRZZG88SUSbOBvdWgAj6V84nPVTwoaO4a+xgAS94
 SjYf2b8mNDVBdJ749VPstHSuceLygIB5QOtyuHbdg3C6rHOeMbAC9EJ9C+n2oUFsTJAg
 VOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482633; x=1752087433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHMs7nmOn+MVUxcnTbQfOV+3h+SOD8dybVNBbhpVafQ=;
 b=MYxqCuypUC/vee5B1uNgjNPGyUSizGl5w7bH1gv5w8GzZPSkl7LRylKw3HWFNKPcTL
 oX5wdTaDdp/hWscdfXzawFYbooq+WGH0mx4Lc1vXOEYw8PVK5JVcMAGzF1q0nKlZ9ixh
 ASiipPjn1QCqhW19iXOheSbJsqBFCrfm8GjuXK68hrBNxuJWKV5FgSfoQ+E7W9FDk9UB
 rjSYT3/8FGBWucqcwCGJUBDWj0A2E4OOnl+ol+OUNux78a1wbj8Wlo4JpRTm2Iv7udhF
 UV07h7c3Kmo2jHlGzltqsq7VbIccU33G1plr6eah6wfbJAVuUcWEUz65SNKM4Q1V4CsL
 ziJw==
X-Gm-Message-State: AOJu0YzWelflcW2Usg1RgUysFNLq18o+weZnblAh1Q8kHl4fi+GEI7yB
 /HNsItOdXiNd4za0KifLwXD6Qrnp5cQGysWIJG8+r3R1CQRAqLy0b/fEsiTDPyjvgMYf70IVyhm
 xOZCZ
X-Gm-Gg: ASbGncuHh1GEI2q1Fp/nQ2g8IYrwq+ZrAZURTsNwo5EExqwVNr773F9bYXnWPr54KPS
 yX3v2gs4ZJI9lEgbl7whQf0VlO0kKYLHdearDpMOJnO0AHxja9nA9xWph/tq0OnmGGO3tM4M7cD
 GGF+3G6ZS5IHKV/SwId/xHxI9oySzgTsaz3XhKc5k2+3tfEX0wcxutELbKB9bB18qtyJHfk/izn
 MW8BWXeV++Rsc4d6RVgfdu9it+VKcQDJ8kRCs0GViJzfFxi8vdxK+pVHQFWPWblaP1OZTBqXYvG
 7Kl/3cHlasAOOf7gMPW1XY0Nuv/VEhgFr72KudJAMFGZzjUxFaIfeMFsUPtJ3SFOqRgKi/G7PWG
 y8qTDSoJ74CoLAB7KQJz8BsCGyzUQSxrE1fi9
X-Google-Smtp-Source: AGHT+IH0EBZAF5mxNPdzZ6QDlkWdmeN/ur29UrzcihgymRQv0jlnVKFm0Li9xAqFrt88eOgE58Lvcg==
X-Received: by 2002:a05:600c:8883:b0:454:ab1a:8c2a with SMTP id
 5b1f17b1804b1-454ab1a8eb6mr370505e9.24.1751482633313; 
 Wed, 02 Jul 2025 11:57:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcececsm5486015e9.23.2025.07.02.11.57.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 30/65] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
Date: Wed,  2 Jul 2025 20:52:52 +0200
Message-ID: <20250702185332.43650-31-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

hvf-all.c aims to contain the generic accel methods (TYPE_ACCEL),
while hvf-accel-ops.c the per-vcpu methods (TYPE_ACCEL_OPS).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 29 +++++++++++++++++++++++++++++
 accel/hvf/hvf-all.c       | 29 -----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ada2a3357eb..be044b9ceaa 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -50,6 +50,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/queue.h"
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
@@ -492,6 +493,34 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
+struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
+{
+    struct hvf_sw_breakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
+        if (bp->pc == pc) {
+            return bp;
+        }
+    }
+    return NULL;
+}
+
+int hvf_sw_breakpoints_active(CPUState *cpu)
+{
+    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
+}
+
+static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
+{
+    hvf_arch_update_guest_debug(cpu);
+}
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
+    return 0;
+}
+
 static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
 {
     struct hvf_sw_breakpoint *bp;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 8c387fda24d..481d7dece57 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -12,7 +12,6 @@
 #include "qemu/error-report.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
-#include "hw/core/cpu.h"
 
 const char *hvf_return_string(hv_return_t ret)
 {
@@ -41,31 +40,3 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
     abort();
 }
-
-struct hvf_sw_breakpoint *hvf_find_sw_breakpoint(CPUState *cpu, vaddr pc)
-{
-    struct hvf_sw_breakpoint *bp;
-
-    QTAILQ_FOREACH(bp, &hvf_state->hvf_sw_breakpoints, entry) {
-        if (bp->pc == pc) {
-            return bp;
-        }
-    }
-    return NULL;
-}
-
-int hvf_sw_breakpoints_active(CPUState *cpu)
-{
-    return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
-}
-
-static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
-{
-    hvf_arch_update_guest_debug(cpu);
-}
-
-int hvf_update_guest_debug(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
-    return 0;
-}
-- 
2.49.0



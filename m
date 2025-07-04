Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F34EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdS0-0006CW-9y; Fri, 04 Jul 2025 06:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRy-0006C4-Fn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRw-0006eX-9x
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso317624f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624118; x=1752228918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpXNsihVON/k8tGrpfoVi+AOpyOW8UHr4r65X+dnp3c=;
 b=NBUd/qFR3FsDIMFp+yZUJehJigiwCXB3ifCnhPpMlD+zuMDJYOI5Gj+0FCn7jFQCmN
 oNGfrHA6d5kQBtr6/IUi1ns8i+P+vfgtOkRcX9v94T70uVDKH1NU3cFnHEl/ugBnXhP/
 s/U1XrXr1tpDvsUN4Hv+q3aWuKSBu07SLW1hvdwG5ZoDlMaL72GLLRtl9izERVkxUczY
 AV0RbQoKpLPEVKkL9HJGvTvElBgmmnk7Cmw3+lNV4jDsQCmUWfiwr2R5Z2Espjg5dWIJ
 IXFLkry2iJcBI8Zuo/ajZFk3G5TakoE/oO087q4bU7tt1WgWjqbqAa0OxHN4aZVJ2wBa
 cmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624118; x=1752228918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpXNsihVON/k8tGrpfoVi+AOpyOW8UHr4r65X+dnp3c=;
 b=DjU9LitTDF//drKD3cT2/+z1o+uEOPSNPFDJTfxw8/gulyCEoTXGs/GwAS4SChlMfy
 U8q0qF6S6mXbOR79iT2pO7L7TK8ZXr96gDuAuXaa8rDjABzR45DH45+tPzdAAXJx+Wvq
 ygbN4Csj/5v+fe4/iAaWfn/uZW8g0vvKInLn0ah57J5Jh8v2u0GAdUQWWUmHqLYm8gal
 XAd65O5gBQO19u8z2QPi4OW384hAkoBuy/UxcSRlNRVfuVRByiq9UNv5sB8Iv0cxbft7
 LHDjP9phYH8Ej9GNPY+AESRY1Bd75nbGGMYPLC2mDg2gERx6g039+5pTaXq5gvZqxtzN
 MQqw==
X-Gm-Message-State: AOJu0YylOj5G7lEmmvwfIBIzTmzwnKLYIBOGpy1D5fqIuWrl70O3evNC
 zmn/HJSqz/ooJ+TcyDqHGsoeX8VfuNQWtANtVdWCtRrwk+IefGtF1txcJy6KDxaijeMFXHCg42I
 JSkvAxXc=
X-Gm-Gg: ASbGncu+G/0j6gpPaL6Io52ZNY08ZeudTuAGpWsUpdi6yvETv8hOQmvPI3OIQp/Yeor
 f/Du2FvkEBKzfXzJKIum3JZIL8qgXa8/Rur81BvFiDLeG7H3k2lr80zmdzej8SOm41CFiZhaTmc
 dfVWRQ7jA0E5y9HfGMi7cIaPP9F6AxTHTKbUoRxC9tlLOBsXatDf90DgQ3zUL/krwvRnwhasYnF
 4LMzzy5wLEVLOtFxOp9EKBxgKAYf2q8kpwYOcB02gL+imKZwU+boLyVWAykqpfyp19Lu2dl9dNi
 USjUb+fQQFArRRJ5r8vy7UcemS3PEG0NyQWl3Uxqd+hbl919u0CGq1/r8vx4ID4zg9AdEwxnubs
 nQ0YLwNU4Km3JWS3UG3qpIUnwWx7qBvw4SKIzzkmJ5HeYy9s=
X-Google-Smtp-Source: AGHT+IFW8PcE+ytQMFksvWx3usGvuQlPGWsEou9ztQMS6C7KJn806k0d7GXx6o2QXVdCCw8ag2wJng==
X-Received: by 2002:a05:6000:240c:b0:3b3:9cc4:6830 with SMTP id
 ffacd0b85a97d-3b4964f7c5fmr1806562f8f.48.1751624117876; 
 Fri, 04 Jul 2025 03:15:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b9651dsm2137625f8f.65.2025.07.04.03.15.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/31] accel/hvf: Move per-cpu method declarations to
 hvf-accel-ops.c
Date: Fri,  4 Jul 2025 12:14:10 +0200
Message-ID: <20250704101433.8813-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-16-philmd@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 30 ++++++++++++++++++++++++++++++
 accel/hvf/hvf-all.c       | 28 ----------------------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b38977207d2..3752334688b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -50,9 +50,11 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/queue.h"
 #include "system/address-spaces.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
+#include "hw/core/cpu.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
@@ -482,6 +484,34 @@ static void hvf_start_vcpu_thread(CPUState *cpu)
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
index 8c387fda24d..1c72c43ddb4 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -41,31 +41,3 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 
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



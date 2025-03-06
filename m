Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720A7C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTs-0001fl-OG; Thu, 06 Mar 2025 10:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTR-0000Ox-62
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTP-0006NS-IF
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:24 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so9729865e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276162; x=1741880962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7gQL+fUXOizsPvaDiR2QJscVtgRbEO+e68iNhkxG0Ak=;
 b=klKKoksQTPsQ5yCZ5+lP/2GKoMC+co/ZDnNm0C22Y+DX02pD9pNajQc7SGooSnI0bJ
 G5eIKNxGtMNGfwpF0oFirB3BeaVjooHyDw54qxPp75wCEUvsXWEDtKgqV9Z3UhYW7SE1
 ANVFtF/oWVeLrXygSzY1Gj22FReVSf9KFcVgdU0HkUeWiLUq8UV+M5uZ1/dpeSoiWnGX
 QNwPYLcFjOmWrQYYMlnxyk1wg1tl2bmUBBfJ4l/6xiYOdeWPJJ/wAUg40MIVigcKpuRw
 uVTdkPP+QkAw8uAzL16w5iStSFvlYbPz2/HcbFPbL6hNtFyMqLNM1DOkFWq+Bt+hLbMw
 0fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276162; x=1741880962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gQL+fUXOizsPvaDiR2QJscVtgRbEO+e68iNhkxG0Ak=;
 b=S0iWBHzyl+uRSwZ11E2uAmOzKKtkUjKYaGRDH692SMH+J7VhkFy4GkCMwyA5SVEVE3
 qLaAkZDQ84lrvc4N0gmv1SXnIFkrVnFlqim6VA1madcX89rH0c5ysGa6LKKpVnl239tY
 gWwd+EtkSgCUjkAaoJbtKuLyKujIdKgKz/4vd8d7dyVhQRl2VTRcXOrQeaZS6Dq2QdWP
 5/VaS41t91qYMTN1nmSpubRGVfUPeTMW3I6h1iIfa6DWddfte+3/zUvzMZd7KAeEFzKC
 ghIJ7fKdRbmg5jyAyTj3winQMZoyGa80J+IHrx6G8bsjWyvL7ME6SRP0BesOCtLJO4lP
 CV4Q==
X-Gm-Message-State: AOJu0Yz/hQJVyA1DaFmFyL5MpctviNgiRmlZ0pMu5mMSfys7x417bTNd
 QPJBGO3z+7ZHVv4HB5ZzMEr0hpascs8fSHOHFqWLjRnZZ0nSTIYd6G08FCnCkjiRfjxMVMR33eL
 Azms=
X-Gm-Gg: ASbGncuJLsR/lPmmwYpNzIraBIFOhV76mx1rOdB0BrSkkQGb+S8x9izcjzlpVsyBP2b
 0/FQUXWpDw2ltefYr32NwqMqUr8ngoMafUlqEjlNsfcLhcsqGA49D4SLQEz+gkht+KGzi5fbcQt
 WRsj2jKHiRSHIkUIaPXhV1WRpeoqUlEGF7A6a0qROE2EAxCB3/SekAQNxtcj95rv5SNAb5DTVvA
 z6QPaNRvPFVpljuoaynu48beUkT4yDXVHZerM0seDnUXvkkJsDUjvddZx74QsPp0C798baPv/Rm
 YuSfz17kiGSaneUeWmqj1IiI7V2c0c5ywPcO6vXhs5/S4v2RB6RBoWjlUgxugx47xWKAS5qBkpB
 CegN+SDXom5MZ/HnpTsc=
X-Google-Smtp-Source: AGHT+IHI5bm8Q2OvpeafvKTe7+ygU6pEWjyJsA32DtcgZQzug5v9fTlo3D1R1UG0HoGPhfqRAw1kDw==
X-Received: by 2002:a05:6000:1f82:b0:390:f75e:f815 with SMTP id
 ffacd0b85a97d-3911f7543a6mr8563839f8f.23.1741276161875; 
 Thu, 06 Mar 2025 07:49:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f57sm2411276f8f.91.2025.03.06.07.49.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/54] cpus: Have cpu_exec_initfn() per user / system emulation
Date: Thu,  6 Mar 2025 16:47:05 +0100
Message-ID: <20250306154737.70886-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Slighly simplify cpu-target.c again by extracting cpu_exec_initfn()
to cpu-{system,user}.c, adding an empty stub for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-19-philmd@linaro.org>
---
 cpu-target.c         | 9 ---------
 hw/core/cpu-system.c | 7 +++++++
 hw/core/cpu-user.c   | 5 +++++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index f4c834fd26a..5aa6c4b0c63 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -24,7 +24,6 @@
 #include "migration/vmstate.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
-#include "exec/address-spaces.h"
 #endif
 #include "system/accel-ops.h"
 #include "system/cpus.h"
@@ -175,14 +174,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     accel_cpu_common_unrealize(cpu);
 }
 
-void cpu_exec_initfn(CPUState *cpu)
-{
-#ifndef CONFIG_USER_ONLY
-    cpu->memory = get_system_memory();
-    object_ref(OBJECT(cpu->memory));
-#endif
-}
-
 char *cpu_model_from_type(const char *typename)
 {
     const char *suffix = "-" CPU_RESOLVING_TYPE;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 1310b4203fd..e511507e13b 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
@@ -187,3 +188,9 @@ void cpu_class_init_props(DeviceClass *dc)
 
     device_class_set_props(dc, cpu_system_props);
 }
+
+void cpu_exec_initfn(CPUState *cpu)
+{
+    cpu->memory = get_system_memory();
+    object_ref(OBJECT(cpu->memory));
+}
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index e5ccf6bf13a..cdd8de2fefa 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -25,3 +25,8 @@ void cpu_class_init_props(DeviceClass *dc)
 {
     device_class_set_props(dc, cpu_user_props);
 }
+
+void cpu_exec_initfn(CPUState *cpu)
+{
+    /* nothing to do */
+}
-- 
2.47.1



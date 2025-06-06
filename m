Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEB8C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaD8-0006RF-8m; Fri, 06 Jun 2025 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCh-0005xE-0L
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCf-0003Rd-1m
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:46:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so1230461f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228359; x=1749833159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwxS6tGZTBGZ4r+Yv78QnnlZaFN0K0U25unYT1xV8tg=;
 b=X+l92fH4QjokPYM3ltqPbj9NGQWusb3ojs+8gziS5UKk6g8YA7xaNeLR63vyh9EDDs
 5DOHWl7bBh0HS85XFla+h23kHI/0ckvU0YSKk4QP2cMhsla9ILFFXxsnA6fxaTSuld+Y
 kX7MIu82ArKfZzFmi3mzMcYpWFSQyhKPvm+2maYRTaWMemaeplp1zBW97vwA3jXV4lPg
 sWtAO1FR8GozqBZRn2WMEsKhpXkgzacMuyID6D+3s2lE4CjrAUdiIaI4KtVZqQ5cV9r6
 UJ9N7hxjAEuFV6z+cNaSoAwHVWmUid1cJfnPjZmpcqTfa+8BNSif3jklDNqz2Js+Z43K
 uIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228359; x=1749833159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwxS6tGZTBGZ4r+Yv78QnnlZaFN0K0U25unYT1xV8tg=;
 b=g6qGdKNePVXCG5/tc09JWHrAj6SHYL1cxVBGqBUbg1XchRAWcmoc7NqJ57YDHAKDO/
 Ti6aOWeG+Ij8OyfK4gaYKas+J57+SBIWhP5nXyJvkX/JbpBIFQiHFxK3mPZHHWHocgJ3
 tEH/dmrd5pebeHJGnKRGUANkcEU/X8lo/tyyi59zhRLx0mDpKgtkwZTVNDn9bhmIHs2v
 IOsWHbSo27BWuKAhPiJxWa1bi4OPLT4ZlK8NxJDEiHtEvMC4XLKjzdw0PZHUn9RVGi7Y
 Zg3KM3KBP/KOzlluo3FL+ThWqcrFrFeN78VdklmgUEP3/EtV7mpw0xeHrrEzaG15osaf
 U29w==
X-Gm-Message-State: AOJu0Yw2131KFVjYxuisIfr1NTKPyhU5zqT45dxLVZmpfcxeoDiFQX4b
 b7NjWdFCuddaD6yXf/FaJUnzmheQFEFjUSqBMy65cUV1QR6laVIRFwf/I0lS8Ibyp/gHKJb8QFb
 4nZYCOYQm6w==
X-Gm-Gg: ASbGncvmrTZ+15Y5V4+u2gf1y1pXo2FflAEXx/juqZLcmva6pFKP5uJPCuZdW6LYt12
 geMHBwC1CE4KhYEiSeNczAPTON7bqIAShQblc9PTrF5wRmuPMNBejr0vpjJMFdkOqoHiZftXfPq
 Ivv1TUiEXwPScWIBXi/VPj+CMIRToovQTx5btUxnADOvjs+9R8G9DBhaJEJeUgjjMTInWt7U8qR
 rPx5zVN+jrP50jgPT2UPHLQ5NL5SRVBYhjNRidtNkzxTAlcPGr1ZGIox12Go7k3DAgU+DLpXH5b
 KN5X04gSyrWtoH6kZUE+agN/xEji1RW9pApODNfDFO1D+d4w8DtVzoFNXeF2AcnqW+Ui0GQTjwA
 xPCIvuzfFxpVm6dHgRy+2pk8J0hzX7vGxUy08+g==
X-Google-Smtp-Source: AGHT+IG4SC6b/prO8grC06Fyujv0dozi6SX5wubmWB35gjpsLmmWO0Fruyy7K1QksvT8hUk2MrB+AA==
X-Received: by 2002:a05:6000:1a86:b0:3a4:f723:3e73 with SMTP id
 ffacd0b85a97d-3a531caa50cmr3448182f8f.16.1749228358894; 
 Fri, 06 Jun 2025 09:45:58 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d66dsm2362103f8f.70.2025.06.06.09.45.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 13/19] accel: Introduce AccelOpsClass::cpu_thread_routine
 handler
Date: Fri,  6 Jun 2025 18:44:12 +0200
Message-ID: <20250606164418.98655-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

In order to have a generic function creating threads,
introduce the thread_precreate() and cpu_thread_routine()
handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h |  2 ++
 accel/accel-common.c       | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a6535a07343 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -37,6 +37,8 @@ struct AccelOpsClass {
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
+    void *(*cpu_thread_routine)(void *);
+    void (*thread_precreate)(CPUState *cpu);
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 6bd4ef47c2c..39eb2b2c1be 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -11,6 +11,7 @@
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
 #include "system/accel-ops.h"
+#include "system/cpus.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
@@ -104,7 +105,20 @@ void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
     if (ac->ops->create_vcpu_thread != NULL) {
         ac->ops->create_vcpu_thread(cpu);
     } else {
-        g_assert_not_reached();
+        char thread_name[VCPU_THREAD_NAME_SIZE];
+
+        assert(ac->name);
+        assert(ac->ops->cpu_thread_routine);
+
+        if (ac->ops->thread_precreate) {
+            ac->ops->thread_precreate(cpu);
+        }
+
+        snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/%s",
+                 cpu->cpu_index, ac->name);
+        qemu_thread_create(cpu->thread, thread_name,
+                           ac->ops->cpu_thread_routine,
+                           cpu, QEMU_THREAD_JOINABLE);
     }
 }
 
-- 
2.49.0



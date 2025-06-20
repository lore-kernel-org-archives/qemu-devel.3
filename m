Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74031C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfLo-000313-28; Fri, 20 Jun 2025 13:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKw-0001r8-S0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKv-0004W0-0d
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so11161455e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439731; x=1751044531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aE4GKmwZeWavng9177kIID/vxobtbpAfmb76z/Q9fgI=;
 b=nCvv5xNgZR/BvWOEdUr6TzJnK+D9V/cENmOBg1vN8mlY+0AuP5T2TRWJlONxopv/KC
 T2AD3kZXdrBmq5m37RAQtixYAdasGE0hndj8vH+4BoXG/XvZDIvl10r9VALtSNdc+F7N
 1roeoWmnG1LoQkoJJVLw//O6Oain+bjh689oy0bn3zCB9XREzXWmK/NzhOktFzRwXLX3
 pg68x2ZLHex87VupkA9If9MGT8gkHOABMwWENYgHaF+5NOUW4k2xfu7hT/V4gWHo1UXJ
 598LDbZ3Q9903LuDpfXYugsNOLszWtGD/v+pCKj5OZcz0ar9HdicOCmv+nvMN1Z9qGvb
 yINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439731; x=1751044531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aE4GKmwZeWavng9177kIID/vxobtbpAfmb76z/Q9fgI=;
 b=E3OISSrmRtyU2sFVgCRqs+cRIRFJMMdzawOX/QPeddVvMAyk0+nuCgQ6Y9M3UK2Fmw
 A/kc4qHOWqatAFebKWuLhsHywYCivcFwXIBG+kAb3JtDiM1yOrPcgCGoZrLLGrUy1+tQ
 8R2W1jJJk+AzcafWakx53nkQ9YLU6TjK5kG08VO8e1bRUkLDp54Qc7DX+UVVpBUM99+E
 4Kl6aAxyKUEVIuBNqloANCdIxeffTO7kQSDCtZ0U9fitZg4RdJSJaTL6u/6bMs3nFEk+
 z+Rrtuu34qm/SHPvpj9vzv2xnujHrAanlvcSMmqQmfI17itUf+XVXxTOj4mVUIkaqpQq
 bZEw==
X-Gm-Message-State: AOJu0YxtqXMP3mAzSs+PU9tJJSQpXulJfoMa0Ug7PyDZgFy66o2bQDuI
 2bMDIuAE7K+ernkXWBUjJGXEOZdEREMkUOLcogBEwXHk/AaXdV1AoiOKqo3gdTvZzcQ2Pgm4U6t
 Xwi5BoDo=
X-Gm-Gg: ASbGncvPvmfpLvJU54ZBqGoyWhbYRoSW752gobdbiD667n1ehPs8lN+HWRH8gJ7Oshh
 Wjbn9Xg0NPiWEcj1fdOmVOMv2jn3v/dr5tEXZJSzbzoQZFNpSDuf0dGrw2g08HKax+Mk4sIOkM7
 UqNr1tjbo0AcdRZnbHvgd2zoHtBfxFq5IaRB4xQFiKkGYXIKiGsnEwxYYWvRMTGFjDZ5EkgPAXo
 OVVKO8TpTuPROixa8acv5Iy14eRkyxhPp9FZvUQF09pQNQSD+813LFHefoABCqf6U+PngZ4e0P4
 BGsJoGZN0cMv/zgLB/jklZERuIeLwguFAoUQ6heyvDfkxIhgKI01KK3L/5LmsqxZA/It6hPwSQO
 lVAKebselNBWfG+GbhQDbWDRYMPpt+/MFh8/l
X-Google-Smtp-Source: AGHT+IEINV7qYD1eoIUbwDQ5qMztZ1xJLv4YGMrN9xiDZaNysJbRLNsJxqqvqKdMn5Q2khXhCnDfXg==
X-Received: by 2002:a05:600c:c48e:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-453659c3bbamr31961325e9.1.1750439731002; 
 Fri, 20 Jun 2025 10:15:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535969dc4bsm41902615e9.0.2025.06.20.10.15.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 22/48] accel/nvmm: Replace @dirty field by generic
 @hwaccel_synchronized
Date: Fri, 20 Jun 2025 19:13:15 +0200
Message-ID: <20250620171342.92678-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 887534d4ca6..5c8e2857a8b 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -30,7 +30,6 @@ struct AccelCPUState {
     struct nvmm_vcpu vcpu;
     uint8_t tpr;
     bool stop;
-    bool dirty;
 
     /* Window-exiting for INTs/NMIs. */
     bool int_window_exit;
@@ -508,7 +507,7 @@ nvmm_io_callback(struct nvmm_io *io)
     }
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->accel->dirty = false;
+    current_cpu->hwaccel_synchronized = true;
 }
 
 static void
@@ -517,7 +516,7 @@ nvmm_mem_callback(struct nvmm_mem *mem)
     cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->accel->dirty = false;
+    current_cpu->hwaccel_synchronized = true;
 }
 
 static struct nvmm_assist_callbacks nvmm_callbacks = {
@@ -727,9 +726,9 @@ nvmm_vcpu_loop(CPUState *cpu)
      * Inner VCPU loop.
      */
     do {
-        if (cpu->accel->dirty) {
+        if (!cpu->hwaccel_synchronized) {
             nvmm_set_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->hwaccel_synchronized = true;
         }
 
         if (qcpu->stop) {
@@ -827,32 +826,32 @@ static void
 do_nvmm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_get_registers(cpu);
-    cpu->accel->dirty = true;
+    cpu->hwaccel_synchronized = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->accel->dirty = false;
+    cpu->hwaccel_synchronized = true;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->accel->dirty = false;
+    cpu->hwaccel_synchronized = true;
 }
 
 static void
 do_nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->hwaccel_synchronized = false;
 }
 
 void nvmm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (cpu->hwaccel_synchronized) {
         run_on_cpu(cpu, do_nvmm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    qcpu->dirty = true;
+    qcpu->hwaccel_synchronized = false;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CBBC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNpd-0007Sb-RR; Thu, 03 Jul 2025 13:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpT-0006mA-Q2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNpR-0000ck-7d
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:34:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so26449f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564071; x=1752168871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWKEWRHQpEpbh6ailemJvHhnr8Dm9jf2WfUx6in3sZs=;
 b=m3QMR9mFFgDweC1nuI6a8DtrocSETTj8TiwgO7eSdXcmZzGPexPTtYNl/npKuxb6xC
 GYjyV5Xqi/Z+5h9LWb66ygRK0KgTmAVJ41oIWNQ50wYLXl7LbscZQNzHJdZW/gJMseuz
 6+teu8O5z1C5LOHf6C+XyaznbCKQXf2Roy+0DozZcP/s0iPKd70/WRSHAb93haLRaqAp
 qr74fvQYrpOC9uDb1uHc7pnV+TGrKcRDiRT6H8QX5jKM0tkFT0xBaCthnYzOT9OUP/d0
 XPSOCWM9TmOAjPgPH0C4rDgniLKpTAleXn7HGB+gSJR7eOeZgSmVMAAs46AodPuJW1r/
 zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564071; x=1752168871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWKEWRHQpEpbh6ailemJvHhnr8Dm9jf2WfUx6in3sZs=;
 b=qPAnsjLHBVuCQJDATeuziUF9vAEUChrQvhQadnrikLL9b0sTlpULTLCWkx0QsuAr1h
 EZvvardzD2eRtwlGa/5GqjQ/mHQnewaSFWEbtKfr06FcbCbu1xqg5h0F+567KKh6Kfch
 k3ZuaAHDNS+/X40AGiqRw2gEnLno5hI5DvV8cVbzGC5m57l+3mfo4aq5H79xNMoxwIxF
 oR7I0jFaqiOo02E0pZrP3pHGWnzygEko3dMDMSemmuiY0J4QzMacwKEWg+2o6nbE/hAE
 R1ED2nxgm7JTHZKR1QKBSj8F3S75TdbgFWP3GPH4EHLrj31BNlBzPnHM4jRH/9qFkyak
 7vMQ==
X-Gm-Message-State: AOJu0YwZnKsOGA1fjg70h2SFWhXOgqIP43rTaHFU0p82m+U5mgjj9IWD
 Ub4F+8bVYoER2AgjgycVjSJVL6z7Pxgyb6Vk3EoWYiU0gv1r3D8LGO/a5EWtlaoYozUHbULVLqc
 RMwY7bgs=
X-Gm-Gg: ASbGncv56zhVkUARFaReyPC+rrKwwXN8Y37VpWdK9O8v+kYQn+M+aLyP4FBvxfncgrK
 PaKd7fyLPnUkvmN0jdQSnvvTr9kcBkQF+teEQENiLmlplBejwFFTNtjqjnIrz0nOquj4pcSGRUm
 ySbkuZ3idJtGP6ykJEGoV7bfA/FikOLHfyeV3kc2w4fFVi+dADmz99X7G1tg67NYFuC+/8hKb6l
 RgUcJvtgHVvfnnJF+yC4rHaqOH2tNJh+tgTJ3tfrLmx+GIezF1Pyxav+VilESETy6i8BB+MtFip
 C/RRSIy1JiVUSZIwtv1Gvjk6uU/n/xql1UYC8iJKqLyB/Qn4zOP1yDwwt76ap8G5TdMlLC98XJT
 3GbqBHmompfY7ZqtZqPx66Avapn4boOndskRt
X-Google-Smtp-Source: AGHT+IFie8PMVY64uuF3iyQJVp0HOVjZO76RGho0BQfImVhrebRlQMoujd3ZynngWaeIZg05hFVCRg==
X-Received: by 2002:a05:6000:1a8a:b0:3a4:f786:4fa1 with SMTP id
 ffacd0b85a97d-3b1fe5bf079mr6351189f8f.2.1751564070792; 
 Thu, 03 Jul 2025 10:34:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcf35csm32146605e9.20.2025.07.03.10.34.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:34:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v6 19/39] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Thu,  3 Jul 2025 19:32:25 +0200
Message-ID: <20250703173248.44995-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f1c6120ccf1..aea61a6fd2a 100644
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
+    current_cpu->vcpu_dirty = false;
 }
 
 static void
@@ -517,7 +516,7 @@ nvmm_mem_callback(struct nvmm_mem *mem)
     cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
-    current_cpu->accel->dirty = false;
+    current_cpu->vcpu_dirty = false;
 }
 
 static struct nvmm_assist_callbacks nvmm_callbacks = {
@@ -727,9 +726,9 @@ nvmm_vcpu_loop(CPUState *cpu)
      * Inner VCPU loop.
      */
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             nvmm_set_registers(cpu);
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         if (qcpu->stop) {
@@ -827,32 +826,32 @@ static void
 do_nvmm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_get_registers(cpu);
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
     nvmm_set_registers(cpu);
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void
 do_nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 void nvmm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_nvmm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    qcpu->dirty = true;
+    qcpu->vcpu_dirty = true;
     cpu->accel = qcpu;
 
     return 0;
-- 
2.49.0



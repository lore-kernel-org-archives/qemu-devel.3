Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6FDC83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdST-0006Ze-H2; Fri, 04 Jul 2025 06:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSH-0006J2-62
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSE-0006hT-Hn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso8370755e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624136; x=1752228936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LBoiRmSfdCqtJIqk1JKUtvtWiXDQLjURI5vrbPYAfFE=;
 b=G72pCg39CSUgiTp4Ks8RWEZUVJ8y8JxSLr4IxSJmOcr6YjoUlGN14djKU9cp5BXqc9
 p9sXKizFptdsEE8czWy5dmuZWgxc2KISsOdSoUdePApqtp9HfPka/FlLesoryNJmdtK7
 prc/iLQq3tCbYC4nFWYLkLals1NxpMO10QB7EXtsSVX1LykkFr9aU7Rbqzt3klDGX5F3
 PTnCDKmZKNfcZg1XKYx4fwD+2popTck5SskuVGCRq/aB6roIbezxOoyB/iIKjqL9+7qH
 sK8Ti7sqVWBvGsbTAmLB6zs1ahf3q4LXE0B3pT9pxU5PAz7O833lwB7rYcxak4kPIzH3
 VorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624136; x=1752228936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBoiRmSfdCqtJIqk1JKUtvtWiXDQLjURI5vrbPYAfFE=;
 b=lelAD9EuXzgVkjAyuliSI6cGDCO8gAQXYP7HF8zTqsKVIRh4Xb8a3QyAwyoDIEq7XX
 kNRZScBkGUu7lD/ZIp67YfPLWomxthtLPkIGNxym3yxo9rafFOwDuD+5hQf2UzSiVPjp
 2t3q7sbuJH8qWT3vWTep/muIhLQTRlkmDBOduJy0qdSUfcfjD17DUZHb+yN8oegJxdB6
 FjxiA42gMPZyoFjRis7KFgueGofpYa5FifYydBCvkq6D+ugsf+jwqxZCmKG64GlV5MfF
 HKhPmSRg/3vNPGsmN8KXepxEOb2iY0V6NOsbS0H5DLuLwdYIRLnwb11v5uwuRrvU007s
 9i7A==
X-Gm-Message-State: AOJu0Yw7hLqy/CVLRt1gHWwqbQkScoX2cq5eW8tLrbyNJtJq+86KmuIc
 +eZrpN6U5NRuDO+3t7QX+i3lU0fHI3kkJJ7DBUolAojMVq1Pf6HUYhukZE6w+Fdr7R+tGAGz1A0
 owG3urX0=
X-Gm-Gg: ASbGncv8vfbEQDMhEl46JdJrw+FomqEwbqErWgbzF4fmRbD7yy62/yLdVeZ2S9+fiBl
 OBOcPmqwCJeZt2Uz+WUgu90s5DnG7c71c5xGOTgWZJIs7Rb3W2OOpL+DznuR1P9dPPxtXeXgdZx
 WzItbm6ym3hw/eU/9mIIrThFFp/4A/KuRzjeukGsTssQut1Qpm6TiK5MAmyHqNd9JTQPg3EVIEl
 N2lJe8xIlrJPKOzlmIcy9pco0Jrk/D9IR9l0DM3V4PsfFLZrBzriOxSTp7fs2ktSpHk47qTV07g
 roLojHTE1Mh+RQbimtNTWWyAFlUUD5uJa609rET8/5h30QBxprEtLOsxKJDLR/zLzEvo2INNuYZ
 2EePaDjutel7zlXS7aoiV4gQ5r6ov8l3nPUa7
X-Google-Smtp-Source: AGHT+IF96hGUeYY4GTMBkgEadWYpoiiQRpfuJLjoi8QKuucYEiqlUEAF6rIZUp9QtbHwu/Hsl+IwpA==
X-Received: by 2002:a05:6000:1788:b0:3a4:f379:65bc with SMTP id
 ffacd0b85a97d-3b497038e7emr1362278f8f.40.1751624136332; 
 Fri, 04 Jul 2025 03:15:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcef22sm51811925e9.19.2025.07.04.03.15.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Fri,  4 Jul 2025 12:14:14 +0200
Message-ID: <20250704101433.8813-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-20-philmd@linaro.org>
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3F5C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dV-0006bd-Pp; Wed, 02 Jul 2025 14:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cv-0005Lo-Dq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2cm-0002Po-Iw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so177819f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482561; x=1752087361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzsXmG16DASHWsIXbw9ajDisw+zUQq9t5Ugm0qpyfec=;
 b=FDI8mkYkkMJj2ZY02b7qf2lGdT2WVZK6uXKEB3l0eI9r/ahUTqw5vEt3K88KywVjbz
 KYq/sJIG4+4NMNZZrHDRRceLh+aCBFzdmyWrMMSS3c3i/qfFu/hTC2L45RBvHQnlDwKE
 eW91e2ZOcnd3PuG8qNj9eaMGqocyT9ILA0G24NdB0DafjJgJWeP1bhPOzyGsOqLQCbaX
 XD88rRXfjoL0qXDtTFrSBVNK7kEkrbBWyALZsgBD2+0qJA1FpQ3bpNQmzroKbEBET5QE
 HW4kN02a6MRa28IkoZ0rdhh8GmRE2g+JE/jKWh1v1I14u2Zj9KwW1k16Qte8bGzgl5ub
 amkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482561; x=1752087361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzsXmG16DASHWsIXbw9ajDisw+zUQq9t5Ugm0qpyfec=;
 b=VhJWaqRZfCY7HjRO1YC4oSDUWeR/hWjdPuxpmRRxfaqK8IBUVVQ1AOBI73gA2ib7AK
 du4S9m4t5JZtAnvnwA8vyLdtgRwCBcSywWAVcneNRMDOZihwck/IHoD8gp73LlkxTs7u
 ViderCj1Nrml2/qrHz+y4AorzpWmy3xuavPlaksm/Xy/JsYdo6bqzqQjRbstQjilMY9i
 WBlqOgk2RKQ5zdA5AJK+sBO61DPPC2fo0QNYHSRa6G13eBU46xqUQA6PRViYPWILfQDR
 5hWMi2+1bTpfr8abM+vd2FtoUCDN5Z2r1Q7zbdFU7NneVOjFBwYBCesGQEMFzpDg75DP
 V2pg==
X-Gm-Message-State: AOJu0Yxmkqig8PTqCMqcOhpQNV/hCM4v2kwkxm0PdfdodNWayf6D7gM2
 hiQxHPiUhld9Xwv8zryKuxv+/aYq4ef7dQsu1a7/7sBdPNad7FOwXJiCL68fhiev+PvuWWArIEy
 umRQO
X-Gm-Gg: ASbGncugX/LjatiB2xOfnXwjuOYEw0CYmz+R2kjBtfSCDxY7FOWbqHUwalkx/evIYOY
 ELvIasMtd99e+cmPQxbh7asBllaziV8+zTfe8vIUVt36S9VBaonXv2Vp8usju7aNuAudsZ8m3G2
 +nC2Jl+TNfyuziLA86pNS11iA+iyPQGPQpc2strDaoc6pRVqvLLyuKEgiIdUB6pjL+z/B/fqYU8
 69dfK3dDjz8QqezP/zZMUTnxhE/AIl6yPZvshqlNqcV04HfyXr9g9drMxB5sX7WLKmvmFz2JmQ+
 /+5nWzgQdlvMx1ytM6cBQ3szMvdN9k4JtLKF3UEJbLoe8wxJfYeZW0rUF0KoHLm7ZYJXtxN7Lp5
 59IyjHwwkFrA994MMY6Tk/n7efOGGDTIixYIr
X-Google-Smtp-Source: AGHT+IEF1tTk86ccYTdarFhiAEmWKm8S2IzmjyE8HZJQDughNZMfUx9lbMJhMCOJZBt7ovs4/JJLQA==
X-Received: by 2002:a05:6000:2308:b0:3a4:eb7a:2ccb with SMTP id
 ffacd0b85a97d-3b344322dfdmr15439f8f.16.1751482561197; 
 Wed, 02 Jul 2025 11:56:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fb20esm16984289f8f.36.2025.07.02.11.55.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [PATCH v4 20/65] accel/system: Convert pre_resume() from
 AccelOpsClass to AccelClass
Date: Wed,  2 Jul 2025 20:52:42 +0200
Message-ID: <20250702185332.43650-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Accelerators call pre_resume() once. Since it isn't a method to
call for each vCPU, move it from AccelOpsClass to AccelClass.
Adapt WHPX.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h              | 3 +++
 include/system/accel-ops.h        | 1 -
 target/i386/whpx/whpx-accel-ops.h | 1 -
 accel/accel-system.c              | 9 +++++++++
 system/cpus.c                     | 4 +---
 target/i386/whpx/whpx-accel-ops.c | 1 -
 target/i386/whpx/whpx-all.c       | 3 ++-
 7 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 518c99ab643..065de80a87b 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -47,6 +47,7 @@ typedef struct AccelClass {
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
     bool (*cpus_are_resettable)(AccelState *as);
+    void (*pre_resume_vm)(AccelState *as, bool step_pending);
 
     /* gdbstub related hooks */
     bool (*supports_guest_debug)(AccelState *as);
@@ -86,6 +87,8 @@ int accel_init_machine(AccelState *accel, MachineState *ms);
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
 
+void accel_pre_resume(MachineState *ms, bool step_pending);
+
 /**
  * accel_cpu_instance_init:
  * @cpu: The CPU that needs to do accel-specific object initializations.
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index fb199dc78f0..af54302409c 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -47,7 +47,6 @@ struct AccelOpsClass {
     void (*synchronize_post_init)(CPUState *cpu);
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
-    void (*synchronize_pre_resume)(bool step_pending);
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
diff --git a/target/i386/whpx/whpx-accel-ops.h b/target/i386/whpx/whpx-accel-ops.h
index e6cf15511d4..54cfc25a147 100644
--- a/target/i386/whpx/whpx-accel-ops.h
+++ b/target/i386/whpx/whpx-accel-ops.h
@@ -21,7 +21,6 @@ void whpx_cpu_synchronize_state(CPUState *cpu);
 void whpx_cpu_synchronize_post_reset(CPUState *cpu);
 void whpx_cpu_synchronize_post_init(CPUState *cpu);
 void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu);
-void whpx_cpu_synchronize_pre_resume(bool step_pending);
 
 /* state subset only touched by the VCPU itself during runtime */
 #define WHPX_SET_RUNTIME_STATE   1
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 637e2390f35..11ba8e24d60 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -62,6 +62,15 @@ void accel_setup_post(MachineState *ms)
     }
 }
 
+void accel_pre_resume(MachineState *ms, bool step_pending)
+{
+    AccelState *accel = ms->accelerator;
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    if (acc->pre_resume_vm) {
+        acc->pre_resume_vm(accel, step_pending);
+    }
+}
+
 bool cpus_are_resettable(void)
 {
     AccelState *accel = current_accel();
diff --git a/system/cpus.c b/system/cpus.c
index 4fb764ac880..2c3759ea9be 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -762,9 +762,7 @@ int vm_prepare_start(bool step_pending)
      * WHPX accelerator needs to know whether we are going to step
      * any CPUs, before starting the first one.
      */
-    if (cpus_accel->synchronize_pre_resume) {
-        cpus_accel->synchronize_pre_resume(step_pending);
-    }
+    accel_pre_resume(MACHINE(qdev_get_machine()), step_pending);
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
     qapi_event_send_resume();
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index b8bebe403c9..011810b5e50 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -95,7 +95,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
     ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
-    ops->synchronize_pre_resume = whpx_cpu_synchronize_pre_resume;
 }
 
 static const TypeInfo whpx_accel_ops_type = {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f0be840b7db..821167a2a77 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2106,7 +2106,7 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
     run_on_cpu(cpu, do_whpx_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
 }
 
-void whpx_cpu_synchronize_pre_resume(bool step_pending)
+static void whpx_pre_resume_vm(AccelState *as, bool step_pending)
 {
     whpx_global.step_pending = step_pending;
 }
@@ -2703,6 +2703,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "WHPX";
     ac->init_machine = whpx_accel_init;
+    ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
 
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-- 
2.49.0



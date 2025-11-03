Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDF5CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrfR-0005df-P2; Mon, 03 Nov 2025 05:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrf3-0005Mw-Qg
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:19:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFret-0003u4-02
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:19:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so34107545e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762165165; x=1762769965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGSMP/2LGUaTeDayCsmj1/W99MoL27fCEOy6TYG+rnA=;
 b=P1WPAIYbcZC/5ZEKAzqlMvT3Kiycpm0QiXrhzULxBlxzkO2gkguLWkUs6y6C1ZnvzR
 cunUl/pO7VG7rETDnN9GpnqAkJi4Knxx62/ENJgG2PJHLVEu93MlTsK9gtua0s77xCWf
 1RRCUiYSZSQfsbcC0AQ/YiONFicXR8e5Nl2kj1ogVvhTQQ4i37ro/ImY0JN8Htx68Ljy
 I5w+CAHLmDDqtLfJsy/mxfoKP/F/Da1hrIVlZdllcA5s07dWEZcQvt4lIt5jt9WK7s5M
 cPV9bogKhPtktK73U4Z5DbMBFxFwciScxIBRwfBPM9BQfW0A3xAGfWDWO7Sxuw55d3xQ
 rD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165165; x=1762769965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGSMP/2LGUaTeDayCsmj1/W99MoL27fCEOy6TYG+rnA=;
 b=rSs7dqmPj16IpcQc7IhFTGmRo6ZLNsgWiu8XlJIno5sUaDOmdMhvrOLZCJvklBXefN
 8kJXxray5r9kKpDaB7iTMqMhdjUtzueZCl5liJPvgcoCem3vA1NogTYIT/IfoWxXMqrd
 lC+Vm6JN/JURvbtgNPXBcLjQTK1re//DnKmmcgAjv92bjgocO7dsrFCDIRGOfPAE5Qya
 DRyeballPgSBXnO81FNOdM52N7Rnj/Oe/AyGX7OyWkOqpGJ6YhAVX3UPYqLJT3XVW7/O
 njKsgj89gcxB3s2VJJ3tDphopB8QSOu/A69oXe7wMh22ywbuAY5xMsnhe9NpJXYTPRfF
 SitQ==
X-Gm-Message-State: AOJu0YyiPUWZGNbCFnTmSp99xAXKfbZeXnw+yffxqEdw+pG9Ch8NxJ95
 Rb25o0hWgxyb+PuG+ST39jtHgW6OgCPWeHmxFKdBSuZwgrniF0ye/Xr/VOQUH1uGSyxdNfBbMkv
 84lCHaEAcwrI1
X-Gm-Gg: ASbGncvFaLr2Tik5LA6J7jmY1cH1jqsjQZNNjiJHZQAjqveMTOi+PjpOtiltd0hVpfA
 5KtJNyEYoVbUJxAs02iHNQO1tBL6pysehV8zItSGytQxIb2+WqwrN4GYUhc0F8im8J0EZ8cKetG
 YjEnhdRyV3PPJkF5A70josnd52pxRLZoEod92hmFQzBvxJNnfsMEDQGjzoqjLjvv6RKeL3MhVG1
 iPtUL39jPMmwIdDS2lAoGZlMfURzmmN1i7urEbpVsYQ2rFIxRvwDmQHwjHuLBprLzhHlqgWlRjZ
 ziu71nLMicWxpK0NhjJubAPCn8zRBe6GR9GGxMQebBI6j9rJgszhsyym8ot54dDoiwUrij/Vss0
 nnprnjnPJ6HH07a7mhahAOh2v4neFEidS8kb49qAbiaKE3rluQ+HwiEKiJdh+TNclwZS8kfHENS
 5lrmYcs+byYllJYvUZNSqHrghCCPHpCX3X5kM++NkjEyUmK0GCL1wpL3+Xu4c=
X-Google-Smtp-Source: AGHT+IEymGYdV8WsItyND7+doV1eIAdKJbS2/7U/v42pDsTyJN6V5G5qWijc9dS6H3OV/Cw2FpG/dw==
X-Received: by 2002:a05:600c:4f0b:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-47730797bbfmr94954045e9.1.1762165165323; 
 Mon, 03 Nov 2025 02:19:25 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c394e33sm147163355e9.13.2025.11.03.02.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:19:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 20/23] accel/hvf: Introduce
 hvf_arch_cpu_synchronize_[pre/post]exec() hooks
Date: Mon,  3 Nov 2025 11:10:29 +0100
Message-ID: <20251103101034.59039-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/hvf_int.h  | 4 ++++
 accel/hvf/hvf-accel-ops.c | 2 ++
 target/arm/hvf/hvf.c      | 8 ++++++++
 target/i386/hvf/hvf.c     | 8 ++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 96790b49386..3120a4593a4 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,6 +71,10 @@ int hvf_arch_put_registers(CPUState *);
 int hvf_arch_get_registers(CPUState *);
 /* Must be called by the owning thread */
 void hvf_arch_update_guest_debug(CPUState *cpu);
+/* Must be called by the owning thread */
+void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu);
+/* Must be called by the owning thread */
+void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu);
 
 void hvf_protect_clean_range(hwaddr addr, size_t size);
 void hvf_unprotect_dirty_range(hwaddr addr, size_t size);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 02c5d01670d..56ff259a14d 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -177,10 +177,12 @@ static void *hvf_cpu_thread_fn(void *arg)
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
+            hvf_arch_cpu_synchronize_pre_exec(cpu);
             r = hvf_arch_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
+            hvf_arch_cpu_synchronize_post_exec(cpu);
         }
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e1113e3d6ca..8d0a528dceb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2017,6 +2017,14 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
     return ret;
 }
 
+void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
+{
+}
+
+void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
+{
+}
+
 int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     int ret;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1b189efb4c7..5134f302c08 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -729,6 +729,14 @@ void hvf_simulate_wrmsr(CPUState *cs)
     printf("write msr %llx\n", RCX(cs));*/
 }
 
+void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
+{
+}
+
+void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
+{
+}
+
 static int hvf_handle_vmexit(CPUState *cpu)
 {
     X86CPU *x86_cpu = env_archcpu(cpu_env(cpu));
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41663C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcGW-0007zb-AO; Tue, 01 Jul 2025 10:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFg-0007Ok-1G
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcFc-0007VM-Qi
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:46:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso57467175e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381179; x=1751985979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6IcrsyLdnOeI596TIzbeDDuhPreoHEVrkIVko3MSBQ=;
 b=V6eHyqLOV1Y/xOPs5QiOWBcqHholPh7chFmRUdvczAV2tOCTauFl+iuETNsrY6VjS7
 12AXmjzh9B5IdBt6LakSTYIaaIr/ioKFLlWx6ivlDVs/w8dC30EEGmsK6ZTUcOqIfcEN
 s+pOZyS7rx74+gu+xT2Viz0ZitiNMpWdo6dYg9Zwy6UrYt7orY9vmSMQcRqW2SwYk8Nl
 1esXBQDL/PogZqqpsVjdab7vkYM8mC27OdLpVu0O6S1/flnmNRsZ6WHKbzdCQxmf1N0K
 DESOhtdCBjYQGxFwW9N3n004W4Z7hD0lLsvqbclFHk8nuqwMVKItmN6jgGYhc/gWqKr6
 CYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381179; x=1751985979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6IcrsyLdnOeI596TIzbeDDuhPreoHEVrkIVko3MSBQ=;
 b=bpy/raP9li0iGR2OHf9+WfVROM0SyOGwbNS83iWd5Y6dO0YFg1Leil56IQPuJpgYCN
 8XyD8YrObUpKE6td8BgCejPqxQtAFJaYTXCgAgxByM4TywI1M9o5/sA5LXBRRm3Sdpt7
 Rr25otHTKvf0coEfDGkPOZ2GbM3fup8n2KhL0NE0oRQRTBwoK7cMQLp7LlrsvDXbuM4t
 h4p5jfsvCTR9aU38gRY4y+ZIPNSI3WhmxIHPFyWHN6hXXNMawx6FPv4+B6jFWXVCgJpk
 00exLG0tH25J23jE0ELTW4ZMeqO9WhJ81v5dyTG+fbGza8++2RGmajas2fE08vXHxj1t
 3R0A==
X-Gm-Message-State: AOJu0Yw8+tEDC3wgZRUg1XRXm4nauDcXMF840TzCE6ivfKRc+QzLJyDu
 V5X2GZoq1VLiJXXr/IS+u+E8H/8Kq4Qs+soM7vj1/nmBYikzftuVsaNkV8KAGQpnkdWtuYcUyOX
 Mv+eK
X-Gm-Gg: ASbGncuMm4pyeCP1e2Cg+fzvJdXV+cBbXwgpjXpEgPoYWf7KyJiQ7/0j5uxphhxEM33
 f+yoRUz3E6C0HdjvxP1h8i8z0cYFdbPAbmHRsaqcBEqU8lTvpXCOfofct2CIkiMNkxiIyw3Ih19
 GemqgGtqyEhzuRA1Y/CZqfR2lROIQjFnFTV6wIdlcoLccPqcM0sNusVeASIg7ENI/ZS0ePN23zD
 tZQJE2aF1ZN3X95AIb2ql7McWMR9PCpSj1a+ROuVI5h8mSqh9j6Tvi+1FchMlg6xedExGD12U9u
 C02zYr7DxypVc1c4TLIp5lDpJfcvAzrsFs7qbtk62Kk3qFjYHgpNzAV18nZAFiMUOQMUCdlZPRe
 CN8RkGtoxC3nf2qClclm1b4MwJx5uK/qKQ98p
X-Google-Smtp-Source: AGHT+IFp9tVKCsbVNb2nifYv7ud+WkTLZWHRsvOxI3AmOVrV+dFXTujip9pJrV4oMyBwUCXDGht7Iw==
X-Received: by 2002:a05:600c:3b9a:b0:451:df07:f437 with SMTP id
 5b1f17b1804b1-45395177409mr168148455e9.30.1751381179077; 
 Tue, 01 Jul 2025 07:46:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6d50sm201007145e9.30.2025.07.01.07.46.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 57/68] accel/tcg: Expose vcpu_[un]register() for MTTCG
Date: Tue,  1 Jul 2025 16:40:05 +0200
Message-ID: <20250701144017.43487-58-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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

Allocate ForceRcuNotifier on the Heap.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4de506a80ca..2d31b00ee59 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -55,6 +55,27 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
     async_run_on_cpu(cpu, do_nothing, RUN_ON_CPU_NULL);
 }
 
+static void *mttcg_vcpu_register(CPUState *cpu)
+{
+    MttcgForceRcuNotifier *force_rcu = g_new(MttcgForceRcuNotifier, 1);
+
+    force_rcu->notifier.notify = mttcg_force_rcu;
+    force_rcu->cpu = cpu;
+    rcu_add_force_rcu_notifier(&force_rcu->notifier);
+    tcg_register_thread();
+
+    return force_rcu;
+}
+
+static void mttcg_vcpu_unregister(CPUState *cpu, void *opaque)
+{
+    MttcgForceRcuNotifier *force_rcu = opaque;
+
+    rcu_remove_force_rcu_notifier(&force_rcu->notifier);
+
+    g_free(force_rcu);
+}
+
 /*
  * In the multi-threaded case each vCPU has its own thread. The TLS
  * variable current_cpu can be used deep in the code to find the
@@ -63,17 +84,14 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
 
 void *mttcg_cpu_thread_routine(void *arg)
 {
-    MttcgForceRcuNotifier force_rcu;
+    MttcgForceRcuNotifier *force_rcu;
     CPUState *cpu = arg;
 
     assert(tcg_enabled());
     g_assert(!icount_enabled());
 
     rcu_register_thread();
-    force_rcu.notifier.notify = mttcg_force_rcu;
-    force_rcu.cpu = cpu;
-    rcu_add_force_rcu_notifier(&force_rcu.notifier);
-    tcg_register_thread();
+    force_rcu = mttcg_vcpu_register(cpu);
 
     bql_lock();
     qemu_thread_get_self(cpu->thread);
@@ -121,7 +139,7 @@ void *mttcg_cpu_thread_routine(void *arg)
 
     tcg_cpu_destroy(cpu);
     bql_unlock();
-    rcu_remove_force_rcu_notifier(&force_rcu.notifier);
+    mttcg_vcpu_unregister(cpu, force_rcu);
     rcu_unregister_thread();
     return NULL;
 }
-- 
2.49.0



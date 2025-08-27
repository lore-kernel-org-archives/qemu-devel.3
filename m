Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D0CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur8s0-0005MY-HE; Wed, 27 Aug 2025 01:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur8rx-0005Lq-9C
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:38:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur8rs-0006kw-JU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:38:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-771ff6f117aso1147080b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 22:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756273120; x=1756877920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdMhIp1+hv+APs6iwmimqvUCk8niLvWTzzjevOU/ip4=;
 b=WavaqESygPtZ+T1M4bOuVFkSxzKC5OVC4B4c9W+ZDfMLPeJbXZNBTfXQLKTSCAzjmA
 8UJpgEoxk09DZx6fWuItFwgXculqmI0Aj7NOI8vR8s4Kxfw0Vg6eGqx6VzfDzusC5Gjo
 o6UrlL80jC0isYMdmrR19y4aDJpoJKyZICxSZ9emQOXVD7GHgMT4QM7AoggE63qznPPF
 bqddggJhmUJv1BPbY1lUyPulUl3/eh+C1U8ksmmNnZPiZEEM2qftCsHQMTdAPtttJW67
 OiewMPSDQ1D7f5AdUBze2ZSEw8C9VeCjVczDmXBtUjhBD2m6WS1mHRHvpG/CAYPaJcxk
 7FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756273120; x=1756877920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YdMhIp1+hv+APs6iwmimqvUCk8niLvWTzzjevOU/ip4=;
 b=oyUJYiIMjlFlO9LOPY4sWQ0LHwXSyD91+vJZqfbPczrH7UFgK/iBh/FQWWOWbaRl2w
 MyXopFHs9tL+VnFdS4hiN9qRVdwICZJywE1c6kSFATH92xtVTQibdEnwGNLSSW63mWvs
 g8FFg43LojGzIuq9qUhG2fMDxuzkdsFnWWIorxIaLvAz2J5vH4gmqjsltWxPIneKY5fk
 qvYOXbQS9Z2qdtOIHc2R2vy2722r/qRopbWU1cjuIgdNX+7BXs/p7El4N3HrrFtSgf6p
 HaEv0B5XApEZvew/jAH4/Ey5YBEzWi4sfPAGIPCeMTPs+kFzX4UfWsTl2HKqRpZk68ab
 G19g==
X-Gm-Message-State: AOJu0YwX7p7aN1rzvfk2/443jPM8A7xyAP/nMeK0cYwXwCYjTyu26e0S
 jOuXJlJ8G1T2arTcYNwDS5oExomNG9IYAKIQUvJu1aJhRHbHBqwGp+OVHvY5r8p97jeu8xkpSga
 6yHpbgC8=
X-Gm-Gg: ASbGncu7Ce97f1hMfzcSg0t8RhWMDk6FqY87LbdfWE8gSgeFnLZDexlCGXAlLaoBUdC
 uIuIGAQcmIlHyD5I6tgGZ/jnIWeZhRGfSdzVZUzJ/Ts3xYFqdknYJojYgwOhQ11pzUYFZbdEed8
 D6G7/7VNMzscSnbb7qEHYO1Bg2cWylvMiFh1q12W5+EVKvDnzM4jD9fmt4HCfz52Pg6SJlba02Z
 +o/iRYOJChTvkDOm1ad0gC0F2+mlqR/BExgaJq4KDIUCj7HpptZ+DlEBMx6UbawIZ9PwXwnzSLz
 YVlUjraUTF0OAArjW/y0F28Iqzsdd04usLKuSyu8KYHL+yvzTBDW5ho4aDa6nG4P5vUZqKWyxDY
 QXKSOf/B4US16DbcDxUx22PK2lQ==
X-Google-Smtp-Source: AGHT+IH7MUhEFcCtXhNNqHuq7YiIUPCOE4bVyQOXMM3kexrPkIf9QycSXIm4LYOUzKnbbZkHm4ggbA==
X-Received: by 2002:a05:6a00:80f:b0:771:fd05:d376 with SMTP id
 d2e1a72fcca58-771fd05dad5mr4796989b3a.0.1756273120390; 
 Tue, 26 Aug 2025 22:38:40 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401af6b2sm12071868b3a.56.2025.08.26.22.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 22:38:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Henk van der Laak <henk@laaksoft.nl>
Subject: [PATCH 1/2] hw/core: Dump cpu_reset in the reset.exit phase
Date: Wed, 27 Aug 2025 15:38:21 +1000
Message-ID: <20250827053822.4094239-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827053822.4094239-1-richard.henderson@linaro.org>
References: <20250827053822.4094239-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

During reset.hold, the cpu is in an inconsistent state,
where the leaf class has not had a chance to initialize
state at all.

This is visible as a SIGSEGV in "qemu-system-sparc64 -d cpu_reset".

Move the dump to the exit phase, where all initialization
is certain to be complete.

Reported-by: Henk van der Laak <henk@laaksoft.nl>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/cpu-common.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 39e674aca2..26321be785 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -119,11 +119,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cpu = CPU(obj);
 
-    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
-        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
-        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
-    }
-
     cpu->interrupt_request = 0;
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
@@ -137,6 +132,16 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu_exec_reset_hold(cpu);
 }
 
+static void cpu_common_reset_exit(Object *obj, ResetType type)
+{
+    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
+        CPUState *cpu = CPU(obj);
+
+        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
+        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
+    }
+}
+
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
     ObjectClass *oc;
@@ -380,6 +385,7 @@ static void cpu_common_class_init(ObjectClass *klass, const void *data)
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
+    rc->phases.exit = cpu_common_reset_exit;
     cpu_class_init_props(dc);
     /*
      * Reason: CPUs still need special care by board code: wiring up
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB3BC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2gh-0006cD-UK; Wed, 02 Jul 2025 15:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fs-0006C5-06
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fo-00034f-5F
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-453634d8609so51857805e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482749; x=1752087549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WhoOlqE7V0YYD9gThfuSml4H33X/s4g/0Rif+XmbeI=;
 b=uqAR0qyCLVDV9VUjX6uUHm/rjjwZTNcq1x2w7yC8/I0MGRG5/P2vMh04tIVQ2iSet8
 +iYsXXX9LdevHLDgD2lVhnovmsIMP6iCLJdzGc4OU3rcVLBESXTw2NZM/NJO7RcLQejC
 H4gJ75DIIx0rX0plzBImCrlP72pt6p3jy9nCEXdgxpiV8ACK7HRP7KseZcXw1z2dtPm1
 736ir6QwPko+2BqwRp2xByn4G8ZtZWMhDaPKJlI+PJOUZsuIIMy0qgXSwr7nZv3XRMTu
 sMcpT0S2pYe+1siRyIQgouUg8SbtQB2qt8NQQZuBEtagOPfCQTtZUJmGKgjHFt/O3E0X
 Y2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482749; x=1752087549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WhoOlqE7V0YYD9gThfuSml4H33X/s4g/0Rif+XmbeI=;
 b=J3eqGd95KTmNPtp8dAam9/w+cjX0I370MpxyxqUHhKdRvLDaDoQp+AHRmF91psMaqv
 +T+gTDarTeB3wt6Phj0IZf8be+apx5OuemFeaxZ63IAVcSICSsCUKdNMdRPee4B8FReg
 NRJCliKi9IUqVGWReGYrpk+8Q0m4/1BJJCxKx80MWXqNNUvGdNSmF3mtzLyvHn+yEk5t
 GBYomUbkEcworsHlmO8YgkY8LtEq0A566vogfcG42h0YEqLQlOep/YtkfOGtqoxC4KU2
 AKFoEmGlEiEsZ3vARyDxS3r8yX1pHgK3Z/ModDlfbA6KCQQBRm5hjsskNYj1RPhncZvU
 TG3g==
X-Gm-Message-State: AOJu0YzbFx3VwUYSkZmMbT1JNWKvO/MfLpzTMC7a5PgXR9SkXXkJvcDX
 /EXru9RrHfMiQ8nTjuONPbmlIbJEUgAmOWpMT7KEu36S17ew0VWwrXycaEhwQkVre/c3gIPCes0
 ilNUZ
X-Gm-Gg: ASbGncsxLL3LflwutrRZG79g1ksVNtVXLMyhWuu+3CPSdWq6JuNCMW/c2/yAT1e4REV
 wGjBiHB+M0/VrzXZr4F1MkOGOZpAwD0x6QBzSlEWXnnv1j73lNEp1a7cRWSpLutXMoD15tjMZHP
 97BEcAaCDvGBFJUQ1sG9MMLmJxj8pSKbT6P3IxAj5a+wxuYhtNfPmcXDgzw2xeJsiSvB6vj21NT
 7b0DG7ps7Cenb++EUAyRFYkVRuOoJORCRMGXdTOOv9OK6K42Lgrf3aOW0KIiQK5zeBTHVnri/Kp
 aEqGrhwMTnVmil/gl+F0tppspktUDFRoOkYQRpkla/+Pw0HQIabcjlRMlLw5Py1R1oDQKZWQ/11
 aTGz6ecXuJduLgyu9GTgQCBjMrOMFAVotIg4h
X-Google-Smtp-Source: AGHT+IE5y16UFsNQIiQUNetauFumjrJWcH1KgFcTJSnEepp/EyiEww9Rf5yKD9GttIAuHYd0YqNMgQ==
X-Received: by 2002:a05:600c:1c81:b0:442:f482:c432 with SMTP id
 5b1f17b1804b1-454a370c19dmr46489485e9.18.1751482748591; 
 Wed, 02 Jul 2025 11:59:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9966a00sm6030795e9.3.2025.07.02.11.59.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 46/65] accel: Factor accel_create_vcpu_thread() out
Date: Wed,  2 Jul 2025 20:53:08 +0200
Message-ID: <20250702185332.43650-47-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Factor accel_create_vcpu_thread() out of system/cpus.c
to be able to access accel/ internal definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 19 +++++++++++++++++++
 system/cpus.c        |  4 +---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 598796bdca9..17cf103e445 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -97,6 +97,8 @@ void accel_pre_resume(MachineState *ms, bool step_pending);
  */
 void accel_cpu_instance_init(CPUState *cpu);
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu);
+
 /**
  * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d1a5f3ca3df..d719917063e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -89,6 +89,25 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
+{
+    AccelClass *ac;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    ac = ACCEL_GET_CLASS(accel);
+
+    /* accelerators all implement the AccelOpsClass */
+    g_assert(ac->ops);
+
+    if (ac->ops->create_vcpu_thread != NULL) {
+        ac->ops->create_vcpu_thread(cpu);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
 {
     AccelState *accel = current_accel();
diff --git a/system/cpus.c b/system/cpus.c
index 2c3759ea9be..6055f7c1c5f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -698,9 +698,7 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    /* accelerators all implement the AccelOpsClass */
-    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
-    cpus_accel->create_vcpu_thread(cpu);
+    accel_create_vcpu_thread(NULL, cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &bql);
-- 
2.49.0



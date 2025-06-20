Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC8C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4a-0000zH-TY; Fri, 20 Jun 2025 18:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYE-00079a-MZ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYD-0005wJ-4M
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so22252885e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440555; x=1751045355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohx4GP/5vVyUd0x0C8YOpGYH493OfMoJsrTgIcM1l3E=;
 b=VFl6lIUZLfWGzMVHn5T2rK8NI6obvZw1f6HTXGxRAQxh9SxrB90p2ma5Ac2PXveQHk
 +49e16+r1GmWa2wcswtNwQN1lqbMKp6jVMV12bEwUyrmZR7mAn1+DVWnNst8GYPJgk9n
 5eD0tGGeRU5c5JwozsKcycmlE+rjasDO7OEA011mMFUL3xG1DefeoBtp+5EU8MY+Jsjj
 iTd3BMcoLVy2RNqflMzfr8Sc+XvV+1j9yjXB9u4R6YV6wiwL5jjopuW+qFqObomC+oF1
 FWr6zDnzoXeM7oV66tHaAgE5sw3IHKBvOa/pwKbT4ZQI6fjr0UyZfPY5WrQPKKJwhFg2
 nBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440555; x=1751045355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohx4GP/5vVyUd0x0C8YOpGYH493OfMoJsrTgIcM1l3E=;
 b=hhyHR4//f86dK0vVrLDblMGg7FxMW5gH5nswd7nWkuSUM0zMD+KWP4DS5qQN0hJfwD
 QGlBJPFyEEsDHpIl1Waq0F4COgF1SBRBmRbG94WoBbXfhlKS3UKdzcidqW3br0j7FtYp
 viZFhTIVJTHXsCqFpcm5qB3aYZV6sv76YLle4+cpzD/PlPKb5ynTtZbQrgDAGkr37sKV
 LlC64u7iFExPlQAlRDlNo9CsHRdGvh98L5SynJaqb+V+iqeZic6ndI6D4lju42wU+BxI
 49T4MZIh73WSj3oeBU/KocJZ3wonHgArB2U0HYKpukcEt1nCNXeKwvKXRqHAyQy2TXHz
 GwUA==
X-Gm-Message-State: AOJu0YwasUWjkfjqyfWz0SD8IWeJ7Ot+Tsiga5K12Fjuv0yWAgxPrro2
 q4q7fTE9kzjOEc2XMapIv30QfA4SvQuGQyP55KuA+s/ud/aKmRFQFZJm8zB3MqtnRjpwC1rTzDi
 JQJ3HUBW52w==
X-Gm-Gg: ASbGnctYDndUfzoFRfuTzIOuB3P2wZytLQEfHZGDIEwD4gI6g/ugH86kKoxicdo8gK9
 g1J6YJJnSlodiS1DIHcqdVMqvVlBHu6qCc7O7al2rZjkn3d1IVSzF8lQtTC0b43RC0jfPJRIkPh
 Up7yul/0wK44MPa8/mnI1XGjWPld59RXxpykwzJXM1STVfKw4ebzZKeP55oRGJNqhZCcPLyc8sE
 cyVOhIytfZ97xIyNalX4Dv779qD0uMhbcNim1nj13TVRFDOEP0N++phC4RhBlO/HgOfrDODYH5X
 NUftLCAbupEo5y4XS9iSy2CBZFmn12XC6FNIFtk8LhBubkMaf5kVaBZiYngbdHGqIkdeZl89WAd
 C7x8BYK0jq7o7/B4A2jToDWY1il8s4XfHUjJKj0fihJyGxNCmibjbe5xO
X-Google-Smtp-Source: AGHT+IGZPAEMfhIjjYf9qL5qqNwwnHFuwR453wqzVKnyHgJMflhqIrjPJVI2eaAS+mLEvK05iiZqnw==
X-Received: by 2002:a05:600c:45cd:b0:453:6150:de2f with SMTP id
 5b1f17b1804b1-453653cc978mr33309325e9.1.1750440555161; 
 Fri, 20 Jun 2025 10:29:15 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364705748sm30865405e9.28.2025.06.20.10.29.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 10/42] accel/split: Define and allocate
 AccelCPUState
Date: Fri, 20 Jun 2025 19:27:18 +0200
Message-ID: <20250620172751.94231-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

AccelCPUState is where we store per-vCPU accelerator
related information.

FIXME: structures might clash so add padding (ok with TCG+HVF)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel.h     | 7 +++++++
 accel/split/split-accel-ops.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
index 19fb530f207..87a08454ce6 100644
--- a/accel/split/split-accel.h
+++ b/accel/split/split-accel.h
@@ -38,4 +38,11 @@ struct SplitAccelState {
     char *sw_name;
 };
 
+struct AccelCPUState {
+    char pad[128];
+
+    AccelState *accel;
+    bool use_hw;
+};
+
 #endif /* SPLIT_ACCEL_H */
diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 294ea79420e..efef0d60fde 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -12,10 +12,13 @@
 #include "exec/cpu-common.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
+#include "split-accel.h"
 
 static void *split_cpu_thread_routine(void *arg)
 {
+    AccelState *as = current_accel();
     CPUState *cpu = arg;
+    AccelCPUState *acs;
     int r;
 
     /* TODO: check accel allowed */
@@ -29,7 +32,10 @@ static void *split_cpu_thread_routine(void *arg)
     current_cpu = cpu;
 
     /* TODO: init_vcpu_thread() */
-    /* TODO: allocate AccelCPUState */
+    cpu->accel = g_renew(AccelCPUState, cpu->accel, 1); /* XXX only with current TCG */
+    acs = cpu->accel;
+    acs->accel = as;
+    acs->use_hw = false;
 
     /* signal CPU creation */
     cpu_thread_signal_created(cpu);
@@ -60,6 +66,7 @@ static void *split_cpu_thread_routine(void *arg)
                  */
                 break;
             case EXCP_ATOMIC:
+                assert(!acs->use_hw);
                 bql_unlock();
                 cpu_exec_step_atomic(cpu);
                 bql_lock();
-- 
2.49.0



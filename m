Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4225C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2h9-00074P-O1; Wed, 02 Jul 2025 15:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fy-0006MQ-Vl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:25 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2fs-00035S-TH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:59:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so4062293f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482755; x=1752087555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDEWo1rnLUm5BJBdCICU6CLKmSMFjw+gxKuOsuwVDUo=;
 b=XQQmg1cqh4CPIMbHnYaXDe91EXPHvOnV/R8GJs5nbs1eNcdQ4cAehBFxvw8k4ZpujB
 Br1Ob75reT+ukpUkWXmCkTCSsp5QD1s6Q7EEZkGo2VmXccnjZtbp/q1UA+L7VjVjbytM
 5oFqPS5Bvv7i5cMpLqxeprUFL5DfQHR5DL/uBfBHTtnp9vThhnJZuGM0THG34+wSZ7pB
 cLbXgW1Dh2StUOa/tuclzJ51Lf8X+IQFbzVC8x8t3JlZmwdHMPSUP9gjyOY6ot3rlaiB
 v94RSvfFNfif0qvBIT3cQe+ZMXGOL6LK3jNcdMIfF5jwNRZIdOdhfxX/LwC+MFDbLyC0
 lzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482755; x=1752087555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDEWo1rnLUm5BJBdCICU6CLKmSMFjw+gxKuOsuwVDUo=;
 b=Pu31rnovOUy2nxYjMDuD4oiDvXsqecFfm+1Mpvrc0OdZkiZOUV2MporOO3HZucfuzF
 dcMoYWuIpZERfaqtTyAQWrJE7dBM15xDpn2l2tRuEc9wG62SSFQ34U4lXAcCE3Lvq5fz
 VfQPNfsdLd0CSyaNmi8/rM7FOqWD3kv9WxEOhhe5431kbWZnKsNokZ4aPC7qA0/7kYlY
 twgy0lY0sE8Hb7coTOoV1BHArntgatJcG5IMd4/tsmMyx8QOh2UHGUCiFV34ABYhFXfG
 T+Fz//JGuFJ5BZKqOu5zxsWqMfCUYYpfZYFcQ0wa43bIvVjnkftHfY8/wKyJV5kFmL2t
 QQGA==
X-Gm-Message-State: AOJu0YzZg8//GxS7L2qqEFl1XJ4VYJPcP6lalIIOZViB1apzVpxVwwud
 K/+Ff77ykalrlac3Ob9QP3+hDfaHdxA8ogAoG+PIZ4wPSEbdN5rr41nG+t2eZRNnvfVxLDl3JbL
 PG2Kf
X-Gm-Gg: ASbGncula9xj8DD6sbmvNf2E9sY1sVsVshOIGwbTV3U6umA+5exTPd0v02UzXIJSCTQ
 6ly9MNmlUBoeIGa/xKSgP66P6iVvOZyQ1Wa0fmzxIZHbq5dmzUosrc3h4bLT+v2nWpQP0CCLPb2
 7KLsua4pqU1p30x7TsJ5A1kWckWKWqI6tUNUG9ZWBciQclc1vLhjO0TM8O7+u0eyEU38OXI+Mn2
 13Da4LEaVkuA3h4/RvBPWh7kvM1AC1Li+8bqJK3GsYnsKrBjkOfFtAZCITLYK8Gp3tEfB5lPj5m
 ZEFTlGzj7f1iGqDLivPFr3EQ+Wl0vu8z7pr1oMRSywYiawn6troEsDp/UMGBcGH1DVSFiH2DB6s
 r+o9SrLGSn42uolykhK6YcrVW/9jM7Fe2KVRO
X-Google-Smtp-Source: AGHT+IFG+ZiqxK9Q/VXBexyw78eyCBQcwFTBUPTcjhYWJw9yY8MoUW+JZX3pcl0jG7F5t+n865WyVQ==
X-Received: by 2002:a05:6000:4408:b0:3a4:f52f:d4a3 with SMTP id
 ffacd0b85a97d-3b32d4d0bafmr183882f8f.28.1751482754583; 
 Wed, 02 Jul 2025 11:59:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bac9dasm5439955e9.38.2025.07.02.11.59.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:59:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 47/65] accel: Introduce AccelOpsClass::cpu_thread_routine
 handler
Date: Wed,  2 Jul 2025 20:53:09 +0200
Message-ID: <20250702185332.43650-48-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/accel-ops.h |  5 ++++-
 accel/accel-common.c       | 16 +++++++++++++++-
 system/cpus.c              |  2 +-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 77bd3f586bd..d4bd9c02d14 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -39,7 +39,10 @@ struct AccelOpsClass {
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
-    void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
+    /* Either cpu_thread_routine() or create_vcpu_thread() is mandatory */
+    void *(*cpu_thread_routine)(void *);
+    void (*thread_precreate)(CPUState *cpu);
+    void (*create_vcpu_thread)(CPUState *cpu);
     void (*kick_vcpu_thread)(CPUState *cpu);
     bool (*cpu_thread_is_idle)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d719917063e..24038acf4aa 100644
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
 
diff --git a/system/cpus.c b/system/cpus.c
index 6055f7c1c5f..c2ad640980c 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -671,7 +671,7 @@ void cpu_remove_sync(CPUState *cpu)
 void cpus_register_accel(const AccelOpsClass *ops)
 {
     assert(ops != NULL);
-    assert(ops->create_vcpu_thread != NULL); /* mandatory */
+    assert(ops->create_vcpu_thread || ops->cpu_thread_routine);
     cpus_accel = ops;
 }
 
-- 
2.49.0



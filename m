Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B543C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiq-0005VC-7g; Thu, 03 Jul 2025 07:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHg2-0007HK-3B
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfv-0003eZ-06
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4657179f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540416; x=1752145216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDEWo1rnLUm5BJBdCICU6CLKmSMFjw+gxKuOsuwVDUo=;
 b=DfpvvGd++UmcgOTQ/saawpNc301mtrknPU9zWYtUJuoFD+P/mFda3jtq3jBnfPzcl/
 uKpAm5peOSNaKrx55u5fuGq1z7qvLA4GD2b5GYFAAHjOw3n9hp6FdGvt93EU4OAlZuKh
 fahqXqdwdVs42V/p7+6Vf1ty4Unq1vhcPB0u9luoXhixn64dhyGCuBoQUae/3Eegj8Js
 kG6S0kKEPnVnfJmf3MirxGJLD2+jDAkJd9HA7Yt2acMOY0zxhAqK3wcN/18Lzd0wjzev
 kIUoZVwhNzrTt94RSfTgZ0IlHCrR0oPodVbCXxJ/vsk5cpr0zFNjrR3YjSCqxym0onH0
 46JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540416; x=1752145216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDEWo1rnLUm5BJBdCICU6CLKmSMFjw+gxKuOsuwVDUo=;
 b=oeAWioKvAPAGi2b3jYPzsUd9OxuBYylIkSLnnDoATDbz5ZGqJDK7fjS8jjKR3BHZ+m
 m3wXiVPCmXqCK5Suejykn0NnO887xLP9EoESwVTRv7GJwYTEA7Y6DkG11x8EgNYD78SH
 Y1UOycNkkuaJM3l6mdosZrDcEuMrkyMe7BZXDdIbrCU4SF/8YETuz6igimEO75aKlsOA
 T2bttxb/xIps0yhjyN2C43W6bI9L3WuERaYwVZgI0HPHCw4Fx929s2y4aqk1aqpYGwd1
 yc39O5SKkzoKmA35gzVm+3vyF5TBIXVjDJi+MuLLFUm6dD6z/dP/4RkhRlWwfiOTP4ii
 QQbQ==
X-Gm-Message-State: AOJu0YzTCqlTGqdgSop0lAvrK394JlR0v4RT0ISzVLKyQf78c4lTmNde
 Ujzplg4aydyuH3f9s7W7z2VzbVuBJ+rlq0bOb6P27V9nViOK1YG+AEC3IMwORzU1MucALaePEhs
 zMSE3KeY=
X-Gm-Gg: ASbGncuoIvpqlahuziLqz/BrDMoqoif5a+mTGdzKrVuHFzvcWH+zK3Qga15fYEa89wz
 0pQU/FZ/pCpMIfs/9gy9NWkLqutaXaqvDi3IqLcVu9fbjw3g8ZdP5xJUG7lRxAOjVrqNy2ObpYG
 MBe06RL71ixPjJTnxvDhKgbc+QhAlmFIS4YnmXgziYR7RzIpuSn1O/bP0MSmrZO/lJQ80r/eI0a
 kJsAFHTsQZe50yeG/WQ2ma3rULl5db948JgPlX60iW/Orlv7c0koUfLQbGgA1mQAANqiGGtu8VP
 XSfgb53+H85H3QRpMqDknHtDmRtDvQ2j/5rVoQD1uRvqWMo3m6XQbCKBNwWUJrRLOZ3N3Bdlym2
 /5yrTVc0aCq65DPo5PbdFFQ==
X-Google-Smtp-Source: AGHT+IFhk+dJX89aeL6Cw0AQ89dfOnSUw7mCET4TWkmrNY6d5nurBwjiVVzjmOBE6Tzod4CCSgM23Q==
X-Received: by 2002:a05:6000:2f86:b0:3a4:e740:cd72 with SMTP id
 ffacd0b85a97d-3b1fe6b4e63mr4918822f8f.13.1751540416475; 
 Thu, 03 Jul 2025 04:00:16 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52addsm18165861f8f.47.2025.07.03.04.00.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 52/69] accel: Introduce AccelOpsClass::cpu_thread_routine
 handler
Date: Thu,  3 Jul 2025 12:55:18 +0200
Message-ID: <20250703105540.67664-53-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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



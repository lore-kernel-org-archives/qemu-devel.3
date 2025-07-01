Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4C3C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcEE-0004Eg-9N; Tue, 01 Jul 2025 10:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDs-00040q-Mh
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDm-0007AA-OQ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so26227095e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381067; x=1751985867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHfCnAey4lbJq0MOD37khk6LufF1VdmIrSHtcBH8U9Y=;
 b=uxdWZcUR/jIVSRs+7pgrFMeF6r4yIfy3vOLE2Tz7YOVL+6u3ElM40wCdPanX/Zu3Ih
 T4EGuOryyRZhrlk00RLDiyIiWa2Ey2tXUbUQdSCG+sXPnrLB+azTgPWrNDLPibbn/nGC
 42wlklX+RTMsuojSnXP2JPibT6f7xB+SF6tuTpRayK15FMIaOc4Tm06A7Y/LQ+KiQJpI
 lSMZRxGBCjFMstPlDOH6cfBVrS91nRjVbI61J7yfupUk/lXeq86oCe/2udhTR4JxdYG0
 clQefIPiT9Kvx2ZnG6zAN4QWZQhQBBPFa8OT73uOspRhPfQi0XvOWZgleQQHoyyhCqF5
 FYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381067; x=1751985867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHfCnAey4lbJq0MOD37khk6LufF1VdmIrSHtcBH8U9Y=;
 b=AUa+Wh4JE3+mI6XQSyuespBLeZEbVDtLSHOH4fb9FUjrQ/O4cXQTQ3AX1HromR5zgO
 0w1gNMtQe4aSYjtFXrMQRNhkqozeN+ja5smd6MKicOJY9e32NCvezKpRrB+4RckScR28
 xcBCMDkS0Vt2gclioBUgsIzNapJ3HGgylNGBLTki9ORFV2vo7k9KfA15EOoyRXhi7feN
 2kFpRbhZdEcBYzsF1fvzZ9ueS2yC8tr8luErojBl80CqU6gWfzJqRtkoOC9R4Kft6XfC
 wLm5JVWMtfe3u5BGHNxBvWGdd7VvNArBhiikUNoRJo/C0PenRnXaj8wmv0DNJ3Jgt2PG
 SXhg==
X-Gm-Message-State: AOJu0YyKhhS+ZCV3wBtDPBjX7VUYsqnz/WC4fxPuAzaylXUF7PtcZrjK
 JnYhusplj5OVpU/2TwF6ka/73w868Zd8ZfQA/YkvcKa6CWCam9G1///hkd5pBIa61t/lma6SUIF
 JB2dw
X-Gm-Gg: ASbGnct7JZpa/wrRfFJ9LdzvkhRLovtuxfZwee94EMaNoOWnfMFS3jgn1kOwGaRIpsg
 v693tcPmIP9Fq0HqhHFDq6AFzgKh4HxaTQNPDncg+oE/GmtfGTvZqgQMwsNPEST/pbqnKXtavoQ
 rU0M/fm9FYSOMkIUTwNI0NmZBhPtspo7myoips342KJdDtK0Zx4B0LlaBdSYSg02DciHio3OWvk
 RWz0h88yMOuebYSzFK7CpJZYpAPq7aS2NZw5hh1pCkvqsSb8SxtMLDDMQt0k3nkoZ2I/Y5GQzhx
 Riz6MOpBvKvM85UgDVqnkfoBQc198WwMnn3QoNKuf6ASkWyFcHkMPsE3FE/bD17LARlYbgwAf0D
 riGplj8SaHTiOsdMgEOEAe3PgQh7yineiEVHu
X-Google-Smtp-Source: AGHT+IFemu1AT73ub54bWiR6kBHSGqZcoHmsR7C8s6I2HGJgh3mf5pXbilQ1sbYK6MmHX1+hd87FmA==
X-Received: by 2002:a05:600c:5392:b0:450:d104:29eb with SMTP id
 5b1f17b1804b1-45390bcb842mr158912695e9.5.1751381066511; 
 Tue, 01 Jul 2025 07:44:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad247sm204911535e9.26.2025.07.01.07.44.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 47/68] accel: Introduce AccelOpsClass::cpu_thread_routine
 handler
Date: Tue,  1 Jul 2025 16:39:55 +0200
Message-ID: <20250701144017.43487-48-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
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
index 14113bb5c10..28e29cfa06d 100644
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



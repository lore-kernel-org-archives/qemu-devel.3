Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF2BC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAJ-0005RO-Vq; Tue, 01 Jul 2025 10:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAE-0005Pm-B6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAA-0006pJ-Jv
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:40:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453643020bdso50206645e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380842; x=1751985642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xbRlHjkCKfI6F0ZyZVDa30naj6O26Xxb9NXVgkrI2o=;
 b=eVJCCYm3vBlbaTM2MLSpcJup7Q8PQcCoL5QZMjt0kJUUALHfS4tfgzSGBw4Cvs5ZrK
 NHwSoTW8p8gUkQewBgY7fSy+znFhaKfD4rAaqJFG5UY+YcCqvQc3kVL7XLeM6MBxA7PH
 gnf+Y4UMKJ/8Fj8cyG2cv5HaMVtQMw2zb78BtcXZWJvDyEcysvahKc0oZnhetFE3EvQP
 te4xJWe6V8Yy3PxapFOibAA0m6blDMnrB5DVZcLJRTXnwN6r0hlpNK0fNXFepJASt59a
 kTSfmfIipV8O672zVdrQrA/7wmosocPgplhnk9mJsWGGqSB/pMeS4KkxGcfNgsmZroZC
 dz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380842; x=1751985642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xbRlHjkCKfI6F0ZyZVDa30naj6O26Xxb9NXVgkrI2o=;
 b=EURVdAm/Gr72MB2fkbtmJ8FdLnrvfATJjxoOcBspwOUV9jo7/yoLQ2aa/0yWcPU2ap
 nF9kWnxPWGQolgIf7s6AgLqCrobkXZigqduj0Caq9BaS51hoDEoLAooqMZgydFBoVQDK
 nvQbTB5UMii6udIMVlbqVncwqfgYLqoXT83LjmRWXv//8tY3AnGfM3g0iLxwm91AB+ia
 DKMCSAfxkxUE/f8K6E4s3uLVvKQZP3Ua/j/CmdNvrH1746qPVU835a8/bZg9XojzLXCN
 XmveQgWuB8oydnQqwlHrQuDybrJIoENXAppFdSCFK/KyZ9Tzf4i8ZURBKh4vSOLLXB7R
 KV8w==
X-Gm-Message-State: AOJu0Yy9fEI8b+MtejSIjdUBb23iGHrF7Fch7ALgusOOd2uACnreGlbI
 XRVyyNgal2pWDM1V/OQFcWJ8vJJAUdoB+xH5R1TS8+qKqetpLldCGoBki3TorkqvdJdofYrOofx
 HUiMm
X-Gm-Gg: ASbGncvcF84dWbUsJ7TKVXGVu8GczVSB6zjBY2Nz3n31RD3FExO+OkbBmMd3GIflUvw
 Wr5j221FKbwcd0SixcfAsVTNVPM04WyWlDBC+WQlS0qgf0Xa9rfxBKOJo/+SIlwpYZlb+BjepN0
 XRUQ7sVd0+VlAJNMiBB9l051OwLtK1Rm2WQPH7m92gQm0qTSkUIZSBcISUfneE1YaoOMHr0i4nT
 AATQ3JRqWQg8T8YXvIt8lJItejIyjJzhNcozgoeJ9uq5LSUCOxhw6llyxRytXbCfpt/PlgjXd91
 m4Cud8OalqLeCeg+NlPizpb2e090CjgwLEtisTFJ4ORsbYaqsq7jRsU4hJLqOA2iIPgdwEV+XB/
 oJBKV4FkjuPV8FjWWIWhXV4mKLfe3VU9ValzZ
X-Google-Smtp-Source: AGHT+IHOSwoYcbIoigr6HAmF5IOiacdcLvtln6mGWho9moj4J6xRtwmoNwuFWalR9IkJwWQP0RsJCg==
X-Received: by 2002:a05:6000:25e8:b0:3a5:3b03:3bc6 with SMTP id
 ffacd0b85a97d-3a8ffbd4b9bmr12607014f8f.28.1751380841780; 
 Tue, 01 Jul 2025 07:40:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab7asm13412634f8f.24.2025.07.01.07.40.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:40:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/68] accel: Keep reference to AccelOpsClass in AccelClass
Date: Tue,  1 Jul 2025 16:39:12 +0200
Message-ID: <20250701144017.43487-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Allow dereferencing AccelOpsClass outside of accel/accel-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/accel.h       | 3 +++
 include/system/accel-ops.h | 3 ++-
 accel/accel-common.c       | 1 +
 accel/accel-system.c       | 3 ++-
 accel/tcg/tcg-accel-ops.c  | 4 +++-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index fbd3d897fef..9dea3145429 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -37,6 +37,9 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+    /* Cached by accel_init_ops_interfaces() when created */
+    AccelOpsClass *ops;
+
     int (*init_machine)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 4c99d25aeff..44b37592d02 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -10,6 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
+#include "qemu/accel.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
 
@@ -31,7 +32,7 @@ struct AccelOpsClass {
     /*< public >*/
 
     /* initialization function called when accel is chosen */
-    void (*ops_init)(AccelOpsClass *ops);
+    void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 4894b98d64a..56d88940f92 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
+#include "system/accel-ops.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a0f562ae9ff..64bc991b1ce 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -85,8 +85,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
      * non-NULL create_vcpu_thread operation.
      */
     ops = ACCEL_OPS_CLASS(oc);
+    ac->ops = ops;
     if (ops->ops_init) {
-        ops->ops_init(ops);
+        ops->ops_init(ac);
     }
     cpus_register_accel(ops);
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6116644d1c0..37b4b21f882 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -196,8 +196,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 
-static void tcg_accel_ops_init(AccelOpsClass *ops)
+static void tcg_accel_ops_init(AccelClass *ac)
 {
+    AccelOpsClass *ops = ac->ops;
+
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
-- 
2.49.0



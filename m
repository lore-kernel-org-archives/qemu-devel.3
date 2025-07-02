Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB83C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2b2-000153-Lx; Wed, 02 Jul 2025 14:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2av-00014Y-En
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2as-0001ZU-EK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so34413425e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482444; x=1752087244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xbRlHjkCKfI6F0ZyZVDa30naj6O26Xxb9NXVgkrI2o=;
 b=ubX536gK5j3zjB4Ssm+2VcnIzeq3II4/YNNtIiXKhqW48iF1SuaNhUrGggp3nkn00E
 gONKanXnHqF3y6fcu8HsDqDDQ2wpUTEmFqmTTAp5KM44lUf9RTe9QqE8MagwsdWQh90B
 wwQnLaONxlccMDVgcZk/VoO3hI7NA1qI+q7Epfd1Vmj/AKRPdEDzjy3EVFhBRU9gp2IP
 sj39V/t6Oto4zoArOGzjwCELJM9+Dn8TZAxOqBHruFhGvz8Y2a9OD4jMJhAF6nZgnRSD
 QTd1WmBLcSes/+R3ypEklKFflxRPEbNUz1SVHRE2EgmElOrHRACnSbwt1UhZ6Z22274j
 jzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482444; x=1752087244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xbRlHjkCKfI6F0ZyZVDa30naj6O26Xxb9NXVgkrI2o=;
 b=QZ05K/4+HjKIEd5qtzMNCsptGPdF0kKfslNsZNH3+gg4Cc9D0AaN8dX1h9TtIuq7Ng
 NDg+KWO0VGPnsMv58AlFS3EKu3DkS8y0NNvVzMEe/rFLAwynxKjL+zfZRZBpmuhmDIrg
 0h0IOWFyA043XXSDcr9Nj016K+OwHGzU4i8hvBqPrpEwluccj9qgQg1nCIWXuXLKhInX
 0e1f/uoUz23ApWZYoXx8bHwAo/P57kIACqI/TMTZd9ReBb3Np8EZzmk+ib2UGqus49ya
 dJdvBZdnfizeEGDQa99J9tS7tWsy7wTdLHlzOtWfd95lKw1NuMhYAE4P6FrnoNTSHdNa
 4jzA==
X-Gm-Message-State: AOJu0Yy+Rs71IGgldb8WM51NDSezTW24wf1hwRhNF7f77oqas48NjOsi
 j0UoVA6n/ilWjkpLANhfrcfkAtKaisnbpmrt0ul5jidV5lSgNkPbFmcOcBESZXV7vuvrkPvNM87
 pQCSY
X-Gm-Gg: ASbGncsy+8V8rncPFiOjPCwO7TUvjpamxh/GA+Ev8uSu0ZsSOAWV4VT7AwErNMNnKVW
 4kQDgQnNFP0wIWVUfgsi8CryNrdRL+puR6xajcaaHWDbiQJprL7Jt3r7jmUku8Nxch1BAd2VYRq
 kx6ttBTNEksu54oH++GfoA0GDhtKUdf/hO+EKDnGX0ohSZOyHI7zLeFgQmIdcATUZSaDu9zVydo
 yuNPGjTmWQLGqtuljLC6mZwafGxOwCwayUIiCu9EZe2csVJ1+aCbd7HILe2Wsi+KfQpVE/VNvkf
 wu4WqEl6ePS5WICGCGq0fH3juONaZJaoVUvLfjWuZ921yLG8VKYciap4c5iJUxC6EwHqIUZwxMA
 ev45UyLOc/3ZY5RiD+LFvUh2U9Jv/pbdV/xR9
X-Google-Smtp-Source: AGHT+IHnU93ZH0LCKAKrDev3i+pb5i+lGgTBlsjmoFT/N2HzvMs09QzE8s3+GEcpPuQnUP9tsSkr6A==
X-Received: by 2002:a05:600c:348b:b0:43d:97ea:2f4 with SMTP id
 5b1f17b1804b1-454a36e648cmr47129205e9.12.1751482444141; 
 Wed, 02 Jul 2025 11:54:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9967ee7sm5895105e9.8.2025.07.02.11.54.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 04/65] accel: Keep reference to AccelOpsClass in AccelClass
Date: Wed,  2 Jul 2025 20:52:26 +0200
Message-ID: <20250702185332.43650-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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



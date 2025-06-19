Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33932C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF67-0003wL-Et; Thu, 19 Jun 2025 09:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF66-0003vu-96
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF64-000413-Gy
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45362b7adc9so1462125e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338866; x=1750943666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOQFF5IHVggEpZxvhH4Dg2y5NDppFE2+idPk4kXeUTw=;
 b=vj1jQJkOCFeAgl2LypV+qDb9Y2mHP/yuk7ThDy49ItUXew3H1PIZ/jbBPZk3Xwzo+1
 j/AXQ4QoYiYJoIpE7EOf7YMYrzV62XaEVU6IGssrFae4lUNMncfjq/gsnIFYHlqxWgEV
 znR78veHeF3WUy5xbjzLJYthVXtyB2te8RDOIOqJX/0don+Dni+bRHjBOPgsIVHovrhU
 k6OQ9lzHgNLkNNV8pcEcCHD4kz7KT9W/+RT3B10h8nIqBUS8VyV+9AOJVlXJ+80SgI28
 +gLlebQ7glEDQfHu6SGbaPmSllvh5RNCowHJ2sECrY9RE+9equxYQeBH4nbCoMKudhDh
 05/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338866; x=1750943666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOQFF5IHVggEpZxvhH4Dg2y5NDppFE2+idPk4kXeUTw=;
 b=TIjWZ/B6u2Hcw9rYPQR3DG6vEVVSs2qjZC29uCWn3rZHhQ+S9qJ2cGIKnmz4Ioeg7l
 uiigastupMJD3LbDLA2x4TTrOiVTY0puJHddkcE172RzvidZNIDugKTJC2UmbGGho52g
 k3Trb0+BrfgYfdsA5bqTS1wU+uRFiMiWSuwVIpsbdpbOxfT1YB4TPpm92YysiI2cWJGa
 /rwMwUdYu7zsk20EDz79uT8sONlspq1aMfa/6voi+AT8niCwVmunROpKK8wh6s0LRMcL
 7S8wrps8+T1rD2IJHjBMf+aX//qnpDLTjzxtrOkhBGNmLmeQQ4bbq2d+lokH9b/HzPSq
 ZPQw==
X-Gm-Message-State: AOJu0Yyc+vP/Hks/vfsmzvTqnGenqKtM+yC3w+K4wQuP/0Xx6YrZWl64
 yZ7M3yETQ6KGWzXkU6MRbEmdyP40wItry4ObIYtef8GD2C0Z0bV/JIRFA9qmRlsZSAZjFmmAgzn
 9rMrDVmY=
X-Gm-Gg: ASbGncuK8xbqjBDPvdBVPyP6+tg/Y7qDJq53JVuU+lN4Ox7ymcjzNybiPkI11QooV/a
 7lN/K+DGSwnNP/Yt9J6nnfayJP9HXkRFjFsWp5pWFnlxZR+sdZaQBfzXQhlpvshcpU6WapL/mx+
 ALkaK2D6Vh1NyE5uIwiN3WQx0hcp6AiBF8NpX9Bk7UA+Le9dFxm6trOVdjJp3gYpIIlquMNdBtI
 k/qvCa44IgKXtZJ7obK+8uxks4MRBRPEjDSQuxV/+SIyJmYMR1kS1rEC4QsD6DJUPGLViCDjoLV
 Df5DeNJmjENBccluD74t/fcLZqAZpkUVNwrWDlVZ7WSzl3agzMkMO02nyOofgL1X1rhinoW3pjO
 ySUPkMPIdyjwn7xHGFCZHwebOabBquwoVB9oy
X-Google-Smtp-Source: AGHT+IEKAPBge8NVooEgnnBCRSTl7DwqXrW7+BrRtP165DuwJl3JVN8xsSMQZ37LDKLlIe59+hrX4g==
X-Received: by 2002:a05:600c:6388:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-4535fd55e92mr22427315e9.0.1750338866441; 
 Thu, 19 Jun 2025 06:14:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97ab95sm29168365e9.7.2025.06.19.06.14.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 12/20] accel: Keep reference to AccelOpsClass in AccelClass
Date: Thu, 19 Jun 2025 15:13:11 +0200
Message-ID: <20250619131319.47301-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
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
index b24d6a75625..da2e22a7dff 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -198,8 +198,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
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



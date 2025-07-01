Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B71C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcF0-0005VR-6W; Tue, 01 Jul 2025 10:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcE4-0004c1-VM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDz-0007B6-0w
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453647147c6so62204975e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381077; x=1751985877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v6+HYr/42Y/Iowg1uUW2qQvLw8fBzoanUujYKDMrhU=;
 b=pgFzRNBR7i38vCncfGEnCdE6rseP2qm8ao+4vyYDBtPVgsMe8Ut3eeF5e9jNZw6Brg
 Pht6g0EWXj/nWMoZ7ghXI5KtOtbNdssSP9Mmfje3Dh3JwFY0d+cKZ/Qj2hueWBEi8vvz
 cOOo0kViZ7da2NrwXNTVQnPWM/XiBAPLhw9Gv4nh7YELLTRVIGIVoO/cbMGQvsleAxo2
 jg2LhSPxsMny2pqQx9JUxPzgwgD5Ggr5vf6z+/y/3vLpSWCbWuXbTta/CxaVUsyI2gMg
 n5x2RLsHJS1o+2N02yX0of1IcYBdtmDyXXuYAU/Rwky8AAMJ128eyixe592OD/19cGPH
 kyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381077; x=1751985877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v6+HYr/42Y/Iowg1uUW2qQvLw8fBzoanUujYKDMrhU=;
 b=GbOFDa6ypdhFeymNhBemNSXSs/4bCHugOuSZWZE35PZV0i6NnuUdUja8DS0CvDayG+
 TKKVX214uSZZ8X3D1w/nS4zv1Mg6cX2VyU99w6Z8SOC/TBqUZeX3ZVYEpUA8x2O+LMzJ
 uhgiTD4FjTIPLGBhvKXPRYLBLcY8ykL9Zu5E01s2es+uZenK1IlHbE/K+V2szW5W1/5R
 JrmWXAk5lgG/wr6FEvAlI70kwyEOoZFuApJyjq7JpgLg70aVr0ErbLdB1byk+VoFE9mN
 sXuEMSzfvbPGmsaNavVaRiNlPFFrNW7q4eq8A1ul06IHXw03XCl/cHbyDpQtAFUM8WRA
 Ol/w==
X-Gm-Message-State: AOJu0Yx11+/NUh/mj2F+0o1J4TOTJnN4lMiDg0xUEF0gROKFkGdEdBTV
 pykEUIHDDKYEYuyGonJRwYd0pyIKQx1Yk6CucaMUg6PH75JW814b/BmEO09HnaozoaHmMVx10Ql
 TLMwZ
X-Gm-Gg: ASbGncvn57Y1QZcJOGGkDxrz5cEf6QyN752nwYReKToO92ZcBZJldccsbkf0VyMp2Xp
 2AT6WM+gitctPAGjEzHrlpCm6knE14cUWmmOaNwFrfCVggpPOYDoHEo6E9dw6y2LHsFuUwJP2xa
 yaW9O4AdVukuStxoktLJ3otv55pBWpYpfJvboQKMIwFS1aeuo+wPMxqaJKT7dsmjMNE3uCyLK8O
 4qWncKNkMmaK3WsHj7LsmNKIGRDEfiPvNC3MHKYgb7+Lf249RSZK51iqNPBUNUPQ/dVycjJU6zC
 YKlh/LoFoPx+vRd8KJXXlbvVthEHoVDj5PJDE71C5xLFvr9Gc0LEd3vHmrFhGA8xgivj++6vkSx
 mk+lNR4uDi6n64kmU0hq2wg4kvlebdFUO0rfW
X-Google-Smtp-Source: AGHT+IG062X4KOOev++ydqHIwg4js7WY5RWUd4WF0/o79DbJRvOcHiSh6x5+M0yLTO7/9nq1nInvfQ==
X-Received: by 2002:a05:600c:a319:b0:442:f98e:f37 with SMTP id
 5b1f17b1804b1-4538ee559f7mr136105105e9.21.1751381077056; 
 Tue, 01 Jul 2025 07:44:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a85b3d44sm16557735e9.0.2025.07.01.07.44.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 49/68] accel/tcg: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Tue,  1 Jul 2025 16:39:57 +0200
Message-ID: <20250701144017.43487-50-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.h |  3 +--
 accel/tcg/tcg-accel-ops-mttcg.c | 16 +---------------
 accel/tcg/tcg-accel-ops.c       |  3 ++-
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..8bf2452c886 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -13,7 +13,6 @@
 /* kick MTTCG vCPU thread */
 void mttcg_kick_vcpu_thread(CPUState *cpu);
 
-/* start an mttcg vCPU thread */
-void mttcg_start_vcpu_thread(CPUState *cpu);
+void *mttcg_cpu_thread_routine(void *arg);
 
 #endif /* TCG_ACCEL_OPS_MTTCG_H */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 462be7596b9..96ce065eb59 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -61,7 +61,7 @@ static void mttcg_force_rcu(Notifier *notify, void *data)
  * current CPUState for a given thread.
  */
 
-static void *mttcg_cpu_thread_fn(void *arg)
+void *mttcg_cpu_thread_routine(void *arg)
 {
     MttcgForceRcuNotifier force_rcu;
     CPUState *cpu = arg;
@@ -128,17 +128,3 @@ void mttcg_kick_vcpu_thread(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
-
-void mttcg_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    tcg_vcpu_thread_precreate(cpu);
-
-    /* create a thread per vCPU with TCG (MTTCG) */
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-             cpu->cpu_index);
-
-    qemu_thread_create(cpu->thread, thread_name, mttcg_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 861996649b7..4931e536beb 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -204,7 +204,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     AccelOpsClass *ops = ac->ops;
 
     if (qemu_tcg_mttcg_enabled()) {
-        ops->create_vcpu_thread = mttcg_start_vcpu_thread;
+        ops->cpu_thread_routine = mttcg_cpu_thread_routine;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
@@ -222,6 +222,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     ops->cpu_common_realize = tcg_exec_realizefn;
     ops->cpu_common_unrealize = tcg_exec_unrealizefn;
+    ops->thread_precreate = tcg_vcpu_thread_precreate;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
-- 
2.49.0



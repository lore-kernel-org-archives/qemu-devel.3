Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED9EC25B10
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Co4-0006K3-To; Sun, 28 Apr 2024 18:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Co3-0006HS-B8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Co1-0005bO-0r
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:35 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a58872c07d8so868551466b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342531; x=1714947331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0P/VtJjh42zf7hktk88GWMfGQHzmvaE6RmKFsHTdzk=;
 b=azwa6ccv7KJnDz85n7WCXjG1j1YOcrW3SUdFBuFU5cRzDxM28Gwd598JE03ii381G4
 dVpaH7aMDMBboR+ZwotgNCTyWd8RpyMXkgCcnQ34uNTEzLLlkLKvE32Ds/zU2Xjte/WP
 r3dl22KBHLFuLUbxxoVFMsVlaUxoSlRAPGx2DVzAwgj7qgG1K1Tj6NDiIXPUqVsN/7JX
 jD0OeZqPK/NxZSg7rq/NlscJuWA/E/wYQMPqRaV6zVzg+mE4VG/MNyI67LfConaj1SUX
 lxv+tbkJajlEM98mTbS5z5qEttyggYuTKx2xlahxpPqASGlJeYZq3MEI8JeulhX5ILfI
 s/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342531; x=1714947331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0P/VtJjh42zf7hktk88GWMfGQHzmvaE6RmKFsHTdzk=;
 b=FTg37rtvsSdxGJEuWffyuADwntHlxlA2rM1s/VnyesIwgsIoT8rhr85tsxXDdRH7SR
 4UinuBVdPm4I6tnTE9mBYjiCCje0mzTFCpHCkyYxcHaa4zZibuSOSgJ+IkQFuryij0PH
 OJhRp+bz9s7SFAZyU6CcBmszEYyJb8scWBgsvQmT6he1VsRUCxM5ME3zMdJ9Dtmt+9jy
 5bZnTBzF9chgRyK6urSFhpbdTshKka+4/+l1qAPXqqy8UwIOt1qa2MyTS6EA90GtKSRn
 JWM7xfoVRfP6d9xz8ViRnZ+hqCBF1K15nAUz7bPZKFvUWEAs4np3wNCZBMi5ALI4vN0r
 fnQA==
X-Gm-Message-State: AOJu0Yxjwuvli3Ked//lfaXR87tIknaJKKlOJXW23j1QdoHvx2sb38AF
 2RLfbroyWrz8dVqWO0595zLkky8PDZ+gErPW+duN/gQjCrfOOqyM+DUfG06n5hAO0e9HGFhqg5z
 M
X-Google-Smtp-Source: AGHT+IH3D7ibXS4f72tP8OL5W0DjLjospzfedj6pdJgb9TFLCu+3SWTyFjRnL2zBL6W7dge8NGLz6w==
X-Received: by 2002:a17:906:e17:b0:a58:921a:970d with SMTP id
 l23-20020a1709060e1700b00a58921a970dmr7426286eji.6.1714342530907; 
 Sun, 28 Apr 2024 15:15:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a1709067c4a00b00a4e5866448bsm13044579ejp.155.2024.04.28.15.15.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/24] accel/tcg: Implement AccelOpsClass::exit_vcpu_thread()
 handler
Date: Mon, 29 Apr 2024 00:14:33 +0200
Message-ID: <20240428221450.26460-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

The TCG-specific code from the system generic cpu_exit()
is equivalent of tcg_cpu_exit(). Define the AccelOpsClass
exit_vcpu_thread() handler to it, making cpu_exit() generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 ++
 system/cpus.c             | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 7ac5f0c974..56bbad9fcd 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -43,6 +43,7 @@
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "internal-common.h"
 
 /* common functionality among all TCG variants */
 
@@ -218,6 +219,7 @@ static void tcg_accel_ops_init(AccelOpsClass *ops)
         }
     }
 
+    ops->exit_vcpu_thread = tcg_cpu_exit;
     ops->cpu_reset_hold = tcg_cpu_reset_hold;
     ops->supports_guest_debug = tcg_supports_guest_debug;
     ops->insert_breakpoint = tcg_insert_breakpoint;
diff --git a/system/cpus.c b/system/cpus.c
index d0d585e8b9..3e86b488d3 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -422,9 +422,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 void cpu_exit(CPUState *cpu)
 {
     qatomic_set(&cpu->exit_request, 1);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
     if (cpus_accel->exit_vcpu_thread) {
         cpus_accel->exit_vcpu_thread(cpu);
     }
-- 
2.41.0



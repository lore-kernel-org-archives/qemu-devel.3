Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447E0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2s8u-0007or-El; Fri, 03 May 2024 08:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8Q-0007Kt-Kn
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:33 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2s8N-00036V-HX
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:35:28 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e10b6e2bacso36646931fa.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739725; x=1715344525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9C79ZCDN03MmjjHQ6TSF486EGxB4sAu8CtoKMbncco=;
 b=FftdX6fy29BiINp8V42kiUQO7LkonRVxTQjAci7LA33uuOkABy4yyedgm6NdVSd2Mb
 uHSlbuN2nJw56EQhNWN34r1/uk5zW/Nn/MVIFNqJge62yO5Hq2DPNCO9W1La2hdGv5DV
 XhOTRz9m+qhqc/kcQRHP9oZTqTjF/ips8StkNvqzwGCperz/OTaWFF7U7UpNCzCcmFvI
 RTbYEOayCP8pOdSgvTEZ3kXe73HcVMcoFKcK0D1jLG7MUju5D1gNodbWH36UVKQP33Y7
 t4aW3lYDpr7GMZNu0wrkn1K2UUK+YnUQJ51HYhDZoFjf2qPDe9vG7T9b4W0H8o2WLm9Y
 NoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739725; x=1715344525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9C79ZCDN03MmjjHQ6TSF486EGxB4sAu8CtoKMbncco=;
 b=uE4Bj/egKjN6r5GHjqK8UJgOIEpImCTGRJKswOoBjvDteu/iZhOgWR81TNqJlnNEtS
 upPkdVzaXy6BOHA/YLVcQs1UFQ3tf/JZslx7Ba+fQexCNNIDrcr/5U4azhpBwrhD3FLy
 lRRUI1hwvrg3ZEVrzhv0vp/lDeVYAdz8m/F6o5O4byCA2QprquZojWn3q32uU1spfPKp
 6uOJCpcmrMInw/oxNu42uwwlBZ1SFuRV7zGSGEvAskjZMBXEHDoWdDvYLMjDu3hP91IT
 oZkBTPfxZm2ibQJjQ/G3AXDkfTOYcFh7H9QvnuD1FEODgfAWO75YuawxxI+/o7PiE4p7
 +9Iw==
X-Gm-Message-State: AOJu0YypyzXJ/dqr5oVE6E7xoN63fwrMx2Pchq5+BRpOdcz7IWlJ3uA8
 4+cpTUaawCVsGViXQtgFSwZ496Gr2AQDteUMiU6R5RPLUFdYbq6DhSuhFEElrntzSRdt1ak/2Dp
 4
X-Google-Smtp-Source: AGHT+IEkjl1c4zplMPtoIETj7k4yvplmvfLOuYZnnAu805MwIj/FLVK7x/NIrhkk+1Y5IEDmhiDAYQ==
X-Received: by 2002:a05:651c:553:b0:2dc:d2c5:ee9 with SMTP id
 q19-20020a05651c055300b002dcd2c50ee9mr2012704ljp.2.1714739725256; 
 Fri, 03 May 2024 05:35:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a05600c4f9100b0041668162b45sm9200100wmq.26.2024.05.03.05.35.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:35:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/5] accel/tcg: Introduce common tcg_exec_cpu_reset_hold()
 method
Date: Fri,  3 May 2024 14:34:55 +0200
Message-ID: <20240503123456.28866-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503123456.28866-1-philmd@linaro.org>
References: <20240503123456.28866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

Introduce a method called by cpu_reset(), common
to both system and user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h      | 2 ++
 accel/tcg/cpu-exec.c             | 4 ++++
 accel/tcg/sysemu/tcg-accel-ops.c | 3 ++-
 accel/tcg/user-exec.c            | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index edefd0dcb7..b85285e2ff 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -23,4 +23,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
+void tcg_exec_cpu_reset_hold(CPUState *cpu);
+
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..1bf85c324d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1096,3 +1096,7 @@ void tcg_exec_unrealizefn(CPUState *cpu)
     tlb_destroy(cpu);
     g_free_rcu(cpu->tb_jmp_cache, rcu);
 }
+
+void tcg_exec_cpu_reset_hold(CPUState *cpu)
+{
+}
diff --git a/accel/tcg/sysemu/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
index 2c7b0cc09e..82c8368f87 100644
--- a/accel/tcg/sysemu/tcg-accel-ops.c
+++ b/accel/tcg/sysemu/tcg-accel-ops.c
@@ -36,7 +36,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
-
+#include "../internal-common.h"
 #include "hw/core/cpu.h"
 
 #include "tcg-accel-ops.h"
@@ -82,6 +82,7 @@ int tcg_cpu_exec(CPUState *cpu)
 
 static void tcg_cpu_reset_hold(CPUState *cpu)
 {
+    tcg_exec_cpu_reset_hold(cpu);
     tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 6a108eb212..85e92ec8f2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -39,6 +39,7 @@ __thread uintptr_t helper_retaddr;
 
 void cpu_exec_reset_hold(CPUState *cpu)
 {
+    tcg_exec_cpu_reset_hold(cpu);
 }
 
 /*
-- 
2.41.0



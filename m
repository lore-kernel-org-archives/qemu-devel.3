Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8965CA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKA-0000ML-HK; Sat, 06 Sep 2025 01:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK5-0000Ku-Mo
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJt-0006p8-1y
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45dd5e24d16so14961225e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135909; x=1757740709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=si78m6k1/2WbkO3UQheH+as6HI/9NYY7KBL//tRndmo=;
 b=BvB8/ev3YciUkNkE3cQSsdVl7ev+kME0QMLkoxVgMxGUpSmFsaePE6u0F77wFbtk2S
 nK5CIF0VIvvKCCr5Y31GdJIrivRvioWUqOKzwKdDhQVKhMETY+lbJgQchFhAMI89yLOK
 iaxdlUxGB2D7D/zuz8T95bVA7uyHacGueMAOe6M9lNN/kruBORU+1KfklpmiRww5vxzY
 PIxjfZey7RbthsUbMMH/eMIc4vTrg5SNF7oO9LT8TYlQWLsV6I0OwFPrSOJzefw6G28n
 YhAR39fevYZ8YPh5pfllZt3DMvcIFNsxXcOLdFjzOKbONvmLR2foFCGtl5b61fdaPkwD
 HMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135909; x=1757740709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=si78m6k1/2WbkO3UQheH+as6HI/9NYY7KBL//tRndmo=;
 b=w9mSxk2nMc88l3pHiuFURSx2kVaU/Q3XIGIfWpSsIBvColqdNs5z0D/HRknlUqRx0u
 7axokhvTbGjGnWcqI/pT9ptGYrHLZingKOnBTVuq9iZd75XBOZOxlSqEfsmhUb7IZp5p
 hXf+A4KD9mw2vILksrOcUkvnxscqKZRvnhAzZS6d/iW/i73M9I963v3o93qazjQp8OCP
 PCNAKP4b987wtG+aWfRV5pJ3aj/T8ERMQCdM1dh6nhhC1YI7y5PE6obzKhhYxCYzn+1h
 0+TcySZ17WzwO4E3Ez5FEBDBgiY10B6YEQS0UKuhJAIttTwmaZeTtBtCAEIsqJvE+dRJ
 8+Og==
X-Gm-Message-State: AOJu0YyAL3GG2cyEP1RGla43UkPvPRxKD/MpgG2GcPml/P886o2WQ/gZ
 hRRhoZ+ABkdXMgmS8Mq47jvSIEojdYgHT9N6AuzBqLAXpdRR9aAr4M0NQg4tmjItEpejIm5EDNB
 JMME+EKg=
X-Gm-Gg: ASbGncsDF/NGx1WPf1AwYBScWrIN3XtWgviymjK28A9vzvWCL99RDUR5PTvv4DkLUFS
 CHZWuDahK16O8FyRaR+v8uUNfALlfwztAx2zP/+HSLndawv5cTQqzk6lpuC8ejeGu1L8vI/mI06
 rU6a5AvVkJoiUV61wRPy973fszOqhmrvuUaYijgIIn8GIecSmbNz52dyWwbWE7R9zqqxhHKDNhk
 L/XqFd25bryC/ggIRoMDayYlKnZFSY6h9w3bqDV4f+CoBAu5iuoGFJf080Bdc55qI+3j1kWC+0y
 tpYefPNnYtCjLuTV9TO08o0Q6fJtDZktqr8Wd8iy6JzolwKCXX6q/KHh9WP4Qd8pxJka8HZR3Jt
 yr4Fly5CAYOwzoE/6gPuOKO5fH5rjcStGOwWF1X4YGk9DoNCAylweujnoi3GrQr9BjSQDh83C
X-Google-Smtp-Source: AGHT+IHOQ0PxvYVG4jc+CmlT03Svxo6xfEZfCvrU0SodIDtu7O6oiqd6S6g/7rjChaRqvWpihPFT4Q==
X-Received: by 2002:a05:600c:4e91:b0:45d:7d88:edcd with SMTP id
 5b1f17b1804b1-45dddef8115mr9943125e9.30.1757135909498; 
 Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 09/11] accel/tcg: Introduce EXCP_TB_FLUSH
Date: Sat,  6 Sep 2025 07:18:18 +0200
Message-ID: <20250906051820.160432-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We are going to disallow tb_flush from within the context
of a running cpu.  Introduce a tcg-internal exception to
return out of the cpu run loop and perform the flush there.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h       | 1 +
 accel/tcg/tcg-accel-ops-mttcg.c | 7 +++++++
 accel/tcg/tcg-accel-ops-rr.c    | 9 +++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b658a3f48..ce9f116ac3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -20,6 +20,7 @@
 #define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+#define EXCP_TB_FLUSH   0x10006 /* stop-the-world and flush all tb */
 
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 337b993d3d..f21c86dc84 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -27,6 +27,7 @@
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
+#include "exec/tb-flush.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
@@ -107,6 +108,12 @@ static void *mttcg_cpu_thread_fn(void *arg)
                 bql_unlock();
                 cpu_exec_step_atomic(cpu);
                 bql_lock();
+                break;
+            case EXCP_TB_FLUSH:
+                start_exclusive();
+                tb_flush__exclusive();
+                end_exclusive();
+                break;
             default:
                 /* Ignore everything else? */
                 break;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 6eec5c9eee..d4bf092736 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "exec/cpu-common.h"
+#include "exec/tb-flush.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
@@ -264,14 +265,18 @@ static void *rr_cpu_thread_fn(void *arg)
                 }
                 bql_lock();
 
-                if (r == EXCP_DEBUG) {
+                switch (r) {
+                case EXCP_DEBUG:
                     cpu_handle_guest_debug(cpu);
                     break;
-                } else if (r == EXCP_ATOMIC) {
+                case EXCP_ATOMIC:
                     bql_unlock();
                     cpu_exec_step_atomic(cpu);
                     bql_lock();
                     break;
+                case EXCP_TB_FLUSH:
+                    tb_flush__exclusive();
+                    break;
                 }
             } else if (cpu->stop) {
                 if (cpu->unplug) {
-- 
2.43.0



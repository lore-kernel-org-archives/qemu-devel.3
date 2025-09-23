Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7A6CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swY-0004HP-3J; Mon, 22 Sep 2025 22:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swQ-0004Fg-39
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swG-0003hR-VA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:41 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f38a9de0bso1581424b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595170; x=1759199970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sgJ3IGwq4F2k433MR4NI0L072AVq2BNbSERXyUDZjqw=;
 b=gWN7lcudpOm1yLm/bOrFpZRKDYHE4q3Js1nOxvrEUfwglMx+yjcCEl8+CYiOG3e9Z6
 kKOw2rxqpNx+or0iVPLsldso1pUDjWjnHbPdKIKXMLZZ0k6mEhQEZAJHXovxevKLVHZr
 uzFIbHO1wBElwF82TJwv1GM7ymbQgC68l8scyWc1xQ2p9tYnwKZeN+mhnleL8+IfE/ff
 sqMY8HT2m7eeC1g/bPLACG4RPQ0Ww+sH3U+vBT5kP8a9QAxXPZWkExx4zmp772GI7uFm
 o1gq/XwV6bkIoU40h7l/ssVe+9cytPJ8ZeZFmJ6hIF/LpFt2ArfJJQ/CNjnLOOEoWYUn
 T1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595170; x=1759199970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgJ3IGwq4F2k433MR4NI0L072AVq2BNbSERXyUDZjqw=;
 b=cPziP15QWa85aYfO5NIuP3NuTKqrJR+PfoL2VlehwaIPn0mhUUT5x5Efi5PtKkqHQ5
 nbqgMHQf11o9GzaI03d9uKZnetmWuua25iO+agK2GcL4dR+d+gktaIaEAHglCnt5g6PM
 32O64QsPOsrDdNIVvB2PGlH+p9q51ANORz7PdzDfvK0JWk9jdwUk77AiASYz3CPdzITN
 GgBinLGrza+ZDxVtQQcizd2N3GYJ7H9dyi4ZFNazu9234Vz1wbs+ZGs5xkjIEU0jqZa7
 oNBP/wG3aSRSFatbwrUw2GQiojHIeK3/Ho2J39Ymw3rqR1+43yCeUGf3vW2AzcakyKxP
 lZdA==
X-Gm-Message-State: AOJu0Yxn7Nx1B/91wx3iBxa4IgZik1vbuOW8X/jwGacYiuBnHpsOcSRd
 SwG1hc1yp3IjYH2f4qPihrXk/TOtxWdWV0gshMKvUsYdkt+ewhjVshj/33cRDa3umzRGB4AVEog
 gSAG/
X-Gm-Gg: ASbGncvBpa9q8+913svXqaQf6qgym0C77uJ0sL7MXKzK4fNszIw4z42Gp6kKL7AfeWC
 OsGiennEobQCygvmblgps9HzqtPCCIPmQ6jpaEQKbsUURsq0a1d0SDSs3rTvUJrPO/anW+vf/Gi
 jXOfjSSEJIgvuZUtDilZOGBHak0wLB3dvzLghkSZnxfFHnAPhY3wndRLHtTCH+zf9+/56it3NP/
 CidMMc1FDVwKPgMg47gIWDcBwNHu7xEyCTP7MkHLZqY8Nb6Kt2Oc2MvJ4Y24w5yp8ANoITgaJBd
 Qpke0SASjwhlIfkbSg8l+LklLsLaKqxkRals8+654GvbkGPeQOv6omE51USqmrueK38NHbCO0lE
 GGO/HpQb4djdohivkGBX4titQiJ1+
X-Google-Smtp-Source: AGHT+IGlWRt3R7MuZDf0Y1TgwwXHQ3cPI3PoT+xmPltl/YbmHt1Dro0Li52bGdcSbccS0MsChFIYlg==
X-Received: by 2002:a05:6a00:1142:b0:777:73a6:edb5 with SMTP id
 d2e1a72fcca58-77f53ac2e8bmr1046050b3a.23.1758595170505; 
 Mon, 22 Sep 2025 19:39:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/12] accel/tcg: Introduce EXCP_TB_FLUSH
Date: Mon, 22 Sep 2025 19:39:13 -0700
Message-ID: <20250923023922.3102471-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index cf1ee7ac25..c7b8e8a713 100644
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
@@ -106,6 +107,12 @@ static void *mttcg_cpu_thread_fn(void *arg)
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
index 2fb4643997..85dade50a8 100644
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
@@ -288,14 +289,18 @@ static void *rr_cpu_thread_fn(void *arg)
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



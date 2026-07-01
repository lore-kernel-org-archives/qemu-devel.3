Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1457C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welGB-00061t-A8; Tue, 30 Jun 2026 23:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welG3-0005oU-B9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFy-0002tL-Fz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ca70925c25so1699435ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875097; x=1783479897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zAEykkLSsC6j7cjQi/1RKg/0+TkxhmA7YPc2ShnuVM=;
 b=CG2VhnFmNR4lMkL0aIDo4kriL3iIsH47yEfv26np4XIpu86U7MTbEa4QcmLdQPjJhC
 iuSgNrcX4qi5QnFJMXZl9wlVxeI+XLC1Ffzx0BlCEAQpK8WSSP8Q8a9iZljAOHhYpMz1
 sXahTcZ26iLLmrzSykDV7V0jweUZH0I2D+b2493Vg5umoMeoV8CVHW8AhupErEu28gpO
 OumEYkYcL/XitXZLDyEaSPdR8at1x0Dxvjont1scTWojFag8Zb/K5QvDdkWrd+YUXwqo
 LtOTiE66DB+760mKvIPdoS8aUwxZjyduwHJP8E870PxETgEXtJXvjBSw+0bM5W0FbjGV
 JxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875097; x=1783479897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zAEykkLSsC6j7cjQi/1RKg/0+TkxhmA7YPc2ShnuVM=;
 b=jwSxga+/f6nz3Zb5v+KaARKBd49/KjYH5ExSAcj6c6auvtLHRaoHDtedRVWy3EvYpN
 sxzhfrlV6s22K8JqA+2J2Pve1TZtz3aVyct3+66tY8E9myqCND14CzEohdkBNNfoLJGK
 7b3lGnJYot7A0X2uyS+TcAfavRK66iGOjHErQrr9+uOO5X3KihuJPGXnXQKV1EPz8eOr
 /vjLWGPmgRv6mt25e3zxlYAJ5PIRavmNT5AvzPlEPw3aTt3+1wyCTiwUP2kEWff6V/NT
 ZocOzxppP3P51RNySW3aoAkpXmkNpj63sA/TCoDK24Pb3Op8Iw29UzYOT6kQdnLwFzKk
 I3xw==
X-Gm-Message-State: AOJu0Ywb2s7QnI1lCsnxg3L9HnH+/6MkOJMWz3uAEr+DlmBCLnXB43Lw
 E7ne5AiQ3cDSASvsabLJ2tiGdOKEAGanOyQdSxDgDlqH2GwsLT1yWMPF9HUG2Tuvmb97e6PJXUH
 eiuwW
X-Gm-Gg: AfdE7cnNKsp+Dri7RoNKLlqrVPvwacc3FteNb89Zjy4v3+8r82XQGCRhCypwKpaZMEA
 lacXPiOtJnTi+CYorD8WQ43M61tut2kPQiHCkAzha1gYeHVUwkSMWXp2sQVsCQiWyWLooF/ND0y
 UB/3rp0K+rFzzaNvI9ltKbxZ2XAH24KZV7zb/wz+aXQJc1o5k6xuY6LXN3OGbuf5tX6h5F1Hgod
 PNCgKFLy5oSJHL2/13lx0QXgZQQrF2vx+D8XQ8oQ/4k+3dVcbj+C7g3pbcrOQGLAob7Cl2XTlf7
 sNrpmfXfXHcVIQXQYoAZmGqNe61eYnMV9iLLozlQC89haws/1HcgXeGlvGOCBt/Xj6jJ3iXBGOL
 l0SCu48ySkr2pP+opMeoL6AQavJAAIZOhZdNYxLq1/qarU27IQOUcPWAaAH20Rn1h2tQ5XRRcWM
 YaVOtcBT7Qlu1drGKDPq3FyNLezNZNRZNsyCApMaqqGGJEyVxw6A==
X-Received: by 2002:a17:903:3b83:b0:2bd:c925:3a16 with SMTP id
 d9443c01a7336-2ca2d52b188mr56311105ad.2.1782875096903; 
 Tue, 30 Jun 2026 20:04:56 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 15/17] target/riscv: Use bp argument in
 riscv_cpu_debug_check_watchpoint
Date: Tue, 30 Jun 2026 20:04:41 -0700
Message-ID: <20260701030443.1382447-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the ID of the watchpoint instead of a loop over all.

This fixes a bug in which addr was compared against wp->vaddr,
so that we never recognized watchpoints that didn't trigger at
the start of the region.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/debug.c | 55 +++-----------------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index f6ffc62f1a..433050bd94 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -973,59 +973,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, const CPUWatchpoint *wp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong ctrl;
-    target_ulong addr;
-    int trigger_type;
-    int flags;
-    int i;
+    int i = wp->flags >> BP_CPU_ID_SHIFT;
+    trigger_type_t trigger_type = get_trigger_type(env, i);
 
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-        trigger_type = get_trigger_type(env, i);
-
-        if (!trigger_common_match(env, trigger_type, i)) {
-            continue;
-        }
-
-        switch (trigger_type) {
-        case TRIGGER_TYPE_AD_MATCH:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
-
-            if (ctrl & TYPE2_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE2_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
-
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
-            }
-            break;
-        case TRIGGER_TYPE_AD_MATCH6:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
-
-            if (ctrl & TYPE6_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE6_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
-
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
-            }
-            break;
-        default:
-            /* other trigger types are not supported */
-            break;
-        }
-    }
-
-    return false;
+    return trigger_common_match(env, trigger_type, i);
 }
 
 void riscv_trigger_realize(CPURISCVState *env)
-- 
2.43.0



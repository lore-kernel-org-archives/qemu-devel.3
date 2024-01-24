Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197CCC48277
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaJZ-0003EP-75; Wed, 24 Jan 2024 05:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJW-0003ED-VY
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:16:59 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJV-0003oZ-DC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:16:58 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cf2a381b86so2734441fa.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091415; x=1706696215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBMlS39CW/Iv4VBfcOh+Zv0cB8PVhw/t20rhumALwGU=;
 b=Kkdr2i3BB1dXg81R+RWi9qDJn3QQEEOuI7C4nuEx2ab9BEdZkuncnRWCnxZNw8YAkB
 G5oIjVSS3hrjIVSBAquYqq+H4DoCQzTkByzWBIvOsB2ggBjxpK4sioJzxfMdxrvBGibd
 yE49qpZB39HYrGXQ12bu3gGfN+89LdxV4BQq9gK1sWpRFkjBUqp/UvJLYZ+L3DtWbg9g
 R2AkkD2ruvaIBzf7e0vouGV8t18Tno3+EkmIRAaDGBccusojcRb04b8eVSSap4dWPY1O
 b4aNDMKMKyKSaabx88powozt844fgfzbN97Fz04gnw94srmdl/3S/NL1nwmUKWEdhx5H
 ateQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091415; x=1706696215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBMlS39CW/Iv4VBfcOh+Zv0cB8PVhw/t20rhumALwGU=;
 b=ORIIHZVpyokCZ5MhPf+rDjABkoldUMve766OX1bh3nPuDiZbGvSWEGs5JTQF+3SotK
 61pVRpP+S+ldlGjfgZ4YTtQt/Ew/UfHPDoSQTIc+jdeybPNeKU4075LZArbVSWyx15RC
 yuEikW/XHIs0MRGWRUxBuD0wCT2KO3Ps178hArNjK7JvpNFJaQEn3Whll0u3NbOwAiOs
 i/nAPTUm3OXP97mxkOVXIshTP3U+UEOKnLCUBj/QNSAZ19J1x0NoE/5JSR3z2AdIFXNx
 Yg+SIJRcJBmgrVIHbwb+tEgdghV35w5L5kIog8PjyO+K27GbZF85uPdjJtDFroCTCkwu
 KoiA==
X-Gm-Message-State: AOJu0Ywcm8PR3Hl/X5LWfCnbcxJTZWHztCtppc6ZzHcwfk51CsSMVYBd
 K4ZU9RIiIFL+pidhGHfl6Ds/YtL4XjB0AWMAR51L/UZ54koZ5w3r3G61QSv1eHA=
X-Google-Smtp-Source: AGHT+IGWwkbYOC0U4dBmSTynpfE6ssaqXGSArnjuAeOxnV9ZtNSORTiLNAcuzDaJQpkloBLfSHLM6A==
X-Received: by 2002:a2e:be84:0:b0:2cc:c7ef:924d with SMTP id
 a4-20020a2ebe84000000b002ccc7ef924dmr971451ljr.29.1706091415358; 
 Wed, 24 Jan 2024 02:16:55 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 cn7-20020a0564020ca700b0055c349e04f8sm3444326edb.36.2024.01.24.02.16.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:16:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] accel/tcg: Rename tcg_cpus_destroy() -> tcg_cpu_destroy()
Date: Wed, 24 Jan 2024 11:16:32 +0100
Message-ID: <20240124101639.30056-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

tcg_cpus_destroy() operates on a single vCPU, rename it
as 'tcg_cpu_destroy'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.h       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c | 2 +-
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index f9bc6330e2..17c7ed00eb 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -14,7 +14,7 @@
 
 #include "sysemu/cpus.h"
 
-void tcg_cpus_destroy(CPUState *cpu);
+void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpus_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index af7307013a..bcba314a65 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -118,7 +118,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
-    tcg_cpus_destroy(cpu);
+    tcg_cpu_destroy(cpu);
     bql_unlock();
     rcu_remove_force_rcu_notifier(&force_rcu.notifier);
     rcu_unregister_thread();
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 3208035d85..0617f66b5b 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -131,7 +131,7 @@ static void rr_deal_with_unplugged_cpus(void)
 
     CPU_FOREACH(cpu) {
         if (cpu->unplug && !cpu_can_run(cpu)) {
-            tcg_cpus_destroy(cpu);
+            tcg_cpu_destroy(cpu);
             break;
         }
     }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 813065c0ec..9b84b84218 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -63,7 +63,7 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
     cpu->tcg_cflags |= cflags;
 }
 
-void tcg_cpus_destroy(CPUState *cpu)
+void tcg_cpu_destroy(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
 }
-- 
2.41.0



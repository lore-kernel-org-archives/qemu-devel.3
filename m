Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ED0C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rzJ-0006nR-36; Fri, 03 May 2024 08:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rz5-0006kx-Kb
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rz3-0000vZ-V6
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:51 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a597de5a715so288284866b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739147; x=1715343947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9C79ZCDN03MmjjHQ6TSF486EGxB4sAu8CtoKMbncco=;
 b=hc46BKcyj2lyZR5KXgcyC1zSP/BjVJnP6VZcum018TBva4L3tjsHEAVlASGv1rqHL4
 ITTLSuXN6f1Gf/a+/dyhUYCX/UMcE7sWES4URYN0s5FCgCt8Nedn3AFMov4WYu4bKhOh
 k+E8YthftzLmu1LGiqh6cec5k+9zfY/X4ZVO+09u4n+xW0VJpBPjxZYkA0VvM07kLaJZ
 0X3ZYWvqmGko5KVHGa/vHNTxDTAiqH74Th5EcPDwQbA9lVNRd7GWByi3rGttakTwKfUz
 LSf5H7d1Q9bjQuirvKf1B8dy2zKudlYjZctReQaV06l0wubfmRpgRQU4nI+0yFqEfhWo
 Gfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739147; x=1715343947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9C79ZCDN03MmjjHQ6TSF486EGxB4sAu8CtoKMbncco=;
 b=cJxzs1ffp9h/fYsNjIJshvAGfOyOqc237wDwugt2tlQYqGqNZ4IxIb5AKje6/le+bm
 ziOwIusL6UFHStjnRhpYoo04qb7q28df0fUnHvQ2mVGHteVAS/fAOkT2PJdpE16yBwvf
 2ISYi5JSrYND35+Lo/5nM/4HHq9wjvfbTnj6aIbBYT7h4Oc7A0om9wWlc44t6S/n4/Dy
 p90BATgHEt9LBgsDe+sM4XvZVeETk8RyxNgNbZH1KfDcFYCo+Pp1dZS4/atku0/XBQ5K
 JjVpoSZ7DGnp6MnJltZzj51bSnDuaEb0hE551mluhvBLcOPgJQjEMGK0fD7LW6T8bmwS
 fdGw==
X-Gm-Message-State: AOJu0YwADLyVdFCDNG7OfvKUr8ZKIm9Cib/2Xd5HwgefrpcEzbPILCo/
 5M/kJtnh04XWJjyl9xdIoZgn6+EhQqd85GeXE86VzP0R9aRJBk69MLSuHZgyq0m7d2CUasNOFgX
 a
X-Google-Smtp-Source: AGHT+IEp/34A9cyWjc9ryiKET1ETOtDLjid3lG8z3CG7LEL9+aTJDDmHoNCSQZ5d6eNj5bH4HJYW5Q==
X-Received: by 2002:a17:906:d8c9:b0:a55:64bd:2544 with SMTP id
 re9-20020a170906d8c900b00a5564bd2544mr1607692ejb.60.1714739147248; 
 Fri, 03 May 2024 05:25:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 kw15-20020a170907770f00b00a597bd5e672sm1160025ejc.88.2024.05.03.05.25.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:25:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] accel/tcg: Introduce common tcg_exec_cpu_reset_hold()
 method
Date: Fri,  3 May 2024 14:25:25 +0200
Message-ID: <20240503122526.28312-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503122526.28312-1-philmd@linaro.org>
References: <20240503122526.28312-1-philmd@linaro.org>
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



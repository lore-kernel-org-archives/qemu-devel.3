Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3673AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rzl-0006zM-2U; Fri, 03 May 2024 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rzQ-0006tx-OL
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:26:18 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rzA-0000wD-8r
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:26:11 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso148188881fa.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739153; x=1715343953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Tb/CgMjRwAYjJGSlcjkSqdpYLQYMSWtat67VigpwVw=;
 b=apzg+PqjaAAA7qA6p9IQhI49w2ZEQDUJN2v64U7+dxmAq7gujjyYsq9dzmHRKuViaD
 8QLKdMta9gXGNNkfpNxxX1sNo2Li8SGKUthI3mTf/QtOeN+TLNj0oPDBYkPAF9ReWB54
 XjHB6ZEBWHxHeXeY6pqqNg48eDkax4Fx5kItRKOIzg3Pdtc70/R8hA7/CR+d98lyy9au
 Tc9uxTi6ReuhAJWTpGW7zQrC31OqXB4rSLd1GeT7cixH+tut8TbfZctK2JHTgmiQulHR
 6y49M+3jNkTPW58pYLV+8MKXT3cHNxuH4cbc2oQA2nGzzcNX9TdbZmkS2K4ZHyOYdeON
 iFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739153; x=1715343953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Tb/CgMjRwAYjJGSlcjkSqdpYLQYMSWtat67VigpwVw=;
 b=KvQqgY6yvaYdgFQOt2u3r7pnH3XZYFXQNqNt2WQC745zs1efaJTBeyoHjuVu/8ODZm
 oCTdVgL84HRFAuSXRGQtZgVqrDz/oLApacJBXf4AUIoKeenvIzx+CcZ1a5dyoXNvBlq/
 Ku85Mop/6P6s4h6wQf8Y5RumKAENlA57XK78MLICfg6Etjk3ERXWCum3fyZSKYl0Ffbn
 rheXeMo3UVxZP0ZZH4ig0GihUq7wqAOkv0Up+u93GGTP6jSqBNMUakdTZXJ1bQ8FfSkP
 57dyiDJZYOP+WZTq9yJsPUCU5092cg+3q6CxSm6jTDBXLX3V2I4SZQGjf8wQJmrppOf9
 op1Q==
X-Gm-Message-State: AOJu0YydxXmSBluCC8xtMoJ94/DWme8FJREDp//PcNbRC8v3Or9jQA49
 ss0pCSB+L1m+S2NusDHXJMThO/918K2fmqboX0QzFKR3mpEtHp0vJyH6pDS2zl0jpJiAS/AL8lG
 u
X-Google-Smtp-Source: AGHT+IFI0ZLJnrfcCBQPmi0+7XoX6WSsB+GyMkxzQQ8pRMXJmqKF6V9J490cgLHhyIxCm5wXFCta4Q==
X-Received: by 2002:a19:c214:0:b0:512:e02f:9fa7 with SMTP id
 l20-20020a19c214000000b00512e02f9fa7mr2127751lfc.1.1714739153128; 
 Fri, 03 May 2024 05:25:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 ay20-20020a170906d29400b00a58aff25d77sm1639278ejb.193.2024.05.03.05.25.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:25:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 4/4] accel/tcg: Always call tcg_flush_jmp_cache() on reset
Date: Fri,  3 May 2024 14:25:26 +0200
Message-ID: <20240503122526.28312-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503122526.28312-1-philmd@linaro.org>
References: <20240503122526.28312-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In commit bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
we unfortunately restricted the tcg_flush_jmp_cache() to system
emulation. Move it to the common tcg_exec_cpu_reset_hold() handler
so user emulation gets the jmp_cache initialized when threads
are created.

Remove the NULL check in tcg_flush_jmp_cache() from commit 4e4fa6c12d
("accel/tcg: Complete cpu initialization before registration") which
was a band-aid fix for incorrect commit bb6cf6f016.

Cc: qemu-stable@nongnu.org
Fixes: bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c             | 2 ++
 accel/tcg/sysemu/tcg-accel-ops.c | 2 --
 accel/tcg/translate-all.c        | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1bf85c324d..7e04df2902 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -36,6 +36,7 @@
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
 #include "exec/helper-proto-common.h"
+#include "exec/tb-flush.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
@@ -1099,4 +1100,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 
 void tcg_exec_cpu_reset_hold(CPUState *cpu)
 {
+    tcg_flush_jmp_cache(cpu);
 }
diff --git a/accel/tcg/sysemu/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
index 82c8368f87..13e450c088 100644
--- a/accel/tcg/sysemu/tcg-accel-ops.c
+++ b/accel/tcg/sysemu/tcg-accel-ops.c
@@ -34,7 +34,6 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 #include "../internal-common.h"
 #include "hw/core/cpu.h"
@@ -83,7 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
 static void tcg_cpu_reset_hold(CPUState *cpu)
 {
     tcg_exec_cpu_reset_hold(cpu);
-    tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83cc14fbde..93202fa3c1 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -663,11 +663,6 @@ void tcg_flush_jmp_cache(CPUState *cpu)
 {
     CPUJumpCache *jc = cpu->tb_jmp_cache;
 
-    /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(jc == NULL)) {
-        return;
-    }
-
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0



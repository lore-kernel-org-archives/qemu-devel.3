Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDBBC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDS1-0007FO-8n; Thu, 06 Mar 2025 10:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDRz-0007Ey-SO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:47:55 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDRy-0006DM-Al
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:47:55 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39127512371so627363f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276072; x=1741880872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=keumHK/xGB74dShNqulk/5Z/c6mVK2UvLucS0OMjfzY=;
 b=mfOo+0B7IsEnV/LTFZcIjpsGj4Wqjv5JOZq+Wly0pYw22/Qsbs1N1AAoZrKCXUwWTS
 62ci6XX+7WqBXgWJvRt67S9x+7FytA9ByR9cVXi9vkwSOT3a25lHVIHjCKdSyfQNFfgy
 laotQEt/PORnArEl//TCWD3QsXKZ18xy67ecTIzlFtogXZ4VZSDkSVP/y+vKUbvZxnnA
 4khjtq6L2glER2+YzC6Z5o6Nu8VL0XYDF93CkcUNItcSASM8EGUKQ5RIiylsVFwT2QUZ
 dckQJin+rSQ74H6IEgpld2GMknSNnvn4c/1DeaSarG+2PP9diCWfsW4UfWNlAw5LzbBF
 a5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276072; x=1741880872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keumHK/xGB74dShNqulk/5Z/c6mVK2UvLucS0OMjfzY=;
 b=egORtYPpY9/VtdTN89g7mons0oSbYfLyCQfTZbznEfDdOU3CmvRPbAsjK4xTeCjLee
 AI5lsw3pK3cLHwiKNlYC4O1V5LaW9j5U7XC4d4wzvOT0AWbmAwnPezI/wYt9uuj6tB22
 UrIYirJmQmQqM7NUJd3VcjLRrlAbgZ2STS032nVWNHXy/TICYXIqv35+Tg/83w1lV2mj
 ULcN9VzCyYpoSdk1Kn2axYmv69pszZeCxfDVhuOfuKLcsEd+BN8pFqDRH+KcXTFlHWjK
 4Sw1BqYhW80tTq85FYJY0D4xuDA+iTSjDW6Ys+oxGHL3h1SX3XvFGhQhRB9eo0XYMpzF
 r0Vg==
X-Gm-Message-State: AOJu0YwL/TnjQMHckunH++n1Ndzl7eJB9e575bF9jGGO7/UE7pCtBYxx
 d1/DcCzm4bdZ6UiJHxOcZHpho0zF7WayNzHLGmwpBTZjXBD15OzayzbTBaIdvWKLyUDALiejjGg
 MiOw=
X-Gm-Gg: ASbGncuJegh/KTKrSORV6O2zwpMyJUar3h4gw7tdnJHWtAGZC7MOtl+OYnO+JtgGCSv
 KjW+9qSUlqcLQjoKpF0F6MkVIq9fMkoWv11yx1Me8pH1s9+uulcVqyOnPsHYeP2dn7SZ+3gptmV
 6upVQp+kuowrtwQ/obxqE6dA+EYSV7W5XymM/HWwryO5UXlA9muYEiny2FM68oGKILVjZH6MUOi
 A5OpbblQfLG+xabBB4cs6CD311Wm+l1aupeGO3/VDxQbKbAcco95FGv5oH6ysu1dzba139wvc4C
 dki4PBTZ1aBYG4U0500/Ztt+19owF7mqDKSUjBqEkwmNksIkA/DrDYHbeSO4Lc14KX9YAqbpwHg
 JWNrw1Mpb1P54+dAxneQ=
X-Google-Smtp-Source: AGHT+IHIPwAgUmDOJbT8oesttxWDkLwRMDZI6dbZvHgFzA9Fs1H9+ME+8UsLVwBKo6h0CBxYMDRbwQ==
X-Received: by 2002:a05:6000:1864:b0:391:22a9:4408 with SMTP id
 ffacd0b85a97d-39122a9453cmr7996914f8f.16.1741276072503; 
 Thu, 06 Mar 2025 07:47:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba66esm2442214f8f.18.2025.03.06.07.47.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:47:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/54] gdbstub: Check for TCG before calling tb_flush()
Date: Thu,  6 Mar 2025 16:46:45 +0100
Message-ID: <20250306154737.70886-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Use the tcg_enabled() check so the compiler can elide
the call when TCG isn't available, allowing to remove
the tb_flush() stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-4-philmd@linaro.org>
---
 accel/stubs/tcg-stub.c | 4 ----
 gdbstub/system.c       | 5 ++++-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 7f4208fddf2..b2b9881bdfb 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -14,10 +14,6 @@
 #include "exec/tb-flush.h"
 #include "exec/exec-all.h"
 
-void tb_flush(CPUState *cpu)
-{
-}
-
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
     g_assert_not_reached();
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8ce79fa88cf..7f047a285c8 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -22,6 +22,7 @@
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
+#include "system/tcg.h"
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
@@ -171,7 +172,9 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         } else {
             trace_gdbstub_hit_break();
         }
-        tb_flush(cpu);
+        if (tcg_enabled()) {
+            tb_flush(cpu);
+        }
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
-- 
2.47.1



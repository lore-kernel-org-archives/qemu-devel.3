Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD85C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6sJ-0006CZ-ES; Thu, 23 Jan 2025 18:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sI-0006B1-1G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:38 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6sF-0003tb-Ea
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:44:37 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso1439123f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675873; x=1738280673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ce4xXqVbqUUJ3kwtGZLdz75HP+CS3yxZeowyzQLM8Ns=;
 b=ArNhyyY9wHQnUy9VaH2mZVYpmQHRKsjWgCeUgeb6aZqf0NLt+le9c0FxvRDUq4LwT8
 xpXBUH0SUc8ymZFTrjZqqFqAqmPmTPPwCWjdOG3MpIT+w4lP14yqqpEQ74TJTBZFp6y4
 qLfQNhghgu106Tpf8/YKWnsvXM1HpjskJLbwG/VVMyjc61E0Q+6KnZZU5Lwv9XIFHVva
 7zTeoyBzZRH/BfJIeCKZ7DiLJxCGpbyHYv+iK2Yoyb9X20E2jvPM3vQi49d/PED1AxWg
 N5iZ2Qp8KujMU8ziwJ5cLzsfzOJVSjTnv8pTDWd4YD/CANL5IIhVBA9/H0WlYVAdvC1S
 qu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675873; x=1738280673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ce4xXqVbqUUJ3kwtGZLdz75HP+CS3yxZeowyzQLM8Ns=;
 b=alPnPkS4+fTLaxEvNxvftd+EOOXp/ExOZdNmjYhqvNBo2D0Qt1ROfCNA6aKQy3Cgop
 Ny0C+JtFscFxXzm5dEf/zVyFXjPlPL1JvAiPcxKiYBb1a13x2/NtSCRFzmM8PGvuFpfL
 6sdjtXExYkNUXnEtrZzIMna9xZRK+f9y8tWT7nGYN1/aRs4ebnNQYMQVQsCPIRfSsX3r
 qn+TiIRNX2nL82sr2XtKlvqjl3v/DYJWiWTYF9rV03muda4SaDa+rusHNidSNbSXpTCI
 xQc/PJsAsCOtL/qRQbw7WKNBUA2fFVw7IuZAMYNReEHeEvlKp9UizZZO7SFtBAYvad8F
 5ZJg==
X-Gm-Message-State: AOJu0Yw6CyxmxsV3my6cMlFgFFDAstt1zwMvfHAD3zzfeOZTTLxFtA1E
 dvO1OJ7twQ4pOvm21HnHctlZaK5ro0ao2RrC6e22WiPw6jUY4h0YrNdF9vpbmKNdDsgr2LyWv1p
 JGpA=
X-Gm-Gg: ASbGncthAvMGR8WJJE4Rpmk5ynr9H6BzNxbP/nLJuXPHnO1i7XL3yf9hE/KXcL+Glyy
 1AQB6ssby3jelMZllY1FPmTXqUjQUNWI9fZhRI2bODKFlN0/CxTUw5dRjar88MsxjZXW9uuu8kU
 yFJKft+45HZionoa0rBiNbcYbJYtLGNH0f1s1d2+NMm4Hp8+0KLaww1EwvgM9+yAO+JCK4NO+Gf
 t1puobhYzOePmNjleFQnpqvfWohQAOJ/DJS0bunyv7yAGILVOs/8JryS3qS63Bz/e+2qay26Ell
 mvRPEhP18Tu4twukOs9vowlzX00HTWVRNQtPunsir5oyoiK6UxAKUIhpIJal6cJN+g==
X-Google-Smtp-Source: AGHT+IF2OW+qflIazHPgiEcST7oe1qZGT6aj/Hik/HFfGWbVcOJj4aFV8515DLdGfzbOF2nObYCMQg==
X-Received: by 2002:a05:6000:144a:b0:38a:9c1b:df5b with SMTP id
 ffacd0b85a97d-38bf566a279mr25563799f8f.30.1737675873434; 
 Thu, 23 Jan 2025 15:44:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4006sm982952f8f.94.2025.01.23.15.44.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:44:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/20] gdbstub: Check for TCG before calling tb_flush()
Date: Fri, 24 Jan 2025 00:43:57 +0100
Message-ID: <20250123234415.59850-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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



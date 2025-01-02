Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2908E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPtu-0008Op-PL; Thu, 02 Jan 2025 13:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPt5-00082i-BW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTPt3-0007uG-LS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:25:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so8027606f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735842335; x=1736447135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peARTf2/KC6klqYofRoAuLkEwM6US8QQU7qQEt05x1c=;
 b=SKO6p/2Z38NhBURzbzssUwzCiDschSx9YPnpO0lR8QMUqzjU6QevyleU2UCi8/lhqI
 F34QwStX2YbbuR+hT2/QPClzxZ9XFCvCQF4UxbGsLe1dQNbdUf3y8KuD+tyhJdDbhhK6
 y8Hw5QqH8XiUpTf3EtksCmQzm3rYOgLBLhbrHvq//cUq9K1OsuRIXgOvykTKaWEbXGzG
 VAP2Nc+1Hl1xbimmudpAUWVIhTwIN4I9a3eitX5n8BhuxTUTf6KpLZLeD9y/+m/jrW30
 4n4479pOA2kzANQBETY6TmVKMy9PpYsInejJlS2kFOCAvR0njLSfNewN5wgt2GwsKj2M
 /VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735842335; x=1736447135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peARTf2/KC6klqYofRoAuLkEwM6US8QQU7qQEt05x1c=;
 b=eqRvN8KhYjJ+6RefO9HlcNjoc+IlnR43SIvnJJ1ms0zsPnui1YuGdOp/jF3dzbc0dc
 dKH2X9QFesvT5xEkYm6ADk4pfloquC60BF+5ygswkJ65zhvdIs9n/xkVBxPzjzosSWeT
 j0MuAI9YAc1yhMYzuf0EYgrnr1wey28CPzjahGWPbQII2La4mcaIrYrk2j3TZznfmonY
 XCknj8hv6l0+sLytVoDvBlAG8zw+YlgoUaPC033jvWmRMmd3wG4WAg0SN95nxmW6uVvR
 eQofOZ9Tc6WftDOJwgDE7zXJWAWwNOX0r+sdWTXWNXVtSF/IQ75DKXhg+F4ClAiwzHzb
 0vgw==
X-Gm-Message-State: AOJu0YxTucXV1U/dqfeR0UiW5uay4rs2XOF2ytS9A0foywryll+FGxjx
 bLlDCHznCvxDfx2NTHyXzHvRqmsZmpLK+buJl5t4tS2TQsWOGbf1pw1jh+Nh8y1FRvgOJb3EjMr
 9oSH9wQ==
X-Gm-Gg: ASbGnctn26/ICfvWnQPgD/mDgAQRGMSbxR/XSbdqRsOzpk9Jw8OHTTWqFFFS6wlY8jO
 aeH5Nsp40DQcYztbwTtG2pyDSycykCctH/x8owwCMI6ODUiP105t9kzX6vgwHYv6TDBsKp5M0XZ
 pk2ThO0OJL4SLFpqujH9W03IWB3mkEmkAI31FgbquQEjFnzKEy/C6EUj2UOcmAFgcyEaUnlv6dz
 TeUg2xT282yHS+BJNrp4hHY/PHTySEwS53KFoZnGegS1B2bisTmDeUEWAuEGi/fg4inWQjee5dO
 kG033jtYTzijwUCrIliteuzLMWU/AS8=
X-Google-Smtp-Source: AGHT+IEFSbuEYWrHAHLpFZr5TJFmKiZRap2XudEjMBUoAN08DHuam16HLDSAKCdq3J4qLd9JWjtHZA==
X-Received: by 2002:a5d:6da3:0:b0:386:32ea:e70d with SMTP id
 ffacd0b85a97d-38a223fd30dmr29606830f8f.50.1735842335194; 
 Thu, 02 Jan 2025 10:25:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm39723531f8f.81.2025.01.02.10.25.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 10:25:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] accel/tcg: Factor out common tcg_exec_reset() helper
Date: Thu,  2 Jan 2025 19:25:20 +0100
Message-ID: <20250102182521.65428-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102182521.65428-1-philmd@linaro.org>
References: <20250102182521.65428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since tcg_cpu_reset_hold() is a system emulation specific
helper, factor tcg_exec_reset() out so we can use it from
user emulation, similarly to the [un]realize() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 1 +
 accel/tcg/cpu-exec-common.c | 6 ++++++
 accel/tcg/tcg-accel-ops.c   | 4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index c8d714256cb..8b474fc1256 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -55,6 +55,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
+void tcg_exec_reset(CPUState *cpu);
 
 /* current cflags for hashing/comparison */
 uint32_t curr_cflags(CPUState *cpu);
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 6ecfc4e7c21..72ab9c3d977 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -21,6 +21,7 @@
 #include "system/cpus.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
+#include "exec/tb-flush.h"
 #include "internal-common.h"
 
 bool tcg_allowed;
@@ -56,3 +57,8 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     cpu->exception_index = EXCP_ATOMIC;
     cpu_loop_exit_restore(cpu, pc);
 }
+
+void tcg_exec_reset(CPUState *cpu)
+{
+    tcg_flush_jmp_cache(cpu);
+}
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b2..4fe6821b017 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -34,7 +34,6 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "gdbstub/enums.h"
 
@@ -44,6 +43,7 @@
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
 #include "tcg-accel-ops-icount.h"
+#include "internal-common.h"
 
 /* common functionality among all TCG variants */
 
@@ -83,7 +83,7 @@ int tcg_cpu_exec(CPUState *cpu)
 
 static void tcg_cpu_reset_hold(CPUState *cpu)
 {
-    tcg_flush_jmp_cache(cpu);
+    tcg_exec_reset(cpu);
 
     tlb_flush(cpu);
 }
-- 
2.47.1



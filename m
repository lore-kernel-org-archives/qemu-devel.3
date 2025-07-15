Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEA3C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubll7-0003h2-4h; Tue, 15 Jul 2025 15:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbf-0003EZ-GP
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbd-0002ku-Qz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-454ac069223so1183515e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608784; x=1753213584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GetABoj100DJUi/hV9HckckiDTBWpey47wgWH7b+5xs=;
 b=PMhwoJ+XyiRp//oBhLgLjyiR/WD/4mSp+G9hw5t6k7+7YJu9lcvANnRxU+pto1wyTZ
 tnIPyauzYoJ+69eh3RNX8s9wYIFCGaET5E9xcIWF4zgKSo6JOCeCF89En3z9HiyHeg0S
 zC7UT25gq145GdTj4vbwsqmc/Un5UECbL9+w+MNs7bi2Tj47k/3fensFrAJkG5+hWYaI
 xZDiom4b9oZrhTmvUCFOH2xizeNkVBjhtPmwXiy1d+yPwNsxoY0kgCJhzS3z59+eL+sT
 7oyAkeYs7qplpMeJ0wdCqaIsSioIot0WkM1eBDU2aJ0xgfS8XvGoc2uxEnoqEjkaEbSc
 GGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608784; x=1753213584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GetABoj100DJUi/hV9HckckiDTBWpey47wgWH7b+5xs=;
 b=dPswQrZYzD5DB0iHnIGay/TN4rjUIMDLvMHwy3kNHrRCrgHqhNgrjjhbCbH8zlGDms
 jPYfef/7d1skRzAxnmTgFRdmXVtyglBwcrBqI0WweAzsjbgUsWhFI6ffy+AKjj9e4cd9
 vOqTXBr52LHSl8Z5sNH5G8HGrbDFgHx2NPgM0CNAFS9ghwRpJVs4ivR3OfQYloeyVbzG
 aHVkQvyIrbnEOL1Q3hEp/yTxO0GQ7gokpM2Okl/8kjuHZla1Qxv2xhMnRYt2j4GTtPzA
 LkHY0xkwuOFH1nAgaduv0Ujcb7AVSY7XCFaditRD4WfDUteHxUY1tpYHZ1UGye5StnTN
 gJ2A==
X-Gm-Message-State: AOJu0YznH6nn8/snLvHBalDBZWNJ7mYZ53iwcPZho3I/gDY7X+7NHAWn
 MtxYQipdXzJBngnl3cXl/Jl2WW4MgBr+0tC97OLtKHmxq+iGiZ+hntANALSGfDl+s7nI1rWdZhZ
 kRhLo
X-Gm-Gg: ASbGncv5tFXNP/8fub0dfF1L2fXyYh9wIxJoYrwvSWH5BRMWMWDuFXGuMtKqaabCsQn
 Vzmb05y+k5AzRbr+9k64/qc+Y7VKJE10EWmTKyo2jKi6l1ZAmtXT15Qp9cKzwY6sOKJzaw9zDHy
 ySWPOcZkN2c/7VJXIf1gjC0Arl5fP1AwDYkmnfkAhbzh/BOapB3QdRAzuFheagh54eWPukafPYn
 /1fVbups3N8E91k4ebOEaDFJ1paAUh57S78vDz8Bcb5VR7tNhAHq/oRJJnC8kP/djtWt6FMjkGM
 gxT2wL6W4jnHT3p676zwqFlrquZD1IwuMekxF8/MccnGeXKx7yoDn+9MUAIxwkjCUJpms6seKNh
 XhQkZuMbJxkFrfCl36cxUUU+b2Xjhu8G9QVLebwBtjlo09jlWuFagbWb1zi9U+AHWonzFZn3WUx
 f8Cg==
X-Google-Smtp-Source: AGHT+IHVEGtlFTjp0loZiZv6Oaz9AXpjpHjXQcQ+WDbKsSn9fYmf4s/FeSF8CGdRHlecLWEfnt9Ldw==
X-Received: by 2002:a05:600c:3515:b0:456:f22:ca49 with SMTP id
 5b1f17b1804b1-45625dbd3c5mr45656925e9.0.1752608783647; 
 Tue, 15 Jul 2025 12:46:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm15668405f8f.76.2025.07.15.12.46.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] accel/tcg: Propagate AccelState to dump_accel_info()
Date: Tue, 15 Jul 2025 21:45:12 +0200
Message-ID: <20250715194516.91722-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Declare tcg_dump_stats() in "tcg/tcg.h" so it can be used out of
accel/tcg/, like by {bsd,linux}-user.

Next commit will register the TCG AccelClass::get_stats handler,
which expects a AccelState, so propagate it to dump_accel_info().

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250715140048.84942-6-philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 --
 include/tcg/tcg.h           | 2 ++
 accel/tcg/monitor.c         | 1 +
 accel/tcg/tcg-stats.c       | 5 ++---
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 77a3a0684a5..1dbc45dd955 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,6 +139,4 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-void tcg_dump_stats(GString *buf);
-
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0c2a319c11d..a6d9aa50d47 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1005,5 +1005,7 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
 void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs);
+/* tcg_dump_stats: Append TCG statistics to @buf */
+void tcg_dump_stats(GString *buf);
 
 #endif /* TCG_H */
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index adb9de5a1c6..be5c1950177 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -12,6 +12,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
 #include "system/tcg.h"
+#include "tcg/tcg.h"
 #include "internal-common.h"
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
index eb6e20ae985..e1a1c4cf4ac 100644
--- a/accel/tcg/tcg-stats.c
+++ b/accel/tcg/tcg-stats.c
@@ -37,9 +37,8 @@ static void dump_drift_info(GString *buf)
     }
 }
 
-static void dump_accel_info(GString *buf)
+static void dump_accel_info(AccelState *accel, GString *buf)
 {
-    AccelState *accel = current_accel();
     bool one_insn_per_tb = object_property_get_bool(OBJECT(accel),
                                                     "one-insn-per-tb",
                                                     &error_fatal);
@@ -209,7 +208,7 @@ static void dump_exec_info(GString *buf)
 
 void tcg_dump_stats(GString *buf)
 {
-    dump_accel_info(buf);
+    dump_accel_info(current_accel(), buf);
     dump_exec_info(buf);
     dump_drift_info(buf);
 }
-- 
2.49.0



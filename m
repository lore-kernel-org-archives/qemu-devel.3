Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9982BE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 21:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNIpU-0007U8-QF; Mon, 16 Dec 2024 16:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNIpR-0007Sh-R8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 16:40:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNIpQ-0004dD-8B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 16:40:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361c705434so33167535e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734385234; x=1734990034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ThBwWEt+PpQnAMQIM7YHR4VhKN3/BBNOhM5Au/CfbLE=;
 b=DmSWn/p4waEKDUap4Ep34G5tv0Dk0RZFm/sk3eR07HmXUerksF6qMSgZq5cWylhRyR
 Qvb180YzBx4/ELvrJ1dW2uZiQb+CiKc1CtWRea7qRH8i/Jd/wayART93xUrbFWXSHb/V
 boVG5rMF4R6vGL9xmsW9r+Is/YiSLMN6IA2thAhUw4KdSmAQGW5j1+Bl2/vgP7Khi49B
 +ka6kYCpcgmKvOo8MVc1Q9GzGqgdmEThQYyQnCZ7aTbQK3kLQI8Uy/sJ+iox5mVzTyK1
 gTGqromFCVvywXoxlF7cgLWPUQbs5rAJt2l+HrpzwbOEpdNbNEu6RMDXTEPoSzIBfCiK
 huTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734385234; x=1734990034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ThBwWEt+PpQnAMQIM7YHR4VhKN3/BBNOhM5Au/CfbLE=;
 b=kjrOssQnk/q7MHsVz6Km1DC620V3CK3UmB/6pRaFK+EWRM7hVZ/YLDxFPzBQXQ2fR6
 /4wfbJ7L8/oQXgKcb9K7WIdqKVY+4Y+CzlmTIg2HNw88UUOH3YM0RXbUgVyPj4bM/QC8
 QiO2Vs+kDNsPSIvG9ihzyGKrGUunb/79dd61STGzJWlb7Zqs1WiXTv9q85cC1/L24Ovq
 eF+ldjRBvYkFg2t9uvxoh96cd4r8oDA1ulmO0MGfZuwZRKdbFihw/1BG1rHBa1+3eRNf
 zavlmpUwk9zCACZOqi4pRr61XxkvWU41k0epl4Ei6ltgeSVCXU0QMX4XNWhLAXCH+MCF
 zElA==
X-Gm-Message-State: AOJu0Yy99b0gVS8V64YSyv22PyhBbXpLbPQXm1nCL8+/x0Lh5j/QbcIW
 LLtvuLslcrXLu39Oo6U9US78Yn4/xDp6JhmKGKZrEKfzY6xNTTqVblm5EJY/NFHWARMgVuKGlo2
 v
X-Gm-Gg: ASbGncsFysHMY/TaK2mF9fGWm2jfW3KMbG+Wzru2ZzhSOmLJI6xOmBQwkjp6fge69Ha
 1Lda/xbyrvXQiAHJUPVQWKXsCU3bhrIBksY0g0Rsx0YFdVk7jdSJpMKwWGryd4PDVDuO8AN5MsO
 PsKRz18fZnIlvYt+CtVFenUFZIivUQYVG9G0x3/Qsp+NhLhmwflg1XM5+Y6JIuaXIqOkkF+0bAf
 GgN3xYKb2pLnV/CCqyrQtU8WM9Qr1+lKWNOph7Zrs39r5EetRxIl5OAWGfGzWOF8O9iAUjX4qk=
X-Google-Smtp-Source: AGHT+IEiRNRN5ssu9TIVMJZNxNIjzGh04XbQhNLprCNSLHevfCtLRN1HuYQ2y+ADB78qDPLJVcP3Ag==
X-Received: by 2002:a05:6000:18a5:b0:386:4277:6cf1 with SMTP id
 ffacd0b85a97d-388da5adbdbmr1015496f8f.39.1734385233648; 
 Mon, 16 Dec 2024 13:40:33 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362b64b0sm97999595e9.30.2024.12.16.13.40.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Dec 2024 13:40:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Restrict curr_cflags() declaration to
 'internal-common.h'
Date: Mon, 16 Dec 2024 22:40:30 +0100
Message-ID: <20241216214030.59393-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

curr_cflags() is only used within accel/tcg/,
move its declaration to accel/tcg/internal-common.h.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 3 +++
 include/exec/cpu-common.h   | 3 ---
 accel/tcg/watchpoint.c      | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index a8fc3db7742..c8d714256cb 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -56,4 +56,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
+/* current cflags for hashing/comparison */
+uint32_t curr_cflags(CPUState *cpu);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5f..ff9ea71f700 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -190,9 +190,6 @@ void list_cpus(void);
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags);
 void tcg_cflags_set(CPUState *cpu, uint32_t flags);
 
-/* current cflags for hashing/comparison */
-uint32_t curr_cflags(CPUState *cpu);
-
 /**
  * cpu_unwind_state_data:
  * @cpu: the cpu context
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index e24baead562..fbaf45d10f2 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -27,6 +27,7 @@
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "hw/core/cpu.h"
+#include "internal-common.h"
 
 /*
  * Return true if this watchpoint address matches the specified
-- 
2.45.2



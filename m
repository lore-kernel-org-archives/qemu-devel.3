Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8ECE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoNE-0004VF-Cn; Thu, 12 Dec 2024 13:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMz-0003Rt-WA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:57:08 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoMy-0006vb-Fx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:57:05 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-728f1525565so1135633b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029823; x=1734634623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Xzd/um0GVNgOnzI0D+rGp5GEvnFQawTaHdbkCJf8k4=;
 b=CyqqKBuE6zhHUoXnOPpPoPCAoDINkBX6TEDq99LOSMxb/FkTAhNwtS1/J1kZeupg67
 GoiOKGxrUwTJz0zgskNPdlTtfIxGJG/N0ewzRn2LooNja5ZIoXN9IAK+qpJVQ2jwHUFM
 BISljVohZDquaYVNNizGA73u2UIc7KEq0hdEoeU6gMDL/OlL38TU7WmUypSzQGOJjBvP
 3BYmABErZo2EneFR2zwrtYWzkz4ad5PU6sX97oH31ncLMvythpmKjWuWeL10LQUEm3+N
 JGPEMnJKHwotCiqjHjnF21Cm5nrITOCbYeSQyGdyGU2l9ZbipNApiYXYl26t2hMhabww
 6/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029823; x=1734634623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Xzd/um0GVNgOnzI0D+rGp5GEvnFQawTaHdbkCJf8k4=;
 b=qY9Sn0f3466uTpZhCmjrQ2L2f0cMrUu0z152vsNyMn8RlN0Rjuj4N0uqU9bSkDw1jp
 9c8MEqL9nllyGG2Mvil4xA03VilMkpEJft3a0SV0zgtDDM74rQdjKnABnUpn7ytTL5J1
 CxDkcaoq+rcxsm7XT8bcPcDp3tbmWAXPllLEMMmm2ev2CzP5RALE+SxubS1vR0hEFN3L
 dCmPW8alXI6wbM1AQvsDwsQEqY46UkDb4rB7oCVFkaCooEuobgCUOdbjJnmIkOALnOO6
 l4vXlGrdVeW3K86FTCFp7YCRjMMcBAC1om5TrXWnEIrrULRepVjyXk5AV4/rR4AA8Liq
 +zXw==
X-Gm-Message-State: AOJu0YxEuEShNpXoxSJOfKngOpgXiISzaG5WpfsJTbKxlQNFtkL1qa3I
 g5Py91aDWYj1s7wXM1ri4IIMSe+ynVucUBbN6tZUWgo391peNTztZuzszzwGdrFdrzF7fp5vTIP
 +
X-Gm-Gg: ASbGnctFXRO26imAS4YI2c19HzwIU2Ucm+tzI0P2LpPNbzOZVIa/R+M4CmAoR0KhNep
 U91qFO9G/kvl+9/UfAXEbxVERLnpYxDLG0TrZEzGb2ZtEEvQ4tBoSU/OmyF3BdSJcW5qIw9SgU1
 JOgZcmgsBy97448GQHbwV60hykGF0VD+Y1eoHd647dghjxnNIz9sVV0M+4yXkU+AzkNP0lYG3pn
 3Gke+EZpi6F73CD/w7RPU80K4OJwd6GYebfZJBwS9a5Ftexjqe7owtlAHYfXguMZvgLS+9Ev+gz
 p3PtPPEwz5NgjDB1q0cM0EZRADIOrbU=
X-Google-Smtp-Source: AGHT+IFdhp0xCerJaashwcj7KlfhXzfhC9ypAIxLzc7A5FRzAEz/MyIdtV3uQMK6qiPOfqlWPsjdOQ==
X-Received: by 2002:a05:6a00:39a2:b0:725:b1df:2daa with SMTP id
 d2e1a72fcca58-72906a747afmr2322335b3a.20.1734029822680; 
 Thu, 12 Dec 2024 10:57:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ee10f928sm7501880b3a.32.2024.12.12.10.56.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:57:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/18] user: Declare cpu_loop() once in 'user/cpu_loop.h'
Date: Thu, 12 Dec 2024 19:53:40 +0100
Message-ID: <20241212185341.2857-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
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

Declare cpu_loop() once in "user/cpu_loop.h".
bsd-user gets the G_NORETURN attribute.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h             | 2 +-
 include/user/cpu_loop.h     | 2 ++
 linux-user/user-internals.h | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 04faee459df..3eaa14f3f56 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 
 #include "user/abitypes.h"
+#include "user/cpu_loop.h"
 #include "user/page-protection.h"
 
 extern char **environ;
@@ -187,7 +188,6 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg5, abi_long arg6);
 void gemu_log(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 extern __thread CPUState *thread_cpu;
-void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 8e2df232758..b0d4704018d 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -23,6 +23,8 @@
 #include "exec/log.h"
 #include "special-errno.h"
 
+G_NORETURN void cpu_loop(CPUArchState *env);
+
 void target_exception_dump(CPUArchState *env, const char *fmt, int code);
 #define EXCP_DUMP(env, fmt, code) \
     target_exception_dump(env, fmt, code)
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 46ffc093f40..b9b05c1d11f 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -65,7 +65,6 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
 extern __thread CPUState *thread_cpu;
-G_NORETURN void cpu_loop(CPUArchState *env);
 abi_long get_errno(abi_long ret);
 const char *target_strerror(int err);
 int get_osversion(void);
-- 
2.45.2



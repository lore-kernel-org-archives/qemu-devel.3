Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAB2C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CoK-0006vB-Up; Sun, 28 Apr 2024 18:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoC-0006Zc-Ul
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CoB-0005dW-77
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:44 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso642111066b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342541; x=1714947341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwA4gGr9bUP88hrZk3uOFR181roNW8nQo5hO4TYpEMY=;
 b=GwmuzJS9O3ErjeWe35HY0JngSNYtfVGOvx1spgMRk8KlCjUOcczp2tuw/wuTd9T7nF
 YsOKaZ2gmInwTbbMQFqAmjMHB3tZn+LA4YRxZB9ZR876tRC5V2YdhVXWCiZiN2WslPTi
 pmTDdlmPKLLIash+XcVySpFq8Fcqst1by0++dZLyCMPhH5hEPgl73NCYS3pCMg92pqdF
 xkYO7kH5kF0sNVu2LH9vDDhFXZAie6rOlzyL6AdnqhoVXMGn4MkHjHDPvBkEKvQWar6c
 HEWeUINaAoxThU4SR6V2k8LFSheHl6TvwJ83NRViW7D56SHWgkqx3MoSrZASWwLNq6HN
 jTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342541; x=1714947341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwA4gGr9bUP88hrZk3uOFR181roNW8nQo5hO4TYpEMY=;
 b=OA7oJ1ZwGKU7QnTlBJDVDNMD5a9YdE008gsIMHoqC5jdkEwTUgP2b6tzkPxanvp4Sp
 m+a7vXYpTaILoYp1OFTrK+tA3p3zUubVDQFo/2hu4Zq/kAYrz/ZpHDVA08QsG8hVJwju
 0YE59eSQBQZjOorVnhADC0z3+IS3CAYGY/YznBK3zuh48i1q08n5BdnBi4+TNr736RCk
 mw3uQqrhnG7PJM4pEIcXWeRRC0M/KWrg26/F4VjR19BaZsxxM+ljUbEiH8wIcM2t+axL
 Z3+pKU8Rb9frjnfZIKWrZb+eGDVLSZdajrtU2qTmwfv95fX6Lpd7Egfyk8gsvtcGTT0c
 Bl5g==
X-Gm-Message-State: AOJu0Yzjz/rf0Rw/QbGsvL+XglsaAYcRxL3WUOW4uHlVNLhA3TxzrhCr
 MzV+y3g48fK9ff3smLKi07XFrnlFGqoJJFu4o7x0TWVz78Sn/JRyrurGLOmrtZfKMholTQwZtLC
 H
X-Google-Smtp-Source: AGHT+IHVav3nKFAKbJ3CalBJ9VRyRe0lBxC/y/PdjZiqztE2QgOa9NCH8v892cBv80DFs7voPHNw+w==
X-Received: by 2002:a17:906:16da:b0:a58:7e28:b6bc with SMTP id
 t26-20020a17090616da00b00a587e28b6bcmr7246359ejd.17.1714342541564; 
 Sun, 28 Apr 2024 15:15:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 bv19-20020a170906b1d300b00a58eabf6082sm2011450ejb.199.2024.04.28.15.15.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/24] user: Declare get_task_state() once in
 'accel/tcg/vcpu-state.h'
Date: Mon, 29 Apr 2024 00:14:35 +0200
Message-ID: <20240428221450.26460-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

While each user emulation implentation defines its own
TaskState structure, both use the same get_task_state()
declaration, in particular in common code (such gdbstub).
Declare the method once in "accel/tcg/vcpu-state.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h | 18 ++++++++++++++++++
 bsd-user/qemu.h        |  6 +-----
 linux-user/qemu.h      |  6 +-----
 3 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 accel/tcg/vcpu-state.h

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
new file mode 100644
index 0000000000..e407d914df
--- /dev/null
+++ b/accel/tcg/vcpu-state.h
@@ -0,0 +1,18 @@
+/*
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ACCEL_TCG_VCPU_STATE_H
+#define ACCEL_TCG_VCPU_STATE_H
+
+#include "hw/core/cpu.h"
+
+#ifdef CONFIG_USER_ONLY
+static inline TaskState *get_task_state(const CPUState *cs)
+{
+    return cs->opaque;
+}
+#endif
+
+#endif
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index be57374b41..65fe95fed1 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -36,6 +36,7 @@ extern char **environ;
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
 #include "qemu/clang-tsa.h"
+#include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
 /*
@@ -116,11 +117,6 @@ struct TaskState {
     struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16)));
 
-static inline TaskState *get_task_state(CPUState *cs)
-{
-    return cs->opaque;
-}
-
 void stop_all_tasks(void);
 extern const char *interp_prefix;
 extern const char *qemu_uname_release;
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 16d9f6ae8c..515af82d8b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -8,6 +8,7 @@
 
 #include "syscall_defs.h"
 #include "target_syscall.h"
+#include "accel/tcg/vcpu-state.h"
 
 /*
  * This is the size of the host kernel's sigset_t, needed where we make
@@ -160,11 +161,6 @@ struct TaskState {
     uint64_t start_boottime;
 };
 
-static inline TaskState *get_task_state(CPUState *cs)
-{
-    return cs->opaque;
-}
-
 abi_long do_brk(abi_ulong new_brk);
 int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
                     int flags, mode_t mode, bool safe);
-- 
2.41.0



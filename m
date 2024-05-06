Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65366C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcu-0003vY-Go; Mon, 06 May 2024 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xck-0003YF-II
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:18 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xcg-00027S-GD
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:39:16 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51f45104ef0so1975408e87.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999151; x=1715603951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDNxZj+xmGVZ6dRFb3MDxJip4ebx+5/K+HgTl2Olyoo=;
 b=K7mO+6M/yaF6Ti/eESVJUOftA+5vhsMYOGeDyvp3+NMEpYq0kkAlSA/FXg7u2EELhu
 ke8voxkK87EzauNy+WnRP/pROYR/RzljvwNe44newmk70AUcVMHTHX4128Sv21jGSPO2
 7noGfMoPTVA+2XeEEyKOrQZKkzFV/2yPuQhXvcepokKoRHewpKhZdURakfPHtFJc+5ln
 DvcGtwjnBj+D3B+PbJmwtQ/vbAlvdnUItDoGghE7vnO8SJH2RmVMNjnS4WcU5u5kBRhn
 odslCjc1QSGeU9DvgA5/ePAxMh6gBfJ7rqcgMyMk8J5Db1lIYLPUCnsupXZ6jirxCjyM
 Udvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999151; x=1715603951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QDNxZj+xmGVZ6dRFb3MDxJip4ebx+5/K+HgTl2Olyoo=;
 b=ZGBDng0mUAF/P42UG+jOWBzrlTJp8XbCW84zvhJH5b0y2FMUjj7ttkVQG44xb2tcem
 KhLGHTyt3x/F6dMT/qn32YQ2iE6n7Y4h0T1eH0nuGT7mKys1Fh7GMH2RLceueyp6vvv2
 eJtN3wfKCy5HgVFF3OYqJvVSqsbnB4ZZaZ1F0qY4ymMv9aAaDeLp4PeccXR+K3Aaz7jU
 KQSwToyzDe3QAqEs2bnQK6ox7uh2hcEwoi96M3Cra1PJ8pOV5i0T+FQmxnCIcwYayVwv
 y9RSpwmu+ePKD/XPWqu1UrV1LMRdg2oPYUwcppj9ss318NYHLFzyKErKAoULkyuW4ney
 jdfg==
X-Gm-Message-State: AOJu0YwIRnE+MDlEAuP9ZQJ7kBuBe8TtTA7tT1Akmk29ED2Z+99sSlUI
 citvRRaxTBWtFl/4WeJLtYMGCPYi+/3POr6+SYMdKB/c1xh3sdglTnmitu13K+bBurGCIMC4je0
 5
X-Google-Smtp-Source: AGHT+IETmXLyJWr8KoautskF0N3ZgZbcy7gJYXQ5Wt6hzGJJkQ/rFfvwFedCBe+DzqZQB8xadV7u+g==
X-Received: by 2002:ac2:5291:0:b0:51e:f1a6:ac39 with SMTP id
 q17-20020ac25291000000b0051ef1a6ac39mr6195254lfm.12.1714999151475; 
 Mon, 06 May 2024 05:39:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c351400b0041be4065adasm16097989wmq.22.2024.05.06.05.39.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:39:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/28] user: Declare get_task_state() once in
 'accel/tcg/vcpu-state.h'
Date: Mon,  6 May 2024 14:37:14 +0200
Message-ID: <20240506123728.65278-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-10-philmd@linaro.org>
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
index 1780f485d6..9d2fc7148e 100644
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
index 7df4645c2b..2e90a97175 100644
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



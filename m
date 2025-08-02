Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293A6C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLTv-0005wO-SI; Sat, 02 Aug 2025 19:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTD-0004PK-Qq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:17:01 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLTB-0002gc-OP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:55 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74190a2fc10so750865a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176612; x=1754781412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PcJpR39SssShXVbHba+WgDV342jrg7zDHAhF6M4KN6o=;
 b=HJJTQqVPGW1B8iTG+NaRk5PwsCvkh4AhX+eNw81iZdskhPNmET4uZPQSk33V4E5PfI
 EhUj8UKQbqV91LE8s9OrZ3cS3VOYF4duGkc9aQWKNuPQwonaZvPvzkqs6VyiupZirehH
 7p59uBc3Au14TOOu2FLSfa29wVvcHqSHzrsJfblkj+vwT5AXAH9pwQc3RtxgPxnlvcwE
 iCe9+JYS1Osd7aQ16ZttYK6pfxW4GdEhGqDF4ECVptfCXhxcguDGOytUXYAUiGXg6+3H
 y9uByXz29nDmWMnns+cRk6jZEn7fNnw6xVHmk4tUW99vFl/PM4eCXB76jaeM/3D5fxFK
 yq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176612; x=1754781412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcJpR39SssShXVbHba+WgDV342jrg7zDHAhF6M4KN6o=;
 b=qRpMnuRlY4DqFLtwSK73rPGNU7lucVLPSrP0VNu21/v4h3TH0/rr6IlYw5W+FzmCkK
 a/aXowhpC1GpZX0b8hygcP4ZenOYCtjTERV28x3N9LJZuQuiESSIPPgWGYtKL553O1+3
 veDffaegPenR9J8hgiNwQ+xdUUbuQMziePa9eGoTdHGVF6yY8cBuN3rTF82xHi5xtf1k
 5MAPk3vs/VvMCQ4XMh5smw8s+XbbbweubbHctbLWXbBr5DAIE2k1f6dIcFhtN7ROvK49
 f6bDcdJT797XB+Osccx6nhr+yCmfkIypncJXw8g9XLpryBJ5Zp/qPc2lL4YvJBbRIwKB
 ElKA==
X-Gm-Message-State: AOJu0YweN6SIO9xv/13TZdaA18s50V/B0Kq4tIgl3PxViNTpRH2ycOWj
 Kkne3Nm5/NGKgEWWzhkRxOOrRuJzSgHgCz8gqq8HtHQr+TBewjIFp9GM9Q5Gg5b/pK3AkO0vmFY
 5ROvVD14=
X-Gm-Gg: ASbGnctuX9D2SFJLP9WfmOe3Lxz8fxXUzMntpCizoQRb9VOCxeHQhmaHqOvJdoPF4Qv
 525EdEz9SM8bBwcHlaNqyMSt/6Lq4QFtgJt3wUNQg5pI935SD6TpqiegY+E2tTPz3+ikXGqG/AF
 6lK0HZ2Chd3vW7v/nZ5qdWhw7q69pzse2ahqcCB1ePMHbxVIYM82veGxRlMsaGFhLmgx6s8yp/C
 VVQy9+c3FIp3vPMQXI4NqksNrWJSRnoYFDUZkZhGHQTT7Gtekm30lLvRqoR9Ngl9zD2fuE4Z2q2
 6KDOtdzr3d9CtjaZSNv+XfpIwqlQV8UpVpwwpEbTXOChXBKaCUbw73MBq37GYPYrKq8TGYnXvoL
 b8YzVT2tdIAgKobWiF5Z2KOP/CEgNLCmC2H4BiIrqcnkAwMO9pwNr
X-Google-Smtp-Source: AGHT+IFUdQTx6TXXU0JbJZk4BuuA43j+n9vWMdtQueYX4+keAJfqTwIvbjkwPVzxbX6FbcLa8CyO8g==
X-Received: by 2002:a05:6830:43aa:b0:741:b263:4ded with SMTP id
 46e09a7af769-741b2635852mr89492a34.15.1754176612498; 
 Sat, 02 Aug 2025 16:16:52 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 93/95] linux-user/openrisc: Move target_pt_regs to signal.c
Date: Sun,  3 Aug 2025 09:04:57 +1000
Message-ID: <20250802230459.412251-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

This structure is part of the openrisc signal frame.

Rename to user_regs_struct, per the kernel's ptrace.h, which allows
removal of the explination of the name change from the kernel source.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_syscall.h | 11 -----------
 linux-user/openrisc/signal.c         |  9 ++++++++-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
index 7fe5b73d3b..c8394e9dcd 100644
--- a/linux-user/openrisc/target_syscall.h
+++ b/linux-user/openrisc/target_syscall.h
@@ -1,17 +1,6 @@
 #ifndef OPENRISC_TARGET_SYSCALL_H
 #define OPENRISC_TARGET_SYSCALL_H
 
-/* Note that in linux/arch/openrisc/include/uapi/asm/ptrace.h,
- * this is called user_regs_struct.  Given that this is what
- * is used within struct sigcontext we need this definition.
- * However, elfload.c wants this name.
- */
-struct target_pt_regs {
-    abi_ulong gpr[32];
-    abi_ulong pc;
-    abi_ulong sr;
-};
-
 #define UNAME_MACHINE "openrisc"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index cb74a9fe5e..5b97d016af 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -22,8 +22,15 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
+/* See linux/arch/openrisc/include/uapi/asm/ptrace.h. */
+struct user_regs_struct {
+    abi_ulong gpr[32];
+    abi_ulong pc;
+    abi_ulong sr;
+};
+
 typedef struct target_sigcontext {
-    struct target_pt_regs regs;
+    struct user_regs_struct regs;
     abi_ulong oldmask;
 } target_sigcontext;
 
-- 
2.43.0



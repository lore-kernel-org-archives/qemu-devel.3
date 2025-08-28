Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670F1C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJD-00006N-Ug; Thu, 28 Aug 2025 13:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWD-00085G-Ij
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:31 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW4-0008I9-VZ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:12 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b49d6f8f347so823388a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383245; x=1756988045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLQh7CWptXLZv/VAP/TlmbA4AxN3fzKeApuzOewiD14=;
 b=fBA5cil41qT2pUOtOZxFmZ8yIo6rjQ/RW4YTgwbmIIZK7qJxW7EXtO/vz2hIFEWyPE
 w+rSj10xICUktBYQD+GtLWm3/rQfeWzNGUmX03LGEmm0uez/wkNuH9xdLoFANkoBJd+x
 WWD7NiYP83KpYHQS7Uj865ELoVtYadoME3rni7W+DggGzdWIcAuorvGKkb6IedKWMat1
 GOtyY9Q0fpU3cQjUVl5dmfOWO4igbqtcUASipamJb84Sm4WO0ndFQCMxlBVcuo1ueHQL
 EB99DV7dceUUbjYpKT+3JB2biatfeoA0XNW0pQYW3Iii1uG7LfUGFFKGYEXinXLS/hYK
 hcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383245; x=1756988045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLQh7CWptXLZv/VAP/TlmbA4AxN3fzKeApuzOewiD14=;
 b=jkKoLrbHLfHHbIFtUrHXlnQTLjVseqLhy8jwHyGOVWAGp519Ys8cqkNw5Kkb2PVvmx
 8eO8uXoZZgo/Df4bVznjoTWZOAxt2Y7aXIY95Ji4QW4915SvXVGxvl8tJpI/Cx3r2MQ/
 VpQ++kt4nrGjkA6JVesPM1y4lwzRghYimyDnLK75bMB4l7UZjI7+RIshbJQdR7TXpwUn
 YN4QdcoVsQhPRVcyDoEq9lkfUwTEUWqilUPl9Aup9vRrRLMDbbLvWYMocfzZrDj5IRo1
 KDbpurRBVzO44R0Si/MyWMDaYmmaJh5oQLC9Kr0a/Q/JCtUlIOBjxU5MLFzEoMVpAwLB
 r0IQ==
X-Gm-Message-State: AOJu0Ywg86F4RJu4eTPj+k7sMf+iVlMtx/PrCx882GwBscbRyhH9kCfO
 FFVGPopEZecAKsMniBcFIz3NUyzwT37tLq1tZpqTrZNqh+8BzGuwdRgs1XpI0gocMR+bpXtQTq4
 nO2Vhvz8=
X-Gm-Gg: ASbGncuz7D8s/1ikgNgN6vnkU+rhJWWL/EX7OoCMvTPJYAb7OqFVO1z5TutpdgqEL0w
 vYTINPw0LyIyvZtA8j5OLXOZjNKi/zJzoNDLnFS4ITi9Ab09XWt6zYXZ0QtKwMQ97SRGYAAFBnq
 trVFToTf5lcH6YEzzNXwGpoOpxz4IgM7csY2rvCxEaBaasXs20g9PC8YsKtyChXbdNrqx1lS/ZH
 +Pf8SxUnJ9KAw+J7zwY5piDlDIBNzV+DUDRZqdnMj/uen0DLP0UX2rL039mgXwH6ARFG/pDjN4F
 NpiJ9fQ0XKhx8fDqEQWS9WbJsGM766ZVEZj5e4aTnancJjfx7ew1+9/C6F59uBE1yRxbgi2lwFl
 soaEuvtRSCE3GkgURiVgJi7mfDWr+SYz1g3tf
X-Google-Smtp-Source: AGHT+IEzDNJDjNZp4eaCIPCevLG4xEUftyLVMB+iXJTeoX3ZYv4SDLtH73XxQ1zX/ur2sWckeN/49Q==
X-Received: by 2002:a17:903:1246:b0:224:910:23f0 with SMTP id
 d9443c01a7336-2462ef9332emr331298405ad.49.1756383245250; 
 Thu, 28 Aug 2025 05:14:05 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 53/87] linux-user/sh4: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:08:02 +1000
Message-ID: <20250828120836.195358-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Move target_pt_regs to target_ptrace.h.
Convert to abi_foo types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/target_ptrace.h  | 18 ++++++++++++++++++
 linux-user/sh4/target_syscall.h | 11 -----------
 2 files changed, 18 insertions(+), 11 deletions(-)
 create mode 100644 linux-user/sh4/target_ptrace.h

diff --git a/linux-user/sh4/target_ptrace.h b/linux-user/sh4/target_ptrace.h
new file mode 100644
index 0000000000..b80218526b
--- /dev/null
+++ b/linux-user/sh4/target_ptrace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef SH4_TARGET_PTRACE_H
+#define SH4_TARGET_PTRACE_H
+
+/* See arch/sh/include/uapi/asm/ptrace_32.h. */
+struct target_pt_regs {
+    abi_ulong regs[16];
+    abi_ulong pc;
+    abi_ulong pr;
+    abi_ulong sr;
+    abi_ulong gbr;
+    abi_ulong mach;
+    abi_ulong macl;
+    abi_long tra;
+};
+
+#endif /* SH4_TARGET_PTRACE_H */
diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
index 148398855d..2f3557742d 100644
--- a/linux-user/sh4/target_syscall.h
+++ b/linux-user/sh4/target_syscall.h
@@ -1,17 +1,6 @@
 #ifndef SH4_TARGET_SYSCALL_H
 #define SH4_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-        unsigned long regs[16];
-        unsigned long pc;
-        unsigned long pr;
-        unsigned long sr;
-        unsigned long gbr;
-        unsigned long mach;
-        unsigned long macl;
-        long tra;
-};
-
 #define UNAME_MACHINE "sh4"
 #define UNAME_MINIMUM_RELEASE "2.6.32"
 
-- 
2.43.0



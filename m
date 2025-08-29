Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B252ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNlG-0004PT-4E; Sat, 30 Aug 2025 11:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bO-0004RU-RK
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bM-0003cu-5e
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7722e0ca299so859847b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506582; x=1757111382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iygv8tGHGS6Phz8vrjGWEgdybmn9tz5c134WHcDFPJg=;
 b=cUEVZVG9FE6I2VMj+gnvAaJip1JEn5Iym4fUzby2eN6bSWKQnO6jiw0s9Ojlwkw8Et
 PDWqb69Nz5UsaCUXN3gEPakWFpDaSw1dngkFty6rCmOUDEHq78c5Zsa5QS9UhOULncCl
 WI/vbhtT5/qg2nGbU7xKo9NJdLMsqkTUzgo5zTsvr24XXC6ayQTzhBeOUt0NXL7TESk0
 PqLqNeKUtmG9aXK4dPFIbBuummPqzuarcw4GQ5qKnMrCG07yqdpUyfjP8CZBRWrds/BG
 wWyIQbL+rXw0Tz4bwg9W5oYTlWrbCXcCEj4g2tJeURwAab7T2XWTUJWEM0Qh/5t9B6hj
 VFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506582; x=1757111382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iygv8tGHGS6Phz8vrjGWEgdybmn9tz5c134WHcDFPJg=;
 b=Eef5CDPQzdA81rnns80DeaxoBDdILpxIRnLqM1xpbthA7RjHo0Q8hfa83F7/dWR/jD
 nWes7L+sKF1gGToKvqfPasCuKbahC6AbtqaiQzFUorb8sOzrv+wkoNmlqnSqO1ZdLlrF
 YGT3K6kXJFQREGDacKJ/viJ1ga8Nm3QHoEmpfG5/Gqp723IInu73vXFuHhV0u6s27dyU
 Qtie3FAZDeIbWE/h0CUsYYBZWwRGSJgccxjo+6TV+iSQCQ5jF1KffeSn3ayMIweWFdJY
 4jY/fozRIsF/bxbcyNSxXF2wby12H7FSRULiS9+T152RrHJWAZ7LTIPWdOABUZtFBPFo
 RsGg==
X-Gm-Message-State: AOJu0YzOhygV7oXh3s6LITYsPjvbWjD4+Xt17ikdACyNrQmKCgGyc1xr
 E9FJiL4Zb4VLHGzLVymSsl04xCLIr6dwLvv/9ZzRjGS1qKzgm4J2oPea/MGjerXrHjjNEX4WGx4
 D98PBl8U=
X-Gm-Gg: ASbGnctG6QzbDx9C860GXu/zQf7V+syuQpkmstlrkyNM2ZZEIdYMPONj4x5fCWVIBqz
 wKeOU+vj4wBsaGrQ+IjBSXCgVtQXh/1xh0KwLZQtwZ95c2QPDkwAvfxBvYNfeS4F5QxPaWAutyE
 shbBBpvcEXvu+JhtAF7vmAEOWIa2L5IIQ0TcPH3j7578bjpGu/epqE8nThOaMMMGf91oC+pDEHp
 LBnnn6T0EXRh28qRmqvV45Vp5bJ6/xlfqiZWrh0K967yypJ6i9NWp9KWh4CxGDKL+Cc3n2sTzKK
 5bUoeUeWZ6XFfvJDtgWlt6fmKzX1BVdtz+u0IcHS17aS1LbgYhpfi8QvLf/dlWnc1HVnYc2f1PE
 kEp6QB+n9ohzukNwqwJVpubA+A4Kjc273Vzy5XDPODy80nr2tEwXf8ouSuERW+2/YFglLDWThuw
 ==
X-Google-Smtp-Source: AGHT+IG/cwRp+gj+FqK7hJBUYU/RING2vYRLnVzHqn+4AvBykZYQxtEvpHMgKVPSKuhbRdbHwwOwIg==
X-Received: by 2002:a17:903:2f8c:b0:249:37b2:8630 with SMTP id
 d9443c01a7336-2493ee070bcmr9887275ad.5.1756506582435; 
 Fri, 29 Aug 2025 15:29:42 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 53/91] linux-user/ppc: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:49 +1000
Message-ID: <20250829222427.289668-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Move the target_pt_regs structure from target_syscall.h.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_ptrace.h  | 26 ++++++++++++++++++++++++++
 linux-user/ppc/target_syscall.h | 28 ----------------------------
 2 files changed, 26 insertions(+), 28 deletions(-)
 create mode 100644 linux-user/ppc/target_ptrace.h

diff --git a/linux-user/ppc/target_ptrace.h b/linux-user/ppc/target_ptrace.h
new file mode 100644
index 0000000000..df77bfde73
--- /dev/null
+++ b/linux-user/ppc/target_ptrace.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef PPC_TARGET_PTRACE_H
+#define PPC_TARGET_PTRACE_H
+
+struct target_pt_regs {
+    abi_ulong gpr[32];
+    abi_ulong nip;
+    abi_ulong msr;
+    abi_ulong orig_gpr3;        /* Used for restarting system calls */
+    abi_ulong ctr;
+    abi_ulong link;
+    abi_ulong xer;
+    abi_ulong ccr;
+#if defined(TARGET_PPC64)
+    abi_ulong softe;
+#else
+    abi_ulong mq;               /* 601 only (not used at present) */
+#endif
+    abi_ulong trap;             /* Reason for being here */
+    abi_ulong dar;              /* Fault registers */
+    abi_ulong dsisr;
+    abi_ulong result;           /* Result of a system call */
+};
+
+#endif /* PPC_TARGET_PTRACE_H */
diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
index 77b36d0b46..976b4bb7e9 100644
--- a/linux-user/ppc/target_syscall.h
+++ b/linux-user/ppc/target_syscall.h
@@ -20,34 +20,6 @@
 #ifndef PPC_TARGET_SYSCALL_H
 #define PPC_TARGET_SYSCALL_H
 
-/* XXX: ABSOLUTELY BUGGY:
- * for now, this is quite just a cut-and-paste from i386 target...
- */
-
-/* default linux values for the selectors */
-#define __USER_DS	(1)
-
-struct target_pt_regs {
-	abi_ulong gpr[32];
-	abi_ulong nip;
-	abi_ulong msr;
-	abi_ulong orig_gpr3;	/* Used for restarting system calls */
-	abi_ulong ctr;
-	abi_ulong link;
-	abi_ulong xer;
-	abi_ulong ccr;
-#if defined(TARGET_PPC64)
-        abi_ulong softe;
-#else
-	abi_ulong mq;		/* 601 only (not used at present) */
-#endif
-					/* Used on APUS to hold IPL value. */
-	abi_ulong trap;		/* Reason for being here */
-	abi_ulong dar;		/* Fault registers */
-	abi_ulong dsisr;
-	abi_ulong result; 		/* Result of a system call */
-};
-
 /* ioctls */
 struct target_revectored_struct {
 	abi_ulong __map[8];			/* 256 bits */
-- 
2.43.0



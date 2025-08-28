Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2D1CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHX-0005IP-Jg; Thu, 28 Aug 2025 13:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS0-0003B1-KD
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRy-0007LE-Ty
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso827066b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382993; x=1756987793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsmCHZq5u+318yXuBEGjsf/i7Y2i6qx/41qn9Y53C1k=;
 b=ADTq4oNdk0yOYdRdOJ6EjuZd8H9rXPO+be1NthxBEPU6SMBY1iqqEZabhFxQLh4SO+
 6QSBUCOOpUy/8AMNYLDmo8gXcOfi23DsVptZ30bVLZuwPVWx2Q1L0BtGHdrMf0LiwOKk
 U7SfucZNSeqDfSHl9DWC52VNv07kDgn2vbMQYoukBG+TNVj3OZfpY7TlnbuPPEJWPvK5
 pi8i8SWMrajPalUPOqE8vbjVMumOdSvJIpWH7KL0Ya7i5SyvI5VJkTWdE6l47vtLsLqP
 uLGZCzrQThgp715BWGVT+/VuzCAZQMohncLDmra3t211r09xo65qDf4MwhpWTLUEN6gt
 YhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382993; x=1756987793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsmCHZq5u+318yXuBEGjsf/i7Y2i6qx/41qn9Y53C1k=;
 b=IPer6XB9pGmAaU5MZ5dwdVT2+9gx59iO/d6mDHPlyOZM5X+ov8w/q1djAqiPHIPfjF
 NIpvnVb+1qp3ANJD3w0WlxqqlEnS6PJEDfWMFiYWcHvtXufktMM8A8/71tldKo6NtXOU
 GP99bctPm4DJ5FwCEXhvde+y5jJqecf5zsMpQgphQYn/9qpm/LZ8Jm3tZMti/DnJHCTI
 0h3/RUaQJaieFzGd0TQ7il3ANtGqUXI1YgndUXg3qX0nwEuJHA/FvC+kb3WEjMVMwujC
 5bRC8SE0KIk6KmWHx908rFlz/dSFJJXwAiOw313UldXzV+L9gQ98LuobvnXaB82kRsUn
 Lvtw==
X-Gm-Message-State: AOJu0YxwkSZaAGSDGLiXg1AGsdkNOdous2R1snYHUtci0F1ALywawnIZ
 bFr722+AXzhikFwaq65BB+efKrMKFGta5B5eqUOiAOLcvTu4k28CdcV7BwhSYT9g3Kqd+sd4MV+
 SSz631Gc=
X-Gm-Gg: ASbGncu4kSSQeYPAyykKlFqsUqJwxoqXVBBKQdzPNcrMeQr+w7BfPqDV9jp4S0IHBCV
 wckaVXoimYgjJyKb3P+tYh9pnOUBKxHOgLO9lQsGsbVGrBe/Vr11+Z8ZKqU2yqlwJDMua8zcnlj
 vUThIlllBxS89SW4mJgBGR2WFH/Bl+r5AgGZ0+EXJ89pqRPpFS35TzaJ1/mFbzqejxDvwJ3q1Qg
 OIoyuYws+HLGIDkjVP079YiyyZNbbgtOH1BCui7tDy02sncsjCMHXjGJnHKO2vKBay8WJsUShxS
 rfAXu5fom+Wun00pn5NWOWBxaGNGlCI1mEDzLiQ0+VAmKEvAC903eih7c3IoBHb/RJXzbZ1/6CP
 30v4Co1LAR5oYrjEdoFcMjhALNMScbGHRw51N
X-Google-Smtp-Source: AGHT+IFdZBbOTBHvs2y9OTxq9EqdwAuR2YU3Ho65IrQthWz7M1uP0SruIGyYk/FwNZGe8znZPtm0bQ==
X-Received: by 2002:a05:6a21:7e87:b0:243:4eb0:5835 with SMTP id
 adf61e73a8af0-2434eb05a09mr24801410637.57.1756382993042; 
 Thu, 28 Aug 2025 05:09:53 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 30/87] linux-user/i386: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:39 +1000
Message-ID: <20250828120836.195358-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Rename the bits according to user_regs_struct, which is
what is actually used by ELF_CORE_COPY_REGS; the layout
of the two structure definitions is identical.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/target_ptrace.h  | 31 +++++++++++++++++++++++++++++++
 linux-user/i386/target_syscall.h | 18 ------------------
 2 files changed, 31 insertions(+), 18 deletions(-)
 create mode 100644 linux-user/i386/target_ptrace.h

diff --git a/linux-user/i386/target_ptrace.h b/linux-user/i386/target_ptrace.h
new file mode 100644
index 0000000000..51edb637af
--- /dev/null
+++ b/linux-user/i386/target_ptrace.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef I386_TARGET_PTRACE_H
+#define I386_TARGET_PTRACE_H
+
+/*
+ * Compare linux arch/x86/include/uapi/asm/ptrace.h (struct pt_regs) and
+ * arch/x86/include/asm/user_32.h (struct user_regs_struct).
+ * The structure layouts are identical; the user_regs_struct names are better.
+ */
+struct target_pt_regs {
+    abi_ulong bx;
+    abi_ulong cx;
+    abi_ulong dx;
+    abi_ulong si;
+    abi_ulong di;
+    abi_ulong bp;
+    abi_ulong ax;
+    abi_ulong ds;
+    abi_ulong es;
+    abi_ulong fs;
+    abi_ulong gs;
+    abi_ulong orig_ax;
+    abi_ulong ip;
+    abi_ulong cs;
+    abi_ulong flags;
+    abi_ulong sp;
+    abi_ulong ss;
+};
+
+#endif /* I386_TARGET_PTRACE_H */
diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
index aaade06b13..c214a909a6 100644
--- a/linux-user/i386/target_syscall.h
+++ b/linux-user/i386/target_syscall.h
@@ -5,24 +5,6 @@
 #define __USER_CS	(0x23)
 #define __USER_DS	(0x2B)
 
-struct target_pt_regs {
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	int  xds;
-	int  xes;
-	long orig_eax;
-	long eip;
-	int  xcs;
-	long eflags;
-	long esp;
-	int  xss;
-};
-
 /* ioctls */
 
 #define TARGET_LDT_ENTRIES      8192
-- 
2.43.0



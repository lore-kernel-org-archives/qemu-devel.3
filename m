Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93658C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgC3-0002fS-67; Thu, 28 Aug 2025 13:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW1-0007sO-8f
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVy-0008Fa-3e
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-24646202152so10794075ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383233; x=1756988033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcaQmcH6qQTY26hZlof1qrwXGZHKHcgEYf1b3d2ymX0=;
 b=FiEdIBqD4LtBT8Gp0rO/ejw10yCMgEMVzhNkTfbgd3Ep+BOwDk6Zvz/WRDmlJdli9j
 XQXAI8Y2RLiUmSuMdBPxruL7aNkoTaq8v2Gwv+//bgiQmJJ87cokeJ39aUE75sUNJN1Q
 ltr+dlsCkVrRKSfGRh/Y0bAhxRR0FJ3HWq/D0OsAu3F/0VpV+IkRW521VETLvkCNJ59f
 4OcgaAUDsAz3Twh7FwEvY1j3GPeTYdFE6T2hoCXp9MUnVudpGTx/I/eTxLyOSkpgx3fK
 HYx345wZHYMA+Y4xL5GyrhPx+D7oaRuU983w10M+rTw3OZB1VJ3g+dPPvrXdCka9ttJQ
 WY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383233; x=1756988033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcaQmcH6qQTY26hZlof1qrwXGZHKHcgEYf1b3d2ymX0=;
 b=P2hkrUacOeqGmozzI8Qp/vSWtukfxQIzIQW4e7NYX7mqXPMVbDzDT7W/xl/B2ljU2D
 7ba2UzM/bZo2QRYPZ7Qao+gemB9E6j7UfUqjIJje4aedwnqP3hKMwPOUJmrl7ZtaLLSo
 GSm1PwfpZxO5SRvXGbzNvIo5voFMSxaOydmosBzqF3dWoi/ahrgb1T6wHeyZPejbuQBU
 ucngqcsOJBV7KC34Krmza0hp9yyzLnbegYI6bsrM1cxVpv6xP2szesxsv3k4xBVQTab1
 xDrZLCIAY4kX5iQmnO0T2QUoQhzhxPeKDH36bGnot1twtg11U+B5XxHHP3SS3OZ3miXC
 8oGA==
X-Gm-Message-State: AOJu0YwypF88CAqu5wtrqDBlk+6evk8+Vbn49jYaPHhhalpGohMRfhkA
 P02xE9XRRWpXO3ssdNAkU00aE2h+wspsGoKl20L50s8NdL0PbfjXtuXsfVmFfixxv55HQMHLbNn
 0+5AkvE8=
X-Gm-Gg: ASbGnct75CoaNeN/7U7jcISPT523BTF4N+FsryAcXc02L12Vtmx4JvKRing5LflnYgC
 qKQrcLD6kBR97W3m7FVxD76cOCg3/LvGneK/nxUCklb7fgOKQNudVlQ12pUNBu0Qm+peQiA/Gqv
 5K8yonNn9LlmTBJYUyS2DvlxGVL61otJcj3JJZo7100Ikq1YcDNsoQP6s+z8FV2l/sfLtaPII26
 HdnA8r/4+Q6b1jvMagCscXRWx6H5bEKeWz1FXfUqdX+5ry89WzU9t5f/I8UJLoUWeJ7w+RdDutV
 EzIFW/28FUJaQyr7zCJ/H/p+18q2LrT7hTgWH4s7NK+NtRMxJWe5/jmFSosVJMyxOp4I5nmtKNt
 jJ0/vF2Js+iLqw5RzzCpeDGi1Er3iuQCJvSe6MfasmLCGSiA=
X-Google-Smtp-Source: AGHT+IEYeAbcGO7L2IfV2Xq7zIdHjbbqpPv20ZeQy3+jO2QPPh0f/lrlsewVbYNYwhp/TF76hNFYPA==
X-Received: by 2002:a17:903:1246:b0:224:910:23f0 with SMTP id
 d9443c01a7336-2462ef9332emr331289925ad.49.1756383233293; 
 Thu, 28 Aug 2025 05:13:53 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 49/87] linux-user/ppc: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:58 +1000
Message-ID: <20250828120836.195358-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCCDC87FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugupc-0004dA-DM; Tue, 29 Jul 2025 20:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMc-0006sF-Fi
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:13 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMa-000598-Lz
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:10 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-31329098ae8so384068a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834087; x=1754438887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lSxLBrV8mXcKHHkWNXdf48xKgnlnxkiZZ+U8+XaPSEc=;
 b=DBCkMm1pwv4TIIWU+b939rZz43Z89LklmCE8rIiFBImuAecan39kjtEEcIqWoHmHZz
 yKS5gdGpj8GwejHj2DzRp/zQUhSKe37j8Bp3JkXsIFjL0BbqVEUArLqV29cvGAHsAGno
 X27vxI1hxdyiAmb2Gj3LoDNHNmvZdmagDsQV3lc+iLtXzL82CmnJX7wnib23K1iHMbHe
 fkML67E4WMqeM3LvbGXlFlMhx2tgifxlLK1DWA2IKiKEAFEghRzJ9L7OI1OdUDLhvgvM
 d9HLbqkFg9POmEcN8oyl3WsEFyAIzKf5W0yzeOEyU9mW2i/cuqYN/eWOoUfTe2rDX/SA
 Tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834087; x=1754438887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSxLBrV8mXcKHHkWNXdf48xKgnlnxkiZZ+U8+XaPSEc=;
 b=Coc/KEpDnzx3cFwTlMx43JgucKdEn6UZo9sszD7CTNKvHU854QBeVlnIRlIUAaotCN
 cWKEvGzq2hp4Oe+6EfHJL01ClOdglhDfDdVsAkj8vQL1HfyZwdjrP2LvJXJwEnpdp5S3
 BWKEk30ZR0h3fLaUjQXCZxB5vm0A4k+QnbYQQ8yFiCNLTvr7rD3ZhEDsGZskWm4Y4b2b
 cFfltTvtwfoYTUC3C4WJ7zMQbh86wDEExHGa2Lm6qJEMBaz0FhHs4Du4OU2IPR2MdgsF
 C8IenwBGkOEPO73h3fyYdBlUNO5+g2J0hNnJAUlxeGFDNJtvUKmKjNHduWcF3dQek1D+
 F+bg==
X-Gm-Message-State: AOJu0YyfVbw37mXNxoWZkDCAlDQ3NH2p1kHIkJmAyzJ0swY6ujYR9Bfc
 xjIwO87gT8nw14mNwvoDiKo8fI8oLOxEPkAIHB79V+wJEfVcsZfEteFhSl6ZXQ2zQqev+YlPwAL
 vKKa6
X-Gm-Gg: ASbGncvBR0Eva6U4QcqvrH6fH03N4o08UdSdtuvIcfDhYlSp6xgFPDww0fop6hVCDnb
 MnQEHMfV+heGTY0SBM/fuRMwmAAUaHDV1cjNJi1CNOWzRvjCHoFt3v4F8GYs2IfTVkU5GLe9lMX
 Q4S+/CXrTQb/tmKdGUzMIZYTHFBSgGlZfZvaH10hhE2jru/X62CejIb9W0YdBMyD+RgMB9mEzOt
 PdD6lD0zDqrQ4/KUMZk2cKshnwQzIT2OpksaUNoCrHaFWOQiEAxGGhUQdp5OlffkETQeyIFLEBA
 4q+xrnB5cFg4qywSGxlNZXpL1+vDfFRhmS2tDkn/Q+gPdKJCEK7G8pVEo2AuhDRLQbFl3S0RO5/
 fDPa/4QnKn7lziuMpLd+SPHoWQXYMHMcmxmVsWkzif5GfLVxtLjWF/6be5GALbwmwSffCZSTfwo
 kNUPAkcDRXDw==
X-Google-Smtp-Source: AGHT+IEXxbj5hKqs4UlZw4M3xqHNuCVHV009jB3rux0ARzv8ajdCRwzFW0UkkCIwvlH++zXWNt5FOg==
X-Received: by 2002:a17:90a:77c6:b0:31f:2bbb:e6a8 with SMTP id
 98e67ed59e1d1-31f2bbbe819mr5117555a91.12.1753834086838; 
 Tue, 29 Jul 2025 17:08:06 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 87/89] linux-user/openrisc: Move target_pt_regs to signal.c
Date: Tue, 29 Jul 2025 14:00:00 -1000
Message-ID: <20250730000003.599084-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_syscall.h | 11 -----------
 linux-user/openrisc/signal.c         | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

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
index cb74a9fe5e..9242d06002 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -22,6 +22,18 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
+/*
+ * Note that in linux/arch/openrisc/include/uapi/asm/ptrace.h,
+ * this is called user_regs_struct.  Given that this is what
+ * is used within struct sigcontext we need this definition.
+ * However, elfload.c wants this name.
+ */
+struct target_pt_regs {
+    abi_ulong gpr[32];
+    abi_ulong pc;
+    abi_ulong sr;
+};
+
 typedef struct target_sigcontext {
     struct target_pt_regs regs;
     abi_ulong oldmask;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375EDC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugupK-0003Kz-I2; Tue, 29 Jul 2025 20:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMa-0006rU-EU
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguMY-00058m-GH
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:08:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2403df11a2aso20536505ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753834085; x=1754438885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vKU7aau6wblJ2iE6GxOueIIcL13PuWGFXXZqmIS92ng=;
 b=hVgdObqO5vUNEjJKuSH84D2XP6tWgaYMC5T4eJH9eZTrV524rw9frB6DwPJDzkUiGe
 7Pz50qHreY7kArL1kPA7o1Ui0XPIJqrH51vBBjhu3/6scLVk5QVDHFON44VtKAC+/UjC
 /dwCcir9LJiLjZOjkhIu+dUwvCJL8xsNs5BWC5yQ0ng5A8qOqERIq0hf7Pt0LaR0L1B0
 ztsfJIkh3Db3HmABpuLWMGCMS/lsl1idiOjcY/9EkYrdMNnvRrYzlIP8wDR02MiUoN0Y
 X6aFYmkmvURHIv4gXZWKUupu6h6p3ARXjurlSjovqOF3fqXU/AtxRrCXIeCJ04E8XkOG
 Mxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753834085; x=1754438885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKU7aau6wblJ2iE6GxOueIIcL13PuWGFXXZqmIS92ng=;
 b=CZOt/g//ASC+N7AHBiWVsMX5yoBICJRZUL6lnUsBQt0r5TswPkp2M1Gvv1zF2l8EBE
 qmqSdmxmilccuAz4QJPPFE5WEMpAAD/P8LCb1LIQ7UiKE7+NO6X3+TPotl/0PzeXH4xi
 pWg07ZCUB4C/lSIon5TBRFV/6RV0ZDsaFvjg/A5M7nvAmfULKqIZD60U3Nawqg253N4v
 0YrPTYM2FEojSz1Rye93Qf/ZNlDDIAw1W4ptMtCniWjBhYHMzYjvLwai/i2qOwCzRIP0
 E4n7Gr8rrCoQIY5ZtI9l0g1PVhQ1CpR3h2F77eZoZh4PQiuTSc2GKFoixA9H4TyrRD8t
 6Pvw==
X-Gm-Message-State: AOJu0YwD5MiF+HdkiHqO0CfgSwUbEWGaeVudnafvUI4mpji91bxemaB1
 gewcbPuhFWdpdt3P4woCzw7PRUI3EPGUmAZCTjX5JU2IwjpEm2cWyJFwvVk9DmyREkfXlBao2ri
 XhB6N
X-Gm-Gg: ASbGncteYTbmkPtdbb3r4S7fyfQCogYWSkAamSq6RFuSdB5ulxqIzxvX+tEUPbSPd+/
 GS2s44WxFyNFgE+2d1K78Ab4odcw3xoJObt8HJ1PxR0BCXEVt1VEYKSW4iTeYP4k8B+MANYPvLY
 skTAVgJ+NY7qqC8Vf20E7NjnvC4PQzXt+npaN/1tp6r4cSFgrJiyol17cVy8zWdaXiNb90ZzXYE
 86NikDetW3OsueRdVtW5nBfYqimq+qfPznlUWk4ctLd3/zM5u31RWftfyoIoMdAzoPDB3gTL1c5
 gwjZepj2rxK5QWatqXKw+mSmnuh5SB0XJM+uN78NJq+SlLanYyWmESWyzKalU0EJKH1qPLQRpBf
 iJsof8Lj0gg9LIwW0/LIhZ1omPGftqpemzQCTJ7lIEeKKPd891V8Et6NuNhDROjQNtEhWEkOi37
 0eZjMj4tFNgg==
X-Google-Smtp-Source: AGHT+IG9Yj3xADeedzWGWjMIL8LGuiAWbcKLusqtdvJlrWktvj3i2NcsOQd0irz+yh10C8xswMphyg==
X-Received: by 2002:a17:903:291:b0:240:14c:c648 with SMTP id
 d9443c01a7336-24096b1c548mr17695875ad.25.1753834084816; 
 Tue, 29 Jul 2025 17:08:04 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ddfb2asm281868a91.22.2025.07.29.17.08.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:08:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 85/89] linux-user/sparc: Move target_pt_regs to signal.c
Date: Tue, 29 Jul 2025 13:59:58 -1000
Message-ID: <20250730000003.599084-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

This structure is part of the sparc signal frame.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_syscall.h | 19 -------------------
 linux-user/sparc/signal.c         | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index e421165357..a90ed2983a 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -1,25 +1,6 @@
 #ifndef SPARC_TARGET_SYSCALL_H
 #define SPARC_TARGET_SYSCALL_H
 
-#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-struct target_pt_regs {
-    abi_ulong u_regs[16];
-    abi_ulong tstate;
-    abi_ulong pc;
-    abi_ulong npc;
-    uint32_t y;
-    uint32_t magic;
-};
-#else
-struct target_pt_regs {
-    abi_ulong psr;
-    abi_ulong pc;
-    abi_ulong npc;
-    abi_ulong y;
-    abi_ulong u_regs[16];
-};
-#endif
-
 #ifdef TARGET_SPARC64
 # define UNAME_MACHINE "sparc64"
 #else
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 8181b8b92c..944769a8de 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -22,6 +22,26 @@
 #include "signal-common.h"
 #include "linux-user/trace.h"
 
+
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+struct target_pt_regs {
+    abi_ulong u_regs[16];
+    abi_ulong tstate;
+    abi_ulong pc;
+    abi_ulong npc;
+    uint32_t y;
+    uint32_t magic;
+};
+#else
+struct target_pt_regs {
+    abi_ulong psr;
+    abi_ulong pc;
+    abi_ulong npc;
+    abi_ulong y;
+    abi_ulong u_regs[16];
+};
+#endif
+
 /* A Sparc register window */
 struct target_reg_window {
     abi_ulong locals[8];
-- 
2.43.0



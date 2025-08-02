Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E868C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLU2-0006Cd-Qo; Sat, 02 Aug 2025 19:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLT6-0004Cp-6E
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:51 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLT4-0002fl-HI
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:47 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-741a59f64c8so415598a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176605; x=1754781405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QdfB+NytoX9k9jsv7VVcmrRDVzL0Ovmr6JLafNnASA=;
 b=w+8rwuRVD4x8MxWXP8sh+pJljMqDi13AJEwumCpi0w3xOzd2b9FVNZkdoitCuQolRX
 L7HAaUFdGcZid0HO8u9LC6Qnmryb6tetO81QK6u6ApV/IRBytdcnJg4rtIHIv+A3+dLZ
 MoWwfVY08MrKZ/43iIRaHxFFINqUc191pPz8H+arXqOHbdhYLa0AGW85CIVH0ZjDJzc5
 +aPrUDF8LFWKcBchswbngjGIzTCqqxgDn5t2KL7MbAN7OpFaa8MGHoUWeJN8axqYGbB+
 amnkRCVsMA7ljIXaou9/2SkIWJxiVEJYI0WkCp4fe48qcto/Y+Tne/RTMVjSkWiS/Dpy
 LwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176605; x=1754781405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QdfB+NytoX9k9jsv7VVcmrRDVzL0Ovmr6JLafNnASA=;
 b=oIiZtu6cquXq1KMpozSgUxBkVGLQ7BerhUQLHjN6iMnPd5b0GPNcDvwcInH8vgpFjN
 ZgrQi8LCAKVU6ByzDH8iagKZ25GYomvLzA9GW3KkXTtgAc9dskur74pgXbdQJex1DO1a
 eoia9gvQVIqGfzMHSx4kfskCrClQU684y+YXoLWf6LxPwr2++35aJruhqhil0GR8A+2H
 JvFZz1j5XMHJ3kE3AWPOXgsNHGwvQbqnF1y1LILC0pSnJsCesVwvyQV+aCfByQ8TFg8B
 DSgOFJWZIyidNUmG7ZTGozu33S/ZdlJ8Z5u76L5ACtvRopP1Q2ZsDyoggwUTSsZrvQhS
 XeJw==
X-Gm-Message-State: AOJu0YyWYHbCfq0iMw+Xi1PbOgzcbq16VRS6yjoJJiIIotRa+MGlW9hy
 6Cz1DJ5OyIW7PmUmEPjQJHrFpFtvsjsXYrgfAdmGgYnsvVR4Hmwi10JeuN9PTt/644m4NCMcZ0l
 VmG8nTkI=
X-Gm-Gg: ASbGncvddRW4/ciTW/4UbLUckhn4g83lDmu2Cy0FD7hyNWX5bAD8w+KONlX8IawPc/t
 uCia5qTmb4Onzu18IqifG2JN0EoypLiKqKjtdiZ/5kZftx39eIezKEwlIJbvzJHbuJs1WHECJX9
 D9aZH2qogJDUl4FbHlKvDkdUJUGC1qC4xczePoSQ43TnriSgRIcVQLZUnZHkl30jRqU67G/Haho
 yuA+Md47zYrupEP6ZVusUMPQJ/HZOETy7kK3ugH1rOiPKNhLvE5jSr7D8OSB6wHulIMkniabilO
 DpBeQz4I93mdGWAmghDDbB9wDQoKOy4N3Nr1/bdssWbitB/efo+PbQt2rfyoeIM0amf5iuUaJ7T
 WUBI8wxf6B5XaXyxkdm287P/WFlXnxqTUvXryvtSCszXc6IPVUy/H
X-Google-Smtp-Source: AGHT+IG5s5giM5kUEGN3uI8nGsmDXnWYxjkGMlPoXr9P+j0bQHNVJNoTUFyNFeqkBvyBxG9Ct/fJKA==
X-Received: by 2002:a05:6830:92a:b0:741:adad:2331 with SMTP id
 46e09a7af769-741adad2557mr693061a34.11.1754176605366; 
 Sat, 02 Aug 2025 16:16:45 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 91/95] linux-user/sparc: Move target_pt_regs to signal.c
Date: Sun,  3 Aug 2025 09:04:55 +1000
Message-ID: <20250802230459.412251-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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



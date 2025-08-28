Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47506CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbUJ-0006iS-9P; Thu, 28 Aug 2025 08:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSN-0003ur-ST
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:25 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSK-0007da-Be
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:19 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-32326e5f0bfso727060a91.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383014; x=1756987814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uu0QoHntGkRrCcKzbvBagJt2LOtYz9fdewhkpWEHEY=;
 b=Ecq0Snavqaf7O9Qcot08A53v6nNSKmEDiq8IEQbBYUhVAxvLo+C5daxFktDQimx13P
 pvy7NcV21jqlxYN91ocdALU1ImzvmvdVY8+6rcdvXXJz68405MqEoovJXaA886AQ9ATO
 faMFgss2LE++ELS9xsH10GY4+4mwaXa7tSFqEoOP54PPrL4lYDoAQFiJR7ZXBCNSbmnr
 KPwS79bXPgiZW/onl5Ir8uELEMS6ZAMJ8uWc10V5C2BdOOknEBWKzGCM8YIhMDmJVBE4
 LcANl6eDMqfViJqqEmp4Oraf439i21tWqyN2Pm2oqTMbSb5n+HyOf3TF9kF2rNdoRjTf
 E9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383014; x=1756987814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2uu0QoHntGkRrCcKzbvBagJt2LOtYz9fdewhkpWEHEY=;
 b=mzCeNN8hMJYgAZQZV9hiXPPrwk+0YmhrvyKb20Zi/hHqjHYNWulkcy4fdT7YzQxUx+
 h6pZg8LIwNgFCj95KG/NuP1mQCBaVSmSG1RxY4iXv3H/DNeJsZbcMzUE9mZFvre+SCZR
 Poy1RQ8pOJLyyzeSBdHq1713Rjx5Xq077kCqmotPePxJgSf0qnpFx2JX53lzIYyww4XN
 hsGnKoRykJAeY+XoXqGkWLxrjZB1vpnFfCH5d5POi64lL5+t2h2pG/Y13ldG37c4hFRZ
 qmL58MI4mmgubVZyeHpPuakhDsCQ3v4UkKciN+cYjZghY8HSicUw3EYYN9qCykO3pXDo
 atsg==
X-Gm-Message-State: AOJu0Yza6ow/VWNxUGFGcsamZax64vSRvSj9drRDeVhEdDNeBLvOP9Je
 E+UPDe7BpCowmjaXmK3avvfdhu28MQHhn+hf2Cwo985IWpQmupXQiRh3n7c1BFgFH+ZALfCKlbY
 tHNBYh0c=
X-Gm-Gg: ASbGncv1nMHt+iGnhbi93EXsYE0FsLSWR8S6AGM1vdXqGEy3TTqF5IuOIrdKzEk1OE0
 huyDBkJ01ZvdYWiZqw22Xpo5H8Cf2d/yk1KVZVTcLIWjMgb+77PVEvInKBzyX4sHC1zDKF4mYZI
 L9/LJsJgBHS/Mf18xK7dhtaOsalewnQMOxVQq6NFsp4iGL7z+vPbw5zq5Wt3p3SCEWvWaV+sjpl
 niOMa9fuNTZ4AsubpUbRqQB54VkPxIeJYikPV7Z36htsb5y4JdVpbmyR+sOxPnvPhI0gbtSMhxu
 NNjLgWC8G/dTBFHgR5ZDoVHCccNUGd6VN+ssU/m4oi4xDR6YqRpkhLkvtugQvv1SHmAMpWYjjJB
 l57/vi/aBq4uJP+tIdjXjlULnjVmXS64h6Lf0KiyFzG1CRKg=
X-Google-Smtp-Source: AGHT+IFkDiWQfyXZgR5bdRYmsVGOzy8Gqovr46MtRtP+qCJmpkHBsiK53mUFgjnmqu9VbArzCVN3oQ==
X-Received: by 2002:a17:90b:3c87:b0:327:7784:5390 with SMTP id
 98e67ed59e1d1-32777939af9mr7222842a91.16.1756383014297; 
 Thu, 28 Aug 2025 05:10:14 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:10:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 39/87] linux-user/loongarch64: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:48 +1000
Message-ID: <20250828120836.195358-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Remove the target_pt_regs structure from target_syscall.h.
Add target_user_pt_regs to target_ptrace.h, which matches
what is actually used on loongarch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_ptrace.h  | 15 +++++++++++++++
 linux-user/loongarch64/target_syscall.h | 23 -----------------------
 2 files changed, 15 insertions(+), 23 deletions(-)
 create mode 100644 linux-user/loongarch64/target_ptrace.h

diff --git a/linux-user/loongarch64/target_ptrace.h b/linux-user/loongarch64/target_ptrace.h
new file mode 100644
index 0000000000..2578e09207
--- /dev/null
+++ b/linux-user/loongarch64/target_ptrace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef LOONGARCH64_TARGET_PTRACE_H
+#define LOONGARCH64_TARGET_PTRACE_H
+
+/* See arch/loongarch/include/uapi/asm/ptrace.h. */
+struct target_user_pt_regs {
+    abi_ulong regs[32];
+    abi_ulong orig_a0;
+    abi_ulong csr_era;
+    abi_ulong csr_badv;
+    abi_ulong reserved[10];
+};
+
+#endif /* LOONGARCH64_TARGET_PTRACE_H */
diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
index 39f229bb9c..f7ced7b2be 100644
--- a/linux-user/loongarch64/target_syscall.h
+++ b/linux-user/loongarch64/target_syscall.h
@@ -8,29 +8,6 @@
 
 #include "qemu/units.h"
 
-/*
- * this struct defines the way the registers are stored on the
- * stack during a system call.
- */
-
-struct target_pt_regs {
-    /* Saved main processor registers. */
-    target_ulong regs[32];
-
-    /* Saved special registers. */
-    struct {
-        target_ulong era;
-        target_ulong badv;
-        target_ulong crmd;
-        target_ulong prmd;
-        target_ulong euen;
-        target_ulong ecfg;
-        target_ulong estat;
-    } csr;
-    target_ulong orig_a0;
-    target_ulong __last[0];
-};
-
 #define UNAME_MACHINE "loongarch64"
 #define UNAME_MINIMUM_RELEASE "5.19.0"
 
-- 
2.43.0



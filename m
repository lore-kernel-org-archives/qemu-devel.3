Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F5CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBp-0002aL-Bl; Thu, 28 Aug 2025 13:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWN-00086r-Dt
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW9-0008Ix-Bz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:18 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2489c65330aso8539725ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383250; x=1756988050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTwliHBkLVkAYi85E5x/rvz1P3OFlfKbMmUTuWWe28I=;
 b=Xr2kJxPvF86M78uYYVRiAL/lavDNp1I6b0/APa3A1L4mSG0+B0YHNHKyuIKT6Qld5M
 Er1jVIWTWS7TBdhfVDmVztEG/tMepPmy7DG5FdR5QwFR3o3a/btVbCbCdxVTiR7dCBBv
 VWGtJMgi0oL8AssuviisgFj00u6xgCELV+PcgBQo9pKKXiXODIR7E/3VXKcf+rgWdbul
 HolFL9oCRmdupFG3QlTc5fN+/MgHmwn4v5imMe39Fz1lG9MZC2A2QqPVzcTG3Wtfp0z5
 SFC4QEc4s1EkTn8JFRaiwRWoaYRFHie5IZ94s23MB1cTOhbYyiLMkUJhoKUVkhDitkis
 q9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383250; x=1756988050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTwliHBkLVkAYi85E5x/rvz1P3OFlfKbMmUTuWWe28I=;
 b=OXcdNqSS/kpNB6ejSv157eR9Z7eG8aeG8PtY/DqhHiANeiWLFV8ozVk9kXYq9DRbcW
 5aj4Pldlot4ikuA0UQgbZPZSVMfoCUKp7HCaVC6LSbQlx7f157bOBmKcK0nBnAZ7doXO
 axpl9w+mN1IKv8f70W357CYeTa17o31XFpqoSY0FfXIYK3OBDFYCYYyhG1Jc3emSHF+T
 ixmlexc5sXRem4E6bIgTacJVSgm1Qp60U4uJb2ejaKZCq4hAaDdoOct3JUsPj80wWYPY
 9qAhNM/adCLYC+90BUu6zaFVhYe41z273/tUIOstXeoinDQmZ9Y6TcRJ9F/TxSdIBDeH
 GtBg==
X-Gm-Message-State: AOJu0YyS3wripAUHCd7pNegJWmt4kdiTvp+Y48iVaVh3RtTkWC6g6KeT
 O0jge7borB4A2IshgpvAdQK9VHQrlRtEHHGIG7xkpFv78So90OWuxcylunYUqjqmC4SJmr1yKv0
 OuGGaCCo=
X-Gm-Gg: ASbGnctkFlr3aCcxqQcINoCGuGGAkbnUugWiI5X19DEuLZotIps7366uwoeerGmB9E6
 9DQj4qZ0xJl438oqATzWXSZmv5y17MNgytTpEtG+RiD2Qq+njTMTMAIoYemfiLSUcD/EmqZWf13
 HFdpxlYi0ucF2DMdQvpVhjSuS36D+W/vQLkLICxf38sjrXc1nUWziz+M0vvS0IrRoqTujreIqVn
 YcGpFju3kHXHGCM9rHzDZkwqD8FUbvo9fRDHwqI9JQbctn514LGmbpD5QEgbUu0y8af5arm7eE9
 +CqdLeqNO3kAXxwXJDB8FW1mr+SFjyapdJyA7zaRcArnxhibrMt+M9RoTblVK3JR/GohgOWhHTX
 15Excs0WK5Lt6kn/83SnrwGtxsY95YfNqKQ/C
X-Google-Smtp-Source: AGHT+IHUSDElGbKZNX3LDi+azFnORcdO75Po2MOgpJyFvvfcY08w9GnY7dItdMgv35X4Nyih+kROoQ==
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id
 d9443c01a7336-2462ee54512mr311909125ad.25.1756383249880; 
 Thu, 28 Aug 2025 05:14:09 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 55/87] linux-user/xtensa: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:08:04 +1000
Message-ID: <20250828120836.195358-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Remove the target_pt_regs; add target_use_pt_regs to
target_ptrace.h, which matches what is actually used.
Remove xtensa_reg_t and xtregs_opt_t.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/xtensa/target_ptrace.h  | 22 +++++++++++++++++++
 linux-user/xtensa/target_syscall.h | 35 ------------------------------
 2 files changed, 22 insertions(+), 35 deletions(-)
 create mode 100644 linux-user/xtensa/target_ptrace.h

diff --git a/linux-user/xtensa/target_ptrace.h b/linux-user/xtensa/target_ptrace.h
new file mode 100644
index 0000000000..32443d0dee
--- /dev/null
+++ b/linux-user/xtensa/target_ptrace.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef XTENSA_TARGET_PTRACE_H
+#define XTENSA_TARGET_PTRACE_H
+
+/* See arch/xtensa/include/uapi/asm/ptrace.h. */
+struct target_user_pt_regs {
+    uint32_t pc;
+    uint32_t ps;
+    uint32_t lbeg;
+    uint32_t lend;
+    uint32_t lcount;
+    uint32_t sar;
+    uint32_t windowstart;
+    uint32_t windowbase;
+    uint32_t threadptr;
+    uint32_t syscall;
+    uint32_t reserved[6 + 48];
+    uint32_t a[64];
+};
+
+#endif /* XTENSA_TARGET_PTRACE_H */
diff --git a/linux-user/xtensa/target_syscall.h b/linux-user/xtensa/target_syscall.h
index afc86a153f..5d4352a4d1 100644
--- a/linux-user/xtensa/target_syscall.h
+++ b/linux-user/xtensa/target_syscall.h
@@ -8,41 +8,6 @@
 
 #define MMAP_SHIFT TARGET_PAGE_BITS
 
-typedef uint32_t xtensa_reg_t;
-typedef struct {
-} xtregs_opt_t; /* TODO */
-
-struct target_pt_regs {
-    xtensa_reg_t pc;            /*   4 */
-    xtensa_reg_t ps;            /*   8 */
-    xtensa_reg_t depc;          /*  12 */
-    xtensa_reg_t exccause;      /*  16 */
-    xtensa_reg_t excvaddr;      /*  20 */
-    xtensa_reg_t debugcause;    /*  24 */
-    xtensa_reg_t wmask;         /*  28 */
-    xtensa_reg_t lbeg;          /*  32 */
-    xtensa_reg_t lend;          /*  36 */
-    xtensa_reg_t lcount;        /*  40 */
-    xtensa_reg_t sar;           /*  44 */
-    xtensa_reg_t windowbase;    /*  48 */
-    xtensa_reg_t windowstart;   /*  52 */
-    xtensa_reg_t syscall;       /*  56 */
-    xtensa_reg_t icountlevel;   /*  60 */
-    xtensa_reg_t scompare1;     /*  64 */
-    xtensa_reg_t threadptr;     /*  68 */
-
-    /* Additional configurable registers that are used by the compiler. */
-    xtregs_opt_t xtregs_opt;
-
-    /* Make sure the areg field is 16 bytes aligned. */
-    int align[0] __attribute__ ((aligned(16)));
-
-    /* current register frame.
-     * Note: The ESF for kernel exceptions ends after 16 registers!
-     */
-    xtensa_reg_t areg[16];
-};
-
 #define TARGET_MCL_CURRENT 1
 #define TARGET_MCL_FUTURE  2
 #define TARGET_MCL_ONFAULT 4
-- 
2.43.0



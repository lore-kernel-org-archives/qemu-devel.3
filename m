Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B46CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNlw-0005dy-Ax; Sat, 30 Aug 2025 11:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bc-0004XJ-Hz
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7ba-0003g0-N4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7722c88fc5fso1116445b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506597; x=1757111397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOwGWo4Z+bzLEdzdQNxxesTvr7Xf0qOSF3IPu5R89Jw=;
 b=uc7KlEm+FyfI5YsLZFw6kVESbbL+1B1N9oDSn6JSKidham52ngqhF9BIj4Tm56tbQn
 Ztj07omEFT6jnJ6fRwtX0YB4fAkpJLy+ob7jmgcfHOMnHzF4xLjRJsHkqLuWUBhJgPEu
 H0aqU/oQghQimWq6f303UvFF5IWs39mS+uY12q2QL58KMNBCY+ydi3Xdxc+Yed11jbE3
 YKRlT7WDcG8vZfsgFNjcpZcRXwdj1OzXjYWHUBB/oaHJqDXixzs2mP1414znU3D+Qo35
 gtDlrYO5BmU7yRs7cGX8ZTRDG9f+p687mvTryjhz+oXoQ9/WN++kUcXq6w2whhtQzk7A
 2rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506597; x=1757111397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOwGWo4Z+bzLEdzdQNxxesTvr7Xf0qOSF3IPu5R89Jw=;
 b=GUGXHQgVbehUOrU8YPKRd1oMKdO/+E4rPcy/axehgIvbCIEBt+RcCWjiJZGwPmGHIM
 HKpZ262+KT2qbT/qscv4dFTlvG8+RjQ5p8Zf2ybnY1nw8zScL7b0UA+m5KN89fVvpaWl
 W/QJ8IGVbIl+uTyhmwTvZps8HszZl4WNq9F0VJrW1o2xvhyOBST/fO0Ko2d5RirBQzju
 TkYOCr3hvJdexoWBHzaWQMViBUKk//2yL30sV5EWkHzW4m3oIVnvEP1I0dVUPAbgMgHE
 b53MvuM4gHZsT1a20a2xaeYnNaUJvF7FFaK5HQyxSkyCVrw5pOKNadHAbUQt0OucBpLo
 RNkQ==
X-Gm-Message-State: AOJu0YwoUCeephA004mTmrG5euAwOnOtmxH3Kl+745FiA9tBRpMioCQC
 ErWj+b2oalv2HDXXdk6KEMALiEsQvy61svRT5DZaHnRjElk9pVzLz90v+n8kR/hFtwgX4Ypa8t1
 /FkCdLaY=
X-Gm-Gg: ASbGnctgtxy9UwOsnTmZGtMI/ERbueg0tGX/G0TJak+3nif7QRJtljMNdjfo6nschzL
 uH9MOoJr7DshlxrA241Ps4SjkRocC9M37rcs+D4169VBp3Ni/Mo61+M676Kkz3LcriptGmfm7+3
 iDtGNrXwyHRBovI9ErJz5iJXsGEiHQGHabWdpiZ9y24+ktGtdeDMmWvyGd+eRSKcbGDdBXgewYH
 qcFrWmzp5h4GS0NUDF/eIfaq6QOk+J5Ap8Ebapz3z3+P2kZNCyEn2sY0YVZP1zGhsIWmV60EWLj
 oLIup2fyLyp4nZtLM60fueOpbRqiLCOx9Cc4p3LBvpQTwk1vdq/+EK7ofB0niOvDCRHl9VtF5z3
 8KPktmf8hSlCY3P05MkFiSKWwoFMbvGrLzluZ4pZuD90kVz1Zf/7UsYnzduM6LnE=
X-Google-Smtp-Source: AGHT+IGQAyBMmV+mwUsJntoN793RWJN52YEyZguk6+1CHLoom9A+Ke4UJdiNg2H5qGDunI6pk2J7LA==
X-Received: by 2002:a05:6a00:1a87:b0:772:114c:bcbb with SMTP id
 d2e1a72fcca58-7723e1f1804mr356575b3a.4.1756506596942; 
 Fri, 29 Aug 2025 15:29:56 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 59/91] linux-user/xtensa: Create target_ptrace.h
Date: Sat, 30 Aug 2025 08:23:55 +1000
Message-ID: <20250829222427.289668-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Remove the target_pt_regs; add target_user_pt_regs to
target_ptrace.h, which matches what is actually used.
Remove xtensa_reg_t and xtregs_opt_t.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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



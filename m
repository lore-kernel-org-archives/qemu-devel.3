Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48579C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadP-0005y4-VK; Mon, 29 Jan 2024 18:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadN-0005wV-18
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:45 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadL-0008OZ-2C
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:44 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3be44e0a7a5so779286b6e.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569301; x=1707174101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGwTnZnscqahFsCYdn6DyT5/GdGMGcaavMpKxhe75qA=;
 b=QZABSXPqjeBP0DhEvvMmD718jfKE1Vra1hpOD73C+aJW4jYg+9RpCwyhljWByvTi+k
 q0kwh/TWiYER+QKePMqu7wHzq1ZmzmX+Uyc3TlzUO7VLbYeiOcXtcF6x93//pDzRdwc0
 F9HHCGJJ4PfHNhx+5T4kTY0I2ndoc2rnLYMRV77D9uaVb3rr/g8PYzuMuKILRNNHP2Pe
 EvZySRYUiQoobalOMeKE03Rjr4TspZiOtfdtHdNCxc3TYP1XwOqdK7+oveB85rqje9i8
 JiJ7RfD7m2n/ufoooyX59eqgSmHhdw4NWWgsehcQZh8zLSQHK2La7RziQoywvYscr6FN
 lZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569301; x=1707174101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGwTnZnscqahFsCYdn6DyT5/GdGMGcaavMpKxhe75qA=;
 b=L14AodzEojSPtOIlFtN2jNiJL8Sb/AMtR7dzuZ5BLrSd8Q7T81UuJsp4ZSAV4quTk6
 iX4i+X0zwkDhWi3I6gP0c5a4m2ZC3XqdObU6G8LaJJt3onhtYpGnpm+gb8Nezi2bYWpi
 ycY8QrcHdHs3vWT0hIqZJGNQWHUwEC9n9WMvRTczsA8OSFIGWUr+cPVIlQ/Bi/4kwM3m
 /1NWBNCrtweYZxWw4oIplB9o/axtYPmyLlIv9909BC8GLbNIkYWFHMtkx5Sz27D3HXEF
 7Vq7P32xduy+McEmxPtLTRnmO/MgZkxE0h41UZ3zFQa8mPxy0Of064bmT5PtOB7VM/9Z
 T/Hw==
X-Gm-Message-State: AOJu0Yxo7e7wypgqIwry5ow1I7X8HaJtow/tPPMd/COSgy0cT8P/YWpU
 dE5fDsM2GcoX0cUxc2iLI1R1jlYc2Doe9bBFjK2Mj42M79QUh89LMDLoCgobwLUULhkRjo43m0x
 ND4Y=
X-Google-Smtp-Source: AGHT+IFpPy6dD6/hHj6+lY9rJOFOMfZHIGpdqBnBPdtEXUY9yU3Fn5Xgsq9FdwsNnC/Xzdcvrov4oQ==
X-Received: by 2002:a05:6358:725:b0:176:8a8e:213c with SMTP id
 e37-20020a056358072500b001768a8e213cmr4980535rwj.3.1706569301498; 
 Mon, 29 Jan 2024 15:01:41 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 07/31] include/exec: Move PAGE_* macros to common header
Date: Tue, 30 Jan 2024 09:00:57 +1000
Message-Id: <20240129230121.8091-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

These don't vary across targets and are used in soon-to-be common code
(cputlb.c).

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-15-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 24 ------------------------
 include/exec/cpu-common.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5340907cfd..edee87d3f4 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -171,34 +171,10 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
-/* same as PROT_xxx */
-#define PAGE_READ      0x0001
-#define PAGE_WRITE     0x0002
-#define PAGE_EXEC      0x0004
-#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
-#define PAGE_VALID     0x0008
-/*
- * Original state of the write flag (used when tracking self-modifying code)
- */
-#define PAGE_WRITE_ORG 0x0010
-/*
- * Invalidate the TLB entry immediately, helpful for s390x
- * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
- */
-#define PAGE_WRITE_INV 0x0020
-/* For use with page_set_flags: page is being replaced; target_data cleared. */
-#define PAGE_RESET     0x0040
-/* For linux-user, indicates that the page is MAP_ANON. */
-#define PAGE_ANON      0x0080
-
 #if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
 #define PAGE_RESERVED  0x0100
 #endif
-/* Target-specific bits that will be used via page_get_flags().  */
-#define PAGE_TARGET_1  0x0200
-#define PAGE_TARGET_2  0x0400
-
 /*
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3109c6b67d..608708ea48 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -206,4 +206,34 @@ G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
+/* same as PROT_xxx */
+#define PAGE_READ      0x0001
+#define PAGE_WRITE     0x0002
+#define PAGE_EXEC      0x0004
+#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
+#define PAGE_VALID     0x0008
+/*
+ * Original state of the write flag (used when tracking self-modifying code)
+ */
+#define PAGE_WRITE_ORG 0x0010
+/*
+ * Invalidate the TLB entry immediately, helpful for s390x
+ * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
+ */
+#define PAGE_WRITE_INV 0x0020
+/* For use with page_set_flags: page is being replaced; target_data cleared. */
+#define PAGE_RESET     0x0040
+/* For linux-user, indicates that the page is MAP_ANON. */
+#define PAGE_ANON      0x0080
+
+/* Target-specific bits that will be used via page_get_flags().  */
+#define PAGE_TARGET_1  0x0200
+#define PAGE_TARGET_2  0x0400
+
+/*
+ * For linux-user, indicates that the page is mapped with the same semantics
+ * in both guest and host.
+ */
+#define PAGE_PASSTHROUGH 0x0800
+
 #endif /* CPU_COMMON_H */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABEECA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTz-00064c-8G; Thu, 28 Aug 2025 08:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSE-0003lD-2S
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:11 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSB-0007Zf-1k
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:09 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-325393d0ddaso647518a91.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383005; x=1756987805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKWlfACAb2jBlO/Rna9hUlVcnHuGXsBhtcGVWRIaeSU=;
 b=FzuTBw4OCrOzhdUh7HAiej3lraUNf41DfNgNWgDzWFWjWzAgggMktXAXYti521XMCi
 Rr9EDhlFbjbAt4RHYQkk7VYQjgz5IPlEIT7Cy84S6SIyYLjfY0mz0cyYeo2R4chZ1hBB
 kC3XtPMtL/grmrT3DTVhKEopkhBQmqnPaqy8AS1AdC9MwjTdd43x2/WXLeTzNUbmNXEz
 bSrRBgrgLTfEtxf4a/DEDK0QpeUaKE/Id+Axdhw4SAZ/gkrhhTAN72o8AAkfphybhCcs
 ldPzLBdko3sm18MYrpAJRKFpXPffRu9iD+2cvMWJ8mnNPn1I8t2scV+seUXd/pSthdBy
 ihGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383005; x=1756987805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKWlfACAb2jBlO/Rna9hUlVcnHuGXsBhtcGVWRIaeSU=;
 b=ggPE20dEZtxoyKyTFCs+h0w7mHfEv8ITbrp7xonq58cTmQbqPJ4QMvWj+hrbHSH5eM
 mDI7AVwyKywo1iTkerer8Fq3Bbkqkc1AcgabcvnQdnMxTciI3g1HiWeGxDfvNWOlRodE
 aM1Z+V/YcjdflHabVFD5p/H9fkaCNmtSBp8ctcvamj0D2IIa5cg7t3NqZ+WSaZOvbptH
 4Uz+v8UHsnq+VGi5tv/sRYtZYTYKoUQE+Q9srsfhwQBpWC6np7+Dhd/o7itobW1mJMtp
 zaHp4uY5JjmcTInjD1tzaSJV229UgkdREFDUDqSVOVP/ouZWR2hrPVT92aWbVipf733s
 E0kg==
X-Gm-Message-State: AOJu0YzEQTrnk53j81MkJjLwi1FQrTefPOsz/jA1TwZwAe5BYTBNE3Vp
 EJmSQDV+uNzCg7jlnMDg4EKt4pdha6yr/VMWrmQDB9XOc1MkIjZd9UJZABYP/ywnitZ4HlfMiXt
 qNlzX6lQ=
X-Gm-Gg: ASbGnctiq9rNfJCX0DNftGRmXuDZl6EWjeucoAkYr5/4GihiPta4w4W2+/qTGK5lGFu
 fshvOBEvwWv870WxxsRj494/V5GGg2b0AoZxxR65vlSU/KTb96d5M+4teWjskYQGWWNZNmhNEPp
 BgI0XIDlUFxpcw+i3Q7fUyxmkPVjFhlLiHdGqblKyUIfbU263dZsy0akGgkbKovWO+5OuMQBNHI
 7DnoB8sCO6HEE5waiMU8DW5svARq0anI4j3iut0tI2d9TND5foNgze6tszMOhSanijPKt13hRXs
 V+N61KtAkJ33grIVv6MhBfNtgHuYATmhvsRHDjQmloYFfEWJJp2uVCOyW+pY54DpGbFykZUxivn
 FzgsNdtsrg1OHIW89mHlpv4nmqQ==
X-Google-Smtp-Source: AGHT+IH7eROIhV6B8SmbtVRbz6Oq+Cg4rIMb4jamE8AbGz7UBsn5pYg7WVZqnco/njQADeyQb546uA==
X-Received: by 2002:a17:90b:5443:b0:311:f99e:7f57 with SMTP id
 98e67ed59e1d1-3251774b90fmr30418823a91.23.1756383005021; 
 Thu, 28 Aug 2025 05:10:05 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:10:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 35/87] linux-user/aarch64: Create target_ptrace.h
Date: Thu, 28 Aug 2025 22:07:44 +1000
Message-ID: <20250828120836.195358-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Move the target_pt_regs structure from target_syscall.h, and
rename to target_user_pt_regs, to match what's in ptrace.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_ptrace.h  | 14 ++++++++++++++
 linux-user/aarch64/target_syscall.h |  7 -------
 2 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 linux-user/aarch64/target_ptrace.h

diff --git a/linux-user/aarch64/target_ptrace.h b/linux-user/aarch64/target_ptrace.h
new file mode 100644
index 0000000000..10681338ba
--- /dev/null
+++ b/linux-user/aarch64/target_ptrace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef AARCH64_TARGET_PTRACE_H
+#define AARCH64_TARGET_PTRACE_H
+
+/* See arch/arm64/include/uapi/asm/ptrace.h. */
+struct target_user_pt_regs {
+    uint64_t regs[31];
+    uint64_t sp;
+    uint64_t pc;
+    uint64_t pstate;
+};
+
+#endif /* AARCH64_TARGET_PTRACE_H */
diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index c055133725..bd05f6c7fe 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -1,13 +1,6 @@
 #ifndef AARCH64_TARGET_SYSCALL_H
 #define AARCH64_TARGET_SYSCALL_H
 
-struct target_pt_regs {
-    uint64_t        regs[31];
-    uint64_t        sp;
-    uint64_t        pc;
-    uint64_t        pstate;
-};
-
 #if TARGET_BIG_ENDIAN
 #define UNAME_MACHINE "aarch64_be"
 #else
-- 
2.43.0



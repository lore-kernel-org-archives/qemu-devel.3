Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2092AC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHZ-0005ML-HI; Thu, 28 Aug 2025 13:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSJ-0003rV-Rr
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:21 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSI-0007co-2o
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-771f69fd6feso1072165b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383012; x=1756987812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uExtz+UYbxm5QWgAqrxDGVRQ9u1WmoijCeQeuh+Ni88=;
 b=pg7/XkvbQ5HzN8jBKHoZiEfeMDfW8U/MyQH99BAs6gBTGwZmJtbYKM0ctBiQaBLJBO
 Lni5iXBlVsHBukPu5tT2pOVhWgcUVUi7NFtrnDrpYbHtlCNplgqMiucw4pVMKaWkSzzc
 kGIT+Xot6Se3Fq8XwdeYUH2dL/gK0OtBMAV6kY65pgkE5B0z4vl+Hz7tVvtHfL2sZd9h
 cgt+RfHCFlHXrP2afJMZgvrhiehA7a2Qn8WiVuO4TuwjagFNextM3IoELyT++7RNw++Y
 wVfjpLgDA/9h0hTSL76MDhoJOHn0peGHDqmfdtm92tOWrgvvcyXKjKx0SOJrfnNbLWRa
 xTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383012; x=1756987812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uExtz+UYbxm5QWgAqrxDGVRQ9u1WmoijCeQeuh+Ni88=;
 b=i+VMsEZ6vJ9V/ey3Nl6GkOLEgVYdjFOdx425wCkkpfrFt4H6Ei8XQg2otDvXLEc38+
 Fd1IfNLlb0UAMYl8DFaojqiAgHk2MON9DlfgH24caecvnfydiMlxpOsw6s1HtEarQ4PC
 nMfysRK9XULbYvNLCeoBQEBVKFuYMciMRmhymZgizF+i8TIvtdLE7MrYoZtdNUqmOFEX
 eIFmOQ4mUf44hH/e6Om1UOClC1Jrf35eQBWqub2HaQ08yrPcNsUrqFxH/4h3P4XCkkAw
 Fv4KWqpfx3C26O9zDPkSH01wAV1lzDlDfIWdoeZ5RwWVoEyh2IYSs0PPxX4EiRVg8eGd
 cM6A==
X-Gm-Message-State: AOJu0YxKLKREVSll/iCMOeajZl1CYKuBi21YSiIOzGuU9nyfAgueNFgF
 t6Lx4UEuxQkof/m78LoaVSEiMpBz0585VcQrJ5egU87qeBgCsgG/QslsF5OkuQlOLXNoVvck3i4
 sltqDaq0=
X-Gm-Gg: ASbGncsCOa1S5Ug3kBNQW7YVzCZe7Lg+orj31IWn+s13xpYqChK4S/1nUqnidDLiy4T
 NFODQ1WtXrGanfXMNniNYmBw8svAHX6vwEf1IwAGx37L/fj0dHPaEtfAaI4broMgOCQJG14Dbv7
 I3cOvx9rLJFYJoPpxNNUsO1Y5rgKilRFar/wJGEvzmehi1tep86SmtNPJJPXJ+nbW9vOrLLQnbT
 mwNXzslJP0hKajggbp4Q7Ry8UNfVGiBGmx/EP4HtxgM1Og5CFfd+j5gp4woLx+hLCF3q6ObTWWJ
 PKBUjtwHMCrKIflvBQnoiRr7TAP+M1KB4lhf1zjnP4GzCJr9Ba3XyugWIFrATQaSntlpfQyxav+
 jcLQXcKPZWt1Ue3QhlypxHtBtWQ==
X-Google-Smtp-Source: AGHT+IFeYPFa84xwrRoko5mXUlNsBdRbncwhQTob5gTkGU2/10BrlJArk+mvL+RAe8A/7UIi+4eXYg==
X-Received: by 2002:a17:902:d54e:b0:248:d4d5:8402 with SMTP id
 d9443c01a7336-248d4d58c41mr35605245ad.20.1756383011994; 
 Thu, 28 Aug 2025 05:10:11 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:10:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 38/87] linux-user/arm: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:47 +1000
Message-ID: <20250828120836.195358-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h | 11 +++++++----
 linux-user/arm/elfload.c    |  8 +++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 94db3738e8..fa8f8af2f3 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -8,16 +8,19 @@
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-#define ELF_NREG                18
+/*
+ * See linux kernel: arch/arm/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct pt_regs via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_pt_regs pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 47fe16a1a6..726d3ec25c 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -201,13 +201,11 @@ const char *get_elf_platform(CPUState *cs)
 #undef END
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
     for (int i = 0; i < 16; ++i) {
-        r->regs[i] = tswapreg(env->regs[i]);
+        r->pt.regs[i] = tswapal(env->regs[i]);
     }
-    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
+    r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
+    r->pt.orig_r0 = tswapal(env->regs[0]);
 }
-- 
2.43.0



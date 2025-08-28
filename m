Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD769C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHg-0005Xl-JC; Thu, 28 Aug 2025 13:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbW0-0007m1-LG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbVx-0008FA-So
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:04 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4c72885c8bso113254a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383231; x=1756988031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpJiF4bApuwU0krCB2cxcz2fyKtUh5H+0164pmacK1U=;
 b=UDiL1pPULorqDWRQPAQfjUsV/FQC9Wxi64CCfRITHI6sYiiYailTm2wH1O5dWQ38E0
 h4701zd2Uk4LWmG2dEytnXgU68HCwjeuJWgiqojHRaH/E0/WGdQ7HPeykCWB1yNSxkyM
 34FfyIHhU0WOJ2jdDCyoCd0WF8RA5dH1d8Q7gISrT06liqLMSqP5X8K94iaSytf3BIyI
 /dzHQMoe+7uV9sktmBUWrpHCjFtQSvL8vESOnPvW4YzgWyx7qTVN7uYCsMDwkwryAXL+
 OMJabvDQIzBlMTB5n0rM7FGpZGW1D8ke211Xcl+NGScVwPRC/1ySfI9TkwScG2YZLInk
 kaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383231; x=1756988031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpJiF4bApuwU0krCB2cxcz2fyKtUh5H+0164pmacK1U=;
 b=XuXj+bGnhUwFQE2RMDJ3QK97YXWXhbsESDB0LL29Ph+oCyvt5nsMau81l55iKXHvsh
 wMg3Khf5q8VNLe9X5voyYDb6EcN6XndOdxcSpQ0ehPAD+kvIqjWsjZEon0zQIr51QT0D
 qPvz05KpN9SJUGPtSorv9zQDIx+0HFx9ec95wHmLk2A4XcuxXZaGf9IuS08OjQSPID8j
 NE3Xim2YYRR/0PwlzQ0SgN0ej87g4KRE9yxdo9Sh77CNBZAJhhRdML7IW37jaj6dFRcs
 IVCVdZlc42/JDM1n4I1PIjmKx2mEbvNauqEAtmggSeLIxuMLD7ZJ6iiUIZm4hUXbhXy0
 N0pw==
X-Gm-Message-State: AOJu0YwFHGpl7lY2ZD/N632w0dGzTH2uT3kqVkqBV1vjM5s3eW/RWdYQ
 7HDSyjzSTGiSLsEfE6juK3wGu+YBqstiamTEP88bnNeulgbVH70hfNv1fVo4v02jklh7KpCIdnd
 8uhATCts=
X-Gm-Gg: ASbGncsy3XrougUIEnPORmPUd3jcNgBHHh+TZ++XLYIrk8mLNvyJku3vOZmMtZCDM9K
 2b7X63coAwtOsVosc31IVQghGWsYSn/E6YsTxxPf6Y1q2VjBkNKG+iqae2e3xzwemABTojwTDtN
 /tY+Q8ZrPCBTTpGmLarv9fG7Rhn48z/jgzWlXvGe6u49yhKoUtlD2WpqlVRJOta0E75wAGG4pZL
 p7iUOEa8W2LSrSW4JDRmkYr8n5FSPds8JcymT8gZm+PmXI1MOLp88dPITdnldQtCZXNwGS73yvy
 w8+4JaneflAYalo4t/82R9TEcRIcbI/Zfa/VMdh0JnPt5dVxF1jJpEHD9bHrxUzier/eYKxD0U0
 uDDNUaU1OTToqFTgZTJ3V44apnQ==
X-Google-Smtp-Source: AGHT+IEMxegY0hn9Oy3HqE6vjQHAGIV2jYK19qBrO9540TQNVM2zdTUVYE3o6Nqh/DViV4C923TPeA==
X-Received: by 2002:a17:903:2290:b0:248:95cd:5268 with SMTP id
 d9443c01a7336-24895cd5bb4mr94760715ad.46.1756383230773; 
 Thu, 28 Aug 2025 05:13:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:13:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 48/87] linux-user/openrisc: Expand target_elf_gregset_t
Date: Thu, 28 Aug 2025 22:07:57 +1000
Message-ID: <20250828120836.195358-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 linux-user/openrisc/target_elf.h | 12 +++++++-----
 linux-user/openrisc/elfload.c    |  8 +++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index e97bdc11ed..ad80e4b41a 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,14 +8,16 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel arch/openrisc/include/asm/elf.h.  */
-#define ELF_NREG                34 /* gprs and pc, sr */
+/*
+ * See linux kernel: arch/openrisc/include/uapi/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_regs_struct via sizeof.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    struct target_user_regs_struct pt;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index bb5ad96711..6bf02bf58d 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -11,13 +11,11 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "any";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
 {
     for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
+        r->pt.gpr[i] = tswapal(cpu_get_gpr(env, i));
     }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(cpu_get_sr(env));
+    r->pt.pc = tswapal(env->pc);
+    r->pt.sr = tswapal(cpu_get_sr(env));
 }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF999C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2Vh-0006bt-LO; Tue, 27 Feb 2024 13:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Vg-0006bT-Eg
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:49:00 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2Ve-0001WI-3p
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:49:00 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c19bc08f96so2645678b6e.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059735; x=1709664535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XrEdDvQ88jaxWmSDzzj/y67fD3f8yoeJckZhxITx78=;
 b=bk2bEhaspsIlDdm37ktyEla0/+/heZjF5/vny1ifWJlHAJ4L76lWvtpPdBmnKaKpKB
 y93Rwe8e3yo+OVJnX2uvyZiP2V3AMqI6rPAHLLGcsqJn93UHXY5KYxBX79yBsb7rhjAs
 S3iSOH8VBJdJ3rLqHCgEPqsDtr8phsbwLdVtkOqjWl8OEFQ9aF2Uhq/bQoHj7DKqECZr
 BH89+pweLb/GdaS2rDClziAFdwxZaCI0NiK89QcNmJ8+CltCWKWa4oQe3Y6AxGcIV4EJ
 jFNOAGfdYQRKB+brsZSs9+38o9/R0AE4LN3Y153ph5dtydkKdWtzckm/pvhICPu/y9Td
 Qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059735; x=1709664535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XrEdDvQ88jaxWmSDzzj/y67fD3f8yoeJckZhxITx78=;
 b=jKWh3n0MWM7CajGpKSOagmyThxoGV8gc5jSyMwTuIxjW4kcLyrHS7T7Yh3bXLXJDef
 A35UExPfa5UX6DfxdwmXwdKCG2d7fttv5o86JDE4+Eljsibup/Z6wNdskr0z2xlme8xD
 oJLAMkFGEitC60z0SesXZunPzpe96dSR7F7b9IdyxD7frQg+fEMbCIm8WaLGM5LSFt8w
 i/sNRiPDvpsl14hr8YkiZlb9aesq0O6Lo1aDilkI8WGTUJ35/Ra1fUMCh7J2tuhqdhOB
 XU6Hq4fOj7SDKlwkydl5PjPGVlKZQFUIOuNKr7U78Q4BLHgzeDjrseqc41/+Kk/qXuAE
 IQGg==
X-Gm-Message-State: AOJu0YxGKXBBElc4pFs0IuiFd20RI2qMGt9shsxs1eZUXuyaYi1zKW03
 7WL9fMpJTxzdsoCrXLvOWdf8zCZNU2ksrpAWjj2bcKiuSvxrncylamGRf6iwGDGIHYEp82QxMJF
 P
X-Google-Smtp-Source: AGHT+IFwPv20Lunhw0EIl5D610KWJyC2ViJkG+Z2W8wOQe0dzYY6wDqca/yIh4a4kGNXtITZ/38aLg==
X-Received: by 2002:a05:6808:14c7:b0:3bf:bf81:c700 with SMTP id
 f7-20020a05680814c700b003bfbf81c700mr3445815oiw.16.1709059735654; 
 Tue, 27 Feb 2024 10:48:55 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 14/14] linux-user/elfload: Unprotect regions before core dump
Date: Tue, 27 Feb 2024 08:48:33 -1000
Message-Id: <20240227184833.193836-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

By unprotecting regions, we re-instate writability and
unify regions that have been split, which may reduce
the total number of regions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ae0abc4931..38bfc9ac67 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3963,6 +3963,8 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 }
 
 #ifdef USE_ELF_CORE_DUMP
+#include "exec/translate-all.h"
+
 /*
  * Definitions to generate Intel SVR4-like core files.
  * These mostly have the same names as the SVR4 types with "target_elf_"
@@ -4280,6 +4282,23 @@ static int dump_write(int fd, const void *ptr, size_t size)
     return (0);
 }
 
+static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
+                                      target_ulong end, unsigned long flags)
+{
+    if ((flags & (PAGE_WRITE | PAGE_WRITE_ORG)) == PAGE_WRITE_ORG) {
+        size_t step = MAX(TARGET_PAGE_SIZE, qemu_host_page_size);
+
+        while (1) {
+            page_unprotect(start, 0);
+            if (end - start <= step) {
+                break;
+            }
+            start += step;
+        }
+    }
+    return 0;
+}
+
 typedef struct {
     unsigned count;
     size_t size;
@@ -4401,6 +4420,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     cpu_list_lock();
     mmap_lock();
 
+    /* By unprotecting, we merge vmas that might be split. */
+    walk_memory_regions(NULL, wmr_page_unprotect_regions);
+
     /*
      * Walk through target process memory mappings and
      * set up structure containing this information.
-- 
2.34.1



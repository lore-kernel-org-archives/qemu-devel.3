Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9555BC36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 15:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15nh-0006Cy-Fl; Sat, 05 Apr 2025 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nR-0006AK-V4
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:02 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nP-0002gE-9C
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:01 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso4013206b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868257; x=1744473057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4pcTaOhdNSQrPCcgStjubsUIgw1IcwTve4W/3vZZ+s=;
 b=weumnnYetfb7L1mwX7ecRipYCJesPkQ657GxfyNcmznNkZGWMW+bgVaPJgvtvWGrgV
 iuC7rf3l01p+ftRzykrM2GT6vBZzvOfdQeRs6nQ76GK4v2baIqB5+GNBUjJx33XXmFBS
 h7c0fgCKXv1eaGcZQjY3UShC1h8Icl4frJlCIJb543cLqCcIuuhj39s18wBxNZhE3oC7
 EXeTiwmLTkCrjfuvadfLRXbpZu6GbpMw7aHTJ5IEhcC2uusifC60vs22n/+tQuEhF/et
 caeP64Gyz0JgCu1rCz0qk1PWf5BftfpRCo4ERHOwj3VAiNnqetXAgo5bYCR+j/W2GO7Q
 H0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868257; x=1744473057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4pcTaOhdNSQrPCcgStjubsUIgw1IcwTve4W/3vZZ+s=;
 b=EoCVVwYXogl+6GNRiEJLOMJxmNZC3IdZm+4sIkdnHgmGbZ8pPrLZgyOJefu7Ou67BB
 tIv8siOwwoE2qNjYPqrHgYhIsyz2gjIBxuSJTzmpxg80MKt/q0qZapoVi/JqZ5sQ6Kx+
 lqZ0ijbInE/zRLufMvzaHwrnZklELIhfFLpXQZ4qfPxNxnxP1xUor7LVyrqBoVevDVA7
 cx90jdxExKSkDNRdz8bMnfan1i2DuSdJMDdYKke+lBbou82weR3VBkI6aWMOQkvds+IF
 nNDih3o8GhIoeVQ3+6krI9/tCfzQ166ed3XMwHlq0vDqL2gcNuZzbhmDBUhfjRIDLuvN
 YVKA==
X-Gm-Message-State: AOJu0YwtDh0ykQ8OEKlmdWin/3EV0yMXieWb/FCa68sKOreU1xPQpgnK
 zkGDc40fX6auOAc/gf6TRG/Iiw0kT3gAzhfedIpjlNj64laYAKPSnop71jKFjPMG2kTMAOTu1G5
 1
X-Gm-Gg: ASbGncvGczTZVNDGfKduiHpbhd0KK8RXOESz1Knb2Cl3PJKZjtdPcq8bMFDVgTnlqGI
 e4pE4nsnlwfEaSX/u8L56DLrqV2u5DnTyBh3yRxxOpNmwOXOibzWmyXmM8JsqkwP7/y/mYTEJNG
 ytYXkopWXSUeM84J5/FkKs/Kmn1Qts1KqAlSDMa4nMXIvE73ocPO8/7FtlrUsFJxgyHhKdCOP6q
 m7pWtNqXGcjxQrws/rbPat+/qr/ngz6QdGFgjyCOcY+RiopxSvYi8yd0rSyClT8wiqrToqZRTsV
 MUCeZXujnD+DzTT3eRfjdrif5wogztt5MLMkrpMvG3AHutOBbWp87sKYIvSpqss=
X-Google-Smtp-Source: AGHT+IHmCQwaEZ9/V1EyayqsUkeY9GNUfcvidFKWGHhPojUNBP0S4iJRWCSlwQtA7C7rz7Gb5XPd3g==
X-Received: by 2002:a05:6a00:2292:b0:739:b1df:2410 with SMTP id
 d2e1a72fcca58-739e4f73f8dmr9785942b3a.20.1743868257007; 
 Sat, 05 Apr 2025 08:50:57 -0700 (PDT)
Received: from stoup.. ([173.164.107.234]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4851sm5554790b3a.146.2025.04.05.08.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 1/3] accel/tcg: Add CPUState argument to page_unprotect
Date: Sat,  5 Apr 2025 08:50:51 -0700
Message-ID: <20250405155054.967307-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405155054.967307-1-richard.henderson@linaro.org>
References: <20250405155054.967307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

In the next patch, page_unprotect will need to pass
the CPUState to tb_invalidate_phys_page_unwind.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/page-protection.h | 2 +-
 accel/tcg/user-exec.c          | 8 +++++---
 linux-user/elfload.c           | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index d5c8748d49..1de72e31e6 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -16,7 +16,7 @@
 #include "exec/target_long.h"
 #include "exec/translation-block.h"
 
-int page_unprotect(tb_page_addr_t address, uintptr_t pc);
+int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc);
 
 int page_get_flags(target_ulong address);
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 5eef8e7f18..90b345a0cf 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -128,7 +128,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write)
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
                                  uintptr_t host_pc, abi_ptr guest_addr)
 {
-    switch (page_unprotect(guest_addr, host_pc)) {
+    switch (page_unprotect(cpu, guest_addr, host_pc)) {
     case 0:
         /*
          * Fault not caused by a page marked unwritable to protect
@@ -584,7 +584,7 @@ bool page_check_range(target_ulong start, target_ulong len, int flags)
                 break;
             }
             /* Asking about writable, but has been protected: undo. */
-            if (!page_unprotect(start, 0)) {
+            if (!page_unprotect(NULL, start, 0)) {
                 ret = false;
                 break;
             }
@@ -704,11 +704,13 @@ void tb_lock_page0(tb_page_addr_t address)
  * immediately exited. (We can only return 2 if the 'pc' argument is
  * non-zero.)
  */
-int page_unprotect(tb_page_addr_t address, uintptr_t pc)
+int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
 {
     PageFlagsNode *p;
     bool current_tb_invalidated;
 
+    assert((cpu == NULL) == (pc == 0));
+
     /*
      * Technically this isn't safe inside a signal handler.  However we
      * know this only ever happens in a synchronous SEGV handler, so in
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 99811af5e7..7519b6bcda 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4245,7 +4245,7 @@ static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
         size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
 
         while (1) {
-            page_unprotect(start, 0);
+            page_unprotect(NULL, start, 0);
             if (end - start <= step) {
                 break;
             }
-- 
2.43.0



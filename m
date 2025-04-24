Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AD9C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGe-0004px-Dy; Wed, 23 Apr 2025 21:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFP-0002aK-6H
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFJ-00078J-OK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so353994b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457560; x=1746062360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTY2OFpS1RWTqGYBX13cfwjNoyREKh7hiz39ECnEaC4=;
 b=J83aGy34xfEEhWyj4WodrsJ2/DtUjvCxdDknjOFgLlwXowHv1AVHKoX/K7+T+U+x+c
 h965d81TtW+NUMcGojtmmy3sNr28acGlhmym9PIqS0avg0YfHcTc4kQHg0yEuqRT1nil
 n6LunxsUoAFs25LMulaTFHtnwyrbI9oWMGARCZrFtTHFvalFY3I5Lg/SOmIBjlkc79qD
 BjSuLWbNatJY6Ksqw3kKXTDk1/OsxkmgFYe1Ck5RLnP3UigJ3DZbtTb2/TS1P/bFCr0g
 ZxNicZ2HsegEJ3f05mdBhYUEEVff/KaRWls77gnfSgu/FekXt3lNp3lAiAdK41+X1iQa
 JVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457560; x=1746062360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTY2OFpS1RWTqGYBX13cfwjNoyREKh7hiz39ECnEaC4=;
 b=q2j3JvyWL4oVcmLb3ZnTFX97tD0PPw4yYmKZAnrs55FCuU4iWLNwM7Aihstd9rlrn5
 vbxCT9bY9WEg9txqR7v+bXUX/ZYl07xh9vlzk2GTurIoMeDXQffoDI1zEloSSOegtLDJ
 QAAfaP5GmhANmKQiM1t9r8hnzYe96Qnc7kaGiXT69QRizhFH0VJ+OY3oTL6NoCCgdQ8W
 KfV3HmzGHN+FsAInk6gWgymGitrPKm3gWfWNRlEvRyduSoYLDOnLLVzd3482u5QksttN
 fnyY2qdRT7D9XD3kNoixTkbyzG3hpbsjZEu/zdGkL/SpKJe4beexBPMFkJRi5y7rDdMP
 LksA==
X-Gm-Message-State: AOJu0Yy4ialZ8pyxgKHiHL1kyOo6erNIFvNgMyzu4IfsmC8MeImmmW+b
 CRnTvDLDWAxuagHEPNSr0TjYS74HkqKyeTe7OvUkrbfLePAMqRm+SKOopGabYZCjiaBytV47ibb
 c
X-Gm-Gg: ASbGncv1vTGtGYT9K30j8LxfQxS5mHJZ1gVZt7YhBwXBxN1hqRUWbNoXcjTqdPOKtM0
 4gtrR1mYjz6Ma7j+aT81sgA8YugcWSJzquSmIpuHD2H7LasqZFiQgC2u8MGYvZ6zAe247D38IeL
 HE/L+SBo35hp6SoH3pCP5FCBXsta3zlFrLtbO9fPzT5pGeeGyEWBSDQ/EVAz75qyJez5aqXG0x5
 bJl/MHjFH5wLPGnTb9MUd+k+3GvjSLkLEWxxYgWsNMfu9/nyRUURb/xot5BWz6hx1xhkh4ZXZ/9
 bu9J95bgkMcvqz6r3HjVzzI+VlpIAI6L0St/Us0HBegyaG2BW+i3CXWCthaAc5OIKzqb3AyLHMU
 =
X-Google-Smtp-Source: AGHT+IGVIn2VBTQ1j810ewXZpmfE3Z6BlD+pvqgsDn1jxME6klGd6xtjQfwUWeuR2vxMKzOqWtpsSA==
X-Received: by 2002:a05:6a00:3928:b0:736:34ca:dee2 with SMTP id
 d2e1a72fcca58-73e245dafa2mr1203122b3a.4.1745457560358; 
 Wed, 23 Apr 2025 18:19:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/15] accel/tcg: Add CPUState argument to page_unprotect
Date: Wed, 23 Apr 2025 18:19:04 -0700
Message-ID: <20250424011918.599958-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



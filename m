Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FCC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLX-0000mC-59; Thu, 01 May 2025 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLM-0000k5-DE
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:21 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLJ-0001Qc-4j
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:19 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b074d908e56so1043779a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134475; x=1746739275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EM05DafzKajHmaQ2N4+ygLxYZEoAk2szFffhGOKpRHI=;
 b=nsjKT35i8c+g8lWqKt/I6r9ZX15cpZhqgOCBDp9m+vo6aDJRjvRObtSPIKnjw0zJf5
 svEHik9w+Wa6ozfjH3IjvfdfkdG7AM6SUsnlcIhci4xspeOZSPH2+OVA+mbg+onPF9ut
 5G/JssKl9YhQcr7p5R2Ghj2Xq3votKRHfv4quo4CWLy76qGLKJKNVQxbS50M9rEPrRqP
 InqWKD9hc4jZeI9dv6MiQji+470Iu7h9e1hnkltonMIubIuoYxe+3KhLmZrrF+8SViRj
 ZiO4vRtfuvNjRVJrmXl2Nzaty5CqvyzsSnf2vK1YudDcV3Ft+yYegojE9/91BdYTcMbU
 lqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134475; x=1746739275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EM05DafzKajHmaQ2N4+ygLxYZEoAk2szFffhGOKpRHI=;
 b=rcWDLTc9vWVosXJSL+8Xo4rjE67wUcD0EcAv+LLhr/nBXcmo3Osd5hdv2k2rlQweAh
 dmoZJtUYklhncHyIHpMWyAS26sUCkFXPmQ8hK15SYx6Q85k5/HyPEr5MpaYlDAV1lxfK
 4s4HI3rXlblT4wDFcbu573AwXjuRnAN+NmEqZL+ASywrbGiG1r6koKuX1JT9k2ZeI+uu
 VTxOm9kOJaRor5GNMVEK+eLUnXqw0zhiUlXSWKZNkUjpdcUyq+i07aL15fp0CM848eMg
 cbdjHvRw8BgbNbaRW4KpzK01mWRNcHJ674bzIGVuCzmAeSO8Wzlr5Y01QQW70rl/E/q+
 tibQ==
X-Gm-Message-State: AOJu0YwFUmg1QDvPJF0M9kRd+Pm1OgD7dGOWxvu/3P2+hASoFFcglbpE
 N1UBurgYcUgeaKHYu6BqhQW84fSTcfMxdSpKgbyt4d7+Q7Nj/r+fleRpwqZ/V+3+cOoQH3kI/Lh
 k
X-Gm-Gg: ASbGncuVvSZvm0moGMFNci0gSfs1QdnkHDVfE839UQhrYHoEpAgW8hvn53xB2NoKNaj
 46+g3aASDPsELw4z9+1g11mXS1dXgx13U41HdHKTw2RrFElXimXDTnwXnbsQHgcE6AGBH+2fOKi
 OiSUA/W7dcTfnwn6FcqvvR0Vz6Bxgk4/pPB/SBUsb5LUDPVNi22QQXGQMztycqP/KxsqbQEFznC
 vs3mVUOLRfOPCUB+Z8dydyTLvvE8GqEviGHTBaSwHEZxdv7ve8LC7EzDz0pQTpkl51kyJ79NFHo
 zqj67E0byg6O3bPW0fbH5lgoscBQDAsm48aPvZTtqq3JwjAWtMAGa0FzvRolHwbsDkaZVGZTW1U
 nnZafFYRXag==
X-Google-Smtp-Source: AGHT+IHs3+THVnJvh5J5Mmjc4xkhgzHSy+3Tjf0x/4X8o933ZkQze5Djhmm+2RPXauBSu5tkMEAM3w==
X-Received: by 2002:a17:90b:5184:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-30a4e5a1376mr974522a91.11.1746134475347; 
 Thu, 01 May 2025 14:21:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/59] accel/tcg: Add CPUState argument to page_unprotect
Date: Thu,  1 May 2025 14:20:15 -0700
Message-ID: <20250501212113.2961531-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index fbfdec2f17..87c6d3ab9f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4260,7 +4260,7 @@ static int wmr_page_unprotect_regions(void *opaque, target_ulong start,
         size_t step = MAX(TARGET_PAGE_SIZE, qemu_real_host_page_size());
 
         while (1) {
-            page_unprotect(start, 0);
+            page_unprotect(NULL, start, 0);
             if (end - start <= step) {
                 break;
             }
-- 
2.43.0



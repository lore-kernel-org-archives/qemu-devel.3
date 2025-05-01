Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37132C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLc-0000q1-TO; Thu, 01 May 2025 17:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLM-0000k7-Lk
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLJ-0001Qi-LP
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:20 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso1614363a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134476; x=1746739276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyHS8JhkVggJWYCLf21RFoGh3DyPnGZlHWJduulHrvM=;
 b=RV95qriSx30MWvHTFE+UBNYpRbsgNiP2BlxrrLRXBVro3YtxtOoZ/vQH6T0SR6kZw3
 29b+E++cndCxvJ4eEap40VMHGvA2gUeGvpQJ64T9bDUIoVtqzdsi3YwfBEPHD/rt8e1z
 u2O26vWoIw2xKXKvbh+1VTZ4/iFxMAl2IF+aC0HPvX3YR9fWbiH9pYhWiZben4aWiFxY
 fLIFbTY4Z7FSHlZAiBnX9ijlcpEdP+OVuXN6A5d0Px3w+3gfOJFi6in9jKmRd8i6d2Jm
 2WF1ZLyQSfWrZSWnnEK1Hhyq5iHXUNe47hAV7jVGkwn8T8XEg2vcx1N/qYRKtOi9/Xlx
 /06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134476; x=1746739276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyHS8JhkVggJWYCLf21RFoGh3DyPnGZlHWJduulHrvM=;
 b=pG9T9Jnv5D1Z7BBNanI0K+bt9XaY0MOy188nk11ivXMyFcCzQl9m5VFdo0IJGBw5BE
 ZkFJ4EoOblKfZZGFVbHme0K4CdnP0WhzD29OMeNVu8ZL+ofX4CWbgRaDOqOtlf9PFu0T
 IDWcvdjzxV4xEYVbYcnZg+J9NE5A2jqDlBogS5XM0KTFwaSu1YTV2t0yt1yl1u0qsmLT
 nSpc6AvFLOvvAnIWRi8gaRfddhP5kR0BOePPDtzf+ClS9YLFkI6gWYLEw7frZWizb/Tr
 4olyu1DQJ1UCGZRqaqjZPZtBGXs0V9Ll4ziVxzo8LGOOUgEXgllWbOHxTG5ZZ56M5VbP
 IODQ==
X-Gm-Message-State: AOJu0YzcgIYnAYl4+7f0tr2QulHd+IJ4IZ9to3EQZSgIDI+6P2VBtCM+
 yrEZrLEqq62dkHToJrUr41sFoNAAu6ut6kNdU2g8udEBa/yA0aOKSFNSOLF/NCVQHUkBIsHiihU
 U
X-Gm-Gg: ASbGncu4X/Jw/o3F928fXW/wD4DouW86MpPitXKiuJo3rytoatC2fYLy2gvS5g+hkH1
 stNWdRgqV/9w12aeAT749znwekmTZZKBVaoNMGgJ+a8Yl5D68OMYU4vaAx7jOlDJUT8cDQ3JSCY
 Xk5YyC1LTp1cbuWgwNlFd56wF+P2SXItp+3R7ciZ5x9szWFB2eoB6ZJZqr1YAjk6oPIiwYSrfBs
 AQ6QikcLMVtsdv6aHax8Vz4VBHCQ4Avu210k2VM+s4SbP0OeLH8uD9gHRUI9sIAwldHHYNQF7g7
 TKlmfdtQtv7uag7Cs8wqJyd1sMvBl9tUkMsN8cenXht3LLs+GfD9eFJXlrJ+sdHNBjtcVZI1Ows
 =
X-Google-Smtp-Source: AGHT+IHtkU4VdKzrabxzLTDEVc2v0XZoB80B8iI1SAksvrWS7Yj8O4PiFnQsBYIVQ53+Y3AACEU+Gw==
X-Received: by 2002:a17:90b:53c7:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-30a4e69e8b9mr896905a91.28.1746134476100; 
 Thu, 01 May 2025 14:21:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/59] accel/tcg: Add CPUState argument to
 tb_invalidate_phys_page_unwind
Date: Thu,  1 May 2025 14:20:16 -0700
Message-ID: <20250501212113.2961531-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Replace existing usage of current_cpu.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 3 ++-
 accel/tcg/tb-maint.c    | 8 ++++----
 accel/tcg/user-exec.c   | 5 +++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 08538e2896..1078de6c99 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -50,6 +50,7 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
                                    uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
-bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
+bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
+                                    uintptr_t pc);
 
 #endif
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d479f53ae0..714dcaedc9 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1045,7 +1045,8 @@ static void tb_invalidate_phys_page(tb_page_addr_t addr)
  * TB (because it was modified by this store and the guest CPU has
  * precise-SMC semantics).
  */
-bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
+bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
+                                    uintptr_t pc)
 {
     TranslationBlock *current_tb;
     bool current_tb_modified;
@@ -1083,15 +1084,14 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
              * the CPU state.
              */
             current_tb_modified = true;
-            cpu_restore_state_from_tb(current_cpu, current_tb, pc);
+            cpu_restore_state_from_tb(cpu, current_tb, pc);
         }
         tb_phys_invalidate__locked(tb);
     }
 
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
-        CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
         return true;
     }
     return false;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 90b345a0cf..39b76d9654 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -749,7 +749,8 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
             len = TARGET_PAGE_SIZE;
             prot = p->flags | PAGE_WRITE;
             pageflags_set_clear(start, start + len - 1, PAGE_WRITE, 0);
-            current_tb_invalidated = tb_invalidate_phys_page_unwind(start, pc);
+            current_tb_invalidated =
+                tb_invalidate_phys_page_unwind(cpu, start, pc);
         } else {
             start = address & -host_page_size;
             len = host_page_size;
@@ -772,7 +773,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
                  * the corresponding translated code.
                  */
                 current_tb_invalidated |=
-                    tb_invalidate_phys_page_unwind(addr, pc);
+                    tb_invalidate_phys_page_unwind(cpu, addr, pc);
             }
         }
         if (prot & PAGE_EXEC) {
-- 
2.43.0



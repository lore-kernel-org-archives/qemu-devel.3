Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDD9C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGN-0003uX-I9; Wed, 23 Apr 2025 21:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFP-0002a7-5s
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFK-00078V-LF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736a72220edso432203b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457561; x=1746062361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BSyrZdC7v2JUnVuoXHNlf5lgfOuXFUfOH2AgahCd9o=;
 b=y0FK71/dodldrMacsgVxZUYO6NKDQ8WXukDxmzPVUzGmYVJNxjdCljcDAO4RTJL5Ln
 RHEyZ67U7cXXw9VrNWMfzLQxyI9LCgIzWn1qdRFIQyeIzTSYJW6pydx5IF/gq2E8RLcf
 VUAdkaU32K9jflvY0/P8iJMm+HSY6h1C4o3yHmxlTyYqY08qo6X5GCqjQ2ZKVHxV1t1y
 pz4XSfPyGXF25fArIW/+N2h9ntKB1j6O59Va5BnY/akT+Ln9Xjwhpqim12vJDR/1nAqs
 P1p3E993Qe59rPv2Q+1YwA8VGTexyXFDKToO3VJfF/h9FklEx1fGOIBmEvjBRn5E+yA2
 NMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457561; x=1746062361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BSyrZdC7v2JUnVuoXHNlf5lgfOuXFUfOH2AgahCd9o=;
 b=DXjIfMWnuNPOSrNqTe4BTg62d2QO88ewZWpafk8naZhcMtiJbgVCJMMSgzslSBJJiE
 VMppaNz0nSFu1CWwqgVRacO69ZvLcSajSrfHdcvfBOPtz5Pd4RExc0i+HSm3PPXg+VQI
 5/1N4jKe23QEB2KU0lWU0/sb6jL6LSTLIU/TQMSfymtFVcHaOzczZ6f3pOoadslUTZp6
 EWRvXELj2L8i0jPh30AOFJBcB6uF/qdhQUu26UX/8XwTFx6fh/XiJzvxD7Wke58HTPzP
 u87vFAct+KTSMpHlUZCqot1AI+pdZ7pNnWXaFsULgQjg9l9wsdFUds1DGGy/IRAu6zwl
 fDGw==
X-Gm-Message-State: AOJu0YwYdsV5P4JoIt8yjmGEwE4gJfdr3ASAqt6SbYFoF/zoacGB67Sy
 el+Htpjz5JrWQKIvKYqGGxqYyQF6xK8WVNZlb9YOaMAqrBIc6w+MDwdpS74Rh1yb0JjXTY+qYq/
 +
X-Gm-Gg: ASbGnctAExJxYjgC8aisz4Y9vLs0xuchrMBAQWdg4EQaaeRUxcnj1himBFeZCKNXdBs
 shrzBT3wIsZ0xVBDOtwNx+dIlQvWVHxRaB8Gom7SmZ2eAa5A6inqD9vTU3nIiN1BC4BbJUx7GOP
 CE3rXfVXFgMRKuRBjYLQ+qS5nhUtLoyQxy9glK7beiwEK6E5H+uvk3QCUooMCnqXO2scKj3l8w3
 WIG+jYzDHe2sfRMJDA++/9YWhfaURC4O0asQeEZi26WHIks1f1VSRzCjzBASHcLZ1rV9+RF+F8q
 wsRZU+Tvd6cEilW+fg8AwitMlRila6GkIt4q+6nl9+zwuSAH0juQ2Z8BPy/c0y8qWxOO9X0MaRd
 5U8c/WBru2Q==
X-Google-Smtp-Source: AGHT+IGYM2DwESJiINJzNJzPPoHI7bpOL6ks1LIELyRacW7v4H+T8a6/PjQ6dFd5EjyhqNYM3sxtXw==
X-Received: by 2002:a05:6a00:1d0a:b0:736:457b:9858 with SMTP id
 d2e1a72fcca58-73e245e6478mr1034101b3a.10.1745457560957; 
 Wed, 23 Apr 2025 18:19:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/15] accel/tcg: Add CPUState argument to
 tb_invalidate_phys_page_unwind
Date: Wed, 23 Apr 2025 18:19:05 -0700
Message-ID: <20250424011918.599958-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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



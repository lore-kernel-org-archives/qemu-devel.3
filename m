Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0642C3ABB0
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPh-000735-EY; Thu, 01 May 2025 17:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOu-0005GI-HM
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOr-0002E4-Si
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso2039227b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134696; x=1746739496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fe29IZ11mCzFvm4KslVvKmO7MK48jjA31j/L8P/5R8A=;
 b=YdXwbRixG56l7kkFfVNyAA+iHvW8Kn4OKLpmsxieJWK83HYwDp7hvDQbVJ/Ibdb3N0
 jC9L9rH3pyTX/UFTmMsmyWjMEo5ziBE0DXEyUC8rcWIyj4HfhHXAlNK5iLQbhoFDbe/+
 SEflJMJ9E/8KeWilXe2J/oblWMMqQ+yc3085j5R05B/HGw1bCixKWE1DEB3kxsg0BHG8
 EsgoWQqPePdAJnsWgljEMPier0ysQwRltQ5+AAhrDx66r6F+lglBdllmqoC7Z1w4i7sV
 Ap7dfnpg5Y6fEHM2qTHVMuplvHIbj77BXlvyrOLG8NnHRqotX5rJCSrc0x09RBdlqk8z
 y1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134696; x=1746739496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fe29IZ11mCzFvm4KslVvKmO7MK48jjA31j/L8P/5R8A=;
 b=ZJTMyIdy31i81W1Po/3rZhUYFV2ft82DNrMdcqW+eRQogkBsnX7w0TjD1WhbwzCfF3
 /xiPbyinGPdraLzRdLorAOPy3zWSSNVrvQdN+xaJ7ed0vWOJ/sHo3IUfOzq4rXddGR74
 J486W/BhCSs23l043cXmA6ysT3oIttVZTVbV+mN8lTcbK9QYENSsqIZubuF05xmzgiOz
 XmTxRsdD7w0GWOLR+uit0NgT2RSR7WiYtqwEE/SPPJhvg70C7Y1gH/bauencsPt59VmJ
 nP9Jy8L6+NrYNJrDGXFuXnQvI+bP0hQUwP0FPyaArM4MT9Hpef98VD5ipXV8AW3UhSs2
 ygJQ==
X-Gm-Message-State: AOJu0Yw4ZV62yiWc6uxcItGhW/ZIiZ6uwcoUWw8FX8zvOc1eDbem6AZW
 5MwovggF91eHHo3NtkfX7sBEr1WekPFyKojt4Q6m9BXmryRfuggdYpDJEzjmmQo9YdMvegUAE68
 5
X-Gm-Gg: ASbGncviGj2HqhyGE8swxLnb/i8kRT9fSTRDCOjl7UyZ4WqJ11XUp87RgDV523+9S1b
 tVLL4vBSB/ookf6cLDw1HfW2JgZJjk60dSgwI2zW9nizJiCQJgJbSwNC3TPoGq/1chqXMfTNugF
 PDGLHMX4HjNIb2QRbssS/5EaKnKgJOU6GcDFksUrrCLss3Y8N19zDDr5wRsik5EOoLMfXghM2kP
 ocopmgXmy92Icc6Ogu1IK7fE+BRqRycDVXUevSf358nSnBVXJ6qqDdd3MnErf8liwzaOKwhHJbH
 R7xUoOXZ+5reBIpERWoInx3d4HClKL5k8VOtt2pf2VzPjWlPds/isly0zYjLirqz5dN99n4FDig
 =
X-Google-Smtp-Source: AGHT+IHEUPLRLy5Zhi/tOlT1fxx/dKDNQd6ZqrlTOvuuFgCPtzmXonbnajDLWzXdGi9si5L5B9NYag==
X-Received: by 2002:a05:6a00:44cb:b0:73e:1e21:b653 with SMTP id
 d2e1a72fcca58-740588f2301mr577758b3a.5.1746134696210; 
 Thu, 01 May 2025 14:24:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 54/59] include/user: Convert GUEST_ADDR_MAX to a variable
Date: Thu,  1 May 2025 14:21:08 -0700
Message-ID: <20250501212113.2961531-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Remove GUEST_ADDR_MAX and add guest_addr_max.
Initialize it in *-user/main.c, after reserved_va.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/guest-host.h | 27 +++++++--------------------
 accel/tcg/user-exec.c     |  4 ++--
 bsd-user/main.c           |  8 ++++++++
 linux-user/main.c         |  8 ++++++++
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/user/guest-host.h b/include/user/guest-host.h
index 8d2079bbbb..8e10d36948 100644
--- a/include/user/guest-host.h
+++ b/include/user/guest-host.h
@@ -23,23 +23,11 @@
 extern unsigned long reserved_va;
 
 /*
- * Limit the guest addresses as best we can.
- *
- * When not using -R reserved_va, we cannot really limit the guest
- * to less address space than the host.  For 32-bit guests, this
- * acts as a sanity check that we're not giving the guest an address
- * that it cannot even represent.  For 64-bit guests... the address
- * might not be what the real kernel would give, but it is at least
- * representable in the guest.
- *
- * TODO: Improve address allocation to avoid this problem, and to
- * avoid setting bits at the top of guest addresses that might need
- * to be used for tags.
+ * The last byte of the guest address space.
+ * If reserved_va is non-zero, guest_addr_max matches.
+ * If reserved_va is zero, guest_addr_max equals the full guest space.
  */
-#define GUEST_ADDR_MAX_                                                 \
-    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
-     UINT32_MAX : ~0ul)
-#define GUEST_ADDR_MAX    (reserved_va ? : GUEST_ADDR_MAX_)
+extern unsigned long guest_addr_max;
 
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
@@ -61,17 +49,16 @@ static inline void *g2h(CPUState *cs, abi_ptr x)
 
 static inline bool guest_addr_valid_untagged(abi_ulong x)
 {
-    return x <= GUEST_ADDR_MAX;
+    return x <= guest_addr_max;
 }
 
 static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
 {
-    return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
+    return len - 1 <= guest_addr_max && start <= guest_addr_max - len + 1;
 }
 
 #define h2g_valid(x) \
-    (HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS || \
-     (uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)
+    ((uintptr_t)(x) - guest_base <= guest_addr_max)
 
 #define h2g_nocheck(x) ({ \
     uintptr_t __ret = (uintptr_t)(x) - guest_base; \
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index adc5296ba5..f674fd875e 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -500,7 +500,7 @@ void page_set_flags(vaddr start, vaddr last, int flags)
        guest address space.  If this assert fires, it probably indicates
        a missing call to h2g_valid.  */
     assert(start <= last);
-    assert(last <= GUEST_ADDR_MAX);
+    assert(last <= guest_addr_max);
     /* Only set PAGE_ANON with new mappings. */
     assert(!(flags & PAGE_ANON) || (flags & PAGE_RESET));
     assert_memory_lock();
@@ -621,7 +621,7 @@ vaddr page_find_range_empty(vaddr min, vaddr max, vaddr len, vaddr align)
     vaddr len_m1, align_m1;
 
     assert(min <= max);
-    assert(max <= GUEST_ADDR_MAX);
+    assert(max <= guest_addr_max);
     assert(len != 0);
     assert(is_power_of_2(align));
     assert_memory_lock();
diff --git a/bsd-user/main.c b/bsd-user/main.c
index fa7645a56e..603fc80ba7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -89,6 +89,7 @@ bool have_guest_base;
 #endif
 
 unsigned long reserved_va;
+unsigned long guest_addr_max;
 
 const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
@@ -500,6 +501,13 @@ int main(int argc, char **argv)
         /* MAX_RESERVED_VA + 1 is a large power of 2, so is aligned. */
         reserved_va = max_reserved_va;
     }
+    if (reserved_va != 0) {
+        guest_addr_max = reserved_va;
+    } else if (MIN(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) {
+        guest_addr_max = UINT32_MAX;
+    } else {
+        guest_addr_max = ~0ul;
+    }
 
     if (getenv("QEMU_STRACE")) {
         do_strace = 1;
diff --git a/linux-user/main.c b/linux-user/main.c
index 4af7f49f38..5ac5b55dc6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -122,6 +122,7 @@ static const char *last_log_filename;
 #endif
 
 unsigned long reserved_va;
+unsigned long guest_addr_max;
 
 static void usage(int exitcode);
 
@@ -858,6 +859,13 @@ int main(int argc, char **argv, char **envp)
         /* MAX_RESERVED_VA + 1 is a large power of 2, so is aligned. */
         reserved_va = max_reserved_va;
     }
+    if (reserved_va != 0) {
+        guest_addr_max = reserved_va;
+    } else if (MIN(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) {
+        guest_addr_max = UINT32_MAX;
+    } else {
+        guest_addr_max = ~0ul;
+    }
 
     /*
      * Temporarily disable
-- 
2.43.0



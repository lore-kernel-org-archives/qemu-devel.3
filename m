Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E1BCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lit-0001Tk-Us; Mon, 22 Sep 2025 14:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgS-0006Av-TZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfT-00052O-Gm
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-271d1305ad7so25151945ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567220; x=1759172020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0WgDnjZZbQNGrZHbHxQl5y/Vvc/Dh17BYKXEKy/nEk=;
 b=Pujr9iHemvPdqRroyimuYaHmku7HeEZ+zzRJemeq4+nxVBd1y3hQY2hziBUCm+/MYJ
 UIcMHImHF+fAaI175toEABfjGbUGL5Oqa0Mk7zok/uGQA/qyBNZlmXN5/CEksO2uOmx1
 P2y1n0Mwli405t/SVtEGaP7Kag8vNr8BRvUo/Hx1jAVo54pZkG7/bMCmH2oeZGi+HfvF
 Qs+gx8pnihDwtx1FW3cAULEyXIP110PNN/WdMDCb0EKgx+VaxEk1b3RHA0hkGvHkgZWt
 3R3AVRuWvMA3vhBXMCA+7zKHGTJKmeCxww9wPigeK/Ww6MoJ4pfFwhftO8fkfwNk8SL6
 vhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567220; x=1759172020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0WgDnjZZbQNGrZHbHxQl5y/Vvc/Dh17BYKXEKy/nEk=;
 b=Mvq6E7hliYb4NpbqugB2oC5M5Krl2cVqWO/A//RxgKgUJoxQLXw2DMmhthJRIGr3qJ
 J8SoGpNgQ0fdaNgynYkm3+gy4+4zP1j8mPFyicBJ2DxC8moi2HdtwHzOCwlV0DkWKsf5
 fy8NhU/ScJBYJzyis/YD1IbUpb0kyNliyaxFNZMZ/f9ruCbwMzU3ksMR15TgzZglFsWa
 V+cLxHNhXaP1/Li8KQ+Tq/c0VcXOs7O6e9hVfPauwzC64Ppaiic7xnSPp9wyiDozQZoU
 Pjpak2YzOa5FuWI3MmLn8pQKISCBqSCVdjoG1eRntWSVyThuPqRRBpUqPZyQua5GmstN
 ZJdw==
X-Gm-Message-State: AOJu0Yyt/Ufb+oR/LK/E5LCauAuYEIKEnk6UkHXNHXnTTE7WmcY+0PA+
 y/3szNsl/0QnarwPmV1V2HUQ1wXpTJ+fj90vRF/3fX2BdihtSWt30iy6aPNt1JH01RGc3yAQwjW
 IhzHW
X-Gm-Gg: ASbGncvsgJO6qqTvfXZUvwrZqD3fmWWSSjCXtbuoMGmuIj0aMn9HQ3SshozJhxsIlm8
 QMWAxwCnGLbOACQwwTlMenGDj2Tz5aGB4Bq/cugHpU72EVnOYjvBubGHYLQms6ycSsW6xMShE68
 5WNoMZixA/zD0nMrxstu7Iyo3omkRivWRx5j5mbygzTe/o1QG6vx86HmN3qzD5hTKf8HRur6tkH
 1XXSa7niRtC/5txSOEPU3FLFE/MrVMR5q7DCtigBXqN0Wb67EfgvN1mcGMgiMZKTqoGgXBCWgYg
 EtqMDLHlp88dZb+od4a4CPDLi+OEjUMaeCvIBBV87WoPO3T9xjqF42/v7ccvFsorPMQ4X0O8YCq
 mapaZstz+cAqfOn0jnD8uJhHXXtJI
X-Google-Smtp-Source: AGHT+IF4EkW84NlHRS9A7Hdv6/4ZgD9pLDiwZd+GGljVyMjLKvVpNwPB7LU0GsXgD9Pdv6xqWLO4lQ==
X-Received: by 2002:a17:902:f552:b0:269:b03b:c272 with SMTP id
 d9443c01a7336-269ba55f95fmr207852485ad.52.1758567220075; 
 Mon, 22 Sep 2025 11:53:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 69/76] linux-user/aarch64: Implement map_shadow_stack
 syscall
Date: Mon, 22 Sep 2025 11:49:17 -0700
Message-ID: <20250922184924.2754205-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dfe114ceb3..0a7ce7a262 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6356,6 +6356,12 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SET_SHADOW_STACK_STATUS  75
 # define PR_LOCK_SHADOW_STACK_STATUS 76
 #endif
+#ifndef SHADOW_STACK_SET_TOKEN
+# define SHADOW_STACK_SET_TOKEN  (1u << 0)
+#endif
+#ifndef SHADOW_STACK_SET_MARKER
+# define SHADOW_STACK_SET_MARKER (1u << 1)
+#endif
 
 #include "target_prctl.h"
 
@@ -6571,6 +6577,54 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     }
 }
 
+#ifdef TARGET_AARCH64
+static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
+                                    abi_ulong size, abi_int flags)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    abi_ulong alloc_size;
+
+    if (!cpu_isar_feature(aa64_gcs, cpu)) {
+        return -TARGET_EOPNOTSUPP;
+    }
+    if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER)) {
+        return -TARGET_EINVAL;
+    }
+    if (addr & ~TARGET_PAGE_MASK) {
+        return -TARGET_EINVAL;
+    }
+    if (size == 8 || !QEMU_IS_ALIGNED(size, 8)) {
+        return -TARGET_EINVAL;
+    }
+
+    alloc_size = TARGET_PAGE_ALIGN(size);
+    if (alloc_size < size) {
+        return -TARGET_EOVERFLOW;
+    }
+
+    mmap_lock();
+    addr = gcs_alloc(addr, alloc_size);
+    if (addr != -1) {
+        if (flags & SHADOW_STACK_SET_TOKEN) {
+            abi_ptr cap_ptr = addr + size - 8;
+            uint64_t cap_val;
+
+            if (flags & SHADOW_STACK_SET_MARKER) {
+                /* Leave an extra empty frame at top-of-stack. */
+                cap_ptr -= 8;
+            }
+            cap_val = (cap_ptr & TARGET_PAGE_MASK) | 1;
+            if (put_user_u64(cap_val, cap_ptr)) {
+                /* Allocation succeeded above. */
+                g_assert_not_reached();
+            }
+        }
+    }
+    mmap_unlock();
+    return get_errno(addr);
+}
+#endif
+
 #define NEW_STACK_SIZE 0x40000
 
 
@@ -13945,6 +13999,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return do_riscv_hwprobe(cpu_env, arg1, arg2, arg3, arg4, arg5);
 #endif
 
+#ifdef TARGET_AARCH64
+    case TARGET_NR_map_shadow_stack:
+        return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
+#endif
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         return -TARGET_ENOSYS;
-- 
2.43.0



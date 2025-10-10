Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78729CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cr8-0008KM-0S; Fri, 10 Oct 2025 09:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqh-0007kO-70
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpc-00042m-3b
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso15861585e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101603; x=1760706403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YuKsIKw5s/OEqOqlZsYGM9IcgOL+/aqefHKXe601aPI=;
 b=iIBEJaoUZnMdhiOvnTOoPzX5huPo0CPBjOADfMqTzssVncJNP/JeXsUbJcVYx/pJVY
 g7QlWnTP+MswsFNdv6r+qN6q2IaDaGnE5zay0m5F2enMJpmAKYlirKkYokAMBW6zeyHz
 hsIIunsz/p/W/dOcn+2zdRFPxJdJVtKlciVUJKdHq9hLreyHe8lyfjRjT3LSXxFv3Ngl
 CGAglSnr+Hs/bWeMN0RkSK13gWMA+XZ6Rf//no3YyZi2T8+2QZvFNcmhEkSeArmaJuvM
 of73MAoD8hl12TiQ0xS31+iccc0IdDKfv5JyplNCbxNI58zR6zTddwyMZd0y1mKsLehG
 iakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101603; x=1760706403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuKsIKw5s/OEqOqlZsYGM9IcgOL+/aqefHKXe601aPI=;
 b=Vgf7IzjolYJzl6uJAYlMhQT4jSScUaP68tUuAM9aEktMlhfzmXIhSiNIcLwe6TySXl
 RV/LaF331Rcu76FniWbgYpYPd7NogbjyKeGp2CHqB13lK6XA/60TCWjIkc1EZOjJ7Z/K
 MwHTXciCxdzSjEUpha7ryeou20tB6usuJRWK/FVwpl5v4B+8BmU53Q2dFp9lBJNTePfu
 7Z8U3XmRXifhwgsLUmlsRdV3P6yBwy0h3Y5cVWnyyYmLDIJIA9kqrAH9q7wQ2mchHh/H
 MaV2KbKZ+hFuMAzmAKNttD+VNZ6Zy5PvW4rBlHeXt7H6Zk/jFNCeIwcElYKbgDqVe343
 Xlcg==
X-Gm-Message-State: AOJu0YwglnDgHxeZh8HM5baforACz6bfB02q74517WlQFL9kU/uofjIc
 N+EUkOH90+7p7y2a5EKFd0jr4vsmRo3xpdomSKa6/DoFBGYL3pXrozihbYcAtHa+1Nn4KZbEgAB
 ZGNU7
X-Gm-Gg: ASbGncvRzgGV52NaW7sOdnDEEmYMkigFhgld6Mv/VrBwS2evfJ2er7nbp+YSdLpZEzq
 EWTSqwrXikkdIxPEB9ZAnJLl1FIjgRjpeGqErfEmfK1lBQHgnKBEp0DZWduKma4l0QK8JyVtbJ4
 HYK+8vZpUVO99hGJaoMSkzXuRhTZOpFDr05OCwbcVdSr/BFerStOvLIJfBW5Qd9yQD6Nl3Rca8D
 d62VSPwf3f+vyd4Z4Gk0AIgY3mIj9kuqow5tqnlECYRlUgz/bJS49oYp9gk/oYOXp9BaoVrfFck
 I8+SKCl7JHQXG/QEfsI8fh0EYV5IwUBQ9iJKYj5Bzwj/2TrWfswJEGilgnkCz3zFCOj4wYqsoEb
 b4Sr/XQ3u6ksNNMWKF733bbElOwdplzRCnpJHpMIzE99ueXM0HrZeD4tJn6sgXQ==
X-Google-Smtp-Source: AGHT+IFa14QNhv/00ju2TiIC/BQ6K1KaQiXudoNkG8bo9C6JhsqDkdhB75Yx1kHFRED+8J6tqiGvXA==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id
 5b1f17b1804b1-46fa296e763mr76260845e9.8.1760101603006; 
 Fri, 10 Oct 2025 06:06:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/76] linux-user/aarch64: Implement map_shadow_stack syscall
Date: Fri, 10 Oct 2025 14:05:17 +0100
Message-ID: <20251010130527.3921602-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-67-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 47a6b58cf5e..8546f48a05b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6358,6 +6358,12 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
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
 
@@ -6605,6 +6611,54 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
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
 
 
@@ -14065,6 +14119,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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



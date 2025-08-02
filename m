Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175BBC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLtS-00075w-EA; Sat, 02 Aug 2025 19:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoh-00068r-6e
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:07 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoe-0006TY-8r
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:06 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30b83108f7aso194766fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177943; x=1754782743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0WgDnjZZbQNGrZHbHxQl5y/Vvc/Dh17BYKXEKy/nEk=;
 b=XLNK9DFOGsoL+ETKzxTAt0uFk/g/elcs7d644a2bykN+GD7gngUKyfNiW4AoR/7hZO
 PAirobPNPnc9TN+fG2V+EYNVybRDhggdln1NseOCabf4zfu+pn/W6/J6/OWaL3w3psKD
 RkyyLYEEGtSmi+bv1PXxsFYKeLtHbh+mFTZbzRbO0hBAJVdzclpEUh/bNZqlmSN1Z63Y
 +wPyHnulQtfbB7T1hlGA+FNc5BDEZag488ttjeDwVsavvSEvdkCW+cTVjGQSFeKJz7VB
 VbVXyHsZaXVZ6M5NNhgbewS8T03VC0uciPk3LDYQhYG2P1y92X+ZfJnP5ObAaJLvj+Uf
 Eeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177943; x=1754782743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0WgDnjZZbQNGrZHbHxQl5y/Vvc/Dh17BYKXEKy/nEk=;
 b=q+aDcFF5NTYG+x6LV8SoCWsMkrA6Sx58AzEOrAstHrWzTsA73AdzQ1md61mCW4ogBe
 AlTsKbpu1r97tzZ4vwGMMJbmpsw1RhaZFPXWuKNI+2tL0evjXwBBCZMzmpue/3kYQMRD
 Ri8Xerr91wRqCfVulXWisNEf/C0XpPCcKMfadoo7KWN3xjg5X9GJ7fmii0xFy0qSesZm
 5SYgOGvyAv42JKUwhOHbv8QaBsl3Qq7AsPJwIC0aQuQG6XUmpITD/cHuGQXuGToagX5L
 J7HXhzr59x7OAo+hdtDTPaLwdP6eg0lbblsMhajPmLOoQqRoXW33UvrgeTwb2oKjU4kj
 z3kw==
X-Gm-Message-State: AOJu0Yy2iBiOpQZCtVt5CCLSsBnVi+Ce99p4l8Evd4jMAeszr27OL0DS
 B0fJnHVpw5jlJroMmSJ/jmSCiJDRdXWUjJuw7Z0+DkU8SICP/z4JG1co2dCroVQNv1kGNrljf/w
 10mbluJ4=
X-Gm-Gg: ASbGncviiEtAeSLxyel/0pXGgFwkVrlfvmkXF5AfRoBg5nTSjObL/8Jq8ji0wdl85dD
 6yrBZbQWWt1kkssEfVMQXlWZubfWvlj1YWMZBKyfV25eGP6caaBOFQ2MsvqTJappofJCgATYWmf
 WYi517VvWV6kpoyaMrOCWZEgxRMwdT5D5fDpEgnQwItYhgGlKU2xdTNJA954wztg0mmrAQV4EAB
 PbRVFnODrQAHd/ufcNBCl8kx3n76Yc76nHf8p1riSgxFFgpkkfBBczMpd4/AJ5PRCZglkpC/GB8
 N7s5OKJZ7SlGbJ4LZ7ngPDqS1a0JqIK5aagv1VQalLa1X9+q1acQBKeBi+1nypiNtWsWzv56aRA
 K1m9jbMdnAPNzu3VPR9SlbNq9wrAcq7CsMq+OGvZMdaB+FbJKqy1p
X-Google-Smtp-Source: AGHT+IEGEGmJuSQXKJr3IW7VWVlfBgvkWJqCLESU5QFN8Z83xsCW4qPWXnqDsMWhihuxVbCwsF4OwQ==
X-Received: by 2002:a05:6870:e24e:b0:306:9f1d:da2a with SMTP id
 586e51a60fabf-30b675e5adcmr2628388fac.5.1754177943018; 
 Sat, 02 Aug 2025 16:39:03 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:39:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 77/85] linux-user/aarch64: Implement map_shadow_stack
 syscall
Date: Sun,  3 Aug 2025 09:29:45 +1000
Message-ID: <20250802232953.413294-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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



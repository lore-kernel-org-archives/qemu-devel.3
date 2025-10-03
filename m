Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4407CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jPn-0003hv-7E; Fri, 03 Oct 2025 13:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jLh-0007jG-Jw
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:42 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKD-0007sC-Vo
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:13:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso2191854b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511521; x=1760116321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fg3hYe5ZBoKGCyTXHH7nqIXtFZCRXYZH3UT8M9cUro=;
 b=seQHm9za02npjMODx721BpaooaVi68KrPzmMDW1uTds1tSYcJjh/1GMEsopf1ollpP
 78Ym9GP0q2r98nRszqeK8PEh6YoWgdibJBQbVjeuzYtpjsEhereqCxGRfp1bX8cCWzEE
 1fKDPPLtXTVbyDY+KOD/I9oMIjanwYDrov69WN8Fssubt33GcgBzttP83W/KX/3q2P3v
 OU5rvxI1lRY7F1eftxo19XdsVqQrwpuy9BiBwa3UgtMPfiykj6mJQ++fgA67Zpj1mFYJ
 aaRvVZYSVnYmgWguA4R7wCpBi/iiutw+Gi+5RtTUzHdLF56KOgqmIoBCqMNzG4AX+c+3
 Lb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511521; x=1760116321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fg3hYe5ZBoKGCyTXHH7nqIXtFZCRXYZH3UT8M9cUro=;
 b=AsrCurt3YDwBCrmxeR4TqrkHlRmEWjZ8fPShfuFF9KcmEw6uPXhoL/HcyFid0ZHm+c
 U/s0+gD9tajTNo6roTCpj7Mn/sLtfbFWZHpULzwKQ9ukmbT0Vrs54Phb4iX9X5aIHtAR
 UHvZFxSzyU2A58R4OYcWTtjudMANCdyzCo2frRyJHdrCwDl/384UwaJKNGetmzmSnSIY
 PZGUxTmmHsu7rB2FNCL0C2y/yTPNzrDGLB939LcO3lX98JjogpmoxoH5FaIZtjVH7vhz
 nn2PKD6sXTalVT2KEeY8cKQAA5Bof+uSW+yZE9l6YgJyWoPmu8Mpek12QHEPbMBAWGaq
 ORtA==
X-Gm-Message-State: AOJu0YzWOKowXTlJMuA63R786xrmw6xiCdjNuusqiMW9whfGK9/BNVNj
 z+fkspgSV2GX8ofiq6qHnDLDZdYvypQGDJEzKo8bnfn2J1+bny3ieL4GnkPkAKSPPcFy+Obevub
 /S2bM0eg=
X-Gm-Gg: ASbGncvJPf+SwXxGyUiHlevcuvxB/kmxwpwXJWJOa1LeuKhl3kFuJqY2QlizxqxtPIr
 z8GBZUmlRQDEDSzntWrkVjV6HA36JuTu3un9Ac0PQ2mvTUQ7jWFq9i/qx+xYVe0qrtzSvhjCMEQ
 piEbgdSU3q/acK+1ShV6tF20j1WcfZTlcPdw8V+CuAeRV5JyAk+CGIdGhEMgvLUiDJrsRvuPPoy
 IfgDYTPSZbveeveqGcEAWbmyaTUhoLrAGeJhoPbS6TybA8UvJThIz9WMHoHYYCkRyx0ryfClIfk
 T2ynIJJBVmkQFxBRvQi+CRlIg28yaTenNQJgXRla/y5kBE1RpOrII+UiYQaRIPV5ZxHmgGu5SwP
 RtPimObfZyECCXnQ4I/T3L9qOfz8wu2SbEcq6x78bvFhkUhosVKbMA/ma
X-Google-Smtp-Source: AGHT+IFk+rwWqFlHj4idEdAMaeIZFhM/71k9ClmGdWkeDTKrsXYm2PBAw/W7WVKRAJ/HzXys161CUQ==
X-Received: by 2002:a05:6a00:2d22:b0:781:eaa:9801 with SMTP id
 d2e1a72fcca58-78c98dd9351mr4947724b3a.24.1759511521031; 
 Fri, 03 Oct 2025 10:12:01 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:12:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 66/73] linux-user/aarch64: Implement map_shadow_stack
 syscall
Date: Fri,  3 Oct 2025 10:07:53 -0700
Message-ID: <20251003170800.997167-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39b139b0bf..7ae78d0715 100644
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
 
 
@@ -13976,6 +14030,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD57CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXel-0004XC-Vq; Thu, 14 Aug 2025 09:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXeA-0003YW-8n
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:34 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdw-0005c1-Ca
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e2e89bebaso698284b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176715; x=1755781515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0WgDnjZZbQNGrZHbHxQl5y/Vvc/Dh17BYKXEKy/nEk=;
 b=MXB4OkMT1f22OiEtP+X4ik1vyxe8SWDx9zPFpdmWbsu2lNl1cxOM1XsrRmYQ0mlE0i
 Go5kHHmu3WyLklJcSBxnqFAdjfe/VW4uZ5PZMT0zby1tAYu1X7vPTnTmHy20NSR9CQGR
 dIe0X4JcW2WWnVnOp8Mr/B16AyNEiqu2jdheNpvELfNb7AyRxHDxMQ1FRpeB3FBEr4zM
 Ei54y4Jh2Boxdt6R3nnyHF0Vfd9ANfZivedQjczjUUXNPdjAFmKJ/4hpFxBks0N/rXP+
 HGITiaLgpIqSWeQ6WSJ9xMKL1rj0MXlQ6Bae5mVvYyrVcDXfkZWuEA368yePr4D7Kn8E
 8Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176715; x=1755781515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0WgDnjZZbQNGrZHbHxQl5y/Vvc/Dh17BYKXEKy/nEk=;
 b=dkZH5EcsrYbXgTEOBfGk2+BSW279U1uVbZbePETsw3BNp055jq5BcMz1R1cpA5m49L
 wzdiWtmkJffP3McfOHIWO3ExMYf25sIJBVW7vCSczl5uXlMP7t6tYRKMRRzog/CH3WRC
 /pnaAD45HKSTkGh8NZnY6KBYOU55JKqABuR7nep6lUFLzV3+dslD+6qlb9FH/ZUzTHGK
 uFH/X3eD60WsNOGTTWvuEOmgc6cO56SNaIkYfIdgdcqqMsoudI4fgfPUAmAxSkDnDrW/
 +WWtHgkM+nnHdurSOaBrp/0TSFLb5DLajPsd3vQgQtSySHqm4b69/xTOyK9SzPbBWj+l
 YbUQ==
X-Gm-Message-State: AOJu0YyEzyFvrtkjMrJJHMkBs/fFk7O3qKwehlYHV97INYsbxPzH1aJU
 AFafqiQXD1SqHV8OnmN7LVoBx3MSwoHPNLCx2d+UCLYvqzlnnIT/7dmyXL6LaEFyxRpiRv+tcrB
 eWrFFgXA=
X-Gm-Gg: ASbGncsHEF0ARzAE4DneCqYh8pM/PX7gi/KGAaa/7NthwLYc32CnY0xijpqYMlGTI1e
 3btfMgn1ptChyOhXIYvNduHR1lsl6CXk9g/sZl/v8ES0NMyiaKMZng3W27I7v6gkpg4D58z6vvX
 5jgsVZ/M3Hpg07jzp/oZvWGbPNueNITMPtYeMpb/wyaarrYEMgqfWAAonBssiU4lZkU3W8Op76/
 DSBU5p8QZpXGUqch3NGTUFixErHZrHbw6UgQC/64ZhzGg6DvSoEv9+L1D6y3cfcpVRFoSaMtkPZ
 6GWN9lXwjzs6PzKuuIArIKd48lz9FrdmeClr/26wr/hKfqImZFvsgccxfsgC6gX8mWzfJIq2Vef
 R6w0ZIBjJ1u0ef37do84A3p2Pnd4MxiIdpdaRtEOAzV76ki8=
X-Google-Smtp-Source: AGHT+IFfO9vl4AwAbosB3xXp1RewKyiDguAhLwyKrcGPiQ51KSA0BbQ1pNvVS49hhtDh9IXpitPncg==
X-Received: by 2002:a05:6a20:3949:b0:240:356:f033 with SMTP id
 adf61e73a8af0-240bcfc8202mr4423678637.16.1755176714753; 
 Thu, 14 Aug 2025 06:05:14 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:05:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 77/85] linux-user/aarch64: Implement map_shadow_stack
 syscall
Date: Thu, 14 Aug 2025 22:57:44 +1000
Message-ID: <20250814125752.164107-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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



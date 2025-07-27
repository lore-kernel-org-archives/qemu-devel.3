Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854D5C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwSm-0007zW-50; Sun, 27 Jul 2025 04:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPq-0004R5-GG
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPn-0004uH-9d
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:30 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-236470b2dceso29632255ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603646; x=1754208446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1XaTPiEo+FTtf/Cktl+jdbCdlFK1FMOPPILBOSb6P0=;
 b=ORh6DisLjiAx2zW6SdEJExcqZ5Lh4TSj/n+atRZEy9gPF1BTi8LUYKVUZBUZl0GmVA
 kDnswrvX/65TCyT5k3y9m9piDR6ARWRzn69V6MIl5oqbsSvQ9qetrQMQDZmvuRbR7HY1
 iODyepVcgBUUgJckCsAoSuOE0LW1n6Q4Jj2edohhiJUNeY23/cN6zBLhoO6by4r0o0bm
 dqy4kL+zExw9OHt9X1Lay7PguzG9/wcKraDOm8FMn9+fZnkAfH6MGUSehcKKhEcDqh1c
 O5P8gGhypMtOb6McQQOtDbf1Vi9MSZzn9pP825i2XH49VyoIJdQ3JQSlFuLooF6xNUZI
 6eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603646; x=1754208446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1XaTPiEo+FTtf/Cktl+jdbCdlFK1FMOPPILBOSb6P0=;
 b=p8nQYsd1uVcWAvgp9lKiSQY/OdL7sivKBOBSp22xRj9HYGvNJIpYfdXYDATONbK4jd
 xqOuKrsW6yoXorbWGtpHd+S3qV6mRIenKFOfcDhBt5DXEakGrvwqc0h7QNdo0UjXkyDm
 S1/lonnsTdDNbLghj7qiD9f0yj9PtxpLBPem7ajjkWGibzMOpHn6Z/jbtifhTCHR5E2l
 ET0KYOV2UqWpODRxrTa+nZxU4vQrVEDMhz3aPe2m8sEoP/tUnk8g8DVk+1e3Fzmc0v33
 iNqa0QYFkCunKUd67Zm/qdM5kOGWbPwxbenox0LVJKO3ecjLao+MrZudGaGSGJF8x1Iq
 HT8g==
X-Gm-Message-State: AOJu0Yx7mh5V+DPGkrdYdWIPicdCOVOjrAzOiCCiBG1xdpGN95tjLZw6
 dgW84SDn9+Uco56nWH/4aF2pNPQU5ZfSSuF9nm2yIop7TcTe5KygEM7QQ2gdnDvuQxcnM6qZg2F
 uwFwU
X-Gm-Gg: ASbGncsaOIPaw7HGuxxsUwINYKZjad/mWQEb5cUdrVeTaGZ9K4bRbIGfyoi6B70HNQT
 E2BKSdUjb4KODkqDZd17L3X9ORbcA1aqaAJtNC4bq81x41G/StQyRLdizbjqH4n90/jAcf9hDL2
 1QzmSsRXjuDP7JihoN08GfBJKtDTfOYXFVvkq4KP4h3JaVvY23LlXftUmI+wASEAgAtYtq1l59g
 xLZTP1UuBmUyHiUbtWmfn2+6YHZuMSuxv2HECkZQC26W4doYoW6NAYsk/6B9FiFf04Em8RRZN7z
 ISumeORCgF6OUC79y8likNSzN423lgPR35pY/qVswHZQx0R/EDy22RojPdUAoYpCKYn4TGBx6K6
 MCYzHhU1eO1Q3KEchI7gXuvwl6DzY133ZsisUjxm/QiGOJaqvdsHonApZklyiF1LfrRRqFb/Naj
 GGC7sHGvyI7g==
X-Google-Smtp-Source: AGHT+IEkvi39PvKm1sNYDnna/cpO78Zsm8uiyQFmothKzox3JMiUh91wKtiGEbNTGZJZnTvaDAmwHA==
X-Received: by 2002:a17:902:fc84:b0:23f:e51b:2189 with SMTP id
 d9443c01a7336-23fe51b27dcmr49777135ad.17.1753603645855; 
 Sun, 27 Jul 2025 01:07:25 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 74/82] linux-user/aarch64: Implement map_shadow_stack syscall
Date: Sat, 26 Jul 2025 22:02:46 -1000
Message-ID: <20250727080254.83840-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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



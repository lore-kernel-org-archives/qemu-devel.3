Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C54CF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pT-00078O-Dt; Sun, 13 Oct 2024 18:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pR-00077w-NU
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:45 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pQ-0000uH-2M
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:45 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so1785551a91.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857563; x=1729462363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpiQ0uRviqHvIpHCmWWiDcmFLJXAKpr3mqpGqdFoplg=;
 b=G86hBLNpYpnqMRtqHvlKnQ//HyKlqxG/3z9vmFE5wy6nZMVeYqKlbUt6+ddasW+qiG
 9V0uqDomRnPSRwILdaO5nEjQUufoapRkTJ4lYSjHg/11b+pW/U+WLDVQHTI5uYW1v8W3
 ORM3T+iQii4iY5D5aQd+i7jxPXvuPrlh1Iy5E5RLvnFrCkfAuvYOlny/C7CXUOMqPFNu
 NNBDKvqqmuOy91f+23nrzeA3zZCcuOq4U3opSuE4kC1jEN8USnEEEUI6urTSYzE+sFbR
 hPHcRJhW6fAzhY/xbmF33ZKgfyKDRa4rvH/+AuU3f1nw54/VLCW7dgHWNX7IUHfJYxbA
 5ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857563; x=1729462363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VpiQ0uRviqHvIpHCmWWiDcmFLJXAKpr3mqpGqdFoplg=;
 b=C0Hgg+gTkURi1gB9cq4Kwe/oeA6Ru5S/qXuRqP6b9hU+YOm6hOQHpXTaIBFPSPBnHX
 ZdjMWowzrf1PKVJBhMFCFeEkuE8uYzBGUr8VdQKDFg3LzIquw5JYsOvfRbt0yviSaOR+
 iVlpLHUz9bzQNMroGezFn2NxbmE6bnR20zhvkN0orgP4kzNtULTte/ls/4uRS8u5kL8F
 6o7tNYkW4yTt5QiQ2pXhHGcEkhuB/G3YK5zsKbcPuzdYVxI60BSQNBfasGuJaJ8KNGxT
 1JtIsJW3xaXQriLvYNQYavL0chCNgl1/R2PGhmHJPSG488f43SQqIBokZrTJcLThFLgx
 VSHg==
X-Gm-Message-State: AOJu0Yx42U+Silbk9EYq1gu8w5/z4eAzKF/noBwg4KcodQS+r/SVVX8u
 PG2KE1Z7FYfJ/LvW5cp2L6JCKAkl08xEXr+oYw7idm9MVKxylNg4omZ2cm7uPX8UHLB2IXb5jo3
 w
X-Google-Smtp-Source: AGHT+IHvYIIJ1ucmCyt6EFJnUaMwH4fYafR4/sOHH3qTlUisimDefrvul389alAQeWksbl5X+tWZng==
X-Received: by 2002:a17:90b:4a89:b0:2e2:d33b:cc with SMTP id
 98e67ed59e1d1-2e3152e76admr8643704a91.21.1728857562747; 
 Sun, 13 Oct 2024 15:12:42 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 07/27] linux-user/vm86: Fix compilation with Clang
Date: Sun, 13 Oct 2024 15:12:15 -0700
Message-ID: <20241013221235.1585193-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

From: Thomas Huth <thuth@redhat.com>

Since commit 95b9c27c81 ("linux-user: Remove unused handle_vm86_fault")
a bunch of other "static inline" function are now unused, too. Clang
warns about such unused "static inline" functions in .c files, so the
build currently breaks when compiling with "--enable-werror". Remove
the unused functions to get it going again.

Fixes: 95b9c27c81 ("linux-user: Remove unused handle_vm86_fault")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20241011161845.417342-1-thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/vm86.c | 65 -----------------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 31a2d707cf..5091d53fb8 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -47,30 +47,6 @@ static inline void vm_putw(CPUX86State *env, uint32_t segptr,
     cpu_stw_data(env, segptr + (reg16 & 0xffff), val);
 }
 
-static inline void vm_putl(CPUX86State *env, uint32_t segptr,
-                           unsigned int reg16, unsigned int val)
-{
-    cpu_stl_data(env, segptr + (reg16 & 0xffff), val);
-}
-
-static inline unsigned int vm_getb(CPUX86State *env,
-                                   uint32_t segptr, unsigned int reg16)
-{
-    return cpu_ldub_data(env, segptr + (reg16 & 0xffff));
-}
-
-static inline unsigned int vm_getw(CPUX86State *env,
-                                   uint32_t segptr, unsigned int reg16)
-{
-    return cpu_lduw_data(env, segptr + (reg16 & 0xffff));
-}
-
-static inline unsigned int vm_getl(CPUX86State *env,
-                                   uint32_t segptr, unsigned int reg16)
-{
-    return cpu_ldl_data(env, segptr + (reg16 & 0xffff));
-}
-
 void save_v86_state(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -131,19 +107,6 @@ static inline void return_to_32bit(CPUX86State *env, int retval)
     env->regs[R_EAX] = retval;
 }
 
-static inline int set_IF(CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-
-    ts->v86flags |= VIF_MASK;
-    if (ts->v86flags & VIP_MASK) {
-        return_to_32bit(env, TARGET_VM86_STI);
-        return 1;
-    }
-    return 0;
-}
-
 static inline void clear_IF(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -162,34 +125,6 @@ static inline void clear_AC(CPUX86State *env)
     env->eflags &= ~AC_MASK;
 }
 
-static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-
-    set_flags(ts->v86flags, eflags, ts->v86mask);
-    set_flags(env->eflags, eflags, SAFE_MASK);
-    if (eflags & IF_MASK)
-        return set_IF(env);
-    else
-        clear_IF(env);
-    return 0;
-}
-
-static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-
-    set_flags(ts->v86flags, flags, ts->v86mask & 0xffff);
-    set_flags(env->eflags, flags, SAFE_MASK);
-    if (flags & IF_MASK)
-        return set_IF(env);
-    else
-        clear_IF(env);
-    return 0;
-}
-
 static inline unsigned int get_vflags(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.43.0



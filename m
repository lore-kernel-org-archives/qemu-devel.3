Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BD2D75E5B
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 15:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tErjB-00025J-Q2; Sat, 23 Nov 2024 10:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tErj9-00024W-8v
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 10:07:15 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tErj7-0004qK-NE
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 10:07:15 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-296b0d23303so1570203fac.2
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732374432; x=1732979232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlzoEerYr1QXo4i48LqayXX7/GK/4llQjkrQzRbzFKU=;
 b=FW9wThUNKfWRM/P/v5TXjxI/ZtRjnH+DIkmRAPDJyNTBRPqpFZUIbFwDeg1AZ+w5A5
 O1IXHvr6t2v9ItY/VdjI7gaWYddY+D1wNQNHwAaDoZhkP5mrFmhyfxzWlAwyKPHwbcws
 MY0HRbzCOWiiRU/mip+oJosfAmD/0p9fqqVoR6eJL25rX+4zg4RGC+Ac+UE+1ktFPxYC
 tDOLK7WDjjp3aifKZTL6fWxmVfNp8Hn79hx1yO+zRz9y1bRR9efOIwgqfw4W6rdjI0id
 pvb+HcxX71rQcLvyMZWTF/ExU/WKgsgGSPje+bB+LOnXmUvrJGo48jr3jFc7eU/bdRVs
 506Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732374432; x=1732979232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlzoEerYr1QXo4i48LqayXX7/GK/4llQjkrQzRbzFKU=;
 b=GuPEAe3GlKUal+Xtp1u0KfveiT/UztDqgdZ7+BwluWIXL1qUGFMiMZwud5f5w79zyi
 XXoK5ItGsAaPlli+qgDnw4D54yFKhGYd7DNsFnT10Kz+PVaIxjxtlsQxjdF0VV/Fr1Bd
 l9iMhC3Am/2RmSPOqyclgmj0Elu04O/E1z20HBBQxhjM47yBxIDTC/IxCLQSV6vwzX3o
 L1W2gRpgtwm3d6sIEHjv3fZuEXLxa4XcTEjqV4CceRP6hZEu1n0xGQBBYHPdSpxZTgZU
 0nfsdXnXVKDbCR91Sjiw2hGXZkRCHFqSzUosu8hcjLLa0+CAUptnmnmUsbQ0bJte1Cl9
 WGjA==
X-Gm-Message-State: AOJu0YwDdn0+turd89czXQM0m5g7m32ac79GH8hSEiHU6tphxz5cEhvz
 z6mgkT8yE2E3WIaYeQUaFFo/oM148aO5IccDOIDHMEHn2n4XtGRv+9qOMxSuPfd72yuc/tn3Zxp
 ECeY=
X-Gm-Gg: ASbGncufflolQg40ntrGd5N6+tSKt0dtK6dCP7DY13TvSLc5R/CiaPyYDWMK4dCmSAx
 LVsPq41fw1/9mPUl5b8mGRu8EVM8yxjJisfsri5ogrDoFjkgXtrw6mu/fC/ssTbkyvi2cWOhdSP
 7jQNy0D7Aenz2W8+rwIN9yHQhM+wHsCebqEtqbgcN29tcCjkxg/2RzHjE8qbUzNN0LibzI1p5hk
 pIGXxYk97p+f7rFK1qgx2Khzmuia47UQaACC0nkmNOPfHNXDEqDZBqxLQ==
X-Google-Smtp-Source: AGHT+IFzP6O0Y1HVuWABaN6NTb37r8GT8dGypUOEIQB8q57J23Q1AHlxgw1Gy+CArb8mVW4OtXE34g==
X-Received: by 2002:a05:6870:5a9b:b0:297:2643:fa25 with SMTP id
 586e51a60fabf-2972644cd34mr4901809fac.26.1732374432021; 
 Sat, 23 Nov 2024 07:07:12 -0800 (PST)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d82291fsm1396390fac.33.2024.11.23.07.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 07:07:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	qemu-stable@nongnu.org
Subject: [PULL 2/2] linux-user: Fix strace output for s390x mmap()
Date: Sat, 23 Nov 2024 09:07:06 -0600
Message-ID: <20241123150706.19740-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241123150706.19740-1-richard.henderson@linaro.org>
References: <20241123150706.19740-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

print_mmap() assumes that mmap() receives arguments via memory if
mmap2() is present. s390x (as opposed to s390) does not fit this
pattern: it does not have mmap2(), but mmap() still receives arguments
via memory.

Fix by sharing the detection logic between syscall.c and strace.c.

Cc: qemu-stable@nongnu.org
Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20241120212717.246186-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 7 +++++++
 linux-user/strace.c       | 2 +-
 linux-user/syscall.c      | 5 +----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0e08dfae3e..faad9147c9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2766,4 +2766,11 @@ struct target_open_how_ver0 {
 #define RESOLVE_NO_SYMLINKS     0x04
 #endif
 
+#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
+    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
+    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
+    defined(TARGET_S390X)
+#define TARGET_ARCH_WANT_SYS_OLD_MMAP
+#endif
+
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index f68c5cdc44..3b744ccd4a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
 {
     return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
                            arg4, arg5,
-#if defined(TARGET_NR_mmap2)
+#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
                             true
 #else
                             false
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0279f23576..1ce4c79784 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10588,10 +10588,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 #ifdef TARGET_NR_mmap
     case TARGET_NR_mmap:
-#if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
-    (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
-    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) \
-    || defined(TARGET_S390X)
+#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
         {
             abi_ulong *v;
             abi_ulong v1, v2, v3, v4, v5, v6;
-- 
2.43.0



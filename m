Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68FAD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 20:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3P8-0007VX-AB; Fri, 15 Nov 2024 15:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P5-0007U2-4Z
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:55 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P3-0004M4-99
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:54 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ea0f91d381so57714a91.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704332; x=1732309132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IefchHLUObrdReiKezDwvf7im5w8O51AN5OkZQmzJ08=;
 b=CoNftJ7QhOgSBwunaGQ4fNfpun+k9w/yh4yNaKe0rOwSZi5wFeUWi0xCYL6aThu+9o
 pSKBsQHX9IRzfyWy0c84Q4mPte606+8ZlssYM+507H3dG6wYLlENTEORqDhRA5Qwc0VH
 n5DDGXECJMCU4c83QbOTixckYTLcaPqLe/gs7K8Qov7p4U9I1m1SYszgFlatPE3ETu2L
 9jda/cfemuuiX92xe42zHFH5GzsWXOa1LCgtv27Go5eWyuPDDh/iLbFEeW59o4URCOnL
 UHFccIhqBe8YQxlHqyWCnhqw0KoFoGf8QvT7JdUxyTijSjSd3d9Z0N8TDXHM/IHBGh+Q
 isCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704332; x=1732309132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IefchHLUObrdReiKezDwvf7im5w8O51AN5OkZQmzJ08=;
 b=wehsNO3P/IUp+jElAzlZFUNmSLiQ5+CmFEb7AEItadkKsIe61tvHYOWdZH2EhUCGu6
 tuMy/DKnSb0MVzvIjEtpyByiRRHqGwxmZQct+bI+lRPg0pfm2qIkbNNesDMCaMu56GTJ
 a6JMII3KDOTxL86PwT3Pc5gNdZ37+x5iZzfBLgV1lzguzfXwk/nYsNtOZ2+x6S0atCCY
 QLhQS+MnIXrNeVXfWGDAdsQTJN4iZHPLUMgJhsJ6IzUPaHF/ocyPPPYgDWbEfCod5uQE
 qTw9vk/8FCnO1jWrzae58fpBtGbW2ykNQtjoJLN19ypwqnLLdYBpvFq1c0NqHost4fcb
 XjdQ==
X-Gm-Message-State: AOJu0YwVb7bAKaJ1hMxpbIAuf/u2512we8ypP69n+0quISr9QBf6+2/J
 ANF1oCd2owJLeZEGsSH0Hm5+rl4HZnLBjE+TH2INlhiAGmWwsnY9pCnOgCOIG/vm3wUsUcAw65+
 n
X-Google-Smtp-Source: AGHT+IFHx7sIjbr4ApO0qtgF2eY/po5ggleeYSrk/CM4h+lI7xYr5xavt+RFNzCE23dD/KEbmuzUtg==
X-Received: by 2002:a17:90b:4ecd:b0:2e2:cd5e:7eef with SMTP id
 98e67ed59e1d1-2ea15585ba3mr4287368a91.27.1731704331827; 
 Fri, 15 Nov 2024 12:58:51 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@kernel.org>, qemu-stable@nongnu.org,
 Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 01/14] linux-user: Fix setreuid and setregid to use direct
 syscalls
Date: Fri, 15 Nov 2024 12:58:36 -0800
Message-ID: <20241115205849.266094-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Helge Deller <deller@kernel.org>

The commit fd6f7798ac30 ("linux-user: Use direct syscalls for setuid(),
etc") added direct syscall wrappers for setuid(), setgid(), etc since the
system calls have different semantics than the libc functions.

Add and use the corresponding wrappers for setreuid and setregid which
were missed in that commit.

This fixes the build of the debian package of the uid_wrapper library
(https://cwrap.org/uid_wrapper.html) when running linux-user.

Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <Zyo2jMKqq8hG8Pkz@p100>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 59b2080b98..0279f23576 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7233,12 +7233,24 @@ static inline int tswapid(int id)
 #else
 #define __NR_sys_setgroups __NR_setgroups
 #endif
+#ifdef __NR_sys_setreuid32
+#define __NR_sys_setreuid __NR_setreuid32
+#else
+#define __NR_sys_setreuid __NR_setreuid
+#endif
+#ifdef __NR_sys_setregid32
+#define __NR_sys_setregid __NR_setregid32
+#else
+#define __NR_sys_setregid __NR_setregid
+#endif
 
 _syscall1(int, sys_setuid, uid_t, uid)
 _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
 _syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
+_syscall2(int, sys_setreuid, uid_t, ruid, uid_t, euid);
+_syscall2(int, sys_setregid, gid_t, rgid, gid_t, egid);
 
 void syscall_init(void)
 {
@@ -11932,9 +11944,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return get_errno(high2lowgid(getegid()));
 #endif
     case TARGET_NR_setreuid:
-        return get_errno(setreuid(low2highuid(arg1), low2highuid(arg2)));
+        return get_errno(sys_setreuid(low2highuid(arg1), low2highuid(arg2)));
     case TARGET_NR_setregid:
-        return get_errno(setregid(low2highgid(arg1), low2highgid(arg2)));
+        return get_errno(sys_setregid(low2highgid(arg1), low2highgid(arg2)));
     case TARGET_NR_getgroups:
         { /* the same code as for TARGET_NR_getgroups32 */
             int gidsetsize = arg1;
@@ -12264,11 +12276,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_setreuid32
     case TARGET_NR_setreuid32:
-        return get_errno(setreuid(arg1, arg2));
+        return get_errno(sys_setreuid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_setregid32
     case TARGET_NR_setregid32:
-        return get_errno(setregid(arg1, arg2));
+        return get_errno(sys_setregid(arg1, arg2));
 #endif
 #ifdef TARGET_NR_getgroups32
     case TARGET_NR_getgroups32:
-- 
2.43.0



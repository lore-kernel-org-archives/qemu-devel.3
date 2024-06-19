Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA162C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pk-0002Nr-PM; Wed, 19 Jun 2024 17:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pi-0002Lu-Df
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pg-0000jK-Lc
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f44b594deeso1815165ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830815; x=1719435615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SDNjdEkTqvqZmekms95ys+/GW3YEsb5HtHOIrwzGFc=;
 b=ikZHgM/rWxdhby3f+G9r9wK03T2EXP902AVvaZAzoTFTTbAPhk7bSnLDz8lGVw4Zk0
 HooAv3VvguuYyLuVuqM0QQfdhXIiWCknH8qktNl5hUAag9dbg8QS2bkzaRx8mFd0axFv
 O9tC0yWyDOZb/5zgMWA16X1jjrHqJOi5d9EByxRB047hIhB+xTVOfkxmgAIl8TDB9ZSt
 PvOSllYJZtEhLlCfL+OlgCt16PW6jikv5mOdCasVkc4yxG86iFN+V5Rc8y0lLSwvtG08
 +9qmzAy0rPMHcV0Pm5NzVPyEs7YDQNSZEISF1QA1enHAED6E6v02DvsEU3T4mxwOL5oV
 jg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830815; x=1719435615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SDNjdEkTqvqZmekms95ys+/GW3YEsb5HtHOIrwzGFc=;
 b=eA98S0ZX3FeUOl9+C007iEq0g4O7Wxe3H1FLgwCdgiNk+RtfNR087vhx+pCoQt4w0y
 5Q1Awc1w7zOC/inUjASIYI470dRQBNPKSfK3cIpsZ1Rv6vABTsGMD26xVaXnMG1U14Ys
 tZ3QBdx0qh3JGv2UEfXySRBJ9A+/v3LsPTbPRjYe8ANze/YZefwkzyPZXQAn6OdvKQ6f
 HmuBj2CKEHuGGkH38ahJLCEsjI3OXfOBnrWwtWYJibrU+n8DFDlbze93Qg98IHajUymn
 qwHs/J9y8nGzGnZNeSaj6qGw1mvkMFvdvn2IHV4b0COFempTn638lI8Xvd2TyR5o+Qhd
 X5Iw==
X-Gm-Message-State: AOJu0YwDDXEcoAtVThTvGJ/mbgFcgbI0uBwQ4KtF1n27956QiUK1ij/j
 Hb0tsRCVZr0F2U34PvkuS8/klzPjmxch2s8I3K3l/vQ+tV0xdUeHQ+vuu9K9a6IH3+aSakznp5B
 p
X-Google-Smtp-Source: AGHT+IEt7vg2zXSLcYT77RvKKVM5+GVigK52UQ2JgkqcrNEYyfxGwdjKmoJotdtwYtzc7h57bbusVg==
X-Received: by 2002:a17:902:d581:b0:1f9:93fe:a1ea with SMTP id
 d9443c01a7336-1f9aa4335cbmr40059525ad.35.1718830814139; 
 Wed, 19 Jun 2024 14:00:14 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/24] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
Date: Wed, 19 Jun 2024 13:59:50 -0700
Message-Id: <20240619205952.235946-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
calling thread, and not the entire process. Therefore, implement it
using a syscall, and not a libc call.

Cc: qemu-stable@nongnu.org
Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240614154710.1078766-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9b5a387b3..e2804312fc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7209,11 +7209,17 @@ static inline int tswapid(int id)
 #else
 #define __NR_sys_setresgid __NR_setresgid
 #endif
+#ifdef __NR_setgroups32
+#define __NR_sys_setgroups __NR_setgroups32
+#else
+#define __NR_sys_setgroups __NR_setgroups
+#endif
 
 _syscall1(int, sys_setuid, uid_t, uid)
 _syscall1(int, sys_setgid, gid_t, gid)
 _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
+_syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
 
 void syscall_init(void)
 {
@@ -11891,7 +11897,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 unlock_user(target_grouplist, arg2,
                             gidsetsize * sizeof(target_id));
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
     case TARGET_NR_fchown:
         return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(arg3)));
@@ -12227,7 +12233,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
                 unlock_user(target_grouplist, arg2, 0);
             }
-            return get_errno(setgroups(gidsetsize, grouplist));
+            return get_errno(sys_setgroups(gidsetsize, grouplist));
         }
 #endif
 #ifdef TARGET_NR_fchown32
-- 
2.34.1



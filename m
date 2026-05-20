Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EDECD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfA0-0007u7-WB; Wed, 20 May 2026 07:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf9o-0007oZ-U1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf9n-0005MQ-4n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:12 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44a14580111so3475581f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276729; x=1779881529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfLMAKm0cFQ1CO5b899F9cGVNdd+gP0hQK4cGU9J1eo=;
 b=H4KBR6C43DisGAU9jIBYDyXUDkxeR3CA+LXPpTShesIS4tjMrmtL8wfQvbElI5RPvY
 +YZlDvSIeCWskq6WJ+ONagOXVY9ajZ948yW1Cb7NYHSM9UPKA1PzHtt5cMdzEZyLVghl
 gfpTqlzNwF1JngHqFFhg6xGP6xvPZUlQWoN464526T2DQ8G1q93pjlFxrZwdsjIWZgS0
 iUnzZmEvoQIH6Q/SZMpwEeZ/nPZ6vJ3QVKRoQgNL3M/LDfbpEzVS9hSYul99EQr3Fn1o
 iyVWHfw4P1hdrkx2kVcK7aGwsCOtM9E7TnGsX4BQAWXBBcIstubbqOzLLpDokyobpJ39
 pXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276729; x=1779881529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfLMAKm0cFQ1CO5b899F9cGVNdd+gP0hQK4cGU9J1eo=;
 b=Cgs1ExMzsCvt7FyqP+mr/2DgsEgLTLTF5B/765bNeEDsf8WWaOG7jqUd5e3W5dJRwi
 6Do8qShOGN0n2vjYksAAUN4cQd5MeAymvP0v+/VjEVmzhnphBW+ZjZSczf9ThA5rGMf4
 7enNeb8IsMxxuMc0K/42lRkudEvV58LbGT1qWiOOaHTmKWyBzs7Y/0762Gh2o2bllwft
 SgCKLlxQUmMAl06V0pZloVLCxTEnU/Q/ZjwDln8b4oqmFqzaIKW65jbM2aYUBRyqI5Pc
 GVN5g6NhHu5ZuCwJHMk1E/fsnhm4lamnpR5j0XHvMyGyiobSF6Y+X3pf/zHovRSyWxuB
 CRpQ==
X-Gm-Message-State: AOJu0YyJQ4Rzr8mXkhYh/UhR0r70QzNHWSIhXZhpqRxaIZFB4rNR4It0
 0i0NF7/oDsgkmopyhbyOlmfQkYRM5OgTZJHdby9Lvzs4po+uXcFBFt1UXlXUjKGvfPyyxtPN2cw
 2QIxktmw=
X-Gm-Gg: Acq92OGR1Cnrk2FRittJt3TNcI6PobKit8C+UD9wZzPI5jsQDc3D6R/brA1bSBPEZkW
 HaYXXBbID7TPTtr64eFl7Dosp/7uvIdlt8qNrcOyJjuW8ZG9qNFpjhBTMKI8VbOIWKCIp0HBCgP
 w3dfWG5OUH8cAqRodGxOyn9HJ37cYTKjHBQg5fjb96D13oWNuQDjxJEa+vx9xhatiMFbRLPHG+d
 4/FifIP0TBGSFLKQSGCV9s/lBTxJngJwI7C6O6QjgYq4Y7jjVwzmCsZXwNU8ebsDofRJQ1KgG6G
 YYVDtOD6ttv+yVZAM1+5BFibAoXpp408x4BD5gNsnkwUY7li0R7y41LtbDFP/Y6a9C7uPxkqXcS
 CUBujWIUu+cpFyvTcBsAsWMxRUzQ/8KEVgXONlFQB/uRbB1NC7yHfFMHDTCP8jDHQr46ja6yLYN
 CtJikKwj6T8aeyam4yTIvCl3PFI/ScsSwM+cM7fqlivUj99Vb2KyPtFE/PICNFUmAhs1hDLSzRQ
 UNPSW+rpEHG4Fcv
X-Received: by 2002:a05:6000:2c07:b0:45e:75c5:1a6a with SMTP id
 ffacd0b85a97d-45e75c51b5emr23937852f8f.33.1779272298595; 
 Wed, 20 May 2026 03:18:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm52092626f8f.30.2026.05.20.03.18.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:18:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v11 01/24] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
Date: Wed, 20 May 2026 12:17:42 +0200
Message-ID: <20260520101807.9971-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7c..3f36c1695a5 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b6..20ea7c6ab9b 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2d4a8aa182b..5a8e00337a0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6630,6 +6630,19 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
     }
 }
 
+#ifdef TARGET_NR_sysmips
+static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
+                           abi_long arg2)
+{
+    switch (cmd) {
+    case TARGET_SYSMIPS_FLUSH_CACHE:
+        return 0;
+    default:
+        return -TARGET_EINVAL;
+    }
+}
+#endif
+
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
 {
@@ -12110,6 +12123,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_prctl:
         return do_prctl(cpu_env, arg1, arg2, arg3, arg4, arg5);
         break;
+#ifdef TARGET_NR_sysmips
+    case TARGET_NR_sysmips:
+        return do_sysmips(cpu_env, arg1, arg2, arg3);
+#endif
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
         return do_arch_prctl(cpu_env, arg1, arg2);
-- 
2.53.0



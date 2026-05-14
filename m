Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFDBCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa1T-0000vq-V0; Thu, 14 May 2026 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0h-0000og-VP
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:15 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0S-0003nB-Rd
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:37:58 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-439e43d16bdso1245080fac.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780273; x=1779385073; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=ljJTeREjlJs+cSqcPoUxI1mHBnTR+2SxJvOWCPDyrrd8SdgVU0QAG9nGKEGG55+1ZZ
 b7fEiExzgJHxs/tAY2OBefHKvTo0QW/oR4NkcCGRRPRDA3Y7r6Odfu7hGAGoVsIsa3RS
 ovSWU44OaCIHZ9bvxeglK5xHtW86SgeJXinqFnr2zlXb+RH0mj0HjF2lOnW7Q/qXW9WX
 njT5FJIlfucrcfgDlc/oXPx34rNOXOLqlm+4OBGCUxihaD9Y1u17YxjvfljN7oabkSHG
 ZEMjkNnsbu+M69lJpAqTvpZPKDbIJQqFtXfIqJCj507apXdvxxAeVeJyuK/X4GrjrtJh
 s4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780273; x=1779385073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=bOhbW5FkhPZpvdOiUQHC/kbCgSUHDaVHIWuiyZO1aiMmCKGNdVwilybQlT2X9WIjuJ
 cr9gelb3iLqmgntODWdW2/2b+iXTi3zx6WEkyQ/RGQV/wuBKbSdImr0brmSnzkQGm2on
 Q9/Ex4npKyhTZdIGTE0CYdVmDIkdghrXR9gQTdn06EhEcaoRqg5xmpyyvrrGOeQmgSJU
 ixd7gN9OyxMnRTsoqru6K7M7jcu3iRjFU0wICUKGlMb83Y3xq8U130WsBFQFP/XHnv+G
 glzYqcCZvVAdS7kAL6obxFir9yd1OM+jPjuWHYSSqFF145G1mOmcjS+lU3VtRrc7qssw
 oPZg==
X-Gm-Message-State: AOJu0YxJUDdj92oZeaoXYjDOhkE97RoGyd5CHaFHYGAnWAXtpY07qwe3
 CHe8hp3vJMZGJHqqoldu0H0+BA1eADkWC/Ex78mnDdcZLoF+kbdvvbrW
X-Gm-Gg: Acq92OEOwbsit9OpUULbTNV4+8G6tsEEvHlSpQGjYqKLEoIVfO1xCMXCaM/VE27Bk/z
 vzZcbBNRwis105KKrL07LxsmjjRLOZVag7xisaWKj2ooa0DgdVGZPTXFr1wjhSxgTrs3I6WuJhL
 nap24FQBFBhW0SjeeM1QJGaEl1AXbut3A09hTxcnvZijdrvA401fjYbLbNzi6MQyNxg56Zdz2Io
 OCtoyrw6gBeTJPjAt/fgC6OmnQnbJhbgcipqmSB8VTsuCqtOrIeCCTk8vHVWvNuHg91dMscoxY/
 QdFGBv0ffJsiyWraYUWIEUYaVNgWFzrd0buwkTuM/BlMLDEC8V9cccMEHTznmDV0gSvXoZdl5fj
 Fh6uOScbHuf9R+sZNBBT304ITNQxUgWRz+FMqA6YEtZEkDgotrD/w5sVASt7ABwaOr1WE0dMGLc
 SAFIbDjAU1S9sOBUzP70tdyPHB0Y0Y6OiXXv+kEfHlBdgziBc/kc84A+hVD357QDl5iCDZBTDJE
 NblBuX1KpIUZLPXzBOV1/D4DHlT8FcC41XQUSkcyUXiFxOcLM3rRjkWiy/oKjfAe+d3SHiUqaQX
 sGs=
X-Received: by 2002:a05:6820:4b04:b0:68b:bc93:1de with SMTP id
 006d021491bc7-69c9436a14fmr270373eaf.35.1778780273585; 
 Thu, 14 May 2026 10:37:53 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:37:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:50 -0600
Subject: [PATCH v7 01/35] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-1-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_FLUSH_CACHE out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index dfcdf320b7..3f36c1695a 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 9135bf5e8b..20ea7c6ab9 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -10,6 +10,7 @@
 #define TARGET_MCL_ONFAULT 4
 
 #define TARGET_FORCE_SHMLBA
+#define TARGET_SYSMIPS_FLUSH_CACHE     3
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3d9fffb54..73f09bb775 100644
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
@@ -12102,6 +12115,10 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.54.0



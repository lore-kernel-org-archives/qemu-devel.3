Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B809ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf6q-0003MH-GZ; Wed, 20 May 2026 07:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf5l-0002xh-CD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:28:06 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf5e-0004OE-Nh
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:27:59 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67e24b8ef55so7996847a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276470; x=1779881270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQD4fR7d1kJbujtCHjx9S6B7VTYIX29Vn1eK5+y9kOs=;
 b=eOgVQgVv6GogRDW1ISLPyPly4lsFGJ8gwb5+dN2iB9XRlF+7y0TvjFwlJg5576jY5z
 nHOky4Y2TTU4wJ5EYOnYZeELOLBTMJBFOi2vU11zNMtob0K18ZpJ1/k01qodKVLuXr/X
 Ie0o84pHYOJu6VCwrrCzxFYOdAR1AZWCH5vJyPqJV6SeqTkcv82s371UGAhvmz3do7gU
 q/oeha8VVTvDxBaieTRTOBBT4+cc/Qlpk7hAduUk7A6rM9F9MMMjFsG3WbHqNagvDXZr
 oZUBshIi4Lzzh3ZHKQ8hppo7oR0gqFP6ZVGZx0hKoGx+UOWkRMHZ1hCJE6mF9BRfgijL
 Dh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276470; x=1779881270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IQD4fR7d1kJbujtCHjx9S6B7VTYIX29Vn1eK5+y9kOs=;
 b=sd8au3zYavMKylTY3GsGUzGGMmP00jXj+f58BACmNsiOoplralUHo1I0UCxLAgnqDh
 qlK2xOyXi8MwGwy75uXGoVQckkNvNQnIfyVzuDr4smX9uEorDXnKUNctx4w7+Gq7OlYD
 iIn3nAMHyQfwcChwWlRxRWgs8hLJxGVulSiVRc+4CU5DXdowumNeJaXB9Tsaxvxepinx
 EM3EA75H5JxhMyyiLKwHiEqoIXploD4Du3cvFVmv0AQMwJ+puiWp2Kmn7pSC6XDQhQyB
 qA8+Ag2bXTIlWgik+Rx3OkFo1WgeRXmZ1M6CeRArfcrAcTxfSrtK4fmkd0r532dDv78b
 85pQ==
X-Gm-Message-State: AOJu0Yx6Fc1TVADABk63U9ec6zvM1CPNYpQmKwCHU7xFG47jfMgEBDAX
 N6yGSBYwp4cYK8wadUvcDt12MtHUHSLCUs2J4Ma3s9KxXgKKeJcz9YGHMFB2cSBQ0PrS1wVQCqs
 bSKOXnd4=
X-Gm-Gg: Acq92OGuhzmA89l4sjE8dktIpz1pnzzZ7ZKpDG2GGRxdVmUN1X0VB+Gfpkg8IgsFTUw
 Dx1sh5R45fguHoWXKYVEBDIirGTdpRgQY5uB5YaR0oj5Cn2/GfU+boFGLBRfIJYZLXstiWb+JY/
 hhrJ/MX8mJQsnnM0X4Z4ew25rB9IFwsLvIn4PRvK84PQxuNFPhqZNQR3w4tPlUfOyTs5rmrB0nB
 qGSUqpSbVusSFL10Q1lGcATJMBIlGSIzbrwuKJofTWO+FRojk+5XOawokG8m0Prtn5ZskbpU7kK
 m5w/yGi/lQj8kPyQUx/d73bLr/bulRaDqguuhtUycAug3CyyaF8DaYFyAesv1F191YKcgpU9Qxf
 uDejV5uAF/xPeroa+cJMLk0YCmGrY1ZnIxaccMDdnHHAWFOufWp5L/49fZKNw8wH0AgoHXmxEAM
 W6vvVtG3qVaDVkcVtmQ5sdweisvT+fFYqE7MHfhl/u/S6+pdlvO6xJ/Hki1L2PpRFKlJNrTgO//
 VjdSm9XD9rwOqgmvUPYMqdCkFc=
X-Received: by 2002:a05:6000:2503:b0:452:65d:e108 with SMTP id
 ffacd0b85a97d-45e5c5a5e99mr37522151f8f.3.1779272305972; 
 Wed, 20 May 2026 03:18:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39ff1sm57277622f8f.10.2026.05.20.03.18.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:18:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v11 02/24] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
Date: Wed, 20 May 2026 12:17:43 +0200
Message-ID: <20260520101807.9971-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Implement the MIPS_ATOMIC_SET sysmips command as an aligned 32-bit atomic
exchange in target memory.

MIPS reports syscall errors through a separate register, so successful old
values can overlap the errno range.  Write the return value and error flag
directly and return -QEMU_ESIGRETURN so the common syscall path leaves the
registers unchanged.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 31 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 3f36c1695a5..9206694f4fb 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 20ea7c6ab9b..e07687f8ac9 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5a8e00337a0..3df42aa159d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6631,10 +6631,41 @@ static abi_long do_prctl_syscall_user_dispatch(CPUArchState *env,
 }
 
 #ifdef TARGET_NR_sysmips
+static abi_long do_sysmips_atomic_set(CPUArchState *env, abi_ulong addr,
+                                      abi_long value)
+{
+    uint32_t *ptr;
+    abi_long old;
+
+    if (addr & 3) {
+        return -TARGET_EINVAL;
+    }
+
+    ptr = lock_user(VERIFY_WRITE, addr, sizeof(*ptr), true);
+    if (!ptr) {
+        return -TARGET_EINVAL;
+    }
+
+    old = tswap32(qatomic_xchg(ptr, tswap32((uint32_t)value)));
+    unlock_user(ptr, addr, sizeof(*ptr));
+
+    /*
+     * MIPS uses a separate error flag, but the common linux-user syscall
+     * path infers that flag from the return value.  Successful atomic_set
+     * results can overlap the target errno range, so write the result
+     * registers here and ask the CPU loop to leave them alone.
+     */
+    env->active_tc.gpr[2] = old;
+    env->active_tc.gpr[7] = 0;
+    return -QEMU_ESIGRETURN;
+}
+
 static abi_long do_sysmips(CPUArchState *env, abi_long cmd, abi_long arg1,
                            abi_long arg2)
 {
     switch (cmd) {
+    case TARGET_SYSMIPS_ATOMIC_SET:
+        return do_sysmips_atomic_set(env, arg1, arg2);
     case TARGET_SYSMIPS_FLUSH_CACHE:
         return 0;
     default:
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A86CD37A7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMt3-0002bs-2k; Fri, 08 May 2026 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsx-0002bT-6X
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:03 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsv-0001bb-Mj
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:02 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so1651350fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253180; x=1778857980; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iAJ8Qk+vpPe+4QpFghj8xaJORB1ELQJhno5MzPCICrs=;
 b=UIJBUCNIqIaPkGeEC+qMjrgbi7yJPRvoMR9QptFlezS1L0QDb+TtbD7AinhZ2DUPG0
 Sx9WD+OPT+a6hCUBFC3I63pBDP3TRq5hcgf1BO+QS2xL9SFaS7I5vFjl33ma/1RmxI7z
 xBNp00hl/6hSArMXCWQiWOu5Vv+caqYZ/+c1xa6UENXaV9nvWq6EJHtKYCiTpD9WuSZs
 jqCe5vhFSYYKl4+m1gFO0X/pXbCoQEsg4OXHhrP9baWDqrbs4di/dF/yC7THkXrlkSU8
 MvAJ8n57SLo46D8yf8W6aZT5yCHCo2Hi1PvKJXon2kdFlvxnM25auglTKf6mID1U1pa7
 HuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253180; x=1778857980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iAJ8Qk+vpPe+4QpFghj8xaJORB1ELQJhno5MzPCICrs=;
 b=k7HagIjidqdJEhWL6h2BZvecYq2pd/y48qwkgSHrkzIA0KGsxU1+Lm8DN5VakJatMU
 Q5TgWJ/dK50tAix775NV/2w80phlWKLqUEGHRbWLCyLYrOzVh4W42yydA5PFnCiu84T7
 9z6UADojFTWpx/hZvjPH2brJE8BcQ1OLSBR0EuuaCvwTHYN6kkBhofK7pG6UcHWPUKS/
 /UATedp3wywr0+X87LhnypTC7U++jCndaVThqs11WDBPwFRk9LmiaPjRMN14WRD/ErA9
 Lo09KAfKdQIr4KXWASrZxaqhtXdJTVUHFxgCMtR07TvwDX9cwAEUGOQ1TH3XNVhFQAh6
 EcHQ==
X-Gm-Message-State: AOJu0Ywbjfa5yWl73bPLIQszkpbhaw40XaVWyNQEjDXG/hKaqho6zUhi
 2YLdOsNqQ+P6xVQdMRj7bP+53AcF2d8K2zqLx6npKZS3/Xl7k2GiKYk81GeQog==
X-Gm-Gg: Acq92OGH26ZTKi776lEowdcWihGs0+M7rBDbP0fcWxlpxgIsU4DKaPrFkzrkZy4wdn2
 DegIosT1Pl+8r6/lV4WNeOPBkq43wGtmamkPyFAIfhgnPAQ9nZWHGR+Qv39vOPdNiRCm6ijz20N
 Yv9h7UDLFUgim61PKvUzj+ZOZ3AdHKzU6xOQFJXsz2w0B0iMhYVPWw36BUKYZlF8diieavROi+i
 2K2jvyMWWNvcJSun+aoYCm+twmsdyifZ1scyciWGc/Bqy/hCbIGPGAv5OCpl1c1KGHVCuJRbrjv
 jH6dLxv4+Z/Z4iYBElkY8KSqNKdYK4aD76apvCg8/yeMLlGt55l32+ZV/wn8//65aq3WWUVYTV2
 XJsxg3bTqTQc8XIg8d5Cf0EEGAn/J8hbwrHLeu7pQS5RP39J6V0hX/la5lKVoaW/ATaQDC3QErS
 XKI4RlHx5MycByzWc4EMlL4kSlPq+oVYAoPsvzoa2R7qGPxnPbQZaUYea1jGpMnEP7NWvqJMe+G
 ucTpf1+bkb7UIveCfeR530PnXnrXybkDPERzUA0a7AaF7H4Je0R5krOalZy3QhoEAKO5JoNLKOp
 pfarkPTs7vsK6/VvzX3lhKB9to0vMX8YFqmJNqNRWBFgpFeodUbJNVCn2id+RIa7W/8i5LJHlI6
 7CcLsUw==
X-Received: by 2002:a05:6870:c08b:b0:433:d0ff:a25b with SMTP id
 586e51a60fabf-43556fcbbe9mr1735875fac.39.1778253180087; 
 Fri, 08 May 2026 08:13:00 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:12:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:02 -0600
Subject: [PATCH v3 02/32] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-2-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2e.google.com
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

Implement the MIPS_ATOMIC_SET sysmips command as an aligned 32-bit atomic
exchange in target memory.

MIPS reports syscall errors through a separate register, so successful old
values can overlap the errno range.  Write the return value and error flag
directly and return -QEMU_ESIGRETURN so the common syscall path leaves the
registers unchanged.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MIPS_ATOMIC_SET out of the combined sysmips/MIPS_FIXADE patch.
    (suggested by Richard Henderson)
  - Always use the explicit MIPS return-register path for successful
    atomic_set results.  (suggested by Richard Henderson)
---
 linux-user/mips/target_syscall.h   |  1 +
 linux-user/mips64/target_syscall.h |  1 +
 linux-user/syscall.c               | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index 3f36c1695a..9206694f4f 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 20ea7c6ab9..e07687f8ac 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -11,6 +11,7 @@
 
 #define TARGET_FORCE_SHMLBA
 #define TARGET_SYSMIPS_FLUSH_CACHE     3
+#define TARGET_SYSMIPS_ATOMIC_SET   2001
 
 static inline abi_ulong target_shmlba(CPUMIPSState *env)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 73f09bb775..3786a34041 100644
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
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D570ECD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgV-00014R-Ng; Wed, 20 May 2026 00:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgM-00012a-Fa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:22 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgI-0003lI-PR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:21 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de7dc85b74so4360434a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251837; x=1779856637; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=eCmG4gN6yLkAqzKCxiEFIuPc1e1emMbaM7rPmzchi0/9FnGyUw47cyKoKtuqxEU9Fk
 s9sSpipjol1NkR0ZoJBPyhNPtce4CH/grLEhqIwWQemiEhp61/InYIO2Lg+Q/kCA1Koe
 vTWSYrqerbC3po/oF5km6u3nKW15UwwTQvC6Oq+ObVnQv+xKmtyckQtIGTGuHk0ZPYrg
 Dnr77Jd2h4rysgqis1cDY1o6D3nsmin7ToZ5CZbjd6hbNjSSlgLnA3BrnfMjSHu3tIdz
 DArUwhZyA49RuqC+2QeT9LCJKn6Y0umqOPxVKsi26IP87lbFZRQfTM4e0QxUK1WNf5Fx
 D3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251837; x=1779856637;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=khVlB/iuHBqSxDf1ci1EMIV9f0Ywmy6N/0aX6cS55HM=;
 b=i99szlh9g43CdVuVWiooEsd0Yj2GuBoZ4W2v72wc2TpGDWkixHr+0hbW4tdBx3T4Ow
 xlruozoO9nXm/7mlsOjdcyYWjU1lgCpRnjncHdjpA5R4wQySkMbNXIQoyRiADKL+oeLd
 m3D21/qeg9himlWNSRNEMQ4782cyUg8hvU+wZodl7fMRzAgSqx7akD16f0phXBeVaho1
 TLqzEE5wQKrRRKjXdFckfWCKUjlwyvWiwaxDsIRvcCbV4nW4cWXZk57LYUdvSu1xrrsB
 eZ6ICBAH0lhl9Y2/twfnMyJRoecBgQ2L+hMqatpLN1p+GOodKdF4+siVTOSsHzMXDBR8
 cmrQ==
X-Gm-Message-State: AOJu0YwI5Fd2qKv2XBEfhYh5+xelHRMa3UCuJBLwnLQOZUiF4DNwywqg
 8+0NzS6yWAgz/9Qkx9SLSMzQd2F9an6GLGCRSnFuCc9cLiacx/GVh8TX
X-Gm-Gg: Acq92OFCVQvQtzZ/ds393Zz3CX3YthMkNFn6+WciKDdSKP5yWqpkj9x2Ycrev+8X0OJ
 3WgrhrigUeF7moAMkG5rPj3WkJlNkumqhh7rqyb8360Hydn/vYtIWLNd5dgvF5km20tkDP3Rp53
 gUueg98+ORljTb58hX4whNJqAKKGSXV+sK6Ydv5WQGqqR+1pk3hnbNjvcVR2ifmaaw0eUsxLopG
 ZAmOG8+iBH7vO7tEM37nxU+dAACcE6fpcq9Zr3Bfen3kNqJlK3yktCr9/lqPlD9Y+IA13+b358t
 3Yiv1LosTlK054gRYi59hEMweKVx0nHALeX4td5Wypr86Vww45OU4OhC6s/IqCjvtC5p2N8kmaF
 97qWWGEiYXEhRVYkcdZvHc/LGjUpvi25gvkpzmIH4kPsQfqoPJOgeyqsI9BijySnEnFYAtgyA40
 6HQARa3+zjn69JTx6XFvI6d+A3XuyeL/zqVxiMkgNXDoU206zmz04OYlAsGUr4os+5iP6oTwVoz
 iUvjCUiADoDX2ZjbYMc+ZPjO1gGxdfwL6uIpx5m0cjqKEXEMY+LDZbdmjZHBurPZ4pQ
X-Received: by 2002:a05:6830:6201:b0:7dc:2f4f:17b4 with SMTP id
 46e09a7af769-7e4f2bb1872mr15469590a34.21.1779251836812; 
 Tue, 19 May 2026 21:37:16 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:36:56 -0600
Subject: [PATCH v10 02/45] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-2-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



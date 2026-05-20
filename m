Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FE3CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkdq-0003j1-Ri; Wed, 20 May 2026 13:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdp-0003gA-9T
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdn-0003Qh-GQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:33 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso49528315e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297809; x=1779902609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQD4fR7d1kJbujtCHjx9S6B7VTYIX29Vn1eK5+y9kOs=;
 b=x+eoa1khw7BOgQIvsi1LFWRmHo6nLDIBaXpP5RNDSj1eVe2XaFBLUg0dQTKfmEFVIl
 0kmZsGkAn6FDiDUnvNnyhyKp19uIaFpDyRZv82vA+fhGrwAAnPkup+rCu6PDduY539eI
 6AaB2d/7tcLCxzAt/N7Ei78AllahJswM/1cGTcUwL2DCXF+pWp5dYdFUD0mfaP1VTRuO
 yEOAtJ9TFe1NoY7VsZOZ5qapBH5xVv1AZXkTFvfoRAQGhLsOpGcarSB54uFtgtuYSjZX
 qu0v2rXxU4DNH1Xi1otvkmNnnY/Cm9fQBOZgTpa009ZBWfAuVXP02LSbMXTg59Ixjrro
 2gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297809; x=1779902609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IQD4fR7d1kJbujtCHjx9S6B7VTYIX29Vn1eK5+y9kOs=;
 b=mU5zHvvoCKO9YDxfl9Zva4F8HL3p9+osxn4LJ9Gc5BOZio7wlKFvKsJySTiSIEmYOG
 F2kX009H+vKYwldeY+C0E8jbkr0c8V1DPth8/msAVeloyvNcBbmLLsBHyvs8r0mLt7Wu
 WWeYlcW1XXxT548812ZRzHznb4iEewO1ZaKcypqgm24Dvi4URUtc+1hm+mkTOC7u3Cq9
 suodbFZtUQxj3peRJJTY1bEiM/cKiHUdcrKSqINBmo0GQx7nKfI1wqKOwo9FZfXhiGju
 84wvPdOr8puUns24E8BdacKucANZGoQk+b9t1/7qQ6aFKapnzcY+iIQwkJ1vjyYfHyCs
 FtSw==
X-Gm-Message-State: AOJu0Yyht0ayq3/k5/d0lM6YU3c7+eqV5dz6IYWPBrabWmfMAIl0XlNV
 qOtBBR4TZJ/o6+wMPJFs5AXgN2rAK7uhmFMj+zWKvKbVSMSqL8XmEmLAti5tCEfoLPGhYKbXvfy
 +KimUKVw=
X-Gm-Gg: Acq92OGHkP+scpxS9nsArz+0YUQbwOL/8drNRAn6ncKgAq2xOcnfDGvc/XSrJo0yCyy
 bSXFMYK/tD0sHovqQ5pRWhnq0lKGVtBDU8YadC/Z8u+ByIpENMZNIy1pHT3XeZs2LuQTUXqQ6Rs
 dCR+iuLik/PSSVnNkaqBu1oiF2oH0+kojOVpz67pce2iobZJ4iChzzvKjGBqZsHk1frgxYrv0nl
 nEIqxNJNZzChMbS9b4qUwc2Sooj4X0nuO6n55b2AfahRlcIg5IfjsZq1VVo5W+JCrals4oC/nnw
 TEZVnrFqDBdcTaOyqt85VCFUDLNmpzJ8eZDMGTaXFgCXM0ICqV9EEHk2NAfO/S3l+izriOtKne1
 /JjiClhgP2NMOApKPbJRtfonALY+4dl9JcWgoXMapACTz+fp1KcxTTdMO7/SKRBhKAt2FVglVFB
 wNM6W8++AfSJERGXso/4NtMAd9v7uXF93tjPGJsG+UX3OAQ/FXIUktiRNvznBIv2UvAMqbjREzy
 eEHfVBpHIw=
X-Received: by 2002:a05:600c:821a:b0:490:2640:a982 with SMTP id
 5b1f17b1804b1-49033d00c54mr6237245e9.3.1779297809378; 
 Wed, 20 May 2026 10:23:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d58838sm5675165e9.11.2026.05.20.10.23.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 02/24] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
Date: Wed, 20 May 2026 19:22:50 +0200
Message-ID: <20260520172313.23777-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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



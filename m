Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C50CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmXM-0000S7-SY; Wed, 20 May 2026 15:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXK-00009y-47
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXH-00020D-Js
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4351877f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305094; x=1779909894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hU6ebKsQT0Fy24onkNdlGUsVBCKWyDDG3Y1v+yE4t/0=;
 b=Uo9fu/Ue/7n4fl5SeQ1kcWrfaO39D0Mk53R0Soyde1Gzoyo5OZYHfiED2IrnEQL+Rt
 Czcw29yq+oaeRpprd/jCdqb/4ujSLeU+Gvij1RnLvC1kPkb9+CcyHzvQBTmRGlueLO11
 NukyRURup4zCH4IH1QzYlL2jobudkFIi44v1LwkTnkivFzeS8emWvECFmte1c0rSSaOH
 Bc2yxyZCbop8sdjLbxRIl1+FwBNkG4BU/lfStKtB0kgROJRL1iWNvI7TKISE38SQm7XW
 +zgejrMTS8VaQhOZVaUCs6+tvsJ9Wf6UERxR/m4KlqKLaUSf3IODoCLpvDQceHBIqISp
 d2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305094; x=1779909894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hU6ebKsQT0Fy24onkNdlGUsVBCKWyDDG3Y1v+yE4t/0=;
 b=GNXDjgWpHz33EEgctpJ9fI5qGSj8/e4VAIPer5ThdxSSh/Wrguwm1UUkMypJldF+G3
 hXVdTbhEdfLAinhuFfNehi79iMifD2pKLBnPkqDbHMZ7TJiiYHFsm3lnPLB3MlDyzwam
 DNQAu9Ew7lQc4hHfPFMGEPbCbLAFZHl2/7v42FKaGC1X7ovY5UcCd+NcXfdVHuAUfQNV
 Y+tAPSreEnjS6m8pwZL95GtBHDNKbBaHB1EK4W8C9FvUMcdWB/oXkBJ2NWUobciukUc0
 c3OedBMSedghAhd6EfLaQFXnJNH9+2z3CWcawf5azSLedb1IA8szxOaFAb1C9FS55jd/
 YsvA==
X-Gm-Message-State: AOJu0Yylm7yIzj42HDyDbK3kegQ6nmTZCfD4+poGARLxKnQVLlI0vjWG
 1gXZLoaovH0VsrEiCJPcDcQwKpwc54nDClmpT+ECIlqQgF2wOltNi++ZYjGzMIYTRNSvBTLy43f
 G2nMKpJ4=
X-Gm-Gg: Acq92OGtpPnIAP1Kny3n6EaUrO0b+mEzf8tVpqTBRaaY8uaNdhu2yO46FVBiydgoAX3
 WLNlB8mIPuTddxVOdBBTRKjLa9lvZkd1AbMamllh701lkct3x/7ImDwmXXSbK2tVg+apgX+Djnq
 S0CVtYc3QxouLFOlSrPqRMCx95xzL1tiv/OBsnkzrq9ZnXDBuF+8K40e+sJgnc0PQAA5aYecuvt
 5AWYWoQqDXEpn6uEc1sjLtgGcT5LQr5tJFW7mX61KsLdLmCGprdiucn0f1ZKVjxvihAmTKqbtZf
 Tp5kdfHSDNdtkCd1ZSeecz1aNwTOsOZuMx7rR/1vf2Nli+0Y2AFvKgmnTzuJ6RDSCYsbPsIz1Ti
 y7DjcU/CfRBv5TUYIYezIv85O6y5p/ZtAmB2gp2BnmlCHsrfkpRG9n+l95KkGzycCrKfFpAcQjk
 TdmjE8FCFOhp0I2OgultFhoh0z/8k1YBlYdSbvm2tVGJ/9wYdN/4tAlaI66WuIdCI5nMv/w25Ot
 o3vmovhX3o=
X-Received: by 2002:a05:6000:471a:b0:452:f380:5508 with SMTP id
 ffacd0b85a97d-45ea0aac013mr1162596f8f.0.1779305093586; 
 Wed, 20 May 2026 12:24:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19a0csm53471546f8f.20.2026.05.20.12.24.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/33] linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
Date: Wed, 20 May 2026 21:23:15 +0200
Message-ID: <20260520192338.40036-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Message-Id: <20260520172313.23777-3-philmd@linaro.org>
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



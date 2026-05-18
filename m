Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F686CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqXz-0006sy-KW; Mon, 18 May 2026 01:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXl-0006rs-9Y
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXc-0003QZ-Ak
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:28 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c941f7213so1240396b6e.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082162; x=1779686962; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=pGZCb/fVvInJu3ItAA8g0CK6Oix/rzyMJ6xABs3b4Lc2rQyYzklnnMPmmSjE3d0Q4+
 P4jpac5a+HD44luO8ep6fvxsRAZis0vEVadnZqcHBd96w6xUsi5ZN9jCwd+U9yqh8A1P
 tAPrb7cKJlgkplCq4IuvyIGA8LBQ/lASymPOUrc8w/nhcZpceSb3zXUe6G6tz1J3GcBx
 BzWkab+svU/ybxhyWt2x94gFEMJH4gslDRUldhnjY9tGBoMbP7wbIHiy/eI+vcB5YYeb
 GC+2UKbYAabjkD/betl1GzOrcnd0oyBFLptHvHw94xKhYysGK40Wjx36O5+NySsodval
 4rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082162; x=1779686962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=csR6r/6tfXDdN+jhNmcjbBheA8aWrtBX4GG7Hf/dh4DMDokgCBgJSHeolvDT1m5rap
 IRZgi8Sj8fRASahkJ2c/pDDBv5PsScHTs/VrSjbFwebzmMjbCVexmnE8D4J32XjSkZu4
 s0ZUVFNvv79xSuucdyl+oWu30sAEsdOg3Jg8oToFr5l189jCn/y0sXICp57T2TmhVBF3
 jpnJg2LpRndWJU5S1lgTE8BFfRojuxPeO88Tlrx7wvzLh/8CnEnCEXIjoP702v3PU+K4
 Dij73KERI5RWDRkzmkQxgj0BMOybX+IbKOlxTDJEWSB/MLyzU+xe84EKoNkhdnjHZTV/
 rIkw==
X-Gm-Message-State: AOJu0YwQ3cUvnzmtWRKgnT5jU+IOLAhe3hVKr6IjrqHr4e++asQ01uyw
 PUCy1iE49ud0syAVf+ajlM66ymNYdIJW1USyrpiJsZmpfDNFljpIx1b1
X-Gm-Gg: Acq92OFG4R6BdR8KhgbA5yv35ABqkEDKB6LPSP7chqeKCSPIbOQUDc9PTro9KEUNfxu
 n0PRU7Wq1kzxjHlQgi3fYKmaSHUFplKcjayqxnN7S9nBabQ3cbqfjySY0MMD4x5I5xkUfTjR7+y
 lDEZrhxZFzFt4f2Qz0lxlCk+NMmkTLeTab5NDT7wexfPus7e78GLFmN7J6tk+Ug3YiUh2aTKfUM
 qSpXYdP8U/OS0U2VObiqkmSwrE53eUg6HY67Ve+QsWGRkwMxTNcoZtF00zeFsRmLmjCGwh9iVFg
 Pzb8aYQB7sCrmoN372TUiAd/r2iqdqsP1u+Uo0R1eSiwuePg9dV14gHjORR2Hnh0YKQTQKCbg3E
 Crb16txYEQ4i0BT0TeTYuHtJai2bYqYBD2syKFbNC9QIdqzDRgmpqcBhYJdCc7pd7J/E1RCmsS3
 8PhR1IG9m4LQsoXl6HRaWpTei/UbpSWQucKOmTM7UeJLoPDwVzFZh6h+vkZ0y9LEDKK+SP1CIOO
 ofUJSy112OBhikoQGjPYkTMwnCE1hIXpUc2G4x9y0pGqtrgtpuomfTomMFvzfn1f5Nr8xM=
X-Received: by 2002:a05:6808:148e:b0:482:5538:20c3 with SMTP id
 5614622812f47-482e57298a1mr9523834b6e.29.1779082161696; 
 Sun, 17 May 2026 22:29:21 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:28:58 -0600
Subject: [PATCH v8 01/35] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-1-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
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



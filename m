Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6278FCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDj-0006iv-CG; Tue, 19 May 2026 12:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDT-0006ca-1t
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:48 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDM-0000dP-0o
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:42 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-439a8366831so1528817fac.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207756; x=1779812556; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=Ow4vZGkTbavzxuCINgDKePSRcBs72ljYUimbbAV2Us1COsAcWIitptQyLc+yJGnobQ
 1JSCeOgrA6DzpoMRaq8sLrsG+iWtAMc+o5c1AHf/2ItwOgMTfpY7XzG4p+MJ0fUGt/p8
 1j4BjeZ2Bs715Y/qFgGD92Y1OE7KF1mSS7K4cLDqoReRVuNKLYXjv9Lh1pvN8Y3QQvY1
 neW7cBZxdc+6s9QQQAiLhMxgLFWRNCLcw4p3r/teS0SVvEHmtdnKLDDSiQJwfk7B7gcq
 0JhdXZG7eW8adej4z+q/qm+HxQ+iaCCpP32oFSDEPZMuC60CNuHkAF9BvLso48ILk5CE
 j31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207756; x=1779812556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jM1jwUY6doQWw7cNzzrKAiwqt9SLepu9Iq35gPFd94=;
 b=WoUkygB1TON4HwlMmbaAjv/gGiaHPomj4GkjXraRO8Wxur8uoOhhyv4QvhNqZaf70Z
 ZjphyO/QN5WgPQrzm/8ASH3X8IaHgomMdo0l7tIJlSE2tmIqjMTnr2Dqu+1AE1tPIOGm
 DlDRiHKa+txTbhZfXWXr9SZicWAWUSu3WGAA2GDSUjihYSR3iVOzrqTIu/Z1XssJfHIY
 7E3ZNzcBKrD4dqNOTX5e5y6TdHEKPE5+/AM+x269GCoIZ7asrqsXPSwh4N/DxJdAs+2G
 yQeUekRAa5dfu8/Kepq/jpRKIApJ6T58ib3p3KmUBAjLViKbvUvKDnPNHdWl2nGXGk9A
 GsYA==
X-Gm-Message-State: AOJu0Yx66Z7zx4g+FF2tXEViLrCIw0qW5ABXfLPyKFpy64KxhE5XOOg3
 uN2d8HIezIqaIDHXseOYxg/vCGGKAtFGNKrdpEY7ARbzVFD+v96b48RB
X-Gm-Gg: Acq92OEVjJbR4stLGqdCTk0s1TMELOozU9YjPyNnts5uskZ5J5+fNAMM041L4MJ9qi6
 8cb5HPg4x2gIMUPIDZsPh/2Ibg0mGUPOd+lx3MaKKqCKEJAHujCCbKkaDQkHtgGv1ym5UiK+qSP
 +tYtXEoBdbvf85Kv2FKei5xD+8TGOqtBUFxhHkV8khPIv3nscSTURsaogs1WVlE/xaXpPYOhKzO
 4iPFi24AnpQZXnqlcS4QyrSmCC25gWG1xj+hEs4SQZyvB1fIxEKYhwLq1cPDTWR4f+mGLxyWBhi
 IEaZ+ipULdaHlB0YWD7B5AWy29d/fq3HD8ZI9x/hUwu/f8LggWn6YyL3RfCW0AYtAmgK8dVqr1K
 w2EQwXPyhMDqn3VfhxFUo9gLtCK1HB6sfWv03W1NHHYtWKg53PqAdRHBxz94I5nhpXzZVcXt44R
 OdFaR+yp9/b9N5bWf8/xV9bipGRo74A3CGrRA5+O0QoBUtQ7NymSw/CcATSSiCMXPVkaja5Ut5q
 hG27Dp4yhIhn1rwTLFSYQdOrUJylur8Go8Ikkc5FcEKkOqeNvxf3VHZrqBWjWbJZIyv
X-Received: by 2002:a05:6870:ff04:b0:42f:fc34:78bd with SMTP id
 586e51a60fabf-43a2de7ba6cmr12118895fac.33.1779207755884; 
 Tue, 19 May 2026 09:22:35 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:03 -0600
Subject: [PATCH v9 01/40] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-1-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0362CD37A7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMt3-0002bg-1u; Fri, 08 May 2026 11:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsv-0002b9-Dx
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:01 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMst-0001af-Qm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:01 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43496e6a964so1603902fac.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253177; x=1778857977; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eeSYubRzrbVOd4JOKsu3EVgrvrE6N+cN6nPl+evK3YQ=;
 b=sFo7pxNZlSToWZjZOFXj4w2W3TyGoqSnkTgtQx4JAPFoOVL1iz/da2Hsckva3z48Xg
 smhH3UZA+UiGXSuRJJG+cHrsEgMFc3krTedWcA20EJ8K38P6FWweZjPGDnBR6lGw1O6B
 l28YnkzbYf8N9QB76/pjahwHSN2N3qM9YTgkfF2ukx4AcMpBE0945dJVuCQ1hlMV7mJd
 4l2p27E7dHXdwfTvu8+MhOUE4D+XiF1Bb6qHPirFxe+p3oAf2HDstfaykOra2fd+RqPj
 MDazulhTDjvJ7o8sR45J//gin2n/r8PQvYA4l/AYGAgkYxfdLkEgb7KEdKPUel+EVBrY
 Bsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253177; x=1778857977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eeSYubRzrbVOd4JOKsu3EVgrvrE6N+cN6nPl+evK3YQ=;
 b=mVl51roQtePrH8aSuyz193StiM1hjIMB8a9HmAPWNGDdoI7LZdqiLMxj00sUO764bm
 O5Hg0Ju4VXtzEpjK4WxhdSqyDKSkTLxNFM0xYRaTzNv4JIvWMjteQs5uhydYQ/btU0/r
 vObIHZAZa5W7ma+y/rMwHk81+p5lXMbDJGN4cw85A4lTZTSiHmlSKJjWoBSlzCtr6D6k
 alp8RT6Os3vbN6hlJv2iILSZ/c+rdTZ1e7BBNgMewO8z5VDGgKH6ayH8BxyUnEcBRM/9
 kRHHBnsp+Di/blr97Z71/LJbrHW6iqU5NY2u4apUT7Wdxhr/hjzR0OxCsduLv9+yg217
 HkJg==
X-Gm-Message-State: AOJu0YzYm1LwUP1M7xfdN0FnXzyFrjX0RHb8n/Hz54HJDWA72j9cOlUn
 9rceTR4bvwptw1xnRijioJ6yBLzxU3RPwspZ9y9MyMf/ZOoBgU3wgQBSAwJE5A==
X-Gm-Gg: AeBDiesrGL0r7GWeIeNbyE/k4iPOlf71rZZs2kt+xXKiNCmtVj5lhQ8VJ49Y8x/Uq9i
 hXk2Y2k3hgqkWuFvRghgQusMD8m8SiaPMIa+qVfZlINk3qF9us8cuZMz7cqF66+rBFAN59fiDpr
 Ozcg2bXSKyJbFIdgDKVYnFlMeLqT2rqqw0Upc6c78idzak6AGjt0Ijw/yXP7HHTVGFjYXlWKvJA
 leAvNYcYjQjTzanFL1AyrexXuMfTn7e2zn3PtM/yPRN1GQPxutkiCQtLE2ewbWrAe4VvzoLcu5I
 jokUOAPyKkxRDIXbHweSNCEH3PhgpKuOU9dv7PCw4SMWh6DEObuueDI2cEO9/qLCDvoTOnebD2M
 olxtix5XsADQGy/wwLMQhm/zv21Y/oLjDuQ61rUMmoQ9KX1tvZToUlN95VwkyO6mwWT6sNkLfNe
 91Ksh2Ss2oxCYQeun2sYfN5nVqRhDR73k6kga5U8mkk1z1BDmidsIVSKJ3O67QTFcTlQS0wIKm/
 1iaS9Zt4uBerlwqu9x4cP2d8k49QZBCzIvl+CKQgfDqpLx73pvFWpaUlH0gAC/V1LlztXb7453E
 8ycIEroKk52jL8NlWeJGv2yPLvkgZ1kBv04G/Weoq/FPio33IKgDHejQ2QXW4CDs39Jg1GA=
X-Received: by 2002:a05:6870:6c09:b0:424:6b88:da8 with SMTP id
 586e51a60fabf-434f63b1c96mr8641023fac.17.1778253176974; 
 Fri, 08 May 2026 08:12:56 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:12:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:01 -0600
Subject: [PATCH v3 01/32] linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-1-bcbec96357d9@gmail.com>
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

Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
successful no-op for linux-user.

Self-modifying code is handled by QEMU's normal user-mode translation
invalidation machinery, so the target ABI only needs the syscall command
to be accepted.

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



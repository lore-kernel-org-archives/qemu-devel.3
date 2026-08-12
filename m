Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D48C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFol-0003Zy-S9; Wed, 12 Aug 2026 16:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoa-0003U0-EA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoY-0002EV-S0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:44:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso1064435b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567481; x=1787172281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dBfwrVCq3v6OU1T4kao3X47pro2yBEmddrlxSU6VEk0=;
 b=i+1j6T5AQHxhQmOeqXwTEn4+Q9aHE79DIlj1FcJd2qyoXC2ws6HutdYfHgT1OqsRl8
 ir7v+uiztrCFsx/CDdz6E+RxzTiZmTjzRclM3soGJCZwEx2weLb9iTUd0EC4p5q9Wjgf
 sb6GZMl2ZwPHZmLRvwkOPVBL/u2c4iryaJxRGPME48wedua0LQu/CBsF9inW//2+dkip
 5bWK8tTOv6qdp7sXDZ2fTLVGb6sYsOppK8saM9+lS0vwnz8aPZcRJtqgmNfqMH07dtCb
 sKuuChjlF5UII41eQQeN0CtXDl42YwH0CLKb2e4gWbx4Z7ppuHhIYWFdzDqkVM5/vCgg
 gOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567481; x=1787172281;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dBfwrVCq3v6OU1T4kao3X47pro2yBEmddrlxSU6VEk0=;
 b=guJ8b/LdN7QCNO+swchFpKjLgSRz4mXvXdxg0GZENPXy64kmaNIIe8aWPMIPBWojnj
 gkh75ZT1e2PPDuYuJAugNGmX6zPnz6FSkojromTf5X20vCyhq6wnSc70UnBxL5LWUboe
 hZak+p/xyi8Uatecl4/BD3bY/5v5ndP+Cy7dsTkapSgucgBkD7NYlBtXNn5faA0KELtF
 GOadsHjfCs0kirvZ+3PijHUOD5FRMoCRQDPtgDacfV4HT7lfSK3l421SQd8vPOrwIMnI
 0TqUlB5BgMV7lJ+at69Ao9qqM6fQP+bdHUBfvjAMyh74MbaWmmdCGxRosFvi5/LXMQ64
 a+/w==
X-Gm-Message-State: AOJu0YyImuXXGWJ6gyrxOMMdgiSB9nwKMormFsYPQ14uXNcwSUYrrzfN
 iyLnH0u026FBqXD9DHSCHmGTGqTZkYDcDJwOfObppDdlG0Dt71GRSK2ocOiLuhjgawg30tVJKWZ
 VRktp
X-Gm-Gg: AR+sD13PnBQchdFKe/4zW0NUBJhG+YD4TbsYrrPhkrZh5F7z2HWc6j7mfDbmbCr7viX
 f9F+K4jZovTM0yct+KMZqkL28IRMnviFoKxG5epBHVmbnNzuG1Amw78JAJmO2Xkn+vw6fYVcsEj
 BrzFJ0vY8ySvwN1non+Kysuz3WgYPGrjjDlezZCwxASy9lhwHKNSQTb4wbL5GnxcgKozmL1KDeR
 mJNPXQ2XXRaW2lDOfBkPQT7WyB2PVYWFFg9wVA0t+8iljw7J+gXrN0L8iRIWrogzqnFmNinSW5E
 YfeGeoeApy0puY7kPdxpxn5jjjHFkbp1cygLsd41jKjVNwnalP1C0lRmi29p76yesZQmdZl1JUk
 Nak6k86H1+Jm6Jg9FBZ5Xwy9QQCq6KaLe9/ph0koFFaNB+gpRBfX7dfFBPdO1MclWQ2zEQZaAfi
 M364+Ym/HWvq+fqf8miHtHmGfKEBwTfOedvGKZ1uw+vjblcSONBzgNFhN8DBmqVkQ4sKrPryLHS
 iL8nRKy1Oje/VCj0VOG
X-Received: by 2002:a05:6a00:3907:b0:847:97a4:d6b3 with SMTP id
 d2e1a72fcca58-84fc745d87cmr500477b3a.16.1786567481263; 
 Wed, 12 Aug 2026 13:44:41 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 03/10] target/arm: Pass aarch64_enabled to
 aarch64_aa32_a57_init
Date: Wed, 12 Aug 2026 13:44:28 -0700
Message-ID: <20260812204435.295067-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Invert aa32_only argument to what is actually used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/cpu-max.c   | 7 +++----
 target/arm/cpu64.c     | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9c9196475b..5e7f41a50d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1813,7 +1813,7 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only);
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa64_enabled);
 void aarch64_host_initfn(Object *obj);
 
 /* Return true if the gdbstub is presenting an AArch64 CPU */
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index bd858f010c..edb5b9e6c3 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -16,10 +16,9 @@
 #include "target/arm/internals.h"
 #include "target/arm/cpregs.h"
 
-void aarch64_aa32_a57_init(ARMCPU *cpu, bool aa32_only)
+void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
 {
     ARMISARegisters *isar = &cpu->isar;
-    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
@@ -207,7 +206,7 @@ static void cpu_max_initfn(Object *obj)
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_aa32_a57_init(cpu, !aarch64_enabled);
+        aarch64_aa32_a57_init(cpu, aarch64_enabled);
         if (!aarch64_enabled) {
             aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
@@ -227,7 +226,7 @@ static void cpu_max_initfn(Object *obj)
 
     /* Ultimate fallback: -cpu max as cortex-a57. */
     assert(qtest_enabled());
-    aarch64_aa32_a57_init(cpu, !aarch64_enabled);
+    aarch64_aa32_a57_init(cpu, aarch64_enabled);
 }
 
 static const ARMCPUInfo arm_max_cpu = {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e3ee0253a0..faaf3ab879 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -688,7 +688,7 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 
 static void aarch64_a57_initfn(Object *obj)
 {
-    aarch64_aa32_a57_init(ARM_CPU(obj), false);
+    aarch64_aa32_a57_init(ARM_CPU(obj), true);
 }
 
 static void aarch64_a53_initfn(Object *obj)
-- 
2.43.0



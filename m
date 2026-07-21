Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2192BC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6C4-0005UR-JM; Tue, 21 Jul 2026 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6C1-0005TU-N8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:13 -0400
Received: from mail-wm2-x09.google.com ([2a00:1450:4864:31::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bz-0005j0-LO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:13 -0400
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-49553b57612so5577895e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623870; x=1785228670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bR4BTeae6fNCOYDibcfJEvLoEeC7E2KT02d4gc9TIoo=;
 b=GZ/p56hqKhFElzo9Nbs10pf5ObvIdkaVtVjEN1rl2WvkX32MQqgGLUDpWS7sil0yiv
 nzqYZeeJm8ubuxFZLSZ4ocbPJsp4S8oKBDoiDoPUD3FINmhbjsaD2SA92y+rn4Zw8FML
 hRPO6edNV2FaVe+3kT8doWhP5qVKODWpp13gQoaPuVTMhxwMQHfCa84byrdFjViZMGFI
 0ihI2v7WfUOq/LPZeJ0Fw/Yda/DjcV89vdxildPMVg6bRuI9b1lnecUFR9V/w8WE+e7C
 euMlwp80+ONr77lfQYEQPc7vUH6YFuS88YTCxtcWYHWWsQyj1nQhRUyyfEqHcEh9dWU3
 MqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623870; x=1785228670;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bR4BTeae6fNCOYDibcfJEvLoEeC7E2KT02d4gc9TIoo=;
 b=Dxk5rBrVojZ5wzUD1hqkV/lsvEN4RfS8FQyjCoYUjEDNZxVs0h2FLA2QFjzgvZyYuB
 VwIvMKKjYOsgp3VQVJpm/bZo2DgoxmKKaNUKV6h+8OBlJ/36UQT2sRUt2pj8+DgvOXEr
 Y5eTiH/C2AIFhq1ewIzAjSG1w2D6mZPN5QPgE13jplr0fiYyMuDaa5gOlXxTc5dd9WpF
 krLqtVeozAlfeiLBjvAFuZbQv/efS6KookVVXBVR2ViNJJxRy7qj50AD4aPyZZ8I2tzD
 ++FB+zvZwLOEH/9QpiKIg8Wn6CCyVUJHWXStFjnXCuuWwqQx8bMxnoj1SOf/CrvnUMhq
 Wznw==
X-Gm-Message-State: AOJu0YxsRI8G8Ywjn8hK/npZ6AG099rOgGrEG2EXJA2JAQg8RaihuDtY
 Xe1ynEE+W9wEh7Tv77BopYkf4QEk0xnXUDMav4QpFlbVMjiVpmoUKHfZU49nPBZHz2/RJzicot4
 JGbVnLEr1LvHK
X-Gm-Gg: AfdE7ckpIv6fbRLuAqpxfsmxzHIzT9o0ujtI82koK2VelU07R+tpZnjdsiw34yFfKal
 qLqy73nqwhUEqpT/HwC0fyl5GoRLaeZ5yjqwHhibCEUzxCcFgo+TS/1EQAQeK34lbS28lVt1aDs
 u3Yim5NkKOQNqkAGrU4RtX1lAOVB5twvby8K+S+oA+WQdQP48D1dU3n6ZlwdojpZdAiE6EyQZwr
 PAxCEaKndk6v8UE8icpZugRh/x++LGYitzwJ4iJHLGOEexOvU8BG90QZuICmynUNCq3kvAZtLXq
 6wbAtQenTJnLGxmSiD1Bf81guMFZSjuv076LxS9lf+ZBqlW1p6uZFFkY6eAopoRXvU7oUMTjQXq
 PNG+bl3fBTw+jATmfyEXFx6RWk8bRe66IsgOVSaIyQZbJDxfITieXf349MAAtlli7p2Fa6bxlXH
 b8g+lX1TM6TLAgTK9WPH7u63tSeXE+sJ6fl02P4jP6ebeEKX8Yrm3m9VwXSlOzdo7bh3fR7nuLl
 bSmX2I+wYY=
X-Received: by 2002:a05:600c:1509:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4954a3dcaa5mr124856015e9.11.1784623870232; 
 Tue, 21 Jul 2026 01:51:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] Revert "target/arm: Build cpu32-system.o as common
 object"
Date: Tue, 21 Jul 2026 09:50:50 +0100
Message-ID: <20260721085050.421257-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::9;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x09.google.com
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

In c8bea1276c we moved cpu32.c and built it as a common object.  The
commit message says "cpu32.c only contains CPU types used in 32-bit
system emulation".  However, this is incorrect -- it contains 32-bit
CPU types used in both system and usermode emulation.  (The case
where we don't need these CPUs and which we were using ifdefs to
avoid is specifically the AArch64 usermode qemu-aarch64 binary.)

The effect is that qemu-arm lost all the named CPU types except
the M-profile ones (which are in cpu-v7m.c).

This reverts commit c8bea1276c85855b2e088b740737d043c8556d58.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3962
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-id: 20260720100312.119894-1-peter.maydell@linaro.org
---
 target/arm/tcg/{cpu32-system.c => cpu32.c} | 10 +++++++++-
 target/arm/tcg/meson.build                 |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)
 rename target/arm/tcg/{cpu32-system.c => cpu32.c} (99%)

diff --git a/target/arm/tcg/cpu32-system.c b/target/arm/tcg/cpu32.c
similarity index 99%
rename from target/arm/tcg/cpu32-system.c
rename to target/arm/tcg/cpu32.c
index 6e983900899..8220d785f5b 100644
--- a/target/arm/tcg/cpu32-system.c
+++ b/target/arm/tcg/cpu32.c
@@ -1,5 +1,5 @@
 /*
- * QEMU ARM TCG-only CPUs (not needed for the AArch64 linux-user build)
+ * QEMU ARM TCG-only CPUs.
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -13,9 +13,15 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
+#if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
+#endif
 #include "cpregs.h"
 
+
+/* CPU models. These are not needed for the AArch64 linux-user build. */
+#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -740,3 +746,5 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
+
+#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 573e8b5af48..227e674ae2f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,6 +30,10 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
+arm_ss.add(files(
+  'cpu32.c',
+))
+
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -82,7 +86,6 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
-  'cpu32-system.c',
   'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
-- 
2.43.0



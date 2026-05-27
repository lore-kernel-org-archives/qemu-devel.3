Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED5BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZ3-0006Rs-1O; Wed, 27 May 2026 06:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZ0-0006PR-Gy
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYy-00014R-FH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so66845095e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877955; x=1780482755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I9340WSLhVpvCMgW/nLw1BtgOmu1GxYGZiZMrp9lCdw=;
 b=X66QHOMi8KsxFk3+1YLm+CFwrdgpDUn8YSFTKezqdK6YvhR9d6g6525k865E4uDljN
 4d+cGVjIrfYl/VcRPB6Kwe//A2yHhU87p8WaDSLH234R+Igj104T31zTCdbIDAW0Hja5
 pnFGE2VPdYuoPk46LXyIuC9fRg+vKsOtGTNZzJPF0FGi2kS5255gsgwjhFOCbT0I5U7H
 10yaipwdVWBpcCo20K6dsi8o27LhVFPKvYJU/hXjsTOMK6d8+80x+eM+YfrzKuJwPBpX
 suBAGkgWKx1N+p7jDBsZCB1kkRXMxeEO2l3/+hxUZMtHPyoUv+RBZf7nYeLa/CteDRCQ
 49cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877955; x=1780482755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I9340WSLhVpvCMgW/nLw1BtgOmu1GxYGZiZMrp9lCdw=;
 b=lJpjJE2uFhP0VN0AkspF/0fLa05JXbaYJQm67Dyd6i0DTmrkVju1TrLP+zrG8Zs3T0
 bxHDP57FN0v9p6ZsuzhjUZLzSQEb/7mTsA/knHLg2z1o34om1zorarBS6ad/bzRmgxP5
 rfiohuCiWBrA+VnTROZSlqFdUlT+EC2Z6eqV5FJrlZAsAlugyqnTKPVKfeToG3/xrxXP
 3M+UUSY0a+GCjSniVc/x4EZK42SIVf0kJ4/P+ehDJxuMbORwCtcpBEJt+pGfewoOsvBc
 k7BwnHzqAnfSykvLVnYYTz8iseGWwqfJQYr61sKPRLzblRJLB7Zm3cDr7NzhR71Jpgzf
 9VAQ==
X-Gm-Message-State: AOJu0YwfoxnreuALMOU/KiyQbuKY3u1QZr9tg1Itmj67u83EqVZcIxyO
 sBqKEEn4rAGfBjL7cwLPXi1zmvGb+qt/ve4AvlqtwZffvBTDym9syKfYa50SvRpBjdonktw7Dkv
 tXCiNZrTikg==
X-Gm-Gg: Acq92OHxH/NSCqcIzxfuZF/Mgc7sRmJwmWDEuCrE4DL3BGB2yyZtqwFTzjo2Lc3M60A
 rS0IyLEcRp/4GYW+Gvo+YZUB1aX7X5DjDMk5yIWMdNSucPe0rRt3rfG7+0WdTtNQhSNKT51DrT4
 eEPk+eLbqMFROFqe+wo2AfIpQvl1hZpzPh/mKzPaHL5LvVOfM3ViZbL7uz58FrcJEhQn/AKjhl+
 S/whSDn/OYioThPRevjHi7QfB92Hnf+uzYLxq5aDElpOMAKBPM/Gu3vIhDXrKAPOm85ycNQS1H2
 iTgoTjoEH78IAns9A0Dd7AWD2uiSWEHd243ABlYuhnucg8mdXS2RU7/YoI/raVU4EeSyCDB2TN7
 y5QlR7uzCu2hoBRAnOO1pF/Ix1meP47gHSPFa2a34MtV4opxjXG9F+jsc2GJ76+/tRRzuC70y6I
 IOmZqhq6miywT9ogpLTdwBdGPJXMGCkasE4zbhhv0veHUkpYwnI7rjoa8=
X-Received: by 2002:a05:600c:8692:b0:490:3fa2:1b93 with SMTP id
 5b1f17b1804b1-490424b0e35mr239428855e9.13.1779877954902; 
 Wed, 27 May 2026 03:32:34 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809c313csm13582855e9.30.2026.05.27.03.32.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] target/arm: Introduce common system/user meson source set
Date: Wed, 27 May 2026 12:30:21 +0200
Message-ID: <20260527103037.4461-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Introduce a source set common to system / user.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-7-philmd@linaro.org>
---
 target/arm/meson.build     | 21 +++++++++--------
 target/arm/tcg/meson.build | 48 ++++++++++++--------------------------
 2 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4723f9f170a..e56fc943bdf 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,7 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
+arm_common_user_system_ss = ss.source_set()
 arm_system_ss = ss.source_set()
 arm_stubs_ss = ss.source_set()
 arm_user_ss = ss.source_set()
@@ -16,6 +17,13 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_common_ss.add(files(
   'mmuidx.c',
 ))
+arm_common_user_system_ss.add(files(
+  'cpregs-gcs.c',
+  'cpregs-pmu.c',
+  'debug_helper.c',
+  'helper.c',
+  'vfp_fpscr.c',
+))
 
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
@@ -26,11 +34,6 @@ arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_user_ss.add(files('cpu.c'))
 arm_stubs_ss.add(files('cpu32-stubs.c'))
 arm_user_ss.add(files(
-  'cpregs-gcs.c',
-  'cpregs-pmu.c',
-  'debug_helper.c',
-  'helper.c',
-  'vfp_fpscr.c',
   'el2-stubs.c',
   'cpregs-omap-stub.c',
 ))
@@ -45,15 +48,10 @@ arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
   'cortex-regs.c',
-  'cpregs-gcs.c',
   'cpregs-omap.c',
-  'cpregs-pmu.c',
   'cpu-irq.c',
-  'debug_helper.c',
-  'helper.c',
   'machine.c',
   'ptw.c',
-  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
@@ -65,6 +63,9 @@ else
     arm_common_system_ss.add(files('tcg-stubs.c'))
 endif
 
+arm_user_ss.add_all(arm_common_user_system_ss)
+arm_common_system_ss.add_all(arm_common_user_system_ss)
+
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1b751d59183..b0f5342245b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -52,60 +52,42 @@ arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
-
 arm_common_ss.add(files(
   'arith_helper.c',
   'crypto_helper.c',
   'idau.c',
 ))
 
-arm_common_system_ss.add(
+arm_common_user_system_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
   translate32_d,
   vfp_d,
   files(
-  'cpregs-at.c',
   'debug.c',
-  'gicv5-cpuif.c',
-  'hflags.c',
   'gengvec.c',
+  'hflags.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
+  'translate.c',
+  'translate-m-nocp.c',
+  'translate-mve.c',
+  'translate-neon.c',
+  'translate-vfp.c',
+  'vec_helper.c',
+  'vfp_helper.c',
+))
+
+arm_common_system_ss.add(files(
+  'cpregs-at.c',
+  'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
-  'translate.c',
-  'translate-m-nocp.c',
-  'translate-mve.c',
-  'translate-neon.c',
-  'translate-vfp.c',
-  'vec_helper.c',
-  'vfp_helper.c',
 ))
-arm_user_ss.add(
-  m_nocp_d,
-  mve_d,
-  neon_d,
-  translate32_d,
-  vfp_d,
-  files(
-  'debug.c',
-  'gengvec.c',
-  'hflags.c',
-  'm_helper.c',
-  'mve_helper.c',
-  'neon_helper.c',
-  'op_helper.c',
+arm_user_ss.add(files(
   'tlb_helper.c',
-  'translate.c',
-  'translate-m-nocp.c',
-  'translate-mve.c',
-  'translate-neon.c',
-  'translate-vfp.c',
-  'vec_helper.c',
-  'vfp_helper.c',
 ))
-- 
2.53.0



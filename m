Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C1CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyXw-00017E-8X; Tue, 26 May 2026 16:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXT-0000tW-NC
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXR-0007GT-N9
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso24665375e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827888; x=1780432688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BmrS6PfjgNRH4hAg0Ule6cUXehh+gM7pH213WKG5vs=;
 b=ZmWwKhgoNolNGfss6UgmBPp+z1sFrH6CXfWrl2PlYOzBWr/JghQDXTOFSIfwpWBkP7
 +VB/caI1KARGfVxedcGA+5JeDRu4yZpaTck4/Iku4ELcIPnVWPQfa/s9s1iUTtgmsrIF
 g4W9nF7/a8UPSKcYkqd6FSixtoHMqpYGw/w+++/PVgvkkl+Y2FzxSbnZN1ChLMkanr/w
 dlJBVCF2/hkHAPJH0qc0Y6Q2l0XW9zTiARD17XsFYckt3IOFZJ/CaAGh0GEjdotC9Dl0
 IKtcXOzs794ES/LSCHMjrZrva8JwkPpNRozgA3b1gxo66d4+9wd7u1pm5Q7dO158knuk
 8rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827888; x=1780432688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+BmrS6PfjgNRH4hAg0Ule6cUXehh+gM7pH213WKG5vs=;
 b=B2TT4woahQEVBg0S6NXjudPvGZcd01i5s7L6K3Li/A/jqv7kBI9yQXa7b9qljb+SqD
 D1zK5GXFdVZEu5sFy1BJjYTu1/WYTMu1qOUUCzy0UFuF5zzVQlnusKE/Zj/zedW9dGKa
 sVhoZJIu7JM+FbOtqWkhO9kWDv0l3e2a9YwmA06JTSmGt2Slt+vWphn38DgenzawhTxv
 /0+hB2VhD/Av/td3rfbL0WpkkJ8vfgEna7ZjR8hEcpLVamm7hVGe0U/YTqOEYX9YqZG/
 g8SXN7TYuEXLfroehmt9mBNr8Q96KD5uD+NRCt7TVI0w69cdTJKfk1vZW4XBKCnQcW8+
 IgEg==
X-Gm-Message-State: AOJu0YxV0nzH2Nih0PydyCML+91le5SuYzXh0oOBZs3EQEYwVQ2Onfu3
 oj0xCws4kV5rlQvdyr22cL1SmNG+eSbSCI/iZ+C0fb3sXXyVVUY8+ydh7awjrRyCZWJ4szyXDya
 rbg3rRzsYAA==
X-Gm-Gg: Acq92OHvHZhe+UiDHaoxWxmAWkfc0Cr6cDZrDml4B7Rl98Da2ZW5B72AORmaTwUzadW
 azUGODPlU/PmI+sLt6GumUgFG0rSCttPAWsHq40FY5Gn+E2qMgfkCeuLwIGE2Ys5Sp0ZxP2kOZ7
 oFPnVjvYIBrHgndAgTa6j5MSWOYnYoeZsDj+Do72QVQtsl3dQ3EG4FPG3gY7ir3MsPwkeneV4ch
 CR7LKqwdk2a5vcK8N9MNLdtLjKuP13NYSNynkaxIKZy+WVMhDuWK6S1kPS8Ta43X0JBiqQZqyDG
 DVM/xS61PUPR+zM6xbbd88Ux0g/qlFNUlsyskBRoyeHZaXiqIzcpEtk5/2a5s6nis8qVaVmPfzf
 /aBwQYTj/g9PlUOrdR67r06MXSLdZ6fZKS4mSpylFVSTm19bTiFnOdEbNoGvsUlt+86Cn/X8D4v
 bowhYuMXV3ecgcPSLh1zFWhkTGVbD4GD+DwiUeFgpF0ewjypUCzgdtAW4=
X-Received: by 2002:a05:600c:46cb:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-49042482762mr345711305e9.4.1779827888066; 
 Tue, 26 May 2026 13:38:08 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809d84fasm1213755e9.36.2026.05.26.13.38.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 06/17] target/arm: Introduce common system/user meson
 source set
Date: Tue, 26 May 2026 22:37:11 +0200
Message-ID: <20260526203722.79463-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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



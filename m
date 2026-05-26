Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14291CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYj-00035R-KR; Tue, 26 May 2026 16:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYb-0002Ny-6Z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYY-0007vf-WE
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso73968575e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827957; x=1780432757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9RfiJaGaTxvcmkspycX1omqRDuYiIKpPiWhd16yBBk=;
 b=bAdb5SCnXs9LTbQZ39K06/KlDnoeNgj50hJKm+5EWAyfcX+PqPgZ+G/wWvVVHO2cZr
 fLBQHVsWC7vZ7hAz75cZRhhYjJDY20pCsJ9onlpff7JvQhVi8vrkLApkV8R8LuQZRjCs
 jCFUdumwLzwZawUwZUK0850x0q1kMqjJfCxfRx6XksEpiIFihP1H/cloEb8sogT2diN5
 jrGxmCF30pfO4dMC3ia1lrtrDcqP3kihMOvDVkKQmRaYZY7NsVvpvQbtQbBnNZEwxuwy
 d30MKwQLVmQwPjPfUmPiv8yhG3uPxbdl3zX21ngNHCEjdm0BLEID7CTIWLVgxnpTxbJv
 fHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827957; x=1780432757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9RfiJaGaTxvcmkspycX1omqRDuYiIKpPiWhd16yBBk=;
 b=IcARhVVGmrI+FOE4ewDQqwwPtOGPIeb1xqtAQ2KGbgtSWI5N1/y2/UwhBabnYO6sfi
 76MUTXi8Fwk7CT7errotxS2JvppFaw20xwmuoaXg80XJH3X3O3VIWnlmoFKWA9PW7z6X
 v+jwQjcbT0t2pJ3V+tcRCtBl3PwBqAxZt9kuNXT994oKjSrZ9W7Ark+hPMU/+EiMtclB
 ZB8YfjiXFXffaTRPfLKtM55FJv5NfHabRoo5YxW426eDvaCqiLeetlJlI5QfRKp8y88n
 oKm/oO4LYkxugWpuWiBIuyCkTiXmEQ1PtlrgWWT+Uc0YLXMeBpksUkI0rVMw2Qh1SCWU
 Ktyw==
X-Gm-Message-State: AOJu0YxAjLNFD/1A2yrM/VaE7+MWDLqrwQTGpwADwhginmy86DsuRUIW
 RNzdfikVasIZEPhKG7VxiR6iz1xiL4TzkA/NxZniOk4rje9Qcwj0BDYY1fJu6NhXN6DHBJjGe6y
 94mLD4z3MYg==
X-Gm-Gg: Acq92OEsHljsGa6T/Bf24C7TqlSRJxhXZvd2WPGavdHhSlXycYCPLSQ8OVSgig6Og1l
 fdoKPFhptQq03kVJwS3RDv2ktI20zj6AjscVjkWQChQadIu732zS/8g76eLSRG5fbsDBHoANJSX
 j611yTlxkF71Uj5wZNb089Lcvrt2Y7HctqcP+ohVytTsZIcenhUZ6ihVdPrns8mOENhAJM17+gc
 mbcHnrJd5F8PHPeEC2Fg6CkKvpSMYs8x+4lyoExRFcoSIOmCuXP5PVPsKw6UMHYf9mPJDjoPVZV
 tcHQEYsnmPgBzg3mZlVPMjCl0GDNok+0FNS/hwxppWfeF4G91QdZiTNiGguAv3mTeALSYe2+17v
 Y9FZ6uyajlmkJ3ksZNbCUKEstQiUKP5eiWphObCSwYS+YOIIBLWSrhyFsHvpR8AXBp6W5GxPfcR
 7REo4yu71CqJOonthgFZh+Q0NVU14Sdi+yX8npDnpH6Y9w453j3HyV2uYq2ZXxFXVOrg==
X-Received: by 2002:a05:600c:4f53:b0:490:7136:ad05 with SMTP id
 5b1f17b1804b1-4907136ae08mr97548415e9.31.1779827957434; 
 Tue, 26 May 2026 13:39:17 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm894674f8f.12.2026.05.26.13.39.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:39:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 16/17] target/arm: Build cpu32-system.o as common object
Date: Tue, 26 May 2026 22:37:21 +0200
Message-ID: <20260526203722.79463-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
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

cpu32.c only contains CPU types used in 32-bit system emulation:
rename it as cpu32-system.c; always compile the file but only
register the QOM types for the 32-bit binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 10 +---------
 target/arm/tcg/meson.build                 |  5 +----
 2 files changed, 2 insertions(+), 13 deletions(-)
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (99%)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32-system.c
similarity index 99%
rename from target/arm/tcg/cpu32.c
rename to target/arm/tcg/cpu32-system.c
index 8220d785f5b..6e983900899 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32-system.c
@@ -1,5 +1,5 @@
 /*
- * QEMU ARM TCG-only CPUs.
+ * QEMU ARM TCG-only CPUs (not needed for the AArch64 linux-user build)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -13,15 +13,9 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
-#if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
-#endif
 #include "cpregs.h"
 
-
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -746,5 +740,3 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
-
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index d5a95bf54f2..9b859892ed8 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,10 +30,6 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
-  'cpu32.c',
-))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -85,6 +81,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
+  'cpu32-system.c',
   'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E97EF99C1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxJr-0006Pw-VV; Fri, 13 Feb 2026 12:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJq-0006PN-Ij
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:51:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxJp-0006Ri-23
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:51:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1289549f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771005063; x=1771609863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEmqrlEPfr3VxIubnpUown2ZwCCfc3yJtNI9ot+KsMA=;
 b=yIq6EGexiaPGZCK6sijLlo42cTWlKsDQmGR1aoSWEFk5fJIwja+qmwVvIrIn4+KDSx
 ZYOnrc5S4yjCPkw3E5v7jWrxRFyF7OxUHCvLSZ5Dzv9Qb+2kg9ZUvlIZMOJV7CNsqQWR
 e8FC8hIaFQT+N0jimZPQ6Mh429EXCYgcxpNc1DxTfZpKOfgORUIiGgzCvoqBN9JWx3Kj
 V2BQnGbtneilBvNu8j6ujcm5CvPXlXyPUPIEiQxZkwYyIjtfPEXj02wfJBHbvQ80no+M
 86GApmSWMgMciucWJLuEzkp2aPf1nLUyfugvBW1YcH6qnWr8pgZWWu5Q32JG3FAl4Ej7
 uMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005063; x=1771609863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEmqrlEPfr3VxIubnpUown2ZwCCfc3yJtNI9ot+KsMA=;
 b=bHejPqVmmrPS1hpCmigEi3WgxWfkUopJSs41Vh8WZvvUv0yX92+hKm43yDgG5sX/94
 /pxV+pWlnp4kMCyp1qKycXkioQN9eeJw+5l2SL8wUNygUb+3iS7jEcZhJMEWYL355UV6
 QFG+SsZz0fqdZoCYCa5iiznBfrvIpytO/+0NI4Gmsx6c7ynbEepzgchOt7LjL6g8O1/y
 a06We5RAqwJyHikn/Tt0S3llfazcGue2AXONu+BPnf/vo/sheUflSs4ONeeCQBfhynzV
 C9Vx8f3QbkCpA64yPIw8+0WlGBMBQNDvqfa6cVoHjzJ9Ykiv9WggmAw5/JRT45b+vnfr
 mKIg==
X-Gm-Message-State: AOJu0YxnKRjqgvWh5InQDrR3q2vhQvSSzkkgvlnhg8DEgNrHduiooWCt
 XaTTPnWNyg8jqYGNWeJ0b2HvW0pKubRyU+zAd1XOYlT18SceATOJWPn2M61dS3TtnFibooAOlNW
 r1Pu7ix4=
X-Gm-Gg: AZuq6aJ3J4XqbM0Di3bPn5IenszSwRC1BLuiGvnZK+tbhz8wZKFs3qFq4D7XURKU8ym
 r3BMOqCjZm0mR2yvatuL6zzbL05joGPZJCsoRVWoQ3bmwkPgo7SsNMbTX8E7P7HBwOLc4561dR1
 v4WvxuP+jMCEloCBq2CwOdOkpOQcUN8ftanJx/F1DgDBVJvNRogctDLwGTALZGyxmgZhHMFLXUa
 WkNZkMb+uSu/oi7VH5MmBvHWnZ/sVDJJrx3DpqJIHTT3iQmo0PUJxwY5mS7MA0Vph6Odxdxn8nw
 qKc7+8LulnDXX0wEA/l0zfX42Z+ImJNnlKjuiVQtY7uGv2LQM/KWFwlbPoskBULDGckCF3pclIK
 qqp0y+Q1qDq3tnxbNfn9+eldXRfNbnYyHEry4dACwwPRza3IMKRBdCJdINt1hKPoOUmZxggxG8/
 3C0jloRvCGw918ShkIzHv5LM3PSWTRwpDceyWfYy3l25mdyoUJRZHJLqegK+H7HUptJVQaSUJt
X-Received: by 2002:a05:6000:402a:b0:435:db95:c2d3 with SMTP id
 ffacd0b85a97d-4379db93486mr553703f8f.36.1771005063191; 
 Fri, 13 Feb 2026 09:51:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc8b1sm7500054f8f.23.2026.02.13.09.51.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:51:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 4/5] system: Make qemu_arch_available() common code
Date: Fri, 13 Feb 2026 18:50:31 +0100
Message-ID: <20260213175032.32121-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213175032.32121-1-philmd@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove the need of per-target QEMU_ARCH. Define the
QEMU_ARCH_* constants based on SYS_EMU_TARGET_* ones,
themselves already exposed via target_arch(), allowing
to check the current target is included in @arch_bitmask.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                |  2 --
 include/system/arch_init.h | 54 ++++++++++++++++++++++++--------------
 system/arch_init.c         |  6 +++--
 system/meson.build         |  2 +-
 4 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/meson.build b/meson.build
index 4af32c3e1f2..fc79a1d9aed 100644
--- a/meson.build
+++ b/meson.build
@@ -3375,8 +3375,6 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
-  config_target_data.set('QEMU_ARCH',
-                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
   config_target_h += {target: configure_file(output: target + '-config-target.h',
                                                configuration: config_target_data)}
 
diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index 92d50ba8d63..bb17d18a2b5 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -1,30 +1,44 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
 
+#include "qapi/qapi-types-machine.h"
 
 enum {
-    QEMU_ARCH_ALL = -1,
-    QEMU_ARCH_ALPHA = (1 << 0),
-    QEMU_ARCH_ARM = (1 << 1),
-    QEMU_ARCH_I386 = (1 << 3),
-    QEMU_ARCH_M68K = (1 << 4),
-    QEMU_ARCH_MICROBLAZE = (1 << 6),
-    QEMU_ARCH_MIPS = (1 << 7),
-    QEMU_ARCH_PPC = (1 << 8),
-    QEMU_ARCH_S390X = (1 << 9),
-    QEMU_ARCH_SH4 = (1 << 10),
-    QEMU_ARCH_SPARC = (1 << 11),
-    QEMU_ARCH_XTENSA = (1 << 12),
-    QEMU_ARCH_OR1K = (1 << 13),
-    QEMU_ARCH_TRICORE = (1 << 16),
-    QEMU_ARCH_HPPA = (1 << 18),
-    QEMU_ARCH_RISCV = (1 << 19),
-    QEMU_ARCH_RX = (1 << 20),
-    QEMU_ARCH_AVR = (1 << 21),
-    QEMU_ARCH_HEXAGON = (1 << 22),
-    QEMU_ARCH_LOONGARCH = (1 << 23),
+    QEMU_ARCH_ALPHA =       (1UL << SYS_EMU_TARGET_ALPHA),
+    QEMU_ARCH_ARM =         (1UL << SYS_EMU_TARGET_ARM) |
+                            (1UL << SYS_EMU_TARGET_AARCH64),
+    QEMU_ARCH_I386 =        (1UL << SYS_EMU_TARGET_I386) |
+                            (1UL << SYS_EMU_TARGET_X86_64),
+    QEMU_ARCH_M68K =        (1UL << SYS_EMU_TARGET_M68K),
+    QEMU_ARCH_MICROBLAZE =  (1UL << SYS_EMU_TARGET_MICROBLAZE) |
+                            (1UL << SYS_EMU_TARGET_MICROBLAZEEL),
+    QEMU_ARCH_MIPS =        (1UL << SYS_EMU_TARGET_MIPS) |
+                            (1UL << SYS_EMU_TARGET_MIPSEL) |
+                            (1UL << SYS_EMU_TARGET_MIPS64) |
+                            (1UL << SYS_EMU_TARGET_MIPS64EL),
+    QEMU_ARCH_PPC =         (1UL << SYS_EMU_TARGET_PPC) |
+                            (1UL << SYS_EMU_TARGET_PPC64),
+    QEMU_ARCH_S390X =       (1UL << SYS_EMU_TARGET_S390X),
+    QEMU_ARCH_SH4 =         (1UL << SYS_EMU_TARGET_SH4) |
+                            (1UL << SYS_EMU_TARGET_SH4EB),
+    QEMU_ARCH_SPARC =       (1UL << SYS_EMU_TARGET_SPARC) |
+                            (1UL << SYS_EMU_TARGET_SPARC64),
+    QEMU_ARCH_XTENSA =      (1UL << SYS_EMU_TARGET_XTENSA) |
+                            (1UL << SYS_EMU_TARGET_XTENSAEB),
+    QEMU_ARCH_OR1K =        (1UL << SYS_EMU_TARGET_OR1K),
+    QEMU_ARCH_TRICORE =     (1UL << SYS_EMU_TARGET_TRICORE),
+    QEMU_ARCH_HPPA =        (1UL << SYS_EMU_TARGET_HPPA),
+    QEMU_ARCH_RISCV =       (1UL << SYS_EMU_TARGET_RISCV32) |
+                            (1UL << SYS_EMU_TARGET_RISCV64),
+    QEMU_ARCH_RX =          (1UL << SYS_EMU_TARGET_RX),
+    QEMU_ARCH_AVR =         (1UL << SYS_EMU_TARGET_AVR),
+    QEMU_ARCH_HEXAGON =     (1UL << SYS_EMU_TARGET_HEXAGON),
+    QEMU_ARCH_LOONGARCH =   (1UL << SYS_EMU_TARGET_LOONGARCH64),
+    QEMU_ARCH_ALL =         UINT32_MAX,
 };
 
+QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
+
 /**
  * qemu_arch_available:
  * @arch_bitmask: bitmask of QEMU_ARCH_* constants
diff --git a/system/arch_init.c b/system/arch_init.c
index d7ec6e69c79..604d5909ed0 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -23,8 +23,10 @@
  */
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
+#include "qemu/bitops.h"
+#include "qemu/target-info-qapi.h"
 
-bool qemu_arch_available(uint32_t arch_bitmask);
+bool qemu_arch_available(uint32_t arch_bitmask)
 {
-    return arch_bitmask & QEMU_ARCH;
+    return extract32(arch_bitmask, target_arch(), 1);
 }
diff --git a/system/meson.build b/system/meson.build
index 4b69ef0f5fb..d91703d3dcc 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,5 +1,4 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
-  'arch_init.c',
   'globals-target.c',
 )])
 
@@ -8,6 +7,7 @@ system_ss.add(files(
 ), sdl, libpmem, libdaxctl)
 
 system_ss.add(files(
+  'arch_init.c',
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3516FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdja-0005bm-Qx; Wed, 22 Apr 2026 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdj3-0005JD-6l
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiu-0000M1-IH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48374014a77so76712505e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887938; x=1777492738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OrnARuNzUHNNI8g6F7T4QivnH4d/Pdmxcu0H1J+19NU=;
 b=K3QTS0wbN2lfHAdYabHVQ6OsbdRYXdmaSyIARrUQFa1XqludMrM5sjydEjVLa5AXzz
 jEN0YcIiquRN/HQICYpUEqUM4rC7+t0ioQOEyt21fHaBA3VfiLrzOgUrcZtuIcvEgyBR
 fDDD/O27Sj+jLdtjwFNbiYguR5RmyN4jlo1h98z7WOnQwuzRMchEutlvptm8anfuQluE
 qewauo+YtPFLy48DiZ9PCRitMY4Z7At8cqa5Lirmd4BMDUsViPuIXuXyYpffAD3IhSTP
 jQR4H8PywRRJJBTaBQGd7tvltRg4O3oNXGuSDsBQTpGjBKnHYWwUE/MV0DFla14r5shA
 U7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887938; x=1777492738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OrnARuNzUHNNI8g6F7T4QivnH4d/Pdmxcu0H1J+19NU=;
 b=jCr8XNXGp/s/n0X15RRa9SAsynt1Z4Ol+cBnIz50oeWMwPKgPqp6gTb/+Ie/aZTXLY
 r2aeFWnr5uRiB9uAMmpuiIH551bVHVED0hH6L9Gq2cQYbEOX4ecfeQSRgrOe1S1kGiJv
 9VCeRqE4PHkc5VJQR9Ngm8FRgbn2C+EGe1jgRhgHkYoGffHULFi18cwf6P01rnZEMofa
 egWu63kPMHuryghMmoc//UmyE73P+/xbdRJxDmNB9hOTxMLOba9R4AsdKMvXCF3oZDwb
 Ju17GBgv6R/soZQXpnKtWbZ+/oDRM6DzslIRP4PMGnqJMrhoMZXG9suTWfffFg0MoYmX
 EZNg==
X-Gm-Message-State: AOJu0YxzKOTc+BtMHovgr7YUsfEmYyZiAqLyOJPgNsfFCBMuFB1+Utj2
 ElFx3YaNmL+rd/2ZpD4Ds8GLsq5IT33fURB+iNkXpm9Rq5AyBK7efdtrg8QWjJhPq5ElvxgO1fM
 T/fPsudE=
X-Gm-Gg: AeBDiesYVoZKL567SEbGjIEJDsGOK+1ECMMXVHaRIs2A+MVC/evND+burlQsqqLr82G
 32ukshrogMH8DPwXCUcRtKnqWq9Ql75MQbSsEPCQHeIEkJnZDmgPWcMCCWXssMsszQlYzP5xRSZ
 HNL80vzOFAwZ2lnwHnchHsLqU+pr0P0I5ukaYl5/kTmEjRAitRDjiu/Le1LC/m/kNFShdH31c4D
 WgFrWjVgtbOl3/4LHbFs7MkfTzN/qGra+RMTWCkE1mcaIp2zD35wdMr7ljbF4R0wbI3FbZr9uw+
 8wGUV8bw5CdOLRH1guX/Ny3yFQU6Qv27kggG8FT+GhvDtNolmBw0NH9Wfa5znLTXmmLTrMwRYFA
 CUL3O+lhJxu3BvsFMCkpfhfdO/EqJIN+DmqTxI0isocZPXy0rVDZQ7vB2KqANkPDyGmJtcuK/Lu
 6s3rF/+qOynqeLbqrnwLHXF6zA5f30eZVSn8mEfqHQ24pz3bB8+B8Q7mhc7wVV3C+xwkgh+OSe3
 2g3e70jeh8=
X-Received: by 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id
 5b1f17b1804b1-4890c57760emr147567405e9.31.1776887938437; 
 Wed, 22 Apr 2026 12:58:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm62641665e9.31.2026.04.22.12.58.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/48] hw/mips: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:08 +0200
Message-ID: <20260422195746.88865-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-28-philmd@linaro.org>
---
 include/hw/intc/mips_gic.h | 2 +-
 hw/mips/bootloader.c       | 2 +-
 hw/mips/fuloong2e.c        | 2 +-
 hw/mips/jazz.c             | 2 +-
 hw/mips/malta.c            | 2 +-
 hw/misc/mips_cpc.c         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index e2e6f0a168c..b3b64fec855 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -14,7 +14,7 @@
 #include "qemu/units.h"
 #include "hw/timer/mips_gictimer.h"
 #include "hw/core/sysbus.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "qom/object.h"
 /*
  * GIC Specific definitions
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 1dd6ef20968..aa4abcf4c36 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "hw/mips/bootloader.h"
 
 typedef enum bl_reg {
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 72ad4507dfa..9a712ee9309 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -22,7 +22,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "hw/core/clock.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index e0adb96c548..bec534d38b0 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -52,7 +52,7 @@
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 #endif /* CONFIG_TCG */
-#include "cpu.h"
+#include "target/mips/cpu.h"
 
 enum jazz_model_e {
     JAZZ_MAGNUM,
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 812ff64d831..0cbe9956e74 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -61,7 +61,7 @@
 #include "hw/core/qdev-clock.h"
 #include "target/mips/internal.h"
 #include "trace.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 
 #define ENVP_PADDR          0x2000
 #define ENVP_VADDR          cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index d092f76f44d..9d9c8bf6ec8 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
-- 
2.53.0



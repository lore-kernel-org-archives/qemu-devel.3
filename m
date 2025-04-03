Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42E1C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUi-0005t6-A3; Thu, 03 Apr 2025 20:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUW-0005QF-13
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUU-00034i-EM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso14790655e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724856; x=1744329656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cdt0hEBhBGBOeVvjrYC1cczHi2xnkVQcQE65ySBiFwY=;
 b=ShBQnjBwxUKy/8+CmC//p+Dj6h5WDUXtIWmObLxHv5h44GMqyyvaZygtHpSEJQniXp
 30eDZUIqLkFAjlSdFTaPWSzqLvWFcQx6bdm9gvepcOBIHPMkmHtaHYoWdJZSTKjWjbej
 fzPRuJOanxonssZxp0kckf8h8h9WRbgOaFzjzaeY9WpK6zdlWHAohgq5/ie8FW3kCbQK
 m4eBllBAD2crIyr1sk2zgab8jE69NI1k5V/8cPa1fjzKdY83LaQIz6iEpuPnNFb5BgNd
 CTwCdCS1wFqWnamYPTXwNn0WlTO2la/htKK2OgUaySQMHeb1E0qk8xuCZ+bBHf1KOhVt
 ztaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724856; x=1744329656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cdt0hEBhBGBOeVvjrYC1cczHi2xnkVQcQE65ySBiFwY=;
 b=fmK9giOyKt/PDV6O8gWx3CWAz3kqns41VgYbQ8aF2QX7OigWcW7aSvDCx7FIX/fZKi
 Pd3aR8emcEcFSX+WFXBgmuBgDXYi3KQup0VqtigdbuXHKKU65065L6ZKLSEIzDgFe8FS
 n9iqbmQUNfy5aT77+vwNo0DDHd0ZXzTTeZAIrFYA1nEahsbk5mZvjrQCBbg7AMsJMzW7
 t+fcV+o3Qs6qjNFmpcdF0OB0w5xLGLZcl2nQZEivPJkFi7O76q4F0KcBHEbC91yLhnjc
 e8LbSTL/V/JfFwWUPuUp4mS3vBUPUL5WTu8AQaIHRFCcn2VRO5SYcsO0OU6aPuLyHQ1Y
 LBEQ==
X-Gm-Message-State: AOJu0Yw5GrJd48e+UwDIm5FeUITUVHSf3IHO3hzNzBl/A3dInINxwT+i
 UodvoWrobu0ZIBpQ6Q5ObMdqyabnieyRsB+xos/x02mO7s/AuWFHMGn5fbsuu+fmwbTlsXw1yOH
 Q
X-Gm-Gg: ASbGncvsjKNNu5FAVxwulmJN4OSn5ACAnOJeM86HjApCt1TysP/4/7XXIApAyC8ytkj
 MnbqLlfK2IR6v2sRaB7YrBe8rfesCoHEV4mI0d2UHYlddYu7EhUTc6H0n72aGz9k2DI9wu8oC6S
 /P0EFNAAGiWByLbYMZV+/7PO6DhDwLcw3Xx+7cNkn63ykNhbqQKrepdsLjKL5fLkdWrx/wn0rsH
 5FUb65L9OsMuFJseVGmraEevhw4+MgDryeQgcEzdY9Fm2u9pLJgH6MyeDcf0nXQWVb7Gmr4SEL6
 IIDcK14AmI19XuWJTJOjGOMkQns0FR+TQN+TkE8lRHtgjCgUfjeYqR0RnS2XrLAvD8MdT7lruL4
 BVan7uzKpow08Ml1CCw0=
X-Google-Smtp-Source: AGHT+IEqZyd9GIfN/fyi7zrWJCxEgusjwLJRf5dLfiHsYEpiwpt851kiIrU0p1MzYWj2d1pmP3cn3g==
X-Received: by 2002:a5d:5f83:0:b0:390:ee01:68fa with SMTP id
 ffacd0b85a97d-39d0de2564cmr576097f8f.24.1743724856425; 
 Thu, 03 Apr 2025 17:00:56 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3669d0fsm31250975e9.36.2025.04.03.17.00.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 23/39] hw/arm/realview: Replace arm_feature() ->
 arm_cpu_has_feature()
Date: Fri,  4 Apr 2025 01:58:05 +0200
Message-ID: <20250403235821.9909-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

By using arm_cpu_has_feature() instead of arm_feature()
we don't need to include "cpu.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/realview.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f81d084eb80..48cfe05add0 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
@@ -31,6 +30,7 @@
 #include "hw/sd/sd.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu_has_feature.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -77,7 +77,6 @@ static void realview_init(MachineState *machine,
                           enum realview_board_type board_type)
 {
     ARMCPU *cpu = NULL;
-    CPUARMState *env;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram_lo;
     MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
@@ -138,16 +137,15 @@ static void realview_init(MachineState *machine,
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpuobj), ARM_CPU_IRQ);
     }
     cpu = ARM_CPU(first_cpu);
-    env = &cpu->env;
-    if (arm_feature(env, ARM_FEATURE_V7)) {
+    if (arm_cpu_has_feature(cpu, ARM_FEATURE_V7)) {
         if (is_mpcore) {
             proc_id = 0x0c000000;
         } else {
             proc_id = 0x0e000000;
         }
-    } else if (arm_feature(env, ARM_FEATURE_V6K)) {
+    } else if (arm_cpu_has_feature(cpu, ARM_FEATURE_V6K)) {
         proc_id = 0x06000000;
-    } else if (arm_feature(env, ARM_FEATURE_V6)) {
+    } else if (arm_cpu_has_feature(cpu, ARM_FEATURE_V6)) {
         proc_id = 0x04000000;
     } else {
         proc_id = 0x02000000;
-- 
2.47.1



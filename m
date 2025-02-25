Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07830C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLd-0005gS-7B; Tue, 25 Feb 2025 13:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJZ-000071-47
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJT-0002If-8S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso4759707f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506744; x=1741111544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1po+NKvKzs7P6OuK7YQBa3sSSQDGisQWVgPTwSnGbDk=;
 b=tNRoZMxcCkus+tFfc3b7c7Q5Xpp2o8VOaovbuYoNnDs937kuOA1keTtMnik6uVhwZu
 PaW/7kRjKLdVOVyVY5cqRVf8SDtIRdtV6vCSe/cg4he85RXtVGteRmXgXev0gJ7qO4gx
 PIijtsKnTnGFLyZltgzKv0AHDLyQqau7/7TbcJYSgEGzG6w5fIS7Xt82gmBhJ5mH6M2J
 46ruu68MliRZp64J/EOfqP7bVQYFueQuTN5AkyQ8leOIU3NV6A8oOHsgVXBMfavVeig5
 G4YEKl4e4Jc2ToaxYYLZQLkws9I4cWmMhzD4WEWbYGs3LHQDE6gSjqKbN9SeQTFOJgbX
 n7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506744; x=1741111544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1po+NKvKzs7P6OuK7YQBa3sSSQDGisQWVgPTwSnGbDk=;
 b=ilvhW09hMFec64NraJzU5zz8n+h+on93GstQI2fn2CNZoyTCDnv1xelYDmsX7mLCWF
 EOW5oFGKK8zU/xrwIUbkCY85QttIVBWbzAuGgYLTot4BbXg1o4px2Uem1U7/5zWFdVtA
 gobKNaVy+UyjbkF4T3o3DSp5/7g5nHVvyyFmd3PXxD8nXzp4UzJzxnL6UM/X9WyDT1VS
 VGv3+GxC1IbzHt8MkO6VRP5QNaZnuK2YdeqDWOdm0QAMAVjuJqWly14PQzDmPZCNGxeT
 z/dEjLXbzM3oTZs14lNVAHccvNjyGynaHMS0Ys6+gECQMxvIK0xj1r0uTsyTGSugHk2r
 jfjA==
X-Gm-Message-State: AOJu0YyfICJ+t+/lTKCInlqNjCd2Gf62sx2rLVreuDz7qqR+tvIUB7jC
 MfLylSojTdGO1x9j5lcxhw/pnEZrEM00QMmEumR4CBSgIQEblRusyVi9hE0S+w7dnrWSA8cJy5W
 W
X-Gm-Gg: ASbGnctc8WU7suh9nUzSvjpTPewcgbwcNGOddQwrl/AaPs4wyNhy8ALBLwfVtOuMiNn
 Ai2s9iziWD9A/C9t5Hf4PpEReYIe+nCr6jIr59feAkL9jKcNzL1XEEi/Z4Uz2tYcWtzQSVgzmqj
 ig4NyS211k86ukw7aKJ+4nmUP1UvqKaagio6HlX+4Rx2m3K3Es8eS0cw09FrAUniA9lExZszD64
 uA6XnSRefp+cn7hUGXJSAR9ODCL4THD+90ZjOoMOf/JOTMR5+Q044LTbWPcCWD9hwKu9nJ0K1W2
 SyDSB4HaRpmw8a3u2fY+XPtejBmKVAK1
X-Google-Smtp-Source: AGHT+IGo/x+PjjwZRIJIsQF81rvJ2UR1Lmt65sW4WUzgP/zjUJSLhHYlJL+pDn8Weu7P/ucaq6j8xQ==
X-Received: by 2002:a5d:64ef:0:b0:38d:da11:df19 with SMTP id
 ffacd0b85a97d-390d4f8b635mr197221f8f.41.1740506744101; 
 Tue, 25 Feb 2025 10:05:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/43] hw/misc/npcm_clk: fix buffer-overflow
Date: Tue, 25 Feb 2025 18:04:53 +0000
Message-ID: <20250225180510.1318207-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Regression introduced by cf76c4
(hw/misc: Add nr_regs and cold_reset_values to NPCM CLK)

cold_reset_values has a different size, depending on device used
(NPCM7xx vs NPCM8xx). However, s->regs has a fixed size, which matches
NPCM8xx. Thus, when initializing a NPCM7xx, we go past cold_reset_values
ending.

Report by asan:
==2066==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55d68a3e97f0 at pc 0x7fcaf2b2d14b bp 0x7ffff0cc3890 sp 0x7ffff0cc3040
READ of size 196 at 0x55d68a3e97f0 thread T0
    #0 0x7fcaf2b2d14a in __interceptor_memcpy ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:827
    #1 0x55d688447e0d in memcpy /usr/include/x86_64-linux-gnu/bits/string_fortified.h:29
    #2 0x55d688447e0d in npcm_clk_enter_reset ../hw/misc/npcm_clk.c:968
    #3 0x55d6899b7213 in resettable_phase_enter ../hw/core/resettable.c:136
    #4 0x55d6899a1ef7 in bus_reset_child_foreach ../hw/core/bus.c:97
    #5 0x55d6899b717d in resettable_child_foreach ../hw/core/resettable.c:92
    #6 0x55d6899b717d in resettable_phase_enter ../hw/core/resettable.c:129
    #7 0x55d6899b4ead in resettable_container_child_foreach ../hw/core/resetcontainer.c:54
    #8 0x55d6899b717d in resettable_child_foreach ../hw/core/resettable.c:92
    #9 0x55d6899b717d in resettable_phase_enter ../hw/core/resettable.c:129
    #10 0x55d6899b7bfa in resettable_assert_reset ../hw/core/resettable.c:55
    #11 0x55d6899b8666 in resettable_reset ../hw/core/resettable.c:45
    #12 0x55d688d15cd2 in qemu_system_reset ../system/runstate.c:527
    #13 0x55d687fc5edd in qdev_machine_creation_done ../hw/core/machine.c:1738
    #14 0x55d688d209bd in qemu_machine_creation_done ../system/vl.c:2779
    #15 0x55d688d209bd in qmp_x_exit_preconfig ../system/vl.c:2807
    #16 0x55d688d281fb in qemu_init ../system/vl.c:3838
    #17 0x55d687ceab12 in main ../system/main.c:68
    #18 0x7fcaef006249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)
    #19 0x7fcaef006304 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x27304)
    #20 0x55d687cf0010 in _start (/home/runner/work/qemu-ci/qemu-ci/build/qemu-system-arm+0x371c010)

0x55d68a3e97f0 is located 0 bytes to the right of global variable 'npcm7xx_cold_reset_values' defined in '../hw/misc/npcm_clk.c:134:23' (0x55d68a3e9780) of size 112

Impacted tests:
Summary of Failures:

check:
  2/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test                         ERROR             9.28s   killed by signal 6 SIGABRT
  4/747 qemu:qtest+qtest-arm / qtest-arm/qom-test                                 ERROR             7.82s   killed by signal 6 SIGABRT
 32/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test           ERROR            10.91s   killed by signal 6 SIGABRT
 35/747 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test                   ERROR            11.33s   killed by signal 6 SIGABRT
114/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_pwm-test                         ERROR             0.98s   killed by signal 6 SIGABRT
115/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp                         ERROR             2.95s   killed by signal 6 SIGABRT
117/747 qemu:qtest+qtest-arm / qtest-arm/test-hmp                                 ERROR             2.54s   killed by signal 6 SIGABRT
151/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_watchdog_timer-test              ERROR             0.96s   killed by signal 6 SIGABRT
247/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_adc-test                         ERROR             0.96s   killed by signal 6 SIGABRT
248/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_gpio-test                        ERROR             1.05s   killed by signal 6 SIGABRT
249/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_rng-test                         ERROR             0.97s   killed by signal 6 SIGABRT
250/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_sdhci-test                       ERROR             0.97s   killed by signal 6 SIGABRT
251/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_smbus-test                       ERROR             0.89s   killed by signal 6 SIGABRT
252/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test                       ERROR             1.09s   killed by signal 6 SIGABRT
253/747 qemu:qtest+qtest-arm / qtest-arm/npcm_gmac-test                           ERROR             1.12s   killed by signal 6 SIGABRT
255/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_emc-test                         ERROR             1.05s   killed by signal 6 SIGABRT

check-functional:
 22/203 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_quanta_gsj                      ERROR             0.79s   exit status 1
 38/203 qemu:func-quick+func-aarch64 / func-aarch64-migration                                        ERROR             1.97s   exit status 1
 45/203 qemu:func-quick+func-arm / func-arm-migration                                                ERROR             1.90s   exit status 1

Fixes: cf76c4e174e1 ("hw/misc: Add nr_regs and cold_reset_values to NPCM CLK")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/npcm_clk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index d1f29759d59..0e85974cf96 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -964,8 +964,9 @@ static void npcm_clk_enter_reset(Object *obj, ResetType type)
     NPCMCLKState *s = NPCM_CLK(obj);
     NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
 
-    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
-    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
+    size_t sizeof_regs = c->nr_regs * sizeof(uint32_t);
+    g_assert(sizeof(s->regs) >= sizeof_regs);
+    memcpy(s->regs, c->cold_reset_values, sizeof_regs);
     s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     npcm7xx_clk_update_all_clocks(s);
     /*
-- 
2.43.0



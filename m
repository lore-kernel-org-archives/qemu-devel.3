Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678DC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KuT-0001US-Vr; Tue, 22 Apr 2025 17:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ku5-00013E-5P
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktx-0000QJ-4G
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22438c356c8so60056495ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356291; x=1745961091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNdVjawedf7L7sOM+y7tXhWt3e7lZuKafuAKLevf0NY=;
 b=tVbcbr8iGqYvQ9OpZmtHTg62Kk4RvN42uKsbdo7FAtyLPMCqboNbYLGqlh2aaI5QgY
 CLJPNSVgFzGgoj0mPNdEf7F8FI/UYK8Wu0m+5zVMGkZKmRHfA/OtObd3j9RzoW8uUtTi
 CeBstWq4utYH/f6eUrnXrDJmB8luBcpvdh1WUZ5+tey6j9CucjTkXz2NzFLvsI1of+kM
 WSCyhwI7JZxGR+53YXv3NO0mmisM0Y+TWE6MJcGSAOLaek0Bk0w+gBImmM6APqhK6gw2
 HBH1YW7GmhD5p+2x4nUqd7CfT0pRYVNZ6PVrQjK+Xu8W0gnTQXjyNVMRLV7ppmYUm51G
 uViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356291; x=1745961091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNdVjawedf7L7sOM+y7tXhWt3e7lZuKafuAKLevf0NY=;
 b=rk8okG7zfHwRMuxWDyfHKE0ZnG/w2FHypQsqAM8/CuC93+0EKiCrXEXRpxO2UqR3L5
 4VOb0aPz231dMDVtVuensWu+sqdM572adnPO9TgYZSNRajjuZvqKXq+NZK9u9lffjoya
 bVyXVCKj6ehlNY+CXBhGVQLDXfWNFf9hudyI2xW5ZyEVfrBXCayEw663S9HEHpbuaoaa
 0gt3qHDmHsOrmFmLBhn76LqDaFdv+kB4IYY0gLYc8jTTPjy98TihUnAYhfRYHbYH9SJO
 DDbQe/cYfmiPq83/Q/ooYzeI5uQPs2OFG53gW6QuQjSJUddzLLdhY5ryXjHLN50/6O/A
 Satw==
X-Gm-Message-State: AOJu0YwjFf42BpWcKAbIIplbdlkY3k0PYeJSkiRWhPGFWEx8junxxW0S
 WkLycOdSN+pCe4ArbWuhzvUwIm5+imSZ8IgzD8k73jwY8WcfuZ/d+np+6i4Co4wYhius4zMNKTG
 U
X-Gm-Gg: ASbGnctZ+ETYMQflwVlQSyYbt3uH/Vmm6l5RI0fg2x1TOloqSYOuTHRQvgw7pz+COeO
 kvBRDk6cqikqj/sdyOWMOD7HfTOJ0PV2WVAL0SpMICOp+tjlGHXq7c1Kb5yYSMqQstq4g6FLwas
 4zciesOXCIRC6jdKeyZQ8FPFWWPRUpXobuAoqPPVZSczYeqr+1cadS7uVZGt8H8KtDPzac9eg/j
 ayi98uEbTcMMTSfJL6lUmkg2gTwyL3Pk3Aa07ymb6CPNmn/8aNLfNMbvNGDBGjjqESBAEFBZp8L
 VOeQwWYm2848TkYGq17soo/lue4SHTCjvbYEHbPjj/FY/Pj0WQKakbZyPC98JILdnwJvUAMb6NQ
 =
X-Google-Smtp-Source: AGHT+IHcumkpvNE/XWu6bm9XfY/7pnpL9WUWOw/5Dos5eoRJioLqTtY4r5a2zSB3KHkKo4llHU4RoA==
X-Received: by 2002:a17:903:1cf:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-22c53611146mr274231935ad.35.1745356290776; 
 Tue, 22 Apr 2025 14:11:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 8/9] hw/avr: Prepare for TARGET_PAGE_SIZE > 256
Date: Tue, 22 Apr 2025 14:11:23 -0700
Message-ID: <20250422211124.305724-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

If i/o does not cover the entire first page, allocate a portion
of ram as an i/o device, so that the entire first page is i/o.

While memory_region_init_ram_device_ptr is happy to allocate
the RAMBlock, it does not register the ram for migration.
Do this by hand.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/atmega.h |  1 +
 hw/avr/atmega.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
index a99ee15c7e..9ac4678231 100644
--- a/hw/avr/atmega.h
+++ b/hw/avr/atmega.h
@@ -41,6 +41,7 @@ struct AtmegaMcuState {
     MemoryRegion flash;
     MemoryRegion eeprom;
     MemoryRegion sram;
+    MemoryRegion sram_io;
     DeviceState *io;
     AVRMaskState pwr[POWER_MAX];
     AVRUsartState usart[USART_MAX];
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index f6844bf118..11fab184de 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -19,6 +19,7 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 #include "hw/misc/unimp.h"
+#include "migration/vmstate.h"
 #include "atmega.h"
 
 enum AtmegaPeripheral {
@@ -224,8 +225,6 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     char *devname;
     size_t i;
 
-    assert(mc->io_size <= 0x200);
-
     if (!s->xtal_freq_hz) {
         error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
         return;
@@ -240,11 +239,37 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
 
-    /* SRAM */
-    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
-                           &error_abort);
-    memory_region_add_subregion(get_system_memory(),
-                                OFFSET_DATA + mc->io_size, &s->sram);
+    /*
+     * SRAM
+     *
+     * Softmmu is not able mix i/o and ram on the same page.
+     * Therefore in all cases, the first page exclusively contains i/o.
+     *
+     * If the MCU's i/o region matches the page size, then we can simply
+     * allocate all ram starting at the second page.  Otherwise, we must
+     * allocate some ram as i/o to complete the first page.
+     */
+    assert(mc->io_size == 0x100 || mc->io_size == 0x200);
+    if (mc->io_size >= TARGET_PAGE_SIZE) {
+        memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
+                               &error_abort);
+        memory_region_add_subregion(get_system_memory(),
+                                    OFFSET_DATA + mc->io_size, &s->sram);
+    } else {
+        int sram_io_size = TARGET_PAGE_SIZE - mc->io_size;
+        void *sram_io_mem = g_malloc0(sram_io_size);
+
+        memory_region_init_ram_device_ptr(&s->sram_io, OBJECT(dev), "sram-as-io",
+                                          sram_io_size, sram_io_mem);
+        memory_region_add_subregion(get_system_memory(),
+                                    OFFSET_DATA + mc->io_size, &s->sram_io);
+        vmstate_register_ram(&s->sram_io, dev);
+
+        memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
+                               mc->sram_size - sram_io_size, &error_abort);
+        memory_region_add_subregion(get_system_memory(),
+                                    OFFSET_DATA + TARGET_PAGE_SIZE, &s->sram);
+    }
 
     /* Flash */
     memory_region_init_rom(&s->flash, OBJECT(dev),
-- 
2.43.0



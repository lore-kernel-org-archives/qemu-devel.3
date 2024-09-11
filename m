Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4027EEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGU-00016W-8u; Wed, 11 Sep 2024 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGI-000065-GU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGG-0007Rg-Di
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:15:54 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso305776666b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056950; x=1726661750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zH8Q2ViKjvRwbv9naxMFGlcA6eu9tZtte4KpH2HVO/Q=;
 b=GFWlGu/YYVs+Vh3RamG537/e8NXXWBTrgyEl1rt/7ssh67VHo0YdypnD9z3IT2zhUH
 TtWF0Jq1Ggo7JZi7IyMGccvwy5sbiT2kX9D+obDILscNTBp8newTXggctQblEs6PIhyW
 M87o+Agd007YXV1TXRLHGMVZ5dA+HRpmAr1q/6KPAkKmBH0gwBRnls0h2kLN8zojZ7Rn
 4g1/chMRBf+4xYAkOCiQju+0IcFRkYZXr/sNKQ/xl85D2ELQvHlBeQmIpxCBL8ZxFQ/l
 e6QOSBtfKms4i0tzy8CCEU46N8m+NyyiHHVLSF7vquYwE4NwGVdZVrubs54NXe4MgwaR
 X8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056950; x=1726661750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zH8Q2ViKjvRwbv9naxMFGlcA6eu9tZtte4KpH2HVO/Q=;
 b=M289KPURfQhY/4kSNZpgagFVe9nNTvuMx7DqaAau5Jezk/q0mVL85yVg5mLQHEIy6l
 f+N1fXptQXJ8qWuZ5nfiMZBkblBP378ngjr2UZcCYbJfIHvXclSHQXQPoMBqZ4J3lwhF
 CK8ik47Ttc5PmJwUXCSPXUHVsvaEgsSAssFYcCzv/9j8eRxBoPxpi5zK4G5sLp7FPcxt
 RzzsUITRqId/EnrqyBtsEkziktklAC4wg1F1n1zOOgDuzCAdrWWxf7LEjB1LEmEKQPYV
 KDr445d2Z0kNkSwery7n2nCQAKcYo9OUWD1IKMhR3NZSkpdRrtMk6rT30l9RofKjipn2
 wS0g==
X-Gm-Message-State: AOJu0YyD8oVEVE4kaKRB63fuhlk4C6jmZZJkZI2AAYmjKGcSZxrj3bFd
 dwlOj4xZ/pwZIZtn2Gq8AHTzPyCsXUF0sQAbw5pL2bClkC1UkCA5b4vI1syel77UlDrFPbAGQ80
 p
X-Google-Smtp-Source: AGHT+IG7wDbTqbscWtb27SZ7v+puL0qoOwU2zdKbPU2qOPaAEZj3BdgXwSkHyKNZLR5pN2Sx88UFWg==
X-Received: by 2002:a17:907:efdc:b0:a8d:64af:dc4c with SMTP id
 a640c23a62f3a-a9004833ef8mr313265666b.25.1726056950251; 
 Wed, 11 Sep 2024 05:15:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ceaf86sm604421466b.155.2024.09.11.05.15.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:15:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 12/56] hw/cris: Remove image loader helper
Date: Wed, 11 Sep 2024 14:13:37 +0200
Message-ID: <20240911121422.52585-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

No more CRIS machine uses cris_load_image(), remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-7-philmd@linaro.org>
---
 hw/cris/boot.h      |  16 -------
 hw/cris/boot.c      | 102 --------------------------------------------
 hw/cris/meson.build |   4 --
 hw/meson.build      |   1 -
 4 files changed, 123 deletions(-)
 delete mode 100644 hw/cris/boot.h
 delete mode 100644 hw/cris/boot.c
 delete mode 100644 hw/cris/meson.build

diff --git a/hw/cris/boot.h b/hw/cris/boot.h
deleted file mode 100644
index 9f1e0e340c..0000000000
--- a/hw/cris/boot.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef HW_CRIS_BOOT_H
-#define HW_CRIS_BOOT_H
-
-struct cris_load_info
-{
-    const char *image_filename;
-    const char *cmdline;
-    int image_size;
-    ram_addr_t ram_size;
-
-    hwaddr entry;
-};
-
-void cris_load_image(CRISCPU *cpu, struct cris_load_info *li);
-
-#endif
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
deleted file mode 100644
index 9fa09cfd83..0000000000
--- a/hw/cris/boot.c
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * CRIS image loading.
- *
- * Copyright (c) 2010 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "hw/loader.h"
-#include "elf.h"
-#include "boot.h"
-#include "qemu/cutils.h"
-#include "sysemu/reset.h"
-
-static void main_cpu_reset(void *opaque)
-{
-    CRISCPU *cpu = opaque;
-    CPUCRISState *env = &cpu->env;
-    struct cris_load_info *li;
-
-    li = env->load_info;
-
-    cpu_reset(CPU(cpu));
-
-    if (!li) {
-        /* nothing more to do.  */
-        return;
-    }
-
-    env->pc = li->entry;
-
-    if (li->image_filename) {
-        env->regs[8] = 0x56902387; /* RAM boot magic.  */
-        env->regs[9] = 0x40004000 + li->image_size;
-    }
-
-    if (li->cmdline) {
-        /* Let the kernel know we are modifying the cmdline.  */
-        env->regs[10] = 0x87109563;
-        env->regs[11] = 0x40000000;
-    }
-}
-
-static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
-{
-    return addr - 0x80000000LL;
-}
-
-void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
-{
-    CPUCRISState *env = &cpu->env;
-    uint64_t entry;
-    int kcmdline_len;
-    int image_size;
-
-    env->load_info = li;
-    /* Boots a kernel elf binary, os/linux-2.6/vmlinux from the axis 
-       devboard SDK.  */
-    image_size = load_elf(li->image_filename, NULL,
-                          translate_kernel_address, NULL,
-                          &entry, NULL, NULL, NULL, 0, EM_CRIS, 0, 0);
-    li->entry = entry;
-    if (image_size < 0) {
-        /* Takes a kimage from the axis devboard SDK.  */
-        image_size = load_image_targphys(li->image_filename, 0x40004000,
-                                         li->ram_size);
-        li->entry = 0x40004000;
-    }
-
-    if (image_size < 0) {
-        fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                li->image_filename);
-        exit(1);
-    }
-
-    if (li->cmdline && (kcmdline_len = strlen(li->cmdline))) {
-        if (kcmdline_len > 256) {
-            fprintf(stderr, "Too long CRIS kernel cmdline (max 256)\n");
-            exit(1);
-        }
-        pstrcpy_targphys("cmdline", 0x40000000, 256, li->cmdline);
-    }
-    qemu_register_reset(main_cpu_reset, cpu);
-}
diff --git a/hw/cris/meson.build b/hw/cris/meson.build
deleted file mode 100644
index dc43251667..0000000000
--- a/hw/cris/meson.build
+++ /dev/null
@@ -1,4 +0,0 @@
-cris_ss = ss.source_set()
-cris_ss.add(files('boot.c'))
-
-hw_arch += {'cris': cris_ss}
diff --git a/hw/meson.build b/hw/meson.build
index 1c6308fe95..e86badc541 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -48,7 +48,6 @@ subdir('fsi')
 subdir('alpha')
 subdir('arm')
 subdir('avr')
-subdir('cris')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch')
-- 
2.45.2



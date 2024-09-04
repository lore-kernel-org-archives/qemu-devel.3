Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92860CD484D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr8E-0005cI-Ha; Wed, 04 Sep 2024 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8C-0005RF-QN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:12 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8A-0005K7-Ch
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so2804818f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460628; x=1726065428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMqhDyW5QE8TfD14k61fEl5Bo8fbyrZNzqZaBAEhM1E=;
 b=lNhYuTYB51lfiCJbC/SiEUDeUQefJelyM4KFHFKSmsVDp9vXIulNLNyfSfBqPH/UHS
 uQK6dcPhLr+9ZL0ZheR05f5WFPS+zxmUuHdBv4ki7JzWh8dLyAHsB9R0cuwqrkfkE+rf
 ZqxdxSREtzJxGes7XOZq37G6DDcQZ4ACEbdKozYmw0n0baYcu7KKyOJIeezTbpZPZs7W
 FVhwsxxiO/Iq4uJElNDqKcuwcMJmVhARTYmXCL0BW71z0QVKQqKUkA2M2JVxhr2EjjN+
 qp3wNEffxSGH+2lBUvFlSb1Cc5ykTkXn8Ti9u2ehxNpUQyuR4MV3VBC4a54fJGqkAyBN
 QviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460628; x=1726065428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMqhDyW5QE8TfD14k61fEl5Bo8fbyrZNzqZaBAEhM1E=;
 b=TXAlVre9SCxZARCD1UUQJgjxtbqxh72hNfSWFK+kwMAggecJgidEzZGz4H6jE6XqU2
 slDgfuoRfXYs1vmnXqvqYhl8LwNRF4Vu+X6eHsHuxrnAPTwre3HHYmLwRKlaRu2pJMsW
 E2WCE7RJ9hGUrTr42D1xEMUkGXj0LX5PdspyrljSFbkDegE6qUdy+CUqG9BiNAd2jJlX
 cc8X9pVlYHlLDJwTMIwfMTQeaRUOfBqJbQJpWoWaizwZFSbEWYVk5lzwXc3+5HKpX3Gt
 1A8vrdParDjhepGME1Qnywt714+hc6b6CUIbRrA6rxixIRgOlHDjDA/h+ZBeUX14tkkx
 VdOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMWUZFXlstr0uGc3dTz37APpA3tdXdHnk+847bn/7dpJe9O9eV7jmzkDOc2PyOf0cm5Gs53Lrmwcu1@nongnu.org
X-Gm-Message-State: AOJu0YzGTF/d6guaGE0jg9wp6ARytf/yB7qsShVeJoxmPG9rFeNlh5Kc
 W/aONTUXLRclWUqRNXtQ4iq3feB/OnKkKkuhYEL0UcXjGP0X34ycCpcaHPpjwzg=
X-Google-Smtp-Source: AGHT+IFxcBnmAVU4Uxl26wyRMxn0skOlK29wBN/5QhKGSMOi8JYMLnFG8I/l8u3ANp5X0d31+JwAXw==
X-Received: by 2002:adf:eac7:0:b0:374:cbe8:6f43 with SMTP id
 ffacd0b85a97d-374cbe8703bmr6886443f8f.33.1725460628494; 
 Wed, 04 Sep 2024 07:37:08 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee9c692sm17103018f8f.53.2024.09.04.07.37.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:37:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/15] hw/cris: Remove image loader helper
Date: Wed,  4 Sep 2024 16:35:54 +0200
Message-ID: <20240904143603.52934-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



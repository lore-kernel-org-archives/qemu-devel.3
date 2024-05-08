Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA1EC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNN-0001UB-Sj; Wed, 08 May 2024 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lN1-0000db-Bh
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:30 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMz-0007kB-P6
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:23 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso60266b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190379; x=1715795179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcFeebFaXd8v0A/qKGNyCc1bIKWkAGLVbbLNEb4Qok8=;
 b=JZUlr0XbKLoRRKT34Ci96HeWztKchZEGAh07qntfN0VGjKQpgY68n9lzpwiWNeouI0
 wFwj6qbfzVVPKkKM5RFcmQqyqJ08w4M+aXYtxsC0vmULVN6FJ4gftZTmS/u++AH4tNCO
 mQCJIGdKqbk22vhLAWwxkG25X1ydpFw07KuJLm1fJowvO5e9u8adimJ/7AdJrp4Zbb5U
 c7oLmqeulh/lyt6c0WpHGWJNvoeKOkyyxhvRg0SZiVD+ZQCPd5UB+E27Yw46P6B4egPE
 kKU+5wlNHxNnCY4TQguvlmjVNtPJIi974MAEQqeMJr5cjyo82WFpVMX6UMv6wSjdeYye
 ed3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190379; x=1715795179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcFeebFaXd8v0A/qKGNyCc1bIKWkAGLVbbLNEb4Qok8=;
 b=PbWXG/sGFIm671v0qjtC9gPUZsdaZFXbtEV2t7zYtWSA2ASjwtpxtWqHv3P9mVyoeb
 MCX5MVxkvKFh+QdHHCS64eQ8WawZPBO9cWq4q1sXdF2regJTiC3BLOx0tPG+N2U9BUW4
 KfidyHwd4bFKj5UaXjvOAqHtFlwP4GIMQoSXrevJjEhyyky02AUFkGgNo31iDCVmwS2D
 IDlhGU75qwcGem/3LY3Zm6gZAvJunCRtcK7I22Nj/wvkz76HlBjrmYoXo0yMfFrKbeQ6
 dViolCAcUHnzH3auDK4ZPAkv24m9d7ZI68F142lRfbuWnb7UHU/kU7f8w6z7ddEaAI76
 iGOA==
X-Gm-Message-State: AOJu0YyfGiQfo+SmBcrZvw8GL0pVRsybMRhh+gYiuwzxt8FyNel+ISJe
 9b8fomH9SxcKNSkioa8RElz8XyTBupN8UgQ9Aqk0cmOXji3aaYYDC15NGFkR5/7QJNILx7yf3fC
 I
X-Google-Smtp-Source: AGHT+IH3ruLoYR9K8XbjxhRnaaEaX5LcvDIFkzkRLmh+sceRuZESBoAQL0Ebi+sJTZv0ps9P7jyCiA==
X-Received: by 2002:a17:906:61a:b0:a59:9ef3:f6df with SMTP id
 a640c23a62f3a-a59fb941d7bmr183102766b.22.1715190378732; 
 Wed, 08 May 2024 10:46:18 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 z3-20020a170906270300b00a55bb18e3d7sm7763243ejc.168.2024.05.08.10.46.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/26] hw/i386/x86: Eliminate two if statements in
 x86_bios_rom_init()
Date: Wed,  8 May 2024 19:44:56 +0200
Message-ID: <20240508174510.60470-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Given that memory_region_set_readonly() is a no-op when the readonlyness is
already as requested it is possible to simplify the pattern

  if (condition) {
    foo(true);
  }

to

  foo(condition);

which is shorter and allows to see the invariant of the code more easily.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240430150643.111976-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/x86.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3d5b51e92d..2a4f3ee285 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1163,9 +1163,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
         load_image_size(filename, ptr, bios_size);
         x86_firmware_configure(ptr, bios_size);
     } else {
-        if (!isapc_ram_fw) {
-            memory_region_set_readonly(bios, true);
-        }
+        memory_region_set_readonly(bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
         if (ret != 0) {
             goto bios_error;
@@ -1182,9 +1180,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
-    }
+    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.41.0



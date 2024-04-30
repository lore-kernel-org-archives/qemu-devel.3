Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309CEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4N-0000yG-0x; Tue, 30 Apr 2024 11:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4L-0000y5-OJ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:06:57 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4K-00009L-3L
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:06:57 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso7561387a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489613; x=1715094413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EU56KqxsaM/0HEsRCm8u8nVsVnVRC1FhJWxFNu5K1Wg=;
 b=DglZPmWc48z3AqwIj9zJbnoFeseEY0DRZ7re1aM8qTrARcrSLVcnp25pBq9EKWb9wH
 Yr4lpNHlaELhsvhx9vwk1WXMHKOyWcDN1Fnyu/e1AV79Z4VGJ14lAvsrkHGf2+1RAgza
 vnBkOsI0NcT8TbgkwaWqeW5dkDjog/Prhh9dGgSKZOn6PqypRxqyzMebISlPmiEBUfql
 riLDcrXNcmg6GGYtKX18Novk7I7AHgjbC33Z4+vSah/TNG2kzoXMuIW+GzFagLFDMKf5
 X56qZ4mouapksS2TPwL7GuxRNeb+BaknZdOolA8s6x750f26a6BN8vNIc5/yscrhXkxX
 FEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489613; x=1715094413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EU56KqxsaM/0HEsRCm8u8nVsVnVRC1FhJWxFNu5K1Wg=;
 b=kshS1P9Kc8lfNbfeSGEmFyR6BYUCkI+sgUk6ztk4GlLYXbhUYHgwd6/6x7/ejIraZ2
 cioKlo6vKMyBoeWU430cG2iZCYAK77FEWSKmz3CBRaleulV7jiBIppNj25kFbALA0Rf8
 xZ2GUmdoYr7Oy6QOKvlHXx/OGrFkefAVsslpkosFyA81XT50qgQmuxUp7is8sKn2Skiv
 wboS1MxSMVaYQZadgF/DFuY1sLT5nUMDvCzyRZHkEQW+uoSFAsCrBmp8D9Z/B/Ek64e8
 abYcZ8u5Sbc1VDVoAYSLARMztwoOO+I/PSihZ8LaB3fcHuKuGwwmqSxljMSWSnae5liz
 Scqg==
X-Gm-Message-State: AOJu0YzCEEJdAzGaHAOZ9KAyQL4xeIcEdkQdRCJbC/nzkTE7KkFXMIr5
 W37dX4nq1aWoawWh1vBNncYWrtGn1Jx/tHYlVlo0j5yXj8qrt3u9q+HTpg==
X-Google-Smtp-Source: AGHT+IH9Jx1ZX2w4ZL4L6Dhjp9awYt3aDVnZhGdRIh3YwW78Hd5v28/yvpeWztLcaU14HH1msNj8YQ==
X-Received: by 2002:a50:ccd4:0:b0:56d:fca5:4245 with SMTP id
 b20-20020a50ccd4000000b0056dfca54245mr72563edj.10.1714489613191; 
 Tue, 30 Apr 2024 08:06:53 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:52 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/6] hw/i386/x86: Eliminate two if statements in
 x86_bios_rom_init()
Date: Tue, 30 Apr 2024 17:06:38 +0200
Message-ID: <20240430150643.111976-2-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
References: <20240430150643.111976-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
2.45.0



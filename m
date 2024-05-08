Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED39CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVv-0001Dc-7q; Wed, 08 May 2024 13:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVn-0001Al-OO
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:28 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVl-00028U-2W
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:26 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59c5c9c6aeso320566b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190922; x=1715795722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+TSGbSG4esBOIIsXyBX5ILJEmV3/MNWQb4SUxib0NM=;
 b=Ak0juWaMLcRcf8BLU1gG25TAdJt7S78V2NcgJTJv7ZnPXEGrJHJ8dB/vHA4P53K1DT
 10yx2nbvqlo/sJzatDWYQUuT6vyZ24UJJqTXz6VjhgFGoKm5+uVL1jJ3upIcFXgObKQ6
 0YMq4nFf0Wv0nhwkZHPbzrwAu1FmpOnG2E4ijoSXwDZ7CzuUD/3/6Q650Jk2uH023O6i
 bgEcDFuBg/UrbeQiOYBLveWclUqjjEVpjijue3zcivDVSnmnROaGDQUvSn+IoT4sBetI
 9BtKw+c39qcaRdXcrEwMs7mA+q9DV1Nz3/uhkHVx+gKoVZVGxd2EEtNBJUqP8ZTrjfHp
 1vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190922; x=1715795722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+TSGbSG4esBOIIsXyBX5ILJEmV3/MNWQb4SUxib0NM=;
 b=WcJrARsJBTvgv1/Ztsr4+H67BMDimZMQB/zMktyMOKV/w7CoZBG9At/SKixFbs2x+H
 PTu2R5Pfiz7CAKiooyUna2SQhAgIA3PbD/+YBIEmKMvhf8NyhLYdecDdUjwgbin+zmNG
 qHcEv7eCmcdX7zxAjI65QNesHX1V1OXHzIPp4Kt1W0sGsarGfp0mKVLfzR4tG3jg2d7k
 ZOQaKgh+5CWjSf+qYTZ1bhWD7e3RJnRuP93+kINbH4um7doeyobGMRws/kPc8hddWqR7
 O0oun33MCQmDyoliGVvIdPngrq3ds0JqJdmUBNPh6ulMH+TSjd5zdNfbNj5AuJRbmFkP
 RpwA==
X-Gm-Message-State: AOJu0Yzzx/HZ7Gleib24vr5f+RJ6C0aR13Bdm7RKKgBKeDqF9ogQ5dQ1
 c5xZRx8re+TDbVqrDVJoJnVadsfRyxI9SMFLicIH6kB0btfmTZSiuVMGXg==
X-Google-Smtp-Source: AGHT+IGZfpYtOLXRaFAwyDghnNGZWQBwNxYloXRd5i/jpiUp2XTtVz8zlkcP1PUmzDE9XDPrLjELzQ==
X-Received: by 2002:a17:906:b80d:b0:a59:cdf4:f940 with SMTP id
 a640c23a62f3a-a59fb955e80mr206570866b.28.1715190921807; 
 Wed, 08 May 2024 10:55:21 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 4/6] hw/i386/x86: Don't leak "pc.bios" memory region
Date: Wed,  8 May 2024 19:55:05 +0200
Message-ID: <20240508175507.22270-5-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
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

Fix the leaking in x86_bios_rom_init() by adding a "bios" attribute to
X86MachineState. Note that it is only used in the -bios case.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h |  6 ++++++
 hw/i386/x86.c         | 13 ++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index a07de79167..55c6809ae0 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -53,6 +53,12 @@ struct X86MachineState {
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
 
+    /*
+     * Map the whole BIOS just underneath the 4 GiB address boundary. Only used
+     * in the ROM (-bios) case.
+     */
+    MemoryRegion bios;
+
     /*
      * Map the upper 128 KiB of the BIOS just underneath the 1 MiB address
      * boundary.
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 457e8a34a5..29167de97d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1133,7 +1133,6 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 {
     const char *bios_name;
     char *filename;
-    MemoryRegion *bios;
     int bios_size, isa_bios_size;
     ssize_t ret;
 
@@ -1149,8 +1148,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
-    bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
+                           &error_fatal);
     if (sev_enabled()) {
         /*
          * The concept of a "reset" simply doesn't exist for
@@ -1159,11 +1158,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
          * the firmware as rom to properly re-initialize on reset.
          * Just go for a straight file load instead.
          */
-        void *ptr = memory_region_get_ram_ptr(bios);
+        void *ptr = memory_region_get_ram_ptr(&x86ms->bios);
         load_image_size(filename, ptr, bios_size);
         x86_firmware_configure(ptr, bios_size);
     } else {
-        memory_region_set_readonly(bios, !isapc_ram_fw);
+        memory_region_set_readonly(&x86ms->bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
         if (ret != 0) {
             goto bios_error;
@@ -1173,7 +1172,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(bios_size, 128 * KiB);
-    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(&x86ms->isa_bios, NULL, "isa-bios", &x86ms->bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
@@ -1184,7 +1183,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
                                 (uint32_t)(-bios_size),
-                                bios);
+                                &x86ms->bios);
     return;
 
 bios_error:
-- 
2.45.0



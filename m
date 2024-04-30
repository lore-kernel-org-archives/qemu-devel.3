Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2E9C25B10
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p4m-00011h-As; Tue, 30 Apr 2024 11:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4S-0000zc-AP
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:05 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s1p4K-00009U-CU
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:07:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so7360293a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714489614; x=1715094414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zb/k7/BA5E8Yw2+b7BDQbjEKFAaUUe7M+nmkaW91ig=;
 b=TGUkmu0YISsAkI5Z+R24wkDOek71BiY2TFGDT6RyQKoD3+ewgDSnFUFoIKFnsoqfL2
 Emf+010+2vCVseST7TWGvah1wZ2R6MaRQmLLsgUMSiIo9CM9Pn+X1T/SYLsrhGM+RuAo
 K14e5se1mlNJXc75VJkFvL55M9nTOGFpFb244ri56ba7IKlh3HE14cg9yEqj1fSCcatN
 zN4rrOcjjCP/C2V6T99AkOP5jhmTadui0ZKd7iDRYk33WLbgnx8iwSdlYYYLnEolW7cH
 d2BjWSeupJe4EsbReZtSN0op2mP88GfEfs5Eiur33lUg+HacUZFJqFC/7tRbe0kuF/ui
 yhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489614; x=1715094414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zb/k7/BA5E8Yw2+b7BDQbjEKFAaUUe7M+nmkaW91ig=;
 b=KMS7zzjlbG1qYpZDpPSWESZ2uDrlvwh3ZwUmqpc1s3tiNhEbA0pgPoRQdzc6a+uUJl
 gM1QCr39rDAqGpcQFwLHw9Ipy8LtTMZaGqkNjbY55yf65nadt5Q63BnEJ1AB+gx09Iyi
 f93Cu5ufMHGVLLhvtEMdJ6Q8Tp6vf9DQMXCTkP8x6ofb/oDJ+KEzmPeFjKSU0S4cTGFv
 Zr2ujWmo4g2kJlPR47p5ru/ZLlDHw46WkCpKzp1o/65GApLaT+x8yVyCa66AQWFPinDP
 x/NsXxv+nAbToOggs4YPSXjrjMlXuMhYUN/T49PwLEqPHXJrwg16j9pK8GzDMSj65dwO
 0mOw==
X-Gm-Message-State: AOJu0YxSg6nr9BNcPoVbcmYyz3UgkolemjkIBf2YVh5GqQ+yOdCP6UvC
 N7tOMEu6Kg/aI/ntEwIQOFdFfUall9Xl92Tv2dtN8TmAtZbXYZcv8dqA4A==
X-Google-Smtp-Source: AGHT+IG1QXIxTgWIcvswDQifdkmYtKPmyb26XR0rv1qNcUjjgCvyPmqxiEotbxXDvbNVu9R66DOpjA==
X-Received: by 2002:a50:9f28:0:b0:572:a22b:12db with SMTP id
 b37-20020a509f28000000b00572a22b12dbmr62406edf.28.1714489613997; 
 Tue, 30 Apr 2024 08:06:53 -0700 (PDT)
Received: from archlinux.. (pd9ed788d.dip0.t-ipconnect.de. [217.237.120.141])
 by smtp.gmail.com with ESMTPSA id
 11-20020a0564021f4b00b005727e826977sm2345741edz.19.2024.04.30.08.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 08:06:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/6] hw/i386: Have x86_bios_rom_init() take X86MachineState
 rather than MachineState
Date: Tue, 30 Apr 2024 17:06:39 +0200
Message-ID: <20240430150643.111976-3-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430150643.111976-1-shentey@gmail.com>
References: <20240430150643.111976-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

The function creates and leaks two MemoryRegion objects regarding the BIOS which
will be moved into X86MachineState in the next steps to avoid the leakage.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/x86.h | 2 +-
 hw/i386/microvm.c     | 2 +-
 hw/i386/pc_sysfw.c    | 4 ++--
 hw/i386/x86.c         | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4dc30dcb4d..cb07618d19 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -116,7 +116,7 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
-void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
 
 void x86_load_linux(X86MachineState *x86ms,
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 61a772dfe6..fec63cacfa 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -278,7 +278,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     default_firmware = x86_machine_is_acpi_enabled(x86ms)
             ? MICROVM_BIOS_FILENAME
             : MICROVM_QBOOT_FILENAME;
-    x86_bios_rom_init(MACHINE(mms), default_firmware, get_system_memory(), true);
+    x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
 }
 
 static void microvm_memory_init(MicrovmMachineState *mms)
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 87b5bf59d6..59c7a81692 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -205,7 +205,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
     if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
         return;
     }
 
@@ -226,7 +226,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, false);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2a4f3ee285..6d3c72f124 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1128,7 +1128,7 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
-void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
+void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw)
 {
     const char *bios_name;
@@ -1138,7 +1138,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     ssize_t ret;
 
     /* BIOS load */
-    bios_name = ms->firmware ?: default_firmware;
+    bios_name = MACHINE(x86ms)->firmware ?: default_firmware;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         bios_size = get_image_size(filename);
-- 
2.45.0



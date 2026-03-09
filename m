Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6349DF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcup-0003bb-9R; Mon, 09 Mar 2026 11:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcud-0003R4-7O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcub-00089Q-H3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853510b4f3so22726975e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071569; x=1773676369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jhTtmUG2GdnqCp2iN5JX67owbOh0LsPxSVz/8hOXpME=;
 b=Nu3Wn1pLLOoDaqZVHDlvGKmK/Eqy/Oj4ceGVD+CNYRe6mx5su0xXxvKd/K8B2SsI3v
 cI5dOTykvIlY7NRKFIreiD2SWrIvl9JdYmF2QTHTbgz44aXlgi0YQa1SHs+3RrAStSTg
 OWERLY2hu5YVUcsx+PnvcBlrBit233lDwDp9dTSxZ48oi/OV+L1C0IFg3IcjDvRcNG8b
 P209ksqJjxnE9Y6+VLIxKBTAHp051X6QwEPrIZQNmS8DKS+jUhlBd27QfzVJVuLWyWDh
 GTKika+X4ZRVMq7ukD2aM4qmUjq38WqPJOL9uVAmkjPbxUdeqRawDKeQcy7SzGUDY0md
 sicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071569; x=1773676369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jhTtmUG2GdnqCp2iN5JX67owbOh0LsPxSVz/8hOXpME=;
 b=mgnOB2Sbdn3MgS8nTFD336up7pjf9NR0UcCVpPPMlsHZ9g15rHb8EBG7nT80cArtT/
 dgP+nL01mS+jXgPQQ4Ja7uE+FCZjOKfqh1hd8UemJsuOnK1sxNiNcDBlELSb9mPf9xld
 QEvvC5hRNEqRjNR3Koc83F3JLDORhtzy3q89fDqg1Uk9z8PPJg69Qfc5OGYexUETdUm9
 kM11HLunasJ8gWm/6QNvx/0WFO7/RpkiYqc9cdpwDjSDRtvEfDRZLAEAbsSVCA+ZGA23
 Cn9bo4u70hzPiJf+JkuAKFElWXc6y4QW23mfa4g4vpcC4oFfUfCNiCe+OAsPFBHJKs/W
 cOqw==
X-Gm-Message-State: AOJu0YwnlGSzb681QPeC9YDlPg0z7Rie8sb6OgN9meM8RQcllxteACBv
 bzetWx/DlfGK0iTRzdd9lOvmr6G27kIxnjbjMn434r/ScrKfJXuzw5jJibTwZAsZz6rfq3wMK7i
 t4oImGbM=
X-Gm-Gg: ATEYQzxNjKMZbvoFNXxFFjni1rNBORnwOgu3iK2Ho9GAxAeETB2hHKiCad5P8oP8jcN
 EBA66Ll+vkVdOpPBuqwbLyrp8Nvzq6p+YFC4Us9X9MqBeA2sndBk8FmivMSCc8uLXuj6zXQri+Q
 FYTgzDhLIlTG28NhdtGuB0OMP7c2gzI9w4GzaVr0XMmlbgbigk5uS0YQq6xS/4oqzVng6bbueLJ
 Hbcx++5zsg5Q0ROLi26ZnxYiWRdrpyvzUxxqihx1u8qJB0PGUwUGeNE0nURtikvhIxbTrzHuEV/
 xgnvxYUpW+Y42xL6B8RCDcPOu34bk+w6VS42whzmOpchbfGz5dO94vc1/4pTWNpVURD0Ytb+WLP
 LLnnngA17dVaKm+zoPd/gDKzCdJUq3PZXgSSngSBXYsotH90UnhoVIZSAV6muFm8pckr+BUVZoF
 QxXaNddsXMEVYE3HH5kVbL8Y5HYQv0o7wf/6swaJ7SV2l2yK/AH9EpSSUFYHLY0Slf6b4PYr+N
X-Received: by 2002:a05:600c:3b82:b0:485:3bb0:194 with SMTP id
 5b1f17b1804b1-4853bb00605mr58481855e9.35.1773071568940; 
 Mon, 09 Mar 2026 08:52:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a7f1f5sm1579825e9.4.2026.03.09.08.52.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:52:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/49] hw/i386/x86: Remove @pvh_enabled argument in
 x86_load_linux()
Date: Mon,  9 Mar 2026 16:51:34 +0100
Message-ID: <20260309155219.62400-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

x86_load_linux()'s @pvh_enabled is now always %true: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-4-philmd@linaro.org>
---
 include/hw/i386/microvm.h | 2 +-
 include/hw/i386/x86.h     | 3 +--
 hw/i386/microvm.c         | 2 +-
 hw/i386/nitro_enclave.c   | 2 +-
 hw/i386/pc.c              | 4 ++--
 hw/i386/x86-common.c      | 3 +--
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 6b9a5065272..184b7a8c094 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -79,7 +79,7 @@ struct MicrovmMachineClass {
     HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
     void (*x86_load_linux)(X86MachineState *x86ms, FWCfgState *fw_cfg,
-                        int acpi_data_size, bool pvh_enabled);
+                           int acpi_data_size);
 };
 
 struct MicrovmMachineState {
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index a85a5600ce9..71fe6b5e122 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -129,8 +129,7 @@ void x86_bios_rom_reload(X86MachineState *x86ms);
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled);
+                    int acpi_data_size);
 
 bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
 bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7ff20512636..5a7889f21b8 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -330,7 +330,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     rom_set_fw(fw_cfg);
 
     if (machine->kernel_filename != NULL) {
-        mmc->x86_load_linux(x86ms, fw_cfg, 0, true);
+        mmc->x86_load_linux(x86ms, fw_cfg, 0);
     }
 
     if (mms->option_roms) {
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 4cd18166ff6..a29f0044d0e 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -199,7 +199,7 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
         machine->kernel_cmdline = eif_cmdline;
     }
 
-    x86_load_linux(x86ms, fw_cfg, 0, true);
+    x86_load_linux(x86ms, fw_cfg, 0);
 
     unlink(machine->kernel_filename);
     unlink(machine->initrd_filename);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3fc2f0a057e..00581dd8b44 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -597,7 +597,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
+    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
@@ -931,7 +931,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
+        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index db8d4e855f4..fde05fa7d7b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -642,8 +642,7 @@ static bool load_elfboot(const char *kernel_filename,
 
 void x86_load_linux(X86MachineState *x86ms,
                     FWCfgState *fw_cfg,
-                    int acpi_data_size,
-                    bool pvh_enabled)
+                    int acpi_data_size)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
-- 
2.53.0



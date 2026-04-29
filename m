Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9EDFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEQe-0004qZ-Kw; Wed, 29 Apr 2026 19:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICoj-000112-0P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:37 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ericsonjoseph@gmail.com>)
 id 1wICog-0004I9-Ro
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:51:36 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso321654eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777499493; x=1778104293; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DA/FqRL0ewZtA3xZKzy9jEg1vUWq4E5BZgOmzcm/gFE=;
 b=OszSFK0ng9FhumpFGowSkpXU9ySlWLTiplD1qVvB3NyyBONZYXSR9zYOKILBxw4T6l
 KNDVS1ynrzgLBm9DR/qZ4GP3YsvCtRglGRW3oyjWPR1iTMREAOTmPZqWIItFc0ooAQ+C
 wsa9n3QlY/2gFVZNEo9p4HZcT4O9vtOxK7Vj5bgfVT6DKdAGZzfioeYxnPLxUScUBl6k
 XRQhcVf/40q4bC0FeVKjbuAASEHek73nxZT2PAq9Kx8zHD7A6Lg5GzKR3v7vq+quUf1z
 MrJvKcyxyGBApJhewpWHnRzFI+T8CbaWjvigrqaewVe4aHH8YDL6DTsrhR1jEz0sSDod
 22cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777499493; x=1778104293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DA/FqRL0ewZtA3xZKzy9jEg1vUWq4E5BZgOmzcm/gFE=;
 b=ZDgfQzNtadU47SCbcOsygztoeizYKQD7jyJJZz/vw1YVO7uH0fJfszrxvQoZhd0FHu
 Nws+TUQDkXma7LlsC2J6twA23brb0QCMGSuHE/5Gch2Oli6PmYNtza8H4hAQ3wO38pqo
 i+ZcQo2eaMRKyUkKon3kFn1eFhhOiaVd7XxaDJ2s0lnpFq1OXm1ZMw6lZ9J6HiMEzfiK
 AT/7a7Ttjnf9tJW0YMLBBHaWhrZmIs/TnBPQYx+s4iXqcAS/nPN3+NH1XI46w9V+29cM
 dvg6veKBJkO/E17GUnx36orrUKPNM4XOzUon3hIXaeiS8io6o3IOi4z8hVQ2FbnlLwgQ
 AlfQ==
X-Gm-Message-State: AOJu0YyreegtBGw7QDndu2Gl2FYVs1+5mku2G93izDMje7Mtxcs973kB
 S+WIM2vqcXIcG9NAdv88zsL1xOulbdPlEfKE1uMwWfbg+J1sqneUFYuv
X-Gm-Gg: AeBDietOC3XjDLDpQ4DNmdhlj1w+WkUvb729tJHeEPCt71IHZw5rl7N+MYmKFMWTDyE
 BdvTdX58fYtI16Y2NDBDmR2IBeLMzMCkEKNikIBXnaeJxJulXckNbbDUIC0boqdr6dF+QDf9Dyb
 ttf60qnisLMzJ3FiHYFxb1crE1S/+VaqxzeTh4rfwjbxEA9jI/DOmLkvrbpYXcb84PhtdnOApWk
 ricDMjfGYj5A7LqXYvDGspmnz+YdNOGBzeb73GVfeHdZoDPMoMHK0c4uabuUkQUSnMET/npXNSW
 ajCHWpjeroySBdq4DjhVqDokRVzyOlMljHenkCPndajIYylAAy4t1+wj6AbsnBZKXXxAS1m5Lxy
 GUhWxuLClLO3sOB6N0Q/EaikDMUk7Kn1d7+7qYVIG+58L4nxZcZRbGsm6DIDBtWmT8ZAMvr0fnj
 GqejveqJTJK9AL4scUzxXM5G4eHk4r8XoCy03AHMh2
X-Received: by 2002:a05:7300:6419:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-2ed3f15d38fmr40324eec.19.1777499493169; 
 Wed, 29 Apr 2026 14:51:33 -0700 (PDT)
Received: from [127.0.1.1] ([2803:9800:9001:c4f0:5d16:7dac:ff8:d8ff])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm4353878eec.1.2026.04.29.14.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 14:51:32 -0700 (PDT)
From: Ericson Joseph <ericsonjoseph@gmail.com>
Date: Wed, 29 Apr 2026 18:51:19 -0300
Subject: [PATCH RFC 3/3] docs: document the PIC32MK machine in target-mips.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-pic32mk-board-support-v1-3-1dfac14f8e2d@voltumotor.com>
References: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
In-Reply-To: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Ericson Joseph <ericsonjoseph@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=ericsonjoseph@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 19:34:51 -0400
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

Add the Microchip PIC32MK GPK/MCM board to the MIPS system emulator
documentation, listing all supported peripherals, the firmware load
address, and example command lines for basic UART and CAN FD usage.

Signed-off-by: Ericson Joseph <ericsonjoseph@gmail.com>
---
 docs/system/target-mips.rst | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index 2a152e1338..571c7b6fa8 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -15,6 +15,8 @@ machine types are emulated:
 -  A MIPS Magnum R4000 machine \"magnum\". This machine needs the
    64-bit emulator.
 
+-  The Microchip PIC32MK GPK/MCM microcontroller family \"pic32mk\"
+
 The Malta emulation supports the following devices:
 
 -  Core board with MIPS 24Kf CPU and Galileo system controller
@@ -78,6 +80,56 @@ The Loongson-3 virtual platform emulation supports:
 
 -  Both KVM and TCG supported
 
+The PIC32MK GPK/MCM emulation supports the following devices:
+
+-  MIPS32 microAptiv MCU core (74Kf, little-endian, 120 MHz)
+
+-  256 KB SRAM, 1 MB program flash, 256 KB boot flash
+
+-  EVIC — 216-source vectored interrupt controller
+
+-  UART × 6 (UART1 connected to the first serial port by default)
+
+-  Timer × 9 with prescaler and period-match interrupts
+
+-  GPIO ports A–G with TRIS/LAT/PORT/ANSEL/CNPU/CNPD registers
+
+-  SPI × 6 (master and slave modes)
+
+-  I2C × 4
+
+-  DMA × 8 channels
+
+-  CAN FD × 4 (via QEMU ``can-bus`` objects, SocketCAN-compatible)
+
+-  USB Full-Speed OTG × 2 (chardev PTY)
+
+-  ADCHS — 12-bit high-speed ADC with 7 cores
+
+-  NVM flash controller with optional host-file backing
+
+-  Data EEPROM emulation over program flash
+
+-  Output Compare (OC) × 16 and Input Capture (IC) × 16
+
+-  CRU (Clock and Reset Unit), WDT (Watchdog), CFG (configuration)
+
+Running a firmware image::
+
+   qemu-system-mipsel -M pic32mk -bios firmware.bin \
+       -serial stdio -nographic -monitor none
+
+Connecting to a SocketCAN interface (e.g. ``vcan0``)::
+
+   qemu-system-mipsel -M pic32mk -bios firmware.bin \
+       -object can-bus,id=canbus0 \
+       -object can-host-socketcan,id=canhost0,if=vcan0,canbus=canbus0 \
+       -serial stdio -nographic
+
+Firmware must be a raw binary linked to start at 0xBFC40000
+(Boot Flash 1). The reset vector at 0xBFC00000 contains a trampoline
+that jumps to 0xBFC40000.
+
 .. include:: cpu-models-mips.rst.inc
 
 .. _nanoMIPS-System-emulator:

-- 
2.48.1



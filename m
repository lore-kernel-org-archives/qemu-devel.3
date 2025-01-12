Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B06E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5zK-0005MF-L5; Sun, 12 Jan 2025 16:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zI-0005Lx-F8
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:16 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zH-0003nJ-0U
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1774714f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719153; x=1737323953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3D5LATmwVIHEkoVYh3B4/BcJbbaKQTKjDGm1VbT9Ey0=;
 b=MvRxNznhVpaFpY725hhFCm73VcH99fjtA8jpz+Go9u2vS+lKUm1SwMGJctLCyVUYGG
 +JVY9F99BrI/433M0MAgik8y7GWRsHxnTLrBfnxVtVv89mIKo+OGW0eRGGKrgyz+pVEr
 7prTllaWbkoyOWuYevbsdj6fuExKXWfqRIpi0SJ6nVdueBgn1Gt0uKr0AbcP/7FcZWgz
 FKJNixg12JT5Fhxn6R8/dX5zfzA/7+t5aN40jpfY99k8bzRF+laGe9txZ/xi/U7+N2YC
 oWtq6jCkCFfkIHAYpdkpgiCfetDlXedyua3J1RTyB331RykRiAKxqfx955XQM1lj/5ly
 0MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719153; x=1737323953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3D5LATmwVIHEkoVYh3B4/BcJbbaKQTKjDGm1VbT9Ey0=;
 b=SiHOh9xDyRjEymuxQ8i/iwKtNkHbi7MLiD2lS4mGRiSpidqeJ72UgTPgIL9sfUPG3u
 VKh2XCI5rngCXLiafVLyT5F83V5kiznZt6o+emWaja7to/8ZXKTQ2Njjvn6h/3U9LsFx
 OVlS5cIFe99y7Z/sYNlh4sCmu4bpctJLdVAdk+DMVExuCjgHc/3UsubY5llzNvx4+d0F
 nWBSx15VcMeHp3udWCu6IOYYCw/zTBWyAnLY88jek/umQpDmQQYZ1zmzVKZuOBl5DYp7
 2b5aSq53GyLvH9RmxjsOVLojvZyMDSRRITqqeVJJhwW4kC/4V544qRv+VwNmcp7Xa2B1
 7JOQ==
X-Gm-Message-State: AOJu0YyTYTsBaIDtCTdlfKJm3YgxALiyMtH8Mj1oM7FxVjuctlwSYB0Q
 hYmN3Sdcpfe3rP/DC0hA2b76OlaczHB3LS7Vv+b2EQ3fzkwj3hNLCs4LO2sWqyrkqwFFh7CGYMi
 aqgA=
X-Gm-Gg: ASbGncsgt1AhyfNvLxluGVgh3mHx7Z5SjmCKMTHsiXkiAJCoD/1f06i2M5oZ0KShLgM
 F1mCHAnujHvh8oegqKDuPOrsdbMgz5rml5gpxSFIvAbziD8UkdfnHnvWJcXM86qREKG28yYNgdt
 tFzMl3dIdAjxRvHkTSqQkc+a1LUJwoeJ0KzvPdSX65dDnIokPhcbYVsfUSsD65qtOj5efCUcCsh
 SgF9X78h1laZvpUBhK3vF9LKAfUr5EMQJILuD3FxoZe8t4XqJNeFxkhJvFvODWOaOTjDlh5vyUY
 nCS0Kn9Nj6u6CocNetuMNtJCjIeQnn4=
X-Google-Smtp-Source: AGHT+IFZnLBgFy9KTi880jdnlRJJYNWo2nVb30QgdYYwTaWkofXT1eZAyiVq6BhcyKMYerSgesnNgQ==
X-Received: by 2002:a05:6000:1864:b0:385:f071:a1c9 with SMTP id
 ffacd0b85a97d-38a87357964mr14534512f8f.50.1736719153040; 
 Sun, 12 Jan 2025 13:59:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a9362947dsm9068134f8f.40.2025.01.12.13.59.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 07/11] hw/mips/loongson3_virt: Propagate cpu_count to
 init_boot_param()
Date: Sun, 12 Jan 2025 22:58:31 +0100
Message-ID: <20250112215835.29320-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Remove one use of the 'current_machine' global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index af1937455b0..a240662016b 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -173,7 +173,7 @@ static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
     return DEF_LOONGSON3_FREQ;
 }
 
-static void init_boot_param(void)
+static void init_boot_param(unsigned cpu_count)
 {
     static void *p;
     struct boot_params *bp;
@@ -184,8 +184,7 @@ static void init_boot_param(void)
     bp->efi.smbios.vers = cpu_to_le16(1);
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
-    init_loongson_params(&(bp->efi.smbios.lp), p,
-                         current_machine->smp.cpus,
+    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
@@ -645,7 +644,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_entry = load_kernel(&cpus[0]->env);
 
         init_boot_rom();
-        init_boot_param();
+        init_boot_param(machine->smp.cpus);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: LOONGSON3_BIOSNAME);
-- 
2.47.1



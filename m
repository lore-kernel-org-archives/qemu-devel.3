Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B20CC02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCq5-0006It-HI; Wed, 15 Jan 2025 18:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpz-0005zJ-8q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpx-0004zB-I5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so195562f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983811; x=1737588611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8NsqtuLl1GgOwQ9maEwkOukw0Aj0PDgWtnDGfLDaJk=;
 b=qybltCIF8Ck2xiYYHKD7TVWAEeIt11y+MkS73utu2awsyqFWLRnyxgbL/AOI7bmXx9
 4pAsSUxaKPubihAKED2DuXhPtB/yQ+S/yHQKIfKhvT4iIcsSfFQwUqI2DQ5ngZU7Q3r1
 P2V6H/FA8dTN5bjEc1+zkYqiMQajxMtbCS0ht0Qm9DdEb1F+ktAyehhKNcfmaL10Czen
 iy35ZR5FTawV7Ca7dAMFjz3IConk8owWP9DPg/Off3uhES1dB/BmqNhXbLgHPqy+/bmZ
 WPevIdOpnPkHBc3XyCcw9h3OPeKSSCkST1QIJuMBDqVr9gvLBeviyFqW0Seh6W2OVCDs
 g4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983811; x=1737588611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8NsqtuLl1GgOwQ9maEwkOukw0Aj0PDgWtnDGfLDaJk=;
 b=W7993d+wpI4K0n3lOhlX2xddeQkt7qSrAcJdkDeaPggSDlDrh1wB3Q0pFPSa0+cs/j
 xLrByFAyXuGujnKzgQf3NcAw6LxdzZEnh5Ke57JvPoqAOGqGojjL8SgsDGFKa75sFCup
 yMVU4BakclJWdCWnbZdqDOEmssYq5WVRfyxe4HVLwkQH82oGU1Gh2t4tL2HoTMP0jsv9
 tzFQByMnl2vcKL0UijAzo/vmQopNVG68vSG4U+Vc01xK9Ka/PitMs7XBwsmUz9jCsRkv
 5bEU28xFOGPgdQl8LmJDDdGZgWSpR/HrTvjkU6h8S3FtUEekbnIDjVjXzRexyMhlMBjP
 +hbg==
X-Gm-Message-State: AOJu0YyzFWkIUGavr2f/nfrHNCuY4ma/xRWi5IF0Giaid4f7NHaBLSST
 mDjGbHMRkHCsi/v4iu5f4n1gYmOVXZulagsz0FRyn4H1EqG7ABK6tbtQmNBxflwf1dNjOXbXCwA
 dexU=
X-Gm-Gg: ASbGncsM7FS6CQ98zRbrHY+cMLIPxeT6pkksfs+hoeq6DTQwHJfo8zSVitdKuDdev9d
 8FGmyzhNAbgQER7vqBnf2Ep4Kq+KbTomcWPeCn2TJQz9dbkU4ug05fN9odgQcX55kLp3xDsIDVu
 SVmF5pflA/3Ql8CsvwaWndCo695fInzIqpcb1alI9RQrrZZ6RzdJaFz0JoGeNKgpBV7UYq/+z9O
 /jufPaSqrObTgFsxG7jb0MnELWgB2pHJ/BG7YbnotYdFHc193jE+A+4ikijAgiSRhwx64fbTpn1
 yPLT/YsBpt0YTySuPeDuOpeeEknONFI=
X-Google-Smtp-Source: AGHT+IFlvvWU/rYo0Hn5ghljSG01sHTWrZy8h5HRp1NieDgzKRL+nFNbigfAyDnlU3Q+jzpAs10t+A==
X-Received: by 2002:a5d:64a8:0:b0:385:e429:e591 with SMTP id
 ffacd0b85a97d-38a8730a6bdmr30749043f8f.23.1736983810210; 
 Wed, 15 Jan 2025 15:30:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749a127sm39220785e9.7.2025.01.15.15.30.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/11] hw/mips/loongson3_virt: Have fw_conf_init() access
 local loaderparams
Date: Thu, 16 Jan 2025 00:29:43 +0100
Message-ID: <20250115232952.31166-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

'loaderparams' is declared statically. Let fw_conf_init()
access its 'cpu_freq' and 'ram_size' fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/loongson3_virt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 488eba495cd..1f5952d7082 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -280,7 +280,7 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
-static void fw_conf_init(unsigned long ram_size)
+static void fw_conf_init(void)
 {
     static const uint8_t suspend[6] = {128, 0, 0, 129, 128, 128};
     FWCfgState *fw_cfg;
@@ -289,9 +289,9 @@ static void fw_conf_init(unsigned long ram_size)
     fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, loaderparams.ram_size);
     fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq_hz());
+    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, loaderparams.cpu_freq);
 
     fw_cfg_add_file(fw_cfg, "etc/system-states",
                     g_memdup2(suspend, sizeof(suspend)), sizeof(suspend));
@@ -632,9 +632,9 @@ static void mips_loongson3_virt_init(MachineState *machine)
      * Please use -L to set the BIOS path and -bios to set bios name.
      */
 
+    loaderparams.cpu_freq = get_cpu_freq_hz();
+    loaderparams.ram_size = ram_size;
     if (kernel_filename) {
-        loaderparams.cpu_freq = get_cpu_freq_hz();
-        loaderparams.ram_size = ram_size;
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
@@ -660,7 +660,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
             exit(1);
         }
 
-        fw_conf_init(ram_size);
+        fw_conf_init();
     }
 
     loongson3_virt_devices_init(machine, liointc);
-- 
2.47.1



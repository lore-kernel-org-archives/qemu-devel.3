Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0F8C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrS-0000XI-Bu; Wed, 05 Mar 2025 10:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrJ-0000O0-Ee
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrH-0002ae-P0
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390e88caa4dso3527542f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189229; x=1741794029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgCOVp2CKYNDhFT/FOf4qCf2zv7LZPk8S7w6YrhW+hs=;
 b=j7sga5FmOA/NLLKx7dHENpSFK5hx7TYNe0NF3wSZmNWc3ioKBQUD3gulMz4HZ0Ggdw
 dLF/nOEwuqivnG5yIe4+1Q9W4iWbHDx2odfVQaY4+7BSvFzWBYdVU1j2egXduLDgoeoI
 TBhxttXdEdMsz+4Xp1JxX7bsVlWi0qbZ9draeaDWZqAglYyoH6pDy5w1rnNlBNlwL5WR
 ShyumCkJtRc+QBmyR3uKy4dHvyLrjza5cLN83TcbwkONTHgEh1fp32m90ec8LA1CyiCY
 HwgkRdFMfb0LnIZvYvO9LMwZVfjeYTnPtsYJ7RIWdV7orzDw52kmc0Bb5FTJMYT1VswJ
 fuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189229; x=1741794029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgCOVp2CKYNDhFT/FOf4qCf2zv7LZPk8S7w6YrhW+hs=;
 b=jAl8noAItbU9inRrIdcDfOp5Rop8Dd6uPw21m+Jj9Ex/DBug2NfAnuToR7K5upfzKi
 gW6SmE/W8XcyJ4S/6qhuzMI4LeCZVLWelyXaQ1JQLwwuwSoTkpYTXbOjjARdcVYNC+cF
 1mQ3q6yZXhiXhn78f9lr+9FNqnXfwAueDWWd1KCco0eIEgpVuUaDe9utecMNgSqrpVLv
 Xlz5FPssvvz8zN1PiuqNQEUf+J9tIHe4iaKOIH1E7PrgSjyFfi1MlSWI/IH/kpqm9jMz
 QmUAkNWz8uLQbspiQX4V1G9OhVmdAPbyU9SbGrP4aWxRwjOubLQduDFTMVxZa9DgIfN9
 E2PA==
X-Gm-Message-State: AOJu0YztKfnd6l1PvoQ0s9MnBbF6romZEL2OqrQMSYEaQt9rZWe36lLa
 xh81MdAnvbp3dkQQyWt0I23hl7dYbmLTdPeVeHwlMA6eswCyb0tpsAXF9CiGlj3V/+5NnD3v/fV
 hVLc=
X-Gm-Gg: ASbGnctsxtCD9bDzEAUvPwDgCbrcfBqlW0GA6+Qz+laYCt7eShGJobf0EVCDSEZ0gdm
 puzhfpEjwZl9I7nJW2cUEyuChGDEFKZuueZIWOcgXa1swZU/34swfSnQxXuGeRvpEbN2nKD1t4V
 2nh6+2EEdsL0KEqaaLxQf1GLyjjAZtc5wR2aqBIZXciXDUCf6M8ii5qYjdaa1vFR11mU19Ycd1B
 hulWiZHWEaOYdSHYs57L8wY7xWdS546xBMDVZb9ageqc3FqorQ+3mPQMryxGVqzyMZeUeC8YAr4
 0qS7hVpqHYVnX6QPZguD5nuyi7+uKHvGPYieUyV2t9wYfgnXjwQEVkfE6NnBhkskHfF50LWGFTW
 6Wv+S7JFVsdaccB2njeo=
X-Google-Smtp-Source: AGHT+IFtTnpGJZhRlxgvjnVn6Po/DKZNrX2ZBL08LVLEjBpdLo8gSJ6bEWyY0hSTN4VgfupP19Uw+w==
X-Received: by 2002:a5d:5984:0:b0:391:1f9:c59a with SMTP id
 ffacd0b85a97d-3911f7c4cf6mr2948440f8f.46.1741189229495; 
 Wed, 05 Mar 2025 07:40:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6ceesm21094089f8f.45.2025.03.05.07.40.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 12/18] hw/mips/mipssim: Use legacy_binary_is_big_endian()
Date: Wed,  5 Mar 2025 16:39:22 +0100
Message-ID: <20250305153929.43687-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
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

For legacy binaries, legacy_binary_is_big_endian() is equivalent
of the compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/mipssim.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index f94dbdc428b..c0959a9e24f 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -47,12 +47,6 @@
 
 #define BIOS_SIZE (4 * MiB)
 
-#if TARGET_BIG_ENDIAN
-#define BIOS_FILENAME "mips_bios.bin"
-#else
-#define BIOS_FILENAME "mipsel_bios.bin"
-#endif
-
 static struct _loaderparams {
     int ram_size;
     const char *kernel_filename;
@@ -65,7 +59,7 @@ typedef struct ResetData {
     uint64_t vector;
 } ResetData;
 
-static uint64_t load_kernel(void)
+static uint64_t load_kernel(bool is_big_endian)
 {
     uint64_t entry, kernel_high, initrd_size;
     long kernel_size;
@@ -75,7 +69,7 @@ static uint64_t load_kernel(void)
                            cpu_mips_kseg0_to_phys, NULL,
                            &entry, NULL,
                            &kernel_high, NULL,
-                           TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                           is_big_endian ? ELFDATA2MSB : ELFDATA2LSB,
                            EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
@@ -153,14 +147,16 @@ mips_mipssim_init(MachineState *machine)
     CPUMIPSState *env;
     ResetData *reset_info;
     int bios_size;
+    bool is_big_endian = legacy_binary_is_big_endian();
+    const char *default_bios_filename = is_big_endian ? "mips_bios.bin"
+                                                      : "mipsel_bios.bin";
     unsigned clock_hz = (legacy_binary_is_64bit() ? 6 : 12) * 1000 * 1000;
 
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
     clock_set_hz(cpuclk, clock_hz);
 
     /* Init CPUs. */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk,
-                                     TARGET_BIG_ENDIAN);
+    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk, is_big_endian);
     env = &cpu->env;
 
     reset_info = g_new0(ResetData, 1);
@@ -177,7 +173,8 @@ mips_mipssim_init(MachineState *machine)
     /* Map the BIOS / boot exception handler. */
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
     /* Load a BIOS / boot exception handler image. */
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware ?: BIOS_FILENAME);
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware
+                                                   ?: default_bios_filename);
     if (filename) {
         bios_size = load_image_targphys(filename, 0x1fc00000LL, BIOS_SIZE);
         g_free(filename);
@@ -199,7 +196,7 @@ mips_mipssim_init(MachineState *machine)
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
-        reset_info->vector = load_kernel();
+        reset_info->vector = load_kernel(is_big_endian);
     }
 
     /* Init CPU internal devices. */
-- 
2.47.1



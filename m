Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3203FC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L26-0006em-Gm; Fri, 25 Apr 2025 11:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1i-0004oM-2c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1g-00044b-1A
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so17189145e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595098; x=1746199898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk+R4YridhukqVAAutZ2TUUvBuxoiK7M6RsZ8N/t+zg=;
 b=kSVEsf5E43NZUDOWTHYCTax5zIgPBo3ku54SgJ2lp1WDlRhXDiIZfFhUM4tlN3AJxI
 dtwyK+zIyZdZj96EjqBd2HxRSDJ7kIF776B6gaVZz5wVqOZB66QVvENK0ElFV8kWcR6N
 6Fd/2ErNbcqhThxmvwrcObyQRCEL0qrESC6MYghlKdaha/aY3I6z8ac/sDYhbucaztMo
 v+dVwQqlZSPSiX1cmpNaCQKlZMBBBma/pMTJvP2O6g61TPy/NaM6TXFs6CcEXRR4DHV6
 xjy/n4hZCMSaY6onrxJohPwJ+xH/oXr8OhOwVWwFeJBWNYpaYPvBQlqbRmY5Q4dYBvzR
 UGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595098; x=1746199898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zk+R4YridhukqVAAutZ2TUUvBuxoiK7M6RsZ8N/t+zg=;
 b=Ddqgs0D6dtNZTI5XOZm6yP1TIsDn9NDSvsnT13iuoTze5bDiBvNsxQd0QwChcM1Rhr
 sM/Y5KkI+MzbjiURVe+8+0aCmwX4RZOjtOLNnxv8ms1jiH40GZnrIwj5REE4IMb/6hEi
 iGk4d6kWuOLQKDjIybfGmSOuYuCoWyLNDPtmADgJNBUAZGGQTgliZKsdbrAdSwkdEWbZ
 1JX7ylgZrP2R5wbXt2fT7AgytXmbm0KPDiKm5Eeds9oDAqRBFTGFHmXzkjtZwfd1KdAN
 HE1yrW9YT7kZvadLuXVrVB+q8B4RtYfMaL8HUPHZF+pvmjJVeT8srMlxPklqjxzrFutF
 lQ5Q==
X-Gm-Message-State: AOJu0Yzt3WzYNXVce7LQIF4fxDSrPnTnyjIxHHXh3S833lQXEJOmeCwX
 sOaXlF2ph9JwkXahrAdyxIgp7cWIzeOf6CmodHFTVW7ECBIqo7LKu0QDGxlB9kIOrPGxbF/td13
 k
X-Gm-Gg: ASbGncvP4FGoPbI4965RGVl0jedm/lA7F3VBpfdgUZZsThapFunBbzM6rIyYzm0DrnI
 K5+chepHilGY9rzuTHCDknpMohvQ8ZUFQxJjGmGff23NCqC78nwwNIwh2qiLkiIlY2/I8MB6PHz
 4N8irTmbchhr6iIFHUnz3QLdn0tP288Y1UKYULZApQPu8a2uySt8FYjFQGO26MU8QY5099410cu
 6zhzOZILUxYm7iqOZNDxj+z5u1RwVy1L92FIoxwU9PwS+bkxSg61fYp8QDOs8/sE7mB+u9Dtzaa
 azZZI+Oz+/kA1/xf3k1bReLUXWRmp93QSnXzV6CobXmNwrFjBVk+YUYuuJjuRYT8rj+0mAJ16X6
 fkqUip7dau5gnRs4=
X-Google-Smtp-Source: AGHT+IEudoLt940TTi1jSl0xgrXAmmqdiesv1BNAaS6DRoxrAOAA8MahwMqgV5VbVhmpgM1hjFCBVg==
X-Received: by 2002:a05:600c:3c92:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-440a63492d8mr18866835e9.0.1745595097858; 
 Fri, 25 Apr 2025 08:31:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac27dsm60196155e9.22.2025.04.25.08.31.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/58] system/datadir: Add new type constant for DTB files
Date: Fri, 25 Apr 2025 17:28:19 +0200
Message-ID: <20250425152843.69638-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Currently DTB files are mixed with ROMs under BIOS type. Separate them
under a new type constant and turn defines into an enum while at it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <ae793d1f81e3577605759c43871722324a1ef2cb.1745402140.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/datadir.h | 11 ++++++++---
 hw/microblaze/boot.c   |  2 +-
 hw/ppc/ppc440_bamboo.c |  2 +-
 hw/ppc/sam460ex.c      |  2 +-
 hw/ppc/virtex_ml507.c  |  2 +-
 system/datadir.c       |  3 ++-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/qemu/datadir.h b/include/qemu/datadir.h
index 21f9097f582..cca32af3008 100644
--- a/include/qemu/datadir.h
+++ b/include/qemu/datadir.h
@@ -1,11 +1,16 @@
 #ifndef QEMU_DATADIR_H
 #define QEMU_DATADIR_H
 
-#define QEMU_FILE_TYPE_BIOS   0
-#define QEMU_FILE_TYPE_KEYMAP 1
+typedef enum {
+    QEMU_FILE_TYPE_BIOS,
+    QEMU_FILE_TYPE_DTB,
+    QEMU_FILE_TYPE_KEYMAP,
+} QemuFileType;
+
 /**
  * qemu_find_file:
  * @type: QEMU_FILE_TYPE_BIOS (for BIOS, VGA BIOS)
+ *        QEMU_FILE_TYPE_DTB (for device tree blobs)
  *        or QEMU_FILE_TYPE_KEYMAP (for keymaps).
  * @name: Relative or absolute file name
  *
@@ -20,7 +25,7 @@
  *
  * Returns: a path that can access @name, or NULL if no matching file exists.
  */
-char *qemu_find_file(int type, const char *name);
+char *qemu_find_file(QemuFileType type, const char *name);
 void qemu_add_default_firmwarepath(void);
 void qemu_add_data_dir(char *path);
 void qemu_list_data_dirs(void);
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 60b4ef0abe7..4a9c9df3181 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -130,7 +130,7 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, bool is_little_endian,
     dtb_arg = current_machine->dtb;
     /* default to pcbios dtb as passed by machine_init */
     if (!dtb_arg && dtb_filename) {
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
+        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, dtb_filename);
     }
 
     boot_info.machine_cpu_reset = machine_cpu_reset;
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 099fda39092..6fff0d8afbc 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -64,7 +64,7 @@ static int bamboo_load_device_tree(MachineState *machine,
     uint32_t tb_freq = 400000000;
     uint32_t clock_freq = 400000000;
 
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
+    filename = qemu_find_file(QEMU_FILE_TYPE_DTB, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
         return -1;
     }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index a070de23cf2..ee31bd8f349 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -142,7 +142,7 @@ static int sam460ex_load_device_tree(MachineState *machine,
     uint32_t clock_freq = CPU_FREQ;
     int offset;
 
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
+    filename = qemu_find_file(QEMU_FILE_TYPE_DTB, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
         error_report("Couldn't find dtb file `%s'", BINARY_DEVICE_TREE_FILE);
         exit(1);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 17115be74d5..c9969ae48a8 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -146,7 +146,7 @@ static int xilinx_load_device_tree(MachineState *machine,
         /* Try the local "ppc.dtb" override.  */
         fdt = load_device_tree("ppc.dtb", &fdt_size);
         if (!fdt) {
-            path = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
+            path = qemu_find_file(QEMU_FILE_TYPE_DTB, BINARY_DEVICE_TREE_FILE);
             if (path) {
                 fdt = load_device_tree(path, &fdt_size);
                 g_free(path);
diff --git a/system/datadir.c b/system/datadir.c
index c9237cb5d4a..e450b84ce91 100644
--- a/system/datadir.c
+++ b/system/datadir.c
@@ -30,7 +30,7 @@
 static const char *data_dir[16];
 static int data_dir_idx;
 
-char *qemu_find_file(int type, const char *name)
+char *qemu_find_file(QemuFileType type, const char *name)
 {
     int i;
     const char *subdir;
@@ -44,6 +44,7 @@ char *qemu_find_file(int type, const char *name)
 
     switch (type) {
     case QEMU_FILE_TYPE_BIOS:
+    case QEMU_FILE_TYPE_DTB:
         subdir = "";
         break;
     case QEMU_FILE_TYPE_KEYMAP:
-- 
2.47.1



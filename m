Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EF6FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtj-0000Ob-EP; Wed, 29 Apr 2026 00:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtR-0007lg-IG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:29 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtQ-0000yt-0Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:25 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so8206827a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438282; x=1778043082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVgwDWm2FZQ7Ipuxdrbl93wK7S5fAE7/3PcrEqAAO2o=;
 b=QWs/jQ78Ywx/Kli2AA/3T1QYNVfeNAqivt+OsdP5XS2TTOoZjTK2PHE58Oe6kKMo6q
 YVClmw5/VH0E3KCJSaHfbv/LtVNfOh5bOyG249h9O4K7+gWTv6Jf4ooiQi380iIVFL/J
 scIvEUIlCg3sFfJOzoxQ8vxa9ZMu/rXXcfeu2bZB03E1UIGTEiNVSgrpuIDSsZoorqTB
 hRmbFaN0qH0YSgWZvtFdSgeveARY2ocWNjmjNnp9Vg09spdTlsk6dBqQsAMz775WzV4L
 7shYSPegV3kR02Eq14BdC2PXn9xxuOrlXg0XU8pi9sQltG2qT+6aghXZjfsnroo3hlyu
 Ycew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438282; x=1778043082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BVgwDWm2FZQ7Ipuxdrbl93wK7S5fAE7/3PcrEqAAO2o=;
 b=RspWd9FjOQTk+JMcGbVPmobS1hObPeesxjIRZo5GvAWxUSudTGX/y0L+UBTEvx7luT
 1LZ+gRPLUaSXDcd5JRDpBldCFvpYmIrFO5igledFd8L6DGCTV36Ri3GiZDIKzr4fYWVi
 lKt4+7nKEZJ545e6spG7HiwhPtZIV6YL5LRJ18nsfBp8+bBBm/deugsAHwMzVkiiXzVy
 8hJOwfJXytaQ9C8C0f8OqiZedopBhJFDgO8n5GK1QARxjRB+mJApGEWr4QJUZpwtLKiK
 en73saxl8k139EKpF8FTB5yhzDFBgoG2vp4uL/eudBq2dkUMj6D++A9cWR5t36VCXOP0
 UP+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/g8UvlXPhLPikadyKYJakZ+bObZMIa/6BJoJu7cZKHHIxjXcWEDV94n10aGrrnGgG4vkr9kOndoR7h@nongnu.org
X-Gm-Message-State: AOJu0Yw09XUugnPYHbUZ7xySMeMOhC7wTOrYsmqs2A8m5Zl+FOnaRv6t
 oXDzOz0pXS/wVG3FJ0Amzq/xcRViTfR70HxSmEcpCETyXayUKz+dWDj9
X-Gm-Gg: AeBDieuU6D14XYJfSNVzbBRf4tKckVTBftxbeRp8/YgMhD6dtQLEZC2EbPTMTbMz1E+
 ElCZYfEnk06i4ruetV2Lh8HCOjgQK48q2n1idBQpqBKjcZ7ioieGFgc3iel6zl4auIYFz3SIhGq
 4cLI2i0wz2qqiUzV5ZSw4IvqbmF4R1mL5P84xdMpBK4aXhfN9UWr7IJpsFiuI5Ef6ikkychZ9CQ
 14SuBIFierRwEI3bLluBwY7UE2vD8aspC476QibVv607+o5yvMwhYRjPd5gWO7RMbTlDhXYKttN
 BCZzZeHTK4YoUtjhhJl+obvXj4wCciCe+vCZv3a0/EnrrOVjz5463M0EwMIy8P5qKLPnY3LkN9K
 wb6OjPeg54GXchBUZlBTxNU8HOj9iMZdD8zsR1/Uq5BI00cdsao/FlYTMeKSDet+65m77aE9S2H
 AN791QbC9U/HOgDuq/4V6h4xD9SSThvxY1QOkHzyRFxTdPaOGueG3L
X-Received: by 2002:a17:90b:2885:b0:35e:5723:85e3 with SMTP id
 98e67ed59e1d1-36491fb9afdmr6220062a91.9.1777438281806; 
 Tue, 28 Apr 2026 21:51:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/51] hw/riscv/boot: Warn if a ELF format file is loaded as a
 binary
Date: Wed, 29 Apr 2026 14:47:39 +1000
Message-ID: <20260429044752.4176397-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

It is possible that an ELF file can not be loaded, in that
case the loader falls back to loading the file as a binary
blob. Print a warning in this case because it is likely that
it is not intended.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260415064838.652297-4-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..9086793b7a 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -163,13 +163,27 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
 
     g_assert(firmware_filename != NULL);
 
-    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
-                         &firmware_entry, NULL, &firmware_end, NULL,
-                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
+    firmware_size = load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
+                                     &firmware_entry, NULL, &firmware_end,
+                                     NULL, 0, EM_RISCV, 1, 0, NULL, false,
+                                     sym_cb);
+    if (firmware_size > 0) {
         *firmware_load_addr = firmware_entry;
         return firmware_end;
     }
 
+    if (firmware_size != ELF_LOAD_NOT_ELF) {
+        /*
+         * If the user specified an ELF format firmware that could not be
+         * loaded as an ELF, it's possible that loading it as a binary is
+         * not what was intended.
+         */
+        warn_report("could not load ELF format firmware '%s' (%s). "
+                    "Attempting to load as binary.",
+                    firmware_filename,
+                    load_elf_strerror(firmware_size));
+    }
+
     firmware_size = load_image_targphys_as(firmware_filename,
                                            *firmware_load_addr,
                                            current_machine->ram_size, NULL,
@@ -179,7 +193,8 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
         return *firmware_load_addr + firmware_size;
     }
 
-    error_report("could not load firmware '%s'", firmware_filename);
+    error_report("could not load firmware '%s': %s", firmware_filename,
+                 load_elf_strerror(firmware_size));
     exit(1);
 }
 
-- 
2.53.0



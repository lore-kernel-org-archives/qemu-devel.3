Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A313CD6E43
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKeq-0007fY-QF; Wed, 27 May 2026 16:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKep-0007cM-KZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKen-0005ck-3O
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:15:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ee1a56328so230674f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912911; x=1780517711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qu8O8rtS738a8Ucf54GvfcNN/jmoBkFJcUUMjuQGH6U=;
 b=Pm2GKr2GEscF7enPwXigzaaHHUn3RQyYH4AuN9shWFC7MTdt4JEMSDZPgi3bSay4MY
 7wl+LKlyXlMN388BHOnXaurezgeCdA/A7P4h1U+Z56H8gyHky6XiPmDzzqQJzDd23si+
 ++y6IR7S9FLTlNmg2s13sdhnX2baoglQNY/iWtiCeSl3ckwLZdAEv0mZSwxHc4bczEm7
 dDPg0ryFbL9I4k3aq7tcCCLx6Z3LUQ8YUSfKlQfg+FVWU3ikCKVO+D6y4BeSSQGlrA2R
 FhEcLvs9AUl7GY3K7XByASUT32E4Gl2g3ZgxfiaT5x+A+Fg6BdwzSduANjFsdFnnQrv8
 M0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912911; x=1780517711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qu8O8rtS738a8Ucf54GvfcNN/jmoBkFJcUUMjuQGH6U=;
 b=ituM1S95m35GKtEG5oYtotA7J9IPCDVEhQ/GapooXUQH7CUKiGuI5x8m1we3siAHdE
 DcrMDyYmwlOG6eCnE3xyNm/QZ+w7UhDiIVAvYBf3fNsq/BJi+kuBuaDHioH+AeLyEVuv
 cTTOI1CW2ddo4C0LwV7AdDr5VVdW4bjO+Yz/Q/D1S4QAMJ0sHfZTr0hpwwKWDDLzcYYO
 IoxQv+3m061+sCtuNqVPR/RQkBTsgM2FADgv6x5frxP97RqdTvMlcMa+0L12UnAnx135
 5uEX+x5KcxxXCwGy//p3OI+Bi4fBXvmEmpZqiFi746uWNTYyhbsuwZHJSORSYIJWTF8h
 FQaQ==
X-Gm-Message-State: AOJu0Yzp9bYH6R9Rw9xW/EhUI42K20PPNYtu/GbeNgKG/wtytoNCbWv6
 YLV2xJmGm972GjHd2Rure8mz0aL67uhJ2x8CptKtouc/JDZZQJ6baR1QLdsdLiPLcC1QTXPrjXy
 sxLQwhz3IvA==
X-Gm-Gg: Acq92OGYza0IMbT/MRTc58viC5SQdkAgEdQKnmlSQfDXrhjTsK01vUekASGEwj0SFBj
 xQvTjVp7Fmc1NGXM7sYlWsYh4iQgqTibiDvr1l+cDbRQf3KSgaeUc/bn1hHjfktmJVIZP8cHtCh
 j1bvjhx6hAxuqDoFE1/G1rxTKUT4TSYrQqlZy1WuNSRdzc41uunMSJYxgWfAM6fY30K2KMjeyIq
 XdPF2LET2sC6eR1+tmIHenM7V8TWIsJmcPLa+MBllCBhQgD7piUaC7BnjQQw5KzRmQrQHBPAdOp
 ZH2//1r+GnD+jmTim4RNj/vZHzmWlAhpWzcuTv8SW20xbsZWPOWc3x/r1v9X9FInjlN5+fbxham
 LBxrUhrP26a2tgxi8QEUtFFxUKzf6ddZDzrSnnHS330ACb2N/12GxH8LA3vJ+szTQEE4mvAw3CN
 KkJcKASdu1pKolKv5LkhdbpYrXemMAU2+pHh5r76EyOJYXDU6Vguyf4ElY4dvgOETX82/XzWZFY
 qU+
X-Received: by 2002:a05:6000:468c:b0:45e:dabf:a00e with SMTP id
 ffacd0b85a97d-45edabfa2d2mr5891652f8f.31.1779912910665; 
 Wed, 27 May 2026 13:15:10 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a432sm11756563f8f.3.2026.05.27.13.15.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 10/12] hw/riscv/boot: Honour data endianness
Date: Wed, 27 May 2026 22:13:46 +0200
Message-ID: <20260527201348.29511-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Check the hart endianness property and use it throughout the boot code:

- ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
- Firmware dynamic info
- Reset vector: instructions (entries 0-5) remain always little-endian,
  data words (entries 6-9) use target data endianness.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/boot.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4297949f6be..7c9cd614681 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -407,21 +407,31 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
     struct fw_dynamic_info64 dinfo64;
     void *dinfo_ptr = NULL;
     size_t dinfo_len;
+    const bool rv32 = riscv_is_32bit(harts);
+    const bool be = harts->harts[0].cfg.big_endian;
 
-    if (riscv_is_32bit(harts)) {
-        dinfo32.magic = cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo32.version = cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
-        dinfo32.next_mode = cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo32.next_addr = cpu_to_le32(kernel_entry);
+    if (rv32) {
+        dinfo32.magic = be ? cpu_to_be32(FW_DYNAMIC_INFO_MAGIC_VALUE)
+                           : cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo32.version = be ? cpu_to_be32(FW_DYNAMIC_INFO_VERSION)
+                             : cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
+        dinfo32.next_mode = be ? cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                               : cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr = be ? cpu_to_be32(kernel_entry)
+                               : cpu_to_le32(kernel_entry);
         dinfo32.options = 0;
         dinfo32.boot_hart = 0;
         dinfo_ptr = &dinfo32;
         dinfo_len = sizeof(dinfo32);
     } else {
-        dinfo64.magic = cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo64.version = cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
-        dinfo64.next_mode = cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo64.next_addr = cpu_to_le64(kernel_entry);
+        dinfo64.magic = be ? cpu_to_be64(FW_DYNAMIC_INFO_MAGIC_VALUE)
+                           : cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo64.version = be ? cpu_to_be64(FW_DYNAMIC_INFO_VERSION)
+                             : cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
+        dinfo64.next_mode = be ? cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                               : cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo64.next_addr = be ? cpu_to_be64(kernel_entry)
+                               : cpu_to_le64(kernel_entry);
         dinfo64.options = 0;
         dinfo64.boot_hart = 0;
         dinfo_ptr = &dinfo64;
@@ -455,6 +465,7 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                uint64_t fdt_load_addr)
 {
     const bool rv32 = riscv_is_32bit(harts);
+    const bool big_endian = harts->harts[0].cfg.big_endian;
     uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
 
     /* .text (RISC-V instructions are always little-endian) */
@@ -480,9 +491,14 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
     }
     reset_vec[5] = const_le32(0x00028067);      /*     jr     t0 */
 
-    /* .data */
-    stq_le_p(&reset_vec[6], start_addr);        /* start:       .dword */
-    stq_le_p(&reset_vec[8], fdt_load_addr);     /* fdt_laddr:   .dword */
+    /* .data (must match the firmware's data endianness) */
+    if (big_endian) {
+        stq_be_p(&reset_vec[6], start_addr);    /* start:       .dword */
+        stq_be_p(&reset_vec[8], fdt_load_addr); /* fdt_laddr:   .dword */
+    } else {
+        stq_le_p(&reset_vec[6], start_addr);
+        stq_le_p(&reset_vec[8], fdt_load_addr);
+    }
 
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
-- 
2.53.0



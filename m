Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE7CD98E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQig-0005lH-KZ; Tue, 16 Jun 2026 06:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQie-0005fO-JM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:32 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQic-0003fU-V6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:32 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c857fba35cfso1951290a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604509; x=1782209309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8PhlzPkw58bsUy5fB/Xu08IOcfbpJ5W/1XPZlVe/rE=;
 b=ZgL9sSSYfY3A9xfnQklUiJrpPksv1A/x7H2Fv2r6cy0SI7PCD1eojHt57FkycjRiwB
 E4j6/bA4yqGMP1Rys55VfbetbL2m1NjO5nr8D8OKkkwd5HXAKrWLZ5KNTY7vRFYG0Ybx
 89Lya42zufskCd3FZBeuKsvYgudOUF5XUzLV+QUEX1LkvejN9TNlr/AtJ0URJ8Uon1KI
 NkLpvyMZdI2n26VutASVdFhAwsTL8wGIqgbvY+4cjT3WR94MvpYFnX0ImJiyW/BWrrWh
 WDLciYN4Wz9/n62ct2mTfj2eGLjPxzhVDKWth2cHmJzRTHkGmeXer0dPZG7EH2nK/y13
 TJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604509; x=1782209309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8PhlzPkw58bsUy5fB/Xu08IOcfbpJ5W/1XPZlVe/rE=;
 b=ZEbGlP4RSNG9FL9XRnP+hDUThmbl/tSoNtgaNMAoIQ4d+gUxC90d8q0mDJo20iFfkh
 sLr69fekvIsDDLZ7SzCMdgybIxBtQB+R4GiIMbD5uENIn0IZBjYcviyGN3UM9ErPMr3h
 MURY+oK1gQ9RdifKnz1yu4DkYCrE2FuL6ygyE2efpqA4VbaIdoPm/jEOMSiArSPU39li
 fufCwwXNKshSIi/RgohWUumMGrFzZ1X9t5zmToHPCwBCqqeQWrpnZqVTQECmL3Vqj/g1
 A2dkRpvZG4N3VXp7iFgKKTeKj5isZg17RykTElt3kWCgtuvjf/ctEoaHj5X3oiNEUWLb
 4Hpg==
X-Gm-Message-State: AOJu0YySNmn7PNaKi+OEdHziJdSA2ipYIheTDmTky+73Cbq311U/zVAR
 1TnfGSQdLJVQgDEMAoUdK0UJklvXzSJ9PbnT6JM7wxD6mr7WU8/11Zm7TJTX+qDQ
X-Gm-Gg: Acq92OE3Bu3AZrS+I+FZFMCmLTmpRXhGxx5GYRNhSxFDnA225FhFiDdV+0L0w3dKPjq
 5jKr3NL8cYwkAWtY7ENpeo6kCMw+yxIsF5EfG1KQ5YQZxkaSvYTa3pISIIup10eRnRhRIeZasIV
 yLJtvPYrbBV6pB7EwmNcZzF0LdynphBc/rIHjtWXkILrFcttYtqiOHkw6hZuXcSxPf2uhIWGWcU
 x1Vzn514aKNU8F07NYaDDxYfY/dOZIgEfstAY40z8YX6mqcnk1zSK23AIXzOUWKxBmKWJ5hToVd
 ap4pDVtjE/oeT5nZlWX57s631ptII2dgjzu54M1TIyag29q1fz1WS30qv44Ux8lBqEISi53+k0G
 XH1rK8YfI4GdnPFaG/fWb0vZkNDKGfBW6zmJ1eYKbx0sBBUi49Unr4pZliqeo9BQO1eo94iHUuC
 OhwBWOnIC0shT62StgVMriPlfBL9U/AUiRlaYMznA5
X-Received: by 2002:a05:6a20:7346:b0:3b4:65ad:b417 with SMTP id
 adf61e73a8af0-3b7e4dd7847mr3183512637.45.1781604509468; 
 Tue, 16 Jun 2026 03:08:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 50/83] hw/riscv/boot: Honour data endianness
Date: Tue, 16 Jun 2026 20:04:53 +1000
Message-ID: <20260616100527.1939565-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Check the hart endianness property and use it throughout the boot code:

- ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
- Firmware dynamic info
- Reset vector: instructions (entries 0-5) remain always little-endian,
  data words (entries 6-9) use target data endianness.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-11-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4297949f6b..7c9cd61468 100644
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
2.54.0



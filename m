Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA8FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKeS-0006Py-Ay; Wed, 27 May 2026 16:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeQ-0006PN-Mw
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKeP-0005ND-12
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so44524935e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912888; x=1780517688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8sLi8TpVj+WiyqU3QlE4wdZYfoI/mwrAP3TeMVzFfg=;
 b=poRX/UaTOaAnJdZnmJMgpeV+XXzQ5Xh8NXmyP9PBYDWeTAK+GQb0k3yCllRW8kyUI2
 Xwo70uQ6p84jlbSM0Muwv3DH4CMHeomEGOb301IYKtOnPT6fVMkS+bB40cxCHLpkpBBO
 de2XpuKCH4tcn9MY4kVMDwJx8yBs74tEbYIqwjgVGPifsyCLKwjF3i/luPbIWKZhiQRq
 T6iSI7AE2TggsvE6C0uJ85DD2MAR9QYOu+cbd1tHPXofpqAsADQicP/hKLr4IQSfQg4R
 EqB6BXgSbDJJ96rm5s5jrbK0pBBAnqi9s714ng5IJ21UGKx4Wgdu2wdwb1k7M532nkRp
 OcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912888; x=1780517688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g8sLi8TpVj+WiyqU3QlE4wdZYfoI/mwrAP3TeMVzFfg=;
 b=f3z+IpSDfT5FPdNfOpxY35uEDIG/OxoF3rmuQD52DfAIfpQgKr9frHurlV7rk+MLrT
 AcgTPvgNwCYZa+Z5szLZqE+M23vefO87fdmXbScqSXKo+MvoBYfU8xTKcmwu5+LnFDlJ
 YRMT/2iQt8Adi7kR/Aep0vIa5g9gMVYoEmxnn62i7B+3+jJKmTMck7dcEf+CIhVXQeYK
 PkPTMHKW+l9fS74xuwu7oqaQCp4ZYf67mmAYA5AS6hlDPssnVh25zedf4R0LGsEXjHLz
 Hotqzma9GCPdDUnUbRr6JI45hYkCYqAgbmgNuqQW/hQn5TtWvpxjg4qddSnMj7P8pSTN
 VrtQ==
X-Gm-Message-State: AOJu0YxKTzExP2nZhVwyo+VMSChL3iYD9iORfUhthZijcXCF6/4+3akS
 bVT8HAqKMXbULtCY1u8DOTeISJVbuY6PQvHpFOG/OR8eeqYlzpdUTaVYSINAel1sDmVazzVe34w
 V3UnuPzLpxA==
X-Gm-Gg: Acq92OGnlHK6y6ii5etbsE7fP8A9VvXeCwpU/s2gWLv3CKPbI5K1oRUi8CVqJ/QarWC
 0r+gz6i/AlcVQT2PWgZEW+b1CTYJB7Hxv+yyLeaY7dDZi+5Qe4WserKBbqhX6GIfqyoAp0xs4Ka
 1h99X5lc2UJry2flcA9OMM1QsCocEGZ6hOX/zlJS5QMbrJy2KaNjN+UsKfUzjEyFEjFG/Cb6CTB
 Fn1vGlGaLKebv9v0EFdzc+ELPM8tUkXI6bWhz7rEYc44lac6GimDvDhktNyLVq2y0XKKSQ7KYF4
 xcxfbMswUIRnjc1wtVARY9qJoWy81WCWqIWxxrNBz+rqhcsP+erPYBmbzCahQl7r+nHaRafOVPO
 1kpbIC/+q8IKgB2XQTuTpfcSvejod7fnmhW3EekANFg4F6FjNUZQl7yeackbA60di+RiboVJWz9
 JoYNA70X3UP1qWOJEswIjnqLkqStmiLHiurF8QeZ2cTeVRaHaCEXD/47YZBD6Q5YyEjw==
X-Received: by 2002:a05:600c:8484:b0:490:3c94:a3c6 with SMTP id
 5b1f17b1804b1-490428e205cmr425199855e9.26.1779912887601; 
 Wed, 27 May 2026 13:14:47 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ea134sm461293765e9.8.2026.05.27.13.14.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:14:46 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 07/12] hw/riscv/boot: Rewrite setup_rom_reset_vec() using
 load/store API
Date: Wed, 27 May 2026 22:13:43 +0200
Message-ID: <20260527201348.29511-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

In order to make the following commits easier to review, do
not pre-initialize the reset_vec[] array, fill each word one
by one. Set the start and FDT load addresses using the load/
store APIs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/boot.c | 53 ++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ae2f86c7ceb..c6ab1cc8cfb 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
@@ -444,6 +445,9 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
                            &address_space_memory);
 }
 
+#define CODE_WORDS 6
+#define DATA_WORDS 4
+
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr start_addr,
                                hwaddr rom_base, hwaddr rom_size,
@@ -451,43 +455,34 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                uint64_t fdt_load_addr)
 {
     int i;
-    uint32_t start_addr_hi32 = 0x00000000;
-    uint32_t fdt_load_addr_hi32 = 0x00000000;
+    const bool rv32 = riscv_is_32bit(harts);
+    uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
 
-    if (!riscv_is_32bit(harts)) {
-        start_addr_hi32 = start_addr >> 32;
-        fdt_load_addr_hi32 = fdt_load_addr >> 32;
-    }
-    /* reset vector */
-    uint32_t reset_vec[10] = {
-        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
-        0x02828613,                  /*     addi   a2, t0, %pcrel_lo(1b) */
-        0xf1402573,                  /*     csrr   a0, mhartid  */
-        0,
-        0,
-        0x00028067,                  /*     jr     t0 */
-        start_addr,                  /* start: .dword */
-        start_addr_hi32,
-        fdt_load_addr,               /* fdt_laddr: .dword */
-        fdt_load_addr_hi32,
-                                     /* fw_dyn: */
-    };
-    if (riscv_is_32bit(harts)) {
-        reset_vec[3] = 0x0202a583;   /*     lw     a1, 32(t0) */
-        reset_vec[4] = 0x0182a283;   /*     lw     t0, 24(t0) */
+    /* .text */
+    reset_vec[0] = 0x00000297;                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+    reset_vec[1] = 0x02828613;                  /*     addi   a2, t0, %pcrel_lo(1b) */
+    if (harts->harts[0].cfg.ext_zicsr) {
+        reset_vec[2] = 0xf1402573;              /*     csrr   a0, mhartid  */
     } else {
-        reset_vec[3] = 0x0202b583;   /*     ld     a1, 32(t0) */
-        reset_vec[4] = 0x0182b283;   /*     ld     t0, 24(t0) */
-    }
-
-    if (!harts->harts[0].cfg.ext_zicsr) {
         /*
          * The Zicsr extension has been disabled, so let's ensure we don't
          * run the CSR instruction. Let's fill the address with a non
          * compressed nop.
          */
-        reset_vec[2] = 0x00000013;   /*     addi   x0, x0, 0 */
+        reset_vec[2] = 0x00000013;              /*     addi   x0, x0, 0 */
     }
+    if (rv32) {
+        reset_vec[3] = 0x0202a583;              /*     lw     a1, 32(t0) */
+        reset_vec[4] = 0x0182a283;              /*     lw     t0, 24(t0) */
+    } else {
+        reset_vec[3] = 0x0202b583;              /*     ld     a1, 32(t0) */
+        reset_vec[4] = 0x0182b283;              /*     ld     t0, 24(t0) */
+    }
+    reset_vec[5] = 0x00028067;                  /*     jr     t0 */
+
+    /* .data */
+    stq_p(&reset_vec[6], start_addr);           /* start:       .dword */
+    stq_p(&reset_vec[8], fdt_load_addr);        /* fdt_laddr:   .dword */
 
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
-- 
2.53.0



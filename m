Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B328BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqra-0000lU-6P; Wed, 05 Mar 2025 10:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrU-0000de-1c
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:45 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrR-0002bt-UR
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:43 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d432so4644332f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189240; x=1741794040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yTWsYV7yfcZRB8fKtcjLgcDtoMSuGOlcV0M3TYNzGI=;
 b=UzoVL2nakmRGmzJfmGz7PMGX+0Wve3Dehhz5M9YBUVSscGVZdx6/gRbWOtpTusDIeI
 oi1RkVJVq9Xqo36CFpFjBTkw+LB8dpF8UDHNzm+crOwZ7qDq/Dvxc1BVoIggONOqoEpN
 tTa47bqh5yJ5TIYd6haTXT7WXK28HIgl+ORE0eQPunJKSWEAJG+zSvyg2Dh5q3IEz+TY
 cAoBgTHlIJ8BviFw3TjQSGPr+1ZD3L2xKKSC1b48Xb9m9qMbaChFPALTMPbMxbK6YNJ8
 mdj5uyUG0gRgvfyWZzd+1YdWt1vhLwwGssYlwuqze9nizdz3kJb0spK8BBfBJdzTGv2D
 m0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189240; x=1741794040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yTWsYV7yfcZRB8fKtcjLgcDtoMSuGOlcV0M3TYNzGI=;
 b=RH6PQhD1Q9lmHZ7Hn9fdCNn4I/mVyeo2KjBikHEJXM9MPC6yyctF++V8eV56sde/S5
 DBNigjQIiY+dtnOZM9YtY694y8Vlb2Nkyf56Sb0oAvXdvr8tvIBJ8k2eEvzKVH/DUEZO
 DjhiIdn9a7TSK1rN912n4EzTGaq8kk0DNoApv4O1oKefCGudpdtZElc3qZEUB5A2QgSe
 r2usCMvX8SrdvSx6MgwAchjjcbxesxs11YMPRu8XNQ+2Ajo50MHFT9ivPpTkqdlo5mF2
 dbl2wvAIn5yUEYUMvNOkg5j/3ziZW/gSHiszX4EEC3kUps5H5djkF9Mrd2aVsqJ8mhX8
 /4kg==
X-Gm-Message-State: AOJu0Yxw7YxIa8lEAlDCyKtJ1kcoYAgT2I1L3EdH8Tx5KbfNUcVAR11i
 Z97zUt+k1+185WJ2i5YGvr78aORlOlWsIIPwJB8VPRo5EW9mZo/XBSxTmFN2vK/EaUW8L85cVCR
 t630=
X-Gm-Gg: ASbGncs30mW2wO3QCsTCvF42pbGjtRqQzyJwCxGhTRtO7vQn5sa4UznZibtl8puFWBN
 qhoH8xsHEvSr1qs37N4gOQa3098DISvjL7f1iSYMnuk4TcArH2v5Gy9wmSr0DXnreui5LWwGR2i
 311+I9xCgteswqEJKwQlP4Z4SfoypOuDgKEbUv/fSKKmby79EIJaVu5WGMkAdsw9UXjiMFbAfbV
 7YkVF2V4fUGB/m2UUyH17NuoSAdaQDL9OCZ9zsDP335NMkEhT824NG4HKgJ2b6OnkOZ21qewXjY
 ysdur9DVws1Intn4/x6hA10Gg5Ox51YZikBn6m3agGQzcZcGtbFwGU3kuTQCJSoNoIecTu3+cec
 nOYbwtEIghTI4YoAuBQU=
X-Google-Smtp-Source: AGHT+IFOQhx56i9GhpkFWeMqO+r36ELBfvzHkZvTWBo5eoemy07OMx/V+xN1/4OZH2QfdKI9HmV6sQ==
X-Received: by 2002:a5d:64e9:0:b0:391:2192:ccd6 with SMTP id
 ffacd0b85a97d-3912192cd5fmr2461486f8f.39.1741189238864; 
 Wed, 05 Mar 2025 07:40:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d6dbsm21356258f8f.82.2025.03.05.07.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 14/18] hw/xtensa/xtfpga: Check endianness via
 legacy_binary_is_big_endian()
Date: Wed,  5 Mar 2025 16:39:24 +0100
Message-ID: <20250305153929.43687-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
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

For legacy binaries, legacy_binary_is_big_endian() is
equivalent of the compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/xtfpga.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 3f3677f1c9a..7f0a849b795 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "system/system.h"
@@ -238,6 +239,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     uint32_t freq = 10000000;
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
+    bool is_big_endian = legacy_binary_is_big_endian();
 
     if (smp_cpus > 1) {
         mx_pic = xtensa_mx_pic_init(31);
@@ -311,7 +313,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
-        flash = xtfpga_flash_init(system_io, board, dinfo, TARGET_BIG_ENDIAN);
+        flash = xtfpga_flash_init(system_io, board, dinfo, is_big_endian);
     }
 
     /* Use presence of kernel file name as 'boot from SRAM' switch. */
@@ -399,7 +401,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
                                &elf_entry, NULL, NULL, NULL,
-                               TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                               is_big_endian ? ELFDATA2MSB : ELFDATA2LSB,
                                EM_XTENSA, 0, 0);
         if (success > 0) {
             entry_point = elf_entry;
@@ -437,9 +439,9 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 0x21, 0xfe, 0xff,       /* l32r a2, entry_a2 */
                 0xa0, 0x00, 0x00,       /* jx   a0 */
             };
-            const size_t boot_sz = TARGET_BIG_ENDIAN ? sizeof(boot_be)
-                                                     : sizeof(boot_le);
-            uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
+            const size_t boot_sz = is_big_endian ? sizeof(boot_be)
+                                                 : sizeof(boot_le);
+            uint8_t *boot = is_big_endian ? boot_be : boot_le;
             uint32_t entry_pc = tswap32(entry_point);
             uint32_t entry_a2 = tswap32(tagptr);
 
-- 
2.47.1



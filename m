Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506D6E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8eT-0007o7-JC; Sun, 12 Jan 2025 19:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eP-0007P0-HP
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:53 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eN-00010l-QG
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so26340045e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729390; x=1737334190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t7LN/wKZvE1noLloA1ScY9xrm7gHXj/oUl+gXuqqpU=;
 b=sntkCroIm9AADpXZ688KLaNL2EXoOYFJSmGwIl5bYmdWuH0/3PVtcBeWAGTibYh2zc
 fbv+QEElkYNdwqDfLQjSO6ibZrlz6uoVu/GYrMkWZ61PQQ3itQwTnp+Y1RHhuJkVeQ4h
 pDdDjuiphGi1XuFB76NMAjjExJcBVPZZcH1AYUWWcgfdxdyPfEwp1yDZt1IA7C4Z35St
 sXhZGszV2pnAnjnnPo7xDs9MG61ATHw2nkwWs88jxWvgt0rsX5e1o5G3bXvenUaho1TR
 Y9k3+MYhJ/3OU+aj5qOgrp4b6CuMZohnyRZq3sbiAI0Lcg4mzEjiIlKX6qOrKJxbxNzp
 /5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729390; x=1737334190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5t7LN/wKZvE1noLloA1ScY9xrm7gHXj/oUl+gXuqqpU=;
 b=A0T2j6oa8Y94V2DFV/wPwVaqDJDyoNtTOUoHXd12W/ucj1KT91IPhiaQ8si5AWNwll
 D9BzQEOj/RYVNhyuCThiqttO5tYkzJn7f3zIDT83z2DuNlOXOrgXqcISOmQhKfsj4zqT
 4a3JCcA3LbK1eBpDxf63lQKXUrk5ksy20VrNL6B22r4i15Asg7AO5YwZKlHO8+LUb33o
 SQshr4Szc6kkTz7W5nyBKzOc91+gtcr7yyCimxckOPR8+3Q1Q6xQXioClc1TJoOfOCTA
 vXw91nj6yg7I3BQJkYKQq+JfZGJKcSGweXv7ztCC0yxBVlcTxOYMjlLfHw/Ex2epDarq
 qrVQ==
X-Gm-Message-State: AOJu0Yz7aMsgfioXQYdPtxUCZlV+JZuo0bypXx0YHitZReS8vWejc+KK
 MVbgpwXqeQPHY/z/Pq3ITus5gCyq3vc0okg3RoSHtUjDFfdz/zbSXXQ8cQuz/BDIX5Kq3tYwQaQ
 BIgU=
X-Gm-Gg: ASbGnctSHy5RGoWW8k5NJpxsvMVAdcmnKvByNxl23O2VKlb5eYvySWBdt3Ula79k9Qz
 +BvuE8hRRgsCSwkBZuvLY3A3Ea096wlUlGuhTn9I6EWsHtSEWiRSXS/Xi3Yrwf062uog39mBSPs
 jnG/UyQX+Cz/ouAUmyYU150Lw1UcJqAFTp8M3L4DUirDLCValysgz1XMyAhUlyZqhpEYAeZb75Z
 Z/5WVI+zl5BzY0Sv7cN+0Zp3mfFCXWfWIhTiMr76ryNWFbPoPnFs6xKp6AdReX4OB5YRi/0Q0/e
 U5p4Ygq9fD97JFWgfVRtyFZHM2PlfYk=
X-Google-Smtp-Source: AGHT+IED2ZrvfsmkVYjiAmblygTMRodVkeQtnqamJdy+IIuJnKC8vCPowlTr3zJBYiQaidlI1m5xiw==
X-Received: by 2002:a05:600c:4586:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-436e26f4b91mr149209055e9.25.1736729389903; 
 Sun, 12 Jan 2025 16:49:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fd03sm129722785e9.6.2025.01.12.16.49.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 21/23] hw/mips/malta: Propagate MaltaState to
 write_bootloader()
Date: Mon, 13 Jan 2025 01:47:46 +0100
Message-ID: <20250113004748.41658-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Pass MaltaState as argument to write_bootloader() so next
commit can propagate it to bl_setup_gt64120_jump_kernel().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index a037ec2cc8d..589e1a07e47 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -692,7 +692,8 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
                        kernel_entry);
 }
 
-static void write_bootloader_nanomips(uint8_t *base, uint64_t run_addr,
+static void write_bootloader_nanomips(MaltaState *s,
+                                      uint8_t *base, uint64_t run_addr,
                                       uint64_t kernel_entry)
 {
     uint16_t *p;
@@ -744,7 +745,8 @@ static void write_bootloader_nanomips(uint8_t *base, uint64_t run_addr,
  *   a2 - 32-bit address of the environment variables table
  *   a3 - RAM size in bytes
  */
-static void write_bootloader(uint8_t *base, uint64_t run_addr,
+static void write_bootloader(MaltaState *s,
+                             uint8_t *base, uint64_t run_addr,
                              uint64_t kernel_entry)
 {
     uint32_t *p;
@@ -1172,10 +1174,10 @@ void mips_malta_init(MachineState *machine)
         kernel_entry = load_kernel();
 
         if (!cpu_type_supports_isa(machine->cpu_type, ISA_NANOMIPS32)) {
-            write_bootloader(memory_region_get_ram_ptr(bios),
+            write_bootloader(s, memory_region_get_ram_ptr(bios),
                              bootloader_run_addr, kernel_entry);
         } else {
-            write_bootloader_nanomips(memory_region_get_ram_ptr(bios),
+            write_bootloader_nanomips(s, memory_region_get_ram_ptr(bios),
                                       bootloader_run_addr, kernel_entry);
         }
     } else {
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C03C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXm-00069n-GS; Mon, 13 Jan 2025 14:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXk-00063a-AJ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:12 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXi-0007TL-NW
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:12 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso33947345e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798168; x=1737402968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4kmZyv0O5bHo8aW0lg7ydcay6cFbqBLxdZksmJ/bR0=;
 b=ZFqVV6SUPL2ZHAeTCmb81sC1VGNfK3qVGSpmXfm/KUDSSXBuwCUESW1ZYhLOPswNK7
 x1A4fCmNGXxAuRKXFNRPxdjuBC5ATP4H3QaCrgT6NngpsGgQlP+PHo56yCjFlA3Ovz2Z
 wrAVmoHGDK1bPZuDDPdzC9vittyt1Ogx2nN9Wb0qNl5lbsn+1pURrKO+HQuinpdhhZgb
 c8B7iXAduboG2aytwyNoTGUd4ALKT4xagVAhZIQxJNqS6CQHQqip1kL/BF4BsiNVWiyA
 LhaJTKXbkuZOSSuy/U2G5X0ELqE6COhwmE2ZXduW2QK1aZ+a1x+eNWBfRwqG5o0cPt7n
 iGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798168; x=1737402968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4kmZyv0O5bHo8aW0lg7ydcay6cFbqBLxdZksmJ/bR0=;
 b=AvhbSxhc2CJ+IjgcPUcVMVoVN9LZLDoVr4Rn9lW3Xt/IXE3f9XPKp9ZCwBkaprI7K3
 a7XXiEQ5BAfXKSzcLVYOll42FjzPPa8P9nS87c45MQORKxgzldk3r75fFW09lm8jkLIF
 OWvPQWuyDvQVtAgyYXv3XuDccck9PI0qwjAwXZwIZaVwcVluWGEKpcnMBxvd7bV9NMzt
 xJCIwX1Do2L12yewoM0xA8KW3ofstYqsDmiw4uICtGzwy9nNtkbrMdQeXl2PFeuNZLZn
 nb+KL7aJTDy757Dq56v5sZtqGFO5Gn9QwLZwteUCBO7xq/RlWLhZqRsb48DTlDQOY78/
 /qGA==
X-Gm-Message-State: AOJu0Yy7h0xsf4Px9d/1QusUuPIRwoPPI5alhhwCyzVnawmx/0eNrvKk
 kFm2zrRK76xJZyOdFYORkAt8DD48Ex1L90zc+ByBuohSQ2idFXD5axJ0pbypqKwhg3zekJHS7KU
 GOvY=
X-Gm-Gg: ASbGncsRFjHy5ym+V9p8wiKb6mXIUZVcW9LdeJibUYkhff6SGkLfdvXyIDDyOghRUDq
 z4Ac0MNvi0KQekhfmJV6F7oeJkBbfn5aBfVQ2IQ1uPGQofXUwpJ1g85CnrEFftbOphaZYC8jCyK
 vjNVKBof6aWQaLBOy9ChmM0OmAt/5YdGV2Rw/NPnbGMj/meQKOkbIJ8VNk66Y2lWQQBOU9wlqGM
 6n5MEcws/Uf40TZ1zSH6Kou8CkP4poHAsZmtSNruDorD/IIb63kWbyE9PAmysNAwZD1zD58jBxA
 NfcXt7fMHTEvph4B8w6cYvDxGlnwOME=
X-Google-Smtp-Source: AGHT+IEXrSrZiQlAtZNTidw/iK9c3TP9IrQwdCebRSxkUrYNA46e5YdYDJtonbnXYaJN1yP/9KiZ3Q==
X-Received: by 2002:a05:600c:1552:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-436e26be5a3mr216603955e9.17.1736798168596; 
 Mon, 13 Jan 2025 11:56:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm153973325e9.4.2025.01.13.11.56.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 08/19] hw/mips/fuloong: Propagate CPU to write_bootloader()
Date: Mon, 13 Jan 2025 20:55:14 +0100
Message-ID: <20250113195525.57150-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

mips_fuloong2e_init() created the vCPU so has its reference,
propagate it to write_bootloader(), removing the &first_cpu use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/fuloong2e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 16b6a5129e7..c4080a8a6e3 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -163,7 +163,7 @@ static uint64_t load_kernel(MIPSCPU *cpu)
     return kernel_entry;
 }
 
-static void write_bootloader(CPUMIPSState *env, uint8_t *base,
+static void write_bootloader(const MIPSCPU *cpu, uint8_t *base,
                              uint64_t kernel_addr)
 {
     uint32_t *p;
@@ -258,7 +258,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
         kernel_entry = load_kernel(cpu);
-        write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
+        write_bootloader(cpu, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: FULOONG_BIOSNAME);
-- 
2.47.1



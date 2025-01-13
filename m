Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ABCE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8eM-0006wx-FZ; Sun, 12 Jan 2025 19:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eF-0006ZU-Qc
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eD-0000xn-Eg
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so2058933f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729379; x=1737334179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTZEKKLS4PrCy1H2BI5piTVs8fWWFd13d+VvsRM6L5Y=;
 b=uuPd5TJQmx9W6i+B4ueJV1st9rxu/eKkrvaDThOW+0deqQsU7lZyu0oOyy7DZUUFEp
 IataLQ2OrA8ZYscBDqznB7HO2fMiTpBjq3f0if3q8Q+w0zVnnUv7McjUoPTDHrCv67Wv
 mA5NROtRTrfyMyfvn0pYOqvCINCY9Fph9u1Refzfzsfx4FJdkILsLikPeEhqo4QM21Ut
 Rsx7BMmRZUi1X7sj/SsemI/rE46OWtwLhCEJ1eNCpvjSt+Hv1oud+utfWwYBt/ta8CdB
 CQLgDiaRkshHOvk0vjGKGDSQxVN5OqqZ/zR8hnOgAf7DMZ8Y9IQx+4ED3z7mU315K0vY
 3q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729379; x=1737334179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTZEKKLS4PrCy1H2BI5piTVs8fWWFd13d+VvsRM6L5Y=;
 b=pvUoRIosGUVLenCjWyjP6X/aAu7UWTu5QGHf2YvF4+ARFiyik4vXyLirpXHvQ8C6/R
 xm0Ml9fXZIEOujfkEfPb7IYGm+q1dhQxa9jYhUxfdpvyO/Iv/X8WaACNkcnqna8ZBgml
 TnOpJ47ESx8rhkIROgUETSLXP+wcpFyvd0uNcd2wQVakrpDBypY8QiJ560EP1ATmH3De
 3iXMAka5iURuww43k+nOF8KFeoNXzjPtyPRz72MzJqI3gEDXcrfiF0w58qydzGO9XI1Z
 lH5ZL78l0KKNl2SNX0Lpi+cJxxj5OVmv7c026vHV7FazGfLnFjG0Ka+xaVzJlK1KgrRs
 /F3A==
X-Gm-Message-State: AOJu0YzV7iSxCDhhyx+llA5Po3K9RiaRlnoxwen4AT7MRF09VM150OTz
 Go+yxm+QJmWOb1g0vjTbAHyKjIURUApMd+iS7mST6wSYu6cjQnnC1jt0LnqaijOOc1sNlaVZXJb
 NFL0=
X-Gm-Gg: ASbGnct3YxpJKeY8xNNBq2ABFyrni36SbVCho5kK1QkDjfmJqXXWCk9YfdiCh8HbmwX
 MzXkdqb+SKyOf5itVKjAmXeslxsXiDnqcaxItCiClcN8pCDAsb7F02Ie0LzNGlm5UssesnxgBOB
 JRPseXahT0ccMPc3YLp5wmrImrINCTiHvJk2wLxSfWJ4w7x6hEY951kg3Or1oC7PQ0wArKUZC6d
 kCMXjBU6rMiL4L953glV9nMCk2svMyEjmU3VZMuHSYu3NlQq8UVkVZB5luADqPYtXkGFKowRnFM
 5/ZsZekHT1alkFNqZsXGRSKmNjVT4Ms=
X-Google-Smtp-Source: AGHT+IFkWDguG0lB1L45FBqNQKhmga83S/UYq8cfgnHwrvI3DVMWcXE+VLSGgnLLWW3hDTXubSxhzQ==
X-Received: by 2002:a5d:5f44:0:b0:38a:864e:29b1 with SMTP id
 ffacd0b85a97d-38a8730ddf8mr17410096f8f.41.1736729379134; 
 Sun, 12 Jan 2025 16:49:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0casm10893890f8f.11.2025.01.12.16.49.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 19/23] hw/mips/fuloong: Propagate CPU to write_bootloader()
Date: Mon, 13 Jan 2025 01:47:44 +0100
Message-ID: <20250113004748.41658-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
 hw/mips/fuloong2e.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index b87622ee6e3..1e55adacdd2 100644
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
@@ -179,7 +179,7 @@ static void write_bootloader(CPUMIPSState *env, uint8_t *base,
     /* Second part of the bootloader */
     p = (uint32_t *)(base + 0x040);
 
-    bl_gen_jump_kernel(MIPS_CPU(first_cpu), (void **)&p,
+    bl_gen_jump_kernel(cpu, (void **)&p,
                        true, ENVP_VADDR - 64,
                        true, 2, true, ENVP_VADDR,
                        true, ENVP_VADDR + 8,
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



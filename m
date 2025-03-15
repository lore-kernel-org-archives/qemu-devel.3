Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865CEC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSU8-0005Pf-QP; Sat, 15 Mar 2025 10:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSU2-0005OM-Rj
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:27:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSU1-0003p7-4t
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:27:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso3699765e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048842; x=1742653642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=oR5fyK/RXv36z/735yS0fIm0JdZzZZgGlFV/CkdVgYqlJ8RTQ4MM+i4I5uaRdbjOn+
 yyTof5lh6vUiqYsR7L5iMRnzgYAFyNS3Vc+EQFaNw8QfZYwEgkzbAksrSmuh1yE8hQfX
 hDn05CCJuvnil1rGrPXkZYKQ8JY96CX7bcDKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048842; x=1742653642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=vHFMqMtjxZ2Vd1elXkou3juvZZ1/g0wjabchrYg4NWn07Psm0nS1BSBm8PMUHjJeGF
 MD1RSiQQD11XsOKw6YGMXTljJFx/Oj2XEDodo4PJO4SwtZntTaOgdW3T7U7HAEBSLrmT
 6iWkPjSc0O5r9BC7ceo9zLFXAjtqY1ShbwK5TH1CO446XUOWpQiQ4ibPXwfMVI7WfdIm
 3Jlo9vrK2rQ3ZFucPdz95vlUwGDOQOMyx4LI5AH/gIinrOtXPH5ehJoRY036VHzPlemH
 MtMSOyQEfuTFTJUilvmv3gCVAXLqnT/qRC3MiKpl/6xQnK6cgrgOwQnUHslfMu8dGGGb
 Ebkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2hqvHTeuRU6pgTuTIOakUA3WrCrIJtFK9jUUYSZ2sOYEXQ6EE791yEXiVsF4ADKSdrZCtQuuTgGmU@nongnu.org
X-Gm-Message-State: AOJu0YzYPgWX14zPIvGqAwAgXZMzVqIJdQ+UPQxu7xVAqdTRLAyCxfSX
 fBPCOT7FQNwr3Mk8kCfGv9HoQ6oIdWp4brgUqLjJUuQoHwt6op065+DhMFqRAMalAwhdnH7xK2j
 dvA==
X-Gm-Gg: ASbGncv3Zolh8SPPUpH3XQaHGEmmf+fqs4ENul/bZEiPJdr0jW5DPGDODTIsSoILRyC
 qglvg0/jZ7JlW+wYVkCYUtyssfHS++ZpCjsu22eKo6ktlshDTNNGir/IdHFlj4pJDkedYV7ND0g
 2V6gWF7n+LPNAC6TWmJQZAjAHBy5Nm9l2yTQZy/37kWaN1F31UVn6XWeAClBvk+6Qu+GHNI8pxE
 fsxttUZGHIy/Bmp9F+s6xau5cw9qltgf19wJEckuv5KmYt2YqrrVwX2SbjH5hWY0Dan5QDWwRka
 ZY5hfB5ruZhbZZ40gKVeHtggQzgQPrYW4iQaG/lYZg==
X-Google-Smtp-Source: AGHT+IGQFKxTe9uUhW69L/A1IKrS1GeD6w9nXe1sPPJUaJMkVEXu7Qea37LPcLLKzb6JIV2El1doTQ==
X-Received: by 2002:a05:600c:6b09:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-43d180cef19mr124533465e9.13.1742048842173; 
 Sat, 15 Mar 2025 07:27:22 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 06/46] x86: qemu: Avoid accessing BSS too early
Date: Sat, 15 Mar 2025 14:25:26 +0000
Message-ID: <20250315142643.2600605-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=sjg@chromium.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

BSS is placed in DRAM which is actually available early with QEMU. But
it is cleared by the init sequence, so values stored there are lost.

Move the system-type flag into a function, instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/qemu/qemu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/cpu/qemu/qemu.c b/arch/x86/cpu/qemu/qemu.c
index 563f63e2bc8..e846ccd44aa 100644
--- a/arch/x86/cpu/qemu/qemu.c
+++ b/arch/x86/cpu/qemu/qemu.c
@@ -15,14 +15,21 @@
 #include <asm/arch/qemu.h>
 #include <asm/u-boot-x86.h>
 
-static bool i440fx;
-
 #if CONFIG_IS_ENABLED(QFW_PIO)
 U_BOOT_DRVINFO(x86_qfw_pio) = {
 	.name = "qfw_pio",
 };
 #endif
 
+static bool is_i440fx(void)
+{
+	u16 device;
+
+	pci_read_config16(PCI_BDF(0, 0, 0), PCI_DEVICE_ID, &device);
+
+	return device == PCI_DEVICE_ID_INTEL_82441;
+}
+
 static void enable_pm_piix(void)
 {
 	u8 en;
@@ -50,16 +57,17 @@ static void enable_pm_ich9(void)
 
 void qemu_chipset_init(void)
 {
-	u16 device, xbcs;
+	bool i440fx;
+	u16 xbcs;
 	int pam, i;
 
+	i440fx = is_i440fx();
+
 	/*
 	 * i440FX and Q35 chipset have different PAM register offset, but with
 	 * the same bitfield layout. Here we determine the offset based on its
 	 * PCI device ID.
 	 */
-	pci_read_config16(PCI_BDF(0, 0, 0), PCI_DEVICE_ID, &device);
-	i440fx = (device == PCI_DEVICE_ID_INTEL_82441);
 	pam = i440fx ? I440FX_PAM : Q35_PAM;
 
 	/*
@@ -123,7 +131,7 @@ int mp_determine_pci_dstirq(int bus, int dev, int func, int pirq)
 {
 	u8 irq;
 
-	if (i440fx) {
+	if (is_i440fx()) {
 		/*
 		 * Not like most x86 platforms, the PIRQ[A-D] on PIIX3 are not
 		 * connected to I/O APIC INTPIN#16-19. Instead they are routed
-- 
2.43.0



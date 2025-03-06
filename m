Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08293C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDj8-0006i6-Ti; Thu, 06 Mar 2025 11:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDiW-00061k-AP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:03 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDiU-00085w-Hy
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:00 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso2924165ab.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277097; x=1741881897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=MMR8nphitQ/WDcheEWdnV6IJWF1G1FXKxtvaTc1U1y4/jE+h0h1od+engyb6om/umW
 sgCLn2LSljMfXblD2C5v0G46pp1hlULiRD2uMt8FVQfGWuD7ttFQBaeAlv8FH/VsOZ3B
 i5Lo8tH3HNdy9rEwoQ2zvtgsYmU9HPxuUR4l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277097; x=1741881897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=KRFBYZP4xcUODRLHqsIjisO++V+rllF6IzuVCbTSDAmGR/3avYr2Yj9HCNVip4bKEf
 vjgSfPWaEHvOmX+Pi7IczEGcPk11C/VQkd+hdJgrhI5YRb8C2LmY8ffDZyiA5chHumzr
 Z2vkzYtUDvshSonVieE02LTlF7qzwKg7x+6MD1BK6WUA9eZqAdWDx5m4kUEeP6Qgz05U
 apVxK9bQ3CCXmV+/Y6b4MHltbdf2RaxFtylBYO9OtSYjkEqdqEIdOkXqpOk3conHl3e/
 3ixxNcf4rmSlTReX+CAJfcOrUFZJNDIeotyPb+LJC2iGDUqmkz9HgDiH5eMarK2umRaQ
 Mj3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8aF3kCjd9DATYKZEFaBbVhrPKVqjnqIO0v/1OOCWQRKlsESutWDrJRnKm6OQyAh+2nnWn6sgYeTAU@nongnu.org
X-Gm-Message-State: AOJu0YzOMMoNdkJF4/tABTDk2++3Seh8txYyPxh09dvF1LRr0bmbR1rZ
 3qJOF4tFAaJEcWYOAp2/S6NTtiDJNBGWAPtF3z6Paq6qe83T9kzRjytIj9ds4w==
X-Gm-Gg: ASbGncuD1ftlKmEacJK3jQEyobWYSP/ZWEEJ2s8r7ZreqfV+25N90rsB2HkrGKDozKs
 +5+94LwNX+66Ifycvm6y4eurbvhDFN6KuqpsGB9oBTmaGr57pu9q9MKcQAPWq8VM3/o7twbzbua
 0VDcGwJK4rQse/st5PlY8dKPdGW1WedHDNLrvKwrqq2COx+a4XBiFDz7usXoBYTRA6+XBBXioT4
 OXBYxz821UthXczqA3v8FeWqI6orwKnSmTlL1jyog2eJTucQ5cY9ceBHP/lD+AcW372fhFYugwA
 Pd/XkVebctKoBg/awEUShfNZNVxgP7CvabY/QrfIosi0MU2+k+gpxNEC9901krYRfED4FJO8xvL
 xTUm46w==
X-Google-Smtp-Source: AGHT+IEEQXDzmyW5nkBuIaoREplf5yZ8Jtg/vswpLt2FZkwUf5WEnmJN1MFp2Hg2Quy0N2OWtvpMLg==
X-Received: by 2002:a92:c266:0:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d42b9759f5mr105381605ab.18.1741277097260; 
 Thu, 06 Mar 2025 08:04:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 06/47] x86: qemu: Avoid accessing BSS too early
Date: Thu,  6 Mar 2025 09:03:33 -0700
Message-ID: <20250306160428.3041057-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=sjg@chromium.org; helo=mail-il1-x133.google.com
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



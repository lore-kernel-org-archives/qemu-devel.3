Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22639C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlVc-0007GU-Mw; Sun, 16 Feb 2025 15:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVb-0007Fz-6W
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:59 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVZ-0005hP-IC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:58 -0500
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-855799b9d1cso36675239f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738696; x=1740343496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=DZiwzsUVlqocwM7SnJfzKAPkRZmWPiVy3khKFDYyUnKIXua39jXwZMaipu0nFQv2xO
 IVEnfHAZj+o7YmVxxo62ekj+4nNAsXKvYZyjQ2K8q9ifw5IE55gpyxbNMZ43LnB3FHdi
 LSoUOhO2st5Jnmtt9vpBGVKGIjrwHbE1brJsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738696; x=1740343496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=km7bidC9TrJ/heElOVnuVWRWlQ+kqHbuJpXB/cO8Gmu2O+lmPrdqV08T2LHY6WXHBW
 k6JhAjaXtCQxieHfNbm6nrmsUct1XpCfpiKXGMls6jqzuzM0pcTspot5LO7qdg7DcA/k
 S4kOm852zr73PSkPzNxtyzYPoZGd0vmTFHfMUb6Rb0Zy4xmVi4FNs+v7JBGMCMXI9U1G
 7OuXD0OZmd54rRjDPj/i3+kji4nyiMoNsGqvPjD3Wp8V2e0nLFAm5hk0dREyYvlazAI4
 X1paNhSAxwLMBAB362gD5/Vb/QzDvNREMivcXbHN/tBREnnuUAY+T//y2HXySGzQzb00
 s2BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg/7zWltIfnlDjsyXteiunz9Bp82gyMfs26FmC3X+eeIhTlhBhhzzs1AksAwjefSp4FmZgPBdzrsoC@nongnu.org
X-Gm-Message-State: AOJu0YxxU1Ma9F2tBOw/Re072ZAtHb/hReK2b4NJwnEX2HLAV3UFRgGA
 HGtSPXpUi5S9F3y67uChvg1e/xrv8HgvNchUFrvK4nB0x+VVCjkmj8Qtn8rS/A==
X-Gm-Gg: ASbGncuaU8Z6w66dZjb2kMAVuVaR/Lgjf5ODL1pK7IygRsXBugZ7qf5inza/xDKZDdz
 0aokH/R3M2Sinjn8D+QuZabXzb2UllPLTat9dcbdy3C7NPqQKfil4Ld/7OI9LAFRVV0GY99+cwI
 nGQj69fbSsCQc8nCruLoqotoVZRWsXCRp9P1wi+nU8zRsoW873c+3ammERP1/FGf0p6ZWWEDBPb
 0gw/K6QwqL+O60+P614YLirqzwmK/hAaiAEXKLTmXzb3EpmvuaQ/fVQgh59bOXaAir+27BTyMPY
 q/P2Qd3QDWG1/OcmtHcos2zGn6gj0EYXYkQwPBrOUNT1EofuEwui
X-Google-Smtp-Source: AGHT+IFISbdq5Wij5MmQleMsFwBroEinOUYjslIJWvkUtfyVXW49il4lSVIOnWISmblklYFkdKf4fw==
X-Received: by 2002:a05:6e02:1fed:b0:3cf:fa94:c7d with SMTP id
 e9e14a558f8ab-3d2807fe341mr49492515ab.9.1739738696188; 
 Sun, 16 Feb 2025 12:44:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 04/28] x86: qemu: Avoid accessing BSS too early
Date: Sun, 16 Feb 2025 13:43:49 -0700
Message-ID: <20250216204421.3560012-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd34.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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



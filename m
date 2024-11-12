Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274E7D42B82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArQn-0006Tl-E1; Tue, 12 Nov 2024 08:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQl-0006QL-Er
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:43 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQj-000428-Uu
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:43 -0500
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so238455239f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419979; x=1732024779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDwtn31JD9K6ZyMSG8kCn2YHfnKQHNMeVz6FRkH60SM=;
 b=jH1028tK31hb1oFR+u6dhciFq7HVl0Rai5rn9yHHLS9rTgAf75YVT8xbo1Jd91rKCK
 egjUQht1JIv/VPz2JPEXPUshU6Ks99SHZbjXc/9wY6YDVZJdYB97cOwWR4g//uFJptFb
 htSJqXWWYyGDWnNDxc+pS+cPs8FQWhpmaKI8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419979; x=1732024779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDwtn31JD9K6ZyMSG8kCn2YHfnKQHNMeVz6FRkH60SM=;
 b=EeDKc3+owezYJdS70VsBEuApUldbUzcfdtbm47ElE7b/VYqzofIRUbmIJkDqrg7mLN
 g2AocEsRFSobMwSgK42bRoMZQ3UnSD9pjui9Hhhy/u5BS0akOfYohziI5lfGqps567+b
 NX0UPL2VLVX4Fe2SfP5K35xeMYVSXbWiGe4CVS1s0FJ39pHEmIvKawfJd01l7lsq6VoD
 JqpATBOFCxklhPEMah4I50uW9K422WsrcUMMS/uUv79dJSIvRtcujNBq5ATDaJI7exEG
 BecaEy/kG7S1suc/rRgm8KgyFBo/yhOYcQ9Th7c40giUea3sB7ifPgTxrgEqvq6UpZl0
 RL3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZqvzHNtLC6aGgTV0a3JY6+cZJDRcAdwc09kczlKMLgTxK5xAS333TdBeY+3Z9mcGNqTRFSTrvZb8U@nongnu.org
X-Gm-Message-State: AOJu0YzCN2VnghKLs709dic+85AbOCe2hIlvh86RT5A2odKzaAVhuijD
 8onC1ev1+S+ObQUQFCcocZIH4VI7JhCjWY3uWIqPm96pMpgqJA86IdYJpP2caw==
X-Google-Smtp-Source: AGHT+IHCm7eCSaDZCtHC1EYpq1641uaGdlJn8zdXwhVBLvYQOceurJxAYpd3DhKkaqYjKCawWE7csA==
X-Received: by 2002:a05:6602:15c5:b0:82d:16fa:52dd with SMTP id
 ca18e2360f4ac-83e431d3082mr321524639f.7.1731419978709; 
 Tue, 12 Nov 2024 05:59:38 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH 05/18] x86: qemu: Avoid accessing BSS too early
Date: Tue, 12 Nov 2024 06:58:58 -0700
Message-Id: <20241112135911.630586-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd33.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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
2.34.1



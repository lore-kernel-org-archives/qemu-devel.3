Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FADC021B8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmhXb-0005tK-Fe; Mon, 24 Feb 2025 18:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhXZ-0005st-Jh
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:09 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhXX-0007XL-RS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:09 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d2f5a93a32so3989395ab.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 15:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438423; x=1741043223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=T5z1q7rYRDf9Ri3yyVrKGM3ENsCVIE3yBy++VrmqOHXpG+1LzSYnPbc5RDrlXZnn2h
 vKx1DrFYjp6kYOcBE31gIq2DoUvmg0X3fZLe6kxgU5ZmTCGQ6VR6GAexNlKsQm8lZ7Vh
 nAXAmaNC/1CVDck/DaGdW+RJDuXvCZKKeexWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438423; x=1741043223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=v5tAg0ut1LbtuUmfQJXghY5VuSHsp9vjJLun1LvPUtX95ZoafJHHOrRVpgdCS3BvUr
 gHDdatXUWgY4cMhN3xK0qoDxqJ2Hg5leka7323YJVyMMD6rP07VMKsEYE6C3LtQVZuaY
 7e4bskRJ+vyH8B9CksTx/9lwzGelzVI7yhZZqTQ/TlGp1p/ZOg1A3gZrA7pKW0K1b1uk
 tNaJvrNV6QL8PeLLhxXOOzneirxVqny43mDKmqDfJi80iOHIpubG7UwV4b9NWCgOQPWF
 CIMO3my4YUPJ/MUrBgWg3l9xuP1T1Ni7Nt5UD5djcH62pXEZKC2x+iwjdXKBBEGf/Kua
 UjMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYIo2urRsYL1J2fv9dJTl0Q1WYZeODiLl7nZ6Zp9iRRgHZNTiMHUacHqJQRC8hoBBWoA1GLm1+Sbo5@nongnu.org
X-Gm-Message-State: AOJu0YwGdIKFgVV0iK1OR81Oi5adkCOr8YByy8BYAqJ//tPmebTvdBe+
 KdfSFgw7Dd7QiWCiMrpjUy7elX1qeyOqPsMP3mGFv0RcV+toLHZmziPT3mzOOg==
X-Gm-Gg: ASbGncs/l4fv0qoqmauAXzEi7Xyo3YEgtrC1CdhBPGskmlAv9xjw41gO6OuItZbRvTy
 cjqGRwrIz3Wx6c4Bb4hdgLdcKTuiwUHCJlQGQ/28Gk1zJNZItv1H2LYLKbOtVFpJrdbXimblSFr
 LM4E8Yx8uiwLR2QAc/oDC+5JwZ479VbHORi7/74mB6rXqcYW11DRiD0UaHqAy4XVn8ZTX1/dInZ
 6QMcOMCtTx0maUNEFs3CyHwLSH5RQD5IT7X5IqF9lgsTjdgMT7iUtFGIy6ENg6JOOd8tjm0Qh2m
 OJlGnzJ/lJWDiHPWvSyfWA++cg/PkV1GBFWNSRMwiF7BV58v1b7a5JgzuiPiilY=
X-Google-Smtp-Source: AGHT+IFNct6lnzD/RZAZBeipW8gHFWGG2XuMfCVmS66pkePHPioDGJmUrm5ZiV/XCBnOKBRB9w0pMA==
X-Received: by 2002:a05:6e02:16cb:b0:3d0:137a:8ca2 with SMTP id
 e9e14a558f8ab-3d2caf0dbeamr173540975ab.22.1740438423559; 
 Mon, 24 Feb 2025 15:07:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 04/44] x86: qemu: Avoid accessing BSS too early
Date: Mon, 24 Feb 2025 16:05:53 -0700
Message-ID: <20250224230640.2665206-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=sjg@chromium.org; helo=mail-il1-x133.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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



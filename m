Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B123C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6j5-0000Qk-NF; Mon, 03 Feb 2025 19:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iv-0000Nt-SG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6iu-00075R-17
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so4204936f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628605; x=1739233405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpPlnEnDWFC/Ik2Y/thdSUt8XZtZU/cwYbfSseA7YMQ=;
 b=eJoy79M816f9ircBf3Q3bwRnl1uLFR9VVOFE4GblqE13ZQRmOzZ60qLif/FdUcuLD6
 /pnoYVgqsTRJVGgKAVovZavh84CyrRDxtnWxV+ze6nHyQE8l9g4vWtZqCP0VUm7f/KQC
 t6HfUdH+pS89U4xxq2BsJLHJSomXZLE8kaHBqSN0IVI1gwtib70zhATEwelDRDydAZLp
 grpeaGXA2EeEvzqFirHVzmcRKnseC3fOoGz+LJHf4PnmGL+XHIBU5UgSW+swmGP+5V7g
 d+1oKB+YVXrwUUx6LlBh9sbHki6ZnlUk6ybarqzhmJN62LTsPlHTdccUFx6NufB83+OV
 Ac9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628605; x=1739233405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpPlnEnDWFC/Ik2Y/thdSUt8XZtZU/cwYbfSseA7YMQ=;
 b=Ua8/WbP5VNYiRIg+PD4eGv+hdDwnuR/kcnbi2hnRZ+cKfXjFRmcdf22Z5RKO+Ua5OS
 LRwIAMJSWOwfw9YV9JeByBjIhWlch13/Yu4+i2NeXD2j47rGo8v1nD4i8WtiuIAIl3hF
 kccTzUQ4IEfq6etEgELN/S5TpqjLD1Iq5rp3ivgp8CUpyogudaaYHRN5A5PKXSf8XZpZ
 T6b7QrPxQW+WkfMYL4+z+NFhaLunl1kSEm2kkcUCT7zOwRWVrFixtN4rXWUHWQG5iNiU
 WKQgH5P1MMtwuXjUTvGQYpZK70Sg08p/tAkCR7usYAyFQ9xd6sT+RyQAOpPMrkz5LuzF
 zqzw==
X-Gm-Message-State: AOJu0Yz3ipm3J2MLILp0rljcYx/FG4NLr4u0wOe92c66ViTW7ZkLfsEt
 AZeK0n8c/H+TQLx/x93UuJgwAewd+mCduTMIxR+GStxacSM42iVr9eGXHUlPrlTjq5Zzv664adO
 1G9U=
X-Gm-Gg: ASbGncvdAOP0XKLprSVrkc5SIvBX8IbMEdv9bgeCMofuiPZEr6Py/gPMBnlFFETyLeR
 TBA0bHI6WaLScIODHFqJnk6ajoRSfn6sHox4fufPkcBc6jnu3aZfMyFBrJIr8rWHzRJwmUgHaDV
 TJjuaTbTTfejOdVAuYzFb3ucsY02fYoRrq5r8NIpbgdQILFYwt25wQVs3d719AnI0RfKuW3533V
 bvGUG01RboT+2mPE3kGHK2qpuBx5o7KHczjDzawWT4rdVN6F8zdE/1MwMUxPYj87NjFQWF+IPFM
 Pgiv3HH0HRpNhJ4Z6wJ5gTEMwlc/oU946aPogKmC2SzEb5Uo6K8/HBRprMcXsgjF5g==
X-Google-Smtp-Source: AGHT+IFXxjdiX1jXLTjFtTEgAoBvG3NXn1OkUcQYFs5o3H1ayhaOYKZLsiFB8Nd03rQGcAki3/kgcw==
X-Received: by 2002:a5d:6d86:0:b0:385:df43:2179 with SMTP id
 ffacd0b85a97d-38c51967fd9mr16644540f8f.17.1738628605611; 
 Mon, 03 Feb 2025 16:23:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f5a5sm175171855e9.40.2025.02.03.16.23.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 07/12] hw/arm/raspi: Check ramsize is within chipset
 aperture
Date: Tue,  4 Feb 2025 01:22:35 +0100
Message-ID: <20250204002240.97830-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Add the 'max_ramsize' field to the soc_property[] array,
corresponding to the maximum DRAM size a SoC can map.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 68332fba027..d44277001ee 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -76,11 +76,12 @@ typedef enum RaspiProcessorId {
 static const struct {
     const char *type;
     int cores_count;
+    uint64_t max_ramsize;
 } soc_property[] = {
-    [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
-    [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
-    [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
-    [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
+    [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1,              512 * MiB},
+    [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS,  1 * GiB},
+    [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS,  1 * GiB},
+    [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS,  8 * GiB},
 };
 
 static const struct {
@@ -133,6 +134,11 @@ static int cores_count(uint32_t board_rev)
     return soc_property[board_processor_id(board_rev)].cores_count;
 }
 
+static uint64_t ramsize_max(uint32_t board_rev)
+{
+    return soc_property[board_processor_id(board_rev)].max_ramsize;
+}
+
 static const char *board_type(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -294,6 +300,7 @@ void raspi_base_machine_init(MachineState *machine,
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
+    uint64_t max_ramsize;
 
     if (machine->ram_size != ram_size) {
         char *size_str = size_to_str(ram_size);
@@ -301,6 +308,12 @@ void raspi_base_machine_init(MachineState *machine,
         g_free(size_str);
         exit(1);
     }
+    max_ramsize = ramsize_max(board_rev);
+    if (ram_size > max_ramsize) {
+        g_autofree char *max_ramsize_str = size_to_str(max_ramsize);
+        error_report("At most %s of RAM can be used", max_ramsize_str);
+         exit(1);
+    }
 
     /* FIXME: Remove when we have custom CPU address space support */
     memory_region_add_subregion_overlap(get_system_memory(), 0,
-- 
2.47.1



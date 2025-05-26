Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01530C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXRW-0007m2-5I; Mon, 26 May 2025 09:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRS-0007jJ-VI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRL-0005Vw-J5
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so18538775e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748264425; x=1748869225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYVff6aW8pddrXfep/dx+jW+ATHbjPdcPUPMa5bC6bQ=;
 b=RYAlQG7HVJvlBoq1HKiI71lWKH4vqPUv+FV99PdC6G3apMtJZJsOVuwfxNlnv9Z61v
 NUVdj1jyaFyu+iEQWxQ1zKqgUfV9UrBfTgN77bVW68OI2PzlODIIV+wh9wD6jtPs61Uz
 kwhpx1lnnwKtAQ8cYx43QKdMtpCeO+Tps2wb2emBANSbJmp0lLF4V+4rz51zwy9WF46M
 ai0zPzy89Br1GUUqbHWjLJL3Zf4QE04XYy8Ao5aei1wNX755xgPztvbIxFVRLr2qS2Am
 LBy5kG+ea8uca1qeEOMoFI3eXZZXoPf+GA67VgeKHH8xJENVMoU4UvZ3p3QokEwRRFTi
 nMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748264425; x=1748869225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYVff6aW8pddrXfep/dx+jW+ATHbjPdcPUPMa5bC6bQ=;
 b=Jx3lpaIIgJPrWgx85ArAe6A5xUQ5mp9Fj7Me+3vyvxsoJyCeTdbCSVPJOhZTi5w/8j
 +TqePd/fJiJvsSQFGY/LmTsJizvtqJVpkudZgR/MbSJHvFmasQ6kDXIYO7ewiPygcgtu
 fWSMa8ziX1rhx+Qd6TJ99OeDgSuPnLavKVqKGU3ZnvoV1zBsJat2/nPQKDV/vk4aWPYn
 nB+iSJG+FaVPYY1ma7D0nDCvxrqfAsubgHMgils/6ARYeki3geSH2F+S+iNfP1V69Bun
 a/PJFNdStxdY2CI/QEM8c4W3mOWG+yWqhVPo9pGESetbJ41lrt/xP4/s8f06B/+lkgvB
 05Qw==
X-Gm-Message-State: AOJu0YxCAej0dj0Mvrkb5ANrghacuJWQ/fUTIdCoR8AOyf/D2YUM2O5x
 LYN2NBfk8ERv/qvd+4PBlTcwXDe5R50SqLk+KdO78N7MHKNZ0D8TY7HcEYxC4rm9Esxp9bgFphA
 YiDiAD9Z5yg==
X-Gm-Gg: ASbGncuYtiRTNPoiYZ+uumu2YH85D0LABZ2Ph6bpwjbBCJUJT1dpEnNMdij2tstBAQ8
 ecAPJzpazetlqx1wk+7rVvPxrfNVtt0HuIbt/rlHOVRQvIRVReAYPz1k3s7ddhwDDfIY9O+Zve8
 Uacb1MlDzGaA7oF25/XqKS3+h2+kEjbC5eiIvdlEno0VuZ/q0noAwQo9sapBhh9MfaNFa2bo4pY
 CbYy2Z2N98ytRVEcDBeOoT3a1T4LcyDqNa2AcTtoSytZTdTS6+wFCcohcNLwyaII1bstbXFt69/
 6QO7w+XJzYmW50Zac0EYiYQSDuXQdoine2sh8UTJ53ZlwXhn+B6rQGsQ8x2gOO2PMuEwAapYCFs
 pV+N56P1Z7JRI6tgU/eK3Iw==
X-Google-Smtp-Source: AGHT+IHn+qT4GEKWAVqgI3E+a/6cqiGTUDn57HelkBWdJg1kSbryuL3rfniluxp8V6QYTGW2TtJQ+A==
X-Received: by 2002:a05:6000:2282:b0:3a3:4b8a:9a36 with SMTP id
 ffacd0b85a97d-3a4cb43315emr6986953f8f.11.1748264424644; 
 Mon, 26 May 2025 06:00:24 -0700 (PDT)
Received: from localhost.localdomain (44.87.95.79.rev.sfr.net. [79.95.87.44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d1d2f788sm5613392f8f.65.2025.05.26.06.00.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 06:00:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 2/3] hw/ppc/mac_newworld: Only create default devices when
 requested
Date: Mon, 26 May 2025 15:00:05 +0200
Message-ID: <20250526130006.49817-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526130006.49817-1-philmd@linaro.org>
References: <20250526130006.49817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Only create default devices when requested, avoid have the
machine implementation to modify the generic 'usb' boolean
set from command line.

Fixes: 59a0419856c ("hw/ppc/mac_newworld: simplify usb controller creation logic")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mac_newworld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 0b6e096116a..7598d42cbc2 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -346,7 +346,6 @@ static void ppc_core99_init(MachineState *machine)
                                     sysbus_mmio_get_region(s, 3));
     }
 
-    machine->usb |= defaults_enabled() && !machine->usb_disabled;
     has_pmu = (core99_machine->via_config != CORE99_VIA_CONFIG_CUDA);
     has_adb = (core99_machine->via_config == CORE99_VIA_CONFIG_CUDA ||
                core99_machine->via_config == CORE99_VIA_CONFIG_PMU_ADB);
@@ -427,7 +426,7 @@ static void ppc_core99_init(MachineState *machine)
 
         /* U3 needs to use USB for input because Linux doesn't support via-cuda
         on PPC64 */
-        if (!has_adb || machine_arch == ARCH_MAC99_U3) {
+        if ((!has_adb || machine_arch == ARCH_MAC99_U3) && defaults_enabled()) {
             USBBus *usb_bus;
 
             usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE38DCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGL9R-0004MZ-Qx; Tue, 04 Nov 2025 12:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL97-0004Jj-N8
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:44 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGL95-0005jB-VZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:48:41 -0500
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-b6d4e44c54aso770497566b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762278518; x=1762883318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xFKz61NgOTDe44iZ8PiV1I49jlxgeapCPlVrsJSbdmY=;
 b=jkI9PR9ks1YXPFGS7RcXSbAWOv6o2JkCdnJSDAA9SigX4KA/q8V2veq2gUZ3qlR+c1
 DGU+guL0daSU346x8mw7kMOYDIe+WaX8Df6S27vzD+n3lJd4KpqcfHoqZGAYmT66m9NT
 WHyVgV5HRPunNvX2Wkrfo8rNBiEQMDUJ8xCc3tDL4jaaGnNhz9YMIAFKornlas+8QRFm
 78clNrW0zxoR07lDrcehWjtXosty3XCoZXzGF/3izOCD0v6h4monH5otjRzZAezbsY9+
 4xggJslLsXZQiq7edWBPGCUIVryRVajHkMPQ1xq9/ullyAV5KZIWxnsKKh6ei4Q3uYMq
 /zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278518; x=1762883318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFKz61NgOTDe44iZ8PiV1I49jlxgeapCPlVrsJSbdmY=;
 b=L5azOaPzlwF/NEpeiUoUhNwHoRcN4bGtSQ6vI7sqE3HoE3b5cPPEJ9zhYjebT24bss
 4ptpcW8UDsvTvuxNXkx8twrfqJ8/aeeBnpZ1OqwrXdvqf3s39Mv9LurjSkkYDO47Lnfu
 Q6MIVPX5iW+8ziUoJ37XWqjMHA3jwGHSe8yUx2Q0sV/5O60ABf0+ljC2mlJVA9RP0jaI
 V8wQ84f5Ij4RcBK7PGWF1XnmmZJcjdCf5njBMpKySHTF6Qh3S0y+AHVURcWs3CqK/ueG
 qNvxBFompSwZKvvOF81kaepahXm2W+vb/rFiBSgu5ukdkvcqxpAIKS941bxI3LtaYqFW
 J8SQ==
X-Gm-Message-State: AOJu0YxiLiAFx9nnQuKxQdAi1OJocUtuszAwFjsyEwzRbCf9pSNAWn6X
 jvY+PE8P7e1nskgo2+KpJ2aa+JALuybw3DDKqW0rMEe0IbJ/tSQ2DctXDiQNhS3IPPCDdysyVif
 P4D7aUx2mPpW5
X-Gm-Gg: ASbGnct/t1+M2I7kPPrmJeiHGmqGcMEpTZXmvgyUONxzw2ZuP9uBOldjstED0pE8JkT
 A/K3kYLjR3VzwkjbK0B6yDKQNtTQQAzAtzlKzCMaHuSVTxuroqJ1whRVz4PA4K8Y0sBrpfGoVPs
 8bNcg5tUZgIAh+OyS/j7WJhrjLoci2cJH9fKqrLe2TdMEWS54ahQPS6xHzErFz3/9kTB55CGauA
 EmvxE1VDqL6FiGNHkXYWVe38rwv1eKoexVtP5lspNdiNjLzqoftKXpZZIMQlKURl5VpHAJ58hGA
 3vz7/wkHqDZOmHeZqQWECAFlu5T0IPPuYTYwkip1LPs9YBLNgSBt2TStEk9g0cTN6YoH8enTD8I
 SWWNSoyfP5ysvgVauANS//w6CPG2Unp6Mx4Gv+d6gX6kFldU77SSFFX2lB2uhMu7gCZfqQnDAGy
 qpqYu0sf02GZ8ZVts6KAyvy2CMhWslIfCz
X-Google-Smtp-Source: AGHT+IFQkNyitbDt1Rfz6PJ4xvZRonZCWtQcPsC4M5IRB0oZks/3p3dYVB+PXDoVNpxbUQGc7zZeUQ==
X-Received: by 2002:a17:907:3e11:b0:b6d:2c75:3c57 with SMTP id
 a640c23a62f3a-b70704b5225mr1879203466b.39.1762278517720; 
 Tue, 04 Nov 2025 09:48:37 -0800 (PST)
Received: from localhost.localdomain ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723ff45831sm268855366b.67.2025.11.04.09.48.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Nov 2025 09:48:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] hw/sd/sdcard: Allow user creation of eMMCs
Date: Tue,  4 Nov 2025 18:48:17 +0100
Message-ID: <20251104174823.92412-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x644.google.com
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

From: Jan Luebbe <jlu@pengutronix.de>

For testing eMMC-specific functionality (such as handling boot
partitions), it would be very useful to attach them to generic VMs such
as x86_64 via the sdhci-pci device:
 ...
 -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
 -device sdhci-pci \
 -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
 ...

While most eMMCs are soldered to boards, they can also be connected to
SD controllers with just a passive adapter, such as:
 https://docs.radxa.com/en/accessories/emmc-to-usd
 https://github.com/voltlog/emmc-wfbga153-microsd

The only change necessary to make the options above work is to avoid
disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
kernel already supports this just fine.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241015135649.4189256-1-jlu@pengutronix.de>

Enable user-instantiation so that eMMCs can be created for PCI-attached
SD/MMC host controllers (such as sdhci-pci) on virt machines, for QA
purposes for the eMMC model itself and for complex firmware/OS
integrations using the upcoming RPMB partition support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e515cc80de261ff03b3141724298f20313259a85.1762261430.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 76e915e1900..e43e1a10ebb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2930,8 +2930,6 @@ static void emmc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "eMMC";
     dc->realize = emmc_realize;
     device_class_set_props(dc, emmc_properties);
-    /* Reason: Soldered on board */
-    dc->user_creatable = false;
 
     sc->proto = &sd_proto_emmc;
 
-- 
2.51.0



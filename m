Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F8FC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5lt-0004Kg-AW; Fri, 28 Jun 2024 03:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lq-0004G3-Qz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5lp-0005ZH-0N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:11:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3651ee582cfso132782f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558703; x=1720163503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wfOV4Z9kH5/WWEkygPAPJDC+UN3xtUZojvL70U9kebo=;
 b=qH6m3otIN1V6wX6W7FwmY3sfY1CQQGM9vlwq5Cb32jAuHifqm5jIzkiZEi1Izys/Dd
 Bj7eMv3KYmGFerZ97l1tWcQRMcK18YtMBkOjfs7GUzj8V8ladw6cnwRv5gNTrD8E0kZn
 R97iTQOobh7FupgchJ0aT0irJwqr4Z02nriNcVjrS1Eb6mvHi7WYoYbgbR5CniTzJ/U8
 s71pzHG6p2d/lxYMn6Z/gO+CGCw9UFD40e7thjZByTIqNPQcn1YBi4z8MtVwFAUiGqQi
 Z6luuMAIMrajAnnCJ/Vv6l5X+Uckv3AabzZfrYzdFJZU7sxmza+Z36Ctz/OesJXrItfe
 zE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558703; x=1720163503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfOV4Z9kH5/WWEkygPAPJDC+UN3xtUZojvL70U9kebo=;
 b=G84hP2lmQK2wirL75tH3tq1CNbwim1CWPGLxiv5ORA5/JGHJ3fne4pEzGDeH7Cg3t9
 eSjtiSOp1U+TljIKw94XD932mvyM8owspPNDpz0cgIWwxCcR5jwGi8l22vbi2VRkGDyN
 KXIJiVtmMX5IN3D3S3BIr9EyKQn+UnEkfpWutQ4cp55Y6unqdoEhuCdK9spiiEtlzWnC
 aMpvQ5uTbXDXsb4yVj9tjvQmYBxsF+J1PAWASay8IoQGX4mYsoY/RX1a5LvbkpQ0XHLL
 gpARnHJy4KAJfx0dk5NiYsn8wnymUKRq1cwU7fcVUTr6fZUBatym5Rl2rqZ7sKeHeev0
 Dd4Q==
X-Gm-Message-State: AOJu0YxLyCr9xN/vHG4/T2DtnYjNNliMEMNrTt7X+YUY4HCCSLC//4d4
 T1IW6Ul08Vge4qalhNpLxcj1d3qRQaEXa10dR8qfZQDT432ZjY+nL9C0RDve3utd/76kQOg0wmc
 DreM=
X-Google-Smtp-Source: AGHT+IGxCRUaIt89HGbZR0qm5r0gsfFsm0u6blNX8GnSmzVKX/TUgxLs70CgV0/ZJFay3VRLYSAhiw==
X-Received: by 2002:adf:e811:0:b0:35f:fa0:cf82 with SMTP id
 ffacd0b85a97d-366e9632621mr9952233f8f.68.1719558703350; 
 Fri, 28 Jun 2024 00:11:43 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd562sm1350541f8f.15.2024.06.28.00.11.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:11:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH v42 98/98] hw/sd/sdcard: Add boot config support
Date: Fri, 28 Jun 2024 09:02:14 +0200
Message-ID: <20240628070216.92609-99-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Joel Stanley <joel@jms.id.au>

Introduced "boot-config" property to set CSD 179, the boot config
register.

With this correctly set we can use the enable bit to detect if
partition support is enabled.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bbf054ea1e..b598974bbf 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -129,6 +129,7 @@ struct SDState {
     uint8_t spec_version;
     BlockBackend *blk;
     bool aspeed_emmc_kludge;
+    uint8_t boot_config;
 
     const SDProto *proto;
 
@@ -505,6 +506,8 @@ static void mmc_set_ext_csd(SDState *sd, uint64_t size)
     sd->ext_csd[159] = 0x00; /* Max enhanced area size */
     sd->ext_csd[158] = 0x00; /* ... */
     sd->ext_csd[157] = 0xEC; /* ... */
+
+    sd->ext_csd[EXT_CSD_PART_CONFIG] = sd->boot_config;
 }
 
 static void sd_emmc_set_csd(SDState *sd, uint64_t size)
@@ -1004,8 +1007,14 @@ static uint32_t sd_emmc_bootpart_offset(SDState *sd)
 {
     unsigned int access = sd->ext_csd[EXT_CSD_PART_CONFIG] &
         EXT_CSD_PART_CONFIG_ACC_MASK;
+    unsigned int enable = sd->ext_csd[EXT_CSD_PART_CONFIG] &
+         EXT_CSD_PART_CONFIG_EN_MASK;
     unsigned int boot_capacity = sd_boot_capacity_bytes(sd);
 
+    if (!enable) {
+        return 0;
+    }
+
     switch (access) {
     case EXT_CSD_PART_CONFIG_ACC_DEFAULT:
         return boot_capacity * 2;
@@ -2808,6 +2817,7 @@ static Property sd_properties[] = {
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
+    DEFINE_PROP_UINT8("boot-config", SDState, boot_config, 0x0),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0



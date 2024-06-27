Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4C5C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsiB-0001rd-PT; Thu, 27 Jun 2024 13:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMshm-0001au-Uc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:14:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMshl-0002oj-7a
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:14:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36701e6c6e8so1814457f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508479; x=1720113279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfOV4Z9kH5/WWEkygPAPJDC+UN3xtUZojvL70U9kebo=;
 b=wxYUtCb2LKDm0pv3eRppVMyfv3yNHgZJoxvKALbw3Kha7ZwjX8qulUYzwHfd/GETc1
 fJJiawfM6vj0s3lO1L+6IELvh8wjbdl7bVFddmujg5WIH8gZQFsqWI4/q8wHJnbasthI
 MwYiohoLgDFVLOM6c3pYJ2O3fjVsH28BroGa1ERcGNvfOp5qHch5YCWgKexgl4Qyd66G
 xX+om+SeH+tLhRxg9dFcP4EO8wTy4zhoJyV+oMENWloHmKD56IM439mPPPKJiFqM8jbz
 MdmKZ5rwyno2Kx+/++WTVhcDvzgAp/XJlCU4gUU+JR5GYiC3JCOMRHkz1RZXP7gLS7oz
 8NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508479; x=1720113279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfOV4Z9kH5/WWEkygPAPJDC+UN3xtUZojvL70U9kebo=;
 b=LwcjtpmsCT3JGBtAU/uKOpAis4a6PzEtddAwwSbMx+t0dp5Pb/VwtgP/HfxilG/xX5
 WG296fFTYER1Arz4I8+6SfLdr1KwqLg3eheAKuIb7MBIcRzr+CcBZFfN9mnvmjkM2iFl
 TmlR+DEiWLYXp3SwaZkWH7A7IPJo9zckBgOWGDHJWi3deR2KEsgEGN/GgsEbGE346Cjv
 Wg/wRzbFqq6YlbXEzdRwaqWMDxbFhufUQW7AnnUELgZn/zEknRBtAdZgPgp5UjuqUFhl
 X1AeGhewTowa4jR7Sjwd89KSxZwQseummC8EdwnLwTk2wDFGHgHGrj/Cdlb9CaJZC1ai
 b+EQ==
X-Gm-Message-State: AOJu0YysxOeZVZI5wPt6dz6/bbPr1t3hXBjatNt0YEoaerhARBGc1Wdj
 X9wFBhi7azbemA8cJs+ok9KWbKCZJuXM0yq1env0GvBFaWqKCV+vNM4Zxi529+B5DcmoVLJSyoj
 1G4g=
X-Google-Smtp-Source: AGHT+IGmgLLjOxCbmIOh7IHTnXcb5jlPJ0AMY8vhPwh32Uu0Va8H4ERz/2juGFhU+aAkZYKTzo26BQ==
X-Received: by 2002:adf:e34e:0:b0:35d:ca63:4e74 with SMTP id
 ffacd0b85a97d-366e7a64642mr10429990f8f.70.1719508479316; 
 Thu, 27 Jun 2024 10:14:39 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fd08sm2514150f8f.27.2024.06.27.10.14.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:14:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 19/19] hw/sd/sdcard: Add boot config support
Date: Thu, 27 Jun 2024 19:10:59 +0200
Message-ID: <20240627171059.84349-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A76CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuL-0005Jg-5I; Tue, 01 Oct 2024 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuJ-0005Ih-2Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuH-00060i-CU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso55225095e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800764; x=1728405564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vx5tPl8mZ4Syxp4bwv318p0goxHnVxqpE0gfsca6UPE=;
 b=mwuhm+ODcwXmP54+2xl3t6vV6AQOfk0oaffhDRTb7aXgh75L5qsvBQ2RqH+Gv4r1tQ
 YqqQoffTPJ+w6Jm6cJNvLAOhD7kiEq6pGViXXDuaymfZDYxejsOFPZBKLdglegbP2iZh
 1UQyADFEH452rseg6/0hlO32wp9WZRW11qZKtylGL3mcR3M4U134S3GyGM3StUtHh8jc
 CborEICenQ9PWMuodbnxeSalUs9BjBzuhI81lDEjy3MYq/5dQabyyTQsSwG9MTZa7Wcl
 LmoKGxfDAwx6ZmxfuJ+vou4ClEW3uRajTM6bRWwZaVtSN0/LAyoGlb5Ur+0pMB7mF1vR
 gfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800764; x=1728405564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vx5tPl8mZ4Syxp4bwv318p0goxHnVxqpE0gfsca6UPE=;
 b=ONKkL8LbQBYDMiaApv0g+YTebODDZFcLVFdObVzfG2SOfeYZ1kQUxuys39lGj+cEuv
 cBNoftHomdMGJzQzvuMiKa9iVYnFhiewaS6U4yWl6hf1UGQJTWGOGW8yUGXy1AQFbxIq
 NcyZVGRCdpUyAnusNfhtVnNrRprjpORAIdxQjcbQmT0rNLrmlMp8ZwddwhtGhw5Vb7VS
 e6z/5I6DN93+KySX3Bm3bGE9hV4CM6cJS/ROdxIIEE63gf2U7drGzwDbrGBonlZSBhP2
 xrEeCt2f/doiZHR0EuiW8aZEToK5OY7S4JmszipC8NbtFfBQjn4G20KAreE4VwAA2AQD
 9wNw==
X-Gm-Message-State: AOJu0YwUzkKGA/dIe9jqtKzzTRDad40OmQI2D1wAAXiGaJGdGaGZxjQW
 IoSDMNXKx8MBAHJ2qjvm+W2wbPNGApd3TYnxjsYeYXSHLXrJPLfy9E1jDamG81W3A0CWgt4cP13
 1
X-Google-Smtp-Source: AGHT+IGlIeJTH/CsGaYcx3vEnpDaI1y4rPd+PYOFMLgb04ELp67rwqB44SvvwFzJoVYMvzKa34XW3A==
X-Received: by 2002:adf:a3c1:0:b0:37c:c9ab:e641 with SMTP id
 ffacd0b85a97d-37cfb823aeemr189070f8f.0.1727800763657; 
 Tue, 01 Oct 2024 09:39:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/54] hw/sd/sdcard: Fix handling of disabled boot partitions
Date: Tue,  1 Oct 2024 17:38:31 +0100
Message-Id: <20241001163918.1275441-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The enable bits in the EXT_CSD_PART_CONFIG ext_csd register do *not*
specify whether the boot partitions exist, but whether they are enabled
for booting. Existence of the boot partitions is specified by a
EXT_CSD_BOOT_MULT != 0.

Currently, in the case of boot-partition-size=1M and boot-config=0,
Linux detects boot partitions of 1M. But as sd_bootpart_offset always
returns 0, all reads/writes are mapped to the same offset in the backing
file.

Fix this bug by calculating the offset independent of which partition is
enabled for booting.

This bug is unlikely to affect many users with QEMU's current set of
boards, because only aspeed sets boot-partition-size, and it also
sets boot-config to 8. So to run into this a user would have to
manually mark the boot partition non-booting from within the guest.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Message-id: 20240906164834.130257-1-jlu@pengutronix.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added note to commit message about effects of bug]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2dd7a8217cb..a5d2d929a8a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -774,19 +774,12 @@ static uint32_t sd_blk_len(SDState *sd)
  */
 static uint32_t sd_bootpart_offset(SDState *sd)
 {
-    bool partitions_enabled;
     unsigned partition_access;
 
     if (!sd->boot_part_size || !sd_is_emmc(sd)) {
         return 0;
     }
 
-    partitions_enabled = sd->ext_csd[EXT_CSD_PART_CONFIG]
-                                   & EXT_CSD_PART_CONFIG_EN_MASK;
-    if (!partitions_enabled) {
-        return 0;
-    }
-
     partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                                  & EXT_CSD_PART_CONFIG_ACC_MASK;
     switch (partition_access) {
-- 
2.34.1



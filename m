Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1826DC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCjG-0002WY-2O; Tue, 09 Jul 2024 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjE-0002U5-EU
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjC-0006AU-7c
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367a23462e6so3253099f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538760; x=1721143560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=juaQd8aRqSReupg1aRg4nLDaTehFUhbFD6v/zJ/DEqU=;
 b=f9uzpp+CbUEKk7u8G1iYgdZYgXI5lLXcaslujMatf4uhjSPjBWlCGK4weENglhRKYR
 8FXdVpf9tWUOpJMyIETcGGM69aba3dR843Vm93+xoiEJxiAmUtatbPPuXSPTQ40zCe4E
 4ZHJlAtJF2N07GLSGKExoHCfXHANuqt0SQPxnjAfm+JR2LUi29g8qdPRz+Zw5mvzk7Kk
 gydi6vZxzia4Gy1Wbz+Uv1yZVSShJdHEZAHtijy7XjmbLJZHe1v2Qs9yLVj6SthpDDWh
 BlEZzdXdpWExm8yPYJJVaS4OhBbae4RWRMXNm0umDLXBqyL2ro/tlsjDCpC8wk2Uuluj
 B7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538760; x=1721143560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juaQd8aRqSReupg1aRg4nLDaTehFUhbFD6v/zJ/DEqU=;
 b=XCoCrp5E/x7jYGRnQ9xc2Gj674KvmgR1aCidQjRGNcmQineQ348/KrfXevwQyImRk3
 QeDpYzffWUduAzc7dRuSnWO+7Sd2ddYOo9XoHSxwSCnEw6j4fSXalG/z1zy4uL0UK83s
 QIy8dGy5Dpb/Hd0Hwb9fJpCcdkyHAAFtT08Cw3q+oMGwhkCc5jwmiT8wO8xwUojZxnWO
 QdlmFMr8Xi18Nsd0U0mJm6f7Tf33cXg+fBvrQfwMRoEpVmWWJ4swyYXc2eNK9nhEayjs
 V8jnN8MY/M0Wq/rnrYe4lRe2lDhdW0CHYNgWcHIQudy30GuNDh4x/Zf7YXRY5XRnbpJ9
 exkA==
X-Gm-Message-State: AOJu0YyG6sOweJiO8UPAnS8f3ZKYRRYuwxL0QFrvFduGqhdGMHp/rGGX
 +g8QJ0+flCcNXcHcbGcXEy/sUOk3CBWa3cgRWmwZv2uUVec0FSuR+qhe7Pg0RzyJJF7isfQ7qqR
 H
X-Google-Smtp-Source: AGHT+IGYtjMb0C87K1Btavjx/KK6ztTxqN+JQyXzIwHJOdByC+Ueq4ObmTJqNUfhmzXV6tccMhy7hQ==
X-Received: by 2002:a5d:64c7:0:b0:362:fc59:1ff5 with SMTP id
 ffacd0b85a97d-367ceadd349mr2466651f8f.59.1720538760233; 
 Tue, 09 Jul 2024 08:26:00 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde890d3sm2874134f8f.59.2024.07.09.08.25.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:25:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 00/19] hw/sd/sdcard: Add eMMC support
Date: Tue,  9 Jul 2024 17:25:37 +0200
Message-ID: <20240709152556.52896-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since v42:
- Stick to spec v4.3 (re-simplified EXT_CSD register & migrate)
- Fill CID register
- Few changes to CSD register
- Implement 'boot-mode' reset timing
- Add 'boot-size' property

Change required for aspeed branch:
-- >8 --
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8c0e36badd..563816b710 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -344,3 +344,3 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
         if (emmc) {
-            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 : 0x0);
+            qdev_prop_set_uint64(card, "boot-size", 1 * MiB);
         }
(I'm still reluctant to merge patches 16-18)...
---

Cédric Le Goater (2):
  hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR handler (CMD3)
  hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)

Joel Stanley (3):
  hw/sd/sdcard: Support boot area in emmc image
  hw/sd/sdcard: Subtract bootarea size from blk
  hw/sd/sdcard: Add boot config support

Luc Michel (1):
  hw/sd/sdcard: Implement eMMC sleep state (CMD5)

Philippe Mathieu-Daudé (11):
  hw/sd/sdcard: Basis for eMMC support
  hw/sd/sdcard: Register generic command handlers
  hw/sd/sdcard: Register unimplemented command handlers
  hw/sd/sdcard: Implement emmc_set_cid()
  hw/sd/sdcard: Implement emmc_set_csd()
  hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
  hw/sd/sdcard: Add eMMC 'boot-size' property
  hw/sd/sdcard: Simplify EXT_CSD values for spec v4.3
  hw/sd/sdcard: Migrate ExtCSD 'modes' register
  hw/sd/sdcard: Implement eMMC 'boot-mode'
  hw/sd/sdcard: Enable TYPE_EMMC card model

Sai Pavan Boddu (1):
  hw/sd/sdcard: Add mmc SWITCH function support (CMD6)

Vincent Palatin (1):
  hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)

 include/hw/sd/sd.h |   4 +
 hw/sd/sd.c         | 424 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events |   3 +
 3 files changed, 425 insertions(+), 6 deletions(-)

-- 
2.41.0



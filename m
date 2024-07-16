Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36518C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn7f-0008B2-IU; Tue, 16 Jul 2024 14:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn7e-00085Q-3B
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:41:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn7V-0007KW-T9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:41:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso41530095e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155307; x=1721760107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sO58Q1dbbNWbXhV70n6r409eHgPzIHoWD1JYp3xYgPs=;
 b=FhEics8Ysh8Yjb2YONp1yTkiCiK2QtRkiiTB/mBq2Ke8nW/O0CWL1axxxXcKjoX15L
 FdOnVr8D411DX3LJBvebyRm6IrIvo4mncnlnq58OUY8TtwoO/bd/8G+srDs5NuFC/8V4
 XHMuiPXz3z+JiCjt6WJCfIB5gfCrbKHIRA7fak8Uml+ztkBj/Obo3S5jsWREYsSR9tQc
 rDptUpjFZBuBfQDZwkN/lOQdAzkQbm83EpXXzIbbmjTpTmp6hJ7x2rWgj/tpLil6ysLD
 WEl0UHsmRXUX9ZPIm8wbUcCG1nU3JzdOztwAesxw2UE46pmjyrhnA+7uhJd9EOMNGX1K
 tNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155307; x=1721760107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sO58Q1dbbNWbXhV70n6r409eHgPzIHoWD1JYp3xYgPs=;
 b=AiAoOrqKl4B5YUbDmvOPGkclB74jAIMLw0pZ0tHChwBSVDeD/8No0DJWfN5M9Ft8NP
 55Kdl4lp+uuicaDAqhk/74Ic2K6RpxTNfOokgdBtzAOmwKSWZIydKooeBSm2f4QLo9dd
 aPF1UMXUQSr1WtfiipZ1l55LFgr/uMYi+jlgG7Ldf0AcoMakEFOpLlfZnojjF3uTwC9k
 1QK6n6fMX9DMOClXgNG3bzCK5E3Munqqbf+FBBlY7WqYF6/d7IHvV2Om/LRYpirLuZZJ
 6tLtyqyMCkKNbmivKlKJoh1Q2cs0DojLYGrGka8JyEV7U6XQvhtHN7qxOe6nKBePALDn
 npaw==
X-Gm-Message-State: AOJu0YxJVtKAuxdf2lch2t+bPNpd1dNgFqfgJdrB+iOfCiMN0kuAKXM8
 ERl1xwxFOXObMT4Qjr2GDII67DQ7rhab7LR07yPBFk/WA9R0xayCFV9JtnWjEFSrWHhJ2OQs1LX
 b/DnJ7Q==
X-Google-Smtp-Source: AGHT+IFZtrtNMTiIO8Np2fohEpckJmLaIs5tKoUmL3ZZ8yn12hubrj9XMj1yiRYhNI9zCtO3juIgDg==
X-Received: by 2002:a5d:4e52:0:b0:367:988d:fb99 with SMTP id
 ffacd0b85a97d-36825f72661mr2099701f8f.8.1721155307398; 
 Tue, 16 Jul 2024 11:41:47 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db046e2sm9780765f8f.105.2024.07.16.11.41.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:41:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/11] SD/MMC patches for 2024-07-16
Date: Tue, 16 Jul 2024 20:41:33 +0200
Message-ID: <20240716184144.42463-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit 959269e910944c03bc13f300d65bf08b060d5d0f:

  Merge tag 'python-pull-request' of https://gitlab.com/jsnow/qemu into staging (2024-07-16 06:45:23 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/sdmmc-20240716

for you to fetch changes up to c8cb19876d3e29bffd7ffd87586ff451f97f5f46:

  hw/sd/sdcard: Support boot area in emmc image (2024-07-16 20:30:15 +0200)

Ignored checkpatch error:

  WARNING: line over 80 characters
  #109: FILE: hw/sd/sd.c:500:
  +    sd->ext_csd[EXT_CSD_HC_WP_GRP_SIZE] = 0x01; /* HC write protect group size */

----------------------------------------------------------------
SD/MMC patches queue

Addition of eMMC support is a long-term collaborative virtual work by:

 - Cédric Le Goater
 - Edgar E. Iglesias
 - Francisco Iglesias
 - Joel Stanley
 - Luc Michel
 - Philippe Mathieu-Daudé
 - Sai Pavan Boddu
 - Vincent Palatin

----------------------------------------------------------------

Cédric Le Goater (2):
  hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR handler (CMD3)
  hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)

Joel Stanley (1):
  hw/sd/sdcard: Support boot area in emmc image

Luc Michel (1):
  hw/sd/sdcard: Implement eMMC sleep state (CMD5)

Philippe Mathieu-Daudé (5):
  hw/sd/sdcard: Basis for eMMC support
  hw/sd/sdcard: Register generic command handlers
  hw/sd/sdcard: Register unimplemented command handlers
  hw/sd/sdcard: Add emmc_cmd_PROGRAM_CID handler (CMD26)
  hw/sd/sdcard: Add eMMC 'boot-partition-size' property

Sai Pavan Boddu (1):
  hw/sd/sdcard: Add mmc SWITCH function support (CMD6)

Vincent Palatin (1):
  hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)

 include/hw/sd/sd.h |   3 +
 hw/sd/sd.c         | 385 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events |   2 +
 3 files changed, 384 insertions(+), 6 deletions(-)

-- 
2.41.0



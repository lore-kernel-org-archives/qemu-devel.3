Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDl7-0008C7-P9; Thu, 06 Mar 2025 11:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDjM-00071w-Fa
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:06:06 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDjJ-0008Nv-SO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:51 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3d43c972616so1726705ab.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277147; x=1741881947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=Ke4nTtMro0FNWrOIK3224bFW1wRQQovdaebgTErOxaZ54H2brZiUNINuKHgWeJu5YN
 XN4EO7hyTPeot0P0NL+/XgNX0lvGmjk7f4mftkPiggH+iZFwoY+QvAu5X1w02C0BDW/1
 fUbvtctQE+UubjMkZihVKHty1Qokq5hogIZrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277147; x=1741881947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=psCK6/4NrIyXmTB5ag+BwjFSYcWr5NanIYoxQ8wmTbdGYApamB8Rc/aWk22YZlOcHO
 5+FCWKGgpMGfcH3NGlmFd0BGt1wvT862jivvXgbltU1GEziRCcTOGQAE9ScfGa9UAzYs
 6bXTQjgSSFGX4Sp4oAEaZPvzZQNbxRdbM0b6BswOnbbfQYc8ImYhV63U/7YhLN+UAyw1
 4HJRE6HEUlkLZZsPRwBJI+SEglkXpONPmdpNQnqZ2VpYgVx899ZkEcDMEwXM566GBBX4
 ipB6H6CmnsXd9cWnqJKokx3M1xxewAu86IZ5fusl59f8VcQ2GWl7O0i9GeQmv9sex0/i
 TviA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuvBOtGsKJrZNVvT2cWcg8xQ3lsIlHDiR8HebTq/oCZW9Xu+XlVu+X5ivm1i2rVOcen4UiUjhKS+i2@nongnu.org
X-Gm-Message-State: AOJu0YzxpqpiqxjuBXqhtd6BuntE6pPjqZDm3UFAP3+NRpUnZrUwPSuc
 VA7o/KmSS/xViaZKVtKYOZLqR8fB5WxVYTjVW2nIlxtObuQR6KRcDQmQ8TvgXA==
X-Gm-Gg: ASbGncuA5v/hvC437/TVYjo03X8DDOBFVo2ESAn9JghPAUcKnDoZxvmQ51ZbxSnZe2K
 nPBMbP5depcWObRcyij6ZsDa5xV3utnBIf5CnTuuKCPSvyHvT3xa2KpsGROcszkKhRudqI8k7lT
 C9lEwj1BaaNXr24iYTyoxeLBAgg0+BfMYp6u+wp2VeKv9Dx4kEF2yj/s4V8PpTFtr8L2jUdUdgR
 2J5FWnY9wmiNxkRpI5ELqq+wZHOozMmJZy3KcREFVpy6Ja9fb7LWKeNA1sMDu5rRUGL68cJXteK
 2J9WyLKo3nx14RPqO5L2HddecknsRmK+oK5KZiZaIRvM4fq3iBp/mvAvowsCb4RW3OkfizR7NoA
 GCc2kQw==
X-Google-Smtp-Source: AGHT+IHuglgVnFtzfUwfDuVTzdXWjTh0CPnqHoatBlkZzeNQ3VGOrkEnP75Ie1cpdQ24+4tOGWjSXw==
X-Received: by 2002:a05:6e02:4602:b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d436aa13abmr45343645ab.3.1741277147086; 
 Thu, 06 Mar 2025 08:05:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 28/47] x86: qemu: Support environment and cat command
Date: Thu,  6 Mar 2025 09:03:55 -0700
Message-ID: <20250306160428.3041057-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=sjg@chromium.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add support for an environment stored in the first partition of the
disk, which is assumed to hold a FAT filesystem.

Support the 'cat' command as it is useful for looking at extlinux.conf
files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 6 ++++--
 configs/qemu-x86_defconfig    | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 84b7dc8e99f..ae34cc2a6f8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -41,9 +41,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_CPU=y
-CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_NET=y
 CONFIG_SPL_PCI=y
 CONFIG_SPL_PCH=y
 CONFIG_SPL_RTC=y
@@ -54,6 +52,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -61,6 +60,9 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_INTERFACE="virtio"
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index d52afa42955..7afa3827e61 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -42,6 +43,9 @@ CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_INTERFACE="virtio"
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-- 
2.43.0



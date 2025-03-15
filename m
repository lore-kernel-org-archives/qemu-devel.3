Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E197C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSUo-0006oC-5w; Sat, 15 Mar 2025 10:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSUl-0006dr-K6
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:28:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSUk-0003xc-0P
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:28:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so4389645e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048888; x=1742653688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=cMlgGDk0wZtzt5Q7DLBPOqeWTs6sYXwosapwmHczrC0G4C7KitGaRx6Dnnc/R49YkM
 BZy+xJ+/YPOOOIh2YUUdGoHSzA1WcY9BrgOQC2xQmFw9oSQmJ9x+2yJlEgYQodJRdQgZ
 LB1C5rw7RIS4je53+f1LSb1iFBSeC/yEOqrAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048888; x=1742653688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=ZP+QLvEHTPDfclOVdN11zyOZQWr164+nDhbxtF7Hoyv52p6FuFTWmGDUKohU4RwmtT
 woPuZfYnqx7r7nd2CtZhxxZM8MHgw+af2NP3HSun1o8sbSj49aUUs+ZUKWxY5IU70uTr
 Q0YU0/z7paOOsqT3Qk8LC0GSnL8w0vyYmXcBAHAlCIF9sNFagXZ08KyJSe4Z/ClDKz2m
 xDceTfRJ98Obkti8HWpHQ0T0VdioquEm1s0t9tlS9MC5kP5Ckh2MwaxqnJtvYeWJfMV4
 6oEGcuWZfW4KB/hatRHl3fJh1P+ESsRea0LY27Bu5yyWU0hEzGt2/BLJqvk8T0B8HUK5
 ilDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJo+hibFEJkSiaddWpd3PbF1N4LmQ+0FglWi2iZ/2Nop2BMRHofQV6YrQu+0e9093qQmYfjNapXAAG@nongnu.org
X-Gm-Message-State: AOJu0Yxpv84X+NdlIV+cI2l+bwkBdeNWIo7Qcu9hff4ArYvb15reHBEd
 YH0gn4yvxDXXt5bmZdvyvZAZgEU59JpAy+D2/KpGcEYHBJkJ+BbLkazyb8ncfA==
X-Gm-Gg: ASbGncvACT9VCtLnrYEIGNWdZqTLkzsfOCpm+P+qRVvKDAwy4SEkOYB3E0x8HVGo7PT
 JRxUnIKkcl3YxFiWSz5spHHpXgnEi54NaF+qc1agXQBWguM9mLMGimCraNYKDQe+ll644m0qe9L
 4nIz9N23bND5BXVkaKogvX9teFOwU3tGGFKLz+ACObQfAPbSgJqLOgnl9DYMDjVcwE6/7GfyHk8
 JP1axEL+WJPaCrgxmOUT8wO77YwaEDWoGNwKhrZU5xuR25ClSwjvRFXAyINQa68+H/S0SRpWMLe
 37T3P/Iz60WjCSP1XwIUOooIqYJHDR0/du5NtVZQGQ==
X-Google-Smtp-Source: AGHT+IGu9fj3IB/3JJZSuGapRjOiDGUdzhm6XhlWU53ITcgn2d0W/XgrpVYSlW+dk1imD/Us4n+VhQ==
X-Received: by 2002:a05:600c:510f:b0:43d:aed:f7de with SMTP id
 5b1f17b1804b1-43d1ece301amr72592455e9.21.1742048888257; 
 Sat, 15 Mar 2025 07:28:08 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 28/46] x86: qemu: Support environment and cat command
Date: Sat, 15 Mar 2025 14:25:48 +0000
Message-ID: <20250315142643.2600605-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=sjg@chromium.org; helo=mail-wm1-x331.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEDCC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmhYN-0006Ee-PS; Mon, 24 Feb 2025 18:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhYJ-00068N-Hv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:56 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhYH-0007eM-Oi
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:55 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3cf8e017abcso17287955ab.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 15:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438471; x=1741043271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=B9H6WcSl2ILnhxox4HI7L3mGAtI0gfGWODW73qTPS3QP3zfB1bMACBgdAcjNfwpLJD
 DE52O8r+BLHgIsSsUp4+MPh6k6EGRVjzQPv6f7a65FRtJ53KkFKdRmfpYgQz8ZA6JqOx
 GgBNWvTWzRiQ9ISxkLK1kqQv/53RGYv6edeeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438471; x=1741043271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=AZgVIKm0ic5Q/0nz4JFZ4eiG3FE+ruk4namCgI1hG/f7Oz7m+/I95QFGtXxT1pfyVr
 UN12VXSNf96gkOO95aZM/XxpLtI2Cz9jYDWY4PIwXJZB3ZawPswSrox+x3ZlbJXk+F3L
 owdpwoho3aIn8fyQHdY4msIiSIYJYWkOn2uqvoXoOsLBGOnD7M5DAZbdiKRWJ9Qg7tez
 gZIhgLPHyzoml9MlMjvF2PF7oTWte2PFAa+hjpAZkZqvgSUD9ubSl8or/Dmlh8bBNyvy
 GolKZy6kGXlY77e1IJjLZXk+EkkvFLiId8Ir+gUzFs1XDIunmIeXtZMe+Bjh8YVdZ4T+
 7udg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoSbd2yTkeEEHJ/woOopSyt3DTubI1YdIeCygbeVJCZ4S83FPN4nEbXLlzzQHYFmES9ijv2x8/nR/h@nongnu.org
X-Gm-Message-State: AOJu0YwckqnD1LX9yOj3NS6OhaSvH7ec7Rw30BYtK5bFCBIDeEfV9UZD
 IXOzr8Sw4Qtk86eiMTfT/MZZBbvYVfZqSGJjiUN7XxxqsqaELyJUli5nCsYJtA==
X-Gm-Gg: ASbGncsou9llmRuZcHcqy7cY5/ipqAE4Eos44h5Qvj9Tn+ZNjnR+29EoJXoewfmtMCS
 YwhitZR9f48pRVPkO0i8XPt1Gpjtf5TBZDHetdrV7jsX3zb/2g/LPkmF7C4aJWiuNrgVIDLcku5
 5Ubni1MxMek0R+nxfozh+5/zWfhjl8OPSjmH55mH6u1FJnyNGr7iFSs16Nmb5bRq0RDEwlDD9Zg
 lCF1X0TwTuHNBueSSVIfiw0ZoAwCEotcG8YQsg10QIRjQDNC/6RDwjotz6arjS8T/0G8fsaT+b+
 J4da6N5R+yiGGls0KNNNIUT2w/dU6GyPG1cOURc31S69Ri0SLRDrOLZZv4lnsEk=
X-Google-Smtp-Source: AGHT+IGJ0PyYA7aN2H+Wd3AUmLTHv4nsQ7t+eBZtCay/PdzBHbeJLHh3U9MgQnXeG1vnXSkUazdOJg==
X-Received: by 2002:a05:6e02:b2a:b0:3ce:78e5:d36d with SMTP id
 e9e14a558f8ab-3d2fc0ea5camr16148325ab.12.1740438471564; 
 Mon, 24 Feb 2025 15:07:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 26/44] x86: qemu: Support environment and cat command
Date: Mon, 24 Feb 2025 16:06:15 -0700
Message-ID: <20250224230640.2665206-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=sjg@chromium.org; helo=mail-il1-x129.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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



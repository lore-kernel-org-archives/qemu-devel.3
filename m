Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B5C021B6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmhXU-0005sX-7C; Mon, 24 Feb 2025 18:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhXS-0005rR-BM
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:02 -0500
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tmhXQ-0007UW-FV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 18:07:02 -0500
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-855fc51bdfcso61601339f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438419; x=1741043219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=SABw4C6JXdTIdqBHeRoHAExTAMIiWMzo/LJW5NUVRe+IozPysSApAHk1v+RDRP3WAu
 i6iO/Bb/YucPVWH6ohppjkTZlP+OTIcLmmw3/Mzu/y4FA043eytfaBkbQhl0kc2DPTEG
 Xh/IN+ujMIEGm/UJE+XR+FMDBQjSi6eWKB0W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438419; x=1741043219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=LRU+nq8lvaoylO6H8IOoNgjIGCe/EcAcocZZRjdQOR2ZC5X65ktOgVT/6ksPAFP2ed
 uRgJ1rB8DG9qXk4lD1Ua49JtFtYeiQh/dSwIR9wV/JzR4RP3cwtL0OM8kTB9nGILsWnD
 54hDtHCGXh7sZHVtOom2sisLEC7SBzf3CiHUOX0KNtJczzdP5h+/fc4xAFXIuiSscVG9
 9Wyc/hXsUw0nYdQ9J941NZ/3eYRVbeeQ13PxgSyjB/CnsCsoecTYZHVgSKsGdn6B30gq
 fk8+tdgRyJTPowUOoA/lZSq03sPvMH4zv+izWvTOE2C3dXHotmWskQ/ffBkw3kanOz9c
 yogw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHa0FiRZqP+74ObLl9l+HpeQu/mrbcO2HdCY/5toufyr1H6nqB1vWjCNJ++IAmd5I9BUpmrwh0MR2A@nongnu.org
X-Gm-Message-State: AOJu0YxdQn4UmyA4j9pu37ftwrRtBBYanaFE/82UT8YJ3I/J5uoIIL2c
 dh6YEaeFK/65N/ktnP+ioJYTiTDfCx5AisKK7nzOJ25O4MNp9RvfqQFnoYsUhw==
X-Gm-Gg: ASbGncvNinYhE/gau8p3Jwt0X/Q2twCJXWvMRVORgDS2JJbGjxHH9doaX2W9eACrcBd
 kWfhmjGRTmms6Z1KQJxHdkRXIiDKmvJ1OsB8iIBqLkBxRKUdlhWlizhe6unA3MJLUDfrWaYZx0d
 FbOeDoicS66WyIAFjU1SDhfiS1JJW+1lhl45nsDoRE1509G3ArfIQGqaDK+R5tNWOitxX9OePKN
 fuRJvLW/6LQ/YG4fdveLU+u9hok0bRcQCC2n+c3fw/1BdYr09wKwf9Fg+PDk58TyRHrZtfzgwKr
 rcjrw33Y0Z0U24EIVK9KndBWPJ0SaRL/DRxDxlPDsGJfz22M/T+LAQ+WZJ+YvpE=
X-Google-Smtp-Source: AGHT+IESzZuQ3xV1xK6PEf28VTHcQqfUJM+ii6gDMG9whtArFN0CXpZoszcI9vr/2XP8ZVa2fuTVFA==
X-Received: by 2002:a05:6e02:1066:b0:3d1:54ce:a8f9 with SMTP id
 e9e14a558f8ab-3d2c027290emr172917405ab.10.1740438418802; 
 Mon, 24 Feb 2025 15:06:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:06:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 02/44] x86: qemu: Switch to bochs display
Date: Mon, 24 Feb 2025 16:05:51 -0700
Message-ID: <20250224230640.2665206-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The vesa display is widely used on hardware, but it is a bit of a pain
with QEMU. It requires executing option ROMs, which either doesn't work
with kvm, or is difficult to do in a kvm/QEMU-friendly way.

THe bochs display is probably better anyway, so switch to that. It works
fine with kvm as it doesn't need an option ROM.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

(no changes since v2)

Changes in v2:
- Redo commit message

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index af275e8ce8f..ff2a192ee7d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -83,9 +83,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 0b0e10c795f..ee5b150e062 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,9 +62,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
 # CONFIG_GZIP is not set
-- 
2.43.0



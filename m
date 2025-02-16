Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2E5C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlVa-0007Fk-SW; Sun, 16 Feb 2025 15:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVV-0007FJ-LB
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:53 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tjlVT-0005fu-Qr
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 15:44:53 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so137134339f.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 12:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738690; x=1740343490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DreV9NBWw1rAAKxQDwzKoQMmZrapH2rDpG7DGjQOfBQ=;
 b=cv0NN7fr2Xg5l8NFJT0ZAcCKr6hIlbelXZ/n6KYU1z4Q0AzvKSwTfSiDv/JByAhX27
 kfMkAKImwmPV+ozEZ2/GetdC3YW2Fl0JmDohKfGmWB4UTUPi5wqLElLW/Wvm7zaf5Rhb
 ylQoH4RXrIz2IAnQuBd278CucjQDfyReRxt+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738690; x=1740343490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DreV9NBWw1rAAKxQDwzKoQMmZrapH2rDpG7DGjQOfBQ=;
 b=Cb/XOW8b0HtscwJSM2t6KR91M5fma69qKlWA5LlAiu5IxMRWEn8eBNb6FC/roIEAXQ
 Zmj/tHyxXxnTb+uxBMM/5ydXnh4PSWX538O9EYo+GcENkdfsoinRTZ4g/H3qywILVlVN
 xe9l6YIl9uvJzyuBmyuFfUtdyftyffLIjn99ukZLd0q2G4AhbF6FCfZwNCVGjZzJWlJ7
 9i/2WmkBGR/2H6/8NLr6foZOOQtls8xN/qcUtkYGxjLLdlSSAruRkd8fk0RQ2q6R3OZp
 8Qp+aH76SeCYwhYvrt13/aK2f5vIFk0gDQKrs0eEqszJLp4JSLyqkg7whgTXeWXteKJh
 Bb8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgC6kCyuETAq0cnMOG251utykwXE1R3cl8jnIKnKd8Eo5CQq7zaE/LJwdxcawL/k1zKDinl+OvPGe8@nongnu.org
X-Gm-Message-State: AOJu0Yx6+urCuOotUbGd68UNaSx9kiP9Q3hv2myypQkrVG/Vk9GEaakv
 Cb/vRzkyuSIx7wmzcQD7VjXPEmciRKhL371lddEAAyTZdpCznXcPhjDUAHH7Hg==
X-Gm-Gg: ASbGnctD4cZLvxiUQMpPnyDSJOpdYjn33F3MaQbCN3cl/yF13Ndwm9r8QQiZlLfn+mJ
 sHSJu23Wo2jL6kLuuKZS03UVXdOWN4sTLyaiGA8EckaFml5XZvhxUOTedTARmYxL8A4WTFnvpMq
 og0/D5F0bvf+WrZHq59jyYc14Jdq7wMPC4yh3DyDgGXcLkyvurKYydD2YnByWDNuKYsPnsG3BQI
 ue/RHKcf5w2OxI2gtVVTMhLdg8XJq9A1BPWs0dqbxNtvM+0pfLvb1MNqc2DrpBSDXqQIl8FzLrK
 a5QttVZmiBLF7yZDUjM3o3SooTHgqRruENNYlWhXFXYHIutcCv3N
X-Google-Smtp-Source: AGHT+IFVW4sYH36KMd/WtC0pieXo6dZkD4DFQF6MqOw1XkQ0XCh5/OjhdzlMOChRjesLs4sLeAimXA==
X-Received: by 2002:a92:d34f:0:b0:3d1:5dce:5105 with SMTP id
 e9e14a558f8ab-3d18cc7476amr85680815ab.4.1739738690507; 
 Sun, 16 Feb 2025 12:44:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 02/28] x86: qemu: Switch to bochs display
Date: Sun, 16 Feb 2025 13:43:47 -0700
Message-ID: <20250216204421.3560012-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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



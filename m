Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D43C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSUC-0005RA-Ld; Sat, 15 Mar 2025 10:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSTz-0005NS-Ph
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:27:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSTx-0003of-C6
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:27:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so3979995e9.1
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048838; x=1742653638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=bAWnFepQ293569oD4k7tgXaOYTMM/w78cDPqJigle5KUO7bFgT0e0pcXVnfnyd/Aqp
 I3qM2v7mKilPnGZ7/K3Kd4AVcIRo47CjXMg8QPAZz6ugtqRdYKVud7Pj+yAgBim5+zap
 2Y7kBVEoJrnJqXCysIYdoSRn8c4bikwWaBLHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048838; x=1742653638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=ulIiagk9Cd1Ten8wr9q4IbL1gGRSMH7BU7Yb89D+HlRBhuNfLegylbTzZmVDUBn9bK
 Xq99AJxq2c4w114hTLenaUQCXj9UkD+ETac9GhRpVmoVqIWT+dK3Dt7NQrWTiZmi5k6F
 vD+y+clGj2GxHFnnHUZWYHkMctvz+O8C5UX2qKovNLIABRRUfxO4PDJLuu9QYgNPvS5G
 Rvs8R/Q8mrJbxsjEv2CYkwq1P+2ULeMxpxRowGb7BHWB0RYYSeN0mVAsnbrcPGevJCaK
 sw/oeS6cey6jTUz+EUL+PwV2t8gzH4ghfpv3s6KA6jzeXZ0ZnPT0ACBLOVdYLSW06cHG
 F3zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/d6OMclukCIRngBVV2Sz3faYM6dUpwFSNXGme52zQZ+/qaVbHgKkF3gegrrbPG/UW2XLoyPH3jp8c@nongnu.org
X-Gm-Message-State: AOJu0Yx4ntxmg78A29/yU+VFS92sFpBg4HFSM+/dGqYhSew+70dS1WqY
 Vz3ImpiOhbyGQAKDURbxFVkjaPNRN2nkPaHdv+nixGlGQWg8xBRIvhYzC49MNg==
X-Gm-Gg: ASbGncu4CUbX49S1oAj0eBBZdMB91YqGmYzQ1Dp4tJQSS56nFJwGsGWZiTQ4kPZREJc
 iJq+F8iV//FZu8zLS7MbemY+Izoxv4bZGFDJjU+yR0WZc51nJzUgjZGfp9f+9CxkuZnW8eAf/Be
 WmsWt9POqd7q7Hvq0myJFERyiwio62ezj9fmm+Ha/hqXicV82zBlBZTEaceFz+Dh9qgzmNrLDID
 5Y5toND64IZUHKThw4LhH1myThY+rqh2TucX4zfJ7hR4v4/R01LkJHqAAwhXvj3QMVDKahRApsj
 SlU3NrXLRTdpiwP4RT9Ijo5FbyTa7Al7ZbmBQYVe9A==
X-Google-Smtp-Source: AGHT+IEUCaKWAXmD2dNfZFSctlqBx4wImhFblMcdOlpmkUTq5sOMZbTFX+xqYzEO3A7bzTBWlWcLtA==
X-Received: by 2002:a05:600c:3c9e:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43d1ecd2a18mr75871985e9.28.1742048838153; 
 Sat, 15 Mar 2025 07:27:18 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 04/46] x86: qemu: Switch to bochs display
Date: Sat, 15 Mar 2025 14:25:24 +0000
Message-ID: <20250315142643.2600605-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=sjg@chromium.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



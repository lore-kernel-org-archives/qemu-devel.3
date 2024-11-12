Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F4FD42B84
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArQo-0006Ux-BN; Tue, 12 Nov 2024 08:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQm-0006SK-TG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:44 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tArQl-00042K-8x
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:59:44 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so219907939f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419975; x=1732024775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQ0or+92eQIwyIqeAnu22dTpZHJuaX9S3qy+ardMUUs=;
 b=ey2yb/y+GRnp6ZtgU9cPNe1H/xQESU6jXqUc4spVvCpttY5+ums82TXJiZhqip3Ffu
 xiOsTjXV71wTsTh0Nt1eqYa/F/IZuoRskkRCl5m8mkvue88XAcjNmEb8s4hh+oVbddZe
 KwGKGkqja/l++V8y9KNgfE0Zz508tBBywJTg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419975; x=1732024775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQ0or+92eQIwyIqeAnu22dTpZHJuaX9S3qy+ardMUUs=;
 b=wAx3sFDvVbyZdn2MLd1RqplufaByh+luJbYTG9Tz4A13a/x2SlViDziraCkxSggTYC
 OjCNTvW9MXyWig/i60pOx6/RwfqDoQtuGv/pgLiqgN7sCMQr3nlFgfiORubylsgyAqUs
 nEM8jGrgYVNSIHfzO/bSnpCxSHNhJRC+pkuqFmbujnNxd0DsC+S1ONrbJbAKr0wDIULS
 iXGKxjweSP/gKEJcIzHDpxEUA+72R6tFWrgkOl0o8JvpVAh6SvFIq/UJYu9ysz8NI5ma
 5U4aP+4UKh0ehKUhQzulAMFxtq5+sAC8UDp4yX4WT2qagHpqSTARqc0nEXsnt6aSVUFz
 Vuhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMlICEcoLVg0leBw1bRHo3ojyCVIsEZE2Ak2LGOrmsrX1r8TzbvQ60IkJztXKqk5Wio9Wfs5Cq9QV0@nongnu.org
X-Gm-Message-State: AOJu0YysNT/8EZ+qlZLqZAfv2B8/6+XALdJI5zM2pWpIoNbwbiMWUHC+
 ioEigUQp1NrCDeY2Euj82zo81Z3J8tcQZDHDjqAKLQh1fQ9jyEmfPdQ95JARoQ==
X-Google-Smtp-Source: AGHT+IFRbhsH3AjC0WgNlkAxNkftaUSmp70QM44N6E+zcwo2sbWOYoqBNr0YBpkJee5o8ETWAtybWQ==
X-Received: by 2002:a05:6602:3c5:b0:83b:2da6:239a with SMTP id
 ca18e2360f4ac-83e432ae355mr281331239f.15.1731419974877; 
 Tue, 12 Nov 2024 05:59:34 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH 03/18] RFC: x86: qemu: Switch to bochs display
Date: Tue, 12 Nov 2024 06:58:56 -0700
Message-Id: <20241112135911.630586-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

Unfortunately this causes the Ubuntu 22.04 installer to stop booting,
which needs further investigation

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 218c3535d15..1670c122002 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -81,9 +81,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
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
index 947d15cd727..40c2f1cd362 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -58,9 +58,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
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
2.34.1



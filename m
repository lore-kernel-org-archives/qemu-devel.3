Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8673C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDj1-0006MM-E3; Thu, 06 Mar 2025 11:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDiT-0005yS-OW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:05:01 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1tqDiR-00085Z-QX
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:04:57 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-855bd88ee2cso18976939f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277094; x=1741881894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=MMqV2vSsL2Mix+hSRlId9lnywzdUNH/PJiq4oXr/0FGpfD8TZ61Fxbng7OGtUmwcSx
 47OWj+dAJFUup62cPmCV6ok6OM9I6x9XBV5/bRMFfZDy842A/MI5tDMPJOU2/GTvHFFA
 sR7Y3CDdk7LpelocMG1RdH34ezAFZHdPrt8gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277094; x=1741881894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scYAFHQt+yZLnJPuXsDZJw8jiztjZtxUpNqeXfeVN2s=;
 b=E51f/uePjond7oXA7afhQOtGjgTEeqGcLtMCqwCXI5bEJu2XM/qT/HDTFEjyntQIxy
 DrFnfRpWPFfa6cTQ63x+gI2c/xgnD8gM+HvvLEaqJHtyVaD5NQAiAwi/b/i6w0dsMZCA
 xHn7n9n8od8yto/lgVkkmtxDqCZsTfx/SeB4o/br4LD/vifmp0JD2ABn8wqKss6jx25L
 0LmePMFWjgSZBRHI7q84+7I1HqXihaHhzbKsuFLlCf/Zg++A2ar905xPHHa2KjTHDD2A
 DIDZ9XPvcSEC7Il3CIPlfoVXt30TgidExL/x7iaG/yQnJ03xaI04zzXuVcON5eN3IyDi
 HiDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCVEErf1mAiHdxVZJlwMCuFVqUfkyw4b3L9z3ZEEL2cS69h3R+kVI49+pmE9J4hyvxIEarbURNqyTp@nongnu.org
X-Gm-Message-State: AOJu0Yzbc2jqBjinhRRmFIcOVjjbj6fFVaUTSn6NmsRWNZeCqP5k2fxP
 sQL85dTpcL2CYVSprtU7Vh1wYRu/4qXKdv+/iYqZ4d7RUed7dZL667f9TrwQng==
X-Gm-Gg: ASbGncuYxWdiBfxuBJMeLn753EI1cMwCeYfJQVd1DZ37eyNs3Q2+Ci6mGjninK5RIlk
 IK2hLeYdHGjRCU1E278wPb77QNWTJpnFtbTGtlWwoyaYo9V+bVgkZJq6o3tzVmHBMHeez19YuWl
 5yYrrAEhrVsDO3Wv1mTO4BFnqwTKeDJymUYPaafSAM5IUdiz35Nrm6Rl9WM5jfMKSrzNAOj4vk6
 HXm4ii/NbfCle80FX9YMBgIMJkIoT993VeLGoeBkOAS1Wnv2TjcLfxvlWUdVTRbDKsw+yVlnzeN
 CxpX30DxwKmCL4PF+zJU3HsuB6s6ayw4uAfVxodgCAxD3Hdz4LQuaQ80KelOqm43n7FnaZQdvrn
 B2SBBpA==
X-Google-Smtp-Source: AGHT+IGrDhWIuTeARQoX0n52NIjXDCU4PV3dfKlAoDGi0UFWbweufFaR2W6GRjviMc5psIKMzaJb6w==
X-Received: by 2002:a05:6602:474d:b0:855:b345:4893 with SMTP id
 ca18e2360f4ac-85affbb4dc7mr888719739f.13.1741277093043; 
 Thu, 06 Mar 2025 08:04:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 04/47] x86: qemu: Switch to bochs display
Date: Thu,  6 Mar 2025 09:03:31 -0700
Message-ID: <20250306160428.3041057-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd32.google.com
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



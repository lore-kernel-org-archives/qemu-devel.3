Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A97C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKm-0001LS-KB; Tue, 11 Mar 2025 09:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFL-0006LS-Pr; Tue, 11 Mar 2025 09:02:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFI-0000Ok-LQ; Tue, 11 Mar 2025 09:02:10 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so11359335a91.2; 
 Tue, 11 Mar 2025 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698124; x=1742302924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAN+HnepXEYeETm6X7cQEpTvdXTBx3EHSfsdgopHuPI=;
 b=JJZbh2l0Ph+pAKrU4cJQj5kkoQ2p/UBym7ImFEWHMokTBORjMacpx5KSj1cckOxDI9
 gPjPah65MNWgo8B0TkuAjAPWYr8tFTuj/CPkDsnhlnz1bUkBb7LAa3WTxCVkF3677u94
 3O9f/ZjhVj186sd9u2dPK15H9RTD8rCkWzJan+xBaNtmZymCE5RiEkmoEt2m4wLIkNrD
 zOHoJ23R/KKzfJx2UiQC2GgiPLLOkVBZ5+Dwt5iB5jRcqy7NB6gILSLn/K2rmQuNF7mt
 YYZRUdVCdLUIi2ATqVuvnIbr/5gO3R3qTife0uk575D7hhCTvAPvWGxGfQHhEiaLUBty
 pv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698124; x=1742302924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAN+HnepXEYeETm6X7cQEpTvdXTBx3EHSfsdgopHuPI=;
 b=NgwPyKNLEuhZM8xXGdWoJ50ckNvYMKG5VTztR/pvHuHfnXvOTJiujkWUuiF7yDMT0h
 E7C5wq8kSawLCLyTelwve7Q1xtrCqSS/XcsnqgvrQONKaYDdOqu0MsCZmqEdahRodpzT
 dutR785tqpSh/p7BGvWCoOXOAORDUKZV5rou5Qb7Y6fPzrF0f29H9QGKFN8/xIEBL3/K
 CNrTu3IdVNPiOT+SD1GuGaqNDgsha3wR+iJqj43HIfkUJraNVLgxuJX2lpFoAyOqVTQf
 7iEvO/m4biaMacIKiXsk+2Gr+cgBkSXszIFYZeSDMeyj1PA2ruZgGWMqWgBHA4MPn9X7
 tuFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyLr06BuYEZIeqJ5U91oO8afNWxpAGWiSdTETwc8x7tDmp5ymYjc5oBOxOLp9dD5tcZxaCUHYumQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx6h9FCt/7fHHvFiSxPUJZ1lfe+Miml5hwqEtQW1jfSoO2lpiFN
 XAK1WL0i5LdtEANLgohsEbveM2FPkPuKF9JZW/iS5vXjqharcWDSHHtKpA==
X-Gm-Gg: ASbGncuxvlkwt3AR5OQAFx1taCNqTZtURCgPDMASyen8iD3P1RfQDNXCQoCXR9oAdL8
 JOTYKnDq0HUXYUEYs9W934+jF6A4Kgclvi3m7P5Y7Xmf+EaooUmZrKi0lM4NhMTQR6YW9HjBrG3
 Hu7JXIBLLingwLkcTIAEk+LUj1NMw3t7tjOjHmw9HJi/eYM3gBWYN9pePGY7X64Al/6BKeMD3MC
 SmKPy96t7/CbefBxlTJWlmiFgGw+PC7kYNj4M8iGtJ2KZHlCYTDU0CEn9Du74cH4Bo6q5NARI15
 Vqn41hyp+EtryMEoH+XAnsf4e+WV4cfvTBf6oBeoW4q4FvH/iFs=
X-Google-Smtp-Source: AGHT+IEhxKc7QK2c+anq0I1mojZLWvDqfhA2vOV9L7tDz2FcGcafQoam3LJNySdsaQeq/PjJ9Lg/jw==
X-Received: by 2002:a17:90b:2883:b0:2ff:52e1:c4a1 with SMTP id
 98e67ed59e1d1-2ff7cf128acmr27247430a91.24.1741698123882; 
 Tue, 11 Mar 2025 06:02:03 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:02:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 72/72] docs/system/ppc/amigang.rst: Update for NVRAM emulation
Date: Tue, 11 Mar 2025 22:58:06 +1000
Message-ID: <20250311125815.903177-73-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add NVRAM and hint on how to make it persistent. Also update Linux
boot section which should now boot automatically with the new NVRAM
defaults so manual settings in menu may not be needed normally.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250304205926.87E364E6010@zero.eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/system/ppc/amigang.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
index e2c9cb74b7..21bb14ed09 100644
--- a/docs/system/ppc/amigang.rst
+++ b/docs/system/ppc/amigang.rst
@@ -21,6 +21,7 @@ Emulated devices
  * VIA VT82C686B south bridge
  * PCI VGA compatible card (guests may need other card instead)
  * PS/2 keyboard and mouse
+ * 4 KiB NVRAM (use ``-drive if=mtd,format=raw,file=nvram.bin`` to keep contents persistent)
 
 Firmware
 --------
@@ -54,14 +55,14 @@ To boot the system run:
                     -cdrom "A1 Linux Net Installer.iso" \
                     -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
 
-From the firmware menu that appears select ``Boot sequence`` →
-``Amiga Multiboot Options`` and set ``Boot device 1`` to
-``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
-hit escape once more and from the exit menu that appears select either
-``Save settings and exit`` or ``Use settings for this session only``. It may
-take a long time loading the kernel into memory but eventually it boots and the
-installer becomes visible. The ``ati-vga`` RV100 emulation is not
-complete yet so only frame buffer works, DRM and 3D is not available.
+If a firmware menu appears, select ``Boot sequence`` → ``Amiga Multiboot Options``
+and set ``Boot device 1`` to ``Onboard VIA IDE CDROM``. Then hit escape until
+the main screen appears again, hit escape once more and from the exit menu that
+appears select either ``Save settings and exit`` or ``Use settings for this
+session only``. It may take a long time loading the kernel into memory but
+eventually it boots and the installer becomes visible. The ``ati-vga`` RV100
+emulation is not complete yet so only frame buffer works, DRM and 3D is not
+available.
 
 Genesi/bPlan Pegasos II (``pegasos2``)
 ======================================
-- 
2.47.1



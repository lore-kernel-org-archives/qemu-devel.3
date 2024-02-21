Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40AEC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu0V-0006B5-Ek; Wed, 21 Feb 2024 16:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzx-0004a3-4R
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:26 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzt-0001NV-Fl
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:23 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d44d78e5fso2020285f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550359; x=1709155159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSyJnKQkd93ud2FmPgc+3hwMsxOVnxzVCD11CZAAcfk=;
 b=dHP54ZK/SlQkPy6n53VV6BW/1UlH9FWQ60TCS3VMtPP+u/C8oTFzu0a9U/yOQi9s2W
 p79JQeFoWa2fD2A38Bvzxvc+fQASyrF0hOJs1ZbODUFoOpCoZiLWXyktXhPSaR0Vpqq7
 vu3P3K0ipKmR/oS1faGh/ReXUVlv5LZeZ/jjVzENn986KKME0zOA3tR6fORxMi7E0uNb
 L5FFE2YCTLFOWspEZW70Fe8in7tfBv6vCY+m+Nh4bvk6EMg6NMoMg5L6CQfLfviuVJh6
 VA8OqKhtxGlj5VR156Ec67IWaxU5NbXfFMkacvkCgHi0JtJ85RznwHQmeHz/U0rvKc4O
 9MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550359; x=1709155159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSyJnKQkd93ud2FmPgc+3hwMsxOVnxzVCD11CZAAcfk=;
 b=udku5VdIeK0GTtinn2bPa4pWOT4TZDLhywt1p1kLBSglqDak5X5+1WhTeZUvbW8FY6
 ZMHsqj0j6/H6yTjJi/dRURJzyQTaNDkr0x1P0t8jsfzUF8Ic9BaU6Z3CXphSxoA0lbFa
 CD2S32CoU9eaDWDcwY/jHTIoQMI3eI7vjhfyg72QryfCAYC8zQLos/CIqQ9DGTghR8hM
 FeK+SuUlWMCbRDj9ujw1IiC6aADCfl4Y7Kn5wOHvx+IuhCQBWK+zYQy36jEjWECqbJ5d
 aicF95ypX2JqvWfkiQ0odXhI8m+JkDYljVbu1hPMpgbqKfnFLqxg8gbEOtX4GD6zlpqe
 Kwdg==
X-Gm-Message-State: AOJu0Ywa83cE76qpNpRKtfTIHJRLGCD/9HLuppI0j/FWlFS4N9/X+AZb
 r9DpjSD0UAfBpHK8VMRQy+lQziDiYdeYBEMfMoDdaHO0yol3zTe7LdOqff/So3Wx00R1nPi65Jd
 3fac=
X-Google-Smtp-Source: AGHT+IG0/TS12M26H3NQkwkNXV/cOJUAS0IUBeInj+gTqx2YkIHGntbYMj4+ad3B+rkq4bLtUN3V6Q==
X-Received: by 2002:adf:fc90:0:b0:33d:3566:b5d1 with SMTP id
 g16-20020adffc90000000b0033d3566b5d1mr9489249wrr.57.1708550358803; 
 Wed, 21 Feb 2024 13:19:18 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0033cdbe335bcsm18113801wrm.71.2024.02.21.13.19.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:19:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 24/25] hw/ide: Stop exposing internal.h to non-IDE files
Date: Wed, 21 Feb 2024 22:16:24 +0100
Message-ID: <20240221211626.48190-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

include/hw/ide/internal.h is currently included by include/hw/ide/pci.h
and thus exposed to a lot of files that are not part of the IDE subsystem.
Stop including internal.h there and use the appropriate new headers
ide-bus.h and ide-dma.h instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240220085505.30255-8-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/pci.h | 2 +-
 hw/i386/pc.c         | 2 +-
 hw/ide/cmd646.c      | 1 +
 hw/ide/pci.c         | 1 +
 hw/ide/piix.c        | 1 +
 hw/ide/sii3112.c     | 1 +
 hw/ide/via.c         | 1 +
 7 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index a814a0a7c3..ef03764caa 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -1,7 +1,7 @@
 #ifndef HW_IDE_PCI_H
 #define HW_IDE_PCI_H
 
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/pci/pci_device.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1ee41a5e56..f8eb684a49 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -31,7 +31,7 @@
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/timer/hpet.h"
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index c0bcfa4414..23d213ff01 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -33,6 +33,7 @@
 #include "sysemu/reset.h"
 
 #include "hw/ide/pci.h"
+#include "hw/ide/internal.h"
 #include "trace.h"
 
 /* CMD646 specific */
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index ca85d8474c..73efeec7f4 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -30,6 +30,7 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 4e5e12935f..1773a068c3 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
+#include "hw/ide/internal.h"
 #include "hw/ide/piix.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 63dc4a0494..321b9e46a1 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 3f3c484253..cf151e70ec 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/ide/internal.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.41.0



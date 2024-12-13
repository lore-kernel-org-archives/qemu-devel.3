Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E150E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8Bc-0001hP-R8; Fri, 13 Dec 2024 11:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BT-0001gp-0T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:31 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM8BQ-0006ep-Dh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:06:30 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so283270866b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734105985; x=1734710785;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEHyHCnolAD/eFAXqMw+MQuU1GhJUTNe2rn5XFdxHBc=;
 b=JKGH5/9mMxlWPFmkzFL0qiqtMh453gwzeBeT6U+gglSLP3eBpJLraSs8zHBrhF1WmG
 gs9dA0ReuCWwuTWDOiF6LpT0xTsG78AUaeuVzPQ84pZVyGcRz1TNiOiQENm5NX/CVRiy
 BOiPpe5qxu15J8OZuYiu1GEeCrd41gKKZMB2K/Wtop16bx7Nf2xQg8GyecNa16q35PMV
 ndN5Swv3G4QXcXdJtw+Dsj7mLkn1vCXat/c8QLeS30JBxdGwCBD4zG6TTuHW2zXpFf9E
 Njjq19BcKIsv9KoAYfxNjPxpKwzx/+7C7UEiGSpdmoz2RB2550MPiGtihoPLjk32VWJr
 Njkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734105985; x=1734710785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEHyHCnolAD/eFAXqMw+MQuU1GhJUTNe2rn5XFdxHBc=;
 b=ZBVae+1VPtZG4+ITu4v9DnCyNewx+o0mI2T9rGeLzSLP37tWNdjRFL6qAsZxp+em4B
 BHfsG2G385nRJselmUo8JKy606zlMNdQmXT21f/ujYnzP232r1MKnIFSnH87d9KERoVO
 TzsvtVGKFyhU9dihU7YEn8CF/StuMZAs3T2vI2C7MmoxocLxJ49XNkf+YuGAEUBSGPkz
 to5VIRZkJrhYVO1F+Xf0Uzb/VtSLAezNky2QF1tNb2zjtbdLvmwpNt9acZYVxls+nHLw
 S3AiX8Z0q75FgIhuf+hIKM6ixmic29Tfdmg7f0WzHZ51ePWua1zUEjeEwbYSVvif4CRn
 LI5w==
X-Gm-Message-State: AOJu0Yy4MWyKfXHQkR1WmouLmDeoPdTXpVkb1nAQRLbvxgLrqn9Q5Yz8
 b1KtHCbrrz3+BEC+D5SN0lKIocrJno1OJIiTJGHGz2c3SY6S4+NUgMLiuxqIfVsRxM6exlg3lQh
 cew==
X-Gm-Gg: ASbGncvla82T4ZYhLYb0zQ0OEA9rY1AZkNvFDDxQ2CXiyAoZgs11fF+Y0Wge5xEzoaI
 zbM6IVnGSIp/WYHD5zGHj/aYiEIj0duFU6YOC0/x/PZMQ/denr0gWZnJjz+rGB69r+LGE2fmM6K
 d5eJH3gfcUZc2lttRYj+CIARYNhTGS6+9IkgS71GXAiLiT6ZbDHKwcG8HHhKpZIH7Ekx5fCj4NG
 RjryymC2zau8w5AbUxS7T0QeymzON12/+nOEwR9R1hHo8+TAXxcCOFrnIJjhzOOOs0Al5bQNiXG
 o5S1FqwyoyF1kFmlmzx9C+bSbeIA7roB
X-Google-Smtp-Source: AGHT+IFnhUSMC2MDBgVGiO9BUSL86lUWIFX+wCSYYiYDY8EZ21rwqxJ/h86kxYcbDr3GQqYYDxJOIw==
X-Received: by 2002:a17:907:9557:b0:aa6:7107:db00 with SMTP id
 a640c23a62f3a-aab77eab9d3mr248603666b.50.1734105985016; 
 Fri, 13 Dec 2024 08:06:25 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa667843413sm916683166b.24.2024.12.13.08.06.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 08:06:24 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 1/6] hw/usb/hcd-xhci-pci: Use modulo to select MSI vector
 as per spec
Date: Fri, 13 Dec 2024 17:06:14 +0100
Message-Id: <20241213160619.66509-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213160619.66509-1-phil@philjordan.eu>
References: <20241213160619.66509-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62c;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

QEMU would crash with a failed assertion if the XHCI controller
attempted to raise the interrupt on a higher vector than the
highest configured for the device by the guest driver.

It turns out the XHCI spec (Implementation Note in section 4.17,
"Interrupters") requires that the host controller signal the MSI
vector with the number computed by taking the interrupter number
modulo the number of enabled MSI vectors.

This change introduces that modulo calculation, fixing the
failed assertion and making the device work correctly in MSI mode
with macOS's XHCI driver.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---

v2:

 * Switch to modulo arithmetic for MSI vector number rather than dropping,
   as per spec.

 hw/usb/hcd-xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a039f5778a6..516e6909d20 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     }
 
     if (msi_enabled(pci_dev) && level) {
+        n %= msi_nr_vectors_allocated(pci_dev);
         msi_notify(pci_dev, n);
         return true;
     }
-- 
2.39.5 (Apple Git-154)



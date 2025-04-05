Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5483BC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u144E-00027P-5m; Sat, 05 Apr 2025 10:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u144B-00025z-SJ
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:00:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u144A-0002Q5-Ap
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:00:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22423adf751so29166275ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743861609; x=1744466409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jW/nGJ9nhfNLcuNss/qrb1rh1i7PJHIjmtAmxEwu2Mo=;
 b=brsuVotUTSwsJm+s60bWoXUB3LXQp4k6CWVbtHPHudgiaDFy6OpgfO+u283a28GL2p
 VblTQbexi0ezPo0tJEirKyqMtbPArDN6urD2Bs3roTP11V9BBmFNo6fMFXlwF3kVEFyT
 yARrDlvnvu9z67N+lz25sjax/bz1ddFQApk37y+YFQSiwZmb484+Jhqqll6aZaiz/5rK
 frHIMwbrQmQu/EQB+3MngNGXErP+jCudJZmli/aYFR5VPVHl1iCE83yHbJqeN45FO7eu
 JP+sblWcTQQcs2C4w+ItiNxgNFfNU4FkedoLlQcn2cT8HYuOfbGnBdvrxVgMj4/C4PVK
 k8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743861609; x=1744466409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jW/nGJ9nhfNLcuNss/qrb1rh1i7PJHIjmtAmxEwu2Mo=;
 b=Dy3Vrc88jHSvpT3IX1SDnUjvgGI52/AEpWXyRpBDyurWn0z2jF0jiKHXU1+oMuk1uZ
 wgFzJ/kIEuMifCuxHvCb0FArUdzxjCTqEUZSzeg2G3qlQgjdlAPFYa0yxR9p90wqSrQO
 HfoNveHwWtPW9zG+QqROjOJn5pHUmUOG6w1kmlHSnOKjquV9JSekIxDuu4P9zX58KXQD
 3AXj3vQOiU1EZ9uGeEePGj5datE9Qia9qaoQ1VVAPTQV1mWwBP91GJJVSG5qqjkseyIt
 VIZ7OIAXUj8KE2VF/an6PlYhuKbnndMxxPF61bFUQcDUS8Z/JCkJ+WxYcz3A3IMpysIw
 Ee7w==
X-Gm-Message-State: AOJu0Ywjpv99LK1cPdx1G7/03wIO6J+ba9pDwYCOGl/7otqTJn1onnm2
 MJjBOOd1f4Yo/VYD+YGB8j6nsXPaCSWD0TQQv9mXrGYeUU/FYyjzoZCc8g==
X-Gm-Gg: ASbGnctuEQ2RkqLWhlwMhsGkUq6tTPz84PHCalDGjJnpC44B1KEtebj7xiGbBw8tsf3
 oWSBuEmMEImjKEjM06IF47ozlrc030auHJRaPcHWigc519Pmhy/2OBMCo3uLCs1UPTrrKMJFFk2
 kZwi1LtbRQuflbUOIuXqeO4PfL2tdDXfBNvQh2qHDOWxgvANVbT6kErCTI0V88xwSRDvAY+635h
 osNn/CImfNlcWgN8TWIcm0ViP/nnqX5zbeZ3tLpN7FHEFxbkqZ34zou5pBfzc1pkxBXdRbGdGkh
 xi5OoU4+049IPXltlTcU2b+OfRJmXn3JvE0YqthtjWhSddWSLQiPHprrrur2gs2U3SPH
X-Google-Smtp-Source: AGHT+IFJM7vREFBQemnCKwWN0arbTRzkf9ObvimVT7hC6CaCeD8IFNt9TNwYi2Fq4lGcAQ3HZGvVdg==
X-Received: by 2002:a17:903:94e:b0:215:4a4e:9262 with SMTP id
 d9443c01a7336-22a8a04a780mr72777245ad.8.1743861608701; 
 Sat, 05 Apr 2025 07:00:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785bfea5sm50149875ad.54.2025.04.05.07.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:00:08 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] hw/usb/hcd-dwc3: Set erstba-hi-lo property
Date: Sat,  5 Apr 2025 07:00:02 -0700
Message-ID: <20250405140002.3537411-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250405140002.3537411-1-linux@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The dwc3 hardware requires the ERSTBA address to be written in
high-low order.

From information found in the Linux kernel:

[Synopsys]- The host controller was design to support ERST setting
during the RUN state. But since there is a limitation in controller
in supporting separate ERSTBA_HI and ERSTBA_LO programming,
It is supported when the ERSTBA is programmed in 64bit,
or in 32 bit mode ERSTBA_HI before ERSTBA_LO

[Synopsys]- The internal initialization of event ring fetches
the "Event Ring Segment Table Entry" based on the indication of
ERSTBA_LO written.

Inform the XHCI core to expect ERSTBA to be written in high-low order.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-dwc3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 0bceee2712..6783d55526 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -603,6 +603,7 @@ static void usb_dwc3_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *err = NULL;
 
+    qdev_prop_set_bit(DEVICE(&s->sysbus_xhci), "erstba-hi-lo", true);
     sysbus_realize(SYS_BUS_DEVICE(&s->sysbus_xhci), &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.45.2



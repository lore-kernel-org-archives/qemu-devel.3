Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C502C3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 19:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKMmr-0005JP-N2; Sun, 08 Dec 2024 14:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMml-0005Iw-NV
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:44 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKMmj-0001Vr-R1
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 14:17:43 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so669634766b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733685459; x=1734290259;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3BoSGB7P8OJJqEoTDM7+AVqy5XBZWcK8vMNoo4I1hk=;
 b=1Gl3W/s3JXNjoVatDL29lRWGP2JPG+O4N7zWNk340QQbipXeuQbr9WtRGpgRp23RvW
 qOP/VaQ+Q8Zye51IQAoOC7p+KwBRDSlK3XB3W36DPY6n0E4BhGdT9+L7vbbHLDlEDsZv
 uO+RHvHyw+N4TM9JBS1D93qknQTmRrpODW3lBhwy8voPDD0BBWmdDPEkyCAcSSBKetjS
 zQZMY0+OzKAE+SuB3t/i4xTm5fkGR+fXpTvB+A3stVb1FaIGESv9sdr6OjNBhrrkoT/C
 7EkWaLR2IqV585vkOVLmK0by/beOeaZFo+BIH2OZo2StO3AZnYxq0zeA2zGSf+p7Js+l
 C/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733685459; x=1734290259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3BoSGB7P8OJJqEoTDM7+AVqy5XBZWcK8vMNoo4I1hk=;
 b=LWBwkm8rNJ/CXVH2z4oWCQTcqTbjRUcpQ4+Wv+L3yN1GXqwjzLd5xeePMk7jB125HN
 UztRZ8vMrUJUrqhTd659ek3i1zZLK9z++spSgssPaEM0MCYa5wdbBmnK+r6Eck4+AJ1+
 8Co2QHoOcTscjG6YWD3sAmY3j9RMvs8Ku6AU8IeFYZd0htXLQ3PEHd5WYDiNWbjsiwVE
 hVvzvgKeT1e/A8qn7a9UF+lu/nDJ0gV0bIHlZJwoR5qUbEgHFcA4mj9DL8SX7QQH5w+U
 B4QXCqztM8SdKdVxE+oQhatiw5fOXTRIhXjwT6LVGTA7nWt3wDJotTXgVcNb8OMqLXLc
 frrg==
X-Gm-Message-State: AOJu0YxMt00LkTodXMwbK8AT4A0gBBTf7KyXkMtj5SVyhBV2AW4D5mAl
 ztbHog6tr4iBNE1sx+KhquwRmel/mcNYsnPvbuLDSLkL0Qj903e1v3SLgLO69XM0HRhR2MkXy+X
 eLw==
X-Gm-Gg: ASbGncuNG62vppSO4AMKG2bedSzXQ1DvVQDkJ+wOTc63166EAHUmDefH4PDbrFIbjyL
 GcR+UI7K0xmujQ+TryllDy5ooQe+PBcGcJFJ5hmE3WRIuYNNFa0egEQDl4T+iKbqA17CT2ML6/v
 zdnsB6gj+ZL1j7Tk7etsap1FLux7AW55xWoJxMJSdAB73c1LqCkZZ/F0JP8HVJuHRU0lRyuCiqE
 k7fvCJPO5ZnqKwlHLESFKNO6zafLO6ARcnlkH8lnJACLAtNyrw3uSRKH0pwZSGTX/sMhzjGRLZ6
 pA6N41KLs4cFlSsbcFk43v4sSg==
X-Google-Smtp-Source: AGHT+IHaYl5CqQoxB+CLjhFxgkNPtEow3xA0EplaiR3IpyclqIxYyKoLa+w2uJiFDLFVpAecQqzhbg==
X-Received: by 2002:a17:907:950f:b0:aa6:6ca2:b774 with SMTP id
 a640c23a62f3a-aa66ca2b86emr434968366b.6.1733685458900; 
 Sun, 08 Dec 2024 11:17:38 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa665119a06sm240350866b.121.2024.12.08.11.17.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 11:17:37 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 1/6] hw/usb/hcd-xhci-pci: Don't trigger MSI on higher vector
 than allocated
Date: Sun,  8 Dec 2024 20:16:41 +0100
Message-Id: <20241208191646.64857-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208191646.64857-1-phil@philjordan.eu>
References: <20241208191646.64857-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62d;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62d.google.com
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
attempted to raise the interrupt on a higher vector than the highest
configured for the device by the guest driver.

This change adds a check so the interrupt is dropped instead of crashing
the VM.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/hcd-xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a039f5778a6..376635e889b 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -73,7 +73,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
         return true;
     }
 
-    if (msi_enabled(pci_dev) && level) {
+    if (msi_enabled(pci_dev) && level && n < msi_nr_vectors_allocated(pci_dev)) {
         msi_notify(pci_dev, n);
         return true;
     }
-- 
2.39.5 (Apple Git-154)



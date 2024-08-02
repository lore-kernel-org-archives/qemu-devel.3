Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02F0C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7P-0000gw-Hd; Fri, 02 Aug 2024 02:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7O-0000cT-DU
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7N-0000ux-0X
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so63245215ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581424; x=1723186224;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p/xbyP1Am7mZb37ldbOaJNJuDRPmUAjsJzjuyi2y2fE=;
 b=FrwFPgl66Z6pS1y5+q3LNUYtWsGaoUYHAktUklxR0edxdcpV4b09AYsBnvqbUFSwFc
 apC/pkEjfsPZhabYm8ao+AEfpImUqgB79dOM7fpRbA3xtiijsAuTIm0Hth2uSHOO2ath
 ZP2i3D/Mc8XSvSXoTneDP55fmnZGplm+iMTT9OL+z2HvpUtdkm2hS8kXFmWbhN8OYkkz
 GU10jNWeN5CMEZiMbc3pdnUxeVGL5Nmg/kRKfe16P6hIco67uPG7e4ds9nYowyhhkmEq
 P1RTo7/yLxA+KmANkrLs3c+HqhnoKsMznzPVNfQxlUDwuWqbEn5+hSIxyTWe19T0cm3A
 iE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581424; x=1723186224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/xbyP1Am7mZb37ldbOaJNJuDRPmUAjsJzjuyi2y2fE=;
 b=l9rH1z8pGgxLDBoUu4DJshYU+BJwB6W0Uu81KBamPsxg0ByAUpM7zu7pJ2O0+wwGMR
 3Gwe5kp32kscdZfhOSU+F0/5GBeyiWMKu/XFUVH0iFDKvVf5ndOn3rjJrAMdJuImC9iE
 DHO4bUA+YF+cwI0h852rsHIcQmyi8jKMnxHcq9oUMkVDMgbpEdTvVlF9kWBFM0H2pMPq
 PJI9IinTNvW5oHdU5PtVazsu2QWTI67FxdNjgHZdGOsJP5qXjxKTZ6AJdL5rqwMQAAkt
 CF3QQDHOYk490+ckU5/KI2bsKXpVA8gPmxSxpbTDmKitBVdCbyvYnziVlvhvCjd57z2K
 kyWA==
X-Gm-Message-State: AOJu0Yzl7djOFfv3FptDDAnfP6+JaJX2aTwTo159QKfgYBFTwW+ifRXB
 8JrzO0KPHwZ24rfGtQ/wpEuOig5yENZ0pdAtFpqxtzs/VekH4S2yEVV3zhxGJw8=
X-Google-Smtp-Source: AGHT+IF4K/OW5vEQiPX+KgI0NvYOBhps/u8u1mGGK7gKTtlJPt1SaQCaqpv/gG9LvXmg6hnZ+opmDQ==
X-Received: by 2002:a17:902:ecd2:b0:1fd:64d2:62da with SMTP id
 d9443c01a7336-1ff572c4e13mr37040385ad.29.1722581423720; 
 Thu, 01 Aug 2024 23:50:23 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58f29f96sm9849195ad.1.2024.08.01.23.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:45 +0900
Subject: [PATCH for-9.2 v6 1/9] hw/pci: Do not add ROM BAR for SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-1-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A SR-IOV VF cannot have a ROM BAR.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d2eaf0c51dde..60b1747d60e6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2359,6 +2359,14 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        if (pdev->rom_bar > 0) {
+            error_setg(errp, "ROM BAR cannot be enabled for SR-IOV VF");
+        }
+
+        return;
+    }
+
     if (load_file || pdev->romsize == UINT32_MAX) {
         path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
         if (path == NULL) {

-- 
2.45.2



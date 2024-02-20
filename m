Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD2AC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPC4-0005Xy-FP; Tue, 20 Feb 2024 07:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPC1-0005Pe-PD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:49 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPC0-0006Jb-68
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:49 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-299e4b352cdso312190a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431947; x=1709036747;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9dP8CIVGa2z+MJbr16ngrSkEvcO51KPNeCuX2Tm5UMI=;
 b=bGWEY4+tMRQG+UiL7ZN31mgXcseCVlziJ0f++58MowsyMGnYTptpmgT4EsfNHs2GJ0
 AXJZEyz0I9JUN6hGi/EHTzvOWqW/q7h9AHuAxrwZhNQkFFdXH4DVKSRbVvOoPeq56LRd
 DQgyqbcctp//yvcIMlHWwKIQ92DPa0npUHoTcMicUH/tUppnx9PVQ78TQh6yE8sT3FPX
 wnE18k2mUTnG/5G56LCoSGgl3gagXBf7qtdMid/2Yr/3LcmsSy3W1xG4xR08cW7uq7kW
 50Ww/ukiCInDrdPTSDvamR0rRUZD+3RniACpyzfXFmcbKxEFEdn3xSOx76Tyzi9jHeIH
 xe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431947; x=1709036747;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dP8CIVGa2z+MJbr16ngrSkEvcO51KPNeCuX2Tm5UMI=;
 b=DJEYmuGpSr4xqYJQcii4fBD6Yk3U+yo6t0xD3fLXbVVqB31qjSrxJUIGEtsH5Sa1ay
 ZS44257VR3ll9TdS7SiwgePmPWAVE24OB91xsyrmqoEFwZT67928cPAxkKt31W007f2Q
 B7YqO5mYl2UiDzsaAqNbq7oELZzzPc4o2oB6c6gjcAppvoPz2okjg9Xslvl7s0j2CoQD
 QkDD9X/wd63c1GH3hLAbISsrVSRRnEOuts+3+Xcys6xs49MNTtybO0/wH19ca/mSNPvG
 i3QMw/cokW8FGn6T6L60cWQx2qKyCWOqt0g5pSJIN3hdM+q0CkQAOEYUx03PUKuEL+zw
 RYGw==
X-Gm-Message-State: AOJu0Yz3RemHcfL0SLAXXkYsT7qCpXRqi/vVItSM80WJqrgjYjeSK+wI
 mwytwE2+XxnNqpxKYkDI9pZC7wTQbI1ETfn990JTmP1GHCdhoPKhm5qoFEFzonY=
X-Google-Smtp-Source: AGHT+IGgAMZDhpBFFvxV3YmQXCoq5xY/wQk14+5bfR/GSY3DpBnAO6q69sKAuORmTilryIcuNVwiIg==
X-Received: by 2002:a17:90a:dd82:b0:299:5186:1989 with SMTP id
 l2-20020a17090add8200b0029951861989mr7202411pjv.37.1708431946771; 
 Tue, 20 Feb 2024 04:25:46 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 w3-20020a17090a528300b002990d91d31dsm7162833pjh.15.2024.02.20.04.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:25:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:48 +0900
Subject: [PATCH v6 13/15] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-13-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ca151325085d..c4fdc96ef50d 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != -1;
+}
+
 static inline void pci_set_power(PCIDevice *pci_dev, bool state)
 {
     /*

-- 
2.43.1



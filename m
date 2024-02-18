Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1218CC5475B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEa-0001QC-Dx; Sat, 17 Feb 2024 23:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEY-0001PR-I6
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:58 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEX-00045W-3d
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:58 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2995185dbbbso955639a91.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232216; x=1708837016;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0pI7/kgzAyUqVmg5oIUsMyi/X4fn9vaVlpf42x700uc=;
 b=yZcfDydcuUJCmCSrb1hFul6e2/dkZgmlcNj+SEIi9B/82fILNIaXM9WydxSBd6qjKC
 lqyclkYjpITbNK+YeYyGSwB02udCpx3hmTpNYmX+fDZkO2rnzyUSX0795I9+ko+UND6Z
 Uj8nbsEePsdHk0HKgaPrEI7aZm431WqXQ5Bt1orD9uV3c/VA3IwCoiXsvR20tvkjd1M8
 wo/3hInWr/sneHsDFCZMU7izTWxLsSX8AGckIjlH/hHkSsGVueUIqg6Lc83SWWDq6toE
 lQn7mDqgccjuTT3vAEuPv1Mdu937JT8+FNfyzJkr2azxL7DbJCjVmh8RA+WnROs8TWoJ
 bY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232216; x=1708837016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pI7/kgzAyUqVmg5oIUsMyi/X4fn9vaVlpf42x700uc=;
 b=ZVNdrvCZRfclnsB1rQKgzyGirGRFAvc2h58YktSVIKti9p+FNPOZo4/TloJIpoTpru
 /XoNBJCdurcRcBeiZ33SlejhHbuObQbPzLPxGiNHaJsVTP1NiwGVIlmIrdyPSgEkF9jO
 M2BPFqSiNejbnyHn4iN+kV1ccdhCmtumtWfn9j5Q2nKagO9EPrNAfPhkGGTtRdpL7xVq
 mH7kwZ17kDggJRaHldNqln4iU+2prag8cKdQHcv24KUDSO1eBc5xz6FXq8EsqMOa+b2u
 EtBqthVnfcYYU7FORgUZjrOtR/1OWPmK0ro7qXNBlPm8xmlW2jQpwmVf4obD3AhElLu7
 FUKA==
X-Gm-Message-State: AOJu0YwY1WLPz1KyYsHLCXqvVlUOZvcHujXta2hXCmyyBUw9Ig+hNXwm
 qB8AkPyl72LUJ+PTRI9DQnPdp6wR5sfKaBaLXWVSGIDooQTYxTNd/9leFMMcmzY=
X-Google-Smtp-Source: AGHT+IEaExf+BkjnkyXkRywq0dPw1dg6kMWucDIcpKPmzB1kZPWB0qUXb2DBecP0OwLjPVPd9pQCAw==
X-Received: by 2002:a17:90b:3911:b0:299:3bf6:f2eb with SMTP id
 ob17-20020a17090b391100b002993bf6f2ebmr4565244pjb.5.1708232215876; 
 Sat, 17 Feb 2024 20:56:55 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 cx3-20020a17090afd8300b0029951d04dc4sm2260748pjb.54.2024.02.17.20.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:56:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:09 +0900
Subject: [PATCH v5 04/11] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-4-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b273..54fa0676abf1 100644
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
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */

-- 
2.43.1



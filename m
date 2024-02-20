Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07045C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPCF-00068y-0C; Tue, 20 Feb 2024 07:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPC6-0005mk-ES
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:54 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPC4-0006KC-Nf
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:54 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso4038382b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431951; x=1709036751;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKib9lFhkqfQp/XBira3ThQ631U3FRHMXLPB53AQUH4=;
 b=idJRrDQUmEmzigJ2pZDBG+8ZKm7mXs3/c17eUnJXAqq8qKhhd70LCfZaMRW5Gf3Id1
 zDhvPm28CiBUyKNSFdLCObmKxyLxKJNd52aJhrSJDKFLp+lnnM8YUIw4f8txwQp1cNbs
 SfoXRT8eimV7iVc8oPutL7U5Yp95DOdtT8x9a60f31m2GjCtb1nyjdlvoHvn2uJD2qUP
 4yCWN6CkhF04Yzxun3992Nagn2+4N1JZuLC05Ny0+/jmihaScDAd8lmp/ND9sCJ+Icd1
 ZnwZT6RIxfaDmASr/o0wmWGsUwHZULLeRhbHBIuWzFJSYpIyiQZbCmcPACIGlDwgelvT
 kJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431951; x=1709036751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKib9lFhkqfQp/XBira3ThQ631U3FRHMXLPB53AQUH4=;
 b=QAHQWLwr31O//2aMCzFIBo6JowTCncXKPxshXa9WRd8I5cY0wfQYXB1w52UyCccbJT
 dvmiX5FFbHA8mrL5m15q6Qh32AucO284dzoV+Kk6fOw+uT9o+0Ko6/wswJTq23C7Lg+k
 OYMNsEl6kQrhbepJD5ETh7W4JOZ03n5elXnid4GwnTdADvoSPPyPXIEFVPLdeKcLxO5g
 6RXKJT9naeOyqMc9MwYyOFl7B/aqPvjXWTvleIDpiLZQGakRUD1/bNbgMDg0qmUZb8N+
 Tj+/K7comTnGPei7tc0bbaLAeZxDKlK1apQEkylKym1Zc1it5fdx4PcVms1jJd0LUCLN
 4U3g==
X-Gm-Message-State: AOJu0YyWXnjp3ei2tJeLGFSjjAu3T9TbCP5ALquvsvxdpXj2hZehtsrs
 B/I4m2llQH1853U+qMbdWqhOsOUYScAMRUMXcJUkHlSY8Pv1aTpucEGEcyvzsUg=
X-Google-Smtp-Source: AGHT+IGHQhWt3hQOOgyuN4ZRBDyOXrUpLWwspMDvTvjtlvwEBQnGA6qrrY4yNCH3q4q8MGk1ZK3ghw==
X-Received: by 2002:a05:6a00:7295:b0:6e1:29ee:aae8 with SMTP id
 ll21-20020a056a00729500b006e129eeaae8mr10793993pfb.25.1708431951444; 
 Tue, 20 Feb 2024 04:25:51 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 r12-20020aa78b8c000000b006e3a9bdeb99sm5471510pfd.40.2024.02.20.04.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:25:51 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:49 +0900
Subject: [PATCH v6 14/15] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-14-2e42a28b0cf2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f0430d..647f15b2a060 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1046,7 +1045,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.1



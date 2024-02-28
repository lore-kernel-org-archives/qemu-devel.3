Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6183DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICL-0000ls-39; Wed, 28 Feb 2024 06:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICJ-0000lE-GO
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:03 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIC6-00079R-DF
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:03 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so4384448b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120029; x=1709724829;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H8o4sAtnRR5uX1iMzz8pEZTUAdiHV73SVw/pyfxc/jI=;
 b=qOcKG4p0PYDRpomqpOfQ+IZcyeGVpLaVeS7MzGR0eWk0HMhs3MVr7C9iaSaVr14dTi
 fomTRLktpMDVcL7C01WES/+QyVL1NqIIkgTXrJkBSWBw5VLjXJoQYfxkbO1g/8Yh9ICa
 qDqI1AhAeoNXCpbjDPPt+9dzxp1qhzZEp+1matJg80ahfnyRQfXyfSsaeXXTh+B9OW00
 m2CTIXl2ABDFN2b7UjEaavsh+iUWQL6oVk4v3Swhs3xjdG2bfs20XMxG2IDNzftVZAI9
 cs/IayyimWVeHRx1p9CuWuvo87fRUBqgb3aXhAPt2FIQnLTvAcK4SuR2ajd93fxXTdOR
 RAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120029; x=1709724829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8o4sAtnRR5uX1iMzz8pEZTUAdiHV73SVw/pyfxc/jI=;
 b=QyVjjGZVNPKn8bl/SuxkmqL9GZiv3PVsQ8p78bTO/cyHfJLx7N1CHgNslr4l9pjyvQ
 TEp45PSj8XcxmfwS9iJ8RSIj2xIZFde88yvN0fVfJcwU/aN8mnsHdbGFTsQt+zIHWvYy
 hCT8JNAOiPDXxp2EpBVeTX5fAoNq9RMI8OrbBhCsXhMoch/Q5egwFUdUVdNULUYe79Qm
 bAAB2ptUUyPwp7aSMRgMA0J7JuI+wUyeLLYVnDKAqU1grN0JakyEh6TYVmznbPix6JQA
 6ervGdEdxvjUFiAYwBPllQ/NjRsXk8sodQpbOsfK/snOqA5kXaQavRXyv4Pa2HJ+iAZM
 rooQ==
X-Gm-Message-State: AOJu0Yy8Qm9LKj5/RRgKJrCR3Q5wvXon8PuU/qdZ/Nlfx0zrQ1vyELmV
 RSCxM58Tty0zVIYDycHX4wGu7wucrlyvNsbegG1JnnNYYvoed7co0mDV3bB0ktQ=
X-Google-Smtp-Source: AGHT+IEVe2izAXn/PZVy96z14kgzilPuHyuFHoOLjXs8Hu/KR1x8qPSIyvBTovMk1Mj/DEa/WmTVMA==
X-Received: by 2002:aa7:8814:0:b0:6e5:6589:f949 with SMTP id
 c20-20020aa78814000000b006e56589f949mr1051234pfo.1.1709120028762; 
 Wed, 28 Feb 2024 03:33:48 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 r3-20020aa78443000000b006e4f1e6f145sm7642378pfn.33.2024.02.28.03.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:33:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:15 +0900
Subject: [PATCH v8 04/15] pcie_sriov: Do not reset NumVFs after disabling VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-4-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
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

The spec does not NumVFs is reset after disabling VFs except when
resetting the PF. Clearing it is guest visible and out of spec, even
though Linux doesn't rely on this value being preserved, so we never
noticed.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 51b66d1bb342..e9b23221d713 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -215,7 +215,6 @@ static void unregister_vfs(PCIDevice *dev)
     g_free(dev->exp.sriov_pf.vf);
     dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
-    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -260,6 +259,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
     unregister_vfs(dev);
 
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+
     /*
      * Default is to use 4K pages, software can modify it
      * to any of the supported bits

-- 
2.43.2



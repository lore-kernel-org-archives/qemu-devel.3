Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6380EC52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7d-0001fn-RA; Fri, 02 Aug 2024 02:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7c-0001Zi-JJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7b-0000x1-5M
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7a2123e9ad5so1988952a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581438; x=1723186238;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eIrCsb1ntTQZ4u2QiCIc/D2bj4QGskaeiB3kw7Zorrg=;
 b=wrIJkb77fV18QDf5DtFAoE8uznHpY3dOyWm12Zkx2c455DTeSzvj9f+A1eEIyDQCzC
 gsmSC5DAznkvbIP1GaQh2s5/UHkCW0GTVv7DxvJHKBnNuhns0AEjiCkVBjowL/fvv2Jf
 C0wqwBgk45YARvEe6pijBx1RTwI0vs9LkRrx2eOzTTWOjpb+8oFQdUZL/dYXVqny1N9W
 m0qivEpKS7HWAjKccQNHVs5vAYsaZjX4LLwlXYLR2t7VJYy5h9/KY3WmMQpDHD+rrdjE
 TlVM4Xw95+qLti5yqEcim2+eTc9M997Y079BEQVAWGijSbUXVgT6Mp6PGoTfbCAu01Dk
 hwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581438; x=1723186238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIrCsb1ntTQZ4u2QiCIc/D2bj4QGskaeiB3kw7Zorrg=;
 b=UNdEKUE9Q22ZBnZzF7Aq+rAz5dVeYooCNvSxyqXMvobImoskm+Sx+KGoj/Heq82YBL
 LCBGyTexztylhc7YubFDetSJ25KprqKVqtmpbe8XmWhEINiv9IXXHGyEgAIigflaPneT
 Kq7VadFDlsAYu73LAc7L+LPnCGkNIm6lUlhiqrkhNy3SBLaeIyyZlgU3vT4GVypF/rXA
 tiLpkgr6XskMAX9bKNgm1dkAvmAHcy5hE9vmVvygzG5B/m5YjMNNFf0EyDIZFTq9uTnn
 OvBXlTZG51unG9p1CHjadT8XFWqNk5wkfQuGR+SWwA97kHUEBEzgfg8IqL0mkZ007nkP
 MAHw==
X-Gm-Message-State: AOJu0Yw1SJFQ1p0mL0T1V1mvkxyF20ZgfawSYCJOPlpTczrmUGEeS9Ci
 MhmwdKtPtuifmDEUoJfxxeRz21VIP17bbo5EgKS+USGDrATPJ4Et6/Cpr+JzcPA=
X-Google-Smtp-Source: AGHT+IEft9ZxxwTiurDIjItlQ1rzd+ViC1S7qUUBS0dXQB1N27yx6aJgikarHd3qTbPwcMKLTK6/mw==
X-Received: by 2002:a05:6a21:32a4:b0:1c0:f09c:1b98 with SMTP id
 adf61e73a8af0-1c69434da17mr6864668637.16.1722581437947; 
 Thu, 01 Aug 2024 23:50:37 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7b830f296d4sm99471a12.68.2024.08.01.23.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:48 +0900
Subject: [PATCH for-9.2 v6 4/9] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-4-0c8ff49c4276@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index ec8fc0757b92..3af0cc7d560a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
         return false;

-- 
2.45.2



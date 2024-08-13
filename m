Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62980C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdl9y-0006e1-JK; Tue, 13 Aug 2024 02:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9w-0006Ts-2d
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:32 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdl9t-0006Qh-Fv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ff67158052so32851905ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531048; x=1724135848;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vA26nEU65dtwvWJQIJNPD+i6nbzwt/Hl37bWV6eE0XI=;
 b=O/Nd1IcrHMkzaYNfjMjaqsSps+7yBjK+7igfeNnCQwl8IbzisIhQgcRYRYuj6cp2el
 ETjXD7mbox1JDgTqRpsg93VYSV6UbVDQcBRp1yERKDKXaZYes536NdoSoygVfFnow9H8
 TwGiP50fD0EI9Xwbu+HhkFu+ZU5kB8fJWoidZ+C2dpACUabvpmfZSZO9Dw4i04953RHn
 5aRGb7bOCc6AgT9OR6ZZA5CT5eAI1c8wfgqQj8kiVgnoxO68jcTKZvPj4cm7RuU0FRLt
 gEosAgG1bn2gqaoBLa8bNJpCLmcyw+5Y1ZYlR6oUT55tOnAH2cRlXuoD3bmvoaIhXr1Z
 9LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531048; x=1724135848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vA26nEU65dtwvWJQIJNPD+i6nbzwt/Hl37bWV6eE0XI=;
 b=Ow+jkNkwPX1PyKZHguziaq4OzX4Zke1w/K935gtbXHux8gADQj7N17DcUOsyNWzy7A
 oQQGGTsso269PvZ2OrTjLme2Xr5pRa444qwr3qxhh/EXFOTqG4KQVU+HKCYyScmWaYFw
 Gd+3BIPHHLWee9u88UzYY5PbGorzZpQqsV3Bs8/PBdKMz9NhOgl8VhTvFEktTf/hvmFF
 GwG9sDE1YY0U3sTyuVpVLVPUPPHE4tFYdQtVIRHwrTQVP2X+9ZKNG8/1ZJ6RGQOObst/
 NDwHu0zEXnV3cttgtsUBn1BJ4OmEhyOEkN4/ig2BblFSxjW7Eiok3Fz1X69rV847jMvR
 3M5g==
X-Gm-Message-State: AOJu0Yz3s16Om3MJ2BjFn/0MA0M7X14+NwHxXbPbWZJVk23TG2/CjqzX
 OOP44Fl9YlVgMCSbXmy4sG1sV7+tj608wkaC/jDC1WIBkiDL0K97KmR5fcvc0yM=
X-Google-Smtp-Source: AGHT+IF3zbsteBl/roY0i9ig54NZa83VT030hPoJA9+VEYyaQhCYX8aLn34bWM95k6bRMMAxt3QTdw==
X-Received: by 2002:a17:902:f651:b0:1fc:4763:445c with SMTP id
 d9443c01a7336-201ca175c46mr29679955ad.32.1723531048182; 
 Mon, 12 Aug 2024 23:37:28 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201cd1a9215sm6609885ad.153.2024.08.12.23.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:03 +0900
Subject: [PATCH for-9.2 v7 4/9] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-4-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e1b4ecf79ff9..2daea6ecdb6a 100644
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
2.46.0



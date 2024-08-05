Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D7FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauVM-0003s5-Nl; Mon, 05 Aug 2024 05:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVL-0003qA-Se
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVJ-0001IP-Uv
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:51 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7163489149eso7335091a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722851988; x=1723456788;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=PR4hW9QPK0dzYJTjZYV6le8ybfVCM3qyW8m39wXtU7hPSXWjd6YkhIlDwofzromvf8
 qolASZeGsKiSgfadai9jdIO6kADT4QNbGGJW6YA8muA2KacyjefEVJo7yE4WGS+8V2Dc
 fRXKSFz4PJDLtHlzN5CKlEi+R32KWCfqX8crJEvFJTFaLnXGGRGoK/ngS60WGPQRoTMg
 vhHADDjLKMuzMeyI2GubbPGtq/o8L72mGPoZoC0sprHth9RFhkGEEvSgo9GLjxx537mt
 75MY3l6mwh6EIb/Ue3UQSkAxOp98MJoUhwhwUbvUg1Lrqat2jhJcJ/0CFvdbZwWwtnKm
 6igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722851988; x=1723456788;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=FzLyH4tG79OuP3QPjWyROEtq9V+rhLX1XCZt+OcbJY3QQ4po9P4Va90/BhioFgQ3cj
 4rNUZFgXWQ/Zl5tRwHQgwP3lb4RgimmVjdsrS1nNBFyylYUbO0tPThQgf+DPlTF9z8qO
 PtnSsTCOTEWjxOaE6bCePSWwcdAquPRW629cZvu+8s7B3KBldyNtE5RDtvy+ka0x+srI
 dxnrvMXBqRbWvkxH/p1xb+YluWjX+jmoGUPzx+hhmo6JGdAECY54owpPn3kQP04im+xR
 lZUiahdtAi/j6GSRPVOqc0lmVWDcG7IRUVP4wbOt651ByU0rFIgXcLMWWiuoklBAZSYQ
 8YYQ==
X-Gm-Message-State: AOJu0Yz9H9WRgIY1ex+1u025DEDZ8gXole+C54WE/3JuPS+CPxEwA/GX
 tSjOFgKbFhh99aeVdz4r+4nN9VHMG51z0/++pHeJ2/v3lNH1ZS3kjMm/Z1RZBJE=
X-Google-Smtp-Source: AGHT+IGGBZglPco7tYVVxnP+o2Oc+ABIwTtZHlRnXSY1Jbw+66g391+XRrGjB6ZfjoDLSCMYNYDCOw==
X-Received: by 2002:a17:90b:489:b0:2c9:6a2d:b116 with SMTP id
 98e67ed59e1d1-2cff940e469mr13438243a91.7.1722851987778; 
 Mon, 05 Aug 2024 02:59:47 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cffb091391sm6585975a91.18.2024.08.05.02.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 02:59:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:59:02 +0900
Subject: [PATCH for-9.2 v13 05/12] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-reuse-v13-5-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
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
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.45.2



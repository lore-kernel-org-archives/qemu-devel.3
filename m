Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19EBC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJ3-0003yQ-I6; Thu, 27 Jun 2024 02:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJ2-0003xz-Eh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:28 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJ0-0003bZ-W0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:28 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so29596815ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468505; x=1720073305;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=w1S50KSFP9g1ltdyvN/34SceYZF4xL8mRfL/yAvIy0rqC6Qn7mEW/ks0vYPHsdBlNN
 mHP0yvRBhuQc3bG3+gHnH14aeehwfmY5FZcaRcJTvZARQ12zTb8XSOAwMsSb1Bm9RwqM
 IyOG0q1tStuQAmv4BOci6ldmrRkXoa7ZkD5PC6Ud0ITSFalBiPS0UxSmZLPjX35VAiqu
 wHtjEogQVbI4nLNU+tqpxsOHfOBsAwkOH/BV9s7i/gz2eajEEt6K6TZG9fLh3SIAztnt
 8g4kkIRyi1+nNiQxhrFpSpfzN4DSTCa6Autn9yRmnsPfjOiLpk/gyirT6Aq7TQGJ4VpZ
 EFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468505; x=1720073305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=cGazrR7G2GHaTb/9tLtYVvgK53daN9JVVvJlbYns0EU+WnDiGt4PxmQr+wJMDzR7Oo
 63WD+9omlGqayFozchDdfJXTixxpSr68L2Ti0FBbLltpQpbuHR22lGohYwgfNraM7eQg
 vuWwQVdz18L/jVUH1skUDkTCLDbEUauYnTz1C80zs4rUeVJ/xmtEIK/dgPUqCs4M01Ci
 MkNPpkyR33yUx3z1eiMVpMOA4CI+mPoPxtVZYCAI+ySlS8oSMGf00VhtzRyF3DSKZtzc
 Fqm9CATdIZmdxKtyTl+ZnqW5D8pdPMf/pHx1zM2tou0Z4IvOmN+Mxfq/t6KT7Ybps5vp
 YCOA==
X-Gm-Message-State: AOJu0YxJvx8W5imZJpqpc78XXQ0VYeHqogCGkxXFd9zY7hcg+nnHYlQz
 KI6NCX0jfVZVGaqOmg+2pBtlHa8zHoS6xDjbHgfxJ/7SOM38dU0VdetfSAyjl6w=
X-Google-Smtp-Source: AGHT+IGwJu8qd+uRUCn2mE2e083V1HdfaO4tlHugAaXCi4wOZnVayrKt2Jve4ZaMna8rdv0BpoV0qQ==
X-Received: by 2002:a17:902:d4c7:b0:1fa:128c:4315 with SMTP id
 d9443c01a7336-1fa15937ac6mr141750235ad.44.1719468505589; 
 Wed, 26 Jun 2024 23:08:25 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9a8b39sm4883335ad.260.2024.06.26.23.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:08:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:07:51 +0900
Subject: [PATCH v10 02/12] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-reuse-v10-2-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c3546..f63182a03c41 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;

-- 
2.45.2



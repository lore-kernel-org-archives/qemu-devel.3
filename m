Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56D3C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLkw-0008EU-AZ; Thu, 16 Jan 2025 04:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkt-0008D0-UV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:36 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkr-0000yd-KV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:34 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216401de828so10174635ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018092; x=1737622892;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DRA5SFwLixA5p1Smgb33TcMmhiFuTV2U9nSiZzVSvuY=;
 b=uwRqMMAObu1sRfRrFetslPhuiRXIKONPlBaF2HE5fmA3v+51VxXK/b3QDncOgnCNv0
 gtk1WhQSDNllB8ezzJI2eeD78ucaytKIujFAY1KkPWjjY49CepxeNpDBx8fYb8bQ03RA
 1vimK0ZcDBi6YAQ8S9mb2nVMyTq8RBquMAftWuB+Eyj4sVGp3J+tX0myMIp2wYOxWEUH
 YXqpKCz98ZLYRNopKCKnzxgRxSPTJb+bR0qu0VpJzEC3+oNz1M3bwNOEO96drRZeAuay
 hHhLUeNUV2VHw98O9tL7vkFtWn4SKJ7TMmTwGG+GXuUK7yTp4/kAKjDyPVEvyFOnvbsF
 YDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018092; x=1737622892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRA5SFwLixA5p1Smgb33TcMmhiFuTV2U9nSiZzVSvuY=;
 b=GE7RXQuvvy35ZiJ+E6HKbzA6eJp8aFOtFdO0pFPDq1+1zEMZe8V3vg4mz2nDqL2Vf7
 rYMGMPFRkZZVcof9un6omQ6UiP0YbagQa04/2+vXvjP1dgxeM7skSzy7R6jzqGI+jJN9
 rMEjRnQtyt9HVyfBb3qZl8eSCfDrD0LTPfVeGGtp06n+sGCC7H5BKik4LpzAUrUoOaDf
 kvtIpK+CG+cC92W+bM2XQkzeUaLMseuF9lxNT/AcYZf65/2cMO/ewggOvTiFQMgCoqIq
 RN7JcQdvUGNlhCHRhDjxPgj07ws2h348Oe98ToetJBINPC65w5bMOPk8wxsGa7JEjQWv
 FSKg==
X-Gm-Message-State: AOJu0YwT2obDYPdfHRDlxHJOZgmuizCndKiuTZTP3krPRBEPY+jOtaNE
 Do3NAyF48AYDb+Sl1M2S/GYJ+U918/lKb6qPfVuhWYI6HPVKyLeS0Zu0ZJ0D8Gs=
X-Gm-Gg: ASbGncuCcvuUjQ/43iVAFZ156TLoRL7BINHAx4MvWwvbnRmepm2p3sWZDjxsdFHr8li
 DnRRRyo7cEJxiytTrjDR4Lt5gD0F1tocd9OALbTBS/FVsxBMGs6gG3EcAa7Ww5XKG7Hqj8+TVES
 8jUwk3Ywa3s4wbmJ+15EO+50RC8tCG+2lyAgi0tlAtH7xUkcQGScR9RuwFuizOxxs/dlOcvhgnP
 KUfQFCXUOBJAwbMxtqBX6fVsR694ClKDaEPKVPG2DE3OA+mg4fPhjRAHbk=
X-Google-Smtp-Source: AGHT+IGwjFHIumorJESs2nD0w2N9f+l+Zrk10upKap9bHGTZP5j6JnrfIhCt3yFMddMMbqshDc+VrA==
X-Received: by 2002:a05:6a00:e8e:b0:725:460e:6bc0 with SMTP id
 d2e1a72fcca58-72d21df408dmr45816315b3a.0.1737018092233; 
 Thu, 16 Jan 2025 01:01:32 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d4065c3b4sm10471136b3a.112.2025.01.16.01.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:54 +0900
Subject: [PATCH v20 03/11] s390x/pci: Avoid creating zpci for VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-3-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VFs are automatically created by PF, and creating zpci for them will
result in unexpected usage of fids. Currently QEMU does not support
multifunction for s390x so we don't need zpci for VFs anyway.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eead269cc285..8c5eb69f7d76 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pbdev = s390_pci_find_dev_by_target(s, dev->id);
         if (!pbdev) {
+            /*
+             * VFs are automatically created by PF, and creating zpci for them
+             * will result in unexpected usage of fids. Currently QEMU does not
+             * support multifunction for s390x so we don't need zpci for VFs
+             * anyway.
+             */
+            if (pci_is_vf(pdev)) {
+                return;
+            }
+
             pbdev = s390_pci_device_new(s, dev->id, errp);
             if (!pbdev) {
                 return;
@@ -1167,7 +1177,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         int32_t devfn;
 
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            g_assert(pci_is_vf(pci_dev));
+            return;
+        }
 
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
@@ -1206,7 +1219,11 @@ static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
          * we've checked the PCI device already (to prevent endless recursion).
          */
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            g_assert(pci_is_vf(PCI_DEVICE(dev)));
+            return;
+        }
+
         pbdev->pci_unplug_request_processed = true;
         qdev_unplug(DEVICE(pbdev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {

-- 
2.47.1



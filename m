Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED20E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm45-00011C-Cr; Thu, 09 Jan 2025 01:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3z-0000xz-Iv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:40 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3y-0003iS-10
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:39 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ee67e9287fso987344a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404237; x=1737009037;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DRA5SFwLixA5p1Smgb33TcMmhiFuTV2U9nSiZzVSvuY=;
 b=lPyBmI/BkRcGJjlvSPBsoQm9SuYD4YQqcwGAlcpFkVQD4zyni9lARP1kwdgwzumHcz
 aZT2VoGAxoPCzr//T1lJiJ6t+63wOLtalY7FagsiQXPxehye/6CzK0k9DGEaJglbsgIs
 t6jTcPscIZ2xaFaaCBebZQ/+HUAFE3tigeAhCFUMzmCPOiOcJFKtKXlQpH/+fFPU3Dvq
 BTlUpZgO6abyK526qwd8E7SEjmvMH2Wc66zPteieeRW7qHwC+xA0U5ya5WQuIIl5J5Sa
 Hg4r971qzJnLoHqKyNF66OrN3vVKQvt5BsIvYsbCcawcDRa7Um/D2IBH/GmtgFeUDdxK
 zYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404237; x=1737009037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRA5SFwLixA5p1Smgb33TcMmhiFuTV2U9nSiZzVSvuY=;
 b=D624EDHsXU3wnpKBTJXd9EXhZpdsMIaTuEO3xIL56RoN9n3ZgwwNRTZqn2nxOWq8G9
 pLVdQCrCXBbNIgJPaVZeR3/Hr+FS6tbHIC+mS3ey3uTrFNGAglfNBENX2QcJovFE+uv5
 LRcyC6vwpV6jQncywgG4glSZ5DiSieiEUuxq/9h4B6A0cgS6EsBcVpSZqsYHqG//Phr+
 09pgl1Y0lPR2OewUBvCtWGwNkO0Fl3M176BQN77oxq2U1WOJUQSJmABBwj5Tpym5U/Fu
 FAlQzjsTmNH92RpEN0ciiZwXteOor8Zi5fUke60DyWF04r0Fg/fwpHYGtsx+UUhfH6sg
 0HDw==
X-Gm-Message-State: AOJu0Yz5NlKI0vce11fnt4ZTYE0YztbZ9uELz3aER29F08tB9tFApOLK
 CRFlBb0Z/LdKzXAE3oIUeOQdFQfrqfpQoMLfyWXdFltPcCdrqx8pZhpWepoam5o=
X-Gm-Gg: ASbGncu/HxXO6voWV6nioXhlOmqVbtG7ZdYfwj3U/gVkArAk47pr3pTwdLL0dHg6FSL
 Kh4lJh9rsZOSFfYwRKHNsCktXw7g78jJRzsVyexjsP3a22FFZODQkvX/EZm+dI3j09Tuv10iZ4l
 BzhjPuTzMY67A198ZLPhXpw7vX/9WiQSRw6hWgu3qvYSqBKdKPmtA/T8wvOVf/CVuLHxKx8vHer
 t38ns7rOTMyN9XOjYP4UDTsY3wWyAvZhAQEgUH5uEoeikaOFg/Us7RCfWA=
X-Google-Smtp-Source: AGHT+IGJ1b31ammQd8jufl11w6CQ/Pv4K0pc8vItIOKueEFTB34McA38BzCkpJLJeDzBbM6Anl8kvQ==
X-Received: by 2002:a17:90b:2b8e:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2f548eceae7mr7950115a91.19.1736404236661; 
 Wed, 08 Jan 2025 22:30:36 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f54a34e44bsm2774676a91.36.2025.01.08.22.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:49 +0900
Subject: [PATCH v19 04/14] s390x/pci: Avoid creating zpci for VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-4-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



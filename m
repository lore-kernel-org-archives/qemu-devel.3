Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E11DD1CDB8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AOY-0002QB-EY; Tue, 22 Oct 2024 04:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOX-0002MK-1E
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOV-0001WT-F5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so3580772b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586254; x=1730191054;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pQrvciCkOy/A/+YwEeHddo6lMPRDDT6kedSZ2jSFXsU=;
 b=xqSXI0DPIBNS0p69XFgBGJTdaE2Rxm0oNJ21vS+AZfTea1akXEqiVsc2lyW5psvMRq
 9jHh0PyIgZ1oK+Ha6RkAMtJY8f81NVY5IQWjVVdAnTH2KM7gDMOmOA/UwvrRUuxk02Bj
 wvOA7na+YKT06RhEnwHp48o4MQeGdY6IbGDtOy7Ut8sIYwh8H4t70fuAfwI3Wb9pH8bM
 Q5ZGUZ2XTw0X5lsGlc0yiM3Y1hmaDk1HqUpx6qnN5CTbDB4t64mgO/455/w80h0U57MJ
 7uJZkDcKkng7xn2pexto2qvR5i1v/S2crpFUlo9lP3TRkworFjoDfF8Sb88UItCfdQNg
 Pf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586254; x=1730191054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQrvciCkOy/A/+YwEeHddo6lMPRDDT6kedSZ2jSFXsU=;
 b=EVh26zxgjtxM50cGml3ZTIpkghSJPMR/jp2XMo65Dlf0LevmmfEXHh07OfU58mLxKV
 tjQ5U/aLN+PsTN/CcwkrfkPYH2Sb/WlxWmJ+LpRtWaaAQImjfmLdQweU0PQCwElplcxZ
 ZoaXesntcBBTtysJMAVrZ8MumllCPIMk2lpQGqQNkkmLvAYNB72OwvqXlQfmHlKHsmHb
 IRsodlgs0sj6+1bxZuQfkhPtOaEhgWAMEPXwZff7KQtcUZuUfw9/tYwxBD/dfnV48UI3
 VTrQRcmF8PuDl3JkxRPkjdgGTlv25Dp/J2OuEGJV2NCZZzQVGzxinysPu9cm80/SUTNn
 jU2Q==
X-Gm-Message-State: AOJu0Yy/C/aMU3KCs9LJ+ruYLdZniXyRAgmfZCWoFJAm2Ui1y+4V4Bwv
 7yOUFq97tLC+EpN3zQSx0+sD4i/3eDEWqrlZDMNcS/l5eB4THJkxwBjkJ1SUgiA=
X-Google-Smtp-Source: AGHT+IGpVTD1gdTeN+CdtmR6/XTR1DqijmSuZ5/IxSVrEsMDuoevd62Zquycx/1nf0YPhpUUBhs1tQ==
X-Received: by 2002:a05:6a00:928a:b0:71e:722b:ae1d with SMTP id
 d2e1a72fcca58-71ea3399b49mr19666465b3a.25.1729586253856; 
 Tue, 22 Oct 2024 01:37:33 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71ec13d754fsm4202596b3a.107.2024.10.22.01.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:43 +0900
Subject: [PATCH v17 06/14] s390x/pci: Check for multifunction after device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-6-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

The SR-IOV PFs set the multifunction bit during device realization so
check them after that. There is no functional change because we
explicitly ignore the multifunction bit for SR-IOV devices.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 0c8866f8298d..6ad47f4fbebe 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -971,21 +971,7 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     "this device");
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        PCIDevice *pdev = PCI_DEVICE(dev);
-
-        /*
-         * Multifunction is not supported due to the lack of CLP. However,
-         * do not check for multifunction capability for SR-IOV devices because
-         * SR-IOV devices automatically add the multifunction capability whether
-         * the user intends to use the functions other than the PF.
-         */
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
-            !pdev->exp.sriov_cap) {
-            error_setg(errp, "multifunction not supported in s390");
-            return;
-        }
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
 
         if (!s390_pci_alloc_idx(s, pbdev)) {
@@ -1076,6 +1062,18 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
+        /*
+         * Multifunction is not supported due to the lack of CLP. However,
+         * do not check for multifunction capability for SR-IOV devices because
+         * SR-IOV devices automatically add the multifunction capability whether
+         * the user intends to use the functions other than the PF.
+         */
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
+            !pdev->exp.sriov_cap) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+
         if (!dev->id) {
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */

-- 
2.47.0



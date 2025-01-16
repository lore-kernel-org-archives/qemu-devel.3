Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A044C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLlF-0008LH-1V; Thu, 16 Jan 2025 04:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLl8-0008JE-AY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:52 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLl6-00010L-PF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:50 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2165448243fso14344495ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018107; x=1737622907;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZwhofAKjVKmkEhd1Cibtf+dlD6/Lpkqp1XwfNb60dic=;
 b=Tk4oVll6PbE2acK5VFREbn27T/mPZna8tq8eAhy3uLb/JdBbmpHmmo4yhnKNhQh0lC
 efn7ZsRbHxhOxIcQqLg2NhwlorQ6/cnxhfFdbtZZ3bjl7CtDUepOOkmPg8iGA4ZvVB3b
 DlmQcYwtNRJWDP/J9vgjEDkk/lgOeBWyQNqpI648FHtftDHX0DPudT2gBAgM3mG2qrpJ
 m4IJwyT5Pg5McTHNcPeE4tUu/hK71DFcAs+5Ince8pxls7Dvek31wbDwEJYztkfdAdlW
 MEIGjGCehHs92+eNS/GgG90F8/3ktAF4gAYfswZf9DfHV6+VzO+uFqV7+4WBkEc5I9Lo
 6doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018107; x=1737622907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwhofAKjVKmkEhd1Cibtf+dlD6/Lpkqp1XwfNb60dic=;
 b=I82aBSGv389ndXxHrzd59b89Fa78rT0laPEjM3cBJWQcalEoEz9VZMyP7yQemD21PY
 I1TDc0L/TlkhLkomIGTwqODA+Y3smN4HwAk79Oq0KrpSlYtirMaUvefRnY/QNvAQxwlf
 WfQruEFSsI1YnJJS1E6NF9ouu6bsj9QgaVo8/xN1g+nQJZls20RdjmkjM6PCDEH3uUEc
 4VvIvm3IQN0Fvmlc7nUfcBMYaSkDGUxOoLmR7I9foRSZaKVbbXkKDoXaQKLqVXqfjOZK
 ezDluz1fAwBe15+BPexcm8H3W2J12vKpWe0mRGYnkVzfnHcVLgDITLWCdAoKtwpXNYAx
 gIFw==
X-Gm-Message-State: AOJu0YxXZRnw8H1piak/rSItFvmsjrqzPhZO9Q771jryCdENGLy1/2cp
 od4Ih7tblZ821jBzkuecRTCY4cFR/9zUIF/QOwfvvS2PeYPPug9R7a2a9G7KqwM=
X-Gm-Gg: ASbGncu/b/z1eejzuF6I41ldmT/mWwK2dgC1jcrp9aHqppDNSRJrumo5UsGoda1pjme
 rPWPcgCPRVNhaWoFWNrzxTuo0TfwbqHbUqvlWo1v/JPWPl0kWtcar5dIS8lOEH100c7iBSPJvxM
 3cOqEmezJuFvxTc+44Gs+Ojh3WN2DURuDih4bk+XKEgV3O9AWpO1GLN1SMyn19O+Y8mkwiJ9lxx
 Ohh9dyNHy6H3QvElItPL9yYlfpuDURedo5ga68YckJsz/P3V1Z/Zh3N+Ow=
X-Google-Smtp-Source: AGHT+IG/0FX29eQ4H3zdRueWKQUpGCBSeyveElIn81JO1fHxnEjN2hSVFpg3WqmmkQC+c59u3rWdOg==
X-Received: by 2002:a17:902:e545:b0:216:61d2:46b6 with SMTP id
 d9443c01a7336-21a83f6dae1mr523809355ad.25.1737018107497; 
 Thu, 16 Jan 2025 01:01:47 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f10f86bsm93465655ad.36.2025.01.16.01.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:56 +0900
Subject: [PATCH v20 05/11] s390x/pci: Check for multifunction after device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-5-7cb370606368@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

The SR-IOV PFs set the multifunction bit during device realization so
check them after that. There is no functional change because we
explicitly ignore the multifunction bit for SR-IOV devices.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index c396d55c7240..913d72cc7480 100644
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
2.47.1



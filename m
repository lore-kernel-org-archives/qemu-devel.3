Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0842BE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm4a-00017G-32; Thu, 09 Jan 2025 01:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4I-000142-4x
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:05 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4E-0003lr-PG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166f1e589cso10049955ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404253; x=1737009053;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZwhofAKjVKmkEhd1Cibtf+dlD6/Lpkqp1XwfNb60dic=;
 b=L1e2pgkACLz+kjQn07HNDjpNJU7oD7eadXLp23NX5totKKqyex+lcTgTP8qMuH/Ena
 /IaG2ZXBbaurq8EoShbAFRCV1bl7xVBruVutLYOc7O1ujt2pB+bFlCKp+el2QyASzOkA
 dq5UEmGD/VQRekPUcJXa1hDb9zjXHOLZHPk8LzSJzzJxaHTx7WC6y9Rlv1RJePj7V/Zy
 03d8pabZjGuTfVqgbjkUXU0FybiYffSpNCCf3+sQnVQGl5sK9n9rwJP8j6v+Axnru+QY
 ZU8Uj4yEh6JKaI0nE06GALHIGQ+3n7UGEbUE4wb6f/ZriQj1EVU985NlZZvf4rnG5BLS
 AcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404253; x=1737009053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwhofAKjVKmkEhd1Cibtf+dlD6/Lpkqp1XwfNb60dic=;
 b=MoxFWQb18zMVPwvwneH0VEfNSDlDdDNENz+ZlfOSal40rOShRxsT9zoyVCvosDOeah
 pWSoMu6lWUPfxAyIV0yHG4YDUpdIMd+wwwbAPCarertdILL3ae7354EErLa3a0gcoGUc
 ULGbB8n0mMF0PCKhS8bi4CnPq/VP7fJQ9W/NYfGFaA1KsY9XliruZjrVepsHZ5R14/L8
 YJE8vsfcWy3/j3GdTnntxCI6FWixeci7lJ+vNtadhcHZ2zFeEmyDYq8PWkQltnYIhyV4
 Sf507mOdCXtx1hyJzNzjgOOuExmbq2tvHwEZXX13/OoLbKfuDn+vFASrCyscONro3ODw
 Sm0w==
X-Gm-Message-State: AOJu0YzGIAW9TU4E6aFtEqhBkKCNJeqkIRhYXTJyEjv+71YWgDW3fpfs
 9d8+BGoq3WsNrnVv5MlheUGrJr/vy972qMn4NAMopfimDEO3vIMZl1ls4f6Ur+s=
X-Gm-Gg: ASbGncsFDymGHNxeGSiWDSLhu7xQATJTfoIpqmMEHQB2FTBfAXGFMUkL3q3Ji6ToDQg
 G5uUYdJf0I4c2W+bN9/I5Jt5OMY3Ha4Gi30TUkGrDfV4D94d0GO5AS2feZfFiNorxwOYkbaUTdW
 7d74J5512rqUaWuegdRt6m+3zivLF7OF59pmYWCIzUMc3T3Kz2KEomxZZlm1MM9erTRll/xLezp
 HQvAKb67e/sYgt572TaR8YifoQjouns0G/qM8p585B2EVUhT4Z6v7XB/Rc=
X-Google-Smtp-Source: AGHT+IEbP5vtQy41vSzvbJCNja1ju4WhTkijORHca+AQ7GcBAA8Vv2O/y3hgAxyYOcuXvwmgVQITaw==
X-Received: by 2002:a05:6a20:9f0f:b0:1e1:ca25:8da3 with SMTP id
 adf61e73a8af0-1e88d13090fmr9202407637.20.1736404252884; 
 Wed, 08 Jan 2025 22:30:52 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a31ddb9e409sm516403a12.74.2025.01.08.22.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:51 +0900
Subject: [PATCH v19 06/14] s390x/pci: Check for multifunction after device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-6-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B859AE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyyR-0001pQ-A7; Sat, 04 Jan 2025 02:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyN-0001iA-LZ
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:27 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyy9-00035E-Ac
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:15 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2164b662090so159264555ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977192; x=1736581992;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZwhofAKjVKmkEhd1Cibtf+dlD6/Lpkqp1XwfNb60dic=;
 b=mHs6pOQQMf4aHycktc8g0L8NQSud1MedAjNI0R+0WBaSnsxstONGSPr52TtDnahBs0
 QXfTy2/wy/YNUidpKulRo+fD+SaxeTf/Bh/jH2vJx5A5xYvGb5UsYRgAdyw6+vI/baVK
 4/nCqITqNdX+TgGf8ydQHUSXbnOlewys90yq/Wo2nHW84lq0uJKaj7Ekard48xm3PQnQ
 QWqKhQZxVbWCSFDIMzToRkAQP2Yu2wZKWfZWS/1tAyFYgAmtV5J9tdfr416mUdQk9io5
 TUFxYh7xWwdzTFVUAp5jqN/I3q6OsNo9Zav0ABcFyHXkFAuFsAnyYT+3GT6Vd4L/SmnB
 q2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977192; x=1736581992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwhofAKjVKmkEhd1Cibtf+dlD6/Lpkqp1XwfNb60dic=;
 b=KCpbtejJxyORLITEOlZJVLwZt9srUhhzPeTz3g3P/hNH2+w1Hev+XQGl2cXItntZne
 umoAAbUAF7zA0HTq2BS8AGl2Xn0yF4EqwO2Ai6Hu4sNmVl5+zQI4NP3EUSRNwhfgF6pq
 ALffqE1pLFrloHTeOsplLKszRlWo52vMX4XCZFz/7nWjM/3keHVEwfQv90EwA7Mn2pY1
 fGCI4dsEkjk6B5lGW/eU1mHo4uBkVpfIoDWKYpKsikMRQISBHDLuqHukQsjtaQlajHTp
 UBk5q/xumVy5bbYdGQWC/3xhByCc1lKV3ilMTTFAvd8AtB2Rv4kTEsKvLGNvbh82sdkz
 imEg==
X-Gm-Message-State: AOJu0YyCrpbBzuVWM3WcwP7g+ch6w846uh0BqZY6zY6/dThORBIr29w+
 CgOR3L+WgUS7IQkyTTuXJvr3YEWZeBo5jSJ1Yp2o16P5pyn53vNP7qMaKi5OxSr2jsVpVgFgnhY
 uREQ=
X-Gm-Gg: ASbGncvbXjyW1Nwvguj8Sx/uAPqwqhHtTEy/484JzQ9JdV5p7mR1h5N8y8pKtIn7Ia6
 WLP4UQvNku5D0LlEbZhMzQr/sKcltr1tfGN1MpjCekPP17sCw8gdoQhHHgzgv9osYegcDnzJLMy
 zvxMcb3iNRIk0nTk09DNZuizVX1yW/nQJkrjA92xA77fuwW1edUYmnsUULxzXEZtB/aSflkE6Ke
 Hey6FvT3Jw3Mux5LPI07Dz8W/FZ92/XJ2sCzSdEA810CWtk+ZStrQZa1gXS
X-Google-Smtp-Source: AGHT+IFd9Ka0tE/xl6rRoN3Y6pC2tTaDB45q1tVZGRb6rqHzwPVqdsc7wi9zfo+a43GXuONMsUUkSw==
X-Received: by 2002:a05:6a21:898e:b0:1e0:d837:c929 with SMTP id
 adf61e73a8af0-1e606dfe7f7mr58475545637.9.1735977192087; 
 Fri, 03 Jan 2025 23:53:12 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8fd610sm27368736b3a.136.2025.01.03.23.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:11 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:26 +0900
Subject: [PATCH v18 06/14] s390x/pci: Check for multifunction after device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-6-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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



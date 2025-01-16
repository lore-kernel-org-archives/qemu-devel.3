Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F74C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLkg-00089s-DK; Thu, 16 Jan 2025 04:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLke-00089P-H4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:20 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLkc-0000wH-Kg
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:20 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21670dce0a7so14001495ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018077; x=1737622877;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2gQd0Jy4rc+uI1Ti92SqV/hr0DQj0ZpBWM4CmdOjypM=;
 b=JRVRSUq6rgUOb6gP+OTyCs3mQz0dMdxt/KNPtmvrYtA7SSCbCA6wiqUyRiaHTy6G6w
 ZlVTRiOOssnDwjmS3riSm8OPKQ4x9W8JFNcO4sk+spE/CDjYnc1qd1ro7KGQHmjtbGxG
 uwRAQFgLUENG+2cvqVj+L1LL1QoQtDAaWS9icTdX2scTH8Lty2FUl+iIJ73IUbsCZts/
 2Mcu/PtV41cpz9vJQkJWva+NippYlEYCghu0Nc1AO1YC05AVLCwS52D0o+R/eC/ZpIPr
 d9FP0IkrYqnFnXeoQXjGqekIFe8f/3ibG2HYK6AcQvx6VYBFI8hCNaqLPJ5XlBk+VEX8
 4UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018077; x=1737622877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gQd0Jy4rc+uI1Ti92SqV/hr0DQj0ZpBWM4CmdOjypM=;
 b=NU9/WiBTz0IzjxJ2Q57kaL4U058frhMZq76tLg8+LZUqE1ckQZiS0vQMA+TzL1ZJ6k
 POQH8O/UmrejuZZHC8bQZ0NFYeMjiovLU5EPatgVh+tY86gPZD7JATxQRke2MG894Pyx
 rgp1dXVkY8z2HKOZaZjpobi4obEUp1npPxcypYDPCioeh5FP7+DGZNpxeS0abdDbQ33M
 xR/Mx7b4QzgcUZw8rcZ3MchVqRdJ2uoln1ijggnyiKY5jbN8HAFchyeYh/47mW0Xpfxh
 SMpzoLzfKRtH3BS5t8+rZ6QAi5acW4M96duyQxGiwEmDE4ITYEZc6TKoHd955CtDhM9i
 0tPA==
X-Gm-Message-State: AOJu0YytAHIamDvl4cXypyvmWYAZikymgRihQVd8Bk3jxHGFiunUmuOJ
 Jldmg7FjWb8Wb4+9n8vuKt0QNU4EEFYdhM/409QK+JjEPk1IIrplCsWhHjEvNQ4=
X-Gm-Gg: ASbGncvE9wMLVh/ZeDjsIFVLHx/vw0mVo5JRjU0G5ZudpOrCsKGTWvkD7u99Kj1qxt3
 /5xxwWEal3m43oW4ZcBQeg98L3vu8w38NhLyvDteP9R9PQNHGgBIPew8jAZw2O+dQJz6APvPbRU
 KNetRgkl4fl1PgKucxdMQ14sUq+3TXtRZKWAmvwnO5nRVvE+HBWmiVcswFURnN8Th/foHMOaKa3
 1Y7Z0XenzwZyiythgpy8O97W1wltDG2vF1tTS2XRG/W22lhMjz0/5kuLkE=
X-Google-Smtp-Source: AGHT+IGsHAXdcQyu8YJ3opLV0F5kA9eiBjGYAV8dlGdGfIEgcIK/HTKudx692rsFUvlVNRPj/ZrjPw==
X-Received: by 2002:a05:6a20:6f09:b0:1e0:d859:e1bd with SMTP id
 adf61e73a8af0-1e88cf635d3mr48091587637.1.1737018077261; 
 Thu, 16 Jan 2025 01:01:17 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a31d5047fc8sm11055796a12.57.2025.01.16.01.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:52 +0900
Subject: [PATCH v20 01/11] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-1-7cb370606368@daynix.com>
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

Disabled means it is a disabled SR-IOV VF and hidden from the guest.
Do not create DT when starting the system and also keep the disabled PCI
device not linked to DRC, which generates DT in case of hotplug.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
---
 hw/ppc/spapr_pci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 904227d9aa1f..b94e4ba1314f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1283,8 +1283,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
     PciWalkFdt *p = opaque;
     int err;
 
-    if (p->err) {
-        /* Something's already broken, don't keep going */
+    if (p->err || !pdev->enabled) {
         return;
     }
 
@@ -1572,6 +1571,14 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
+    /*
+     * If DR or the PCI device is disabled we don't need to do anything
+     * in the case of hotplug or coldplug callbacks.
+     */
+    if (!pdev->enabled) {
+        return;
+    }
+
     g_assert(drc);
 
     if (IS_PCI_BRIDGE(plugged_dev)) {
@@ -1647,6 +1654,11 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
     g_assert(drc);
+
+    if (!drc->dev) {
+        return;
+    }
+
     g_assert(drc->dev == plugged_dev);
 
     if (!spapr_drc_unplug_requested(drc)) {

-- 
2.47.1



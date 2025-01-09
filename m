Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD12E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm40-0000xw-KR; Thu, 09 Jan 2025 01:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3l-0000sQ-Lg
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:32 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3k-0003gW-2b
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:25 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216426b0865so8025015ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404222; x=1737009022;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2gQd0Jy4rc+uI1Ti92SqV/hr0DQj0ZpBWM4CmdOjypM=;
 b=KnqX6E1uBKjt/aW19GROzIx3m9FK29HyL1g8Jcz44SvcyxsgglSRGzNqiXWf2/IHaO
 zAq1yzJ7syzsDiyB6hylsZhQXl5P4TRHmVqz+MBoDy47FilQdA4+qvDuJi8u46e8nRvT
 FaI9k2Gr0rNPcTaR3ku5iEbed8wSWqUPFP4Wi6ybXtArdZn0TMt/6dfAkqSIMEmLMqeI
 dDfIkaUZEuCithfVnETkQ8BQf1MDVJSadFnFjbO4hNdaSF0bWmUnYA+8TvYLy06qjnNl
 4hkAhYFRHjjbLaMDeQNcB+5D5tTWo3A0lHm5W0S6S3ifUy3xfwQGyC96r9PfwE7QdHSK
 GgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404222; x=1737009022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gQd0Jy4rc+uI1Ti92SqV/hr0DQj0ZpBWM4CmdOjypM=;
 b=wS5gPJCPh3FMw8PE7BGgmjQB0WspQc0twcyGAQBeS89cwkbe/U/J3OEYdCg5XBHSAS
 j+FWqhp14YUAEy+vCN7aQYYnqHUMPDIDuPqUVE4c/3bpvJe9fU8xxiHTeVt4U7PmYqa/
 G0BnrW6dtpG/mvdIvT/ZtO4QSnHdetHw1FBh+w3y9F7HUJSX1uGBi1ATr7ew4XsXPrqx
 ULV63Wb6gWGU6sj7ZM7xfL1RVOMQHMK9Fk6tbt6ZmGl1zsNd2EwSggA4lyLkWhx/ZhtQ
 TMQuB5sEgmZPdciIkJyK4dhyd92aRoegsu6rSwHKGyp9RRfW5nsklsqaLZcA4J20k5gB
 AErA==
X-Gm-Message-State: AOJu0Yx+uURenPHTuABB2ndhv8xFEvo+Fv9u3BLZTwlqMBTWvon5zrm8
 cXBkCFcNP7AMOl2zbGoRjpOvdgl2Qg3n6RxoZY/adYWIo1stMrHhY00nlC+AEEo=
X-Gm-Gg: ASbGncv55iGfarr0mnOFWa2ofwqBescXG+DuoAjZU9NA3fAHHcqA9HVyGSzrGzdvJHf
 cJvBn3xEO8tGJ3Ss/bPlkyekmqjeTaxcuEyRrnnm3x8O/+oxx65I4GJy/mZsKOD7dpMK43u7LeT
 YHkyPJxoyp98ydxfuRUtsxwjfoFBUF/0az5vjLgFj+GBT68vO643rVZAV0N6DPSFGyv+cIDKzh5
 nJVOHrUacUUZTcVxYFb/FWmgVs5Mz6hYgXgI9GrouqVpNxobqRiF7Ho2aw=
X-Google-Smtp-Source: AGHT+IEydGEPV3mvle42V616MZrv5dVTqShwy7ZfRwNBFMOpBKMV82cbi8zoma8GK6yxfJC5aWy5OQ==
X-Received: by 2002:a17:902:ec84:b0:218:a4ea:a786 with SMTP id
 d9443c01a7336-21a8400b2a8mr95718275ad.53.1736404222354; 
 Wed, 08 Jan 2025 22:30:22 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a91a3ad56sm4722705ad.214.2025.01.08.22.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:47 +0900
Subject: [PATCH v19 02/14] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-2-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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



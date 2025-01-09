Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A97E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm3j-0000s5-Tb; Thu, 09 Jan 2025 01:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3e-0000qQ-Bb
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:18 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3c-0003em-Ju
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:18 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so807016a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404215; x=1737009015;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3gPdL2/+OKJVglVFSysXcL1/AW7YEEFb/kruPVx7Glk=;
 b=c/R2StLkIptjNPeopGYozvFJBSCRqI7uOrATTc257/leSlVN7WtNaXXH3lH/0ZBY8N
 Rc0MT9pjJtcQNbIwHCySl3IejuNta/Zfec0piHiIEr0mvyS4oCWhcODs0J9XrMeJ3KCW
 omJHhJWaRJ/oHKRHUwiEvnbR0R9g+w/uYYbgsrMH+zERm4B8OYZ4/N13FrPmaWgnblh/
 BmqawuqJ559FhubMTxMiUxOmIf0at9rMG6PCMyv3tkmemOHacijpe0SAibmpRUsOAK9w
 pOAjbDmLJMHWWHzVwJw1JFqNC8JPk0v0enikITKs1uWrflbQEdmr3vhh9oA7tbEhuJSB
 EWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404215; x=1737009015;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gPdL2/+OKJVglVFSysXcL1/AW7YEEFb/kruPVx7Glk=;
 b=hrcVXf11Njuu3FIxV1vS0lmx0gh+s+ypsLITpShzpJ8qnIRVGfIN7ohSBX+zuZFzvT
 +Uy8e18wbFU+ohNsuzeT2o/UlwwjdIsCQLYGw/BKplOC9LQWfcSTzE/Ex4wDih18WTNm
 f7vP4alYOuHtBnyg2ZyWjDrnp4Bs2u8ShhVl7E0/jg4itipRql3/icBh30oc3njlIUJw
 oRgoC3GOQAsBccNO1TA6ecJixMMLweIe2wCSzZkjqnCuUoLlHnBs3e4GqX0QXVsrYkhe
 2ieYeHGxjrDAvQwj4SgyNnIddNpCZOAxQnibJj9yU5aBDIlIGlCPlrcdxAC92RJ9GHxs
 dG+g==
X-Gm-Message-State: AOJu0Yw3jO584lDDGVkTmSFephJo2ryutDxjbSrbvCbIGfM2eMpXwYd0
 QA2/b2o6+qiI4mtnucx6u2hEo6hF5oACQvp6PO9oAs7zTEimf4Z7IYtpB90TekY=
X-Gm-Gg: ASbGncthT73mnvsqEcGzS40iYcpGglLEZlbOXJsg/kqJfw/WTbc7pQkjPHVr9AyS0Vh
 PJP0qDIt9EhKzKSaKXUIInTTZJUphCQevOSehPM7ts2csFnAgDZAPHl//032PMIfJEAxiFyWj5D
 EW5mFZlADP/y92sBCPvWnq2H6iLWeoZESdbMeM+2V+glnWQ0Lbd/SmWUzeVR+zpIi1+CL3klgdH
 y8w8JtT9Di/1fZ9jG9XBFP/PIMAP4nIwFBqqUuRD7Yo5APomdhCrJEFx9U=
X-Google-Smtp-Source: AGHT+IHs+Qtz3CLREsCnFAI0rK5Gpt/2see9FHoaLrmGACMhNI+kngLqK++uug2/2cDmrUMD+mg9gw==
X-Received: by 2002:a05:6a00:a11:b0:725:96b1:d217 with SMTP id
 d2e1a72fcca58-72d21f3234cmr7061333b3a.9.1736404215085; 
 Wed, 08 Jan 2025 22:30:15 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8370e2sm37733825b3a.64.2025.01.08.22.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:46 +0900
Subject: [PATCH v19 01/14] hw/pci: Rename has_power to enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250109-reuse-v19-1-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

The renamed state will not only represent powering state of PFs, but
also represent SR-IOV VF enablement in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h        |  1 +
 include/hw/pci/pci_device.h |  2 +-
 hw/pci/pci.c                | 17 +++++++++++------
 hw/pci/pci_host.c           |  4 ++--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cefeb388bde5..4002bbeebde0 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -674,6 +674,7 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
+void pci_set_enabled(PCIDevice *pci_dev, bool state);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 8eaf0d58bb39..66b6c08b0118 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -57,7 +57,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool has_power;
+    bool enabled;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b6c630c32368..577ea0ea5eae 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1598,7 +1598,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->has_power) {
+        if (!d->enabled) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1686,7 +1686,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->has_power);
+                                   & PCI_COMMAND_MASTER) && d->enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2963,16 +2963,21 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
 
 void pci_set_power(PCIDevice *d, bool state)
 {
-    if (d->has_power == state) {
+    pci_set_enabled(d, state);
+}
+
+void pci_set_enabled(PCIDevice *d, bool state)
+{
+    if (d->enabled == state) {
         return;
     }
 
-    d->has_power = state;
+    d->enabled = state;
     pci_update_mappings(d);
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->has_power);
-    if (!d->has_power) {
+                               & PCI_COMMAND_MASTER) && d->enabled);
+    if (!d->enabled) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 4510890dfc18..80f91f409f90 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51DFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm40-0000xx-Mc; Thu, 09 Jan 2025 01:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3s-0000t4-Pf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:33 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm3r-0003hX-3E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:30:32 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso813624a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404229; x=1737009029;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oyg4pbHdwstOkTHIR1V+PL7i5L1dZO54bgS88oDmuKI=;
 b=xOiIfLv1uVRlmpctU1nN7xepotQZBJrTvOBfhiFahEgWZFbl66I1aBy/7VzAvlYFVv
 2G3SP9iM/QkeUUYYz6tfEebh0MDwh1fc6UHASg5OSYA6WFS9CwQrAQ2wtp72x44mUB/D
 thdu8GUiHZf9AqpXtGdR+0CRwcS3AIEx6nKKwzEWyNU9hzBciGpXQkdR0n1Gfh8OL+DW
 jlwseCV2MmdtNKZSDAM2oA+xV5hVbfe96VnKzWrR201yUCefw0f0OoqorxBM5y9Q0Qbv
 outwxlfS+VwN6cBe3VzC5N7lIcr7myHmrJH30W/2Gv/iBOzDyegPKdYgG3aVkXJm9dhn
 jNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404229; x=1737009029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyg4pbHdwstOkTHIR1V+PL7i5L1dZO54bgS88oDmuKI=;
 b=axrLIrjIu4nZcM9vcaIFUSmNKle6GLFjXb8eCdAND83y96q+oWl4oZeHTbela+gTbY
 ypjH3xeuP6R/bwdwKS6CGYsRrPLPnOW41pOON6S7/AUB3jBhOz4+w9zRHz+xLo9sn1ul
 NguWLTyuyp4vj/5n9pkge6gmkZo0M9pJbS3L5c0+fw3qBk5yXX+SFyFhXxDbL7bYVmZR
 UM0txWUxtQwWU4XlYXV0K2DjuPTJjqdx+kFUgy6RwRTDyj7B5qgVvpRdEMX0EBXdZRVl
 wkIbAt7g1CK0RYKb61VHe/V6w6HUF7HbegqrzBYOU6BevN9XrCqup3MXKknmrSAlcW/B
 b9kA==
X-Gm-Message-State: AOJu0Yx/krYA7WRXCo0ubCIDhrluOk0ShKtPRVBM3ZlE9zFS31s8utXK
 p6RMTrcO8PmjApIdvzE3wlmHRAfK6xYLdke8kwRUnPbtP+h9/sLCpzx91HSBrgo=
X-Gm-Gg: ASbGncs1GIeuB0UaK0bpGgZx0GzKyvJimVABrnrnTh9Bwg3gcllmQkZXkZhRgKoSk/9
 wNWefxeSNhKBD2O9HabSVlqikgYEg5HGx3npDprK2/Vxdig5tljAHGXS0H32e8dc6dQoyzXAG78
 z69Wzo01GGrnZ0Ty0YvBl86K4Sx9P2exDtwnTA2zeGmI/Ms91ZyMEUM/7wEQgg7fM+jEHrRySb9
 JhhAjiwVYwwGeErraLHADbnlTQPBxG3tsiq/cJ0Y7lk1DMP2VHPu3iW+jw=
X-Google-Smtp-Source: AGHT+IFP5VIVA0+rW5pbNMtgm59Wp3CA6M7vnrj2gChDnTYEfa37ZIuO2EN2iVuyBKUFiBDrHI1oAg==
X-Received: by 2002:a17:90a:c106:b0:2ee:e961:3052 with SMTP id
 98e67ed59e1d1-2f548ebb2damr8716442a91.14.1736404229602; 
 Wed, 08 Jan 2025 22:30:29 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f5593fead5sm537341a91.11.2025.01.08.22.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:30:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:48 +0900
Subject: [PATCH v19 03/14] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-3-f541e82ca5f7@daynix.com>
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b94e4ba1314f..e0a9d50edc3d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1549,7 +1549,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FECAEEEC0B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxEu-0003k7-KV; Thu, 12 Sep 2024 23:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEq-0003bl-FC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:44:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEo-00082E-WB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:44:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d704704aso1474001b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199090; x=1726803890;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hZYRJCaOR7D2p7YWgr7dJo7l/TPHeAaK6dBF5pYEnfc=;
 b=fHHjpOinAIkdlWAtsj7LLoRtUA460JLgOZUx3q0bL1nTdA0JbEYwom2sJ8wBHaL7mQ
 aRMDo6r7c4xZPeJ+X3sS58SuW/lMJHbiW5s6DOsYhcdNvejlLbAwOXCvoAL2QMhx1RfB
 xfF1inYtLtjDrSfdCV07DX18lUmQw+lzS9XeHjtR9I5t29IPyeXRqjw2gJF1TTa71W87
 c1K8AjSJtw745gEDsrZfJEV3RoxFGzerVjPDKo8w32AKaNcyk/FuyBtgNC7sqYZiXU4K
 RXjaDQLYxtoc/ZL97quhKfBdHZxM/uFBf1l8Pzm0YX9M7QwnxrbwSrpvxOQIjJE4WWSb
 r1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199090; x=1726803890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZYRJCaOR7D2p7YWgr7dJo7l/TPHeAaK6dBF5pYEnfc=;
 b=tWZ13KGwTqqwbpAu55fc8ANY3HNT1i7ABGYmQL9/yAoKegzSFzFkrJyskEsGGogUam
 qUYJVuxJ6qDP7HI5gdpfy1mYhLzS//PKBfnk7jABOD8sCWXnql+WItirM+SpLWBnPEyl
 8+sQz732Wwz3RI3hp2Pff+5svPgD3c2J474KhTx8R7OAgZp9pcpH035Z1Ml+Nk0haVj8
 vpwF5e0NiI0dPCnPyjo5tMnuph6qwt0j21Tm5j6DexKvbdWN7+hOs4ymdkfpOIC5WsUV
 2byrfUjdCZOGE5ImCmy7Oy2g8ACMofUF8oj+kp8FCBEBCy0gAvoTiZFSuhslcz89/yZF
 DnUA==
X-Gm-Message-State: AOJu0YyR+spy3l3Jah1Gwp23IpjK5Vpm14dAtqa+ihyyYgSNg7CebSOA
 PlLMyO5NQwB2Ek4Ba+vMReBIU6kWS7Ss2hL2KlB6b60nsiekNwHUQu4rxjruOjU=
X-Google-Smtp-Source: AGHT+IERoRG9O87IJ5JdsL+F+K7XoWg44OlwL03UUjCRmbZ1ot+vJM3pv4OOvUR6QCfijvxXZertHQ==
X-Received: by 2002:a05:6a20:72a7:b0:1cf:e5e4:a24f with SMTP id
 adf61e73a8af0-1cfe5e4a32dmr6476206637.8.1726199089676; 
 Thu, 12 Sep 2024 20:44:49 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71908fc8f96sm5264031b3a.2.2024.09.12.20.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:44:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:30 +0900
Subject: [PATCH v16 02/13] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-2-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c3546..f63182a03c41 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;

-- 
2.46.0



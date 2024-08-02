Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9DEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZkgp-0005TR-2i; Fri, 02 Aug 2024 01:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgm-0005KR-UM
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:18:53 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZkgl-0006vV-FZ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:18:52 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-70944dc8dc6so4147370a34.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722575930; x=1723180730;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=IN6lBtTPdbakMdBdAXr/NWwtyvTBOJuDSN0OjzgP8qSgAGHHgAie194JcX2AA/INXb
 k9+60PMM8IRsVaRt7qFSQRTBRylEEVITLe2pilYuhL8Kga71+PSKOvoYqG4sbuR1Ifvk
 KOIO9NACxq4enDaUk2gA24mqO3V2awvSwgutsn8u8bbCJr50BMCg4LTPLKlrlPBZn3Sy
 V7l5XBz8LGSXBc2sfJiNWVfaEum8doTqc1e7VZPCLoc/hqYy+KIO/vXpQ4W37TdQ0WoK
 GeRe3h9CaBA5uN0eylMUPyYrtjQi4FApgy1NFTkUFyV4G7G7G1ZB1HeAJXgCrXjMqVAh
 8yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722575930; x=1723180730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h49lGewxT9hFA+tlJrf36flRr26IrZVQVpZMqnu2U/A=;
 b=stAScgTKMD3idTG4gPDFplRPwCKuQODYGQlTZT/+4iPcTGm9uumTrxjTKVnIZnr+oh
 c7Ti7tlj0zjsDXQjdlwIEh4xikdc/2kC6QX/qDfiidarEP4pvd/4SFeAMLwe9RmJB/vT
 KXGkRP4FJIZEkEGEpD8brmUIFMxARlg3FeihcPflxpnzYEHu2s97EgOBQ/EB60EbYuzu
 V26k5gu+kaOa32/YZHC2PM+DrqOg+ABSIfOIpJk1uuAZQ7RTaQ3XSH1iolZ6BHI0sJZ+
 Plv8PhROqGUPuwMrthvemllCmTgiLCY/FzzwLfwfJxa0ITkQ1fSocIo7anYVD8IqHuWB
 3lFw==
X-Gm-Message-State: AOJu0YxjbwREzBZct3fbRRSHvvgpjhbg43X3PFeSeCK/WSamZ9OKvD/q
 uIZhcRWo/2D9Biy1QL12/3xNpAYvMIU2Y/dGtELx1mGgk1CqJTMt8XojJ0A7EoI=
X-Google-Smtp-Source: AGHT+IHDKDu8T0vVGl7yILcL8J/CQYzCUuX7OIAMkJVfgHOBbvbmbmP0cBIqfSyEpGuaOZTuWy89fQ==
X-Received: by 2002:a05:6358:591e:b0:1af:3e47:4e3a with SMTP id
 e5c5f4694b2df-1af3e474f99mr186378255d.24.1722575930173; 
 Thu, 01 Aug 2024 22:18:50 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7b762e9c066sm521572a12.13.2024.08.01.22.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:18:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 14:17:52 +0900
Subject: [PATCH for-9.2 v11 02/11] hw/ppc/spapr_pci: Do not create DT for
 disabled PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-reuse-v11-2-fb83bb8c19fb@daynix.com>
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
In-Reply-To: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
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
2.45.2



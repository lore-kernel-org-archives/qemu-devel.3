Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA0CC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyhr-0002AL-DE; Thu, 14 Mar 2024 23:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyhp-00029c-Fw
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyho-0001zv-1h
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dd8dd198d0so12430065ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475082; x=1711079882;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mcCPQWk0Vl3Dmy9Os9eAS88Yp3n8TTfYv/+AY1WsjkQ=;
 b=qJs8hmFOstfLyC26zH3BXyskAbkDO9VeBhmVcWsE9zXJTR+NIGgZX5/axpztwPFGBA
 MJhkZ9MHS4hP8dpIFY9fV21/9at30EbxPIIimGimxwkCDVTLbmWRJiSjuqp4q8GxqfwC
 tvpLTkDORCd5F0zX+/eC27XziT+Tf57LBxVT8ooCq8hR/lMe7D8QNNlHT02swUvk3Sla
 l8n1ZibC088/o/CHwt1jUlDFTM0Rxpy/uo3Dh+14gtKVKtSP/Sh/H1Cbxu2liVgwlBGn
 ZoW/6BvNFB2A2rP63grfUhEUwtoN6URgVjeBnPgYGpnAHpsP7hAVGzVtfFzBfqLkLzy+
 8YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475082; x=1711079882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mcCPQWk0Vl3Dmy9Os9eAS88Yp3n8TTfYv/+AY1WsjkQ=;
 b=tmHZqlec9nq2gr5KRCj53eT0Zyyw5uncu1f2MM0l9WEVhWq5sLC9UjwWm7XevRbTvV
 Kc0voM3KjKl5KtF9ORXHEwSpNzwuT9pUlNVsD8YecVY4nYBgYxjJsdiVcp+fEng+n8ys
 +IsWIppU4+81y8wF1P3lJKEm+qKa+1nekzkS+20zwauBnbiyszL0LPlgZLeRi4i8sUHb
 TYTSWGoFxd1qHQ+fiXYkoeJ+2/JdZiDwJlyZATGxb09P8AfBwgA/CEKJarNMc7XHcCVQ
 qCkXnN8LCSTRiRO8CLSrCUPc7kT06XLabwKFyesnWapqs9wDeIs5VmmJt8S/38g4xWEP
 eiWg==
X-Gm-Message-State: AOJu0YxVz5wwyAmt3m8R4OEr9SjTp65DTshd445NC9luR9mzm3tbAX4M
 2LMOR+AuGDJurjddQ1dbjIegG/0D+HclSf+7YEDxi8EXyxNsMgLOq4dMN2pP79A=
X-Google-Smtp-Source: AGHT+IEHQHuNN90Vc1p8fCS5AP9jp9r0jQk/scnvcHfK87/eYky1ALO6entdbcCjLpIUa+6kRBrN0A==
X-Received: by 2002:a17:902:f551:b0:1dd:138:4e0b with SMTP id
 h17-20020a170902f55100b001dd01384e0bmr2538951plf.40.1710475082670; 
 Thu, 14 Mar 2024 20:58:02 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 w19-20020a170902c79300b001dd0a41447fsm2595177pla.233.2024.03.14.20.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:58:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Mar 2024 12:57:49 +0900
Subject: [PATCH for 9.1 v9 02/11] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-reuse-v9-2-67aa69af4d53@daynix.com>
References: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
In-Reply-To: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
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
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.44.0



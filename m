Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0579C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauVB-0003Qt-Nm; Mon, 05 Aug 2024 05:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVA-0003Nh-L9
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauV9-0001EN-4v
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so80731135ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 02:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722851977; x=1723456777;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=OkpL3jk5uiZ9KfXMdqIbRtr/+gILbs9EEciFP85LGJuRJ5r4CM3XivHkZ+zvfzCccH
 LjXKnZYDQaajgmjcdNED1WmzykDH2WBsHWG1Qg/NZ+JrDxPimIdqqvuXcabvSpVDAXe+
 OuMmjtfsRHAy34Tc001Df6bf/girtpCra5aNIZLyTLvrYqLP5joroSHl/mVfMliiwoan
 t8gn564508MuRDOxbzPiGMNzff2yQqf8ieLJCZSoRRjVToyW7Kpuw84Z96xUnbMXs1WI
 Lvd9JJnH9FRNey4wvyD7DzSSIczCUUgg3osns3cUXX/du1oFrNmXmT0RgS7lEMkGgJd5
 iXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722851977; x=1723456777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=OfmuCxralnZg3NAh6/7M5Wzag/8LbVljIjqAKvRSFyg8oCltYnASlA2OwN+K0bxZdA
 /+6R4EuYA53lOckl2IOMo3dyLeaS8/vqJ0xvoXkxe8QMcE6zVWx+PbshYS+Hj/dhZr/i
 jGeGkPcAXQtSarMgWkD5TZEfQGT39GnrRrkfjPEsWpFYGTMixr45dA0oL0FT0wF0nZga
 SwOX/uA1nIOv7UzdVPlw/QZ5NPf/AdyAf49nmpTlg1phRtzi134DVLD3Bieeb85PgoMg
 hspqKg7tR1SvgM/a02DJ1M++2bYq4sWY/Z5kBRfxqSjge7PUno4nvSTb3wqpiUSOMtfS
 gH+g==
X-Gm-Message-State: AOJu0YyQjO0POU/Bp9C9qdWW8yqya5gM/Exn4+NPo/IdseLNwHKC2wVU
 QJKhsa/uHnXnOPjC2tn1CGSnY8UeM4A9FYpxKbbWVyj6S4ZFlg6oOojI7lX2SHw=
X-Google-Smtp-Source: AGHT+IHKZfmNrs9COenNr9rHpHrlTA+tCgC1dQuZckaluzhRuF+QMSJPpMwl5bOYcMVAk+KgZNu5Zw==
X-Received: by 2002:a17:902:d507:b0:1fd:6a00:582e with SMTP id
 d9443c01a7336-1ff572cdd9amr99225215ad.30.1722851977617; 
 Mon, 05 Aug 2024 02:59:37 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff59060045sm63441995ad.147.2024.08.05.02.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 02:59:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:59:00 +0900
Subject: [PATCH for-9.2 v13 03/12] hw/ppc/spapr_pci: Do not reject VFs
 created after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-reuse-v13-3-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c41..ed4454bbf79e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
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
2.45.2



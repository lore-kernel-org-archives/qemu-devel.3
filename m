Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4EC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJB-0003zm-G3; Thu, 27 Jun 2024 02:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJ7-0003zC-4p
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJ5-0003cD-Kp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f9c6e59d34so61636255ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468510; x=1720073310;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=ECwSKcrtoVjLKpv6VjhgaUxZP3+g2zyOd4RSy9m4G10rNDafFgKOkBegjAFFVXO5LN
 Smvv8TC75xdNwrcqJTOhwojEY36IEQQo6olnMUvwT91X+svBoxQxKnbbb13Zf2GufQbY
 ldyNpr6uAZezC8+eT/izMFFMAIvBmsKmxRSZ18zDTXaC286LS3XpgVrZtP6DLaw8KHal
 IoSjoRMRB2hxC0h3aYNfHB9I0/e8fgYZ+7UFVR9Tf7fOTbxq4pHdqXL8WoATnjC1whvn
 kl69gqeVwl5R9ZwlweYRHDrCuKj4lznw56I67jFMyHvnlCzCNR6K01g5KWnHarjSWOn9
 jUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468510; x=1720073310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=rafIjzrH8dI+kyQCPLuUUsDbLVmjxWAglE3b/rgsQ07UyATk/p641QXrGw04UUTYT3
 CwpBzCp/gPCSazY6kTg4fDKf1QZc+f70qtuV+6r0KYhpHt27A5jh55FTVT97Uozylzte
 UCcUf3hRk7r9n50Wag3hfZnx70hbHEACYDxAFXXLHPm49JqMMxtYTkbJS0PwWkuzdLoT
 pMhcTxj4EoJVjnwEpTiAZY7pF+jL95JyVCUPWZJiw9RZAfJFwM+jY/OmlHSq5FZuYlLI
 NAjiwSD0XOZ5kAf8pzN7IppmIcHcydAk584hpLvdhAplNZmAc9EESDszIaPZv+TyneCd
 ZgMA==
X-Gm-Message-State: AOJu0YzRr5Zk8j1wv1N2l6Zeo1vGAfCancTxUGAIUhKDok8A9+PCyUFU
 EylLwgs5LzHyiTejk9ePol1fmd/l6/Bii6zWIRBScXjsfaEnySedhQd3BDAeSzA=
X-Google-Smtp-Source: AGHT+IH318a4KY8MLgK1PSUEj8yob8hr3rtYkIUJVLFubZOJlm52gF9FEN9Rd6oCXvfNPtS1CAxpEw==
X-Received: by 2002:a17:903:18d:b0:1f9:b4eb:ce4a with SMTP id
 d9443c01a7336-1fa1d51c2b4mr173842155ad.23.1719468510363; 
 Wed, 26 Jun 2024 23:08:30 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9c4ec2sm4883735ad.293.2024.06.26.23.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:08:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:07:52 +0900
Subject: [PATCH v10 03/12] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-reuse-v10-3-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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



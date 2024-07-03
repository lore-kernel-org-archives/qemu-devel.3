Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854B0C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nz-0004Eq-N0; Wed, 03 Jul 2024 18:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nx-0003xS-8W
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nt-0007UB-Ks
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMkazJvXlCFuPVFo5zwsqgTLcz0EAKKfqUw3BcILaOs=;
 b=AdZvQWvyyJXX3dqBB5/ARhMTF1R8i7n5UdD4IRvnMo93vDKYMgzbyiJpGMg5jJiILhGXOk
 AHL2q1wjfkmiuBNB8h7ue/4bd3+JN1SC0PXWoPLXzCDHwL8J2pqoSs8v/2OWvxNGxc3dBZ
 lgODEP1vN/Va6gHkcZCi+Ptj1u279fI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-2fItBZLdPeeP1VmiJOks3g-1; Wed, 03 Jul 2024 18:50:20 -0400
X-MC-Unique: 2fItBZLdPeeP1VmiJOks3g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-366e0a4c965so37627f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047018; x=1720651818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMkazJvXlCFuPVFo5zwsqgTLcz0EAKKfqUw3BcILaOs=;
 b=nl+Ph5nxFzu0gcHYaSJqiXSKdwGOuOIHEhkTndElFaxJk3W6sPrXard2mllEuXNFTA
 LaJTQdeeQxjtl7L+dG9PKOLUbRSp4IXRbp+gyxsN2LCGYhu5Olw871On8fZraJaI7RRo
 FdNkEpQB1H+YntV1OBHWgmh3/kPGoimv8+wOVQyz+7ij943Xvn6Mr8UIu7Ot9MWPoGt/
 TGZWGoQlKQ0DoJLmKeAK3ii1WCSaHXtgnc3mhPRqVPcqnR1bFsygM+b/KNVKtXxqLHYx
 msPSyKygNp0Yb+vHGoIph7+x7FDUlgIZy5Jim0IPOho0Evo4u05nyowjNmMtgLFvam/s
 +BFQ==
X-Gm-Message-State: AOJu0YxDy3/ReKvMgGnLTYsnpH3LX+h6uwgHGUW8NRfCRZSPABz3Sj0B
 Pizu9kRzDslQzFh7z1F7xnLX7mn/KZCmraHUDBl+xPQStvLPol40rmVxIKGNKoQzUsla+xzg7VK
 uU73gnVAqCmcdbzxngj+dv7Gp9F51BOxe7ucXjbzXasxIUn6uCoW1VYfsxHhBPD4/p2klR14Z65
 QXzGIikqBiQKU9OgbGjz4m2MjnO0qIag==
X-Received: by 2002:adf:fccd:0:b0:366:ebd2:662f with SMTP id
 ffacd0b85a97d-3679dd34163mr9149f8f.30.1720047018140; 
 Wed, 03 Jul 2024 15:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaooaPw282ZT5JS2s5r681ut3H6DUwmgSQ+036eoYeugyGzbJ1HayzLRizzhHO1CsgMTAyxw==
X-Received: by 2002:adf:fccd:0:b0:366:ebd2:662f with SMTP id
 ffacd0b85a97d-3679dd34163mr9136f8f.30.1720047017589; 
 Wed, 03 Jul 2024 15:50:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678eb6593bsm4188588f8f.93.2024.07.03.15.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL v3 78/85] hw/ppc/spapr_pci: Do not reject VFs created after a PF
Message-ID: <26f86093ec989cb73ad03e8a234f5dc321e1e267.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-3-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c..ed4454bbf7 100644
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
MST



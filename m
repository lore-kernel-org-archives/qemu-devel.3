Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6352BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBI-0000o5-W8; Thu, 01 Aug 2024 06:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBC-00009g-2S
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBB-0001nB-Ld
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHtvaqv/X1Y471mdHo9KCdjIxuFijXCK1FtuQT+o6C0=;
 b=L8/eHWbCJ5mqQhIOyRiASxxEyj43tdITu0v5WQ3YIODLbSZrCyTLO7a+uxtq1xSrJr/XQV
 6ycDsbXIp/5HKjTc8xGNa96bz2JL9qX8ziqf3xf2Ifowp0SsuCHTkgzRij4SBPoMRkUqLn
 pmG4aXuxSOjl+cZ6XNBgqWDis/87ufY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-N5xjlR5BOViSHNBleo9NsA-1; Thu, 01 Aug 2024 06:37:02 -0400
X-MC-Unique: N5xjlR5BOViSHNBleo9NsA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7a8281dba5so545392266b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508620; x=1723113420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHtvaqv/X1Y471mdHo9KCdjIxuFijXCK1FtuQT+o6C0=;
 b=VZfHq+peg2lHFcJFgp+P2Duoaw1qg06vsNyjiEt4BSt63ewB8hr68ahnNJqnuXUfx3
 G9fxuhd/RwbcHtJ83L5nQMkWsOY/e/7jotZILmCFzdi9usSfSheTYAtFd35cfAy+Duf9
 Ntk1x7wirhsIT0UuJhLg3qxx+Mw+C8YVyioIwmuG/n5+YXDpJlKXFNx8rzzANPcW/VfX
 1DiGoeRPApPIU9sS3UGkP1u8iiQRZPydSfsSaKH5XjWvq0FihhnwcRtCgyeBpc+O0bj1
 BtxaEwoPd6PzGYeX40/WesbdxDOYqYm3BQuVDUG+g1BzwrJFC1w2wlAmMBFiaZVx9qmJ
 wUWQ==
X-Gm-Message-State: AOJu0YyiG2jD1xa3bsO7Ps66syh8sht+wlazjqdj2hMONT4IoHOiQoJT
 5T6G4/wqfGuW/cFsJ2wdBrfbIRpSeUA/pxEvf05oaeUvdjTMZR3ii6/Mv05ytswxFpPcqEJsp9+
 iQ32zNYaRHbeFQerKtwJWeAxST8AnkHQqeEkb5yWqh+NCmyFNr57IoHl2VyETXtZETkkpeXZs+I
 Kkiwqgp+OupfCC1O35efWFuEHsm/dnBQ==
X-Received: by 2002:a17:906:f59f:b0:a7a:c083:8578 with SMTP id
 a640c23a62f3a-a7daf64e2afmr137518966b.52.1722508620061; 
 Thu, 01 Aug 2024 03:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLWYoxcoR/JlQ2J4wfZ1biCfluxafhXlJFfCLYs6sbnB/lLllzG1P2auEUunJ/XBUhfsUTiw==
X-Received: by 2002:a17:906:f59f:b0:a7a:c083:8578 with SMTP id
 a640c23a62f3a-a7daf64e2afmr137515466b.52.1722508619188; 
 Thu, 01 Aug 2024 03:36:59 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad90e34sm879705166b.164.2024.08.01.03.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:56 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 15/19] Revert "hw/ppc/spapr_pci: Do not reject VFs created
 after a PF"
Message-ID: <47279e8afa84cb28e84e3ac4392487b94a494fa9.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

This reverts commit 26f86093ec989cb73ad03e8a234f5dc321e1e267.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ed4454bbf7..f63182a03c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1573,9 +1573,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged &&
-        !pci_is_vf(pdev) &&
-        bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",
-- 
MST



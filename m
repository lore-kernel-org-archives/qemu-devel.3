Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD6DC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBJ-0000sq-BW; Thu, 01 Aug 2024 06:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTB5-0007zu-3r
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTB3-0001k5-MX
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jqJ2fB0CQSR8If0y+CDtptnZsaPIw8Y6Eo12ycGDsKk=;
 b=R5yVvBQnnuvzoEgtQ+ITvQjz31VfYWED+vWivX6r/q4BWtU+4TzQR9wEd6vSAZGkJjDO9H
 S9bFWvnVe2mz3/s+nA3QzVkqwIWDXGBwjt/SVz0PQImTGQgpjOCbdeUVhn1oPMVz5rRWNp
 WMNtTK0cGHB+SRsUQjozoMBXPdBpbXA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-C5mLd4NQNZWs59WViagp3Q-1; Thu, 01 Aug 2024 06:36:55 -0400
X-MC-Unique: C5mLd4NQNZWs59WViagp3Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7d6a72ad99so366082666b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508614; x=1723113414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqJ2fB0CQSR8If0y+CDtptnZsaPIw8Y6Eo12ycGDsKk=;
 b=TgayZhe3YqXa+40yGhcR45eC5xoLNGREIhzj/vLe8FBTL+ylMqIa+AJ+3jB7mcnmdQ
 063ejFXzCWApC68WakJdPSf3EzxYwcoJGIoA6jpTMbgrSKCq7iGVy69boRqAIwk7ZfgM
 2TOIxSlZf5NWmUQD+O0htnuir07p4/J/iWO0Jjvg/Yv7Cx3+uOk8skxRhKZSV6k0o8dy
 qFoUbBr8WPpMk0Kpt1ffJTbCO82eNb5YxWw/jtWsa65ZoDwCCM+L6mZZJzlEZclHfQQy
 wPTaAuBeqE2vWzUWA3bk3/KRAQ95RxiP5MD6hKlzDhw5Q05VNK0sRl0Ykmf6Ktq7k1yW
 xcJQ==
X-Gm-Message-State: AOJu0YwjAHlPXHHxas/O5OBqX0WTUbfMm0MCBSPi9Wq6dcImgmDKwrdP
 hCKgEME/JHQPJdwhlZOFyND1XFyQlOOAvA84waP0WkQJxV5CaoM/OTf/RjiRnDTcyN9OrbDUgiz
 BT+u/KMwXmugcswZgHMt46bagFlBMSLbpD/WPO2lVGg2K93ZJhmBpEyHFukMwcik8jgiGB7ctqL
 z++IOOtZ/EWyCR5SWCGZ37I8LuJ2VTwg==
X-Received: by 2002:a17:906:f58b:b0:a77:dd1c:6276 with SMTP id
 a640c23a62f3a-a7daf2d6ba5mr165355066b.7.1722508614509; 
 Thu, 01 Aug 2024 03:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsFCYUTvIayA1LXb+HSqUWTG6GPj5F8M58mPmv3WulQW0ncxPRXZQVTPASZKtZv/S0CyYlyA==
X-Received: by 2002:a17:906:f58b:b0:a77:dd1c:6276 with SMTP id
 a640c23a62f3a-a7daf2d6ba5mr165348266b.7.1722508613314; 
 Thu, 01 Aug 2024 03:36:53 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23639sm882511766b.9.2024.08.01.03.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:51 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 14/19] Revert "pcie_sriov: Do not manually unrealize"
Message-ID: <b0fdaee5d1ed52f650ca0c3bebfce3dd4dc8ddb5.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit c613ad25125bf3016aa8f81ce170f5ac91d2379f.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 499becd527..e9b23221d7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,7 +204,11 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
+        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
+        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
+            error_reportf_err(err, "Failed to unplug: ");
+        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A09C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBe-0000QJ-KN; Fri, 11 Sep 2026 05:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAm-0004v9-8E
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAf-0008M0-T7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2hNz4/jqFz0hJ0OYLcWq6vFd56S2mjD9cbtRudNy4aw=;
 b=X2dU40H8W+UjCiJl+QDzNJF6VUEYuNtZxby8B20Z336syfjRVMl3eQy9HWaOHxv6rx+22T
 to/4/wK+egy6EwRUNncQr6Evej5OMSBHCtPk4BqUtp/D2YF2zdEwvc4J8ft/raMrFSJ3DY
 ZR3/9xzXDgTGWciSNoMvHUxiqrqGghs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-GOTgL5sHMTaszy2k7YxY2w-1; Fri, 11 Sep 2026 05:03:43 -0400
X-MC-Unique: GOTgL5sHMTaszy2k7YxY2w-1
X-Mimecast-MFC-AGG-ID: GOTgL5sHMTaszy2k7YxY2w_1789117422
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so6056655e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117422; x=1789722222; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hNz4/jqFz0hJ0OYLcWq6vFd56S2mjD9cbtRudNy4aw=;
 b=fwFxkGnudnCEfS6HV0RRqQPyHqlW6Xl3BRbdrfNJUwHGhzYDA3NpcarDvh1dLeKX7t
 uK3Zr7gUxhe2dhA0VyQ8eh+k0KTvusiYobJd7SplLbcbMOKe1yuCc0ZRzo4z0eAlv5g4
 AOJB+8d87NSiS6gqYsO0yEKxp68mEbolDdNp8WbUw4pxoJUMHxDdXxBERXh1J1VcPEd1
 3TqxZ+khXBw1N6ExZWvmP7rff/cDRzmbGgWMvjzTv6JG4NS4r5alyC5o/ry6ye5M3yVJ
 uGJVDvvggxcnjYmsfaecLg4PT5RLjVo+5hvMiJrNpw5VVwEf7+MhqTKbLUVyLfXnWWIF
 yHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117422; x=1789722222;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hNz4/jqFz0hJ0OYLcWq6vFd56S2mjD9cbtRudNy4aw=;
 b=pzTksIkrJ8BDP9TPP/isXo7DlHWNlcQLxAkb3MAaxcKIwaOVE4ewkkDF14D+X1w53n
 z8EYhrxLW3CZIUjQtxN8HHV0HjjpINja+OYbae2M3g5VH4QvkBjv/5evQHwonD0qVWhN
 E4KqT3Xbw9f4VgPTpVI8mtJcvN4kSzakbP2XT+p/hmg+0yqHjRWA6QFBedqLR9hXKEEw
 pG40PRB/r74LpjWI3d8UJWWtwjesOncUqF52uSDliHpQzQnpriX9AElnJv1rTSSDAAUQ
 fSqTYxP55Ol99FwBlIgy7Xtpe6eQqFtEYw/ST6FeMvj228Vn0oLGLxcMdHnCgbGTNrBr
 TXpA==
X-Gm-Message-State: AFuF++mmxWuKwYwr71o4Nhf/qsMmhq2O899jAnJLvAwiefs95ETkmyQg
 +ZrVCrDOYuykhCddxc00rzv9L3AfuJZsh1419dUZX1R8mkLimrJVDvC4TvtHBBbvAxx/uSsgirI
 Y0rnS9nZD0/lEIOHDY0E4PiJUXzj13eRPkH0IFjezpI0/Q4eyXM6omcISb12PCHgvaQ06JwMuHJ
 Sdc0iAbQs26eRjYXM0VHDS2ajD9hT6av79xQ==
X-Gm-Gg: AYBFou3fdJabbyyY1r3kXS0tI1LDBvtphpqNH/xGhMarkZ/EaNgmPvGZWNXt2uYZNkI
 CNrvL3cbsmtO7RrgHqpYXZPrr7m0rY1MnsFajr0vJdzUoFaNeJNuHHuzXDEQxFPZ5rqhR+gqPrg
 tl1752GxTzc2xZiMaHvfNefCisIT/MV1h5xPDY/m6WDG3ycsckvsaP/LUAIcSsdYXI+XN1+Ckhl
 UjjU6kSJx/q385N4Gcyd/HkjHK7yMVA4ar4Q4P+e4TJaND8jvh9t5gBlT1cBENw4dWzzG66GV2R
 0gH8rn+E6UwdoW4huqb9qdfzHg9slUaF4CjN12jr8qyDxnEWgtfQ4p/YhrblOQm8uIC3Wer7V35
 SlCF1a58y7wIiLm5b8D8gK2o=
X-Received: by 2002:a05:600c:5391:b0:49c:fa21:1c7e with SMTP id
 5b1f17b1804b1-49e619bb6b3mr36033735e9.19.1789117422269; 
 Fri, 11 Sep 2026 02:03:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5391:b0:49c:fa21:1c7e with SMTP id
 5b1f17b1804b1-49e619bb6b3mr36032975e9.19.1789117421625; 
 Fri, 11 Sep 2026 02:03:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62121747sm37594735e9.2.2026.09.11.02.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@openvz.org>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PULL v2 60/75] pci: batch BAR remapping into one memory transaction
Message-ID: <6bda4e6abaafa3e6f49c4ca51d5a0f55337855fa.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

pci_update_mappings() deletes and re-adds a subregion for each BAR
whose address changed, and both of those commit their own transaction,
so one BAR move costs two full flatview rebuilds.

Nothing between the delete and the add touches an address space, so
the walk can run inside a single transaction. pci_bridge_update_mappings()
already does this for the bridge windows.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903184542.2629976-2-den@openvz.org>
---
 hw/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c15f2b9f08..14c78e3c62 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1742,6 +1742,8 @@ static void pci_update_mappings(PCIDevice *d)
     int i;
     pcibus_t new_addr;
 
+    memory_region_transaction_begin();
+
     for(i = 0; i < PCI_NUM_REGIONS; i++) {
         r = &d->io_regions[i];
 
@@ -1778,6 +1780,8 @@ static void pci_update_mappings(PCIDevice *d)
     }
 
     pci_update_vga(d);
+
+    memory_region_transaction_commit();
 }
 
 int pci_irq_disabled(PCIDevice *d)
-- 
MST



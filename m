Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C38C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBA-00073p-1g; Fri, 11 Sep 2026 05:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAi-0004ZA-2z
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAf-0008Lt-S6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
 b=JsZShD0Om3sCc8vs2FC8EBZ5Q62Id2knBRV7rgEW8ICtWNti7jnZxDeLpdqONvzFyI6HOu
 EiLYaXOp6uOIi8weYGNJe+j51p6/N6tLRO5j0M66EBtpjMN42pqCuqSi3Jy2On86mW+8NH
 HlucYb0KVnkiQn9ag8YMUfxr4gExkII=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-3aOm_GopNRuplp9koN5-yg-1; Fri, 11 Sep 2026 05:03:42 -0400
X-MC-Unique: 3aOm_GopNRuplp9koN5-yg-1
X-Mimecast-MFC-AGG-ID: 3aOm_GopNRuplp9koN5-yg_1789117421
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso3447495e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117421; x=1789722221; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
 b=F6BZt6hUHgbdJPshGE+U11pJW2vhWCWxpwsSHLOSgTu5zDJbWT/B8n5MedrygLxNSR
 syuGrtqL8hmUYByCvKdH/YK5lLfnoFMhVyIixMWfx+hN21C1+NIjD/GlkE3H4mTAll+s
 lNc2pj0/Cogfa2v0NW17k7NJgfhKxup4IwijXKNje03GeMHphfR1ggPn4lcRZUHHoQtg
 cQbop2Gj9VH+y7kzdagFHdVdOLEm86BnswKx2UgwTMOBZyikwpiXW7YnuLvZ3vRURYJi
 1zxnLjuBwKtErIxOqglE7LLWniMPPqb0zdpg/3Wltfxgzi81IS1MVi277ozTGH5Yknz5
 SrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117421; x=1789722221;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
 b=X8kxEnYNiWwKckBcJMt2ApMxKgBSloDKP8vJu7cO6YHYl8pSoJw/5RbFjKRgbtb0Jq
 vrSmQ94xlPFrJQczYo91cI7rLFNBy2ghbxjx5CoGR1MdD9PSq131MgBbjN8dd/DwgXBB
 fehX0UhQ+MfWX/8ECKYmtL1rY3/AuLCPkrezmdCnvG3E1izUCklMB8yelhpCe9G3/QQl
 6jUZx553y3I0Bff50B/WhIvDiLks0fBUpdnyPWeajzj/EyOAdNMN42v4kPqknnp9lXlA
 b6Iz6TSE/qwX6SjnOzQ5YW3Lhz+mIH0wzSQEtHE08d0JCJRwgLh3EWP1iEmcrb8rsBlk
 hm6w==
X-Gm-Message-State: AFuF++kuVecI4J9ss7wsyZiz4+l4YI9mJtG+jQSViOiCPJagP5taxVGi
 retD2Jn2Ms2bUnK6X9z6AMmCrI9EA5R94WgpQ7K8nWViOA61UDg331a6VaDM6H+PamcLllWkVHL
 MotqBCIovTVAB4rCfZPfyBkSo/jV0/p+m6afu0Ybk3MmiuXYDF9hXaa+5CY9jrZmR8jwpC4y11T
 W7WAHE6VZrmxM4KsalBtKu86coSyIfADJ11g==
X-Gm-Gg: AYBFou2NboyEDWWBu/oqXg2HtlpwWxjMizIjpwjiN9bJYitddb7495hDasRVNjzbn6v
 ZM+I52BWRALA98SN4PtKNVsK1O32ahtOjYPmapNV2MWjLGz/Eqe7cxcC9slLZgrqmak1yYA7NSo
 8OssiEH8QJvpreA0nhp5kumGZaLvubaX9kqtXajlX9khlAjNZw5MtsxCAPXD77AMLs2j9zGgQLU
 AwMebisgwVGLw+Z6VQcKfT2jPCiUTY7wsswejr9rUbNwx+UzWYame9KW3rs+M46vJNLHPh+tGIr
 4zHfy9Kh0HQa3DTpaWZbuQh/BFbZ5z8nO9q585ZG0vjpxWu03hdf1SMd9yaG45/OqMb9jJoP5DA
 NmbqazVuReLLbKGiUw8mMJoo=
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id
 5b1f17b1804b1-49e610829b5mr37824945e9.9.1789117416886; 
 Fri, 11 Sep 2026 02:03:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id
 5b1f17b1804b1-49e610829b5mr37818395e9.9.1789117410371; 
 Fri, 11 Sep 2026 02:03:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm69520125e9.0.2026.09.11.02.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:29 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL v2 55/75] hw/cxl: fix the CDAT DOE overlapping the Flex Bus
 DVSEC when sn= is set
Message-ID: <c9a5fd358cccd4c1616967973aedf39973833f85.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
With sn= the Device Serial Number capability pushes the block to
0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
catches this -- pcie_add_capability() checks bounds, not overlap, and
the chain still walks because the DVSEC's next pointer becomes 0x190,
inside its own body.  Most cxl-type3 examples in
docs/system/devices/cxl.rst set sn=.

Derive the offset from the DVSEC block instead, as cxl_upstream.c
already does.  Without sn= the layout is unchanged byte for byte; with
sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
type 3 device has no VMStateDescription, so its config space never
reaches the migration stream.

Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260831022302.406740-1-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6f44770db6..a04dc74ecc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
-                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
+                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
-- 
MST



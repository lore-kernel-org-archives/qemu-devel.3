Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D503C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treez-0004Rn-JL; Mon, 10 Mar 2025 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0f.v1-368be07599fc4a2893c4ac517d073408@bounce.vates.tech>)
 id 1treeq-0004Mf-Gl
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:10 -0400
Received: from mail186-3.suw21.mandrillapp.com ([198.2.186.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0f.v1-368be07599fc4a2893c4ac517d073408@bounce.vates.tech>)
 id 1treel-0005LX-VC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1741617935; x=1741887935;
 bh=4yf+U/Cs5iGe0IID9OfkhTo+yjG5clPxWQk9tooGuiU=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=hpbuo2SlDOg/BCtJw1pDwpvfIeAe4b8Hg1ktvPcf6hA2uCcd6auIrMilhsGorNc3B
 sSmHfhS/9nOUHE/rvLD4l92Q70W7J6bp5UQ/YbkxGNGQGyZPt4fiBlJdOmA6iXUcUX
 6IHuObUD5WgTtX4tBvAhv85o/QYOYEuD9lwiVuxUGuILRwpzolbrbyZ2speH1EDiXg
 gAYkeEvgNW+vdmzqDJCq7cX0K637BeUwZE0NBmQIfJ48acoZRgb2cuGxhp+dhp8TDc
 zktiw/DmiuvqTQ1MTRoKebgal/FoFqeehKWz3SSais8PT/QUWNMP/7LUarrGHqwd73
 4wNvSum6mcCog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1741617935; x=1741878435; i=anthony.perard@vates.tech;
 bh=4yf+U/Cs5iGe0IID9OfkhTo+yjG5clPxWQk9tooGuiU=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=Ukr40IJnjc1Wqxzu1vS5gMggtXf8z6WPW/NlJLw/0xBcaLZ30j1CHWCUUaqmEAXqu
 mWuGuxObi9PsCFhpN8DEoj3UbN0DJd9tgjYWf6cCBLgqAGauscD68VqlvcGIF3iEzw
 MJs2j086+yIZBIXBIWYIrg9NZkBp4QaeznfAowo3tutlKmFHueR3nZzQ3xJBsqxHam
 99abFQRUYKIrPuGeoG32XrjGc0iiffO05aAIdsJKSKDJEs/TVyrRrf8IQ1XofWHfhA
 //ZkVakfjqcXO8jbp1hL1AWiq2/F+8jq0xwUiCJxZ23uLF7gpVJKcbQn+lrt0Z5ruJ
 v7uRp1NaM/wTg==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-3.suw21.mandrillapp.com (Mailchimp) with ESMTP id 4ZBKSb182czDRJ18D
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:45:35 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=203/3]=20xen:=20No=20need=20to=20flush=20the=20mapcache=20for=20grants?=
Received: from [37.26.189.201] by mandrillapp.com id
 368be07599fc4a2893c4ac517d073408; Mon, 10 Mar 2025 14:45:35 +0000
X-Mailer: git-send-email 2.39.5
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1741617934091
To: qemu-devel@nongnu.org
Cc: "Stefano Stabellini" <stefano.stabellini@amd.com>,
 "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20250310144516.28828-4-anthony.perard@vates.tech>
In-Reply-To: <20250310144516.28828-1-anthony.perard@vates.tech>
References: <20250310144516.28828-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.368be07599fc4a2893c4ac517d073408?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250310:md
Date: Mon, 10 Mar 2025 14:45:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.3;
 envelope-from=bounce-md_30504962.67cefb0f.v1-368be07599fc4a2893c4ac517d073408@bounce.vates.tech;
 helo=mail186-3.suw21.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

On IOREQ_TYPE_INVALIDATE we need to invalidate the mapcache for regular
mappings. Since recently we started reusing the mapcache also to keep
track of grants mappings. However, there is no need to remove grant
mappings on IOREQ_TYPE_INVALIDATE requests, we shouldn't do that. So
remove the function call.

Fixes: 9ecdd4bf08 (xen: mapcache: Add support for grant mappings)
Cc: qemu-stable@nongnu.org
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Message-Id: <20250206194915.3357743-2-edgar.iglesias@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/xen/xen-mapcache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 00bfbcc6fb..698b5c53ed 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -700,7 +700,6 @@ void xen_invalidate_map_cache(void)
     bdrv_drain_all();
 
     xen_invalidate_map_cache_single(mapcache);
-    xen_invalidate_map_cache_single(mapcache_grants);
 }
 
 static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
-- 


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


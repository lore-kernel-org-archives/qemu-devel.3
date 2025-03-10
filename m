Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB64C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trefa-0004tN-DQ; Mon, 10 Mar 2025 11:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0e.v1-7bfbee78310241baba23d658a5e92bf4@bounce.vates.tech>)
 id 1trefR-0004me-5Q
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:45 -0400
Received: from mail128-10.atl41.mandrillapp.com ([198.2.128.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67cefb0e.v1-7bfbee78310241baba23d658a5e92bf4@bounce.vates.tech>)
 id 1trefL-0005Pc-QW
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1741617934; x=1741887934;
 bh=Jtw83zR8ClGIKsdVW1XH0izlnw0Jjgrfmv5Kbcmzc5U=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=F9VZpSRNhoH2eFbGO1IVbEiNTCls+MNNN+3ww7UNiNBQXxWVwkoKcDGryWsMgPWMb
 fqcTJmDHJ3I3lFRnNTDS2xli9+Y8CpCgZ7iEzeUQVZLcM/EKxRI/y+H0Y+jpUAwqDK
 0g0KOfJ62wQ/4+THO+IuDcvmAvbBlaX9g71WEVdMQRkKlJiN/uz80ix/OeluzqZdxY
 tuP6uYDbPURGTgd+246Va5jexhhYEAkZc4mWp7EFNhbb7VEVpPZW7C6OUwCIf2bd0Q
 ypHxuWUAu5hkTYM/grKE9zyWSyfTjKzbt9o+EYcQIng1ZTW8wEm6UxtkSBUPuURjly
 0VW8/p4/7p63Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1741617934; x=1741878434; i=anthony.perard@vates.tech;
 bh=Jtw83zR8ClGIKsdVW1XH0izlnw0Jjgrfmv5Kbcmzc5U=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=KU15XRe6+67N9xw/K7Pv7a2paah4fJm9Eml3/Vilzt1y1kKiAsC5doyHox7Ub3ysy
 9CpgU61fNnmc0+TWl/6Wd+eHfUWUPlIlGD7JS1xY6IUy0D+V0GuD5QfVO3NVL1956g
 5rBOnnGd9glGS80r3R8etujRAIohrMzRaS2K4ZBtDlyqWdG2lLQpBPDxWQSdMJX/H6
 XD/A0zwgdbK/q99chCWSW7Em5m6fBWkrh5edy0o7UtJcHD6FjGYUdmbCJaBLbWoYe6
 s6qe+JlbXstkDljmSQluSSc20Ag4a5U8Q6q6mIToVnF+uupTG9ugfPPpkWYvjR6hC/
 OxeNjnESEdkuw==
Received: from pmta08.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail128-10.atl41.mandrillapp.com (Mailchimp) with ESMTP id
 4ZBKSZ4FKCzLfHJ8h
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:45:34 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=202/3]=20hw/xen:=20Add=20"mode"=20parameter=20to=20xen-block=20devices?=
Received: from [37.26.189.201] by mandrillapp.com id
 7bfbee78310241baba23d658a5e92bf4; Mon, 10 Mar 2025 14:45:34 +0000
X-Mailer: git-send-email 2.39.5
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1741617933736
To: qemu-devel@nongnu.org
Cc: "David Woodhouse" <dwmw@amazon.co.uk>,
 "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20250310144516.28828-3-anthony.perard@vates.tech>
In-Reply-To: <20250310144516.28828-1-anthony.perard@vates.tech>
References: <20250310144516.28828-1-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.7bfbee78310241baba23d658a5e92bf4?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250310:md
Date: Mon, 10 Mar 2025 14:45:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.128.10;
 envelope-from=bounce-md_30504962.67cefb0e.v1-7bfbee78310241baba23d658a5e92bf4@bounce.vates.tech;
 helo=mail128-10.atl41.mandrillapp.com
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

From: David Woodhouse <dwmw@amazon.co.uk>

Block devices don't work in PV Grub (0.9x) if there is no mode specified. It
complains: "Error ENOENT when reading the mode"

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20250207143724.30792-2-dwmw2@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/block/xen-block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 2098286b5f..ec04102b66 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -408,6 +408,8 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
     }
 
     xen_device_backend_printf(xendev, "info", "%u", blockdev->info);
+    xen_device_backend_printf(xendev, "mode",
+                              (blockdev->info & VDISK_READONLY) ? "r" : "w");
 
     xen_device_frontend_printf(xendev, "virtual-device", "%lu",
                                vdev->number);
-- 


Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


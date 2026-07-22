Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8234C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPa-0008Cj-8G; Wed, 22 Jul 2026 08:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWP4-0004mH-PG; Wed, 22 Jul 2026 08:50:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWP3-0002Es-7K; Wed, 22 Jul 2026 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724391; bh=WIGktaQeAj84csc0PuuW++0gLrrRt0l8dxYk6jcHtFA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K0Ps3XLC8r5ayYARLc7VatYatZHtIMKNjDcNHwjXyEyJJ0qbFiqoVJOYoajFzLPry
 egBPY4omaRSokkzOkg513YYBGLpIOuQPVsIAfTrELRef3RQ8zSIWylP3Q0g2nuichx
 1Sy9phTwAzVIYh8mS3l6euMZ8kz+6Fqvb8/p2QXU5Nd+3EM8NZjk2gMgignePfv6zW
 ie9/zAT576MoTxo209YSBhiTT1ZYfhazpwQDX5nFkVkaVhsqGRQBA0Bnb7z6tyCnyn
 rR1IY4wuu2FKC8eP0PqSDfGfcLkuhtzoY2LH1JCxSGndmevl3MEIs81vLdGR8Pe2m3
 sqVYJWwyh1LFA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13E1C1C3B1D;
 Wed, 22 Jul 2026 15:46:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5AB413F3777;
 Wed, 22 Jul 2026 15:46:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 96C8C17F23; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 116/122] hw/net/xilinx_axienet: Fix PHY register
 17 link status reporting
Date: Wed, 22 Jul 2026 15:46:05 +0300
Message-ID: <20260722124622.31034-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Jay Chang <jay.chang@sifive.com>

The Marvell 88E1111 PHY register 17 (PHY Specific Status Register)
bit 10 reports real-time link status. Previously, this register
returned a fixed value of 0x8800 with bit 10 always cleared,
causing U-Boot to always detect "No link" even when the link
was up.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-id: 20260713064617.85374-1-jay.chang@sifive.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 83927347227c91dd659e7ed718d656ed0d551ab6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 457952af196..d2f98db1026 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -103,6 +103,9 @@ static unsigned int tdk_read(struct PHY *phy, unsigned int req)
         case 17:
             /* Marvell PHY on many xilinx boards.  */
             r = 0x8000; /* 1000Mb  */
+            if (phy->link) {
+                r |= 0x0400; /* Link is up */
+            }
             break;
         case 18:
             {
-- 
2.47.3



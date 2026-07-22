Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F52C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWR-000790-IP; Wed, 22 Jul 2026 08:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU1-0001Uu-0r; Wed, 22 Jul 2026 08:55:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTx-0003Kj-BI; Wed, 22 Jul 2026 08:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=7KEEn1Z5CkASTN+7BPdqiQvq0OrdbnWemm7/NWHglGA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sihqy0BXR/rqgbUXVgZ/eObB5NioVcv0saLSb4NysOBg7FTfOClCJrGuJ15cHZdEG
 Mayp5SVGtiF2LkH+k7DAZOe8eVzi+ziiUnCjH4gXrNcumetrxQ+c0VQ3BVBv+jIuGh
 qPPV1ASc/MRSZ6sR3HDkzPrvr8ACFhv0pnPW1P4Qpao/Tlqwh3GHx+mDUFsyaY+gTi
 sD5/8houdnpNbc8lAdhi4kv5oNVp8YW1W9Aob8UKry67440B/7WHo4cn75j6wab1Qt
 mc1Hr9xZyKIPuK7PLorjILqM4b1eqAG4Sqm30JAihMR9PAcr6rdif4LaKIzHllm3P/
 n+VDXSfYwJsTQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B0401C3B56;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A41D63F37A6;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id F0C6817F81; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 121/127] hw/net/xilinx_axienet: Fix PHY register 17
 link status reporting
Date: Wed, 22 Jul 2026 15:48:46 +0300
Message-ID: <20260722124859.32371-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
index 970732b162b..9f5f65ecfac 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F885CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXl2-0007p3-T1; Fri, 22 May 2026 17:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkS-0006sx-Oa; Fri, 22 May 2026 17:49:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXkQ-0002YG-7x; Fri, 22 May 2026 17:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486559; bh=l1KR96xyNj+NKF/aW1Gstxcyrzn+GA3PyPYJ/QGBQG8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J4mRuIQTBF58Z7/xhq3AHehMq3XB5l167dJul5eueA4B2mm1W3GD+5JpsfoXaF7Tw
 i4YSJzjsBkI4FQmnaxRxnbt81xWjoSvbOTIH2itu1PuZBWvN74nvrvdfq0zDMp1gKw
 ScbEqp2k2ht76EP3JYKiG8VPX7qEIg8HOqDD2F0yPcY683FCXS0afB1/GLb4MuOAJv
 I4A6ML/J+vV102wS0NWHDTzcJmlHF1y/BDnSxqhrZbwnWLhCtNeQ5W9BgseSA6ST9R
 c5HS0W3SdUIUMs2YPDlWFab0e72bGgcFHrL59orN3qciFfk5Jfm7UaHXlBOpbIMoCz
 Sm2BzOMTQfriA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 668E51AFB60;
 Sat, 23 May 2026 00:49:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E9F53B71AF;
 Sat, 23 May 2026 00:49:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?=E5=AE=8B=E6=96=87=E6=AD=A6?= <iyzsong@member.fsf.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 106/149] hw/net/allwinner-sun8i-emac: Flush queued
 packets when rx is enabled
Date: Sat, 23 May 2026 00:48:38 +0300
Message-ID: <20260522214923.807017-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: 宋文武 <iyzsong@member.fsf.org>

The RX_CTL_0 register includes the RX_EN receive-enable bit,
which allwinner_sun8i_emac_can_receive() checks. That means that
if the guest sets it we need to call qemu_flush_queued_packets()
as we might now be able to handle them.

This fixes a bug where networking didn't work in u-boot on the
orangepi-pc machine.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3459
Signed-off-by: 宋文武 <iyzsong@member.fsf.org>
Message-id: 20260430040753.3337-1-iyzsong@envs.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: expanded commit message, removed unneeded RX_EN test]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a7f27d6903b30bcea21c46986cb7507edcbc970c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 30a81576b4..9d73a99f54 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -727,6 +727,9 @@ static void allwinner_sun8i_emac_write(void *opaque, hwaddr offset,
         break;
     case REG_RX_CTL_0:          /* Receive Control 0 */
         s->rx_ctl0 = value;
+        if (allwinner_sun8i_emac_can_receive(nc)) {
+            qemu_flush_queued_packets(nc);
+        }
         break;
     case REG_RX_CTL_1:          /* Receive Control 1 */
         s->rx_ctl1 = value | RX_CTL1_RX_MD;
-- 
2.47.3



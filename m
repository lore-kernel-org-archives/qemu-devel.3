Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F5BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGQ-00042Y-6s; Thu, 30 Apr 2026 10:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iyzsong@envs.net>)
 id 1wIIh6-0004Zd-8h; Thu, 30 Apr 2026 00:08:09 -0400
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iyzsong@envs.net>)
 id 1wIIh4-0007ZY-40; Thu, 30 Apr 2026 00:08:08 -0400
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 7EF2C1C00DD;
 Thu, 30 Apr 2026 04:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1777522081; bh=M/o/a1TyFk+0yQMyxATHnbbQVaeQgIhIOXOPCY6uvpE=;
 h=From:To:Cc:Subject:Date:From;
 b=TKitUcOVcKYnGnoO4jWxDrYT/gzY+GH3agoRQ3J0dxCmMsprW2a4JCx2DoAGWq0xP
 9rd9BlNfdP909agM41AyP/y13RM/G7hJ8c1ZX38eRIpAzupSKpvKoQxa1QCBx+bWuv
 r6B4Un7QVHxEzIoaNOzzjMpHSMcXl6pecs6uwcS6nQzg7l1+tIVVzc7HTheS7AoebL
 kjlcm1yRyLwGP2gFw+NjeZlupTY+mXMI8YHT+Ujpzllexn5iAKaE8FR3iKAFja1GIR
 dozEBWoyu+Cp/HO+Cb6DB/pnSA+Jf54rgzH65/qRfnHaUBMaJ9qmNQamgx3X/wp84s
 g+3janzp1a0YPIdgEF6oj9i75U0RVAcgHSEwORpA/HkQxCLBcKqCVWjq8eRRR97Zpj
 OLjf/DhfKLs3PEBC54Wu+Zp71PXMbus8bu3EC56W2o5a6esZU9qslDs0eqG+ghv6QL
 Q5w/Ln8TYjrlKz1slvFlV32VBZX8FLivW6evFHubZyHICOi+nRjR0yvn7KhglIDrzv
 XH32e06kH6/+j9IDCxi2GFq9i6WBxAgGURS+n8CgvMGguzWUWeeFClTNy3SyCc9vw3
 5ymSBbXv5KWyjgaUWOfwR1Sf5ej2eUYdaWYgt37/Pa/iK7WB2bJHKnqh14+1A36BVC
 fX1pn1q/hBir91r6yR9lrqF0=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id HIpJV7EzxxDy; Thu, 30 Apr 2026 04:07:52 +0000 (UTC)
Received: from localhost (unknown [183.220.24.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Thu, 30 Apr 2026 04:07:52 +0000 (UTC)
Received: from noisemaker.lan (localhost.lan [127.0.0.1])
 by localhost (OpenSMTPD) with ESMTP id d6e4a97f;
 Thu, 30 Apr 2026 04:08:03 +0000 (UTC)
From: iyzsong@envs.net
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?=E5=AE=8B=E6=96=87=E6=AD=A6?= <iyzsong@member.fsf.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org (open list:Allwinner-a10)
Subject: [PATCH] hw/net/allwinner-sun8i-emac: Flush queued packets when rx is
 enabled
Date: Thu, 30 Apr 2026 12:06:49 +0800
Message-ID: <20260430040753.3337-1-iyzsong@envs.net>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=157.180.15.194; envelope-from=iyzsong@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Apr 2026 08:57:35 -0400
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3459
Signed-off-by: 宋文武 <iyzsong@member.fsf.org>
---
 hw/net/allwinner-sun8i-emac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 9b7c67ae8e..7cc06b73c2 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -727,6 +727,10 @@ static void allwinner_sun8i_emac_write(void *opaque, hwaddr offset,
         break;
     case REG_RX_CTL_0:          /* Receive Control 0 */
         s->rx_ctl0 = value;
+        if ((value & RX_CTL0_RX_EN) &&
+             allwinner_sun8i_emac_can_receive(nc)) {
+            qemu_flush_queued_packets(nc);
+        }
         break;
     case REG_RX_CTL_1:          /* Receive Control 1 */
         s->rx_ctl1 = value | RX_CTL1_RX_MD;
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D86C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 19:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX4wU-0007P6-NT; Mon, 05 Feb 2024 14:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rX4wT-0007Ow-4C
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:47:45 -0500
Received: from bongo.birch.relay.mailchannels.net ([23.83.209.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rX4wN-0002KT-4v
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 14:47:44 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B20C885166
 for <qemu-devel@nongnu.org>; Mon,  5 Feb 2024 19:47:32 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id E2756850EF
 for <qemu-devel@nongnu.org>; Mon,  5 Feb 2024 19:47:31 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1707162452; a=rsa-sha256;
 cv=pass;
 b=KgFADD3KvU4d5P6Uk5hp+AOnzLmtTuV+AlKIanzgb1Cx5RV36OteRoAqitKlKgXCB2ft47
 imgNgmxBEHXhTCIkPeCu4ixihFLJsAnYcn0DfwhNqxygqZLYyhElbwBtCkk60526jeM5Cr
 kfocoPhnjCorHzYKu8l2VLfOmKzt6fjOrCsTL4lBhHXCD9g5u9JqsM7Dn7rohwjSeEGqv4
 vqjqZtPBYtkrqPchxisMo8VIrJpNpSP9UB8rJdWPiGSGckOW5CovL5eyLJMMyRmA542KrI
 eaYguRVgaQBpSiP6/GkRosBXTR5JlVdsPBmVdKJgyBVgXy3huSz79yk50HoFew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1707162452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=hnkXYgQtG2uagHtZsqwImaSw2G/POYXWA3hgil2YjQs=;
 b=Wwqddpvyv8QIypRHET4hAfggXBnWGRrvT3lOF8+K12A8HbvbASkZQeH6Muw0w2/zuO7HIq
 YDVvm34i463TpPyyIDNHJn4PuyuF1GRJ4mRHOi+ePEmCMgrl9S6TTCZHEYfJIOTGdsHsm0
 hkU9lbE2ExxiodKM5TTI/p7PXOTa0NKfkNtKVq7dBpa/wmqP9kKCuWYLtinyvJ1DNPpSKO
 RHvXxlTt5uPZWesbDb4DpdGPOQIyTvg3xLxrSky2IFrnfA12dFz0OlKFjjAKrYTcWgTMyx
 d1AJQ9Ganncc/g0J30KcUrV/hK5cXAYQstxX6VDnxHQE/VterBFhUjb8xJdtnA==
ARC-Authentication-Results: i=2; rspamd-6bdc45795d-nlq29;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Gusty-Lyrical: 45ca9ef56b077543_1707162452423_3940978444
X-MC-Loop-Signature: 1707162452423:434020675
X-MC-Ingress-Time: 1707162452423
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.22.107 (trex/6.9.2); Mon, 05 Feb 2024 19:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1707162430; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Tlf0rbB85ipg1B8SRcmVHXPL8aJhOy75Pz8uMWqdXJfJjoGh92PHouc8rioOFtlAMwvf0ePuWlOzz
 ZhFWZ0QCIFbZSoZM/B2BA98NoyyDgqT2fGiTGzKgZBWQOZXYWlVQQCQAV/wt9IC++1DjwjkzVG7e4X
 6pk2voDCQ19tBOxDhgrxvkjUJilwD06Vz6Sgh1x1qHEcr7NcYFtO/XRlJLXMQNjDZhQIlkpQM5hkBj
 +iQv85t0kG1T1XjIEXy6tm+0Btwib4yjT5Uq69jot/j8NyEebGNaN+pWAsARUfT10xAoxvc2D/8LpW
 GRfyTMHxXgWww8oPNnCupUBuZOjOEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=hnkXYgQtG2uagHtZsqwImaSw2G/POYXWA3hgil2YjQs=;
 b=B+eFx3N7+R50XpDRhYRWqK7BLBnNUP7GC15yt3BOs/casqiq2INoCiZigkKA3vU2oLOgCMvg5YTGw
 PrsIcg8nY6zgtRj2qF6ldWL6+nIIiOD0OWpQmGrGcRfoGIY6RoHSdNt/72LMzPanzod6ER86Y/NDaa
 QJXFBYx42mzGH+AFLP/ZDB9n94Qe1A+ukk9sWxSX7ussbtTCWMvP3R3oxTFp+5eydJaNSJBMKeWoEN
 kb6XEjFYsVK3weGp7bNyv+cpKqt1xyuMaNSZBf6MXa1sR3cuV+y/x380BZNkmPCBZK2fDQMqLpjD82
 94jkYE2hZulwqZV9OHowsG5SRYaz0BA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=jUL37gM9; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=hnkXYgQtG2uagHtZsqwImaSw2G/POYXWA3hgil2YjQs=;
 b=D5g7GJ5DGN02NajyKqDKJSIEKAlzAG1vDcChvlsSt8wUC9fgDB0fpPSl5YRJ30c6ySVMwk6IJqcAc
 1qpIbodJo9EPxT0ydvQd6oxd2DVRCmMQCPupFW30Kr6O2Klxm3izZwlDXpWxtI2VxJkrMtCwb5sApP
 bXx6hA2Pw6EiORro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=hnkXYgQtG2uagHtZsqwImaSw2G/POYXWA3hgil2YjQs=;
 b=VXuy4aAeal0Bhl4pshM0J0nQoguoD/e24XFuWA5k1FzoOaAWmpSf1rLv71NS1VuPn3huHuB3rAesJ
 azkeNnzsjKcLUCBX3pTRqeYIdw9Ysm2wvBBkmePmiyJzVPa7NDPTMKj+RKoapR4bLdZs6IinRafc2x
 GbidVZUwNar5kJ1np2ZAwqcSM6uoTOrFbgVBaRLKcN3XThZyvve6ZOtzmBTEMCCgRU+Caya7D57tpO
 7ex1x6utdFingv5OFLQopPX/WCFPojp0ibt3CMVjLrrV4IFgP/Rc/7M0pgsU1/3LbR7MqbUo51Ng2/
 jRvDR849hUNhMvWs4RVWErgYsyHW00A==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 582e517a-c45f-11ee-a9e0-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 582e517a-c45f-11ee-a9e0-eda7e384987e;
 Mon, 05 Feb 2024 19:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hnkXYgQtG2uagHtZsqwImaSw2G/POYXWA3hgil2YjQs=; b=jUL37gM9dSr9xlmNFdfmq3p2/b
 hoWflpcDzwgWYpZ38lvYV2cDHohvWKjl39Oueup9uUQiOFE0gyMPSQ8b4XihpxJgYPcmRxIG9E8u+
 b1AkOXMqJTG867Rrha5f9bnodW/0liY5O0Oc6BzXXu1Q1/PdlCy7ytRCYAR1GBA5n1WjpwX8atD02
 o+A1RYdpuEOWOmJQT3XIq7aR4ejckymU5E948QTxxYNRYykOaNkr9VgkW2qVw47o+XXR8obw5dvWF
 in4jzoj9Qcj4i3Atu58vsVVKleLTpL8pSfmi8G6IhJzP31uufrwb5FG7sw0HXNWK82b+LSBGKrxd+
 PAij5DEQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rX4wB-002OGe-1A;
 Mon, 05 Feb 2024 20:47:27 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Sven Schnelle <svens@stackframe.org>,
	Jason Wang <jasowang@redhat.com>
Cc: deller@gmx.de,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/net/tulip: add chip status register values
Date: Mon,  5 Feb 2024 20:47:17 +0100
Message-ID: <20240205194717.2056026-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.21; envelope-from=svens@stackframe.org;
 helo=bongo.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Netbsd isn't able to detect a link on the emulated tulip card. That's
because netbsd reads the Chip Status Register of the Phy (address
0x14). The default phy data in the qemu tulip driver is all zero,
which means no link is established and autonegotation isn't complete.

Therefore set the register to 0x3b40, which means:

Link is up, Autonegotation complete, Full Duplex, 100MBit/s Link
speed.

Also clear the mask because this register is read only.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/net/tulip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 6d4fb06dad..1f2ef20977 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -421,7 +421,7 @@ static uint16_t tulip_mdi_default[] = {
     /* MDI Registers 8 - 15 */
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     /* MDI Registers 16 - 31 */
-    0x0003, 0x0000, 0x0001, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+    0x0003, 0x0000, 0x0001, 0x0000, 0x3b40, 0x0000, 0x0000, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
@@ -429,7 +429,7 @@ static uint16_t tulip_mdi_default[] = {
 static const uint16_t tulip_mdi_mask[] = {
     0x0000, 0xffff, 0xffff, 0xffff, 0xc01f, 0xffff, 0xffff, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
-    0x0fff, 0x0000, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff,
+    0x0fff, 0x0000, 0xffff, 0xffff, 0x0000, 0xffff, 0xffff, 0xffff,
     0xffff, 0xffff, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
 };
 
-- 
2.43.0



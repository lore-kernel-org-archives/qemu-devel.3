Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C385AC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 21:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uReAv-00068U-57; Tue, 17 Jun 2025 17:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1uReAi-00067W-0a
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 17:48:48 -0400
Received: from aye.elm.relay.mailchannels.net ([23.83.212.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1uReAg-00078a-7t
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 17:48:47 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 97D952C4491;
 Tue, 17 Jun 2025 21:48:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com
 (100-96-75-84.trex-nlb.outbound.svc.cluster.local [100.96.75.84])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 24DFF2C45D3;
 Tue, 17 Jun 2025 21:48:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750196922; a=rsa-sha256;
 cv=none;
 b=xIgxGyDP0OiwV9f1lyyjbxDNz6P90ubrO4ZO7st3fPh+Z05B33HXsziZeZSxxhPypWvBBf
 +EBqVy2jPXeDQjSGHiwWZpeyubmWCc4kZspRI/AXCeyDW6k/Xdy4+GF08uoEMPoAJwGfcw
 HmRLquw4cVG7HJQhJPs1ajJdvHFDV4PeVi2M33VZMTrgv/EDxXdILmqknF51SCvRqpZoeG
 FBiPBNY5gCbP/5LBA/MHENGvg4BPhyWMm0c1bOfspsabR0paDrDmX+0CgDh0P1Rn7R63zO
 i+xYkZAYGvDpr+QOzflOXWLTWxcc0O+5hrDSQJ/V/S/mQ79hisYfJh0qj8CtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1750196922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=O+H+ub5Z0zzETPUmqgVWsKgHUDPnHyicCgY2PeQ0rH4=;
 b=hKpqrFyzpVx08Vnc6D+Tcb9Jzfeve2rQ3J6QX+hE0nY6WjzLWQ5YcHJLJEdxxZi+x4eyXh
 bu1eggIvksVgGmvsMVqcVyeoxNr9dyoZ/0aFHgfk9ZdMA48BoeuXmDfcmc0cGm9teXHi+k
 M/s9CIFkI/7ZK3HnRdoaIaiFespvzDdqglZPs/jMMo18dA67sttn8vQwwe/MLty9A7JQgG
 HUtZ/F/VFwmxZUf08GJWHG/dcWb2Ey45PZbzxCquG6HixsUziEBbUbAzTPUAe/zds6Z6kU
 VMkC/B33LH3r0d7qNPs1Mc3NpWnbdd6EZWT2pZSxuNpPeLVmYGeezrDH/QWSXQ==
ARC-Authentication-Results: i=1; rspamd-5859dfb5d9-g2595;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Belong: 3ffe89c608d2b78b_1750196922415_2858683198
X-MC-Loop-Signature: 1750196922415:4242759945
X-MC-Ingress-Time: 1750196922415
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.75.84 (trex/7.0.3); Tue, 17 Jun 2025 21:48:42 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com
 [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4bML9544nGz1P; 
 Tue, 17 Jun 2025 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1750196922;
 bh=O+H+ub5Z0zzETPUmqgVWsKgHUDPnHyicCgY2PeQ0rH4=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=QnfQeXiyCRW17gh5Bg/WFDYSXMF1S0BI6WeCsw5XsB1g4s0drsKtJMIqWxT38PwLv
 SJf9hDnKQ0qKQvZxWGQ29R7VJ2ROMnLurIloTvez4qA5GNjOdezp9uk0oXNwCiTPQo
 ss35knwY3/MtcxHOXypeAsiC1ez8sMi6jI323RGhLRxBnsiwUmYufBu7bIHXo186jd
 gSGKstikhD+tq71Dmqfy8+9xg0r7/ANiGDh08rsl1W5g/kfHkr/La6YGkAGrsavBBi
 pLEQ/XFTNrcU1hZ9uuswjkhCx2Ls1bzqAUN3sYWsRLBQ5Wu6FXDAkLgzksDXbslUxS
 goSEMoJ3n6QWQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan.Cameron@Huawei.com,
	fan.ni@samsung.com
Cc: ravis.opensrc@micron.com, ajay.opensrc@micron.com, dave@stgolabs.net,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: [PATCH -qemu] hw/cxl: Use runtime for bg cmd running semantics
Date: Tue, 17 Jun 2025 14:48:32 -0700
Message-Id: <20250617214832.579960-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.212.6; envelope-from=dave@stgolabs.net;
 helo=aye.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The current check incorrectly misses the 0% case, which semantically
can either be not running or one that just started. The runtime
is a better way to check for 0%, 100% or aborted. This is currently
benign in the kernel equivalent without cancel support.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

Applies against 'cxl-2025-06-10' from jic23 tree.

 hw/cxl/cxl-device-utils.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index e150d7445762..add0ab615976 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -95,13 +95,10 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
         }
         if (offset == A_CXL_DEV_MAILBOX_STS) {
             uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
-            int bgop;
 
             qemu_mutex_lock(&cci->bg.lock);
-            bgop = !(cci->bg.complete_pct == 100 || cci->bg.aborted);
-
             status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
-                                    bgop);
+                                    !!cci->bg.runtime);
             cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
             qemu_mutex_unlock(&cci->bg.lock);
         }
-- 
2.39.5



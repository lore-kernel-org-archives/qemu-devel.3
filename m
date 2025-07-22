Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1837FC83F25
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 09:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue8wu-0003Vw-Ug; Tue, 22 Jul 2025 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1ue8wr-0003Rc-76; Tue, 22 Jul 2025 05:06:09 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1ue8wl-0002Wy-4Q; Tue, 22 Jul 2025 05:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QDcUolgcaz6Olmv4pajis9trn1JJchKUxKgm1PbCVZQ=; b=wRV2VJozl/Cf8MXvhvYbHss4I6
 S6x/hOjtKXQ2yMOP+uj//LM0BzjHhAy0mrEvvuZKBaYPMBupp42u1rABF8XLUYXnn3tjCLN3R5D7l
 FZDkbDR41ZEFvGwMz1h2kZkUCv+kADG3ok0wXgTJPGvxklTt7sLOIcW0pCij54K2QdgylBhLH4Ap1
 NC9RotkBsV2SZj6Pu6IipsSnQJHd5bzZi5tCpFEhgHlBuVkOdKbPFENvbZDfecA5xCn8M7pX5Xbn+
 Nbd7TVggNFjxgIVls/Kt/4wkYCvauMUVBUXFUEno1VydYMklfbdIZKDSba6HxqwTYWD/uWxdqd9+I
 6/zBN1TQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1ue8wa-000ILg-Lw; Tue, 22 Jul 2025 10:05:54 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1ue8wb-00000000SOA-193f;
 Tue, 22 Jul 2025 10:05:53 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] hw/sd: print bad s->arglen in unexpected response
Date: Tue, 22 Jul 2025 10:05:47 +0100
Message-Id: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.157,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If we get "ssi_sd: error: Unexpected response to cmd" then having
the bad s->arglen would be useful debug and does not add any complexity
to the code.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 hw/sd/ssi-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 6c90a86ab4..f1441d2c97 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -183,7 +183,7 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
                 s->response[0] = 1;
                 memcpy(&s->response[1], longresp, 4);
             } else if (s->arglen != 4) {
-                BADF("Unexpected response to cmd %d\n", s->cmd);
+                BADF("Unexpected response to cmd %d, arglen=%d\n", s->cmd, s->arglen);
                 /* Illegal command is about as near as we can get.  */
                 s->arglen = 1;
                 s->response[0] = 4;
-- 
2.37.2.352.g3c44437643



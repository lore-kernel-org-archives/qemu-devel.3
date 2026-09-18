Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11580C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 09:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7VLn-0001l2-Bi; Fri, 18 Sep 2026 05:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x7VLk-0001km-Mq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:57:44 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x7VLi-00061c-0U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 05:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789725440; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=t6B3Hmi6/wt4BzgK76LeXSgNmOywanfs4/UuSOxIqd8=;
 b=Kkd6GqjmhElHA/zrDqWOH+RqrWA8COdNQks7d/eJgttbNm/+vkTgXbVBYNukQ60U5jpev9wp4XCfwL0H0RndV71ULqiBacKatgzAXeB+4ISUjSOxbOI2qzme1UjsHXw5Uxxc4Ry/KQYz4p6eUbPwCksYJ6LX94h0Ik3A8tqT47A=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=1; SR=0;
 TI=SMTPD_---0XBAzfrM_1789725439; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XBAzfrM_1789725439 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 18 Sep 2026 17:57:20 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb/canokey: validate endpoint number in
 canokey_handle_data
Date: Fri, 18 Sep 2026 17:57:18 +0800
Message-ID: <20260918095718.33745-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

canokey_handle_data() takes the endpoint number from the USB packet
(p->ep->nr, guest-selectable 1..15) and uses it to index the fixed-size
ep_out[] / ep_out_size[] arrays of CanoKeyState, which hold only
CANOKEY_EP_NUM = 3 entries.  A forged bulk-OUT transfer on any endpoint
number >= 3 therefore reads a bogus length from past ep_out_size[] and
writes guest data through a wild pointer read from past ep_out[].

Validate p->ep->nr against CANOKEY_EP_NUM and return USB_RET_STALL for
invalid endpoints, before any array access.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4481
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/usb/canokey.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index c3baedac2c..91dd886761 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -189,6 +189,11 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
 {
     CanoKeyState *key = CANOKEY(dev);
 
+    if (p->ep->nr >= CANOKEY_EP_NUM) {
+        p->status = USB_RET_STALL;
+        return;
+    }
+
     uint8_t ep_in = CANOKEY_EP_IN(p->ep->nr);
     uint8_t ep_out = p->ep->nr;
     uint32_t in_len;
-- 
2.50.1 (Apple Git-155)



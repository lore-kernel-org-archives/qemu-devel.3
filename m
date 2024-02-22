Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BACC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 00:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcwZS-0007Y8-J7; Wed, 21 Feb 2024 19:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc4@cl.cam.ac.uk>)
 id 1rcwZQ-0007Xq-Nk; Wed, 21 Feb 2024 19:04:12 -0500
Received: from mta0.cl.cam.ac.uk ([2a05:b400:110::25:0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc4@cl.cam.ac.uk>)
 id 1rcwZO-0004oW-MN; Wed, 21 Feb 2024 19:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cl.cam.ac.uk; s=mta3; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOqpFpRHeNTJkIs3ZCo+XPQx0TPFGZAjY2V7pgRTXhg=; t=1708560247; x=1709424247; 
 b=NssVUuuYlpPQK1LRMcVMpFo2NEErxEXEh4sDRhJTek5ol/Nbr8cED28HcMFnHgTPEKpcSI+pynI
 9I76pPZ21JOR7r3/F7AbMtt4n2jd066hAVemjcx9nZWceUyAmrBuJdGb9qxLb1vu/CufwBC2hRMoS
 QVpyzZeFVnCP7iDhXY4bjQ9WGZybjfiJ3fvbzHgdGkn+HahOZ76GStyz+GmaM2R59CpkpOKBxDsy1
 Hc2+Bcty7HVIKm3HtvQoKXTxfjjJMx25cgif6LvV5dytClba/0Tqpvu4ru2XeyBJb3drnuRpBmpa8
 +0a0brA0mBZUHrGvCyIvGrxlq+iIxPxft+TA==;
X-CL-Received-SPF: pass (mta0.cl.cam.ac.uk: )
 client-ip=2001:630:212:238:e63d:1aff:fe8d:4a70;
 envelope-from=jrtc4@cl.cam.ac.uk; helo=technos.cl.cam.ac.uk
Received-SPF: pass (mta0.cl.cam.ac.uk: )
 client-ip=2001:630:212:238:e63d:1aff:fe8d:4a70;
 envelope-from=jrtc4@cl.cam.ac.uk; helo=technos.cl.cam.ac.uk
Received: from technos.cl.cam.ac.uk
 ([2001:630:212:238:e63d:1aff:fe8d:4a70]:34906) (dnseec=no)
 by mta0.cl.cam.ac.uk:25 [2a05:b400:110::25:0] with esmtp
 (Exim 4.95) id 1rcwZD-00HXhZ-SY (envelope-from <jrtc4@cl.cam.ac.uk>);
 Thu, 22 Feb 2024 00:03:59 +0000
Received: from jrtc4 by technos.cl.cam.ac.uk with local (Exim 4.95)
 (envelope-from <jrtc4@cl.cam.ac.uk>) id 1rcwZD-006YTc-3J;
 Thu, 22 Feb 2024 00:03:59 +0000
From: Jessica Clarke <jrtc27@jrtc27.com>
To: qemu-devel@nongnu.org
Cc: Jessica Clarke <jrtc27@jrtc27.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] pl031: Update last RTCLR value on write in case it's read back
Date: Thu, 22 Feb 2024 00:03:41 +0000
Message-Id: <20240222000341.1562443-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a05:b400:110::25:0;
 envelope-from=jrtc4@cl.cam.ac.uk; helo=mta0.cl.cam.ac.uk
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The PL031 allows you to read RTCLR, which is meant to give you the last
value written. PL031State has an lr field which is used when reading
from RTCLR, and is present in the VM migration state, but we never
actually update it, so it always reads as its initial 0 value.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 hw/rtc/pl031.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
index 837b0bdf9b..563bb4b446 100644
--- a/hw/rtc/pl031.c
+++ b/hw/rtc/pl031.c
@@ -141,6 +141,7 @@ static void pl031_write(void * opaque, hwaddr offset,
         g_autofree const char *qom_path = object_get_canonical_path(opaque);
         struct tm tm;
 
+        s->lr = value;
         s->tick_offset += value - pl031_get_count(s);
 
         qemu_get_timedate(&tm, s->tick_offset);
-- 
2.34.1



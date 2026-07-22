Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F72DC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWST-0003tx-7l; Wed, 22 Jul 2026 08:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQu-0002a9-0Z; Wed, 22 Jul 2026 08:52:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQq-0002Pw-Ot; Wed, 22 Jul 2026 08:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=xA5u8nJYF9vnWZFwGfXYwzuNFkIK2ztMZiO7HgNPOaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UXzDTmq+og2swxUp3oMxd1HI/mxxvNkxRoY5+CFlRmo6KxHnVs/TH1I91Nt1VO0I6
 n6uqcVFfuiRuD8JIUVdhyeY9yjaT82Jt9CsGkpPo+oQto2hgcaOWTj9GzRY/1dvjiL
 7qBVlcB8fuzlhMaos0zd4czXQYODo6hF/cEd+RVrJuiYzsD6uGccpNCCyeV9oDrPcP
 GItSnyfHB0i7uYqw55lj9cySbf1Q4KOcCeGAJZqhDyBp0oHbxaBcACKLB8X1rqRAHY
 dFkYMb//69n9dVSMflnv5E9LsI2dn0XBoiYFFMCZiQg4Dn2m1iOBcOrajcNQ3TG6+x
 VyCoxB1CnqmrQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B63861C3B39;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0AC493F3789;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AC42017F47; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 092/127] s390x/css: firm up handling of chained TIC
 CCWs
Date: Wed, 22 Jul 2026 15:48:17 +0300
Message-ID: <20260722124859.32371-11-mjt@tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

The logic in css_interpret_ccw() correctly returns -EINVAL if a
Transfer-In-Channel (TIC) CCW is command chained to another TIC CCW.
The same routine also correctly returns -EINVAL if 256 CCWs do not
perform a data transfer as part of the I/O operation [0].

What is missing, however, is a combination of these two, where a loop
can be generated that will continue processing CCWs but without
providing an opportunity to catch a breath. Fix this by capping
the number of TIC CCWs in a channel program at the same limit as
the CCWs without data transfer.

[0] See "Invalid Sequence" in z/Architecture Principles of Operation
    (SA22-7832-14), p16-27

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260713074708.884282-1-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 33bece0fa121c0a85df4f0372145ca74b967e78e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 13a0e113703..e53b823bc90 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1076,6 +1076,12 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             ret = -EINVAL;
             break;
         }
+        /* Limit the number of TICs in a given channel program */
+        if (sch->ccw_tic_cnt == 255) {
+            ret = -EINVAL;
+            break;
+        }
+        sch->ccw_tic_cnt++;
         sch->channel_prog = ccw.cda;
         ret = -EAGAIN;
         break;
@@ -1127,6 +1133,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
         sch->ccw_fmt_1 = !!(orb->ctrl0 & ORB_CTRL0_MASK_FMT);
         schib->scsw.flags |= (sch->ccw_fmt_1) ? SCSW_FLAGS_MASK_FMT : 0;
         sch->ccw_no_data_cnt = 0;
+        sch->ccw_tic_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
         /* Start Function resumed via rsch */
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d3326237c9f..79b41f305e8 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -132,6 +132,7 @@ struct SubchDev {
     bool ccw_fmt_1;
     bool thinint_active;
     uint8_t ccw_no_data_cnt;
+    uint8_t ccw_tic_cnt;
     uint16_t migrated_schid; /* used for mismatch detection */
     CcwDataStream cds;
     /* transport-provided data: */
-- 
2.47.3



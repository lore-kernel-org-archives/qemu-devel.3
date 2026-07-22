Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2986BC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWMR-0002xK-SO; Wed, 22 Jul 2026 08:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMG-0002nU-7H; Wed, 22 Jul 2026 08:47:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWMC-0001mu-Hz; Wed, 22 Jul 2026 08:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=OcYwZc34stgULov+pGXFoN3p7Da5ufsOWcySG86J41I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZVM4zg7IBysvLbxCO25tFga/2fNy0lZQ7kVLz7k59j5xQBTLFLbTcWBpFM6fv9Cg8
 BX141lvikgxP+UpBT68qzvteljX2kXNMtvA0EB5OAyK4RUzw8WqLcTGzCWmsGVFu/i
 3wd/wQ6yQ/U4E8e4iq/3QijdHh6E1i1kYpyICsVrXo4x1qw27C75s4Ldk16IRt9uSg
 bUZGhHCOHh1X9Mxmj8uX2LD7ZylQe0fWXNQdLnqBJzRcB5Cyf+IwIwigDvA053CqUo
 MNoIxyubCFOZokgamQM32h65hgaKeikKJTJZln46O+PcNdaicvKEQz9u3AusikkZbv
 maSBgB8KN+xzg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F7201C3B01;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B72503F375B;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 544BF17EEB; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 088/122] s390x/css: firm up handling of chained
 TIC CCWs
Date: Wed, 22 Jul 2026 15:45:37 +0300
Message-ID: <20260722124622.31034-13-mjt@tls.msk.ru>
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
index 38d2d90028c..991fc126089 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1104,6 +1104,12 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
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
@@ -1155,6 +1161,7 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
         sch->ccw_fmt_1 = !!(orb->ctrl0 & ORB_CTRL0_MASK_FMT);
         schib->scsw.flags |= (sch->ccw_fmt_1) ? SCSW_FLAGS_MASK_FMT : 0;
         sch->ccw_no_data_cnt = 0;
+        sch->ccw_tic_cnt = 0;
         suspend_allowed = !!(orb->ctrl0 & ORB_CTRL0_MASK_SPND);
     } else {
         /* Start Function resumed via rsch */
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index cd97e2b7075..9ee66ca39ac 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD2ECCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0c-0005mY-Uq; Sat, 17 Oct 2026 16:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0E-0005H9-8l; Sat, 17 Oct 2026 16:27:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0B-0003vD-5K; Sat, 17 Oct 2026 16:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268832; bh=VcvUbPAXldWAHPO6IWKGzyVdoVokx/0DFamuIiWP80k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S5jaJOj+tWpRGb5IHpnT1AWMo2gDgSu08By8SWWf02hLOYZGEtlJOltWSJbXea8AC
 iU4gSCaQViQdmQN17jTPmk3D54M6hFy26MWtGVVzU8qzWVwMNnKlL+BhY+YAuCLSmQ
 A7s73Ms9CTdU9CGpfJUH9g19CMj5swZiA7b572D9IvfmTfYzLc0qPF3rZPgEEXlMAh
 Yi/uNFF7jkbwvX75z+8300dpTGy8psvCqCIhcttaAX51GDBYPnpV3yrBMLnpBq8eLU
 mrrefhAMvbA27VWp7D/+pSmj/PGyi8i53gMughvf28jBYhBf3B5RGJMAGv7zooRNUQ
 FA0UYQ5CMnV9g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 92ECD1DE745;
 Sat, 17 Oct 2026 23:27:12 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D6F6744341C;
 Sat, 17 Oct 2026 23:27:11 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 10/73] s390x/css: Use datastream pointer for checking
 no-data CCWs
Date: Sat, 17 Oct 2026 23:25:28 +0300
Message-ID: <20261017202638.728621-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

The channel subsystem will reject channel programs that incorporate
256 CCWs without a data transfer, but the existing check to account
for this only does so for CCWs with a data address of zero. Other
valid CCWs that wouldn't transfer data are not accounted for.

Rather than re-inventing the wheel, use the output of the datastream
at the end of the entire CCW parsing tree to indicate whether data
was moved or not.

Cc: qemu-stable@nongnu.org
Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-9-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 930a188edbbcbd68aadaa1db22e4db1b785a2171)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 9be895a797..d4d4f4a220 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1016,13 +1016,6 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
 
     check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
 
-    if (!ccw.cda) {
-        if (sch->ccw_no_data_cnt == 255) {
-            return -EINVAL;
-        }
-        sch->ccw_no_data_cnt++;
-    }
-
     /* Look at the command. */
     ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
     switch (ccw.cmd_code) {
@@ -1103,6 +1096,20 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     }
     sch->last_cmd = ccw;
     sch->last_cmd_valid = true;
+
+    /*
+     * A CCW that transfers no data is allowed, but ensure an upper limit
+     * is established to prevent long-running channel programs that don't
+     * move actual data.
+     */
+    if (ret == 0 && sch->cds.at_byte == 0) {
+        if (sch->ccw_no_data_cnt == 255) {
+            ret = -EINVAL;
+        } else {
+            sch->ccw_no_data_cnt++;
+        }
+    }
+
     if (ret == 0) {
         if (ccw.flags & CCW_FLAG_CC) {
             sch->channel_prog += 8;
-- 
2.47.3



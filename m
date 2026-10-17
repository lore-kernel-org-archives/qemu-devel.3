Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8AFCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9a6-0008Ll-HU; Sat, 17 Oct 2026 14:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zq-0008F8-L9; Sat, 17 Oct 2026 14:56:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9Zp-0003ca-0H; Sat, 17 Oct 2026 14:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263366; bh=tSb0Tqwf4A9fdsaISwiIaIBvnw7/aaR7Lo2gyb4UNkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HgKfHGJkiPaEc077pn2EQj5tpmvAQaXM/K9B8sIuSxJ+EbC0hnpfHcKeOzsp0SRw0
 bWwFnX4lhKWe6QTqWCLnwWeciat2lKpbMBLIryMElGY2b2qA9xFoyk81lsIfk5nkgp
 6WngcQOR4rPgZoN3LTp0TiNTu+AlG7e7bof+c0bloyy/8AbmM7GhX1s8lbUxgEcE0S
 yN0vO75zGSTNuO6PqAZmKn/oQjmOh1yxn83R8t1MYP4isrEk8x/aUMrmY3/ttME+d9
 3N0bm7CIKX3telqaaiM1ZwXXw0EXJEGpG6TbBpcVoO36PEHyGD4zFsOkIGg3CuM/5l
 j0NTVzF05XYnA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 60EBB1DE6AA;
 Sat, 17 Oct 2026 21:56:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2D727443375;
 Sat, 17 Oct 2026 21:56:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 10/63] s390x/css: Use datastream pointer for checking
 no-data CCWs
Date: Sat, 17 Oct 2026 21:54:26 +0300
Message-ID: <20261017185528.722197-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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
index 79a6c90175..c480f04d0a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1042,13 +1042,6 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
 
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
@@ -1129,6 +1122,20 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
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



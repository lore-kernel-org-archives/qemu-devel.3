Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA21125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LEN-0007cA-0f; Wed, 11 Mar 2026 11:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCD-0002cL-NJ; Wed, 11 Mar 2026 11:10:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LCA-0005pK-Ef; Wed, 11 Mar 2026 11:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241483; bh=1+0w7xRv/DZ7PGz4an+pI/7zGWxeu5zPdwS/hJ4BtIg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p5+KyAX0dPMMbr8mdemDZegCGJcuhr+3hKdYcIaB5GnnwijRoYgc0FE4vYoEi8CdF
 gtj4Pzk6I37xgNNd8oOc5EYZJ/kuVjG8X1hA1B0bTOs9XVdwdECD01kpwD2SPDC8ca
 EOhNgp+6MyhGZhYTZ6JtvjSSYkqut5hSWPEmMZ32JneYTp9YNggcQo1Kp95bWWyxRV
 DtcsUEDSfaWRDW+/0EKlR6dOn1HQEV3+JR1mQl3vuWz2WCfbOIUmmcItlPshRykYvZ
 +bN8FHrKqDu5wfKN2JpAdM0z6HLqL8Np6soBTC5Zx3n5vxnK5Z3cYixw7VMoGvm43x
 Qb8+xL7Mk6hiA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 632AD191EA4;
 Wed, 11 Mar 2026 18:04:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50D8F37C2E5;
 Wed, 11 Mar 2026 18:05:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Antoine Damhet <adamhet@scaleway.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 33/46] block/curl: fix concurrent completion handling
Date: Wed, 11 Mar 2026 18:03:09 +0300
Message-ID: <20260311150327.1084669-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Antoine Damhet <adamhet@scaleway.com>

curl_multi_check_completion would bail upon the first completed
transfer even if more completion messages were available thus leaving
some in flight IOs stuck.

Rework a bit the loop to make the iterations clearer and drop the breaks.

The original hang can be somewhat reproduced with the following command:

$ qemu-img convert -p -m 16 -O qcow2 -c --image-opts \
  'file.driver=https,file.url=https://scaleway.testdebit.info/10G.iso,file.readahead=1M' \
  /tmp/test.qcow2

Fixes: 1f2cead32443 ("curl: Ensure all informationals are checked for completion")
Cc: qemu-stable@nongnu.org
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
Message-ID: <20260212162730.440855-2-adamhet@scaleway.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 6f7b0a23a6ea0cc72ad222ab37936248d99d4256)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index 96498aac1d..dabd2a905e 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -324,17 +324,11 @@ curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len, CURLAIOCB *acb)
 static void curl_multi_check_completion(BDRVCURLState *s)
 {
     int msgs_in_queue;
+    CURLMsg *msg;
 
     /* Try to find done transfers, so we can free the easy
      * handle again. */
-    for (;;) {
-        CURLMsg *msg;
-        msg = curl_multi_info_read(s->multi, &msgs_in_queue);
-
-        /* Quit when there are no more completions */
-        if (!msg)
-            break;
-
+    while ((msg = curl_multi_info_read(s->multi, &msgs_in_queue))) {
         if (msg->msg == CURLMSG_DONE) {
             int i;
             CURLState *state = NULL;
@@ -397,7 +391,6 @@ static void curl_multi_check_completion(BDRVCURLState *s)
             }
 
             curl_clean_state(state);
-            break;
         }
     }
 }
-- 
2.47.3



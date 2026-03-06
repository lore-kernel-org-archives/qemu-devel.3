Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0975FCC056
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vya44-000129-4L; Fri, 06 Mar 2026 13:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya42-000110-HF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vya40-00063T-CT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772822295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWQanKCnun5kNRbLxR1iy3Ws6TAaTZ3SCHpHTbvOpjY=;
 b=ellC+FjDBAQreFFRr1Dk1jGcT+KwGwM0jLooPuiV8t6YbOPfubwzqRJOWGMoxtq5+zWe5E
 /M1iWtBzotOzIM0HKo35yvrExjH2YwbZtiQvgWDDke4/MT8To9YMZs7P4uDWSSKlL7Oii7
 5ySlHtE/MJrbJ6Q+HeDFU4QtOOJsSPQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-rxeFLpfUPXK6sLHeikbuPA-1; Fri,
 06 Mar 2026 13:38:14 -0500
X-MC-Unique: rxeFLpfUPXK6sLHeikbuPA-1
X-Mimecast-MFC-AGG-ID: rxeFLpfUPXK6sLHeikbuPA_1772822293
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 743211956096; Fri,  6 Mar 2026 18:38:13 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EC6E1800576; Fri,  6 Mar 2026 18:38:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/12] block/curl: fix concurrent completion handling
Date: Fri,  6 Mar 2026 19:36:57 +0100
Message-ID: <20260306183705.410357-5-kwolf@redhat.com>
In-Reply-To: <20260306183705.410357-1-kwolf@redhat.com>
References: <20260306183705.410357-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block/curl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 4e77c93b46e..6dccf002564 100644
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
2.53.0



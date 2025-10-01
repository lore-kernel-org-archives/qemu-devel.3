Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B4ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wAk-00032V-4l; Wed, 01 Oct 2025 08:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v3wAX-0002zf-Ec
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v3wAJ-0004RA-Hs
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759322551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m8igwKVhpYABVU8tPx+aqfAWWKNjPSCb/Y5rUEFDSzI=;
 b=M+p4Bef8KthsSU3flIMWlUnSF0V4WGZGByxzN1UOUe7Q8xgfJaOamjII7lA04N9FC+sSlV
 G339wwnSR1Gc7nGLO4j6JtF+gSUr1ba1X+rbYoEtOCcq3SnHc/4fTJPdgmnqfhYEKXXebq
 AFgr1k1z828SW0tl3LHxHbLwL1Xings=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-PG09mMs-N5GnDpXQlcGzww-1; Wed,
 01 Oct 2025 08:41:08 -0400
X-MC-Unique: PG09mMs-N5GnDpXQlcGzww-1
X-Mimecast-MFC-AGG-ID: PG09mMs-N5GnDpXQlcGzww_1759322467
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 280E0180AF60; Wed,  1 Oct 2025 12:41:00 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCEED1944D2A; Wed,  1 Oct 2025 12:40:57 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Subject: [PATCH] block/curl.c: Use explicit long constants in curl_easy_setopt
 calls
Date: Wed,  1 Oct 2025 13:40:47 +0100
Message-ID: <20251001124055.2743244-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

curl_easy_setopt takes a variable argument that depends on what
CURLOPT you are setting.  Some require a long constant.  Passing a
plain int constant is potentially wrong on some platforms.

With warnings enabled, multiple warnings like this were printed:

../block/curl.c: In function ‘curl_init_state’:
../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
  474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
      |             ^

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/curl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index e0f98e035a..68cf83ce55 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -471,11 +471,11 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
                              (void *)curl_read_cb) ||
             curl_easy_setopt(state->curl, CURLOPT_WRITEDATA, (void *)state) ||
             curl_easy_setopt(state->curl, CURLOPT_PRIVATE, (void *)state) ||
-            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1) ||
+            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1L) ||
             curl_easy_setopt(state->curl, CURLOPT_ERRORBUFFER, state->errmsg) ||
-            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1)) {
+            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1L)) {
             goto err;
         }
         if (s->username) {
@@ -800,7 +800,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->accept_range = false;
-    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1) ||
+    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1L) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION, curl_header_cb) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERDATA, s)) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
-- 
2.50.1



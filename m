Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A6CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rM9-0006sA-J4; Thu, 09 Oct 2025 10:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6rM8-0006rp-8U
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6rLw-0008Pd-SM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760019043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T62vm6+niHDYeOVCra1Ql5diIM7fJTI1DNT0MGSdcWk=;
 b=BGg3HtIajynCxlj7JUQaDFL2sEA9c2cxocIlepkbsvZZx3J2aMKIDez1RawE7ddUNN8956
 4RW+1KT0wUWiAgHyWn9X1gCBNx9tZ1PeIRgpitvHYSvnNn1COjV3CfakU7xUS7ysQI0bU0
 wGcaDrpoqhyu1rPBgu132hXLZgGlNq0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-PljcQ9QFMd6Rdmr4g9qr5w-1; Thu,
 09 Oct 2025 10:10:40 -0400
X-MC-Unique: PljcQ9QFMd6Rdmr4g9qr5w-1
X-Mimecast-MFC-AGG-ID: PljcQ9QFMd6Rdmr4g9qr5w_1760019039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57EED1800288; Thu,  9 Oct 2025 14:10:38 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D90341955F22; Thu,  9 Oct 2025 14:10:34 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 viktor.prutyanov@phystech.edu, hreitz@redhat.com, kwolf@redhat.com,
 maochenxi@bosc.ac.cn, berrange@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
Date: Thu,  9 Oct 2025 15:08:31 +0100
Message-ID: <20251009141026.4042021-2-rjones@redhat.com>
In-Reply-To: <20251009141026.4042021-1-rjones@redhat.com>
References: <20251009141026.4042021-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/curl.c               | 10 +++++-----
 contrib/elf2dmp/download.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

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
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index 21306b3fd4..fa8da0f9a2 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -27,8 +27,8 @@ bool download_url(const char *name, const char *url)
     if (curl_easy_setopt(curl, CURLOPT_URL, url) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, NULL) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEDATA, file) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L) != CURLE_OK
             || curl_easy_perform(curl) != CURLE_OK) {
         unlink(name);
         fclose(file);
-- 
2.50.1



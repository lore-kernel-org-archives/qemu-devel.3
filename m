Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA3606A932
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BemP5+Ow
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvT-0006KO-U8; Mon, 02 Nov 2026 11:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvP-0006FH-U3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvN-00024M-9l
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e49Kkdmxpht5OpCgBAdHfoQAAq/X1svsym1kafyMUjE=;
 b=BemP5+OwyZc7f/iWvPfZITFaBUfxdqGp78P76zodCCUBMY5tpYWD7vaVBsE/aSgh3xyPrS
 vUsKKTZcecnZfGzsa/xu27VjsPwrXidygGQ8/28hdcQhXEkQjW0jTM7ryuOpAnyc9FQn9k
 vuvf1HhXvWDMvNVOhdYCRM3n9HYUalo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-jYkhEuRLMT-WHUsH3zYpLw-1; Mon,
 02 Nov 2026 11:30:12 -0500
X-MC-Unique: jYkhEuRLMT-WHUsH3zYpLw-1
X-Mimecast-MFC-AGG-ID: jYkhEuRLMT-WHUsH3zYpLw_1793637011
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2A5219560B6; Mon,  2 Nov 2026 16:30:10 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A13021956087; Mon,  2 Nov 2026 16:30:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/17] util/coroutine: trim sysctl's max_map_count newline
 before parsing
Date: Mon,  2 Nov 2026 17:29:42 +0100
Message-ID: <20261102162955.268763-5-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hector Cao <hector.cao@canonical.com>

Strip trailing whitespace from max_map_count before passing it to
qemu_strtoi(), allowing the strict full-string parse to succeed.
Otherwise, qemu_strtoi() fails to parse the string and returns -22,
making the global cache pool cap size set to UINT_MAX.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Message-ID: <20261016-set-default-pool-size-v5-1-719e9e4d3f9c@canonical.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/qemu-coroutine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..5af61995437 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
      * VMAs.
      */
     if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL) &&
-        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+                            NULL)) {
+        /* contents has trailing newline, remove it before conversion */
+        g_strchomp(contents);
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
+            return UINT_MAX;
+        }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
          * fixed amount for non-coroutine users like library dependencies,
-- 
2.56.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C11FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvZ-0003vK-QB; Tue, 10 Mar 2026 12:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvU-0003Yt-To
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvS-0000zr-8E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BljQaDFUCxkFjbyZi0Hu5Rjj8PEQG8JiRAUI1zZAOyE=;
 b=jRgFkRfMJbIzHgyWGiaYySQoGf+akt9k72OEuBgQYoYqgysxhgNLOj5n7vlSTxBXErMaux
 4Ef7stCYV4KtgJEt6iHLEEcq6v6ONHkQ9odpV24A92hlXfGg/5bOvq9d45cf8vsBitOwQe
 7BSKvjgo/EHlBgcwik8xUoqJzSoSb1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-42AF2qBlOQyl_A4CzHApnA-1; Tue,
 10 Mar 2026 12:27:15 -0400
X-MC-Unique: 42AF2qBlOQyl_A4CzHApnA-1
X-Mimecast-MFC-AGG-ID: 42AF2qBlOQyl_A4CzHApnA_1773160034
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AE5518002E7; Tue, 10 Mar 2026 16:27:14 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 733F819560A6; Tue, 10 Mar 2026 16:27:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 27/28] qapi: block: Refactor HTTP(s) common arguments
Date: Tue, 10 Mar 2026 17:26:21 +0100
Message-ID: <20260310162622.333137-28-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The HTTPs curl block driver is a superset of the HTTP driver, reflect
that in the QAPI.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
Message-ID: <20260227-fix-curl-v3-v3-2-eb8a4d88feef@scaleway.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index da0b36a3751..8ba1fdc49d6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4600,23 +4600,14 @@
 # Driver specific block device options for HTTPS connections over the
 # curl backend.  URLs must start with "https://".
 #
-# @cookie: List of cookies to set; format is "name1=content1;
-#     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
-#     no cookies.
-#
 # @sslverify: Whether to verify the SSL certificate's validity
 #     (defaults to true)
 #
-# @cookie-secret: ID of a QCryptoSecret object providing the cookie
-#     data in a secure way.  See @cookie for the format.  (since 2.10)
-#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttps',
-  'base': 'BlockdevOptionsCurlBase',
-  'data': { '*cookie': 'str',
-            '*sslverify': 'bool',
-            '*cookie-secret': 'str'} }
+  'base': 'BlockdevOptionsCurlHttp',
+  'data': { '*sslverify': 'bool'} }
 
 ##
 # @BlockdevOptionsCurlFtp:
-- 
2.53.0



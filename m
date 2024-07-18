Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F1AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQMw-00022B-Ed; Thu, 18 Jul 2024 08:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUQMu-0001zy-AZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUQMr-0007lP-SL
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721306176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hr4tuv6voBJisv+BakhC0kgDBn4OuHb6ouLC6jpmRD8=;
 b=TZp0WconXsVbVK/tnXXOpOnBp36pQ8DPy8/kL4Sk2TJ3IbbfpRCC0Sqbc95HmQxAptQdUx
 1GtlnuIXrRL038qchHcginH3GPiEIE/PWcS7p+yls7hKaC6Nx04Dzcbq4yn3MvnrVpc658
 23maiLWJq2R9Db7uUSbvfbbOir2e/aU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116--sCVMm0eM0idRwAH_C1hbA-1; Thu,
 18 Jul 2024 08:36:13 -0400
X-MC-Unique: -sCVMm0eM0idRwAH_C1hbA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C93A1955D45; Thu, 18 Jul 2024 12:36:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC8081956046; Thu, 18 Jul 2024 12:36:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80FB521E668F; Thu, 18 Jul 2024 14:36:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 qemu-block@nongnu.org, jsnow@redhat.com
Subject: [PATCH] qapi-block-core: Clean up blockdev-snapshot-internal-sync doc
Date: Thu, 18 Jul 2024 14:36:09 +0200
Message-ID: <20240718123609.3063055-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BlockdevSnapshotInternal is the arguments type of command
blockdev-snapshot-internal-sync.  Its doc comment contains this note:

    # .. note:: In a transaction, if @name is empty or any snapshot matching
    #    @name exists, the operation will fail.  Only some image formats
    #    support it; for example, qcow2, and rbd.

"In a transaction" is misleading, and "if @name is empty or any
snapshot matching @name exists, the operation will fail" is redundant
with the command's Errors documentation.  Drop.

The remainder is fine.  Move it to the command's doc comment, where it
is more prominently visible, with a slight rephrasing for clarity.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f400b334c8..994e384a71 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6046,10 +6046,6 @@
 #
 # @name: the name of the internal snapshot to be created
 #
-# .. note:: In a transaction, if @name is empty or any snapshot matching
-#    @name exists, the operation will fail.  Only some image formats
-#    support it; for example, qcow2, and rbd.
-#
 # Since: 1.7
 ##
 { 'struct': 'BlockdevSnapshotInternal',
@@ -6070,6 +6066,9 @@
 #     - If the format of the image used does not support it,
 #       GenericError
 #
+# .. note:: Only some image formats such as qcow2 and rbd support
+#    internal snapshots.
+#
 # Since: 1.7
 #
 # .. qmp-example::
-- 
2.45.0



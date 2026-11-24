Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B7606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HXeGtzLB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVsN1-0001dw-It; Tue, 24 Nov 2026 10:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xVsMy-0001cN-3L
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xVsMv-0005NY-VK
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 10:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795533815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LtyySNkV7/NA/GESEjAVvrUbnLqNPdRUt8EgqPwts6k=;
 b=HXeGtzLB5E0DMfYpSpj3dmc3w5eFOlxG8yqjViqMMwUsisAa5awqa5R532mSvn74RywYDF
 hY+maXZ3LMsqco1joaxK5mId72bt9W0pSsdo/sbuYpLrEAdVk3BLHUToA7cYdgu6d7/Qfc
 AJt/xTSqZb408+Xmh84b5yyoYPyKlqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-KzvQP7RVPg2V7WhsE2rSVA-1; Tue,
 24 Nov 2026 15:23:33 +0000
X-MC-Unique: KzvQP7RVPg2V7WhsE2rSVA-1
X-Mimecast-MFC-AGG-ID: KzvQP7RVPg2V7WhsE2rSVA_1795533811
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20024182D165
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:22:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7A0C1956042
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:22:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56AB121E6A04; Tue, 24 Nov 2026 16:22:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH] file-posix: Fix loss of QAPI feature 'dynamic-auto-read-only'
Date: Tue, 24 Nov 2026 16:22:18 +0100
Message-ID: <20261124152218.2562390-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Recent commit 691094b7091b added a variant member to BlockdevOptions
branch 'host-device' by changing the branch type to new struct type
BlockdevOptionsHostDevice that has the old branch type
BlockdevOptionsFile as base.  This is a perfectly reasonable thing to
do.  However, since a type only inherits its base's members, and not
its features or conditions, this lost BlockdevOptionsFile's feature
'dynamic-auto-read-only'.

Considering we are in deep freeze, fix the regression the stupidest
and safest way possible: copy the feature from BlockdevOptionsFile to
BlockdevOptionsHostDevice.

Reported-by: Peter Krempa <pkrempa@redhat.com>
Fixes: 691094b7091b ("file-posix: Add 'accept-read-only-device' option")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 23c5787d99b..7aa4fa2df93 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3403,11 +3403,23 @@
 #     writable.  If it is true, this check is skipped.  (since: 11.2,
 #     default: false)
 #
+# Features:
+#
+# @dynamic-auto-read-only: If present, enabled auto-read-only means
+#     that the driver will open the image read-only at first,
+#     dynamically reopen the image file read-write when the first
+#     writer is attached to the node and reopen read-only when the
+#     last writer is detached.  This allows giving QEMU write
+#     permissions only on demand when an operation actually needs
+#     write access.
+#
 # Since: 11.2
 ##
 { 'struct': 'BlockdevOptionsHostDevice',
   'base': 'BlockdevOptionsFile',
-  'data': { '*accept-read-only-device': 'bool' } }
+  'data': { '*accept-read-only-device': 'bool' },
+  'features': [ { 'name': 'dynamic-auto-read-only',
+                  'if': 'CONFIG_POSIX' } ] }
 
 ##
 # @BlockdevOptionsNull:
-- 
2.55.0



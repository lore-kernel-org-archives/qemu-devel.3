Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC54D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viD1x-0004s6-VE; Tue, 20 Jan 2026 09:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1viCzx-00049m-6h
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1viCzv-0007Nh-3y
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768920370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtvOs6oqUv/P4O+hxq7j2SLb0tEOZS5BMGbK2lAS/OA=;
 b=VuZyJ0p0tsrtfcSdHD0woOzcUOdTFlReYEaamPG+DhyX6DHVeuT8YaZyizjHwG3FOpGYHk
 laiOJZk0YfEL7/J0PhesLDTdigHlFpW73a0To+/xUk2/BaA8hyzwCURhXJMNz40C5hipv9
 Whyyl2xGcZR6aS9OzNG3RkzxJ8QDwbg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-0MHIKvp9PxShdvNJTGDjUQ-1; Tue,
 20 Jan 2026 09:46:06 -0500
X-MC-Unique: 0MHIKvp9PxShdvNJTGDjUQ-1
X-Mimecast-MFC-AGG-ID: 0MHIKvp9PxShdvNJTGDjUQ_1768920366
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17F431954B06; Tue, 20 Jan 2026 14:46:06 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 102451800993; Tue, 20 Jan 2026 14:46:03 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/2] hmp_nbd_server_start: Don't ask for backing image data
Date: Tue, 20 Jan 2026 15:45:57 +0100
Message-ID: <3d34ff5e7166abf4fd9d9b9b324cde3a1c2b00ee.1768920111.git.pkrempa@redhat.com>
In-Reply-To: <cover.1768920111.git.pkrempa@redhat.com>
References: <cover.1768920111.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Krempa <pkrempa@redhat.com>

'hmp_nbd_server_start' uses only the device name from the data returned
from 'qmp_query_block', thus no backing file information. Use the new
options to suppress asking for the unused parts to save on resources.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bde25bb588..1fd28d59eb 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -422,7 +422,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     /* Then try adding all block devices.  If one fails, close all and
      * exit.
      */
-    block_list = qmp_query_block(false, false, NULL);
+    block_list = qmp_query_block(true, true, NULL);

     for (info = block_list; info; info = info->next) {
         if (!info->value->inserted) {
-- 
2.52.0



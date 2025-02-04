Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EBBC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQFy-0005K7-M0; Tue, 04 Feb 2025 16:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFg-0005CS-VP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFf-0005fJ-IK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738703675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEYb6IyR+/WWjulz36EVwQIUpHsOCFTKyj0M4JSFFpM=;
 b=aozIJX5SXGsJ0R0ZB5JfZLFRZG1YCqQJQYu7Ca0cC/KFeCLXEIOQN4esFIO5HPiefxBgIM
 gmqLZcGwpPKwMg9IgtX+89jzQs+lOeikBv2JJrIgP0m8E7AfUiElL8IM3HbbCGvZHo1fc6
 Uqk/+9kv1sdq1QnQJIq//55A3k7e31s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-U5bvPsBVPD2id2mRTBEreQ-1; Tue,
 04 Feb 2025 16:14:31 -0500
X-MC-Unique: U5bvPsBVPD2id2mRTBEreQ-1
X-Mimecast-MFC-AGG-ID: U5bvPsBVPD2id2mRTBEreQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6DD81800266; Tue,  4 Feb 2025 21:14:30 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5A0E1800268; Tue,  4 Feb 2025 21:14:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v3 03/16] block: Inactivate external snapshot overlays when
 necessary
Date: Tue,  4 Feb 2025 22:13:54 +0100
Message-ID: <20250204211407.381505-4-kwolf@redhat.com>
In-Reply-To: <20250204211407.381505-1-kwolf@redhat.com>
References: <20250204211407.381505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Putting an active block node on top of an inactive one is strictly
speaking an invalid configuration and the next patch will turn it into a
hard error.

However, taking a snapshot while disk images are inactive after
completing migration has an important use case: After migrating to a
file, taking an external snapshot is what is needed to take a full VM
snapshot.

In order for this to keep working after the later patches, change
creating a snapshot such that it automatically inactivates an overlay
that is added on top of an already inactive node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 218024497b..eb2517f1dd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1497,6 +1497,22 @@ static void external_snapshot_action(TransactionAction *action,
         return;
     }
 
+    /*
+     * Older QEMU versions have allowed adding an active parent node to an
+     * inactive child node. This is unsafe in the general case, but there is an
+     * important use case, which is taking a VM snapshot with migration to file
+     * and then adding an external snapshot while the VM is still stopped and
+     * images are inactive. Requiring the user to explicitly create the overlay
+     * as inactive would break compatibility, so just do it automatically here
+     * to keep this working.
+     */
+    if (bdrv_is_inactive(state->old_bs) && !bdrv_is_inactive(state->new_bs)) {
+        ret = bdrv_inactivate(state->new_bs, errp);
+        if (ret < 0) {
+            return;
+        }
+    }
+
     ret = bdrv_append(state->new_bs, state->old_bs, errp);
     if (ret < 0) {
         return;
-- 
2.48.1



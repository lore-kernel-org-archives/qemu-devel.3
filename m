Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C3AC02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdY6B-0000YQ-8i; Thu, 30 Jan 2025 12:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY68-0000Wf-7V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY66-00039j-6E
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738257177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9R1bvCZlCby3nJpaX4lx6Gi7/oQpcND1WUKEvZhskk=;
 b=WEOJ48rgKP5Vu07Hnrnist9gQTJA/c62jff4p+6hPHrtAeLl/yyP1ASwbCb1yNyoZtPFH9
 nRlcspyl9Hc6Qcx28nBfrvaEjF2Tbzv9oIvHaRn0T24HJc567+wSUuw9XDhDmVPrrfRLW+
 fJxTjQZKT1KJiLCJ/kaTEmQiP3S3KxQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-0UBNsMEPNjG7tnJvPJ-h4g-1; Thu,
 30 Jan 2025 12:12:56 -0500
X-MC-Unique: 0UBNsMEPNjG7tnJvPJ-h4g-1
X-Mimecast-MFC-AGG-ID: 0UBNsMEPNjG7tnJvPJ-h4g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0E6919560B0; Thu, 30 Jan 2025 17:12:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DD643003FD2; Thu, 30 Jan 2025 17:12:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] block: Inactivate external snapshot overlays when
 necessary
Date: Thu, 30 Jan 2025 18:12:33 +0100
Message-ID: <20250130171240.286878-3-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



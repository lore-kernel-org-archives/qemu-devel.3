Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8A6072ED5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wta37mNE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvV-0006L3-7O; Mon, 02 Nov 2026 11:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvP-0006FF-U4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvM-00024k-2b
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI702lmf0dXDYfUcznbqDvVkhfdIpD6BvP729k7iTXg=;
 b=Wta37mNEsCqXl4qXbRyhqU8UlDMPOn9sTufihT9aAVzYbAdy5gSjhyEiHIq9HXwcgNGT92
 IcHcrcLA7tMCAd6Ju/KlB/Fpa3zOIWaXIctsRv+yi5OlKg4YYJ+aEhD3y0B6mweUSc2sUz
 3GlL1scyuWNZRsWpMcgeG0tZmENT5FQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-_H7JtgQmNSebZwcG80DY5w-1; Mon,
 02 Nov 2026 11:30:17 -0500
X-MC-Unique: _H7JtgQmNSebZwcG80DY5w-1
X-Mimecast-MFC-AGG-ID: _H7JtgQmNSebZwcG80DY5w_1793637016
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51DBC1955DDB; Mon,  2 Nov 2026 16:30:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB6F51956087; Mon,  2 Nov 2026 16:30:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/17] blockdev: mirror: do not require a root block node
Date: Mon,  2 Nov 2026 17:29:45 +0100
Message-ID: <20261102162955.268763-8-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Fiona Ebner <f.ebner@proxmox.com>

The mirror block job currently only operates on a root block node. It
might be desired to use a throttle node as the root node for limiting
the guest IO, without also limiting mirror operations.

There is no obvious reason why mirror should only be able to operate
on a root block node.

When there is no explicit @replaces argument, implicit filters on top
are skipped. Allowing mirror to operate on non-root nodes does not
change that fact and keeps the behavior consistent with the
documentation for @replaces.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20261006114240.478523-3-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  4 ++--
 blockdev.c           | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 741c8165c06..469297ea70f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2250,7 +2250,7 @@
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
 #
-# @device: the device name or node-name of a root node whose writes
+# @device: the device name or node-name of a block node whose writes
 #     should be mirrored.
 #
 # @target: the target of the new image.  If the file exists, or if it
@@ -2573,7 +2573,7 @@
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
 #
-# @device: The device name or node-name of a root node whose writes
+# @device: The device name or node-name of a block node whose writes
 #     should be mirrored.
 #
 # @target: the id or node-name of the block device to mirror to.  This
diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f9..0f709733260 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2987,13 +2987,19 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     bool target_is_zero;
     int ret;
 
-    bs = qmp_get_root_bs(arg->device, errp);
+    bdrv_graph_rdlock_main_loop();
+    bs = bdrv_lookup_bs(arg->device, arg->device, errp);
     if (!bs) {
+        bdrv_graph_rdunlock_main_loop();
+        return;
+    }
+    if (!bdrv_is_inserted(bs)) {
+        error_setg(errp, "Device has no medium");
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
 
     /* Early check to avoid creating target */
-    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
         bdrv_graph_rdunlock_main_loop();
         return;
@@ -3150,10 +3156,18 @@ void qmp_blockdev_mirror(const char *job_id,
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
     int ret;
 
-    bs = qmp_get_root_bs(device, errp);
+    bdrv_graph_rdlock_main_loop();
+    bs = bdrv_lookup_bs(device, device, errp);
     if (!bs) {
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
+    if (!bdrv_is_inserted(bs)) {
+        error_setg(errp, "Device has no medium");
+        bdrv_graph_rdunlock_main_loop();
+        return;
+    }
+    bdrv_graph_rdunlock_main_loop();
 
     target_bs = bdrv_lookup_bs(target, target, errp);
     if (!target_bs) {
-- 
2.56.0



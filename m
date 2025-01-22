Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03418C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZGg-0002av-Sh; Wed, 22 Jan 2025 06:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGc-0002Y2-NE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGa-00087N-C3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737546687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfTcGwhapQPjPmdDmvfjqoRozP1S1gAUmnX2CEu07Nk=;
 b=gRbF4J7ew6RzKuHcX+H3eHxb54Sx0y2wKXxXrQLqeVqw80Fc4gLRenX9DVravUc3gs+XXc
 b+vifwJvsEfRxGMQLen6mJi7ksJYuDc42LogWPAT8iPu653K5rMCr8Ojc7ksI5WMSlZlX3
 Up+PM+4ZIvB2YMOeo9eRJukFZKdhUc0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-YJizTtYUP1KSxFYQvfjgzg-1; Wed,
 22 Jan 2025 06:51:22 -0500
X-MC-Unique: YJizTtYUP1KSxFYQvfjgzg-1
X-Mimecast-MFC-AGG-ID: YJizTtYUP1KSxFYQvfjgzg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8A7E19560AA; Wed, 22 Jan 2025 11:51:21 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.195])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0A981956053; Wed, 22 Jan 2025 11:51:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pkrempa@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/9] block: Add option to create inactive nodes
Date: Wed, 22 Jan 2025 12:50:39 +0100
Message-ID: <20250122115046.51216-3-kwolf@redhat.com>
In-Reply-To: <20250122115046.51216-1-kwolf@redhat.com>
References: <20250122115046.51216-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

In QEMU, nodes are automatically created inactive while expecting an
incoming migration (i.e. RUN_STATE_INMIGRATE). In qemu-storage-daemon,
the notion of runstates doesn't exist. It also wouldn't necessarily make
sense to introduce it because a single daemon can serve multiple VMs
that can be in different states.

Therefore, allow the user to explicitly open images as inactive with a
new option. The default is as before: Nodes are usually active, except
when created during RUN_STATE_INMIGRATE.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json         | 6 ++++++
 include/block/block-common.h | 1 +
 block.c                      | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index fd3bcc1c17..5bc164dbed 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4679,6 +4679,11 @@
 #
 # @cache: cache-related options
 #
+# @active: whether the block node should be activated (default: true).
+#     Having inactive block nodes is useful primarily for migration because it
+#     allows opening an image on the destination while the source is still
+#     holding locks for it. (Since 10.0)
+#
 # @read-only: whether the block device should be read-only (default:
 #     false).  Note that some block drivers support only read-only
 #     access, either generally or in certain configurations.  In this
@@ -4705,6 +4710,7 @@
             '*node-name': 'str',
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
+            '*active': 'bool',
             '*read-only': 'bool',
             '*auto-read-only': 'bool',
             '*force-share': 'bool',
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 338fe5ff7a..7030669f04 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -257,6 +257,7 @@ typedef enum {
 #define BDRV_OPT_AUTO_READ_ONLY "auto-read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
+#define BDRV_OPT_ACTIVE         "active"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/block.c b/block.c
index 43ed632a7a..2740a95a72 100644
--- a/block.c
+++ b/block.c
@@ -1573,6 +1573,10 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
     if (qemu_opt_get_bool_del(opts, BDRV_OPT_AUTO_READ_ONLY, false)) {
         *flags |= BDRV_O_AUTO_RDONLY;
     }
+
+    if (!qemu_opt_get_bool_del(opts, BDRV_OPT_ACTIVE, true)) {
+        *flags |= BDRV_O_INACTIVE;
+    }
 }
 
 static void update_options_from_flags(QDict *options, int flags)
@@ -1799,6 +1803,11 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Ignore flush requests",
         },
+        {
+            .name = BDRV_OPT_ACTIVE,
+            .type = QEMU_OPT_BOOL,
+            .help = "Node is activated",
+        },
         {
             .name = BDRV_OPT_READ_ONLY,
             .type = QEMU_OPT_BOOL,
-- 
2.48.1



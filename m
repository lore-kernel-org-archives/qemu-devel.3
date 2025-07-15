Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D027C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublS7-0007sE-Uo; Tue, 15 Jul 2025 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxG-00049J-3A
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxD-0001Pj-Rg
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fjLhhOT1GHA5GeL6hb0wUmyYfZeXw2frUz0mOAoe1I=;
 b=QYgFCF7S5Wz/OW3hrzfbXJIibnY/4z4vgloTvrfyCiZgfKZGKY9yY454XlUIhhiG1aG99r
 ir/Kqk80T/1zzGsB8CMjYcAEKhJRJT7YLV79E3qNJqxznpUKs9VhuHLGYaWxrse0EzigpM
 hZbvOdaMnpTpy7g+S+L6XjSoGeyRzd4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-_ze_WRkgNE6Ff2ikOTHkNg-1; Tue,
 15 Jul 2025 15:04:37 -0400
X-MC-Unique: _ze_WRkgNE6Ff2ikOTHkNg-1
X-Mimecast-MFC-AGG-ID: _ze_WRkgNE6Ff2ikOTHkNg_1752606276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4DCC19560B8; Tue, 15 Jul 2025 19:04:36 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33AD8197702B; Tue, 15 Jul 2025 19:04:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 28/57] block/qapi: make @node-name in @BlockDeviceInfo
 non-optional
Date: Tue, 15 Jul 2025 21:03:01 +0200
Message-ID: <20250715190330.378764-29-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Since commit 15489c769b ("block: auto-generated node-names"), if the
node name of a block driver state is not explicitly specified, it
will be auto-generated.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250702123204.325470-3-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 2 +-
 block/qapi.c         | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3e720af5ad..9d36927fc1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -573,7 +573,7 @@
 # Since: 0.14
 ##
 { 'struct': 'BlockDeviceInfo',
-  'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str',
+  'data': { 'file': 'str', 'node-name': 'str', 'ro': 'bool', 'drv': 'str',
             '*backing_file': 'str', 'backing_file_depth': 'int',
             'children': ['BlockdevChild'],
             'active': 'bool', 'encrypted': 'bool',
diff --git a/block/qapi.c b/block/qapi.c
index e08a1e970f..12fbf8d1b7 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -75,9 +75,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         .no_flush       = !!(bs->open_flags & BDRV_O_NO_FLUSH),
     };
 
-    if (bs->node_name[0]) {
-        info->node_name = g_strdup(bs->node_name);
-    }
+    info->node_name = g_strdup(bs->node_name);
 
     children_list_tail = &info->children;
     QLIST_FOREACH(child, &bs->children, next) {
-- 
2.50.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9145EC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMOp-0002HE-J2; Mon, 27 Jan 2025 05:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tcMOa-000246-M6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:31:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tcMOV-0002pX-SS
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737973861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6E+oCISpqR6Cdq0Z+2xhjOafmyJFtBlAc6ZEDRhnszk=;
 b=S+QEjrPRCvETaevvwr/ZV8/NvN9wfodwzDT6bP4wWLmzrEAZ5MiCj7WhjywxkIXsQkU1ia
 Qe6+bt7oFoYK5Rgc5SYeRvD/hs4QQCoGO5KmLw8pBvhPnRuiU+5LXfuG9eJ+mBL4XWWxzE
 3BwuSt3eP0PkLkMtU7Vau0AL0ziIO4Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-NtkF_BxSNY6hbqiV_UsMOA-1; Mon,
 27 Jan 2025 05:29:30 -0500
X-MC-Unique: NtkF_BxSNY6hbqiV_UsMOA-1
X-Mimecast-MFC-AGG-ID: NtkF_BxSNY6hbqiV_UsMOA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4E181956050; Mon, 27 Jan 2025 10:29:29 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0386F1800348; Mon, 27 Jan 2025 10:29:25 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH] block-backend: Fix argument order when calling
 'qapi_event_send_block_io_error()'
Date: Mon, 27 Jan 2025 11:29:24 +0100
Message-ID: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 7452162adec25c10 introduced 'qom-path' argument to BLOCK_IO_ERROR
event but when the event is instantiated in 'send_qmp_error_event()' the
arguments for 'device' and 'qom_path' in
qapi_event_send_block_io_error() were reversed :

Generated code for sending event:

  void qapi_event_send_block_io_error(const char *qom_path,
                                      const char *device,
                                      const char *node_name,
                                      IoOperationType operation,
                                      [...]

Call inside send_qmp_error_event():

     qapi_event_send_block_io_error(blk_name(blk),
                                    blk_get_attached_dev_path(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    [...]

This results into reporting the QOM path as the device alias and vice
versa which in turn breaks libvirt, which expects the device alias being
either a valid alias or empty (which would make libvirt do the lookup by
node-name instead).

Fixes: 7452162adec25c1003d5bf0079aca52913a80e0c
Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 block/block-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index c93a7525ad..981be67e5d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2136,8 +2136,8 @@ static void send_qmp_error_event(BlockBackend *blk,
     BlockDriverState *bs = blk_bs(blk);

     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk),
-                                   blk_get_attached_dev_path(blk),
+    qapi_event_send_block_io_error(blk_get_attached_dev_path(blk),
+                                   blk_name(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.48.1



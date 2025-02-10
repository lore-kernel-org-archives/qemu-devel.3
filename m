Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047E4C021A1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNY-0006Zt-N9; Mon, 10 Feb 2025 11:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNN-0006Ts-VU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNL-00010d-O3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us6rSAdRi50U3+TL610UuTJjH+NW1dPzUAxL6weKf3U=;
 b=OLGJnNIRLdt5vlP/nk4YQiBCB1Bxu7P8Pew0pwGISrx1TLe3bdyxgb4WKVcHzzXNI2rbuv
 K5xsaqU5BiFpNMiJjN7jgYwO++UXyrNbSqC7v4jxzxHkbIb1hW6nfG4dH/6Z285Z3FJWv4
 0S4x6Gn+dShibGpyOh7AWDgCuwjemGI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-PNly4jUyNuKmageUylSnpw-1; Mon,
 10 Feb 2025 11:11:07 -0500
X-MC-Unique: PNly4jUyNuKmageUylSnpw-1
X-Mimecast-MFC-AGG-ID: PNly4jUyNuKmageUylSnpw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580621800268; Mon, 10 Feb 2025 16:11:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FEF1195608D; Mon, 10 Feb 2025 16:11:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/25] block-backend: Fix argument order when calling
 'qapi_event_send_block_io_error()'
Date: Mon, 10 Feb 2025 17:10:17 +0100
Message-ID: <20250210161034.76494-9-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Krempa <pkrempa@redhat.com>

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

Cc: qemu-stable@nongnu.org
Fixes: 7452162adec2 ("qapi: add qom-path to BLOCK_IO_ERROR event")
Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Message-ID: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index b610582644..d093f01f89 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2141,7 +2141,7 @@ static void send_qmp_error_event(BlockBackend *blk,
     g_autofree char *path = blk_get_attached_dev_path(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk), path,
+    qapi_event_send_block_io_error(path, blk_name(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.48.1



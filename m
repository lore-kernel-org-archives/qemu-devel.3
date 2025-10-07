Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF31CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68WL-0003lC-HY; Tue, 07 Oct 2025 10:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v68WA-0003c5-0b
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v68W0-0003dG-9f
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759846685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqmAxJcwf6pRKKSUnF4GWDas5WBlnsLAsYEj/OIjsBc=;
 b=BFZfmd/G6DTZvG0jdb3KuXxTNHr/JsJcISD5Rcum8jyHq2GeRBp9b2D0sqNa5mmCFCPlr3
 cT3ojl1NVUoikdPayegKPqK0/+PobCSOISY8vJoG+zB3kFGOmHa3+4EdTXfBj8dG2LPRRs
 OsxfNacgob+TlaqRQgz9hOrEjZjVO/M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-jDjr9vXGNaS-CNTpPZW39w-1; Tue,
 07 Oct 2025 10:18:04 -0400
X-MC-Unique: jDjr9vXGNaS-CNTpPZW39w-1
X-Mimecast-MFC-AGG-ID: jDjr9vXGNaS-CNTpPZW39w_1759846683
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DBC31872B0C; Tue,  7 Oct 2025 14:17:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.229])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8774B1800452; Tue,  7 Oct 2025 14:17:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/3] file-posix: populate pwrite_zeroes_alignment
Date: Tue,  7 Oct 2025 10:16:58 -0400
Message-ID: <20251007141700.71891-2-stefanha@redhat.com>
In-Reply-To: <20251007141700.71891-1-stefanha@redhat.com>
References: <20251007141700.71891-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Linux block devices require write zeroes alignment whereas files do not.

It may come as a surprise that block devices opened in buffered I/O mode
require the alignment for write zeroes requests although normal
read/write requests do not.

Therefore it is necessary to populate the pwrite_zeroes_alignment field.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674ce..827ffa77a5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1602,6 +1602,22 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 
             bs->bl.pdiscard_alignment = dalign;
         }
+
+#ifdef __linux__
+        /*
+         * Linux requires logical block size alignment for write zeroes even
+         * when normal reads/writes do not require alignment.
+         */
+        if (!s->needs_alignment) {
+            ret = probe_logical_blocksize(s->fd,
+                                          &bs->bl.pwrite_zeroes_alignment);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Failed to probe logical block size");
+                return;
+            }
+        }
+#endif /* __linux__ */
     }
 
     raw_refresh_zoned_limits(bs, &st, errp);
-- 
2.51.0



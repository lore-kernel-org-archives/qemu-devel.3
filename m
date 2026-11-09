Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF7606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XfDdy0rI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSVp-0002NH-Fh; Mon, 09 Nov 2026 11:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVf-0002JJ-QH
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVa-00010S-Ao
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hkDV4VRRX9wbF6wnOTah+ct5S69YuHQUAubHHzxZBU=;
 b=XfDdy0rIC/zY1K8SRNeoj4duKB4ljAMucrGJU+Tz0Gl8OUAmrXlpyb5OXXvjKaFRvxjYQO
 FwV9HD7yEeRYGidyFi5j9RZv9unQnHjJFWgWpsUavfcqLriJJ/qoOOXLNURTJHouYsdbDM
 NZgJ6LbD9tarWrnUckerfx+YwOj35Sg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-fTB2I38CPBCpVloi9c6E4Q-1; Mon,
 09 Nov 2026 11:45:55 -0500
X-MC-Unique: fTB2I38CPBCpVloi9c6E4Q-1
X-Mimecast-MFC-AGG-ID: fTB2I38CPBCpVloi9c6E4Q_1794242754
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55684180120C; Mon,  9 Nov 2026 16:45:54 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03FD13001DA5; Mon,  9 Nov 2026 16:45:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/11] qcow2: fix snapshot data corruption with
 discard-no-unref=on
Date: Mon,  9 Nov 2026 17:45:31 +0100
Message-ID: <20261109164533.293487-10-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Whenever option discard-no-unref=on is enabled, we bypass refcount
machinery and unconditionally punch hole in the data on 'discard' and
'write -z -u' paths.  However, when this same cluster is also referenced
by an internal snapshot, such operations lead to problems.  The active L2
table is copied before it is changed, so the snapshot metadata stays
correct, but the host range under it is punched out and the snapshot reads
zeroes there afterwards. qemu-img check finds nothing wrong.

Fix this by guarding the 'keep_reference' flag by the presence of the
QCOW_OFLAG_COPIED bit.  I.e. only proceed with unconditional data
punching if we own this cluster exclusively.

Cc: qemu-stable@nongnu.org
Fixes: 42a2890a76f4 ("qcow2: add discard-no-unref option")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20261105161515.794213-3-andrey.drobyshev@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e02fae6a0c6..cc473c7c796 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1953,6 +1953,7 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
         QCow2ClusterType cluster_type =
             qcow2_get_cluster_type(bs, old_l2_entry);
         bool keep_reference = (cluster_type != QCOW2_CLUSTER_COMPRESSED) &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED) &&
                               !full_discard &&
                               (s->discard_no_unref &&
                                type == QCOW2_DISCARD_REQUEST);
@@ -2097,8 +2098,9 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
         QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
         bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
             ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
-        bool keep_reference =
-            (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
+        bool keep_reference = s->discard_no_unref &&
+                              type != QCOW2_CLUSTER_COMPRESSED &&
+                              (old_l2_entry & QCOW_OFLAG_COPIED);
         uint64_t new_l2_entry = old_l2_entry;
         uint64_t new_l2_bitmap = old_l2_bitmap;
 
-- 
2.56.0



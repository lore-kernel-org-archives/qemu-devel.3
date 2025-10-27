Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C74CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDSXF-0006OY-Ej; Mon, 27 Oct 2025 15:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vDSX8-0006O7-Fp
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vDSX3-0003hS-0q
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761591922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPQltLsvoOYR1EDvs5tOwznarOJoulthY/B2nh96bnM=;
 b=clW1XrUTATwNGGg7eE7z0GZhL2WAZfkdyZkr2V4kgJGlmMY8Z6R4Fzo3XNk3jhaygD0s9g
 SYSYVi9nkW7hw9J2MD0lXHc4+Db9AOF17uoArUsLhOum0eSfo5Y2TJe8IPpexNMqjhWsrZ
 vkImud8/Kf+ZEkjUVGtP13B8db3BL04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-QZqshLWaPBCQrJWuflMK3w-1; Mon,
 27 Oct 2025 15:05:20 -0400
X-MC-Unique: QZqshLWaPBCQrJWuflMK3w-1
X-Mimecast-MFC-AGG-ID: QZqshLWaPBCQrJWuflMK3w_1761591919
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 487621800451; Mon, 27 Oct 2025 19:05:19 +0000 (UTC)
Received: from localhost (unknown [10.2.16.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E9ED1955F1B; Mon, 27 Oct 2025 19:05:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/1] hw/scsi: avoid deadlock upon TMF request cancelling with
 VirtIO
Date: Mon, 27 Oct 2025 15:05:14 -0400
Message-ID: <20251027190514.36991-2-stefanha@redhat.com>
In-Reply-To: <20251027190514.36991-1-stefanha@redhat.com>
References: <20251027190514.36991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When scsi_req_dequeue() is reached via
scsi_req_cancel_async()
virtio_scsi_tmf_cancel_req()
virtio_scsi_do_tmf_aio_context(),
there is a deadlock when trying to acquire the SCSI device's requests
lock, because it was already acquired in
virtio_scsi_do_tmf_aio_context().

In particular, the issue happens with a FreeBSD guest (13, 14, 15,
maybe more), when it cancels SCSI requests, because of timeout.

This is a regression caused by commit da6eebb33b ("virtio-scsi:
perform TMFs in appropriate AioContexts") and the introduction of the
requests_lock earlier.

To fix the issue, only cancel the requests after releasing the
requests_lock. For this, the SCSI device's requests are iterated while
holding the requests_lock and the requests to be cancelled are
collected in a list. Then, the collected requests are cancelled
one by one while not holding the requests_lock. This is safe, because
only requests from the current AioContext are collected and acted
upon.

Originally reported by Proxmox VE users:
https://bugzilla.proxmox.com/show_bug.cgi?id=6810
https://forum.proxmox.com/threads/173914/

Fixes: da6eebb33b ("virtio-scsi: perform TMFs in appropriate AioContexts")
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-id: 20251017094518.328905-1-f.ebner@proxmox.com
[Changed g_list_append() to g_list_prepend() to avoid traversing the
list each time.
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d817fc42b4..93e87c459c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -339,6 +339,7 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
     SCSIDevice *d = virtio_scsi_device_get(s, tmf->req.tmf.lun);
     SCSIRequest *r;
     bool match_tag;
+    g_autoptr(GList) reqs = NULL;
 
     if (!d) {
         tmf->resp.tmf.response = VIRTIO_SCSI_S_BAD_TARGET;
@@ -374,10 +375,21 @@ static void virtio_scsi_do_tmf_aio_context(void *opaque)
             if (match_tag && cmd_req->req.cmd.tag != tmf->req.tmf.tag) {
                 continue;
             }
-            virtio_scsi_tmf_cancel_req(tmf, r);
+            /*
+             * Cannot cancel directly, because scsi_req_dequeue() would deadlock
+             * when attempting to acquire the request_lock a second time. Taking
+             * a reference here is paired with an unref after cancelling below.
+             */
+            scsi_req_ref(r);
+            reqs = g_list_prepend(reqs, r);
         }
     }
 
+    for (GList *elem = g_list_first(reqs); elem; elem = g_list_next(elem)) {
+        virtio_scsi_tmf_cancel_req(tmf, elem->data);
+        scsi_req_unref(elem->data);
+    }
+
     /* Incremented by virtio_scsi_do_tmf() */
     virtio_scsi_tmf_dec_remaining(tmf);
 
-- 
2.51.0



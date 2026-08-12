Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B4EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8g8-00033E-CT; Wed, 12 Aug 2026 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fb-0002b2-Ln; Wed, 12 Aug 2026 09:07:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fY-00055i-Fd; Wed, 12 Aug 2026 09:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=qjlU81RIyK1OkCd4proyDaVf+EDt6gfvWujMqoyOj0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MSqUDlMQLe2ehR1bJh+tphjFy8JJW2lKcc7lN8xA4II9vn0YQereUXpbOJWlk2jhG
 j79ab+KEQWZu3oOAtY5IpW+Rwlw9BUBXGrjICgAjCc8+En2TT3p5qTcxfDzps/4Y4c
 6ybiyurI91PfCFXGzTfqk9g4XwaY5YPVDk87+kqf62uKpK+lJZI1oDy7uGE4oibBdB
 hhwUk78XACb1pGNGRi6WFtmWWb47o8ielCFCxQlq9MV3bYkLkBp6pLPuu0hQ1IYLYs
 M3c3qnhIYRY3OzD5lXPxmDvxH2CPlNthZNi0mhf0f2bnHQLz8FVILDAhjm28TI3wGC
 QFJEwPnOKhExg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D3FD21CA4A9;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 15710409B8C;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3888B2F8E8; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 042/102] virtio-scsi: fix SCSIRequest leak on a bad
 request
Date: Wed, 12 Aug 2026 16:01:17 +0300
Message-ID: <20260812130233.621965-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Michael S. Tsirkin" <mst@redhat.com>

When virtio_scsi_handle_cmd_vq() cleans up prepared requests after a
malformed element in the same batch, it drops only one reference even
though virtio_scsi_handle_cmd_req_prepare() leaves each unsubmitted
SCSIRequest with two references. This leaks the request and allows
repeated bad batches to cause unbounded host memory growth.

Add a second scsi_req_unref() and clear hba_private first.

Fixes: CVE-2026-61476
Fixes: 661e32fb3c ("virtio-scsi: convert virtio_scsi_bad_req() to use virtio_error()")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3875
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: Greg Kurz <groug@kaod.org>
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <5092cd4716e08d29731bfe85eea82a732b837ff4.1784895264.git.mst@redhat.com>
(cherry picked from commit f404bf0e6504e0412a00ea64708f17d2a5e3f869)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 35ff216510e..259fab3c7bd 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1515,6 +1515,13 @@ void scsi_req_unref(SCSIRequest *req)
     }
 }
 
+void scsi_req_unref_detach_hba(SCSIRequest *req)
+{
+    /* Unref when the HBA frees hba_private separately (e.g. virtio_scsi_free_req) */
+    req->hba_private = NULL;
+    scsi_req_unref(req);
+}
+
 /* Tell the device that we finished processing this chunk of I/O.  It
    will start the next chunk or complete the command.  */
 void scsi_req_continue(SCSIRequest *req)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index ffa85fa25a5..454e7c9c869 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -935,7 +935,9 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
                     req = QTAILQ_FIRST(&reqs);
                     QTAILQ_REMOVE(&reqs, req, next);
                     defer_call_end();
+                    /* Drop both the ref from _prepare and the initial ref */
                     scsi_req_unref(req->sreq);
+                    scsi_req_unref_detach_hba(req->sreq);
                     virtqueue_detach_element(req->vq, &req->elem, 0);
                     virtio_scsi_free_req(req);
                 }
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 90ee192b4d4..3c7dc845783 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -211,6 +211,7 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
 int32_t scsi_req_enqueue(SCSIRequest *req);
 SCSIRequest *scsi_req_ref(SCSIRequest *req);
 void scsi_req_unref(SCSIRequest *req);
+void scsi_req_unref_detach_hba(SCSIRequest *req);
 
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        size_t buf_len, void *hba_private);
-- 
2.47.3



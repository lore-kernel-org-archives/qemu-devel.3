Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A03C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNM4-0002hD-CJ; Thu, 16 Jul 2026 10:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkNLI-0002Rt-Ek
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkNLE-0000B3-0g
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784213132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rN96T62Yr2hShV0YawOFRcQJf3IcpjnVwq60YVeVJWw=;
 b=NbjBfudMAfel/a5axJZqLs8rjs3mveUrx/fbxlwHBrU3f10TEk+sfHONufXLtpXlPD04fh
 mJ2HQ+SVGzUPTPj59AlDuhfpX8LYj0Afr9UqPE2DPJsRa969Hp9+Delo2xq8KLRP9LWovA
 MBaRWiV9br4Hub2N6VedkbTgmwMVnrw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-R1aezQHdPSW_tNLb1GWReA-1; Thu,
 16 Jul 2026 10:45:31 -0400
X-MC-Unique: R1aezQHdPSW_tNLb1GWReA-1
X-Mimecast-MFC-AGG-ID: R1aezQHdPSW_tNLb1GWReA_1784213130
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B45701800625; Thu, 16 Jul 2026 14:45:29 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6544C3003EFE; Thu, 16 Jul 2026 14:45:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] hw/display/virtio-gpu: handle migration iov allocation failure
Date: Thu, 16 Jul 2026 18:45:24 +0400
Message-ID: <20260716144524.3661103-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

An unbounded iov_cnt from the migration stream drives two g_new()
allocations whose combined size can exceed available memory, causing
GLib to abort the process.

Switch to g_try_new() and propagate the failure as a migration error.

Fixes: 0c244e50ee12 ("virtio-gpu: add live migration support")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3753
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e00fb6effa5..048b151872e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1365,8 +1365,15 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res->addrs = g_new(uint64_t, res->iov_cnt);
-        res->iov = g_new(struct iovec, res->iov_cnt);
+        res->addrs = g_try_new(uint64_t, res->iov_cnt);
+        res->iov = g_try_new(struct iovec, res->iov_cnt);
+        if (res->iov_cnt && (!res->addrs || !res->iov)) {
+            pixman_image_unref(res->image);
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
 
         /* read data */
         for (i = 0; i < res->iov_cnt; i++) {
@@ -1440,8 +1447,15 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         res->resource_id = resource_id;
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
-        res->addrs = g_new(uint64_t, res->iov_cnt);
-        res->iov = g_new(struct iovec, res->iov_cnt);
+
+        res->addrs = g_try_new(uint64_t, res->iov_cnt);
+        res->iov = g_try_new(struct iovec, res->iov_cnt);
+        if (res->iov_cnt && (!res->addrs || !res->iov)) {
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
 
         /* read data */
         for (i = 0; i < res->iov_cnt; i++) {
-- 
2.55.0



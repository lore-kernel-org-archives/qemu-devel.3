Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B467C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2j2-0002P2-Qu; Tue, 12 Mar 2024 10:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2iT-0001dx-1y
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2iO-0008RL-Ab
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqv+15fAnT5VuCI2SpsSS8lUgd55KfjVrvUQKpE9PCs=;
 b=FAKHEcVVn3ZDstV4cbwhjHJ1ajduyTKVo0P1US69MnIR5R8j/reU8ScC00QP2eo3VhMSlh
 iqmCtPwnJAaSg1y7fvMOoJ14tWeW/mD2H12i/tW9MJKCPvzjGiaJK3J8go9IWZHZQKdgX+
 OZuXK6lojq82jv9tLb+vuNocZEopn9M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-RPPgACTKMBW5FjJsS2csaA-1; Tue, 12 Mar 2024 10:02:44 -0400
X-MC-Unique: RPPgACTKMBW5FjJsS2csaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B92648007AB;
 Tue, 12 Mar 2024 14:02:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5869110F53;
 Tue, 12 Mar 2024 14:02:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 4/5] virtio-gpu: remove needless condition
Date: Tue, 12 Mar 2024 18:02:15 +0400
Message-ID: <20240312140216.313618-5-marcandre.lureau@redhat.com>
In-Reply-To: <20240312140216.313618-1-marcandre.lureau@redhat.com>
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

qemu_create_displaysurface_pixman() never returns NULL.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1c1ee230b3..ccbe31d759 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -684,10 +684,6 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
         /* realloc the surface ptr */
         scanout->ds = qemu_create_displaysurface_pixman(rect);
-        if (!scanout->ds) {
-            *error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-            return;
-        }
 #ifdef WIN32
         qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, fb->offset);
 #endif
@@ -1423,9 +1419,6 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
             return -EINVAL;
         }
         scanout->ds = qemu_create_displaysurface_pixman(res->image);
-        if (!scanout->ds) {
-            return -EINVAL;
-        }
 #ifdef WIN32
         qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
 #endif
-- 
2.44.0



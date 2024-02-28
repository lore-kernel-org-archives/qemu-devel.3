Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F2BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIyI-0005WR-8O; Wed, 28 Feb 2024 07:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rfIyG-0005V7-Au
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rfIyE-000501-Tg
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709123014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZuAtynw20cVE61RVDw4QkorA1jGmXPNjdDY9k07Hsw=;
 b=Vu0boor/JlmjagKEv8cGjjY/Xgddh9osQx6ZmkkxDR+m6wf7l7rwsNEMo6E8Qj2UnDq91O
 qQoqbE2W4EAOgTz2F0vkb13PfRvDffdLbKXblShNARLbwskyNWoC6eWf2kG5kpOBaHop+r
 k3doAPB1Qx2rLA5hdjn7Rpes8SnZPDw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-36M5gTiBMuuokubaumMsLg-1; Wed,
 28 Feb 2024 07:23:32 -0500
X-MC-Unique: 36M5gTiBMuuokubaumMsLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B0D282D3C5
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 12:23:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B15B2166B5D;
 Wed, 28 Feb 2024 12:23:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, sebott@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 1/2] virtio-gpu: remove needless condition
Date: Wed, 28 Feb 2024 16:23:22 +0400
Message-ID: <20240228122323.962826-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240228122323.962826-1-marcandre.lureau@redhat.com>
References: <20240228122323.962826-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.43.2



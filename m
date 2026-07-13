Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E020AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGD7-00068e-8o; Mon, 13 Jul 2026 08:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjGD5-000688-An
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjGD4-0006dE-2h
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8fMGqq0bppibKolryf3WJ8I+zxKGGufIVQAZCTRjYtI=;
 b=RElwb9B9d6RlgUStZBqKhs5Uz8R4ZqM4Ua2cSZ6icu/RhzBY+5+BWYWFAQSgkgP/GDW0iR
 Gr81v7xBQaYzH+DVwSBL3yLE6uZfwYN2gNhPz2kWdGXQuTeVVqwaAbqJy69+g6hpujuNfR
 HrorznUb4TfXV1WXyRWvFio467w4ZNw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-KTEzeJZhNDaj_DsPO3vJPA-1; Mon,
 13 Jul 2026 08:56:28 -0400
X-MC-Unique: KTEzeJZhNDaj_DsPO3vJPA-1
X-Mimecast-MFC-AGG-ID: KTEzeJZhNDaj_DsPO3vJPA_1783947387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 882691800581; Mon, 13 Jul 2026 12:56:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D7891800586; Mon, 13 Jul 2026 12:56:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
Date: Mon, 13 Jul 2026 16:56:22 +0400
Message-ID: <20260713125622.111513-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

When virtio_gpu_create_udmabuf() succeeds but virtio_gpu_remap_udmabuf()
fails (mmap returns MAP_FAILED), virtio_gpu_init_udmabuf() returns early
without closing the dmabuf fd. Since res->blob is never set in this
path, later cleanup via virtio_gpu_cleanup_mapping() skips
virtio_gpu_fini_udmabuf() entirely, leaking the file descriptor.

Call virtio_gpu_destroy_udmabuf() before the early return to close
the fd. This function already handles partial state correctly: it
skips the munmap when res->remapped is NULL and closes the fd when
res->dmabuf_fd >= 0.

Fixes: 9b60cdf98723 ("virtio-gpu: Add udmabuf helpers")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-udmabuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d5ac1cfca0e..5f08c855dde 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -143,6 +143,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         }
         virtio_gpu_remap_udmabuf(res);
         if (!res->remapped) {
+            virtio_gpu_destroy_udmabuf(res);
             return;
         }
         pdata = res->remapped;
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E114C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMv-00061g-5T; Tue, 25 Aug 2026 07:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMB-0005Xc-AS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypM9-0006P8-No
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mskKc6mSuvBAkzrTbpBf8DxVhn57z97dfknSFMXPne4=;
 b=R46ndBU/FwRWDX86sy4cerVrv0wxvypZNa76HtvKEjyf9o9pA5VVYU0Cd0TNmO6BOElPg4
 9MwcfwAHmDzC1x6SUqWlkcnp3l8hGzVuM8RHGMWhyHwzYMGK+V/ealyzbc1Lzx1+3sgD6a
 EzRWor5Ph5jciK6AHAU2vLTIrDxgZ/8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-CRUK3GXjMd-VgTWK5kRcqQ-1; Tue,
 25 Aug 2026 07:30:15 -0400
X-MC-Unique: CRUK3GXjMd-VgTWK5kRcqQ-1
X-Mimecast-MFC-AGG-ID: CRUK3GXjMd-VgTWK5kRcqQ_1787657414
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 473591954237; Tue, 25 Aug 2026 11:30:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44EA51801AEA; Tue, 25 Aug 2026 11:30:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:06 +0400
Subject: [GIT PULL 16/19] hw/display/virtio-gpu: Check cursor data presence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-16-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RcZzO5KwMeF19XwWn0KZU91FWni8PQux3WPjJ2zqvkU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrV22/QghIndSlQ0qWh+gWuhGwr4HJtzI5rc
 /zLxaKS0o+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5WyED/9QiLkKmk7Vi1E2M8FEQsNOO9+edCu+8I3+REMtjfGvRXvQlNJqpUHiUSFa9J0Gp0+7llZ
 xdKZlWPrN2YdeOSTKK4e4xQUhNw9alHyJdB8tYz206U+GV/Zf4Ns23L+eR87S2PDSwbvARq+jWv
 TfTWfBlpyoiPBfkeDDG3+EF5tdDjFc3PqXbdnQRcz2uJvVCV+D82dD06RAoAyQDLRm7Cvk/9w8a
 xYJCaYU/K3Z3p+NLdlpuNpzGSc8cMYAVXaoVXqRinDAkkPtRcrMefhrMlZRy1Pu7m0FnvBGfg8y
 RHZSnuL2XmFm9G35S2Xa11IPH+uxY+9VX0mwIC7Q1uEyv06Wo/YIzt26AEYxXiT7c7i7ZqgbFZw
 FG2JEMJlx87TxD8vqhjiwigJqx3mDzkXmJKnlxsorTbj2ZRzUu3XXC/cf6vU/Neuc14bbICGWZd
 q7BjawA+U+i0jnRuWk5UuFVgtyKXhytAXHoT2jj1KHjxrw/wJu3zHAUp1FI5JZ9KiAHG+9NAXlQ
 i0Xffxd16oBdcZaO7vKun/k8KMfmZxaZkEOKC3ss3YW+0podjm9L4u2A4ALjUXDVvs369K8g0Lw
 JcpZ9kvchT/nqkkX1PCPB7To7IrTlErb2mFiTD3b+iguySRbyw1CEZ8HizfAchcklAc0RqKwaGA
 99vAI5kusRKTepA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reject a blob that lacks the backing storage for
VIRTIO_GPU_CMD_UPDATE_CURSOR.

Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825-dmabuf-v2-4-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7f3301a9ac57..01549d29d8a2 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -63,8 +63,8 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         }
         data = pixman_image_get_data(res->image);
     } else {
-        if (res->blob_size < (s->current_cursor->width *
-                              s->current_cursor->height * 4)) {
+        if (!res->iov || res->blob_size < (s->current_cursor->width *
+                                           s->current_cursor->height * 4)) {
             return;
         }
         data = res->blob;

-- 
2.55.0.543.g5ebe2ebe4ea8



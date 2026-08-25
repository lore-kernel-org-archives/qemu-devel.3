Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F3C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMs-0005wT-DR; Tue, 25 Aug 2026 07:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypM5-0005QJ-E3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypM2-0006N1-93
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uL5jGEcrEpQzIIoThweWju+wfQbdFcsQO2Ybh3WmuEI=;
 b=RC59DmtYCObOlcpJY8oZUJS16SO/a2byHQAMnShmiijoI2sEKqWEJirvEgi2QHDdDfQ0tr
 CsJI0W58yQ897z2uMLlbdSFb+ykWlSdUsX2bxsdN7YpQfDoFg0iIQpt8ZExM3JITguevFi
 1UayV1F38RF2nXfYVWz5tLWva4GTu0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-xyMO5nrzPDWoHTlX24GxMw-1; Tue,
 25 Aug 2026 07:30:04 -0400
X-MC-Unique: xyMO5nrzPDWoHTlX24GxMw-1
X-Mimecast-MFC-AGG-ID: xyMO5nrzPDWoHTlX24GxMw_1787657403
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F99D1955BF1; Tue, 25 Aug 2026 11:30:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C440195422E; Tue, 25 Aug 2026 11:30:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:04 +0400
Subject: [GIT PULL 14/19] hw/display/virtio-gpu: Avoid mmap() for empty
 blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-14-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1EjuhVLKQohCzphAuT6ig2Kmtuakt9951klpD1Q+Odg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrVsBffrN8HoI0ps/iKWXdpcRFmqhHLjit7N
 s8IfFuDdhyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5ZlvD/43pund8326utB75GwTUQMd1snvG3EoOVr2RnDs5ap1ZM0WjB3VepwKFLp1swxeB9dtzJ2
 sUZxwv2F8uj1AvythkkroJShF2rlf2mqsbwwLIQjWs8V+WvrV7YU7OWcUmw7g5RQOnXhUOYfY/d
 WXaal1Cm0omPwzTsdqZPzdXSm77bRH9+Nd2e2t1x10mEbPuu9gfIlvbEDZDNY0otjrG0FojWihQ
 a1hOAppmSRNpCmIzmsZuQEJGmBOEqP1f5dwI83n8lLie3iO3SjP/J4PlxE/EFi73QZNi7Yx+tib
 rz2ua/BrTJ+JVt3hL9IPIYUIljkZVCSAGYPiROvWW6I07YJpyjO5zzY+bue3KrKZ/Bb4Y5k/6nO
 fz1AZgaVNMKCPp5pSRco/6b7/Yp+9KD+I4C2DG9ZEyM7LeoM15o8zBSi7I8uoWtspilahLblald
 eYhD4qgUK0HKttaEmpm39hSzx82qjmNjitiIFmjynXB9pZY4XjhF91Gu1fJZFm3jOTzbyPjb6BZ
 tfMzlSRdcLAnihWpn5WYoryjeoW+zFghE7Ms+8H2WqILAOVAVQ9vYlXgbeMKdaSd2sQ4BhQa1NL
 u6O+lpGmlkI7i6EMjvuOSOc7z0Syvg/WYf1Aziw8G0Ku84FgTzJOBCFKja5jvMg40hQcR8DeIwE
 k3t5wX5N+327YWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Calling mmap() for an empty blob fails with EINVAL, causing QEMU to
emit a spurious warning.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825-dmabuf-v2-2-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu-udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 816f52a51457..ba02ba9e8616 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -139,7 +139,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
-    } else {
+    } else if (res->blob_size) {
         virtio_gpu_create_udmabuf(res);
         if (res->dmabuf_fd < 0) {
             return;

-- 
2.55.0.543.g5ebe2ebe4ea8



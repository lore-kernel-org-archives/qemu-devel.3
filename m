Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AE3C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsZ-0006iR-Rn; Mon, 27 Jul 2026 07:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsY-0006gC-CF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsW-0003kA-NY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNiaflyhGXOxa4ggjEKmuQj2KeuWOsy9yNfa0BhTzi0=;
 b=KMiOGSllG0gJGz+6KALKf/go2D3APxkFbt914jlqJBekZ1VG+F5W0FXyJoN0n6NActTy00
 yKl1UgncxYHp2H91nEGrcp/RNiqz6H3tSKXg67Q2ypdEoIKGpgGdu30CuNsmGL/xyjy0L1
 eOl5IzbdKht02aDu6LgFhhLhyzBWooE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-S3XMUpTWOEicrmPGYzTTTA-1; Mon,
 27 Jul 2026 07:52:12 -0400
X-MC-Unique: S3XMUpTWOEicrmPGYzTTTA-1
X-Mimecast-MFC-AGG-ID: S3XMUpTWOEicrmPGYzTTTA_1785153131
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 724151955E9E; Mon, 27 Jul 2026 11:52:11 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D918429; Mon, 27 Jul 2026 11:52:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:16 +0400
Subject: [GIT PULL 07/23] virtio-gpu: fix NULL deref in rutabaga
 set_scanout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-7-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ca/+vDvzNn20KqwVuvwprKoP35ci4y5uRFaQhtejmpk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+doM5nxOlbjtZicvqtd1vwdcOnK3GfztKR
 +RL4GJYMiSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5RwTD/9I7Way+E1yudIw7nrI0aZZqykRBcquIQsvy81chWMJvZuXNuevDlkpPZKc5td+8byKPKD
 Kk6o9TubM4FtLlNTUxuHgWwdufr4PPf+9wq3SpaeX4NyCHCSqWYPw60072elsobQqk8sjXe+8gu
 h4X01jRxfHNb/HVRmkGLubhJ8Np3UvpmNOvoHS4HpQYCr5vbSvt83XEYxAwNWC6tCDfg9/UgTzJ
 n6Jy1+3axkfte21bNh7SujnyS6kn3vKZcmpL4eOnAWek8tCLr53hijIERIeLIN+dxDy4UIlM66l
 tJ1555/eGYlgNfnPmKwZ3SxFjjZJqdXAOYpneM8NLtug5dUtuQEAjHIEDsbagQVA87Mwwm3b7zZ
 oSZU3qkapFBTTyqqtWyvphNuPxFaz2L5PNS+DagVpRNjNfkAnZpbzXeOywxRFsgABnp6hHcyq04
 w4Fr8BTrafh5eyhYXpBJ/O9KnGE9oBrDX92h4y6s9Ag9FocaJ4yiRjfREDIwFmmmE8+5Q/9bbi8
 kSl0/hlm32dh3pFWI+Bzuesn5CIejyjuuVYpQYGOGbpbI90m75blQ/OE3SKvhxJBjrN15CPvR1x
 4rGGoX/0ol5GyQJGcncOjeyaKqtd5LBUQDzHG/qLZsNKBcqwqzE4ZvezumKi2wAV37jDviiSFpV
 4TMLoLbJ7tlsTPw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
(16), but does not check scanout_id < conf.max_outputs like the base
class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.

With the default max_outputs=1, virtio_gpu_base_device_realize only
initializes scanout[0].con. A guest submitting SET_SCANOUT with
scanout_id >= 1 takes the con=NULL path, and
qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
QEMU.

Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
CHECK, since realization already ensures max_outputs <=
VIRTIO_GPU_MAX_SCANOUTS.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3897
Cc: qemu-stable@nongnu.org
Message-ID: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
---
 hw/display/virtio-gpu-rutabaga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 4d7d7b245929..6af5c2514d23 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
-    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
+    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {

-- 
2.55.0



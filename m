Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50F0C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G6C-0003nl-J3; Wed, 09 Sep 2026 07:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6A-0003ki-OI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G69-0005Gi-8q
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHHwspiJ/RpBE0HEPqNXG0+MxDXPOfiZVbdO3BXZFm0=;
 b=KzPDO2MT4tKdaCIPoDT5J3hruzKr/gaje/yeopsde5n3H81hGMWLu+WsvBYBz8HWXI15ss
 9Xe2LeLpU41RuYMXukcIGHpybhkXMHDg+oG1BgOBy26Q59jHVdznZou3Rf8wlo/G1CY5Ai
 RmAV3tl5EaOHbia5aLegDPNJV1EqLh0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38--v4lBJgyObiLJGlG8gn4Ww-1; Wed,
 09 Sep 2026 07:04:09 -0400
X-MC-Unique: -v4lBJgyObiLJGlG8gn4Ww-1
X-Mimecast-MFC-AGG-ID: -v4lBJgyObiLJGlG8gn4Ww_1788951848
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 048A518005A3; Wed,  9 Sep 2026 11:04:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 778AB1956088; Wed,  9 Sep 2026 11:04:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:16 +0400
Subject: [PATCH v3 11/24] ui/sdl2: clear guest_fb.dmabuf on release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-11-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ckwb6WKTNIogQkoKNEFb6W6xtaAoBV7HCY+xp/SqEdE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyrB8KhlzSXZlHtFjChvBUWk3zw8+p5GOh0
 3OVEuiTzUGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5TOqD/wIRmBq9Jv+x35M39S5KJJ2scewC4glLrzcacflP+YJSOC0y6SU7QZpZeH8N5erJ5wUsR4
 YhW4c/h0E2zsGZwii4sAvH6WfZsb6JQ5KDJfeKivLQftNFVWRVgMyhz4++xod6fSCYo71wWdGpm
 1L/trsVg7AnHYCMoqp73sntWUKS8AQ0RCqFPm0byuDJQEtUBZMzPMOyAOv0KjlqJ9WatX/Bvpjy
 9tO4bTezewPCoCUGfs/G/mzHTYuGtLf076rFrvr+LoSD+nayuMW3tJF9RCq/XMfXLwEn+WmXMy5
 Pds+Zf/1Zj8hLa40Ymha40tZYR8M7X16m7bO6LsOGjpjbBDfi3Xosd+w2d97qMFYzg/GIKwoYhw
 8R088iIkeA41GT+K9T+SNQBBVlMNcWbdYRHyijHPcPHxBQB7IxFZdGaBsrzfpB46AY0eYMvBJtz
 z/Oh49DtdGY6/0AE8YGQFW62FfXB9vrSDrBhPeIxGqCx7/ehiqYHKX6ua2AhuzsHxMbdKl9KAyz
 1Gzv4e8BrZO2h6qiihic7k8yIHB+739arXq/TfxaM5RLcPsJ6ucnuhYZWKKLIR4BssxPEfTPkYA
 0kbgBCtU/LMHH3rOXZqaw7ZE4Jpd+nIAtsUFeKfheZvm9mBYuAaRT3rSSUq0HeCla5d6BO9j6W2
 AsKti+d6MhTMt9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

sdl2_gl_release_dmabuf() releases the texture but leaves the
guest_fb.dmabuf pointer dangling. Clear it to prevent stale
references after the dmabuf is freed.

Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2-gl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 1547ad2f6f80..46eff768c968 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -286,7 +286,12 @@ void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
 void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
                             QemuDmaBuf *dmabuf)
 {
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
     egl_dmabuf_release_texture(dmabuf);
+    if (scon->guest_fb.dmabuf == dmabuf) {
+        scon->guest_fb.dmabuf = NULL;
+    }
 }
 
 bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)

-- 
2.55.0.543.g5ebe2ebe4ea8



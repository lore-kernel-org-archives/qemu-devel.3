Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D786CC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ThD-0004RW-CS; Fri, 04 Sep 2026 09:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2ThB-0004R7-Lg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Th9-00055q-Qn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfqhV0k2wnTQNP/8Pi8Tj3/PSKa/COTcPUpKOxqHnxc=;
 b=XXHXe6LTd+EigD1UyI0wyeKyVbGsyij86oN87HbYBkrnLJATfNU3IkWnYveWjJ+5S1pdVX
 yHJxuxScjm87v2PuykCmI2/fZb08hi/62kBnoyehrA+NnPtvLWOcft+If6kFhMwkwVKuuN
 2zkH0IaXWuVRS/oJnIMWX9DYdYE7hFo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-zAkaO3lJOgulv72hKfa36g-1; Fri,
 04 Sep 2026 09:11:01 -0400
X-MC-Unique: zAkaO3lJOgulv72hKfa36g-1
X-Mimecast-MFC-AGG-ID: zAkaO3lJOgulv72hKfa36g_1788527460
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0C11191F5AD; Fri,  4 Sep 2026 13:10:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF9DF1803A40; Fri,  4 Sep 2026 13:10:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:15 +0400
Subject: [PATCH v2 11/25] ui/sdl2: clear guest_fb.dmabuf on release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-11-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=984;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=soqzgd5o5ILBeI69vpRutTaDwn5XU9TT0gvi1GNhfSg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvsVzzRgiUX2WnCXwjE0GsDQdrHFsXKHdEW
 xmiad9NTGyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5YKXD/9zJgm8Kjiu6zY9OYDOAIKq2Mh8XBxLf6HH5M5gFDCx9ie+IFTx3L9fDoiUYUuJgpVbYuq
 2PJNYqzhktP2SXE9EF9HtgKVJU54KaCYjIulT8rQZWV6foQ5VQirWy1p+/CG4IKBI4mAcg4hyHE
 ++WaA2MSYKx1iokIAlQ9KkVLccvyCNmA9lTHvlk5POCkFb2DvPg7FKm/7kJn/cA5oxTog4kK66X
 BH3xHgKmKPEDmhL/fbqv8D18YefqspVU3Fb6T854M+LfkGc8oOw9FSl2o/+wWmFFAjyQAtpklzb
 CPvOkMm6wwJj2xQRHG7Cud2lSQZqL7vyrY5FKfsPZRGloGAiwnv4/4lQLOzdFYsS+SS8GpQ9RAm
 W/IMWX9Ldgl2m0QtHrD+YiL2bH7ULHUPlfXgHOop48WQDMXzLsUPuwzcVZEUc4pTc4uFNEY3H5N
 iI8Mc1EW/Anj+moDWbV8zkHD/xjVrKvLYziKTkl9lwe+X+IK+HAOSTwA8f4erOtuHZqI08B8Ces
 QYNKk8BLSxCwC18JU2lDhoTvLBZWAW+C/NggkQSd+eKN8j4+2gV2bo5b4RGomWI34qQqvlGhgO2
 2pChGKTYBaqToQTY9/BjhGEik5YzbKKMLknpA1h0bxEvrFykgBVQpjXV1vQs/KTdVUHzVLKTXQA
 pDBim/cjbShdDZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

sdl2_gl_release_dmabuf() releases the texture but leaves the
guest_fb.dmabuf pointer dangling. Clear it to prevent stale
references after the dmabuf is freed.

Fixes: 52053b7e0a0e ("ui/sdl2: Implement dpy dmabuf functions")
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



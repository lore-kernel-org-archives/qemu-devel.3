Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3EFC88E42
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZzU-0003RJ-RH; Thu, 10 Sep 2026 04:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzT-0003R7-53
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ZzR-0004uj-6o
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHHwspiJ/RpBE0HEPqNXG0+MxDXPOfiZVbdO3BXZFm0=;
 b=QtG0K4K7deKmTnbtv6ISb6VdGcSdaIkdgVugTD3EJ7n/0RCiPv0B44zUFew//753IsIyST
 iIdk/hQ9GVicM9PRNVOWCfnxErJaRx4E3T2YKDISEkm39G/tkXfV+owCrkLWMnk/Xc8NVm
 V7ovMrFt96fgBBd+u5QbZBfRxeZ2SWQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-4mr2L9krPz6yZLBbOZibKg-1; Thu,
 10 Sep 2026 04:18:33 -0400
X-MC-Unique: 4mr2L9krPz6yZLBbOZibKg-1
X-Mimecast-MFC-AGG-ID: 4mr2L9krPz6yZLBbOZibKg_1789028312
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AEBF1956060; Thu, 10 Sep 2026 08:18:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBEC41800351; Thu, 10 Sep 2026 08:18:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:39 +0400
Subject: [PATCH v4 11/24] ui/sdl2: clear guest_fb.dmabuf on release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-11-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeo2fQLG3Msg8Yg3jsXFe2NaNvivQ/qccdAn
 ldDz3ekkY+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5ROsD/9W1eGSiOvGzg6P7oUHOUkSw+1O6cUdA0l1cTq2bx6p4DbIVAGFGLW5L7arumrCeNGj2XI
 kup1rG8BfoAyjDJYt0GUZBRg+UD03kR9YKu/nIETrmXckeSyYraeew1vI5HzLyl7CFl7hXuAKlu
 QixYOaiT5RFsf1q/lIzZ13dR7NT4DoYGqIXS0gxvEqVCEyERth+piL0Uood/T/Uu7ek6ZXuvNv8
 IcUYfgFC4uzX7awDXoe3QWV+D1lqp9NLZygKrYMutf1VoM76OCNCB70WO3Eu3wZcgvnEEN8j/VC
 MkDntcgRX4QibzEsZwpDNsjyU9Cni6aO1CGBJksd7I7O7Avt8gKyBBumsJxkWOw4EyoD6axYkJK
 MmLke/Ztm5BGiAEiFbK2a2RCXdPdGFotVgEbnjj7GwGby7EqI8/J65s2rL38Y0C2oRev4n7N8ch
 VVBkIk3R77+CLxwnNjMNFuOrgPASZmOaMt+4aAN3qJEKdVUuhSHcerE2fOBGUWLwNlDVd/ceb9f
 NMDJ2k7ZXwLEeUM4BaBmS/zEbHTUQS5cF7JxTqqVwWhC9dxJlj4422A4WEkbqdJN8Uhp8xH4/Mm
 gf4llojub8XiHy2e1sVzaq++pMgZ1SkEQylIUNsshZq1SrBReWLVAF3PYe/fWjGEqafkDiwesXG
 d5h7SywjupZno5Q==
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



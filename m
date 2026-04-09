Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E60CF364A9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAt9F-0008SE-0Z; Thu, 09 Apr 2026 13:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wAqeg-0000X8-Fs
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:46:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wAqee-0003Pz-7m
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:46:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso10436715e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neodyme.io; s=google; t=1775746004; x=1776350804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tzOL7FDl1K7aen5hTdBzUNU7jyLuiNQRylvYSYEPqdw=;
 b=YjjEklQO0UuGIaisY8fphsQFPq+Ldr/VfwoMKkVRletztrcfYQQVs7cWH3SWVR1hCK
 ktbTJSgfAPA0i3JCk4FBykRe2RK7LiEwXpEnqfrKYJiLRgb+qHDqAbg69XA+l6ZFfrfW
 uvtQwL3mLC5iRCR2U9L77IFa8skWipMxp7AmUM7XpS6SOXPnMmqPFIOXH5cYwzLO1IIG
 KMMHrepclYOHQ2lQFRouam6cn1P/rXS4vBt6GQkb9AMj0Yz6yle52QazI/UdaCL/dCdu
 UKg8WXBBuFWYjOlXtq/I91QZsHuBUWhgvoPWVpWNTkP6e6FGLxxwfO5bjrdUbOivXfZe
 eEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746004; x=1776350804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzOL7FDl1K7aen5hTdBzUNU7jyLuiNQRylvYSYEPqdw=;
 b=ZEfNUHdOmJRVtaBcXZdvofGvJ+jlTy5f9OmNQZzKKwYGko7HxphYIIFyAEct5zhmKa
 J78mCrSKVAdxQC0K/MnGq1Z1/IbZ9tTsq1xDVLR9YCofyP7JUxQ6l+kvZ+fw/117pb4R
 o1243tGBXOjw/tJhbhOkC8RyLjWCHJ2pwOqW3vjlX9WqBA2CgF2yY9E49He8WoCVaTu3
 kcoKCE7s3teKxTaRYA+D9SOLhhPdOEu8haHozSYxdECR5yCF2At7geSYj/wwZlyXTTUp
 EBP3qDcO9CNRIBJxuORRxRKtiJfFbW4gWYIPntg8mtsCJ9PrQ0CecKe+dAIWVfI4khaf
 prbg==
X-Gm-Message-State: AOJu0YyMfwaaAROq9urtXuNlrZxZsXjZbz4W+KOmY372188u7DXsovcR
 P6icgWFnJC3YYZHWczx0KObY1CdA5pxIynqQF9FkWunuv41q9pI/av6swGFqjghpdJkbYW+HGee
 2RHb7HKUMRbhyoK9EdFO6Yy1nWB94Gr+eUBZbav+Pa8itcZvNoAtDNrfPt+H2rXc9am8=
X-Gm-Gg: AeBDietoV3bd5gIo2KoHm1pJHGMEGqkAWbKOg/CiTCAalA6373JPdKtgGCvm8pG1Xid
 F9wJG/v6DKMt6qeHTbkbVzmOBFLvXNvjfIZYSva0MGhjfziPj8mXpnrNmnLHv2Mp9GQ5dT0VoR7
 w+EoSqOvz/9aEeAyotT/MAkVxKrvgzc85Yq9OJZRKdfSDhOSqvRDdTuopTwVbNJeH6w8kRxJglC
 DjwJFDCroazZjEt3eFS2mwKHSoK6xNWhF9r97/CdEPi6s8nnIxcYIY3X6LggiqRPihYSUdl2zjY
 8Rm3EmLl0JCl2HeIPsVYLwaM4KeyREs3oL13/Zi2WnVvr7FVOonrHX2+HEk16rm9Smx8O1xKVqF
 ywGyt+cfEiIZ7MM1ePSQTBXjb3he84CBEf9LLi3fBbzvu8PM8g5bF04tFCmBKv74stFpbBGgL+k
 C0WLhRyq49+CQ/LKoeTyCn3kaBCMTKCJSicZLgVV69vvPxx/kD0jna625+RXnpeUt0F7yt5+ZYZ
 v+puaJ8tTkwgyNlOmFAQVOHvVFpxfkFojUgw0wKFGXtH/zbxwtIJqS4Z6q+FA==
X-Received: by 2002:a05:600c:6387:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488d08efdf2mr32906005e9.12.1775746004198; 
 Thu, 09 Apr 2026 07:46:44 -0700 (PDT)
Received: from i-cube.fritz.box.net
 (p200300c27729d60078e64648c83f9ad2.dip0.t-ipconnect.de.
 [2003:c2:7729:d600:78e6:4648:c83f:9ad2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd0eaeecsm26248105e9.8.2026.04.09.07.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:46:43 -0700 (PDT)
From: =?UTF-8?q?Benno=20F=C3=BCnst=C3=BCck?= <benno.fuenfstueck@neodyme.io>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Benno=20F=C3=BCnfst=C3=BCck?= <benno.fuenfstueck@neodyme.io>
Subject: [PATCH] virtio-gpu: fix inverted mouse cursor
Date: Thu,  9 Apr 2026 16:46:39 +0200
Message-ID: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=benno.fuenfstueck@neodyme.io; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 13:26:29 -0400
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

From: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>

When using virtio-gpu-gl, if the guest uses hardware mouse cursor accelerat=
ion then the mouse cursor can end up being a resource with the flag Y_0_TOP=
 set. In this case, we need to make sure to flip the cursor data such that =
display clients render it correctly.

For example, this fixes mouse cursor rendering for wlroots-based window man=
agers (like Sway) in Linux guests.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2315
Signed-off-by: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>
---
 hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c466..4562d3405e 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g=
,
     VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
     uint32_t width, height;
     uint32_t pixels, *data;
+    bool y_0_top =3D true;
+    int ret;
+    struct virgl_renderer_resource_info info;
=20
     if (gl->renderer_state !=3D RS_INITED) {
         return;
@@ -49,8 +52,23 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *=
g,
         return;
     }
=20
+    memset(&info, 0, sizeof(info));
+    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
+    if (ret =3D=3D 0) {
+        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
+    }
+
     pixels =3D s->current_cursor->width * s->current_cursor->height;
-    memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
+    if (y_0_top) {
+        memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
+    } else {
+        uint32_t *dst =3D s->current_cursor->data;
+        for (uint32_t y =3D 0; y < height; y++) {
+            memcpy(dst + y * width,
+                   data + (height - 1 - y) * width,
+                   width * sizeof(uint32_t));
+        }
+    }
     free(data);
 }
=20
--=20
2.50.1 (Apple Git-155)


--=20
Neodyme AG
Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |=C2=A0
85748 Garching b.M=C3=BCnchen
Postanschrift:=C2=A0=E2=80=8BRosenthaler Stra=C3=9Fe 72a |=C2=A0=E2=80=8B10=
119=20
Berlin

Registergericht / Registry court: M=C3=BCnchen, HRB 269168
Vorstand /=20
Management Board: Thomas Lambertz | Tobias Madl
Aufsichtsratsvorsitzender /=20
Chairman of the Supervisory Board: Hendrik Hofstadt






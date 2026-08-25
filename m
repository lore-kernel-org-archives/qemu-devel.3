Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE950C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoJD-00079j-Ak; Tue, 25 Aug 2026 06:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJB-0006ze-H4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoJA-0005nN-5Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfqhV0k2wnTQNP/8Pi8Tj3/PSKa/COTcPUpKOxqHnxc=;
 b=cYe5cyTQPGuBZ4nW48Tav9OZkq7N8A+L2ng6yB/C2s9Cz8oYw5+pRVqZsy52VI5H9q0rmA
 y7PEezQD86qEPXlAZ1Y5w6LTXcHFDz7I6jMdByzVv+YK2So0ba1y6U/ewnrJ+ekTDiGZ/v
 gKeJWt9dOv2bAGGbenDzyv6PTXVPwZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-VMg6GO1nPVi_dPjlpLYtrw-1; Tue,
 25 Aug 2026 06:23:04 -0400
X-MC-Unique: VMg6GO1nPVi_dPjlpLYtrw-1
X-Mimecast-MFC-AGG-ID: VMg6GO1nPVi_dPjlpLYtrw_1787653383
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA5D919540C8; Tue, 25 Aug 2026 10:23:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 533DA30002EF; Tue, 25 Aug 2026 10:22:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:42 +0400
Subject: [PATCH 05/18] ui/sdl2: clear guest_fb.dmabuf on release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-5-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyXz2Yn2vDtuvnl7ZvBDMvfVlySKWyA9IVmA
 afu1ql6TTmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1slwAKCRDa6OEJdZac
 5a5oD/9ixoDpBY/8Ky0Fbb3i230pOCVKLrkF5rRA8fwb+knlGPb4DG5yo/IOyPAgrAnWh5EAj9u
 abuSq0AX37T6pbFGygRA+PVgDX5K7YtADvUQ8hlTITh+FGrXNgnHGzK9gXNKYWGuBRDOyTNvFV9
 OWGdiJdGKmPhxwHWD05Ckha/T7JM3VwleVJU8tvhDFQBwfSr7Op5nfKo9N9Q1inBey/hR4vUSBa
 rf1GU9rdRu+zyUBG0zyXxKBYzM6VUQgx7TWZKM0nqyUDpXPlNM2D1Aw36Q3+F4tLC8AsJMSJ6eX
 jVRNVlbaXEMQuE5Z0NJ3xPEz+tDjXYtswcqTKtz4hLxda0riqZcRkTm8Mjw0HDUfqDgIX3YJMUm
 NB87n59hJ53gmfXP/V8ypYk94ZgN61T2Ts6GSoV+tgtt/lCrQ12fnk6JkKeGIBvewNmY5UpZgMk
 RGGO8CYLc/fmtjs4P5IEbXnMszf94Yfn66/5CR5N2eLFturuFHuo/xijPLGSp+/QpV8VUhAqca8
 RuojKbMf+XN0Grd27ToDvVasLrDjU5iyseuqm949m7M4TVjXqL4mRWbdaqMckqomVKUtojzxMOZ
 ElIaDHb+fdYshCbi/OVwFvU0AWUO+yav23wgwbkgSTNpqDgEP0dE7xdAn/d942GNQlZ15jyYPvC
 tMuxibsClw9aa7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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



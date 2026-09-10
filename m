Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033FFC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4erz-0003Zz-IU; Thu, 10 Sep 2026 09:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4ery-0003Uk-2p
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4erw-0003hK-MU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHHwspiJ/RpBE0HEPqNXG0+MxDXPOfiZVbdO3BXZFm0=;
 b=JIJyEjHUf++/WOKIvIm+JBUdtJnwPixBfy4b1o5yCVKuDPAIzn63s1fDV4Jtp/PjkmlTIw
 Xiqmkd0KOcWQ/ZJ1o5FPjHA8HfsHF7XzAPswBqIT2P2cbCHRsqbpMR65Bx56Yqo/U+Gfpl
 LRtUOzR+png19ypWcoJ9QT3Vv092M9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-hb9q2xo7NS2vhaNhsJRybw-1; Thu,
 10 Sep 2026 09:31:08 -0400
X-MC-Unique: hb9q2xo7NS2vhaNhsJRybw-1
X-Mimecast-MFC-AGG-ID: hb9q2xo7NS2vhaNhsJRybw_1789047067
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0071955E7B; Thu, 10 Sep 2026 13:31:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8A4A3000239; Thu, 10 Sep 2026 13:31:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:06 +0400
Subject: [GIT PULL 11/24] ui/sdl2: clear guest_fb.dmabuf on release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-11-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ckwb6WKTNIogQkoKNEFb6W6xtaAoBV7HCY+xp/SqEdE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDcjt94lYYCHnIMxTQ7LUwEQQ+PhJ1gUA12n
 +Ja7SwpdviJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3AAKCRDa6OEJdZac
 5SRjD/4qSIApWTuBEbFDj0X3FnDv/4lKWq8sOOHyEG2cwEkVWK7af+iiacRA3TpDl6hoIh++wRI
 V2Y53opWuk6maFofeV5X6ZrJ6O//+g73zZCPjahWRzpfa+w4fktNkMGLo8FRM6p+vtUpTX6LWm/
 7obnFhaey7eqj9iBLmrosC4SlnCOyVN2iPijjO8m+m8oNLlTG0n44E5ldyiBPo80aPfm2IlnJoT
 kaJpA4FMYcHTSt3dk7zsLf6uMnPr48nKsm0QhOSspO2iiEPJi65W0h0Q65qTh9LK9loTjhdygLk
 ualTwQ+VL5/AGONHZ8GssdIb3gsd9m6wjryDGM8RXvyH7oRtMu8Fi6U8Q/d1C8fbQyPCXGf5wjJ
 S1KIz96YNSnyljlEHbs0xQIiMDrcbymd7kWVkEOT755qxZdjisVphiVeFq7hrYcoABfkFcLb44h
 5rVBLOc2rUQRvYcASlenW4ktTuSAUALIVsfEtdFGAMbty+NXuzwE34/MRFAICN6c0CjWsmWGFiE
 GjyVEk3pLXR3o4G/yyKFCZFLmYM5jL6TLLbZXq3+5D1Ivp+qZVggI3lUNC2H4Qx19XLkHusmwO5
 9n27WB0p7zabNZE6yi2DDtJFOo9M3lg7GF04WhTyugHbFVjk9cVUFlqeSoTosogvll0oWmXG3tu
 Kwhm2FN/MoLLskw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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



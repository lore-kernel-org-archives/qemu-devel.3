Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C8FC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqTj-0008Gl-NM; Wed, 05 Jun 2024 09:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEqTg-0008F4-Cc
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEqTe-0006EJ-1x
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717593292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkSiq4a30KX/BtKlzALhqQstMUl79qOxtGFoh3xybvE=;
 b=P6TkaPomyj8h0djr4ki93gTaFdYTrLsGK/8usJWTxEZeQ0DRTsq330lDEns8QZyF8XPM/K
 mbIgmOGJQyuaKTMAzkR8OQL7OhgSBHqWbG2Hv3q3hwfSz68ZvgwuqztDnbN+jhASwdyoAb
 0DjO3XdmVaG+7X9Ze9UgH7+3sT4wduI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-rbWF64UtPluLoJfyEMRmOA-1; Wed,
 05 Jun 2024 09:14:49 -0400
X-MC-Unique: rbWF64UtPluLoJfyEMRmOA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7CBD1955DAB; Wed,  5 Jun 2024 13:14:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FC2C1956055; Wed,  5 Jun 2024 13:14:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 437C71800DD3; Wed,  5 Jun 2024 15:14:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Gerd Hoffmann <kraxel@redhat.com>, Anthony PERARD <anthony@xenproject.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 1/3] stdvga: fix screen blanking
Date: Wed,  5 Jun 2024 15:14:41 +0200
Message-ID: <20240605131444.797896-2-kraxel@redhat.com>
In-Reply-To: <20240605131444.797896-1-kraxel@redhat.com>
References: <20240605131444.797896-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In case the display surface uses a shared buffer (i.e. uses vga vram
directly instead of a shadow) go unshare the buffer before clearing it.

This avoids vga memory corruption, which in turn fixes unblanking not
working properly with X11.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2067
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 30facc6c8e33..474b6b14c327 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
     if (s->last_scr_width <= 0 || s->last_scr_height <= 0)
         return;
 
+    if (is_buffer_shared(surface)) {
+        /* unshare buffer, otherwise the blanking corrupts vga vram */
+        surface = qemu_create_displaysurface(s->last_scr_width, s->last_scr_height);
+        dpy_gfx_replace_surface(s->con, surface);
+    }
+
     w = s->last_scr_width * surface_bytes_per_pixel(surface);
     d = surface_data(surface);
     for(i = 0; i < s->last_scr_height; i++) {
-- 
2.45.1



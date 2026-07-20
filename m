Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1DC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmR5-0004wh-GX; Mon, 20 Jul 2026 07:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlmR3-0004uL-0R
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlmR1-0002LP-Aw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784547921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vDMfCNJL4UMCBXo6maaFDh2By6IaadEcmRgiCqU3iX8=;
 b=MP34RTql6lc5+yc80oiD2CVCDVVz7HMGCIAtoV8o9DfRKJL5Qr0dukv+/yNt1r1T0sA/nS
 UupEbFI8qYRRd0kpOiGZroOpe9nNm5a4QjWn4cAV8TIFJtqSR+zqAY60k80AMqpIU+miVE
 E+1qO7Au2NbsRxD0GJxxhPIDFM0dZKE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-OHToc7ZcMPOHigS2pCFKaA-1; Mon,
 20 Jul 2026 07:45:19 -0400
X-MC-Unique: OHToc7ZcMPOHigS2pCFKaA-1
X-Mimecast-MFC-AGG-ID: OHToc7ZcMPOHigS2pCFKaA_1784547918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B895195C242
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:45:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36C951956094; Mon, 20 Jul 2026 11:45:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/display/qxl: validate primary surface stride against width
Date: Mon, 20 Jul 2026 15:45:13 +0400
Message-ID: <20260720114513.2500370-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The existing validation in qxl_create_guest_primary() checks that
abs(stride) * height fits in vgamem_size and that stride is 4-byte
aligned, but never checks that abs(stride) is large enough to hold one
row of pixels for the declared width and format.

A malicious guest can create a primary surface with a stride much
smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
surface). The spice server rejects this via red_validate_surface(), but
the return is void and QEMU unconditionally proceeds to set up the local
rendering state. On the next display refresh, VNC or SDL reads width *
byptes_pp per scanline from a region backed by only stride bytes per
row, causing a host-side out-of-bounds read.

Add three checks before creating the surface:
 - reject unknown surface formats
 - reject zero width or height
 - reject surfaces where abs(stride) < width * bytes_per_pixel

Fixes: CVE-2026-16271
Fixes: 3761abb16784 ("hw/display/qxl: fix signed to unsigned comparison")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 4a56f07b157..36fc681cbfb 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1524,6 +1524,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
     QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
     uint32_t requested_height = le32_to_cpu(sc->height);
     int requested_stride = le32_to_cpu(sc->stride);
+    uint32_t bytes_pp;
 
     if (requested_stride == INT32_MIN ||
         abs(requested_stride) * (uint64_t)requested_height
@@ -1560,6 +1561,34 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
         return;
     }
 
+    switch (surface.format) {
+    case SPICE_SURFACE_FMT_16_555:
+    case SPICE_SURFACE_FMT_16_565:
+        bytes_pp = 2;
+        break;
+    case SPICE_SURFACE_FMT_32_xRGB:
+    case SPICE_SURFACE_FMT_32_ARGB:
+        bytes_pp = 4;
+        break;
+    default:
+        qxl_set_guest_bug(qxl, "%s: unhandled format %d",
+                          __func__, surface.format);
+        return;
+    }
+
+    if (surface.width == 0 || surface.height == 0) {
+        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
+                          __func__, surface.width, surface.height);
+        return;
+    }
+
+    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
+        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
+                          " stride %d width %u bpp %u",
+                          __func__, surface.stride, surface.width, bytes_pp);
+        return;
+    }
+
     surface.mouse_mode = true;
     surface.group_id   = MEMSLOT_GROUP_GUEST;
     if (loadvm) {
-- 
2.55.0



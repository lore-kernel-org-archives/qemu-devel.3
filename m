Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FBAC44509
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBXL-0006NW-DH; Fri, 10 Jul 2026 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBXK-0006NO-34
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBXI-0008Hv-HT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783691099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B6VmVXS+DVJ0n101ho+JP1JR0MasVN8LbWr//fjD4SM=;
 b=iNz67jaCYSmR8BA/vntbPP0t/0uWJsEwXKasUcaCpth5KVfmPxToOH40X6vU2Flveq93k7
 KHPP1VLjfqUgAPxUG8Jy9LDsnjEj17zaBPOvj3seYWCRCQFBWWRfMMxKifKJu0prjRU9Aa
 UW7YOoBHmpIkkEfotwdxO08evtAr4W8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-MDr7OEBXOk-HvE6IQ-qHXw-1; Fri,
 10 Jul 2026 09:44:58 -0400
X-MC-Unique: MDr7OEBXOk-HvE6IQ-qHXw-1
X-Mimecast-MFC-AGG-ID: MDr7OEBXOk-HvE6IQ-qHXw_1783691097
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0339F1955F40
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:44:55 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAAD030A8; Fri, 10 Jul 2026 13:44:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/display/qxl: fix heap buffer overflow in qxl_blit
Date: Fri, 10 Jul 2026 17:44:50 +0400
Message-ID: <20260710134450.2314872-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

qxl_blit() used the guest-controlled abs_stride to walk the destination
display surface pointer. When the guest sets a negative stride, the
display surface is allocated with qemu_create_displaysurface() using
width-based stride, but abs_stride can be much larger (e.g. 65536 for
width=64). This causes dst to advance past the allocated surface buffer,
resulting in an out-of-bounds heap write with attacker-controlled bytes.

Use surface_stride() for the destination pointer instead, which returns
the actual stride of the allocated display surface. When stride > 0 the
surface is created with abs_stride so behavior is unchanged.

Fixes: CVE-2026-15251
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3813
Reported-by: Pulkit Singh Singaria (x3ero0)
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl-render.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 4799c9e8bef..3f922f5c170 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -30,6 +30,7 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     uint8_t *dst = surface_data(surface);
     uint8_t *src;
     int len, i;
+    int dst_stride = surface_stride(surface);
 
     if (!surface_is_allocated(surface)) {
         return;
@@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     } else {
         src += rect->top * qxl->guest_primary.abs_stride;
     }
-    dst += rect->top  * qxl->guest_primary.abs_stride;
+    dst += rect->top  * dst_stride;
     src += rect->left * qxl->guest_primary.bytes_pp;
     dst += rect->left * qxl->guest_primary.bytes_pp;
     len  = (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
 
     for (i = rect->top; i < rect->bottom; i++) {
         memcpy(dst, src, len);
-        dst += qxl->guest_primary.abs_stride;
+        dst += dst_stride;
         src += qxl->guest_primary.qxl_stride;
     }
 }
-- 
2.55.0



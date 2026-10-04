Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D7FCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQK-0002EC-TD; Sun, 04 Oct 2026 06:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQG-0001kK-Hb
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQE-0003P9-TB
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PK6cl16u4bKlvIIDRZitT04MwfyM9MGnnz9qJI2O7t0=;
 b=aptryQGglGYCsfty494riEdWBpyojVo90Sq1OispbeR0em/cpNS6eKptbID8WfC41lM5q8
 wX6fnEyEdVCML4LqGesuT6OSwXBzMKgdPM25dYM2f4aXkQ+HOQGywMx88f++mEHRJAracm
 Y2M+aUWeO8CNBOvxksztfYBe3hIs2zc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-Wefh2PdrPqaZdXjFH-09aw-1; Sun,
 04 Oct 2026 06:26:17 -0400
X-MC-Unique: Wefh2PdrPqaZdXjFH-09aw-1
X-Mimecast-MFC-AGG-ID: Wefh2PdrPqaZdXjFH-09aw_1791109574
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8DCC1954B16; Sun,  4 Oct 2026 10:26:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD8CC19560AB; Sun,  4 Oct 2026 10:26:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:58 +0400
Subject: [PATCH 44/63] hw/display/ramfb: fix map/unmap region size mismatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-44-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S3N9mIyyEwY2bhiWE62k+lnO/E86nVKyHluZIz1zt4g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkZ/27reU140wXVsC/9I5+ESnT9d2Xp5LjO
 W06n/0nV2+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5VgaD/9NJxJg2BAdkgvcIiRDohasAheeDalIJi4c6HIX9l+w90taNzL08M7s0z+k6iARPO5gDPR
 HllgOqpDT9rmkdYZF6u+OLCJBtu11TXBoxPsZ42wmUrtwL8NW7pfurVYnmQhLTShNdtZQbrITJE
 xTvam9danSalZmFuZvO02CHQlnFLSDh9olxbimwsDkpeIbuMK2OrpXQevnI/QrOKYSkf4yPxYSL
 NJYOjJ+SB+WtQu/fI4UeNqHGWa43jAZ42psBRKu1vifiR/PSJijKZSk/vwhvh1hYi3GjXZefwvK
 5BykmkpmRHV2ALSa7mP8ZLFXqmoCSToY6KfbgVhcXbUfxEsl2VGD4wagGuV+lCucIpPltEv++0x
 atUeGkNQVhjTDgDB8bmgFsQFG9h5oiAmqZ2N7Jl1N0ejcG0QMOjGVnVDB6z5XK4bkg+g1+Dk4m/
 OiF++rzIp0cP0yN2aT5+VnyLCCRhXTW3sumYNv4M1sxbCGJOIwVzZA77kQVf5X0WS6Hq2K4714j
 akZxJa4XycTbCPPykzFmUnqO6RnpdqZGxnA1tlYZejE6QqPGBEI1d9cFRippngzUnUW/kPCNZJX
 ZaNL0QjzV22ofxOaNYYoccGP87lMMxy4TxQ0vEGJstGCjwqkdI6oc6bMvJmy1VayVpqwKCNKFbZ
 LJx8mxAUUd1vx9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

The map path computed the framebuffer size as
stride*(height-1)+linesize, while the unmap callback in
ramfb_unmap_display_surface used stride*height. This mismatch means
we unmap more bytes than we mapped.

Fix the unmap callback to recompute linesize from the pixman image
properties and use stride*(height-1)+linesize, matching the map path.
The last scanline only occupies linesize bytes, so there is no need
to map the trailing stride padding.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 3fcf15df0073 ("ramfb: fix size calculation")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ramfb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 2d5378754717..956c2660cb52 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -41,8 +41,11 @@ struct RAMFBState {
 static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
 {
     void *data = pixman_image_get_data(image);
-    uint32_t size = pixman_image_get_stride(image) *
-        pixman_image_get_height(image);
+    int stride = pixman_image_get_stride(image);
+    int height = pixman_image_get_height(image);
+    hwaddr linesize = pixman_image_get_width(image) *
+        PIXMAN_FORMAT_BPP(pixman_image_get_format(image)) / 8;
+    hwaddr size = (hwaddr)stride * (height - 1) + linesize;
     physical_memory_unmap(data, size, 0, 0);
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56



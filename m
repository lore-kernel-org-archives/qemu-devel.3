Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0020C5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsmx-000095-P0; Sat, 24 May 2025 13:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsmt-0008Re-SQ
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsms-0000kG-6b
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvfmhXkFKgpdo74Mx0i48lY/oqi/ZCY4LrmYKzh3wB0=;
 b=QoAzyK1NCx9YXuf05deX5Z14rtUmy2WQh8f50pAe0yhXoW16RcJ4Q58r6cEBSbKVyCCg9s
 guvwouare5ONHgOJ+mWjzJpCCUQrOJNaWIxA9/gkIcpvpHVYJ5xxrxJXJu0wZwoCaEhFeX
 cnpTwnHYJL7PwgrWG4YLB/K+FwMeZaM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-1-eYWJV0MuiQ07Hf6nnN1Q-1; Sat,
 24 May 2025 13:35:55 -0400
X-MC-Unique: 1-eYWJV0MuiQ07Hf6nnN1Q-1
X-Mimecast-MFC-AGG-ID: 1-eYWJV0MuiQ07Hf6nnN1Q_1748108155
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7E7318004AD; Sat, 24 May 2025 17:35:54 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1C2F19560AD; Sat, 24 May 2025 17:35:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>
Subject: [PULL 11/19] ui/gtk: Document scale and coordinate handling
Date: Sat, 24 May 2025 19:35:04 +0200
Message-ID: <20250524173514.317886-12-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Weifeng Liu <weifeng.liu.z@gmail.com>

The existence of multiple scaling factors forces us to deal with various
coordinate systems and this would be confusing. It would be beneficial
to define the concepts clearly and use consistent representation for
variables in different coordinates.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Message-ID: <20250511073337.876650-2-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/gtk.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 982037b2c0..9f3171abc5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -800,6 +800,71 @@ void gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget *widget)
 #endif
 }
 
+/**
+ * DOC: Coordinate handling.
+ *
+ * We are coping with sizes and positions in various coordinates and the
+ * handling of these coordinates is somewhat confusing. It would benefit us
+ * all if we define these coordinates explicitly and clearly. Besides, it's
+ * also helpful to follow the same naming convention for variables
+ * representing values in different coordinates.
+ *
+ * I. Definitions
+ *
+ * - (guest) buffer coordinate: this is the coordinates that the guest will
+ *   see. The x/y offsets and width/height specified in commands sent by
+ *   guest is basically in buffer coordinate.
+ *
+ * - (host) pixel coordinate: this is the coordinate in pixel level on the
+ *   host destop. A window/widget of width 300 in pixel coordinate means it
+ *   occupies 300 pixels horizontally.
+ *
+ * - (host) logical window coordinate: the existence of global scaling
+ *   factor in desktop level makes this kind of coordinate play a role. It
+ *   always holds that (logical window size) * (global scale factor) =
+ *   (pixel size).
+ *
+ * - global scale factor: this is specified in desktop level and is
+ *   typically invariant during the life cycle of the process. Users with
+ *   high-DPI monitors might set this scale, for example, to 2, in order to
+ *   make the UI look larger.
+ *
+ * - zooming scale: this can be freely controlled by the QEMU user to zoom
+ *   in/out the guest content.
+ *
+ * II. Representation
+ *
+ * We'd like to use consistent representation for variables in different
+ * coordinates:
+ * - buffer coordinate: prefix fb
+ * - pixel coordinate: prefix p
+ * - logical window coordinate: prefix w
+ *
+ * For scales:
+ * - global scale factor: prefix gs
+ * - zooming scale: prefix scale/s
+ *
+ * Example: fbw, pw, ww for width in different coordinates
+ *
+ * III. Equation
+ *
+ * - fbw * gs * scale_x = pw
+ * - pw = gs * ww
+ *
+ * Consequently we have
+ *
+ * - fbw * scale_x = ww
+ *
+ * Example: assuming we are running QEMU on a 3840x2160 screen and have set
+ * global scaling factor to 2, if the guest buffer size is 1920x1080 and the
+ * zooming scale is 0.5, then we have:
+ * - fbw = 1920, fbh = 1080
+ * - pw  = 1920, ph  = 1080
+ * - ww  = 960,  wh  = 540
+ * A bonus of this configuration is that we can achieve pixel to pixel
+ * presentation of the guest content.
+ */
+
 static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 {
     VirtualConsole *vc = opaque;
-- 
2.49.0



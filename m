Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C760A2619
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZZcQdKxe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsKr-000186-FB; Fri, 13 Nov 2026 09:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIX-0007jP-Ga
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIW-000686-1I
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ih4cMAcG11/2tQXd/z+ioOfmSIjfeb+AqPRuL222ms4=;
 b=ZZcQdKxemg/t5m/WVqppE3ZNLB2opNm9eSzd6pYTZbyRvYlEZfestF8/pVLi1a3kc/iONw
 RfaVd+qAq1UzLTJlDnSA/LMwZzQkPe8Yy+i3q5m228HOoJDmLE6lcELw81YHt9vJYLr0I8
 JvFJDPYZTkV1NfkLiFhaTncsZGWf4Pg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-z-GwFKydOmigp09v9KYu1w-1; Fri,
 13 Nov 2026 09:30:33 -0500
X-MC-Unique: z-GwFKydOmigp09v9KYu1w-1
X-Mimecast-MFC-AGG-ID: z-GwFKydOmigp09v9KYu1w_1794580231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6328A1955E9E; Fri, 13 Nov 2026 14:30:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90AD51956086; Fri, 13 Nov 2026 14:30:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 18:29:58 +0400
Subject: [PATCH v3 6/8] hw/display/vhost-user-gpu: resize the console on
 dmabuf scanout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v3-6-98e4fa3e77eb@redhat.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
In-Reply-To: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=88Z50NcHdijZJqAT3TzGJIGsZdaDRp1gFBMo/jbYhEc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9x7m0Tfo/v4ea3d5wil3I03XHNIRJjicTuJz4
 o9Bhg9lFQ6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavce5gAKCRDa6OEJdZac
 5Z+DD/9FYVE04ZOWp591BjN9ML8bxyk6Kp4O1S8r/kW5c8KNpxyNUhgSa4GKFWcsQvtkPuY0W0j
 zO/xVj/Hexbdwbg4N5wxraSh23hnTvF+NCqu1ELCKIVHir31Htud5cObZgbPzPasmWxDp0lJn46
 HfiDQ47CHW624t2nrrmK22mYPt1DIdkfgmeQn2u2v5FdX8B2soYFhl9bTv59vW2jbj2EUyvYc49
 WIiWNa75cAU1Fvv092wBmOC9t6dPWT+74hQOW0oCpodkhc7TbQH0QqWT+IXcZ6wXPRKa5BvWC4p
 VxJ+xYAjDJelrAkV340Th8Qx4sJY2CBfSEREZ5uC4gqo4PHCwatpNBaTyvlPNb9CYiXbkZl1n+2
 ICISasd28RlsPoA/Nz7x/KA8SJpgu1ZPEQE7WPcoTdZfJc8P2d6BLaR0e3FMVh+qCeXIVSrwqqi
 dn20SK/SSXun2j3oE/i2sh3Rq+pV445Jab1s9ZW3TbQ5LOmDLGTY4KRkTtC0Ap/cn2ESyplZwa7
 d/RDZbxXMKT/sWcTm3MGQ3giCO2ttCWaSNaBEQxY932FWPbmljUVoN7aVXQ5A8fUj/40BEupud3
 FOkDRe66hqLbdCcXUgoR4kg/XRGLcFiPC8AOOqRTK6GSmxlWpDLWmXk5Xbuo6mSCUrwXrqk9/FH
 0Q9JEhc05/rPdoQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The frontend installs the backend dmabuf with
qemu_console_gl_scanout_dmabuf() and never resizes the console, unlike
the in-process virgl/udmabuf paths. The console surface, and with it the
UI window and the EDID preferred mode reported to the guest, stay at the
initial size, so the guest display is scaled.

Resize the console to the scanout first, and release the previous dmabuf
only after the new one is installed, as virtio_gpu_update_dmabuf() does.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 5874f3a50b28..ac5bf7f8a428 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -279,7 +279,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         uint32_t offset = 0;
         uint32_t stride = m->fd_stride;
         uint64_t modifier = DRM_FORMAT_MOD_INVALID;
-        QemuDmaBuf *dmabuf;
+        QemuDmaBuf *old, *dmabuf;
 
         if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
             error_report("invalid scanout: %d", m->scanout_id);
@@ -291,16 +291,14 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
         g->parent_obj.enable = 1;
         con = g->parent_obj.scanout[m->scanout_id].con;
-        dmabuf = g->dmabuf[m->scanout_id];
-
-        if (dmabuf) {
-            qemu_console_gl_release_dmabuf(con, dmabuf);
-            g_clear_pointer(&dmabuf, qemu_dmabuf_free);
-        }
+        old = g->dmabuf[m->scanout_id];
 
         if (fd == -1) {
+            if (old) {
+                qemu_console_gl_release_dmabuf(con, old);
+                g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
+            }
             qemu_console_gl_scanout_disable(con);
-            g->dmabuf[m->scanout_id] = NULL;
             break;
         }
 
@@ -316,8 +314,14 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
                                  &fd, 1, false, m->fd_flags &
                                  VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
 
+        qemu_console_resize(con, m->width, m->height);
         qemu_console_gl_scanout_dmabuf(con, dmabuf);
         g->dmabuf[m->scanout_id] = dmabuf;
+
+        if (old) {
+            qemu_console_gl_release_dmabuf(con, old);
+            qemu_dmabuf_free(old);
+        }
         break;
     }
     case VHOST_USER_GPU_DMABUF_UPDATE: {

-- 
2.56.0.116.g6de20f6092dc



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58B606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AMWFWv82
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRokS-0002Xs-Om; Fri, 13 Nov 2026 05:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokQ-0002XM-Fc
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokO-0001BA-Oy
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hJHVPX4Z50d1+1WXrfW7G3PiQ0uGdiOhPghZqI7BLg=;
 b=AMWFWv82zvVP+MnPf6Vvz9+onHXnBiR3178LmP0adSMyrl9S+Lrx9M1lPt7OGVl6tG/VW8
 6bmIfBIxHG0CPFxXWrs3FxFQypUa+GxNGWQugWvTeJqVoZSP/I0bmeyai8Yn3OrEszE9Xd
 yNqjQ+Qs+CEXu9jenoVQowxRLNbyCg4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-nePev0olMlea2R5_ViknVA-1; Fri,
 13 Nov 2026 05:43:05 -0500
X-MC-Unique: nePev0olMlea2R5_ViknVA-1
X-Mimecast-MFC-AGG-ID: nePev0olMlea2R5_ViknVA_1794566584
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E9EF18002FA; Fri, 13 Nov 2026 10:43:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B101B1955F2D; Fri, 13 Nov 2026 10:43:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 14:42:15 +0400
Subject: [PATCH v2 3/8] hw/display/vhost-user-gpu: reset the console
 scanout on device reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v2-3-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xJedIrxMbpG+kWmFSdZzdD7IA4dWVdraRUDf0VqaGTQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umowlFDBOZ26uIpGneFg+0jGmatMmEc4AB2r
 FPy3yC4y36JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbpqAAKCRDa6OEJdZac
 5QDvD/4o5JqbFVbZQOTemMOq8d/pEiKYJLY0COpuhw/CSY71iPiO8QcmWIBQUfwGcPeQTdZ8DmQ
 T8B6BFrbvmAXSDADbch5udrtKB+wWPRBOGqk8PJCPmXZElGCFFi84IjDsLXOUpxKst0ZO4Ewkju
 L9ay2epNp9IR7iGiU3CEO7ZhqzHHdx4kAIgwqCDMt7hEDi/81UrYoCXWlZ5hnMcj+sl1PwKuZy+
 vy8LBgIFnv1gRoYYEpkj1rOCdhLvQT0pW1uVDQtI2C5fH/hbEoBwIG1sDZlgHxR0qyV74air40X
 +upAgRd5vYcSbpDG/XGiVuJa88ib41sSPmA9a+tnAtI1AKxT4GYFzxfVrriuiGgdUDg6TrhjHwM
 X8XO+x73tIchAO31OPliymGj1UEJ3ctKY4Lmy2daPHkyEDUKR7eRMecAdiccYHfgdov5ULOjHjA
 W1/K2A8LHsmAlQLVwkC0fBBgPm60nYyQr/StYuCLIdJZClK4DnT96SHijR/7poKvRTufCv7oF/p
 32Tpms/URyvinCql9D6m7lzI1cKEqqVYWsoroDav9bXPrjtr4awP7+FJHEwi5oDj0TNLrhV/0VT
 73ichSWjbmjpuEbo5dOyeLLoNap9VCIMk8JvMuRn31W/lB2fjIaddvGoW9iEOLnPd92ehAz5q2m
 /8QKvAAQkrypXeA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vhost_user_gpu_reset() clears VirtIOGPUBase::enable, which makes the
virtio-vga wrapper fall back to the legacy VGA display. The console is
left in a GL scanout though, so qemu_console_surface() returns NULL and
vga_update_display() dereferences it when the display refreshes: the
host crashes on guest reboot or driver reload with a GL display.

Release the frontend dmabufs, disable the GL scanout and install a
placeholder surface for each output, as virtio_gpu_reset() does for the
non vhost-user device.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4846
Reported-by: Dmitry R <rdmitry0911@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index c09aca041135..d3b720d08a73 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -638,6 +638,20 @@ static void
 vhost_user_gpu_reset(VirtIODevice *vdev)
 {
     VhostUserGPU *g = VHOST_USER_GPU(vdev);
+    int i;
+
+    /* release the scanouts before virtio_gpu_base_reset() drops ds */
+    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[i];
+
+        /* the guest may have left a GL scanout behind */
+        if (g->dmabuf[i]) {
+            qemu_console_gl_release_dmabuf(scanout->con, g->dmabuf[i]);
+            g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
+        }
+        qemu_console_gl_scanout_disable(scanout->con);
+        qemu_console_set_surface(scanout->con, NULL);
+    }
 
     virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 

-- 
2.56.0.116.g6de20f6092dc



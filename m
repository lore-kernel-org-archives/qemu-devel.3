Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A994606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ha8oia1P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsIt-0007lm-Ka; Fri, 13 Nov 2026 09:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIM-0007i1-Pv
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIJ-00065S-5i
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8OOOC8sCjbVI38YX8yRSgMRopoiAHxL7W46Qs+Z1ocQ=;
 b=ha8oia1P2CRVJW0ZyQsKwq646Jut3oKutjitGd8OU/YeTPKd0oXOzBWzt61GgggTspjwHB
 c1fLNbq8INelaG3TFRJ3FQWTkxCPXZQq7mY7HnzWifYyyHBDMHD1YSO3EnnilQcb3GGwfS
 1bRpKCbOjWMAtLpqv7avpdWRV5Hili8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-8x3gJfOnO2O487JxbbUzUg-1; Fri,
 13 Nov 2026 09:30:14 -0500
X-MC-Unique: 8x3gJfOnO2O487JxbbUzUg-1
X-Mimecast-MFC-AGG-ID: 8x3gJfOnO2O487JxbbUzUg_1794580213
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94CDF1955F30; Fri, 13 Nov 2026 14:30:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60A8118004FC; Fri, 13 Nov 2026 14:30:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 18:29:55 +0400
Subject: [PATCH v3 3/8] hw/display/vhost-user-gpu: reset the console
 scanout on device reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v3-3-98e4fa3e77eb@redhat.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
In-Reply-To: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VOGAyjt1Np11u0S2LqKPR58Mpv1CcNCtdfIzb1NV5uw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9x7mDD4z6/bB3G8x9zV68MVqjhf35n2zEhc8d
 A4Aj9/cV82JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavce5gAKCRDa6OEJdZac
 5R8TD/9MJfwOvIsOYACwUf4Sh22pOGWYKJDFaqvGk/ADxzTCfBxPn/YFg/rchxhfaG1hA64W9DZ
 ZIB40e5+JpWIZSJxNstv7VRGwLbx9oKndgcA36h3C0jJi0aCltqplzJxRrtMc7Q8IJpNZIwYwqV
 Wsl1hvxyvEQuc28yimUKjusJT7nNmlGLzRukjoy2QqfXItl7MtuYo3txF0Cdq0UdrV/lbQnlajE
 E0OnDyC9MBBz2cH481tbiB6B+dKXF6gM6tRLU/uY1Agwn+/v/qoKKPiF/MZTbYlHvHZs0Z5AAch
 qVRnV7FVIFwttuQ/JTOd+7cUbA1DppniQwRau6VNgh3cEHTILQ2t14tBiI0o0iQDH8G8bXqAErR
 xV+0RCyv8ofBPXcISfJM0zdy1naLJF0A/CjHY9ZDWWnm/nP21+YvDebqfPp3f37crljeHd6LrpD
 hpKeJIWZDd28PH+3y4wbJR0K8F5qwZtxByET30ZzxxOAB8eHF9TIugXtK5q8yf47dfSiQDdtAJ7
 xcOPcXBYO31JlUFsi11s33tGBmRu2U9fldmOB5dztAfyNm7wKCD/K/yjVg0JNj3cwzex7ecbCEy
 pme3+KobwQah7ya6tHyrc2KwzaZC7fbrTAsVqLamgfMImCSNVPtQOveM06vTEwhBDBBUO8Oqsj3
 7+/+8M8RaG4Ae4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
Reported-by: Dmitry R <rdmitry@taktcycles.com>
Tested-by: Dmitry R <rdmitry@taktcycles.com>
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E83CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTw-0001IM-4s; Tue, 13 Oct 2026 09:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTu-0001Hy-C2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTs-0004fJ-Ab
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7hpxBmEGdjwMtgO2ZqAYuNxUgaMSLKbQ+63u6v0zJU=;
 b=eOReXdEm0r3wy/0qhELBXjhk//x2WW7b3666xT6j7s74IhKNpKaYDlaiLYFC7creFXWvH7
 cyEizwksf093EWH6W28ZaZ0O47jRQ8btYaWQuCdl+7hcG+iOLmEhp2qOupfdltpLVn4oJs
 9uMOor4jB0wmAy+ysGwwIcBVmkNpyuk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-5p9b4jJ2P665wKYyIu5zWw-1; Tue,
 13 Oct 2026 13:23:36 +0000
X-MC-Unique: 5p9b4jJ2P665wKYyIu5zWw-1
X-Mimecast-MFC-AGG-ID: 5p9b4jJ2P665wKYyIu5zWw_1791897813
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C79A193E898; Tue, 13 Oct 2026 13:23:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86CB718002B7; Tue, 13 Oct 2026 13:23:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:00 +0400
Subject: [GIT PULL 03/40] chardev: add CHR_EVENT_RESIZE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-3-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Collin L. Walling" <walling@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>, Corey Minyard <minyard@acm.org>, 
 Fam Zheng <fam@euphon.net>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Milan Zamazal <mzamazal@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=9181;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MeSQo7Ko5VdSQaya53Ase7QpYgT9NLKxYZjvW0yjIyw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCEUOgCXOijtZlnJA4REFDr0rNp/e4vZeBN
 O0GLRBNP0OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5R96D/9X8ccPd73Hn4lYljyjeNkktO7+11hD9hQ4nx211/yYvbzBJcQnbV6i1xJbgLBa+wPosr2
 9ZxLZDNt28jKpgjn/ETIdaC2MLHX402scvVWTBpboEljYDvCvNqwxU+iTFJsM4L7FJDBp82R09t
 qAHEP7TpRgfvxJiaDynME7P785bE5kYoAjfIAcIlWdzwX10x4Ww6FQediVhxS2nZUqO7LD0Q7F3
 xOCG2QXDrtNQkqqe77CpS0gc8NfOZD/pF0LTedJwBx38V9J0O9IkjXmvsFTlAoA1nG43899bOS5
 eIC+nmGBtn6HaCsL/fWkfUn5eaKLb71Btma+sow1OSkpTZhz20wkbGX5v0bNcxl1X4mSE9qCEnV
 Ruj58ElRESm5R6FxwQNwm7vIUuybdyU0MNaIN75AGB3Z4dmWEC+s6Qfs2mqxcfZOvbC4jsiTuWu
 b6LGz7RAG3c89O9FS9AWYyPxZM9SnofYjUbUCM+WYGE1VI1moD7cWBIUsIRZBBaKRbXUX06Q2GN
 ng5o8NpTOq8R+xnItfusxttev7JHtf1XUe/1y9tJkjZnd0mHpQZRdUTH/Achvq+cHs5qFKPlsXX
 L0u4we23m5a2oB7g4B6eOmTprf5LFblGoyO7F1b6U8jgNVhKkf2qH/I2fjBbadQfcUBIfwV/nrO
 r0Od1iHBxJuWWVw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Szymon Lukasz <noh4hss@gmail.com>

Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
trigger if it detects the size of the connected terminal changed.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: add note that only the focused frontend gets the event]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-2-2c3b10d829b3@gmail.com>
---
 backends/cryptodev-vhost-user.c | 1 +
 chardev/char.c                  | 1 +
 hw/block/vhost-user-blk.c       | 1 +
 hw/char/terminal3270.c          | 1 +
 hw/char/virtio-console.c        | 1 +
 hw/display/vhost-user-media.c   | 1 +
 hw/ipmi/ipmi_bmc_extern.c       | 1 +
 hw/scsi/vhost-user-scsi.c       | 1 +
 hw/usb/ccid-card-passthru.c     | 1 +
 hw/usb/dev-serial.c             | 1 +
 hw/usb/redirect.c               | 1 +
 hw/virtio/vhost-user-base.c     | 1 +
 hw/virtio/vhost-user-scmi.c     | 1 +
 include/chardev/char.h          | 6 ++++++
 monitor/hmp.c                   | 1 +
 monitor/qmp.c                   | 1 +
 net/passt.c                     | 1 +
 net/vhost-user.c                | 1 +
 18 files changed, 23 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 3334e280a270..b0e325e47e0b 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -173,6 +173,7 @@ static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/chardev/char.c b/chardev/char.c
index 9da0911e503c..40d2180ce74b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -75,6 +75,7 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 3dade143c95c..1352a0cf5785 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -441,6 +441,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 989b6f6ee1e0..acd754bcfac3 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -169,6 +169,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 4737b9a56eba..36ad2ddc3f62 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -165,6 +165,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
index 851af8ddc2d4..3d76aaba5809 100644
--- a/hw/display/vhost-user-media.c
+++ b/hw/display/vhost-user-media.c
@@ -241,6 +241,7 @@ static void vu_media_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index fa08ed6c2174..bd7c61b2d2f5 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -436,6 +436,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5070178dc28b..7687f2804f88 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -225,6 +225,7 @@ static void vhost_user_scsi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 5ab7855272af..3f4052ec82ee 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -323,6 +323,7 @@ static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
     case CHR_EVENT_CLOSED:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b238cb793756..98d2abbd5639 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -576,6 +576,7 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
         break;
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index dfd9e8bb50c3..a666b1e8d7d0 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1390,6 +1390,7 @@ static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 1a377016e7fc..3cb59fc1739f 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -277,6 +277,7 @@ static void vub_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index c4692bd6aa62..29d37716b3c7 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -215,6 +215,7 @@ static void vu_scmi_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 6394ec2ffeeb..ee9f24038bd0 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -22,6 +22,12 @@ typedef enum {
     CHR_EVENT_OPENED, /* new connection established */
     CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
     CHR_EVENT_MUX_OUT, /* mux-focus will move on */
+    CHR_EVENT_RESIZE, /*
+                       * the size of the terminal connected to
+                       * the chardev has changed.  NOTE: this event is only
+                       * sent to the focused frontend, so you should also
+                       * update the size on receiving CHR_EVENT_MUX_IN.
+                       */
     CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
                       * is only bound to the read port of the chardev.
                       * Normally the read port and write port of a
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937df..7b80d8480055 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1587,6 +1587,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
         break;
 
     case CHR_EVENT_BREAK:
+    case CHR_EVENT_RESIZE:
         /* Ignored */
         break;
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec03157750c..eb44012643f6 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -663,6 +663,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/passt.c b/net/passt.c
index 45440c399bac..e65198960ec9 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -428,6 +428,7 @@ static void passt_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2d0fc49b4d83..b849de92da64 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -363,6 +363,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }

-- 
2.56.0.116.g6de20f6092dc



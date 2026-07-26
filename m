Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27568C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pb-0007TB-CZ; Sun, 26 Jul 2026 17:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PZ-0007Sk-Kv
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PX-0004G1-Qh
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xsRd3tsra0/ORuQXm3tuY9CzXgdUoqap7ZsJ4Ns2NE=;
 b=aHzngRQZ1YRZfQmeJiS7WXtXprxY6VI1Qtsx+RYxGMPqs8o+Tskws5Buw+Z9HPt8v7NDiM
 BtIHago4zFWEQG8al9zkxqJjV53KAsi8O4MlfdvoCBqpbfSynJwpmjU8vkrBQlGc+D5JE4
 eXmskJu6o08/AsH+x0rNf9VoD03uKUM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-M-f1jCEoP-KO-0neUCXJ3A-1; Sun, 26 Jul 2026 17:29:25 -0400
X-MC-Unique: M-f1jCEoP-KO-0neUCXJ3A-1
X-Mimecast-MFC-AGG-ID: M-f1jCEoP-KO-0neUCXJ3A_1785101364
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so18600625e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101364; x=1785706164; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0xsRd3tsra0/ORuQXm3tuY9CzXgdUoqap7ZsJ4Ns2NE=;
 b=Tzt9PItDqOHBTH8BwHwDPS9Hsw8/unxdQ0zmZGyqrDN2U7CWmlh0ecafkuKk+2CXY7
 F+WJfMcgq5krKclu+lXRoC1UMseIjVgg8zIAvQvBitvP4SoTIytICWduKn7C6u/ghKoR
 GvUjGswvBcYy2rN9afaVwQhWYt7PmyhYKYqt/mIAlpuDlBH+zcno2NqMwzfc9Y1scIZY
 eNQ6uk3+y+PkvMz15bkF8vFJ6/EpAa48xeqyzesyFCRuGeWy14iFnZ4QYATnFIBrWLSa
 mwMtmKuMoMUYpoHJiyjVbxt269Rt2mdF6nwy0qT8sQNvcWTmwRKCRjF7kx8yL4jLY6aG
 hDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101364; x=1785706164;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0xsRd3tsra0/ORuQXm3tuY9CzXgdUoqap7ZsJ4Ns2NE=;
 b=kywTbFm9IAZOV7AZMUr/WX5EWhJ/5OGkXKoX1Ia0QGN78b6kf5T9IyIH2eiMUtotxO
 s1ojXITgv4sNCTxHhSPl094Q2BiUHbAXGp9jP1zYLbopdGuNiZJarx+rGZK4I9O6BANj
 JWGyfsECtC2WtdbRiSXPTKBTr5OMFEzx0q0xsNF9N8wfStym+4CCFWfNKGRJ4xh+QX54
 UNpOATvsgLq28naarejEJis5R3zyA2kVRG4cUWJhFMTfYbL2iZyMAg9ttKl7d46AW0nb
 TZT9LZU5ClmtOvY6Q4FgGsBW2LrJpA/wq7lrPV6+aiPtQPQTTdNCUJgJessX30ZqkNxn
 XFSA==
X-Gm-Message-State: AOJu0Ywtgk1dNludbPCbie8GXpbXw2LNCdwvRFLQ1afyjKgFSN7EcQ9i
 BXkBXbuwRd9pOKFuNbo773SvBd3d6pxym/vx/OvV44mLeUkucBujtmR9r5wuHZtkcJmRS8iogS3
 +3IFmpNiMu1hv99YbZpupyhx/ZcFirsVtdouhx6GUO9IAaY9pqL8CpRXALVrFx0DDSjytotTcpA
 cG9TiGrzAQ2M4ry2zwHm9BJNZT2sPILPNlJw==
X-Gm-Gg: AR+sD12HFHFjd6lnP7QNI7I5gUZTNS8IQ5Qc3o6Ayrpi7DwLdIrIFhWOTwHxF5eDq/E
 JxTxpLikWEmV79t8OmxxOF4ZYLkqVj3c9dkEnRADASReKG3oTLSK0zXvZOu2THfrDszw3gCJK7S
 947PusRzfr+MdVXaNALuJheKrdnnG1qGZigdzjOfpqoHUdfUDDu3zr9jIk0AC9PXsCw8OUhlll6
 G6jFOhQlstSODkCY6nS0BXuYBUWusERKyCqV6zvUIodiyu91tdmo0AI4706lwZ5fTC4IkvHg4M8
 Yb7Uc17NXPoob+yyNkR22h/uZHedOjzW2yfx0XQEc2fa3D//Ui+qx779fUr2NKzRY+Bb/ouqt1/
 uFxkRFDdJUJR8opGibifjLA==
X-Received: by 2002:a05:600c:1f92:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-496b56f97e7mr86278685e9.15.1785101364312; 
 Sun, 26 Jul 2026 14:29:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1f92:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-496b56f97e7mr86278555e9.15.1785101363790; 
 Sun, 26 Jul 2026 14:29:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b499c473sm166629185e9.11.2026.07.26.14.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:23 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <6e567872c1c699b82e63eeaf765f556d2a8d40b8.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio-mmio reports VIRTQUEUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every
queue, regardless of the size the device passes to virtio_add_queue().

This works by accident because QEMU mostly does not care about the ring
size - the guest is the one allocating memory here.  But this changes
with in-order vqs where qemu is the one allocating resources.
Now, specifying a larger vq than allocated causes an OOB memory access.

To fix:
- for new machine types, report the actual max queue size to guest
- for old machine types, use a compat property to allocate 1k sized
  queues

Fixes: 525d82e323 ("virtio: fix queue size validation against allocated maximum")
Fixes: CVE-2026-50626
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-bus.h  |  1 +
 include/hw/virtio/virtio-mmio.h |  1 +
 hw/core/machine.c               |  1 +
 hw/virtio/virtio-mmio.c         |  7 +++----
 hw/virtio/virtio.c              | 11 +++++++++++
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 1a2d396156..f80fd71424 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -30,6 +30,7 @@
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_BUS "virtio-bus"
+#define VIRTIO_QUEUE_SIZE_OVERRIDE "x-override-queue-size"
 typedef struct VirtioBusClass VirtioBusClass;
 typedef struct VirtioBusState VirtioBusState;
 DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index 1644d09810..0a9069868c 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -69,6 +69,7 @@ struct VirtIOMMIOProxy {
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
+    uint16_t override_queue_size;
 };
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d..73b4d82b4a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 #include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
+    { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 58c6d46aab..55ceaeef5f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -172,10 +172,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
                 >> (32 * proxy->host_features_sel);
         }
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
-        if (!virtio_queue_get_num(vdev, vdev->queue_sel)) {
-            return 0;
-        }
-        return VIRTQUEUE_MAX_SIZE;
+        return virtio_queue_get_max_num(vdev, vdev->queue_sel);
     case VIRTIO_MMIO_QUEUE_PFN:
         if (!proxy->legacy) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -738,6 +735,8 @@ static const Property virtio_mmio_properties[] = {
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT16(VIRTIO_QUEUE_SIZE_OVERRIDE, VirtIOMMIOProxy,
+                       override_queue_size, 0),
 };
 
 static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2d33622daf..cdc8ba76f1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2568,6 +2568,17 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
         abort();
 
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    if (qbus && qbus->parent &&
+        object_property_find(OBJECT(qbus->parent), VIRTIO_QUEUE_SIZE_OVERRIDE)) {
+        int override = object_property_get_int(OBJECT(qbus->parent),
+                                               VIRTIO_QUEUE_SIZE_OVERRIDE,
+                                               &error_abort);
+        if (override) {
+            queue_size = override;
+        }
+    }
+
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].vring.num_default = queue_size;
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
-- 
MST



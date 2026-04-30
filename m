Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496D9CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6e-00051V-1F; Thu, 30 Apr 2026 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6b-0004xw-MF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6Z-0004UR-LQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwI+DAdyJ/kfQ/N20b98sd9/hfTGkbU6Agp12ufe4Oo=;
 b=AnfXA3wIcNEwowo4xB2FHT8Anmp5hrOmdY9W4jwgXEOXuluMhWE48m8s9awIj154YoOqYd
 gSa+hxGbRGQYgcOWzFHvo1FvtMAn9anP8DS8Sb8BnPaFH7nnBFq6XlVuAtj37N83E8pA0+
 tSsCsosXK2xpNkmQa7PrHJnY7o1UFIw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-FqNJl0rsOPuFsZ4xemR_hA-1; Thu, 30 Apr 2026 13:23:13 -0400
X-MC-Unique: FqNJl0rsOPuFsZ4xemR_hA-1
X-Mimecast-MFC-AGG-ID: FqNJl0rsOPuFsZ4xemR_hA_1777569793
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so30210581cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569792; x=1778174592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwI+DAdyJ/kfQ/N20b98sd9/hfTGkbU6Agp12ufe4Oo=;
 b=b7zDXCA/BSqffM+6WLZtrd79nIsna6faJFrWU4dA/QK8Q2p8JLF0vDO7nILCMuQXCZ
 EauTDpPX+p+dwgG/kZwyeJfCW6CZfSAk3y5UjV8V0FahhtF8TK3/Iluahliwy9t+I5+U
 5gD+ik6lG46Ef5sqmEgReuX6hoYjzgWXFP/bKtSfNeIC5PCbupkg6bOgAGrly2gGmhiD
 y3PrJYE/PC1fqb8Rx6KvWnVbYUruI/cgW9bQ9J5EpXdXCXeytZ0bNL6U9HEF6/QvkEdH
 P4ZrA3n8XRPnjBC7nXFuNbo1x1daFyNiGGyIff+gbqOIoKUkYl2/e6JlTm9Vn18uUFvg
 8tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569792; x=1778174592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BwI+DAdyJ/kfQ/N20b98sd9/hfTGkbU6Agp12ufe4Oo=;
 b=A6K5Zuy0G71JphNwZRtdvk6mYNdpak5A8KKaStWj8fOfO+7qhD+ZfUvBmyNiR4zCHx
 58fFm13cJS9diikBbqGTQXHy+mcdMx7h53H8upX5an+oGOOTnUAnkChP+kBgICBRjYaC
 G/JJjInWzft26KX80WnOb6vT12jUrmXU2L5Kww4I8ebsGQl3y/7e80XQpvQRJbK2VVpT
 MDUImQcsrcZgVq+U6yvIrmtZIL6kK09HWVxdwHOWOt8Wyw6siVOfHegyQSTX08RAzuh6
 ZuCScaisuqmhO2STlAcXL/uXH6ezq57zgSklQcXPW+vUmyPCe18Wegk0cyhAxN3JGBFI
 Iasg==
X-Gm-Message-State: AOJu0YzqjE6TzINIIBGTSEVDKN3Fva6XH5mktHV5c2YIaKiQS3Z/bhF0
 AYwP37Ev+S1kioYg4XovEamOx+4FmkPYd/A6aruVwU061HOI8xDmoYGbi6iXQwy2I7o8SFGcFm4
 /FTN3r6XEEA1SdGIRan3KwosWzcNP77U7Rj2g4fnGteTLgJZ7Ka3kPb3ZSF0nGgoVvo82Rqm3G1
 yT2y4xA6u3DGvXbJGAKtSENpHTv/5vPVvQdB/ATA2P
X-Gm-Gg: AeBDies5htAl0xBpg47XYMwO0GdoFMjO9B32EouaoGKHLfLxdmf1wU561xkiFpXDiQd
 NO9RyMF4PI1MuWTVWA/mCdSZ3Go3EiiXgx8L1RIQsMxf28QL/DLANvbBhxWCSMExzSmeQMBmD3E
 Pxc1s3S2razBLOyWyDx1oG9ayvUMDJYszZ+WIdl5gZ/PiOfV0t8r2nNasmI6/k5jG3GNLDhvxO4
 GWGoC2inZwRhA73HxMhcZ4P3ZOFaKAbL7VSfl4OvcY3tYRcOgSbfucT++tyBXbTclmPPUfN7Jtc
 OaSSLxZmeUDsoOpEsIRsYZN4iPzcXEUXYPG4GFL1PR0falDwo9QkgTKCPIbRsXV2xQWGFn/SjTO
 ZfMjyvxyVZ4aTIHw3NxXEfZp++aU5dZJYIm7Fb9z6ZYFp2VACCvdxRea3r6ZxGefBTR424wewOe
 56Zd/AWAGxqjABHXex7BzakiC4a7E/JPk9gdQ=
X-Received: by 2002:a05:622a:2594:b0:50d:2a76:43c5 with SMTP id
 d75a77b69052e-5102aaf886cmr55753081cf.2.1777569792321; 
 Thu, 30 Apr 2026 10:23:12 -0700 (PDT)
X-Received: by 2002:a05:622a:2594:b0:50d:2a76:43c5 with SMTP id
 d75a77b69052e-5102aaf886cmr55751941cf.2.1777569791438; 
 Thu, 30 Apr 2026 10:23:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d1c6fc4sm586791cf.4.2026.04.30.10.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Ratti <alessandro@0x65c.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 20/58] hw/qdev: Consolidate qdev_get_printable_name() into
 qdev_get_human_name()
Date: Thu, 30 Apr 2026 19:21:26 +0200
Message-ID: <20260430172204.1006673-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alessandro Ratti <alessandro@0x65c.net>

Rename qdev_get_printable_name() to qdev_get_human_name(), remove
the old qdev_get_human_name() implementation, and switch the three
qdev_get_printable_name() callers in hw/virtio/virtio.c.

qdev_get_printable_name() subsumes qdev_get_human_name(): both
return the device ID when set and fall back to the canonical QOM
path, but qdev_get_printable_name() also tries the bus-specific
path first, providing more informative output.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20260321100405.1525059-4-alessandro@0x65c.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/qdev.h | 26 +++++---------------------
 hw/core/qdev.c         | 10 +---------
 hw/virtio/virtio.c     |  6 +++---
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 226bd662901..e1476223411 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1022,13 +1022,12 @@ Object *machine_get_container(const char *name);
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
  *
- * .. note::
- *    This function is intended for user friendly error messages.
+ * Returns: A newly allocated string suitable for user-facing error
+ * messages.
  *
- * Returns: A newly allocated string containing the device id if not null,
- * else the object canonical path.
- *
- * Use g_free() to free it.
+ * Return the device's ID if it has one.  Else, return the path of a
+ * device on its bus if it has one.  Else return its canonical QOM
+ * path.
  */
 char *qdev_get_human_name(DeviceState *dev);
 
@@ -1058,21 +1057,6 @@ extern bool qdev_hot_removed;
  */
 char *qdev_get_dev_path(DeviceState *dev);
 
-/**
- * qdev_get_printable_name: Return human readable name for device
- * @dev: Device to get name of
- *
- * Returns: A newly allocated string containing some human
- * readable name for the device, suitable for printing in
- * user-facing error messages. The function will never return NULL,
- * so the name can be used without further checking or fallbacks.
- *
- * Return the device's ID if it has one.  Else, return the path of a
- * device on its bus if it has one.  Else return its canonical QOM
- * path.
- */
-const char *qdev_get_printable_name(DeviceState *dev);
-
 void qbus_set_hotplug_handler(BusState *bus, Object *handler);
 void qbus_set_bus_hotplug_handler(BusState *bus);
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0efc83f6740..e2aab3d1fc6 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -412,7 +412,7 @@ char *qdev_get_dev_path(DeviceState *dev)
     return NULL;
 }
 
-const char *qdev_get_printable_name(DeviceState *dev)
+char *qdev_get_human_name(DeviceState *dev)
 {
     if (dev->id) {
         return g_strdup(dev->id);
@@ -858,14 +858,6 @@ Object *machine_get_container(const char *name)
     return container;
 }
 
-char *qdev_get_human_name(DeviceState *dev)
-{
-    g_assert(dev != NULL);
-
-    return dev->id ?
-           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
-}
-
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8fcf6cfd0b4..63e2faee994 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -281,7 +281,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
-        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+        g_autofree char *devname = qdev_get_human_name(DEVICE(vdev));
 
         virtio_error(vdev,
                 "Failed to map descriptor ring for device %s: "
@@ -294,7 +294,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+        g_autofree char *devname = qdev_get_human_name(DEVICE(vdev));
 
         virtio_error(vdev,
                 "Failed to map used ring for device %s: "
@@ -307,7 +307,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
-        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+        g_autofree char *devname = qdev_get_human_name(DEVICE(vdev));
 
         virtio_error(vdev,
                 "Failed to map avalaible ring for device %s: "
-- 
2.54.0



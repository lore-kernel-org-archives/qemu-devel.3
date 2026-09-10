Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EF5C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4m4j-00069B-0b; Thu, 10 Sep 2026 17:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lM2-00036C-JD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLk-0000Rr-HJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CnyxDCKVe7u1Oo/VtDfYPCe5Gbe0/d1270GUGGe0eo=;
 b=QtwlouJ4xtFc7kdnB7w7mXfLZeR/Dz9xPvUqphBEDg+wR4Z/CrjEmhj66Vqg+c2QA4V2IW
 IjR02wdAOqbEazOVHLKZl8sLJWk/5kBJHfDvHRdWA6DRv8K7g0pE/Wf6FeML80u4kNiLYV
 E/xY7rH1InHQ6gnq0RpBE4TwmKtbGe8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-9oL67tGePzG99xhpBztNGA-1; Thu, 10 Sep 2026 16:15:22 -0400
X-MC-Unique: 9oL67tGePzG99xhpBztNGA-1
X-Mimecast-MFC-AGG-ID: 9oL67tGePzG99xhpBztNGA_1789071321
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so1742305e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071321; x=1789676121; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4CnyxDCKVe7u1Oo/VtDfYPCe5Gbe0/d1270GUGGe0eo=;
 b=HXq0a4IS+SNkfTZjMmEhxLghb5yXMcEPbI7ZJ5VhWkzgE+/k1e59d51kS9l/+ZtBTt
 P2VIit81xpziKci8hu6YYPRkQ7esAqHrmJmX+qFm5xCvzyGLSyA0cSCJiqeCJPIyZQlN
 2Y36ks44Gho+5EZ4SWCquiSkz66qg88ybipt+oGyyZq71+jSDQP2BedfrqaoGYhZWiY3
 NFtjD4nfVQ89+ESzbtO10WUO8qRouuAWlJ2kz1VZu0GebqFg9gp4mdNHeEWuDpQrAhjC
 RbNsrgYOG3IMxZltkm6Jk64d9yjjSGHGQP8wtpGwsaLPTFtgfUt2RSB7C4xRJ97oq0d9
 jY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071321; x=1789676121;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4CnyxDCKVe7u1Oo/VtDfYPCe5Gbe0/d1270GUGGe0eo=;
 b=qVJ2tOtqPFOW/69HH2mvhmUPJRyTL2PFy7xL3OGeMQ4sqkkgd8xC5WYwPShIqrRfxA
 gSBV636qreha8TPNyrXgVXrhV9SaZXg7yz0k8PCduWuM+nrSlWE4Bc9FOjb/ONVukP3O
 PSH5eb27fA2m89H97hlUd/+56yFteFh4EFZTYZiVTPTB3VzrF96o33V0qnO3KvPCO35i
 zjWZOOehhHXX9qgoSAMU+OnhLzSfvEe9/CDm1Wx55VgbpOcept0y7nOQew6jMvjju66o
 Qhp0S8lFxyVCTxq/tG2XzbEQTfqsIdzqCVXxsVEs1vPdekSFzSd+nEiWibbLb8SmiWEt
 Avig==
X-Gm-Message-State: AFuF++lq30aRgZZQczWbhsIXTUlSWq0zXnnUjcyPn8k7eChfXQ377P4I
 Jjf7ug0xuUZ3w8BfAGC1KR0Z1XmBYZXKgtKQ6kh1xor6tb/3qYieLV7eHVwJ1k/98Z96otQ4tNO
 UIAVewwIGxaYVkRTEUuJabZcqxlEK99AMLI8TK/8soEmw7yvcVrLgH7fl5JcG+u4Av7trBK2Etu
 G20jUmbOLNhX7BfED17HFSiwYhN+59CfOOWA==
X-Gm-Gg: AYBFou1zkLwXQMD0itdU923YBvE1VEwDfy96jdTi1wUHoVT4E3tp1xSTa7a2bCPKLPL
 rDufp9a7p+LFVTbZKAQMa+FGHsDwcaknMWc/DRaGuP7ZCj8L6gB9jOw2LVvrmU/cgPGwHIJv0um
 drHpACcLxdxmGyNnWgBwHg6a+d3g1X2lOv5qyfsG1X87VCAEwoNGuRAB++ciz11ZB1YtqrQJvU3
 DsFG6cLdSA7bQ3gqyknIriOFQtnlgbCVYZ+g/Hsy/qhaQ9ClbSmBDkd1GQPGZK+rZ0SoB7aGUaz
 bzGv1231ZgSM39T7ZbC3LkV7uMdYGHNJSvxru37Oe9gAef7a3rjRkXkmLYZjt7I7emo/nYOog1v
 4EKu96VV8Jnb9dGr2mp4Is1Q=
X-Received: by 2002:a05:600c:3513:b0:49d:28c4:b304 with SMTP id
 5b1f17b1804b1-49e619d479emr7365715e9.29.1789071320838; 
 Thu, 10 Sep 2026 13:15:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:49d:28c4:b304 with SMTP id
 5b1f17b1804b1-49e619d479emr7365155e9.29.1789071320262; 
 Thu, 10 Sep 2026 13:15:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62225628sm1168585e9.3.2026.09.10.13.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:19 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PULL 78/90] hw/hotplug: Mark various HotplugHandlerClass variables
 as const
Message-ID: <3a9648b103b09ee9abbb680f7d07e32f05bd9290.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

The HotplugHandlerClass pointers are only dereferenced, not updated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903230245.65601-3-philmd@oss.qualcomm.com>
---
 include/hw/core/qdev.h    | 2 +-
 hw/core/hotplug.c         | 8 ++++----
 hw/s390x/virtio-ccw-md.c  | 2 +-
 hw/virtio/virtio-md-pci.c | 2 +-
 system/qdev-monitor.c     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f054a214fc..e4cb027ab3 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1069,7 +1069,7 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
     bool ret = !!plug_handler;
 
     if (plug_handler) {
-        HotplugHandlerClass *hdc;
+        const HotplugHandlerClass *hdc;
 
         hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
         if (hdc->is_hotpluggable_bus) {
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 68aabad8ae..00e80a67c8 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -17,7 +17,7 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->pre_plug) {
         hdc->pre_plug(plug_handler, plugged_dev, errp);
@@ -28,7 +28,7 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
                           DeviceState *plugged_dev,
                           Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->plug) {
         hdc->plug(plug_handler, plugged_dev, errp);
@@ -39,7 +39,7 @@ void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->unplug_request) {
         hdc->unplug_request(plug_handler, plugged_dev, errp);
@@ -50,7 +50,7 @@ void hotplug_handler_unplug(HotplugHandler *plug_handler,
                             DeviceState *plugged_dev,
                             Error **errp)
 {
-    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+    const HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
 
     if (hdc->unplug) {
         hdc->unplug(plug_handler, plugged_dev, errp);
diff --git a/hw/s390x/virtio-ccw-md.c b/hw/s390x/virtio-ccw-md.c
index 0370f58450..0b18b49bc4 100644
--- a/hw/s390x/virtio-ccw-md.c
+++ b/hw/s390x/virtio-ccw-md.c
@@ -73,7 +73,7 @@ void virtio_ccw_md_unplug_request(VirtIOMDCcw *vmd, MachineState *ms,
     VirtIOMDCcwClass *vmdc = VIRTIO_MD_CCW_GET_CLASS(vmd);
     DeviceState *dev = DEVICE(vmd);
     HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
     if (!vmdc->unplug_request_check) {
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index 9278b32cf8..aa5b11c0f6 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -72,7 +72,7 @@ void virtio_md_pci_unplug_request(VirtIOMDPCI *vmd, MachineState *ms,
     VirtIOMDPCIClass *vmdc = VIRTIO_MD_PCI_GET_CLASS(vmd);
     DeviceState *dev = DEVICE(vmd);
     HotplugHandler *bus_handler = qdev_get_bus_hotplug_handler(dev);
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
     if (!vmdc->unplug_request_check) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 5c87fda509..0c5502d45b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -918,7 +918,7 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_ctrl;
-    HotplugHandlerClass *hdc;
+    const HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
     if (!qdev_hotunplug_allowed(dev, errp)) {
-- 
MST



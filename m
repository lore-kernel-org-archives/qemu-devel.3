Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59FCC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBP-00086w-Ox; Fri, 11 Sep 2026 05:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAp-0005Ft-S4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAo-0008O5-5M
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CnyxDCKVe7u1Oo/VtDfYPCe5Gbe0/d1270GUGGe0eo=;
 b=XytJIMWSzpfyVmY13W96kgMk42Tq11Sm8MUTeiQzkQvS+gbQrU5/IYciFlFM4Zg/g4/7NF
 XpDejQ1irATLSuLQrnieb8zh1BB9wFOjpm2UIahuxxWpzR6UzE8pzX7cT6T0FJMWBJH46X
 EAYdCacbAmueCZQN5T4qvN+Tddu4hAg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-OM2LBvbDMeWDrLXS5ZkvSA-1; Fri, 11 Sep 2026 05:03:51 -0400
X-MC-Unique: OM2LBvbDMeWDrLXS5ZkvSA-1
X-Mimecast-MFC-AGG-ID: OM2LBvbDMeWDrLXS5ZkvSA_1789117431
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so8090965e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117430; x=1789722230; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4CnyxDCKVe7u1Oo/VtDfYPCe5Gbe0/d1270GUGGe0eo=;
 b=FQqQ/knHTVjt6FeYIcqZ3WoqdUCCXjZq027spnDQ9c0prBHov2p7rhO8YE/uqAeWuo
 uaSD5DkTurK1N/dIb78ipX4DxPkJaTGH9wKK1G/YOcv+8xPCXO6QicK1YOLBwTvdYPhY
 Um4+K2b1aSlF9Q5NHi8hNtfq6tPwSv+v0tr9GQl/C8cAXPnp5dG8GCum2FaWMwpvR4ew
 f/WoZl9z5IeEBvMPAP0H0u7wGTKBbLi3WRWk0xjsN1AlqdBJlFo+WzAbdk0T0rrgV2EE
 qUhShl4zqHD6AEbBNfIofw3wFIdA9vcmd2u4+iKmrDLOK8P62VEquU47QKR7bXBVRxGV
 GLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117430; x=1789722230;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4CnyxDCKVe7u1Oo/VtDfYPCe5Gbe0/d1270GUGGe0eo=;
 b=JEO4Y+ilDAEQ3+8LB9V8JmtzEdxVutoHVhQ4Cg1JlHtPhbKSg8LJ0I0FTD4MWgHzXq
 g2f9X97Zuqawf4sdtoyN2p/M1ZL+DJHXf8rAKo0ZwkeDPOUf747iNV4HgIMi9h0zLfLB
 Pn0b5dLxskadx5zfROqQkxmJ0UhXZXscP3Sq5PtE8wR4InrVHmoaewCCOIhpQclhoEYa
 2qSS3LEDhAXo91xWHAoNPHMgbMQhuAiYoTHJPe8WRX0nrNsbTO1VxONNAKpnsEDCjqNi
 4PtH8+TVWSkStIe/sR2r/Xlj+nEo3WBejF1UGZWm4unrFRqlvpyaWRJipLpE6eHOfx+c
 U6xA==
X-Gm-Message-State: AFuF++kzRlHiHvwidurQSlzOK1ULJplK5xnZyf6NQj0HSrsoTH35C0jL
 073suu/OJTQ+GCofMng/zFsvkSISAP61+Cbq5eIqhDQ32egpwADdRIYVOhiPfDyhc8zVpjxD8gz
 dTf+/Rb9ZC10GeiRxK/cDzH7rGLoElOvX68jjqWQX3rk4LEFWzI/z3tXQO2m15XItR5u2a4pUHk
 hixGf9yZehxv4vPRlw8qrtYLNjgz4KUsQs6A==
X-Gm-Gg: AYBFou04HBdL1zd/1yGy8mE9WoqJZx1zspT+gc9+EHU5MfhiPlulmY6OW5x2ZCtxJcF
 C2H2WT20RULA+HgltW8PemxDyZIOTjue1BDY6x7FWkejxhvsSaCNVVlJjV62p/zMpb4ED/vhpMg
 MtKjJmLwZc128dH0RoK1/pgq8L3KZccGrrBO0fKGGdXdSZGWdNAfGOW9YkM2XtAdzKIk0G6ixGT
 MvZdi9XdUDauYx89iq/n9MBbj661+DO5oADEFVOjTZV7+jNnFTgGJIuszA7LMh6nMrHcNjRAEol
 jDjRR1BY/UxAhF0WONWGvx+7VbC0+EKStnp66+kpHb0hPgmP2yo77EYZKWtsSkJ/BJ5M41ubgVD
 f7W5Ghb3w8ZbxZU1Jqw/RTto=
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49e619f3ae1mr61272745e9.10.1789117430214; 
 Fri, 11 Sep 2026 02:03:50 -0700 (PDT)
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49e619f3ae1mr61271225e9.10.1789117429657; 
 Fri, 11 Sep 2026 02:03:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm4344189f8f.10.2026.09.11.02.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:48 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:46 -0400
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
Subject: [PULL v2 63/75] hw/hotplug: Mark various HotplugHandlerClass
 variables as const
Message-ID: <f4348d359cce7b84c1a755c3ff49f8ebd5fcaf79.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



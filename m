Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E8CC02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUQ1-0000Fl-H3; Thu, 30 Jan 2025 08:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP4-0007SK-Cj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP0-0000A1-FC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kgVS5nOLBjp9lzAmjT/70TvKJ8N7XUJI0OxS/CKpcYU=;
 b=V2xQWS3HK0RyzrEJcXcVN9ai8FcwzJO6mV8aF9S8vRcad/mPgntvw2+T9+hDO1OlTsWLbq
 HGoSIMyUC/v9ImLv4Hs9ShzLso6Ok9GGQu37qDHT1hSFsfsuz6TUsFz8e6xxpAb4GL3QfI
 ADsDbAEHgPGMTYvlN7HQPST00jQ7psk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-jeaFdFeIPZ2CL3nOuQLQUw-1; Thu,
 30 Jan 2025 08:16:12 -0500
X-MC-Unique: jeaFdFeIPZ2CL3nOuQLQUw-1
X-Mimecast-MFC-AGG-ID: jeaFdFeIPZ2CL3nOuQLQUw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EBE618009F9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:16:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BCBD30001BE; Thu, 30 Jan 2025 13:16:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 13/20] s390x/s390-virtio-ccw: Support plugging PCI-based virtio
 memory devices
Date: Thu, 30 Jan 2025 14:15:27 +0100
Message-ID: <20250130131535.91297-14-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: David Hildenbrand <david@redhat.com>

Let's just wire it up, unlocking virtio-mem-pci support on s390x.

While at it, drop the "return;" in s390_machine_device_unplug_request(),
to make it look like the other handlers.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-ID: <20250128185705.1609038-3-david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b069303592..d9e683c5b4 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -576,8 +576,7 @@ static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_pre_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
-        error_setg(errp,
-                   "PCI-attached virtio based memory devices not supported");
+        virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -588,7 +587,8 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
         /*
          * At this point, the device is realized and set all memdevs mapped, so
          * qemu_maxrampagesize() will pick up the page sizes of these memdevs
@@ -602,7 +602,11 @@ static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                        " initial memory");
             return;
         }
-        virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
+            virtio_ccw_md_plug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
+        } else {
+            virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+        }
     }
 }
 
@@ -611,10 +615,12 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
-        return;
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_unplug_request(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev),
                                      errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug_request(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
+                                     errp);
     }
 }
 
@@ -623,7 +629,9 @@ static void s390_machine_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_CCW)) {
         virtio_ccw_md_unplug(VIRTIO_MD_CCW(dev), MACHINE(hotplug_dev), errp);
-     }
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
+        virtio_md_pci_unplug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
+    }
  }
 
 static CpuInstanceProperties s390_cpu_index_to_props(MachineState *ms,
-- 
2.48.1



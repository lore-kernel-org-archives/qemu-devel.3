Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CADC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1iTV-0001SK-UA; Tue, 30 Apr 2024 04:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1iTU-0001S4-9z
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:04:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1iTS-00008r-Jh
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714464265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=M57vhfbB6+tyXe4U2kBkXS0xThABRy9xFAKBlDYVoGs=;
 b=G+M1B5rStNZzLDyVUyeJ1synecWHKNM8MAV+IepY+FHogb7w6TNqpYylQRZDR5LGTnaion
 cs7ocCKbwhS7d2kTDCs8bEeIAFC/VLrZKDgNPiRvjh44SwodkPqZq1zxabZ3jwQmEyFGly
 iR1y1oxZFjYV0gBeWZ0G1bMDRtjw6tE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-pVxeXepEPOmCkAzjqcWL_g-1; Tue,
 30 Apr 2024 04:04:20 -0400
X-MC-Unique: pVxeXepEPOmCkAzjqcWL_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C3D929AC011;
 Tue, 30 Apr 2024 08:04:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E98E52166B34;
 Tue, 30 Apr 2024 08:04:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/s390x: Attach the sclpconsole to the /machine/sclp node
Date: Tue, 30 Apr 2024 10:04:08 +0200
Message-ID: <20240430080408.415890-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The sclpconsole currently does not have a proper parent in the QOM
tree, so it shows up under /machine/unattached - which is somewhat
ugly. Let's attach it to /machine/sclp instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/sclp.h    |  2 +-
 hw/s390x/s390-virtio-ccw.c | 11 +++++++----
 hw/s390x/sclp.c            |  4 +++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index b405a387b6..abfd6d8868 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -222,7 +222,7 @@ static inline int sccb_data_len(SCCB *sccb)
 }
 
 
-void s390_sclp_init(void);
+Object *s390_sclp_init(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
 int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4dcc213820..e2f9206ded 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -237,11 +237,13 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
     }
 }
 
-static void s390_create_sclpconsole(const char *type, Chardev *chardev)
+static void s390_create_sclpconsole(Object *sclp, const char *type,
+                                    Chardev *chardev)
 {
     DeviceState *dev;
 
     dev = qdev_new(type);
+    object_property_add_child(sclp, type, OBJECT(dev));
     qdev_prop_set_chr(dev, "chardev", chardev);
     qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), &error_fatal);
 }
@@ -252,8 +254,9 @@ static void ccw_init(MachineState *machine)
     int ret;
     VirtualCssBus *css_bus;
     DeviceState *dev;
+    Object *sclp;
 
-    s390_sclp_init();
+    sclp = s390_sclp_init();
     /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine->ram);
 
@@ -302,10 +305,10 @@ static void ccw_init(MachineState *machine)
 
     /* init consoles */
     if (serial_hd(0)) {
-        s390_create_sclpconsole("sclpconsole", serial_hd(0));
+        s390_create_sclpconsole(sclp, "sclpconsole", serial_hd(0));
     }
     if (serial_hd(1)) {
-        s390_create_sclpconsole("sclplmconsole", serial_hd(1));
+        s390_create_sclpconsole(sclp, "sclplmconsole", serial_hd(1));
     }
 
     /* init the TOD clock */
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 893e71a41b..75d45fb184 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -379,13 +379,15 @@ void sclp_service_interrupt(uint32_t sccb)
 
 /* qemu object creation and initialization functions */
 
-void s390_sclp_init(void)
+Object *s390_sclp_init(void)
 {
     Object *new = object_new(TYPE_SCLP);
 
     object_property_add_child(qdev_get_machine(), TYPE_SCLP, new);
     object_unref(new);
     qdev_realize(DEVICE(new), NULL, &error_fatal);
+
+    return new;
 }
 
 static void sclp_realize(DeviceState *dev, Error **errp)
-- 
2.44.0



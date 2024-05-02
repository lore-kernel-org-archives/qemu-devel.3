Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A134C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WHu-00012N-AX; Thu, 02 May 2024 09:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHs-00010D-5G
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHq-0003Vt-4O
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714655745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/qlljcrlaSquzEVIXfDf0EMPOwczBiYwTYI43Z2NpA=;
 b=cki10pr240X/K9Jr9WhGt07JRWGlyC0/2C8IKL+SwAKpQ3zR8yjQNNdpUu6a6YopGpDZze
 S1Y0UsASkalYUs/BAUPijY9bzvmayowetU0CQ6o4qboDsxPquCvv3yKykaOIiuX411/TPm
 eM7xMDkPpHV+MBUPAcc8N2gD/+cIv+k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-qE0dGT9TMYG1pEMUXV-MfA-1; Thu,
 02 May 2024 09:15:41 -0400
X-MC-Unique: qE0dGT9TMYG1pEMUXV-MfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2BA43816B44;
 Thu,  2 May 2024 13:15:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06C8E1C0654E;
 Thu,  2 May 2024 13:15:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/3] s390x/event-facility: Simplify
 sclp_get_event_facility_bus()
Date: Thu,  2 May 2024 15:15:32 +0200
Message-ID: <20240502131533.377719-3-clg@redhat.com>
In-Reply-To: <20240502131533.377719-1-clg@redhat.com>
References: <20240502131533.377719-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sclp_get_event_facility_bus() scans the whole machine to find a
TYPE_SCLP_EVENTS_BUS object. The SCLPDevice instance is now available
under the machine state, use it to simplify the lookup and adjust the
creation of the consoles.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/s390x/event-facility.h |  2 +-
 hw/s390x/event-facility.c         | 13 ++-----------
 hw/s390x/s390-virtio-ccw.c        | 12 +++++++-----
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 3ffd575d8ff09863e17f96d1bdb56a2ca6c2aa56..ff874e792d32ffa4089bb4cb40ab9eb34c889b0c 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -203,6 +203,6 @@ struct SCLPEventFacilityClass {
     bool (*event_pending)(SCLPEventFacility *ef);
 };
 
-BusState *sclp_get_event_facility_bus(void);
+BusState *sclp_get_event_facility_bus(SCLPEventFacility *ef);
 
 #endif
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index f9829de9532b65466a65443cecd9609198c5c026..06c1da0ecedcb307c77672097323954c6e7ccaf2 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -523,16 +523,7 @@ static void register_types(void)
 
 type_init(register_types)
 
-BusState *sclp_get_event_facility_bus(void)
+BusState *sclp_get_event_facility_bus(SCLPEventFacility *ef)
 {
-    Object *busobj;
-    SCLPEventsBus *sbus;
-
-    busobj = object_resolve_path_type("", TYPE_SCLP_EVENTS_BUS, NULL);
-    sbus = OBJECT_CHECK(SCLPEventsBus, busobj, TYPE_SCLP_EVENTS_BUS);
-    if (!sbus) {
-        return NULL;
-    }
-
-    return &sbus->qbus;
+    return BUS(&ef->sbus);
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 159f67d05c1e534800427ce46afcdaa526fd5902..2afaf45ce606b2bf7e67dc890339f6c5dd917eca 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -237,13 +237,15 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
     }
 }
 
-static void s390_create_sclpconsole(const char *type, Chardev *chardev)
+static void s390_create_sclpconsole(SCLPDevice *sclp,
+                                    const char *type, Chardev *chardev)
 {
-    BusState *ev_fac_bus = sclp_get_event_facility_bus();
+    SCLPEventFacility *ef = sclp->event_facility;
+    BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
     DeviceState *dev;
 
     dev = qdev_new(type);
-    object_property_add_child(OBJECT(ev_fac_bus->parent), type, OBJECT(dev));
+    object_property_add_child(OBJECT(ef), type, OBJECT(dev));
     qdev_prop_set_chr(dev, "chardev", chardev);
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
@@ -308,10 +310,10 @@ static void ccw_init(MachineState *machine)
 
     /* init consoles */
     if (serial_hd(0)) {
-        s390_create_sclpconsole("sclpconsole", serial_hd(0));
+        s390_create_sclpconsole(ms->sclp, "sclpconsole", serial_hd(0));
     }
     if (serial_hd(1)) {
-        s390_create_sclpconsole("sclplmconsole", serial_hd(1));
+        s390_create_sclpconsole(ms->sclp, "sclplmconsole", serial_hd(1));
     }
 
     /* init the TOD clock */
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D05C25B77
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Jvx-0001H3-Na; Fri, 10 May 2024 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvS-00015l-77
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvP-0001Xg-Gz
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LK7VKeHEgef+sRxRXZXJculo3eBN1bpcKjAtwE2gzYU=;
 b=ATWsgQONRNC5ohXZttR+BrJOr0UJnfWM19WA5BBPjALl69+Vco44P1UAQ77uDXPnAbyXsw
 r0dUcQMQsKbj1DPO2UQP7N24E1N9KhwjfuQxz29bKYHwRH4WKCEbA1xA7J7b0xoJ852D1K
 hDoLgnbEQSOi8Wwix/bivrNjZO3gaQI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-VGjXC725PQCzs-gWrfV98g-1; Fri,
 10 May 2024 02:40:09 -0400
X-MC-Unique: VGjXC725PQCzs-gWrfV98g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D11A73C00090;
 Fri, 10 May 2024 06:40:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86E1E2079267;
 Fri, 10 May 2024 06:40:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/8] s390x/event-facility: Simplify
 sclp_get_event_facility_bus()
Date: Fri, 10 May 2024 08:39:56 +0200
Message-ID: <20240510064001.26002-4-thuth@redhat.com>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
References: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Cédric Le Goater <clg@redhat.com>

sclp_get_event_facility_bus() scans the whole machine to find a
TYPE_SCLP_EVENTS_BUS object. The SCLPDevice instance is now available
under the machine state, use it to simplify the lookup and adjust the
creation of the consoles.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240502131533.377719-3-clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/event-facility.h |  2 +-
 hw/s390x/event-facility.c         | 13 ++-----------
 hw/s390x/s390-virtio-ccw.c        | 12 +++++++-----
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 3ffd575d8f..ff874e792d 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -203,6 +203,6 @@ struct SCLPEventFacilityClass {
     bool (*event_pending)(SCLPEventFacility *ef);
 };
 
-BusState *sclp_get_event_facility_bus(void);
+BusState *sclp_get_event_facility_bus(SCLPEventFacility *ef);
 
 #endif
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index f9829de953..06c1da0ece 100644
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
index 159f67d05c..2afaf45ce6 100644
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
2.45.0



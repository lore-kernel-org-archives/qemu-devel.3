Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39358C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfZ0-0003u3-IU; Thu, 26 Jun 2025 01:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYr-0003sR-0Y
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYp-000169-3b
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1W0uRmyHTr6G8aZqUOTR0yJ0rOVt5nKmngimSzCOEXw=;
 b=ATf4kk1YLSZZv4F2GH+JQ5QzS6ujgkx+4ifAuTqmG5Z0KMF2VT3xbYW1btvm5iAQITUr4g
 rWbbv4ckv//yLX+0TdMnXMQbB4VnQ9yuIlPNGnLcqWfBzIipiH5K1OKhyXQHjVNJtVOIDj
 vllblzJscb/PoSsRK1SHlBydTPS1Q40=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-My-_290HOFqGLb7fZzwX7w-1; Thu,
 26 Jun 2025 01:54:05 -0400
X-MC-Unique: My-_290HOFqGLb7fZzwX7w-1
X-Mimecast-MFC-AGG-ID: My-_290HOFqGLb7fZzwX7w_1750917244
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9A5F19560B5; Thu, 26 Jun 2025 05:54:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7B1419560A3; Thu, 26 Jun 2025 05:54:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 04/19] hw/s390x: add Control-Program Identification to QOM
Date: Thu, 26 Jun 2025 07:53:35 +0200
Message-ID: <20250626055350.218271-5-thuth@redhat.com>
In-Reply-To: <20250626055350.218271-1-thuth@redhat.com>
References: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>

Add Control-Program Identification (CPI) data to the QEMU Object
Model (QOM), along with the timestamp in which the data was received
as shown below.

virsh # qemu-monitor-command vm --pretty '{"execute":"qom-list",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi"}}'
{
  "return": [
    [...]
    {
      "name": "system_level",
      "type": "uint64"
    },
    {
      "name": "system_name",
      "type": "string"
    },
    {
      "name": "system_type",
      "type": "string"
    },
    {
      "name": "timestamp",
      "type": "uint64"
    },
    {
      "name": "sysplex_name",
      "type": "string"
    }
  ],
  "id": "libvirt-14"
}

Example CPI data:
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"system_type"}}'
{
  "return": "LINUX   ",
  "id": "libvirt-18"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"system_name"}}'
{
  "return": "TESTVM  ",
  "id": "libvirt-19"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"sysplex_name"}}'
{
  "return": "PLEX    ",
  "id": "libvirt-20"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"system_level"}}'
{
  "return": 74872343805430528,
  "id": "libvirt-21"
}
virsh # qemu-monitor-command vm --pretty '{"execute":"qom-get",
"arguments":{"path":"/machine/sclp/s390-sclp-event-facility/sclpcpi",
"property":"timestamp"}}'
{
  "return": 1748866753433923000,
  "id": "libvirt-22"
}

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20250616140107.990538-3-shalini@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/event-facility.h |  5 +++
 hw/s390x/sclpcpi.c                | 74 +++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index e81bc804983..eac7a511003 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -201,6 +201,11 @@ OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
 
 struct SCLPEventCPI {
     SCLPEvent event;
+    uint8_t system_type[8];
+    uint8_t system_name[8];
+    uint64_t system_level;
+    uint8_t sysplex_name[8];
+    uint64_t timestamp;
 };
 
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 6e2090b27f8..440a5ff1eb6 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -50,7 +50,10 @@
   */
 
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/s390x/ebcdic.h"
+#include "qapi/qapi-visit-machine.h"
 
 typedef struct Data {
     uint8_t id_format;
@@ -90,11 +93,58 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
 {
     ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
                                              ebh);
+    SCLPEventCPI *e = SCLP_EVENT_CPI(event);
+
+    ascii_put(e->system_type, (char *)cpim->data.system_type,
+              sizeof(cpim->data.system_type));
+    ascii_put(e->system_name, (char *)cpim->data.system_name,
+              sizeof(cpim->data.system_name));
+    ascii_put(e->sysplex_name, (char *)cpim->data.sysplex_name,
+              sizeof(cpim->data.sysplex_name));
+    e->system_level = ldq_be_p(&cpim->data.system_level);
+    e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
 
     cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
     return SCLP_RC_NORMAL_COMPLETION;
 }
 
+static char *get_system_type(Object *obj, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    return g_strndup((char *) e->system_type, sizeof(e->system_type));
+}
+
+static char *get_system_name(Object *obj, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    return g_strndup((char *) e->system_name, sizeof(e->system_name));
+}
+
+static char *get_sysplex_name(Object *obj, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    return g_strndup((char *) e->sysplex_name, sizeof(e->sysplex_name));
+}
+
+static void get_system_level(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    visit_type_uint64(v, name, &e->system_level, errp);
+}
+
+static void get_timestamp(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
+
+    visit_type_uint64(v, name, &e->timestamp, errp);
+}
+
 static void cpi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -106,6 +156,30 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
     k->get_send_mask = send_mask;
     k->get_receive_mask = receive_mask;
     k->write_event_data = write_event_data;
+
+    object_class_property_add_str(klass, "system_type", get_system_type, NULL);
+    object_class_property_set_description(klass, "system_type",
+            "operating system e.g. \"LINUX   \"");
+
+    object_class_property_add_str(klass, "system_name", get_system_name, NULL);
+    object_class_property_set_description(klass, "system_name",
+            "user configurable name of the VM e.g. \"TESTVM  \"");
+
+    object_class_property_add_str(klass, "sysplex_name", get_sysplex_name,
+                                  NULL);
+    object_class_property_set_description(klass, "sysplex_name",
+            "name of the cluster which the VM belongs to, if any"
+            " e.g. \"PLEX    \"");
+
+    object_class_property_add(klass, "system_level", "uint64", get_system_level,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(klass, "system_level",
+            "distribution and kernel version in Linux e.g. 74872343805430528");
+
+    object_class_property_add(klass, "timestamp", "uint64", get_timestamp,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(klass, "timestamp",
+            "latest update of CPI data in nanoseconds since the UNIX EPOCH");
 }
 
 static const TypeInfo sclp_cpi_info = {
-- 
2.50.0



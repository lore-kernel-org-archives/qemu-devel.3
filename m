Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D6AC77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 05:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUfYz-0003tP-Bd; Thu, 26 Jun 2025 01:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYp-0003s5-7c
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUfYk-000163-RM
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 01:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750917246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLQEf5z3kWQyxi28+w5rveSeLgJSA2Z+WX96fuy2Z50=;
 b=OSN9OGBz+fx2Jnwiic2QQLQmnc8qxvJhg6q59SqIh02hXeAxg5oOADVWSWrdlwOA6cerIh
 1evZhRb5lbrK3oxvCRFNuKyhRyYTcBLis3HVKH78SPpE+rfWSLliulHog0IZX0PEsLCraW
 RAcVSS9sIErp+Yxl4HfJBs3N6OUvKcY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-OUTqRPI1MKqiWOmcIuyEsw-1; Thu,
 26 Jun 2025 01:54:03 -0400
X-MC-Unique: OUTqRPI1MKqiWOmcIuyEsw-1
X-Mimecast-MFC-AGG-ID: OUTqRPI1MKqiWOmcIuyEsw_1750917242
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26A3318089B5; Thu, 26 Jun 2025 05:54:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91AFC19560A3; Thu, 26 Jun 2025 05:53:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 03/19] hw/s390x: add SCLP event type CPI
Date: Thu, 26 Jun 2025 07:53:34 +0200
Message-ID: <20250626055350.218271-4-thuth@redhat.com>
In-Reply-To: <20250626055350.218271-1-thuth@redhat.com>
References: <20250626055350.218271-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Implement the Service-Call Logical Processor (SCLP) event
type Control-Program Identification (CPI) in QEMU. This
event is used to send CPI identifiers from the guest to the
host. The CPI identifiers are: system type, system name,
system level and sysplex name.

System type: operating system of the guest (e.g. "LINUX   ").
System name: user configurable name of the guest (e.g. "TESTVM  ").
System level: distribution and kernel version, if the system type is Linux
(e.g. 74872343805430528).
Sysplex name: name of the cluster which the guest belongs to (if any)
(e.g. "PLEX").

The SCLP event CPI is supported only from "s390-ccw-virtio-10.1" machine
and higher.

Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250616140107.990538-2-shalini@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/event-facility.h  |  12 +++
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 hw/s390x/event-facility.c          |   2 +
 hw/s390x/s390-virtio-ccw.c         |  22 ++++++
 hw/s390x/sclpcpi.c                 | 123 +++++++++++++++++++++++++++++
 hw/s390x/meson.build               |   1 +
 6 files changed, 161 insertions(+)
 create mode 100644 hw/s390x/sclpcpi.c

diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index ff874e792d3..e81bc804983 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -25,6 +25,7 @@
 #define SCLP_EVENT_MESSAGE                      0x02
 #define SCLP_EVENT_CONFIG_MGT_DATA              0x04
 #define SCLP_EVENT_PMSGCMD                      0x09
+#define SCLP_EVENT_CTRL_PGM_ID                  0x0b
 #define SCLP_EVENT_ASCII_CONSOLE_DATA           0x1a
 #define SCLP_EVENT_SIGNAL_QUIESCE               0x1d
 
@@ -35,6 +36,7 @@
 #define SCLP_EVENT_MASK_MSG             SCLP_EVMASK(SCLP_EVENT_MESSAGE)
 #define SCLP_EVENT_MASK_CONFIG_MGT_DATA SCLP_EVMASK(SCLP_EVENT_CONFIG_MGT_DATA)
 #define SCLP_EVENT_MASK_PMSGCMD         SCLP_EVMASK(SCLP_EVENT_PMSGCMD)
+#define SCLP_EVENT_MASK_CTRL_PGM_ID     SCLP_EVMASK(SCLP_EVENT_CTRL_PGM_ID)
 #define SCLP_EVENT_MASK_MSG_ASCII       SCLP_EVMASK(SCLP_EVENT_ASCII_CONSOLE_DATA)
 #define SCLP_EVENT_MASK_SIGNAL_QUIESCE  SCLP_EVMASK(SCLP_EVENT_SIGNAL_QUIESCE)
 
@@ -191,6 +193,16 @@ struct SCLPEventClass {
     bool (*can_handle_event)(uint8_t type);
 };
 
+#define TYPE_SCLP_EVENT_CPI "sclpcpi"
+typedef struct SCLPEventCPIClass SCLPEventCPIClass;
+typedef struct SCLPEventCPI SCLPEventCPI;
+OBJECT_DECLARE_TYPE(SCLPEventCPI, SCLPEventCPIClass,
+                    SCLP_EVENT_CPI)
+
+struct SCLPEventCPI {
+    SCLPEvent event;
+};
+
 #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
 typedef struct SCLPEventFacility SCLPEventFacility;
 typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 321b26df308..526078a4e2b 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -54,6 +54,7 @@ struct S390CcwMachineClass {
 
     /*< public >*/
     int max_threads;
+    bool use_cpi;
 };
 
 #endif
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 7b7bf237fed..fee286ea639 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -4,6 +4,7 @@
  *       handles SCLP event types
  *          - Signal Quiesce - system power down
  *          - ASCII Console Data - VT220 read and write
+ *          - Control-Program Identification - Send OS data from guest to host
  *
  * Copyright IBM, Corp. 2012
  *
@@ -40,6 +41,7 @@ struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
     SCLPEvent quiesce, cpu_hotplug;
+    SCLPEventCPI cpi;
     /* guest's receive mask */
     union {
         uint32_t receive_mask_pieces[2];
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ce3c13defb5..a79bd13275b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -260,9 +260,21 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
     qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
 }
 
+static void s390_create_sclpcpi(SCLPDevice *sclp)
+{
+    SCLPEventFacility *ef = sclp->event_facility;
+    BusState *ev_fac_bus = sclp_get_event_facility_bus(ef);
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_SCLP_EVENT_CPI);
+    object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
+    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
+}
+
 static void ccw_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     int ret;
     VirtualCssBus *css_bus;
@@ -323,6 +335,12 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    /* init SCLP event Control-Program Identification */
+    if (s390mc->use_cpi) {
+        s390_create_sclpcpi(ms->sclp);
+    }
+
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -783,6 +801,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     DumpSKeysInterface *dsi = DUMP_SKEYS_INTERFACE_CLASS(oc);
 
     s390mc->max_threads = 1;
+    s390mc->use_cpi = true;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
@@ -908,6 +927,9 @@ static void ccw_machine_10_0_instance_options(MachineState *machine)
 
 static void ccw_machine_10_0_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
+    s390mc->use_cpi = false;
+
     ccw_machine_10_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
 }
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
new file mode 100644
index 00000000000..6e2090b27f8
--- /dev/null
+++ b/hw/s390x/sclpcpi.c
@@ -0,0 +1,123 @@
+ /*
+  * SPDX-License-Identifier: GPL-2.0-or-later
+  *
+  * SCLP event type 11 - Control-Program Identification (CPI):
+  *    CPI is used to send program identifiers from the guest to the
+  *    Service-Call Logical Processor (SCLP). It is not sent by the SCLP.
+  *
+  *    Control-program identifiers provide data about the guest operating
+  *    system.  The control-program identifiers are: system type, system name,
+  *    system level and sysplex name.
+  *
+  *    In Linux, all the control-program identifiers are user configurable. The
+  *    system type, system name, and sysplex name use EBCDIC characters from
+  *    this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the system
+  *    type, system name and sysplex name are arbitrary free-form texts.
+  *
+  *    In Linux, the 8-byte hexadecimal system-level has the format
+  *    0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
+  *    <a>: is a 4-bit digit, its most significant bit indicates hypervisor use
+  *    <b>: is one digit that represents Linux distributions as follows
+  *    0: generic Linux
+  *    1: Red Hat Enterprise Linux
+  *    2: SUSE Linux Enterprise Server
+  *    3: Canonical Ubuntu
+  *    4: Fedora
+  *    5: openSUSE Leap
+  *    6: Debian GNU/Linux
+  *    7: Red Hat Enterprise Linux CoreOS
+  *    <cc>: are two digits for a distribution-specific encoding of the major
+  *    version of the distribution
+  *    <dd>: are two digits for a distribution-specific encoding of the minor
+  *    version of the distribution
+  *    <eeee>: are four digits for the patch level of the distribution
+  *    <ff>: are two digits for the major version of the kernel
+  *    <gg>: are two digits for the minor version of the kernel
+  *    <hh>: are two digits for the stable version of the kernel
+  *    (e.g. 74872343805430528, when converted to hex is 0x010a000000060b00). On
+  *    machines prior to z16, some of the values are not available to display.
+  *
+  *    Sysplex refers to a cluster of logical partitions that communicates and
+  *    co-operates with each other.
+  *
+  *    The CPI feature is supported since 10.1.
+  *
+  * Copyright IBM, Corp. 2024
+  *
+  * Authors:
+  *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
+  *
+  */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/event-facility.h"
+
+typedef struct Data {
+    uint8_t id_format;
+    uint8_t reserved0;
+    uint8_t system_type[8];
+    uint64_t reserved1;
+    uint8_t system_name[8];
+    uint64_t reserved2;
+    uint64_t system_level;
+    uint64_t reserved3;
+    uint8_t sysplex_name[8];
+    uint8_t reserved4[16];
+} QEMU_PACKED Data;
+
+typedef struct ControlProgramIdMsg {
+    EventBufferHeader ebh;
+    Data data;
+} QEMU_PACKED ControlProgramIdMsg;
+
+static bool can_handle_event(uint8_t type)
+{
+    return type == SCLP_EVENT_CTRL_PGM_ID;
+}
+
+static sccb_mask_t send_mask(void)
+{
+    return 0;
+}
+
+/* Enable SCLP to accept buffers of event type CPI from the control-program. */
+static sccb_mask_t receive_mask(void)
+{
+    return SCLP_EVENT_MASK_CTRL_PGM_ID;
+}
+
+static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
+{
+    ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
+                                             ebh);
+
+    cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
+    return SCLP_RC_NORMAL_COMPLETION;
+}
+
+static void cpi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SCLPEventClass *k = SCLP_EVENT_CLASS(klass);
+
+    dc->user_creatable = false;
+
+    k->can_handle_event = can_handle_event;
+    k->get_send_mask = send_mask;
+    k->get_receive_mask = receive_mask;
+    k->write_event_data = write_event_data;
+}
+
+static const TypeInfo sclp_cpi_info = {
+    .name          = TYPE_SCLP_EVENT_CPI,
+    .parent        = TYPE_SCLP_EVENT,
+    .instance_size = sizeof(SCLPEventCPI),
+    .class_init    = cpi_class_init,
+};
+
+static void sclp_cpi_register_types(void)
+{
+    type_register_static(&sclp_cpi_info);
+}
+
+type_init(sclp_cpi_register_types)
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 99cbcbd7d63..1bc85837996 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -13,6 +13,7 @@ s390x_ss.add(files(
   's390-skeys.c',
   's390-stattrib.c',
   'sclp.c',
+  'sclpcpi.c',
   'sclpcpu.c',
   'sclpquiesce.c',
   'tod.c',
-- 
2.50.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6B9CF5386
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFS-0006Sm-Dl; Wed, 23 Oct 2024 09:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFP-0006Po-8E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFM-0002Cq-Ul
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ksFdGwLKh71OF9zpSqA+eTrJlr0azBjVPlIbCU3kz8=;
 b=Xo22Y8hd+WXwiUMUU+l3XQISeRnQzIHT8Se3Zv0XSAH9bwKrsScYbMw4oU2D3SWPWLJdrG
 WodOUmtEpylTfxropHwrkcYD+H7gRznKPNTB1ucZO4BMvEdHirVYjjLqYCz9lYwA7uZ01f
 Lbrqazprgp5SkJ3TX0oZY2BcOnYSbKE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-9WZ-_by7O3mba77R0jUtHA-1; Wed,
 23 Oct 2024 09:17:51 -0400
X-MC-Unique: 9WZ-_by7O3mba77R0jUtHA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EB4A1955E7D; Wed, 23 Oct 2024 13:17:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F24C21956054; Wed, 23 Oct 2024 13:17:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 14/23] s390x: Add individual loadparm assignment to CCW device
Date: Wed, 23 Oct 2024 15:17:01 +0200
Message-ID: <20241023131710.906748-15-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add a loadparm property to the VirtioCcwDevice object so that different
loadparms can be defined on a per-device basis for CCW boot devices.

The machine/global loadparm is still supported. If both a global and per-device
loadparm are defined, the per-device value will override the global value for
that device, but any other devices that do not specify a per-device loadparm
will still use the global loadparm.

It is invalid to assign a loadparm to a non-boot device.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-15-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ccw-device.h       |  2 ++
 hw/s390x/ipl.h              |  3 +-
 include/hw/s390x/ipl/qipl.h |  1 +
 hw/s390x/ccw-device.c       | 46 +++++++++++++++++++++++++
 hw/s390x/ipl.c              | 68 ++++++++++++++++++++++---------------
 hw/s390x/s390-virtio-ccw.c  | 18 +---------
 hw/s390x/sclp.c             |  9 ++---
 pc-bios/s390-ccw/main.c     | 10 ++++--
 8 files changed, 102 insertions(+), 55 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 5feeb0ee7a..1e1737c0f3 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -26,6 +26,8 @@ struct CcwDevice {
     CssDevId dev_id;
     /* The actual busid of the virtual subchannel. */
     CssDevId subch_id;
+    /* If set, use this loadparm value when device is boot target */
+    uint8_t loadparm[8];
 };
 typedef struct CcwDevice CcwDevice;
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index fa394c339d..b670bad551 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -21,7 +21,8 @@
 
 #define DIAG308_FLAGS_LP_VALID 0x80
 
-int s390_ipl_set_loadparm(uint8_t *loadparm);
+void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
+void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 int s390_ipl_prepare_pv_header(Error **errp);
 int s390_ipl_pv_unpack(void);
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 0ef04af027..b67d2ae061 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -18,6 +18,7 @@
 
 #define QIPL_ADDRESS  0xcc
 #define LOADPARM_LEN    8
+#define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
 /*
  * The QEMU IPL Parameters will be stored at absolute address
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 14c24e3890..230cc09e03 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -13,6 +13,10 @@
 #include "ccw-device.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
+#include "ipl.h"
+#include "qapi/visitor.h"
+#include "qemu/ctype.h"
+#include "qapi/error.h"
 
 static void ccw_device_refill_ids(CcwDevice *dev)
 {
@@ -37,10 +41,52 @@ static bool ccw_device_realize(CcwDevice *dev, Error **errp)
     return true;
 }
 
+static void ccw_device_get_loadparm(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    CcwDevice *dev = CCW_DEVICE(obj);
+    char *str = g_strndup((char *) dev->loadparm, sizeof(dev->loadparm));
+
+    visit_type_str(v, name, &str, errp);
+    g_free(str);
+}
+
+static void ccw_device_set_loadparm(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    CcwDevice *dev = CCW_DEVICE(obj);
+    char *val;
+    int index;
+
+    index = object_property_get_int(obj, "bootindex", NULL);
+
+    if (index < 0) {
+        error_setg(errp, "LOADPARM is only valid for boot devices!");
+    }
+
+    if (!visit_type_str(v, name, &val, errp)) {
+        return;
+    }
+
+    s390_ipl_fmt_loadparm(dev->loadparm, val, errp);
+}
+
+static const PropertyInfo ccw_loadparm = {
+    .name  = "ccw_loadparm",
+    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
+            " to the guest loader/kernel",
+    .get = ccw_device_get_loadparm,
+    .set = ccw_device_set_loadparm,
+};
+
 static Property ccw_device_properties[] = {
     DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
     DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
     DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
+    DEFINE_PROP("loadparm", CcwDevice, loadparm, ccw_loadparm,
+            typeof(uint8_t[8])),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8c490eeb52..656996b500 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -34,6 +34,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
+#include "qemu/ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
 
 #define KERN_IMAGE_START                0x010000UL
@@ -397,12 +398,43 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
     return ccw_dev;
 }
 
+void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
+{
+    int i;
+
+    /* Initialize the loadparm with spaces */
+    memset(loadparm, ' ', LOADPARM_LEN);
+    for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
+        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
+
+        if (qemu_isalnum(c) || c == '.' || c == ' ') {
+            loadparm[i] = c;
+        } else {
+            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
+                       c, c);
+            return;
+        }
+    }
+}
+
+void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
+{
+    int i;
+
+    /* Initialize the loadparm with EBCDIC spaces (0x40) */
+    memset(ebcdic_lp, '@', LOADPARM_LEN);
+    for (i = 0; i < LOADPARM_LEN && ascii_lp[i]; i++) {
+        ebcdic_lp[i] = ascii2ebcdic[(uint8_t) ascii_lp[i]];
+    }
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
+    uint8_t *lp;
 
     dev_st = get_boot_device(0);
     if (dev_st) {
@@ -413,6 +445,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
      * Currently allow IPL only from CCW devices.
      */
     if (ccw_dev) {
+        lp = ccw_dev->loadparm;
+
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
@@ -445,40 +479,20 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             break;
         }
 
-        if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
-            ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+        /* If the device loadparm is empty use the global machine loadparm */
+        if (memcmp(lp, NO_LOADPARM, 8) == 0) {
+            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         }
 
+        s390_ipl_convert_loadparm((char *)lp, ipl->iplb.loadparm);
+        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+
         return true;
     }
 
     return false;
 }
 
-int s390_ipl_set_loadparm(uint8_t *loadparm)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    char *lp = object_property_get_str(OBJECT(machine), "loadparm", NULL);
-
-    if (lp) {
-        int i;
-
-        /* lp is an uppercase string without leading/embedded spaces */
-        for (i = 0; i < 8 && lp[i]; i++) {
-            loadparm[i] = ascii2ebcdic[(uint8_t) lp[i]];
-        }
-
-        if (i < 8) {
-            memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces */
-        }
-
-        g_free(lp);
-        return 0;
-    }
-
-    return -1;
-}
-
 static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
                                          int virtio_id)
 {
@@ -534,7 +548,7 @@ static void update_machine_ipl_properties(IplParameterBlock *iplb)
         ascii_loadparm[i] = 0;
         object_property_set_str(machine, "loadparm", ascii_loadparm, &err);
     } else {
-        object_property_set_str(machine, "loadparm", "", &err);
+        object_property_set_str(machine, "loadparm", "        ", &err);
     }
     if (err) {
         warn_report_err(err);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 529e53f308..fe03f716f3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -722,28 +722,12 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
     char *val;
-    int i;
 
     if (!visit_type_str(v, name, &val, errp)) {
         return;
     }
 
-    for (i = 0; i < sizeof(ms->loadparm) && val[i]; i++) {
-        uint8_t c = qemu_toupper(val[i]); /* mimic HMC */
-
-        if (('A' <= c && c <= 'Z') || ('0' <= c && c <= '9') || (c == '.') ||
-            (c == ' ')) {
-            ms->loadparm[i] = c;
-        } else {
-            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
-                       c, c);
-            return;
-        }
-    }
-
-    for (; i < sizeof(ms->loadparm); i++) {
-        ms->loadparm[i] = ' '; /* pad right with spaces */
-    }
+    s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
 }
 
 static void ccw_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index e725dcd5fd..8757626b5c 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -110,7 +110,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     MachineState *machine = MACHINE(qdev_get_machine());
     int cpu_count;
     int rnsize, rnmax;
-    IplParameterBlock *ipib = s390_ipl_get_iplb();
     int required_len = SCCB_REQ_LEN(ReadInfo, machine->possible_cpus->len);
     int offset_cpu = s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
                      offsetof(ReadInfo, entries) :
@@ -171,12 +170,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnmax2 = cpu_to_be64(rnmax);
     }
 
-    if (ipib && ipib->flags & DIAG308_FLAGS_LP_VALID) {
-        memcpy(&read_info->loadparm, &ipib->loadparm,
-               sizeof(read_info->loadparm));
-    } else {
-        s390_ipl_set_loadparm(read_info->loadparm);
-    }
+    s390_ipl_convert_loadparm((char *)S390_CCW_MACHINE(machine)->loadparm,
+                                read_info->loadparm);
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
 }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 34ef27d7a6..ab4709e16e 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -183,8 +183,14 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
+    have_iplb = store_iplb(&iplb);
+
+    if (memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
+        ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
+    } else {
+        sclp_get_loadparm_ascii(loadparm_str);
+    }
 
-    sclp_get_loadparm_ascii(loadparm_str);
     memcpy(lpmsg + 10, loadparm_str, 8);
     puts(lpmsg);
 
@@ -193,8 +199,6 @@ static void boot_setup(void)
      * so we don't taint our decision-making process during a reboot.
      */
     memset((char *)S390EP, 0, 6);
-
-    have_iplb = store_iplb(&iplb);
 }
 
 static bool find_boot_device(void)
-- 
2.47.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E25C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLSa-0005kD-2s; Wed, 29 May 2024 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSZ-0005jf-Dh; Wed, 29 May 2024 11:43:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSX-0006xL-AT; Wed, 29 May 2024 11:43:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TFeKws014066; Wed, 29 May 2024 15:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=rRhNdpHeDHeBH5DoIUy1iUwmsrClhc/xeX0CjkwkJR8=;
 b=tpBXET7hXGcy9rqph5ZsZZRWwjpNdOaDwRgw+13b2ItLLgJUOj6nUgdnLDQJHmvHqxJO
 +/DkRa/JrJ9mmSwfT7DU0DG2ya59vvoYy5Ka6nkb9xxM0gEkSD+4NSPyVv6UuploBqqD
 O7H0FKW11yiJcig0OraGBLavH89hTjgDEQ4q3vXqOG2aYEFRtpzY21UpPzNk5PXk4WLq
 IH3wG/2lNDn9O/FhWgE5UhvX2Gbg0/qwtuDNxgaptcijq/Luby+WPrl1kxIXkCw56yMN
 RpyIVfj50c/GRZ8GgPlaRhxhl4jQ4O5V7a8Ly3/ChJE+FmWlMOPc6I+yEjnGhY0OAXjQ rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye6t10218-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:23 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TFhMRQ019412;
 Wed, 29 May 2024 15:43:22 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye6t10216-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TFATMY026789; Wed, 29 May 2024 15:43:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpd2mj8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TFhHf028443332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 15:43:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D8AA5806C;
 Wed, 29 May 2024 15:43:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3080A58063;
 Wed, 29 May 2024 15:43:17 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.67.55.69])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 May 2024 15:43:17 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 2/5] s390x: Add loadparm to CcwDevice
Date: Wed, 29 May 2024 11:43:08 -0400
Message-Id: <20240529154311.734548-3-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240529154311.734548-1-jrossi@linux.ibm.com>
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0pPCeVEAz-M5OcneXJSTap-TvHJSQ7N1
X-Proofpoint-ORIG-GUID: lFRdzf7XR8d6p5mzF8b6Ey4zJwo8NQa-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a loadparm property to the CcwDevice object so that different loadparms
can be defined on a per-device basis when using multiple boot devices.

The machine/global loadparm is still supported. If both a global and per-device
loadparm are defined, the per-device value will override the global value for
that device, but any other devices that do not specify a per-device loadparm
will still use the global loadparm.

Assigning a loadparm to a non-boot device is invalid and will be rejected.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ccw-device.h      |  2 ++
 hw/s390x/ipl.h             |  3 +-
 hw/s390x/ccw-device.c      | 49 ++++++++++++++++++++++++++++
 hw/s390x/ipl.c             | 67 +++++++++++++++++++++++---------------
 hw/s390x/s390-virtio-ccw.c | 18 +---------
 hw/s390x/sclp.c            |  3 +-
 pc-bios/s390-ccw/main.c    | 10 ++++--
 7 files changed, 104 insertions(+), 48 deletions(-)

diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 6dff95225d..35ccf1f7bb 100644
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
index b066d9e8e5..1dcb8984bb 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -21,7 +21,8 @@
 
 #define DIAG308_FLAGS_LP_VALID 0x80
 
-int s390_ipl_set_loadparm(uint8_t *loadparm);
+void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
+void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 int s390_ipl_prepare_pv_header(Error **errp);
 int s390_ipl_pv_unpack(void);
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index fb8c1acc64..143e085279 100644
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
@@ -36,10 +40,55 @@ static void ccw_device_realize(CcwDevice *dev, Error **errp)
     ccw_device_refill_ids(dev);
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
+    index = object_property_get_int(obj, "bootindex", &error_abort);
+
+    if (index < 0) {
+        error_setg(errp, "LOADPARM: non-boot device");
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
+    .description = "Up to 8 chars in set of [A-Za-z0-9. ] (lower case"
+            " chars converted to upper case) to pass to machine loader,"
+            " boot manager, and guest kernel",
+    .get = ccw_device_get_loadparm,
+    .set = ccw_device_set_loadparm,
+};
+
+#define DEFINE_PROP_CCW_LOADPARM(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, ccw_loadparm, typeof(uint8_t[8]))
+
 static Property ccw_device_properties[] = {
     DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
     DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
     DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
+    DEFINE_PROP_CCW_LOADPARM("loadparm", CcwDevice, loadparm),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index e934bf89d1..2d4f5152b3 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -34,6 +34,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
+#include "qemu/ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
 
 #define KERN_IMAGE_START                0x010000UL
@@ -390,12 +391,44 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
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
+        if (('A' <= c && c <= 'Z') || ('0' <= c && c <= '9') || (c == '.') ||
+            (c == ' ')) {
+            loadparm[i] = c;
+        } else {
+            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
+                       c, c);
+            return;
+        }
+    }
+}
+
+void s390_ipl_set_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
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
@@ -406,6 +439,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
      * Currently allow IPL only from CCW devices.
      */
     if (ccw_dev) {
+        lp = ccw_dev->loadparm;
+
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
@@ -438,40 +473,20 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             break;
         }
 
-        if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
-            ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+        /* If the device loadparm is empty use the global machine loadparm */
+        if (memcmp(lp, "\0\0\0\0\0\0\0\0", 8) == 0) {
+            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         }
 
+        s390_ipl_set_loadparm((char *)lp, ipl->iplb.loadparm);
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
 static int load_netboot_image(Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3d0bc3e7f2..00478bd6ee 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -714,28 +714,12 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
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
index e725dcd5fd..00afa9ad52 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -175,7 +175,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         memcpy(&read_info->loadparm, &ipib->loadparm,
                sizeof(read_info->loadparm));
     } else {
-        s390_ipl_set_loadparm(read_info->loadparm);
+        s390_ipl_set_loadparm((char *)S390_CCW_MACHINE(machine)->loadparm,
+                                read_info->loadparm);
     }
 
     sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 5506798098..3e51d698d7 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -173,8 +173,14 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
+    have_iplb = store_iplb(&iplb);
+
+    if (memcmp(iplb.loadparm, "@@@@@@@@", LOADPARM_LEN) != 0) {
+        ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
+    } else {
+        sclp_get_loadparm_ascii(loadparm_str);
+    }
 
-    sclp_get_loadparm_ascii(loadparm_str);
     memcpy(lpmsg + 10, loadparm_str, 8);
     sclp_print(lpmsg);
 
@@ -183,8 +189,6 @@ static void boot_setup(void)
      * so we don't taint our decision-making process during a reboot.
      */
     memset((char *)S390EP, 0, 6);
-
-    have_iplb = store_iplb(&iplb);
 }
 
 static void find_boot_device(void)
-- 
2.45.1


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA45D65C7E
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 14:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBx3p-0005S1-Cb; Fri, 15 Nov 2024 09:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBx3g-0005RD-U7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 09:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBx3e-0007FM-H4
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 09:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731679939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mxfHEu7IUeUIGqP2NI6eVGXELXqzoqJ/wggRq8TrmGM=;
 b=bntUOcoaOmgKgqDpTAfBsVGl7s7HiEUaN2MtY+CuQR+khsLDajWCwHYkjIvy+4uR3/jg3a
 5AFv+llohnTOhnn2B9aNXbenNdlsXk8tbxm0++iV5Ojifv+syvvlHEVvZMIsKwCT4gpotq
 /LzZddp9GkFI+maL0d7A6LiMOh6y7kk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-p9gD2Qf3OKaX0wpaa_A7qQ-1; Fri,
 15 Nov 2024 09:12:14 -0500
X-MC-Unique: p9gD2Qf3OKaX0wpaa_A7qQ-1
X-Mimecast-MFC-AGG-ID: p9gD2Qf3OKaX0wpaa_A7qQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02177195609E; Fri, 15 Nov 2024 14:12:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.97])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6357B1956054; Fri, 15 Nov 2024 14:12:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
Date: Fri, 15 Nov 2024 15:12:02 +0100
Message-ID: <20241115141202.1877294-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While adding the new flexible boot order feature on s390x recently,
we missed to add the "loadparm" property to the scsi-hd and scsi-cd
devices. This property is required on s390x to pass the information
to the boot loader about which kernel should be started or whether
the boot menu should be shown. But even more serious: The missing
property is now causing trouble with the corresponding libvirt patches
that assume that the "loadparm" property is either settable for all
bootable devices (when the "boot order" feature is implemented in
QEMU), or none (meaning the behaviour of older QEMUs that only allowed
one "loadparm" at the machine level). To fix this broken situation,
let's implement the "loadparm" property in for the SCSI devices, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Only add the property when running with the s390x target 
   (checked via the arch_type variable during runtime)
 - Check bootindex property before setting the loadparm property
 - Call the sanitize function before setting the property, so we
   can now immediately reject bad properties for the scsi devices,
   too (had to move the sanitize function to the common code in
   qdev-properties-system.c for this)

 include/hw/qdev-properties-system.h |  3 ++
 hw/core/qdev-properties-system.c    | 26 +++++++++++++++++
 hw/s390x/ipl.c                      | 19 ++++---------
 hw/scsi/scsi-disk.c                 | 43 +++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 13 deletions(-)

diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index cdcc63056e..7ec37f6316 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -3,6 +3,9 @@
 
 #include "hw/qdev-properties.h"
 
+bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
+                                       Error **errp);
+
 extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 35deef05f3..a61c5ee6dd 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -58,6 +58,32 @@ static bool check_prop_still_unset(Object *obj, const char *name,
     return false;
 }
 
+bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
+                                       Error **errp)
+{
+    int i, len;
+
+    len = strlen(str);
+    if (len > 8) {
+        error_setg(errp, "'loadparm' can only contain up to 8 characters");
+        return false;
+    }
+
+    for (i = 0; i < len; i++) {
+        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
+
+        if (qemu_isalnum(c) || c == '.' || c == ' ') {
+            loadparm[i] = c;
+        } else {
+            error_setg(errp,
+                       "invalid character in 'loadparm': '%c' (ASCII 0x%02x)",
+                       c, c);
+            return false;
+        }
+    }
+
+    return true;
+}
 
 /* --- drive --- */
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index dc02b0fdda..30734661ad 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -418,21 +418,9 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
 
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
 {
-    int i;
-
     /* Initialize the loadparm with spaces */
     memset(loadparm, ' ', LOADPARM_LEN);
-    for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
-        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
-
-        if (qemu_isalnum(c) || c == '.' || c == ' ') {
-            loadparm[i] = c;
-        } else {
-            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
-                       c, c);
-            return;
-        }
-    }
+    qdev_prop_sanitize_s390x_loadparm(loadparm, str, errp);
 }
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
@@ -452,6 +440,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     SCSIDevice *sd;
     int devtype;
     uint8_t *lp;
+    g_autofree void *scsi_lp = NULL;
 
     /*
      * Currently allow IPL only from CCW devices.
@@ -463,6 +452,10 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
+            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
+            if (scsi_lp && strlen(scsi_lp) > 0) {
+                lp = scsi_lp;
+            }
             iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index cb222da7a5..8e553487d5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -32,6 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
+#include "sysemu/arch_init.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
@@ -111,6 +112,7 @@ struct SCSIDiskState {
     char *vendor;
     char *product;
     char *device_id;
+    char *loadparm;     /* only for s390x */
     bool tray_open;
     bool tray_locked;
     /*
@@ -3135,6 +3137,43 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
     return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
 }
 
+static char *scsi_property_get_loadparm(Object *obj, Error **errp)
+{
+    return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
+}
+
+static void scsi_property_set_loadparm(Object *obj, const char *value,
+                                       Error **errp)
+{
+    void *lp_str;
+
+    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
+        error_setg(errp, "'loadparm' is only valid for boot devices");
+        return;
+    }
+
+    lp_str = g_malloc0(strlen(value));
+    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
+        g_free(lp_str);
+        return;
+    }
+    SCSI_DISK_BASE(obj)->loadparm = lp_str;
+}
+
+static void scsi_property_add_specifics(DeviceClass *dc)
+{
+    ObjectClass *oc = OBJECT_CLASS(dc);
+
+    /* The loadparm property is only supported on s390x */
+    if (arch_type & QEMU_ARCH_S390X) {
+        object_class_property_add_str(oc, "loadparm",
+                                      scsi_property_get_loadparm,
+                                      scsi_property_set_loadparm);
+        object_class_property_set_description(oc, "loadparm",
+                                              "load parameter (s390x only)");
+    }
+}
+
 static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -3218,6 +3257,8 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
     dc->desc = "virtual SCSI disk";
     device_class_set_props(dc, scsi_hd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
+
+    scsi_property_add_specifics(dc);
 }
 
 static const TypeInfo scsi_hd_info = {
@@ -3258,6 +3299,8 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
     dc->desc = "virtual SCSI CD-ROM";
     device_class_set_props(dc, scsi_cd_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
+
+    scsi_property_add_specifics(dc);
 }
 
 static const TypeInfo scsi_cd_info = {
-- 
2.47.0



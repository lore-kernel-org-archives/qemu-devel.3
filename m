Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E54D65C49
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBYye-0005FZ-A2; Thu, 14 Nov 2024 07:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBYyc-0005F7-L2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBYya-0000UD-Fx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731587370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3TH6mDnXUqAuws1+l4fGU4hpm3/dP/un2yTL87oPv1I=;
 b=gc6ANNh4fgRZrSUatLt/GnXD6c/kkZbQ+guxDIocGhz84gqQDU62xyA6wkQrfUff+1lQ8c
 ZnSwtegp1QXyqfgpH5P7VYrTdTFvQO/5m7xuO0dPP7yS5f7mBGtlwFcZpqIU1JS3oZ/bf9
 TP5pzmQYEP0U5GcQmn9TNf4J5fKq0FY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-xvEoNnGpMu-4Lw60RJryRQ-1; Thu,
 14 Nov 2024 07:29:27 -0500
X-MC-Unique: xvEoNnGpMu-4Lw60RJryRQ-1
X-Mimecast-MFC-AGG-ID: xvEoNnGpMu-4Lw60RJryRQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B63E61955E8D; Thu, 14 Nov 2024 12:29:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D0601956089; Thu, 14 Nov 2024 12:29:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH] hw: Add "loadparm" property to scsi disk devices for booting
 on s390x
Date: Thu, 14 Nov 2024 13:29:19 +0100
Message-ID: <20241114122919.973930-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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
let's implement the "loadparm" property for the SCSI devices, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 NB: Unlike the ccw_device_set_loadparm() logic that we use for CCW
     devices, I've decided to use a string property for the "loadparm"
     in the SCSI devices to avoid spoiling the common code with too much
     s390x logic. So the check for valid characters is now done after the
     property has been set, i.e. we only print out an error instead of
     forbidding the setting (like we do it with the CCW devices), which
     is IMHO still perfectly acceptable. Or are there other opinions?

 hw/s390x/ipl.c      | 22 +++++++++++++++++++---
 hw/scsi/scsi-disk.c |  2 ++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index dc02b0fdda..c902b562cb 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -416,12 +416,10 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
     return chain_addr;
 }
 
-void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
+static void s390_sanitize_loadparm(uint8_t *loadparm, char *str, Error **errp)
 {
     int i;
 
-    /* Initialize the loadparm with spaces */
-    memset(loadparm, ' ', LOADPARM_LEN);
     for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
         uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
 
@@ -435,6 +433,13 @@ void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
     }
 }
 
+void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
+{
+    /* Initialize the loadparm with spaces */
+    memset(loadparm, ' ', LOADPARM_LEN);
+    s390_sanitize_loadparm(loadparm, str, errp);
+}
+
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
 {
     int i;
@@ -452,6 +457,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     SCSIDevice *sd;
     int devtype;
     uint8_t *lp;
+    g_autofree void *scsi_lp = NULL;
 
     /*
      * Currently allow IPL only from CCW devices.
@@ -463,6 +469,16 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
+            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
+            if (scsi_lp && strlen(scsi_lp) > 0) {
+                Error *errp = NULL;
+                s390_sanitize_loadparm(scsi_lp, scsi_lp, &errp);
+                if (errp) {
+                    error_report_err(errp);
+                } else {
+                    lp = scsi_lp;
+                }
+            }
             iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index cb222da7a5..c1fa02883d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -111,6 +111,7 @@ struct SCSIDiskState {
     char *vendor;
     char *product;
     char *device_id;
+    char *loadparm;
     bool tray_open;
     bool tray_locked;
     /*
@@ -3165,6 +3166,7 @@ static const TypeInfo scsi_disk_base_info = {
     DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),                \
     DEFINE_PROP_STRING("product", SCSIDiskState, product),              \
     DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id),          \
+    DEFINE_PROP_STRING("loadparm", SCSIDiskState, loadparm),            \
     DEFINE_PROP_BOOL("migrate-emulated-scsi-request", SCSIDiskState, migrate_emulated_scsi_request, true)
 
 
-- 
2.47.0



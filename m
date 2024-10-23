Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DC8CF538A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFX-000716-1K; Wed, 23 Oct 2024 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFP-0006Pc-6I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFN-0002D4-7H
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBZV9fF5UzB1z18c6ueAP5BGjy15RQl8nQiHpuOeUfs=;
 b=TxrbtG5b4BDVvtP9m4kFjm/u7neiZYQxSp10EKaHwzrX/rwCRHGC6E+0l/OszmJVU5/ECz
 c/OiVrfKO51QlRd1i21xLhD46JgJQEU4/uudr7oiTLsRFGodQC95n/pBL/JEMK2Ap72BY6
 vZtlCTAvkhA5QrSOI19n4l0dU5FhkSU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-ITcsrr_7OzCV8X76YPfV3Q-1; Wed,
 23 Oct 2024 09:17:54 -0400
X-MC-Unique: ITcsrr_7OzCV8X76YPfV3Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 709D3194510F; Wed, 23 Oct 2024 13:17:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2A7119560AE; Wed, 23 Oct 2024 13:17:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 15/23] hw/s390x: Build an IPLB for each boot device
Date: Wed, 23 Oct 2024 15:17:02 +0200
Message-ID: <20241023131710.906748-16-thuth@redhat.com>
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

Build an IPLB for any device with a bootindex (up to a maximum of 8 devices).

The IPLB chain is placed immediately before the BIOS in memory. Because this
is not a fixed address, the location of the next IPLB and number of remaining
boot devices is stored in the QIPL global variable for possible later access by
the guest during IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241020012953.1380075-16-jrossi@linux.ibm.com>
[thuth: Fix endianness problem when accessing the qipl structure]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.h              |   1 +
 include/hw/s390x/ipl/qipl.h |   4 +-
 hw/s390x/ipl.c              | 129 ++++++++++++++++++++++++++++--------
 3 files changed, 105 insertions(+), 29 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b670bad551..54eb48fd6e 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -20,6 +20,7 @@
 #include "qom/object.h"
 
 #define DIAG308_FLAGS_LP_VALID 0x80
+#define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
 
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index b67d2ae061..1da4f75aa8 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -32,7 +32,9 @@ struct QemuIplParameters {
     uint8_t  reserved1[3];
     uint64_t reserved2;
     uint32_t boot_menu_timeout;
-    uint8_t  reserved3[12];
+    uint8_t  reserved3[2];
+    uint16_t chain_len;
+    uint64_t next_iplb;
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 656996b500..b9d741d0b0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -56,6 +56,13 @@ static bool iplb_extended_needed(void *opaque)
     return ipl->iplbext_migration;
 }
 
+/* Place the IPLB chain immediately before the BIOS in memory */
+static uint64_t find_iplb_chain_addr(uint64_t bios_addr, uint16_t count)
+{
+    return (bios_addr & TARGET_PAGE_MASK)
+            - (count * sizeof(IplParameterBlock));
+}
+
 static const VMStateDescription vmstate_iplb_extended = {
     .name = "ipl/iplb_extended",
     .version_id = 0,
@@ -398,6 +405,17 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
     return ccw_dev;
 }
 
+static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
+{
+    S390IPLState *ipl = get_ipl_device();
+    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
+    uint64_t len = sizeof(IplParameterBlock) * count;
+    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
+
+    cpu_physical_memory_write(chain_addr, iplb_chain, len);
+    return chain_addr;
+}
+
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
 {
     int i;
@@ -428,54 +446,51 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
     }
 }
 
-static bool s390_gen_initial_iplb(S390IPLState *ipl)
+static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
-    DeviceState *dev_st;
+    S390IPLState *ipl = get_ipl_device();
     CcwDevice *ccw_dev = NULL;
     SCSIDevice *sd;
     int devtype;
     uint8_t *lp;
 
-    dev_st = get_boot_device(0);
-    if (dev_st) {
-        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
-    }
-
     /*
      * Currently allow IPL only from CCW devices.
      */
+    ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
         lp = ccw_dev->loadparm;
 
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
             sd = SCSI_DEVICE(dev_st);
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
-            ipl->iplb.blk0_len =
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
+            iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_QEMU_SCSI;
-            ipl->iplb.scsi.lun = cpu_to_be32(sd->lun);
-            ipl->iplb.scsi.target = cpu_to_be16(sd->id);
-            ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
-            ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
+            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
+            iplb->scsi.lun = cpu_to_be32(sd->lun);
+            iplb->scsi.target = cpu_to_be16(sd->id);
+            iplb->scsi.channel = cpu_to_be16(sd->channel);
+            iplb->scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VFIO:
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
-            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->pbt = S390_IPL_TYPE_CCW;
+            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
+            /* The S390IPLState netboot is true if ANY IPLB may use netboot */
             ipl->netboot = true;
             /* Fall through to CCW_DEVTYPE_VIRTIO case */
         case CCW_DEVTYPE_VIRTIO:
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
-            ipl->iplb.blk0_len =
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
-            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            iplb->pbt = S390_IPL_TYPE_CCW;
+            iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         }
 
@@ -484,8 +499,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         }
 
-        s390_ipl_convert_loadparm((char *)lp, ipl->iplb.loadparm);
-        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
+        s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
+        iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
         return true;
     }
@@ -493,6 +508,62 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
     return false;
 }
 
+static bool s390_init_all_iplbs(S390IPLState *ipl)
+{
+    int iplb_num = 0;
+    IplParameterBlock iplb_chain[7];
+    DeviceState *dev_st = get_boot_device(0);
+    Object *machine = qdev_get_machine();
+
+    /*
+     * Parse the boot devices.  Generate an IPLB for only the first boot device
+     * which will later be set with DIAG308.
+     */
+    if (!dev_st) {
+        ipl->qipl.chain_len = 0;
+        return false;
+    }
+
+    /* If no machine loadparm was defined fill it with spaces */
+    if (memcmp(S390_CCW_MACHINE(machine)->loadparm, NO_LOADPARM, 8) == 0) {
+        object_property_set_str(machine, "loadparm", "        ", NULL);
+    }
+
+    iplb_num = 1;
+    s390_build_iplb(dev_st, &ipl->iplb);
+
+    /*  Index any fallback boot devices */
+    while (get_boot_device(iplb_num)) {
+        iplb_num++;
+    }
+
+    if (iplb_num > MAX_BOOT_DEVS) {
+        warn_report("Excess boot devices defined! %d boot devices found, "
+                    "but only the first %d will be considered.",
+                    iplb_num, MAX_BOOT_DEVS);
+
+        iplb_num = MAX_BOOT_DEVS;
+    }
+
+    ipl->qipl.chain_len = cpu_to_be16(iplb_num - 1);
+
+    /*
+     * Build fallback IPLBs for any boot devices above index 0, up to a
+     * maximum amount as defined in ipl.h
+     */
+    if (iplb_num > 1) {
+        /* Start at 1 because the IPLB for boot index 0 is not chained */
+        for (int i = 1; i < iplb_num; i++) {
+            dev_st = get_boot_device(i);
+            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
+        }
+
+        ipl->qipl.next_iplb = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain));
+    }
+
+    return iplb_num;
+}
+
 static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
                                          int virtio_id)
 {
@@ -620,7 +691,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
              * this is the original boot device's SCSI
              * so restore IPL parameter info from it
              */
-            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+            ipl->iplb_valid = s390_build_iplb(get_boot_device(0), &ipl->iplb);
         }
     }
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
@@ -714,7 +785,9 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
         if (!ipl->iplb_valid) {
-            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+            ipl->iplb_valid = s390_init_all_iplbs(ipl);
+        } else {
+            ipl->qipl.chain_len = 0;
         }
     }
     s390_ipl_set_boot_menu(ipl);
-- 
2.47.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C48D3E77D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTRDO-0004ka-W8; Wed, 10 Dec 2025 15:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDM-0004iE-2V; Wed, 10 Dec 2025 15:55:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vTRDK-0000iR-Do; Wed, 10 Dec 2025 15:55:11 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BACm22i018045;
 Wed, 10 Dec 2025 20:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CBtmBBLLfTNE/9f79
 6wDBJIpSmXUfFmfJQHxNvnhsmc=; b=cJp1IzljWVLWU2q46/mizDx2Qe6bKCPVJ
 LcIDlS35gcRV8WXVJwuZNZho3r8pbw/YvczSeV+Hn6zRJj/kInXV2MF3QPpmgJlW
 2yJdlVSvieHwDSV0gNkkCd2dJdqptLjqJ77JV7WAR+gYF3YApPxYCbUMV1oIitt7
 qw94WLrzc6PaTxIIVgdQZ4f7LfdCv2/N9eAp5iy2UT6NF7PPT06/dHVPc62UnMU8
 +un5HFn5iUMObMcaJ2o35cLebV9W0OAOdGwjpn2oK4UAmRQFR8Ext74QJHJqnX6x
 ymtvu7k/kKJuDeq4/6hY2wR1KugLmg7biJBylS5pKSe/7Q+8hd4eQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawvc09h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAK8adl012443;
 Wed, 10 Dec 2025 20:55:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ak2r29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 20:55:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BAKt6ia16843408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Dec 2025 20:55:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E043758056;
 Wed, 10 Dec 2025 20:55:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB7158052;
 Wed, 10 Dec 2025 20:55:06 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.53.32])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Dec 2025 20:55:06 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 09/10] hw: Add "loadparm" property to PCI devices for booting
 on s390x
Date: Wed, 10 Dec 2025 15:54:48 -0500
Message-ID: <20251210205449.2783111-10-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251210205449.2783111-1-jrossi@linux.ibm.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h2E3c_Q3lrS8mjCKn9j8dRGnHbgqOId1
X-Proofpoint-ORIG-GUID: h2E3c_Q3lrS8mjCKn9j8dRGnHbgqOId1
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=6939de2c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=vmHGOmvCPtFvCN_kkgEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfX6swBB76UubV2
 OyUSdXJ5CTavTbJgM+t6kFDOnlad3me3JDxTQGIfwNIbDW5dfcLzBn1uf/GxAAMhQcsOS7jtu/4
 nmn4d3zQMHLOSxUTsCD2QCKCpL5XOu0Cq0dnfxL6AciHg23o9kfSj1nG0Tlt61CtBXyk7hWTQiW
 HLKDrZgzOs4HOqbB0xaNh6CBrJb/tiSbykN9VMckp6vAGGF51C00joRgUTVlztkAXioIzjTOzKr
 zM+PuY8s88COGe1RecmTb3RtChGuur3yVhAeTwamvlzZJpEzsGwYyzt7iJVJIjkhwVccRATTlNz
 rUIv0WJrqrqTHmmtRqFKxk0ijUD+R7mCgnGSqYNVZ+W+Izd7BTs2B7WmryTXjv/ba2YeBb6WwZ3
 nMkQ6Ku1g/v0MiU+67xHG5EWByH9JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The loadparm is required on s390x to pass the information to the boot loader
such as which kernel should be started or whether the boot menu should be shown.

Because PCI devices do not naturally allocate space for this, the property is
added on an architecture specific basis.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/pci/pci_device.h |  3 +++
 hw/pci/pci.c                | 39 +++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.c              | 11 +++++++++--
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea5011..5cac6e1688 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -62,6 +62,9 @@ struct PCIDevice {
     bool partially_hotplugged;
     bool enabled;
 
+    /* only for s390x */
+    char *loadparm;
+
     /* PCI config space */
     uint8_t *config;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b1eba348e0..1ea0d7c54c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,6 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
+#include "system/arch_init.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -2825,6 +2826,43 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
     return rc;
 }
 
+static char *pci_qdev_property_get_loadparm(Object *obj, Error **errp)
+{
+    return g_strdup(PCI_DEVICE(obj)->loadparm);
+}
+
+static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
+                                       Error **errp)
+{
+    void *lp_str;
+
+    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
+        error_setg(errp, "'loadparm' is only valid for boot devices");
+        return;
+    }
+
+    lp_str = g_malloc0(strlen(value) + 1);
+    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
+        g_free(lp_str);
+        return;
+    }
+    PCI_DEVICE(obj)->loadparm = lp_str;
+}
+
+static void pci_qdev_property_add_specifics(DeviceClass *dc)
+{
+    ObjectClass *oc = OBJECT_CLASS(dc);
+
+    /* The loadparm property is only supported on s390x */
+    if (qemu_arch_available(QEMU_ARCH_S390X)) {
+        object_class_property_add_str(oc, "loadparm",
+                                      pci_qdev_property_get_loadparm,
+                                      pci_qdev_property_set_loadparm);
+        object_class_property_set_description(oc, "loadparm",
+                                              "load parameter (s390x only)");
+    }
+}
+
 MemoryRegion *pci_address_space(PCIDevice *dev)
 {
     return pci_get_bus(dev)->address_space_mem;
@@ -2843,6 +2881,7 @@ static void pci_device_class_init(ObjectClass *klass, const void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     device_class_set_props(k, pci_props);
+    pci_qdev_property_add_specifics(k);
     object_class_property_set_description(
         klass, "x-max-bounce-buffer-size",
         "Maximum buffer size allocated for bounce buffers used for mapped "
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index cf423ac764..57f5a7a204 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -460,6 +460,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     int devtype;
     uint8_t *lp;
     g_autofree void *scsi_lp = NULL;
+    g_autofree void *pci_lp = NULL;
 
     ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
@@ -512,6 +513,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 
     pbdev = s390_get_pci_device(dev_st, &devtype);
     if (pbdev) {
+        pci_lp = object_property_get_str(OBJECT(pbdev->pdev), "loadparm", NULL);
+        if (pci_lp && strlen(pci_lp) > 0) {
+            lp = pci_lp;
+        } else {
+            /* Use machine loadparm as a place holder if PCI LP is unset */
+            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
+        }
+
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = S390_IPLB_MIN_PCI_LEN;
@@ -522,8 +531,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             return false;
         }
 
-        /* Per-device loadparm not yet supported for non-ccw IPL */
-        lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
-- 
2.49.0



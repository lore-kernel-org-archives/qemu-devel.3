Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562E2C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7g-0007wd-7F; Wed, 26 Aug 2026 08:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7b-0007ry-FW; Wed, 26 Aug 2026 08:52:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7V-0002i7-CD; Wed, 26 Aug 2026 08:52:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW1pe3893756; Wed, 26 Aug 2026 12:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uH0dNJNktRtebbtBv
 uDlrdsnCdx1Uyoq8CvPxJde8DA=; b=ZneQvb4vJ1RRkCH1BCPmSFp0/fk9CLJK6
 PebqfmD7ppvy/dXQngX4XVA/70NX3JmSQtWI1YnyfqnXfG51N1nCkgJBQMeJ/y1C
 Hbv7t14Yz43yEb2S7Z06Vpa1SyHl8CoVHcudyiX+63/YQhkVQdvi6wb/t9oc53sI
 qVfOSxicaYzamhqY59btnycJhTldFoUVK2khiXVHv6e+lzELWNOyfJETUoVTzYgp
 FC6JjrAJeP/5io18Qy5oE/IUW40HkhrbDuxfE0UJsOvnuC5hm5Itrkh/ssDs7/DO
 s3ZeP1oS+wp1+6NhrVaeG2AYb9YNekahb8gZnxClXcY1xDaQwfbmw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hxsa0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfMMw019298;
 Wed, 26 Aug 2026 12:52:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9pxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqf6X11600204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 408355805E;
 Wed, 26 Aug 2026 12:52:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48DE25805B;
 Wed, 26 Aug 2026 12:52:40 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:40 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 20/37] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for
 certificate storage
Date: Wed, 26 Aug 2026 08:51:55 -0400
Message-ID: <20260826125213.1901252-21-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXxEqu/BPiFcPG
 xz6tyYXgehCXwP7IuLZniRJEKQiN+qX7dAKsE9c6u1nysJhRhVooN6joNOAb+5Ef1koncyuE4OX
 6HFhe25RTkdhohsJGA3eT4mI+kLnSsU=
X-Proofpoint-GUID: F-eqfSskbckM0mdUCIq_twZvcQEZHvjJ
X-Proofpoint-ORIG-GUID: F-eqfSskbckM0mdUCIq_twZvcQEZHvjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXwZLKSMw/uAtj
 +aLkEUjA31lkDGB0Swu9xIrjUsmGnTCoN9nPpsrae7L5QT8RZDGUQhjxcB2GaAkLdJ92UYB5e0a
 wlPYQV17yi/ysk2IoeX0NQjwa9TkF7EjZiKPYtzOMacciiclCws+UjHwKVOHKwFcvIMlKiVbCwL
 iUdxvdSMhQ+i5tSk/2Ov5jQw85Z/KdGuamXFWqHZwaogfyw2IAj1RXK+TJDc/rQmmZwrhoKqKL4
 /PWDtVORsLYk8/jNPyfseOe6fTQOOrjjCX5u5ftOqdnCGVYA3vUDNwPRgufVz6w6sWbbkqC/zZQ
 mjdeVrhUbWLN/jYslh80srSv9U/pjvVjWtMRhOJu7lmhLvaGUwcZVpTKIQi7B1SvHneqhzD71f2
 W9lgOBY9//lgTlkvCbQTItvsoPi5B/Cushiwnr4s6pej+MkG00OHbayfW1ShEMJtA2iNStO0vSm
 QDxivBYp+58kqZ82SqA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ee19b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6n7imOYxnT_JOqVJOMMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhuoying Cai <zycai@linux.ibm.com>

Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
the IPLB chain, regardless of the number of boot devices. This space
is also used to store certificates during secure boot, providing a
safe location for certificates until the kernel reads them during boot.

Rename next_iplb to ipl_data to better reflect its multiple purposes:
storing both IPLB chains and certificate data.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-19-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/ipl.c              | 18 ++++++++++++++----
 hw/s390x/ipl.h              |  2 --
 include/hw/s390x/ipl/qipl.h |  5 ++++-
 pc-bios/s390-ccw/iplb.h     |  4 ++--
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 627544b361..85fe2d3cb4 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -426,10 +426,9 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
     return pbdev;
 }
 
-static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
+static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain, uint16_t count)
 {
     S390IPLState *ipl = get_ipl_device();
-    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
     uint64_t len = sizeof(IplParameterBlock) * count;
     uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
 
@@ -593,7 +592,7 @@ void s390_rebuild_iplb(uint16_t dev_index, IplParameterBlock *iplb)
 static bool s390_init_all_iplbs(S390IPLState *ipl)
 {
     int iplb_num = 0;
-    IplParameterBlock iplb_chain[7];
+    IplParameterBlock iplb_chain[MAX_BOOT_DEVS - 1] = { 0 };
     DeviceState *dev_st = get_boot_device(0);
     Object *machine = qdev_get_machine();
 
@@ -639,13 +638,24 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
             dev_st = get_boot_device(i);
             s390_build_iplb(dev_st, &iplb_chain[i - 1]);
         }
+    }
 
-        ipl->qipl.next_iplb = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain));
+    /*
+     * Allocate maximum space for IPLB chain and/or certificate storage.
+     * Once a valid boot device is found, this space will be used to store
+     * certificates if secure boot is enabled.
+     */
+    if (iplb_num > 1 || s390_has_certificate()) {
+        ipl->qipl.ipl_data = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain,
+                                                                 MAX_BOOT_DEVS - 1));
     }
 
     return iplb_num;
 }
 
+QEMU_BUILD_BUG_MSG(sizeof(IplParameterBlock) * (MAX_BOOT_DEVS - 1) != CERT_BUF_SIZE,
+                   "certificate buffer size is wrong");
+
 static void update_machine_ipl_properties(IplParameterBlock *iplb)
 {
     Object *machine = qdev_get_machine();
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 5d54827b52..772566bb11 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -23,8 +23,6 @@
 #include "qom/object.h"
 #include "target/s390x/kvm/pv.h"
 
-#define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
-
 void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
 void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
 void s390_rebuild_iplb(uint16_t index, IplParameterBlock *iplb);
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6dccc74a9e..5d560a433a 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -43,7 +43,10 @@ typedef enum S390IplType S390IplType;
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 #define S390_IPLB_MAX_LEN 4096
 
+#define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
+
 #define MAX_CERTIFICATES  64
+#define CERT_BUF_SIZE     ((MAX_BOOT_DEVS - 1) * 4096)
 /* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
 #define VIRTIO_MAX_BLOCK_SIZE   4096
 #define MAX_COMP_ENTRIES        ((VIRTIO_MAX_BLOCK_SIZE - 32) / 32)
@@ -63,7 +66,7 @@ struct QemuIplParameters {
     uint32_t boot_menu_timeout;
     uint8_t  reserved3[2];
     uint16_t chain_len;
-    uint64_t next_iplb;
+    uint64_t ipl_data;
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index c92a3d0f0c..c807e7f49b 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -61,11 +61,11 @@ static inline bool load_next_iplb(void)
     }
 
     qipl.index++;
-    next_iplb = (IplParameterBlock *) qipl.next_iplb;
+    next_iplb = (IplParameterBlock *) qipl.ipl_data;
     memcpy(iplb, next_iplb, sizeof(IplParameterBlock));
 
     qipl.chain_len--;
-    qipl.next_iplb = qipl.next_iplb + sizeof(IplParameterBlock);
+    qipl.ipl_data = qipl.ipl_data + sizeof(IplParameterBlock);
 
     return true;
 }
-- 
2.55.0



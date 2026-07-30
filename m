Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE08C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYb1-0002eF-CB; Thu, 30 Jul 2026 17:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYaz-0002FG-2l; Thu, 30 Jul 2026 17:47:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYaw-0002Ox-SZ; Thu, 30 Jul 2026 17:47:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJmWTd2081879; Thu, 30 Jul 2026 21:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9f7X1d5IkR1JFdiB9
 Q1u2x1ED27BULMtuvevhCKjuog=; b=N9jD4KWqoHgkfst6Vcl7xx/nhViJ5TesQ
 PwFQy+xHbIinGMakUJAovgnvbus+Q3NMEpDOrA4ZuDT42NMcIV6l7aLntN1L31Qv
 dSku0BBhYoOPHVTd3EfOYty9/rjkkNlsHwoaDwoNFDOQrWzyL/XK0lbwjVBEmUev
 FUINEzLjCHrh3t7iQzhyu+7ddFdOlVVewBGXSe1yNoHovms4Y28/Zez8K/uDQBGu
 zpdOJ2aniPk6pROuaTXdc+55ez/5vOkyl3lrNzN/lilgKldAlMUs/TWdmEc9fZ4j
 FOhSXW0N4MbXQfFq4McjWiC33Kec8rC4o9j82M08VCiy91CBYVu6g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyct0c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfYIL003872;
 Thu, 30 Jul 2026 21:47:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yd1f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULl6CL27525792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 174345805F;
 Thu, 30 Jul 2026 21:47:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3537A58053;
 Thu, 30 Jul 2026 21:47:04 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:04 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 18/34] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for
 certificate storage
Date: Thu, 30 Jul 2026 17:46:07 -0400
Message-ID: <20260730214624.2328883-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O8k0hxD8oUrokxRyTcZsoHLe3o5Ct61V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX/vkSVO8kOTP8
 /D2uWIA+HhhV0QTnax3qvRLI5UmfjgC3SYCYqiQDKPDa18kmK3DwWmg/0HRkorq/FpolZfg9C3X
 gYcquDCSW6lWTXYPQtLdx6IKGLn9pA1WLByK+0G51wG/vjjexKjSNldjpYv2L8c698UjKNFvoff
 XgSH3IpbmRCI+qlCie8Xr4UHVUsKPOlkV3o+jfRXdudNRMt2yklZGag1DgVsCuzB5lfruMBEdjw
 AdspS7ZXrUMe4x7Nw1q815d4LnwoDxwijN6IfVwIuQsR8n9MoiEiRMOYaoazYAQehTmpKBY3tGi
 qlCRIqfbO/g3N85dM+wfuB3GLyJoCLrJbrZYLAeh5yPKJI7A6xwCbldwcDmN5p2dOctKd84p4EK
 J/Z375zNwbkuK41Qjnwh1sM2lSmfLp1J9I1vopR40Pa5gDbzlsC9+Wd6i3TmY/7y7momFdgl6HS
 oC6bAS8QqyBpG2mYG7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX8ANnqg09noBe
 8hgGq287mowB2NfdlXQ2mBkH/92lsdryW9PX3K794ZHT9yeotmIy5do18PRiEy0PEXwF1i+UsS9
 BlL0jSPdfoNYYsR1lGKtETPlRRf1HN8=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bc65c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6n7imOYxnT_JOqVJOMMA:9
X-Proofpoint-GUID: O8k0hxD8oUrokxRyTcZsoHLe3o5Ct61V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
the IPLB chain, regardless of the number of boot devices. This space
is also used to store certificates during secure boot, providing a
safe location for certificates until the kernel reads them during boot.

Rename next_iplb to ipl_data to better reflect its multiple purposes:
storing both IPLB chains and certificate data.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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
index 9807ef18f2..7b8a51452b 100644
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
index a2180719b1..37452faaa6 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -41,7 +41,10 @@ typedef enum S390IplType S390IplType;
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 #define S390_IPLB_MAX_LEN 4096
 
+#define MAX_BOOT_DEVS 8 /* Max number of devices that may have a bootindex */
+
 #define MAX_CERTIFICATES  64
+#define CERT_BUF_SIZE     ((MAX_BOOT_DEVS - 1) * 4096)
 /* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
 #define VIRTIO_MAX_BLOCK_SIZE   4096
 #define MAX_COMP_ENTRIES        ((VIRTIO_MAX_BLOCK_SIZE - 32) / 32)
@@ -61,7 +64,7 @@ struct QemuIplParameters {
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



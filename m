Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029BCC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfe-0000EX-0R; Thu, 02 Jul 2026 22:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfc-0000CC-A9; Thu, 02 Jul 2026 22:30:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfa-0003Wh-Ed; Thu, 02 Jul 2026 22:30:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631JQLp1203473; Fri, 3 Jul 2026 02:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=K4cV4tQztX3rMXVM3
 qHgimuLIVZevqtA0EpgMTOgA0I=; b=PkHFGZPS5GofXXR+5pGjzWdHEDrsv1kZJ
 ncrWo+CmpYRTj8ol1rhUwpA5ovzHeh07rzDgl/7JzCP49za3Tn5c29WAZlPHA86T
 +uBgp4LgdF3f9q0/OxCayIg2UxgQ6B+A+hdX7s0Tnr60g+OqnOPrMjtDJsMFVB4k
 kpcgSQRk163InB/UVnbmwddhThc8fq4PAEvjJjXpDbzHjqQIvVNNA4FztiObcKPw
 6aLc47op4rVcL0iuc65sIt5ZQ5Li/EnqoV0yatA3mhTKh4IS6I732d5pev2NY3KO
 7tCcHPKbHpEuA8SChW1raqdGFnSGVd1A41CpcSQOYkmMAh3IYYWrQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qacjud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632JhbB023659;
 Fri, 3 Jul 2026 02:30:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhppfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632UG0416057006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99F8558056;
 Fri,  3 Jul 2026 02:30:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90DCB58052;
 Fri,  3 Jul 2026 02:30:14 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:14 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 18/33] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for
 certificate storage
Date: Thu,  2 Jul 2026 22:29:16 -0400
Message-ID: <20260703022933.1805010-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX8k2g4VkXcbhd
 rObOt+gqi+rKvNC20qIya7VM6Egm/Cbh3ahc13j8m1HviwUjmkXCCJ5PaER6C2WMZjKZsmY1Ylf
 Z0cn/bGF9NTQjTQdEdjulEubyR3mrnSRJgkFY1KtS+zgyCRDRzvTgeyKM1XzgTcfwrgSsV3mmD2
 VgDDODFTm0XyUClfh7YoCNcqS9g3Gz842S9up16vPYq9K1NDoP2amyznvlzlwClQf3c9YI1zoVa
 zFfgWsGMBagASTzs+k7u69mVIC1T1sjtfAYn/s0LXkIv5ZhGcUqa+4kkc6ZgteAcWWH9DDUkoq8
 CNLsPdkvGjavoUKdOvBAOVp0Mc7OFcim81YJ7pL7GWVlFv7QFQFx7++Cbz/6uldjfUjJwjUojMj
 QXJNKwQtzc1iW5kb2/WHnQWDlSRxlNUGZ4wL9+44j4wNPbUdXe0wxPKlpyHCSV1WqE1SLjx9kdX
 uEwcC6lFQLgrqE3yymw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXzVyzaLfhLRlQ
 A3rDq2Mq1ZllgsdlATAaLptTHk0n+tN1aO/vjQjuMZ7XilfBSEGLyu4TMdYRurpTm4uxepckWfA
 43aAfdvCvq4bJwVUxB7tmBmUgQFf/fQ=
X-Proofpoint-GUID: COT2OeBsR9we9uwO7kUiTw3nI7flSSE7
X-Proofpoint-ORIG-GUID: COT2OeBsR9we9uwO7kUiTw3nI7flSSE7
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a471ebb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=xj6Z2pgGhtYFzPFpXM4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
the IPLB chain, regardless of the number of boot devices. This space
is also used to store certificates during secure boot, providing a
safe location for certificates until the kernel reads them during boot.

Rename next_iplb to ipl_data to better reflect its multiple purposes:
storing both IPLB chains and certificate data.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c              | 17 +++++++++++++----
 include/hw/s390x/ipl/qipl.h |  3 ++-
 pc-bios/s390-ccw/iplb.h     |  4 ++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index f9f14d7b67..af89005790 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -425,10 +425,9 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
     return pbdev;
 }
 
-static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
+static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain, uint16_t count)
 {
     S390IPLState *ipl = get_ipl_device();
-    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
     uint64_t len = sizeof(IplParameterBlock) * count;
     uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
 
@@ -592,7 +591,7 @@ void s390_rebuild_iplb(uint16_t dev_index, IplParameterBlock *iplb)
 static bool s390_init_all_iplbs(S390IPLState *ipl)
 {
     int iplb_num = 0;
-    IplParameterBlock iplb_chain[7];
+    IplParameterBlock iplb_chain[MAX_BOOT_DEVS - 1] = { 0 };
     DeviceState *dev_st = get_boot_device(0);
     Object *machine = qdev_get_machine();
 
@@ -638,12 +637,22 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
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
 
 static void update_machine_ipl_properties(IplParameterBlock *iplb)
 {
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index a2180719b1..58329fb5bc 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -42,6 +42,7 @@ typedef enum S390IplType S390IplType;
 #define S390_IPLB_MAX_LEN 4096
 
 #define MAX_CERTIFICATES  64
+#define CERT_BUF_SIZE     (7 * 4096)
 /* largest supported block size - same as VIRTIO_DASD_DEFAULT_BLOCK_SIZE */
 #define VIRTIO_MAX_BLOCK_SIZE   4096
 #define MAX_COMP_ENTRIES        ((VIRTIO_MAX_BLOCK_SIZE - 32) / 32)
@@ -61,7 +62,7 @@ struct QemuIplParameters {
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
2.54.0



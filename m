Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE4AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHO-0001BK-8R; Fri, 03 Jul 2026 13:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGo-0007wJ-Q5; Fri, 03 Jul 2026 13:01:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGn-0003I9-08; Fri, 03 Jul 2026 13:01:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJC8C3237374; Fri, 3 Jul 2026 17:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ctJOhT22+/282MyIP
 iIB02l71QB2ubOQvkaLw2y81eg=; b=kHnSHv+PSHSfkIQ/wfQHEvMTaoiYJquuG
 DnLDpvHHPZpSPOPSpGzYBN7N0CzrFKlWw5/rjJn5nLcDqSJ2GteVntvnys7IWZLH
 wsS1yTl5KWvvcjKuI6q8O6wi/ZNm3FIPBukKjkmaP1ufukYviquDXeYjrP8VyRDf
 HsmmaiAoKbqCIvad4UeLWUy8o1P0wA1m9vZMqy9pNAunIEdn003LSKFdsxXV2smt
 yjbTkp6Lvi3WEtFQPlOy8OLFIs9nMWVx3mNMmW91xUwoRFe2sHYw1MdWCtoeTqbU
 cKKMTh4h65LdiwSw2EEmBBkNKllq09WX8X9ixsX0V18N2L10IaYew==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffmfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnlNv031533;
 Fri, 3 Jul 2026 17:01:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhysgbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1YsD24969864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4143A58064;
 Fri,  3 Jul 2026 17:01:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B8EE5805D;
 Fri,  3 Jul 2026 17:01:31 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:31 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 18/33] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain for
 certificate storage
Date: Fri,  3 Jul 2026 13:00:15 -0400
Message-ID: <20260703170032.1893204-19-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47eaf0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=6n7imOYxnT_JOqVJOMMA:9
X-Proofpoint-ORIG-GUID: CXjJoy4biltOPI-mkJ0Yk7xUH5EsQRTM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX+KSnlbGa9KdB
 SsOf726yvfdTMcbFdX02CV4WQnnrm3jeheBe3dF9p2Kmh82onpBxknt7KJLUFn8z5LYaiwpx40h
 zIRNIlN7S6UP+g4zJf0jzWTQaICzi+3rO3ciRSofIMjv+T4x9+r5PXgHufQSdDv1I1jsXnKN+jD
 G/ssjfUUjkKPWjUnhgFIndybqHFU5Hrw9P39uCve5FxeoDpMRi8skG0Bji8CbU9cD4BCHKbXvWk
 Eq96MHkS2LLXAJvfrg2xi5QyzdtKslCajqkcweKnnRrro7pQ9+ugJooStR0Dnr+ua/gufVEvubL
 quvOJybNVAD8VX+ORcgf5rpXT+nj2rcREyAZxYTmN8TcAae3I0/jzGosNLfQhCrWTol4gG4GnYF
 WA1X7H8P0ClKvyEgJx8TyIy9WQeEL9/FMG0uD1a1SEvSH60ulmbgX1JCRK7xWnDOkydkaWDHo3c
 2PoKMGtTbMmi+ENJDeg==
X-Proofpoint-GUID: CXjJoy4biltOPI-mkJ0Yk7xUH5EsQRTM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX68o5tRa4TG3e
 PAtzpfoRAsZImhUYSHrzuSyXCCbEBQivbi80Uvk0YettqH7s9PgehVWuBmvxE7KdxGGp5BNVdI/
 GGlte0E8glJ+BrfrX+pAqeAPI84pmT8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
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
Reviewed-by: Eric Farman <farman@linux.ibm.com>
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



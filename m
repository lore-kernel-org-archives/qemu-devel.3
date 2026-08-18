Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B80DC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNZP-0007Xv-4M; Tue, 18 Aug 2026 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZM-0007UG-RP; Tue, 18 Aug 2026 13:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZK-00036q-Op; Tue, 18 Aug 2026 13:25:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3a4R542384; Tue, 18 Aug 2026 17:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WLxc1FOuIMW3EPGme
 VmrblYH7wqFB83B4nxX2Uu4RMc=; b=sxfhZNSluSMVBvGXQkQEoOd5ev/ylA91U
 n/izp0Zf2hnFR+fKVcb+tKqeeeudmTK7lMtBAM1ejdhqe+INq0kjM+AoyeRdGgPv
 JubofsOC2p6hlebo2m2j4NQL1crP8ZypuzRQ+0vIUQa5dqbNxp5ETLYnc6xPaTHY
 MJzvip2vjEMZGf3968oOI2x81A5T+lwuUDOmNIiUni3YIZwO262juz0HgcUr4eYS
 LBvm2c3yU/hHcoM5Om6mcBioJfUFQX6Kkac8QNAGswmFcsMr5mCgbZYAbtePoHPb
 JAQS/ZILm5G2XDNZMP5JdgMuFKw7xaxGEePCX3JTLI9qOwkGjRw3A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt9697-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDk7W032296;
 Tue, 18 Aug 2026 17:25:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw4k1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHPfM642992082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:25:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 066265805E;
 Tue, 18 Aug 2026 17:25:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A41958058;
 Tue, 18 Aug 2026 17:25:40 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:25:40 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v7 12/15] s390x/pci: Move max_dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Tue, 18 Aug 2026 12:25:18 -0500
Message-Id: <20260818172521.223460-13-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818172521.223460-1-kshk@linux.ibm.com>
References: <20260818172521.223460-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a849597 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=YlvBUofuDPas7G3Xl8cA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX7Gyc+Dq5EmB4
 d5NR7STu3eTvELQLFZZJ635l3HsKNO+Q3m66NVXNf65Ge5SrTCbOVoSgwE8E67XGj2/D7FcpyN7
 V+kZyvtWZAJne+nzI54KR/1vrXkoICc=
X-Proofpoint-GUID: q0VaFx3RavmMw1P4gNxicGIT9btMUVmF
X-Proofpoint-ORIG-GUID: q0VaFx3RavmMw1P4gNxicGIT9btMUVmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX/IXpmTG3SVnk
 iEUPkrkSjJn9f5XAVAinSfg/A+gop0pdEKpYgbf30PsLac7WWCztm+kifJV/D6WXpLMyaIDay3U
 7pLq3z9WHtaH1Z1XrwNvAAqL21RgN4kBKFXoTAwgP/Pkv1Bx8OGtkf6mNWAZwcYObOONZawvi4h
 HMy9B/cS/bGo+CjmlFm8cEwiGTeIAmsokCLNH9FnisszwPTxZxuOjXFbJzREX+nPi1WuNFIXP4X
 i2Mh0XWSx8zGjCMUe4aih1VQckPEftlxbvhNVhQDVYKtpfIs5NBXONIIOnxAICktbt1yM08+xAe
 sbfytDAaI9Yu+feC3eTEGkDHXeFS1wyDYWsZoAy39A32Wp3WmFlYkcBo+uO/4t7FO4AU9Fornu5
 owlLaUQ0iaM3RET+YklIX+hwAKnGnDsm2n4FzJhBz0Pj79WarEThaJl9r7ztB0aDBGGG9jcUTA4
 Hvo10VB4z/zBByRIwQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
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

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify S390PCIIOMMU which purpose is just to store the "root"
AddressSpace.

This also allows to save/restore this field during migration.

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-vfio.c        | 4 ++--
 include/hw/s390x/s390-pci-bus.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index db6de00bd2..a035ba5b2c 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -90,7 +90,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
     cnt->users = 1;
     cnt->avail = avail;
     QTAILQ_INSERT_TAIL(&s->zpci_dma_limit, cnt, link);
-    pbdev->iommu->max_dma_limit = avail;
+    pbdev->max_dma_limit = avail;
     return cnt;
 }
 
@@ -152,7 +152,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
      * to request that the guest free DMA mappings as necessary.
      */
     if (!pbdev->rtr_avail) {
-        vfio_size = pbdev->iommu->max_dma_limit << qemu_target_page_bits();
+        vfio_size = pbdev->max_dma_limit << qemu_target_page_bits();
         if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
             pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
         }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 1f5d8d4bd4..e3cbee2695 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t max_dma_limit;
 };
 
 typedef struct S390PCIIOMMUTable {
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
+    uint64_t max_dma_limit;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1



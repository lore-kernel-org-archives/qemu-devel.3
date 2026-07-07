Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C99C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzuQ-0005pM-RZ; Tue, 07 Jul 2026 03:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuE-0005jo-UZ; Tue, 07 Jul 2026 03:07:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuC-000354-2Z; Tue, 07 Jul 2026 03:07:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IgGw2519653; Tue, 7 Jul 2026 07:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VCNQc5yPgk/JWRoUp
 JHqi3LfZXwhuksR+bEhTHaAwzM=; b=P6Z1CwTaE0g0gAs80M9TRfCy5RChEhmv0
 hIZljyGazvI/lCfDWom4hXNOyVLmh++B1hoffHIhPDkvk9ud/1B+CVY1q0dGqdhQ
 ftZGIpHBVHjB04Eblh2ym1ZW66w60thZdr7cx6zkT5DH2ioNm66BCGFA0Jdlf961
 lapLQ55AN9KzyaCpJq7VTl6EHX6xq7+ijrOQGIZfLWCddlAToHgDHQCdX1r3+t95
 nYce9WCqergownFjBRdeqXb8OBxQDozub1W0qGau4owzxAKIK96Hl5+RkiYZpcOP
 zYvHDy+0aQ4yodMEVGr+ZyHwUP6dTbY+e2P1ixul+bhHWgjuMJfZg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkndjgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6676ngZW023410;
 Tue, 7 Jul 2026 07:07:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq1n7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667773O530737102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 07:07:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E81F58059;
 Tue,  7 Jul 2026 07:07:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47CD058057;
 Tue,  7 Jul 2026 07:07:35 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 07:07:35 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, qemu-stable@nongnu.org,
 Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v2 2/5] s390x/pci: Tighten region detection for BAR read/write
Date: Tue,  7 Jul 2026 09:07:25 +0200
Message-ID: <20260707070728.147203-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707070728.147203-1-borntraeger@linux.ibm.com>
References: <20260707070728.147203-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4ca5bc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=1miPxOOkSzPv5N0FEC4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 4Nc5DBQkR0t-V6mWrW_pdquq5cpYDqhz
X-Proofpoint-ORIG-GUID: 4Nc5DBQkR0t-V6mWrW_pdquq5cpYDqhz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfXw3jEFQEEH/Ej
 82z6WFr6KIa0YpqOK2WNCVAfr72uEP11T8im5GAks4XT0zHfkzjMOeKWziCGb64npfv9yOptHYf
 sCYOUyFdt6f45rTTiUJfgip7Rq1lcBA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX8vsT44yk6xOl
 s0xM3tWQtO3JgKC2eVHs9+WUKqlxy34bP+YmP6Lg51w2HoyJYEI0Ej61JJRuRj006WehVlqExWe
 1lCY/HhdbI2ZEdatI/JHVd+8PngkQUOyS/xYvX5u+QSx76tJdEuLeen8K04cokJ12eU4cJ72CEg
 VLnHBS/YAnRqT/Q1XSPum0890WaM++M67QezH5TnT70iBUoSpq4LVidsjmOnGvGhwjV8i3Y+dVa
 caCFnaRufC77stFJO+WMMELSMyPwvwfxbXdh9C1d4peasTlCYSzZ/IawmeyG2rcEw1lIIw2ueJY
 BL1LHG6CgOjfWPB1kYrLTAnpMbIHql//0U0iD1uBVwNVztlCejV7dUx+/7G9Y7vdgEjljUWmTOD
 yIWQfbb85D66/OjmyJqyMnjg+0ctB1M9HDRzMOmmueNosGpPew0PagdOYEJ/fKmHinfr5kHzGFq
 n92okv0bUAMUmqjdFZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070064
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

For PCISTG/PCISTB/PCILG instruction emulation, ensure that the offset
and length provided by the guest does not overflow, and only return
a memory region when the specified offset+length combination matches
an existing subregion or the parent region.

Cc: qemu-stable@nongnu.org
Fixes: 4f6482bfe3 ("s390x/pci: search for subregion inside the BARs")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 10066ca618..ef20f7645e 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -392,13 +392,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
 static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
                                         uint8_t len)
 {
+    uint64_t last = offset + len;
     MemoryRegion *subregion;
     uint64_t subregion_size;
 
+    /*
+     * Ensure the region is valid, the calculated address cannot wrap and that
+     * it falls within this region.
+     */
+    if (!mr || offset > last || last > memory_region_size(mr)) {
+        return NULL;
+    }
+
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
         subregion_size = memory_region_size(subregion);
         if ((offset >= subregion->addr) &&
-            (offset + len) <= (subregion->addr + subregion_size)) {
+            (last) <= (subregion->addr + subregion_size)) {
             mr = subregion;
             break;
         }
@@ -413,6 +422,10 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
     offset -= mr->addr;
     return memory_region_dispatch_read(mr, offset, data,
                                        size_memop(len) | MO_BE,
@@ -513,6 +526,10 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
     offset -= mr->addr;
     return memory_region_dispatch_write(mr, offset, data,
                                         size_memop(len) | MO_BE,
@@ -900,6 +917,11 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return 0;
+    }
+
     offset -= mr->addr;
 
     for (i = 0; i < len; i += 8) {
-- 
2.53.0



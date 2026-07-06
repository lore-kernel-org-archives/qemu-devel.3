Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85344C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfWK-0005ex-Co; Mon, 06 Jul 2026 05:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW6-0005XX-A6; Mon, 06 Jul 2026 05:21:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW0-00062H-H7; Mon, 06 Jul 2026 05:21:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IV5F3134150; Mon, 6 Jul 2026 09:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0v/yIu6Ab9rKiu9ci
 l+k60ybrHOk1CXioCDN+6+85Ks=; b=MuWGqyOUjV26Z2xVXv262rv8U+MTBy0JU
 l1RCSHjLHckS8/QLKezvgmJRQIw1WnZ5tuslxDrd2nZhPy/RqPnSmPcYYgBl2Gd0
 UtY3jGNy3fn6DNtGgoOc48kcmhZoQg5Uw8jenB+9OwqkH3FEDyDcFsEV20YaMmti
 FKYW2s3egx8d/TyHEfQuQJEOSwtUBi8B6jFLEytOT8N80ZvpiAOjN4tWMulUkECO
 5bCdV1laS1PyQ1HDEKmOBixmnjuJX5jRTyFMHzS/ARyfQMMS12e/bIZJsqM1EiBA
 QeuqPb2L9VDf8bjwotWvJwcaTfggZdbyX0/BGaF/YJW5busk/NGdw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsh67f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669JhhE005757;
 Mon, 6 Jul 2026 09:21:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfvpnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669LIbx1376898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:21:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 665CD58060;
 Mon,  6 Jul 2026 09:21:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 229095805D;
 Mon,  6 Jul 2026 09:21:16 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:21:15 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
Subject: [PATCH 2/5] s390x/pci: Tighten region detection for BAR read/write
Date: Mon,  6 Jul 2026 11:19:06 +0200
Message-ID: <20260706091909.864405-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706091909.864405-1-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9CoSatzLjg4eQl6ZZcsV82w-qP5L99BW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX/iztJYaVBcg3
 d7GgkMJAU+T3/fcS9keqoKblsH2kGY+YM9V5lPnfLcL3uG7wGLGv7QrtTol7cP33Opgd/71yjtj
 5rCVvYmCxCI2tnUFX+0IVsNzfmqQHik=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b7390 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=1miPxOOkSzPv5N0FEC4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 9CoSatzLjg4eQl6ZZcsV82w-qP5L99BW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX2eWx0Pt6GpdL
 H7niOAYNVEh+W2Z/8kN4tx9z63U5UI3bzRnvJowMivpAaL07FnZpu6hZ2EU5FW7Ix+1FOpFWRCw
 pasM84AFyqkRqW4Ryzfd+mZiLARG3RxKcAqJMUk5f+Y/nERWOysTHmlyg6JHpj66O8H9E5MbQmN
 aOklqXqK/yxo664WtrKtjkmJSmJukoq4/nKXhOvqqbL9V4Q6XpdrjHceep8WGKgmBLZk7AgwD4u
 qWgOTGQREGSAnVYgFPxoiVZ7/z09Uoe9TW4/zJfTbdquCSnaiO10WMUwCccSiKjBLIeK7b+Di+s
 Mar9KktTRWdEql8odSrzQhCLJKfIfWT/2FqlHXZsf6LaVH61LbovYvQH0JPiJA/dgTE+cMzithE
 4BgY0qhy5Xc9nmSaoSoDyCyl9DJOqMa8PRPgcQ7o3FApox3JDzzUNEactjMgdelo9RVpvggWvsV
 W4KluwfdTd3muTGyA8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060094
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
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
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



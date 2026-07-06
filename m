Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B50DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfWF-0005bZ-QB; Mon, 06 Jul 2026 05:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW6-0005XY-AN; Mon, 06 Jul 2026 05:21:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgfW2-00062m-R4; Mon, 06 Jul 2026 05:21:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IeQp3151957; Mon, 6 Jul 2026 09:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wU6/MMjwjB0BkBCx1
 IfFQAJuEoWaRUMgU9dhKWG3AUM=; b=cBO/INllvkzI3oMnLHcL/ezcOBn+/mUmy
 tZYjhhMRdnX8PXZxjRWRNv8N6af/ombZFpCGfG2+pQCTuEMX7bY33soe3OEPZghM
 Y/wGtOeS8ZSiKmtOLQOI6nzMWgiTITmHJIYA/GXY2nMgD3DTIw3S9ESFfSitNaU5
 h/GfiaE2DX91atUKHR8GzYnAVAUERN+8kV8HchJJqr1RJlLvEkPweAHtAWvZo4Nx
 +DeXqByrumkJA2u6+CAxEtgidzgARMnJoZbQL5fUAJCnzpVlm0tkQnnK6IISLOJO
 DlslTDEMbuCp6J8tCsLEtZn5jpGeOaDs5Be5gVY2ibCTVXFbTsuEw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdhakk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669JaQ5023092;
 Mon, 6 Jul 2026 09:21:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvw2x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 09:21:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6669LLJm15597948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 09:21:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0387C5805F;
 Mon,  6 Jul 2026 09:21:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4F5E5805C;
 Mon,  6 Jul 2026 09:21:18 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 09:21:18 +0000 (GMT)
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
Subject: [PATCH 3/5] s390x/pci: Shrink RPCIT ranges to registered window
Date: Mon,  6 Jul 2026 11:19:07 +0200
Message-ID: <20260706091909.864405-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706091909.864405-1-borntraeger@linux.ibm.com>
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b7392 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=Ky1VarMbmfzgHUieTBwA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX2pasrzLcnqP2
 vF+NbNMWNbSliM3p8FVIzOYL9bzI3ohW7y8kmI+RJXzrWGW/08NjQBPtwTu7G3CBKWISsDSCc6+
 5xpF/LYyn26aWrRHdLF1xaVS8up81S0wllwUZzeHKJ5J8Ax+v/E61P1JO1lZFvhiZsz/IPbDHJD
 LM7VpPya5qYUIt5XpQZuiTO9xJ3RmvwxIjQoc6ubTDCa4x9qnRWjb57a0wqwpRhTXgpoSPyH5YR
 T0oyUYMKXwCACC45OvPsB6efMqXX1yYyP3NBpLfsP0TMfCJIxREWWGF1LTQRyqsfmDlTSRHSteW
 D/JqRsLLPBO8typodAR7qAYIKpcXYxe+zEimW3XWEfhq+R7RtVpaygWccDJC6S+qEk8z5yA05WV
 DFcJEK88Z90kcOHKphSxaKT26MtUEHKKeov+UZ4zJTN7kr0iEidQKQG24iEgVHXWiN5GW6/2Nbe
 H4gOk4NRZulaGHQaVuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX8ufeRTxpwAJk
 JMfjLeDjgoMLiKiVxa5lAvlBFZg7bzowqKzbkf2ojx+gEEBO25IDnLcZwRqNmvaz7xSwG1ZSB+w
 AjM6oDml+krsMgutE0t2LAE7gAqiDHs=
X-Proofpoint-GUID: km2QphYQS93sYXzaiQORMWG4oYVSVMoU
X-Proofpoint-ORIG-GUID: km2QphYQS93sYXzaiQORMWG4oYVSVMoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094
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

Today, if a RPCIT instruction is presented from the guest whose range
exceeds the previously-registered IOAT, QEMU will process the range
so long as 1) the specified range at least partially overlaps with
what was previously registered and 2) the guest has valid IOAT entries
in its table.  If the entries are not present (invalid), then the
RPCIT will unnecessarily spend time reporting the invalid
region/segment entries.

Optimize this path by exiting immediately if the requested range falls
completely outside of the previously-registered range or if the
requested range ends before it starts (which would only occur if the
guest-specified address + length would overflow a u64).  Otherwise,
clamp the request to only the portion of the range that overlaps with
what was previously registered, effectively ignoring the portion
outside of the registered range.

Cc: qemu-stable@nongnu.org
Fixes: 5d1abf2344 ("s390x/pci: enforce zPCI state checking")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index ef20f7645e..b7de23c7d2 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -770,10 +770,16 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < iommu->pba || start > iommu->pal) {
+    if (end < start || end < iommu->pba || start > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
+    /*
+     * If the specified range at least partially overlaps the registered
+     * aperture, clamp the request to the aperture and ignore the rest.
+     */
+    sstart = MAX(start, iommu->pba);
+    end = MIN(end, iommu->pal + 1);
 
  retry:
     start = sstart;
-- 
2.53.0



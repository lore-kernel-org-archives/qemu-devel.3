Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B26CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzuU-0005qL-0U; Tue, 07 Jul 2026 03:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuH-0005mi-6R; Tue, 07 Jul 2026 03:07:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wgzuF-00035N-Az; Tue, 07 Jul 2026 03:07:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IN9s1630176; Tue, 7 Jul 2026 07:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gvf5up2rYOcM5IMrC
 SMMJWwnrv6csRfNEoXe1bb9Qtg=; b=HdiNIpinQ5Xf8gR6+4Z3Rmwfp5DG69Ct1
 Vaed9IlK+9TN3fBQRZTXGamLQ+aZIYFcN8z0ceq/iN9w+i85UHlcq3I2ZHh7+zoe
 Ear91UewO1ESCUMWf1EWtA8w4VPUjeli0odV6ZEXbBLmBedQTzC34HsbQcd7Wz4v
 0fuXluYUGjImhfIK+I7BfCSYwzWGkljLog+RPJ+qcbdoKUPl2tDXW72oY/F4e+2w
 wc5WDsN+tcjOEJXrxq/v8DYx+Jcf/FEdbqWk8VmFYjo/HLyZXczsY+6mYsQvPOdr
 UJZ20WBViJtoD1+/Q/ZS79gZEpkLnM9l9VJL5EjW5+iWnlcsfzZCQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsp2sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774cIK014719;
 Tue, 7 Jul 2026 07:07:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y14dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 07:07:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66777dmB19333854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 07:07:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5E8858057;
 Tue,  7 Jul 2026 07:07:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFA1158058;
 Tue,  7 Jul 2026 07:07:37 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 07:07:37 +0000 (GMT)
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
Subject: [PATCH v2 3/5] s390x/pci: Shrink RPCIT ranges to registered window
Date: Tue,  7 Jul 2026 09:07:26 +0200
Message-ID: <20260707070728.147203-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707070728.147203-1-borntraeger@linux.ibm.com>
References: <20260707070728.147203-1-borntraeger@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aTClR1suHPujT_gVhEYEZQ9nczXXnwxa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfXycBXi0UqBClg
 RHxP8LlD/Ytb/5MYuw7Wz/2l8JxbOr1EKVG1KgB7MKIY7CjdKBik+K36zjNCsPjwAj5tHBDqSJj
 KvZi19YBmUpwOtM/ak9zIsjUa784IOA=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4ca5be cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=-R_Z6E-YhPHALp1CgG0A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: aTClR1suHPujT_gVhEYEZQ9nczXXnwxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2NCBTYWx0ZWRfX1+aM9COZBeJ2
 ugTNYhfvNwd2TiTfAPQFyn8hdzWHAlJqCJEMDemYin9RS4pQjaKjZNW0paFsD2f48z+KNthBGPz
 o2eRmE2Ly6bjv/i/bQDCsVNAoGiE8qHSfKX86UETD8bt2wIcZBHRN7R9+bpXxPj2Lh+gdHkSU1l
 3o9wPHjCPfRFq9nYJoZWdu/6B5IQmerS23QmtRuKRbPeJ/GUZ9BPuAPC474FkKvb7cwr6c+Q+v0
 bsk1+t5bNv/qhMn3brSVQd4PH1CX70eKhKi3aq+pegkWEBAJKf1rxtPIyXOCY6z4oXghvB1iifz
 s9jWycd2hN6wN44/clI2Focz5h2eP/8EBV1AqgTWzVs+7xqRasQZpkDmDsy4ERKsJa4jjQZ3iIN
 H5i4XOYof9D9RGVOrMN+4z8Cauw9KuvWbBRmvMtzCefbNHyUrRgDlDkNLjcd9rnrvrucHExRQwm
 wxl/0QfMA+pMF+YjNdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070064
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
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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



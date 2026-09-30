Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DAECA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwBE-0000Jy-Fx; Wed, 30 Sep 2026 11:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwBC-0000I9-5O; Wed, 30 Sep 2026 11:25:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwBA-000240-3s; Wed, 30 Sep 2026 11:25:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5pQG3167026; Wed, 30 Sep 2026 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UC5Wrz4cb+APVO1YR
 6QyOPoogUjb+dWaj+M3wgBMxHI=; b=D50DzZm02hVsthwQeQYTLNjdSqlpLiBnm
 yrlfcBPJt9ovWXrvBHZPmhU8mB9vbGg6OsSVfposKEn47hiuwKW7Ye6NfNgbcxth
 1H60k9sp18u9h/L3cACrSLmXccZbICdGOu4bdmzILzq20bvyh94SubbrSGG6X8lY
 TSrc7KnhGgU5RXDil02Ci8R7go6xha90++ojfJjVfoWq/CyM9VZpRpeex0O4aTqa
 SrvHyRPyNYOcNMI9DPxOGh51c9p6F7ly3XWZcqzt1tu+UGod1zssZOjvFsOECEOA
 eJaSEllmvajvgFcau8OxKw9FdradNOvCnXBkSYTG7hV857wkcPBmw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptcva3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEI1Vq3569533; Wed, 30 Sep 2026 15:24:36 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9n35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOYiv25428596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBE7358068;
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 549915805A;
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 22/23] s390x/pci: Reject apertures beyond IOAT capacity in
 translation mode
Date: Wed, 30 Sep 2026 11:24:19 -0400
Message-ID: <20260930152420.1956230-23-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f8dSWU0-53z9Z5Iye8EtRzlBjd_mR0O5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX+cqzTtqTM4v8
 FHmjooW3N0xIHqyQy1L0WRcrACRK/kH8E5+UG64PgIstlKnzUqbX6dBJrJs71qtAgHQ/WtAXOyv
 SYRrjdJQXb8gt6nxOQJD4LYMLiGvadXWjJNNYbXyNCxp6cgPjuSK6AkkB5W/4um3c2c18mB3vn9
 ipON27f2v9WJgsGfu7N7AtP72jyzDvZIjYLFwJolYpJo+rsg0IdRQufaKAMYXpfj6guBhJRN8jd
 Ld3BqakyJBD4vkyD7kdHSjaC04pdvft49ZbFa3gjFpJmDuf/1/juMl5aWy7hr/ZjUAN1r0anPrx
 VDAnbIoKKa7Xzbz33gb47yDATY+De8UqPGUt+QzkFBa0HQ0SUiz+/K8dxbBwuETj1NpmK4HoR0E
 Z9rNmt8xtFBAghCRo0jSDpid83CHO5Fp9P/Jx3Ks0VcmmaxYKu3zdh87NOYBpmC3xczilc9hFop
 ndudgvyMMHxS8dJRpkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX457J0bSwtgmo
 98Tlbsy7qxjXBFr/dh0lKNCNeoTdZ6aETkI6J+qbFjgEfWk6K2hKTNrmFt3OecpLVEfdts/QIpL
 9nzmhTqDwKEeNAmo+kgcuu3TZNh+i5A=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abd29b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=xSIT066dgqKBegNCQIUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: f8dSWU0-53z9Z5Iye8EtRzlBjd_mR0O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

In order to support direct mapping (which is only bound by the aperture
size of the underlying host EDMA reported via vfio) QEMU reports the
host-provided EDMA to the guest.  However, when using translation mode
QEMU only supports up to 4 TiB currently (the size of a single RT
table).

Reject attempts by a guest to register a translation aperture that
would exceed what QEMU can support by giving an operand exception on
the MPCIFC instruction that requested the large aperture.  This
restriction can be removed in the future if/when support for additional
IOAT regions is added.

Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929153012.774530-4-mjrosato@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c        | 15 +++++++++++++++
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 73417edade..09026360d4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1054,6 +1054,21 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
+    /*
+     * We report an EDMA that may exceed what QEMU can handle in support
+     * of direct-mapping.  If the guest attempts to register an IOAT that
+     * is too large, reject it with an informative message.  Only direct
+     * mapping can be used for guests of this size until support is added
+     * to QEMU for additional IOAT regions.
+     */
+    if (t && pal >= ZPCI_TABLE_SIZE_RT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ioat pal 0x%"PRIx64" exceeds max translatable address\n",
+                      pal);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return -EINVAL;
+    }
+
     iommu->pba = pba;
     iommu->pal = pal;
     iommu->g_iota = g_iota;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 9228523ce8..f182bab246 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -140,6 +140,7 @@ enum ZpciIoatDtype {
 #define ZPCI_PT_BITS            8
 #define ZPCI_ST_SHIFT           (ZPCI_PT_BITS + TARGET_PAGE_BITS)
 #define ZPCI_RT_SHIFT           (ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
+#define ZPCI_TABLE_SIZE_RT      (1ULL << (ZPCI_RT_SHIFT + ZPCI_TABLE_BITS))
 
 #define ZPCI_RTE_FLAG_MASK      0x3fffULL
 #define ZPCI_RTE_ADDR_MASK      (~ZPCI_RTE_FLAG_MASK)
-- 
2.55.0



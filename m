Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2099CA5FA6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHt8-0004vE-QC; Mon, 28 Sep 2026 16:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsx-0004s4-Sf; Mon, 28 Sep 2026 16:23:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsw-0001JS-4P; Mon, 28 Sep 2026 16:23:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI5o1h1832843; Mon, 28 Sep 2026 20:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=90nKNxsg5929aHtcJ
 N/XH2puo10poSTEnxAOoJUhnrg=; b=aR1Di4weghdqfX9v4JYJRKsMbzKxG0NGi
 ohi2KmCd0OFdaOLQRLmaEXceK1VFCN+s3bDZTKU7/CW1tp+jlojXDsHzPUA5UnKI
 XC6L9Jx1ZEu14WgkYs2Y4SNQRRKkYTkjUoLLZ7KaF4tFeOqZka7Tr23UaqAyyiv/
 VRiNvkNYAgIfUFR0BnSSz3/x68F4xpomoggTtg5M6AxBZDRhABNaz39U9ivWupGD
 KN9K57IMhggjm1qySlJW5p4w7g6JZgYRkqwudAtUG3Z3bJn6xblqJJRZdCz+0I1C
 IHji+EKvxX4Um9ptDAZZLtvgQNyGbgCAtCtBfYcs4CcAjaLcPdnoA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s53meq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2VLs525928; Mon, 28 Sep 2026 20:23:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpq14s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SKNVMq52822512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 20:23:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 720CF5803F;
 Mon, 28 Sep 2026 20:23:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49B1D5804E;
 Mon, 28 Sep 2026 20:23:30 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 20:23:30 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 3/3] s390x/pci: Reject apertures beyond IOAT capacity in
 translation mode
Date: Mon, 28 Sep 2026 16:23:25 -0400
Message-ID: <20260928202325.309353-4-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928202325.309353-1-mjrosato@linux.ibm.com>
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX4Ol8d5/6PjDA
 rlE81FZQQ5yqX7TWYEiu/ClTL/ioz3bUBjCs1h/kYhVo89hwBBH+459c6wllUOBYR/IozFX/5uI
 8KTaxkRS8qUqkaaoOTsFjeJXn/wmwU4=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abaccc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=xSIT066dgqKBegNCQIUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: aT0z1g_7aKKGDlL_jCJ6D62EuyslHO1F
X-Proofpoint-ORIG-GUID: aT0z1g_7aKKGDlL_jCJ6D62EuyslHO1F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfXwh8Tf58TUzCG
 AD4JIekWE25rGm3r6GvmFiLOHtN2VPX9zVHjpWg+v+ICsbW72XH5UIexp1xCPKC83Os4jWtFrxo
 eKkG/aPSPbHXqFPVmGSw1pEkd/K6PPALasoUbj0f4q35VOcq7YoUb8DB/Ff8zMSjnKYHJF1Y1sF
 YDLdByS6ThjJZa5dJSUOQ42hY8/2JqECL0cf5h2ys1Tmj7ln00DTaogY/pA36t38qsAbsLuJC1S
 IBdcNsB+oNLaM4KXh3lNndHf09a3YJX24C/iwzls9ka+kaNugj9be1h9DHbAuHFFk+OVTE6k7el
 skfXE3k/lqS16/y7tPGRJAKObejoRP+XmvhSsJbp4ujZr6C79dVZosTtE147vzjlEpu8kz3nrVB
 mM68IUHRq7tGsQOsgJUrV/vN3f8n5jsp/zvNlhUiOCTw/MMwvBFVZimnWIixcdf1K23e8gEK1IC
 dn940Fl6dFYM5TQLI9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280080
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
---
 hw/s390x/s390-pci-inst.c        | 15 +++++++++++++++
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index c6da3b4c07..c7658e7eca 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1055,6 +1055,21 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
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
+                      "ioat pal 0x%"PRIx64" exceeds max translatable address",
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



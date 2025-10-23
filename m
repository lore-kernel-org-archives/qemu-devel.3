Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668BBCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkn-0001kg-Sy; Thu, 23 Oct 2025 07:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkX-0001Md-Lt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkV-0001c2-Cr
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MM4vmY013009;
 Thu, 23 Oct 2025 11:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0sCM4u
 3iEphtHlN1dpt9qYhAiTLimDJuilK5EN4Zb0g=; b=MQ11uyE9xM+nduR/ydhP3U
 uKlwi1AzRYyT+jUMoIJEykw7cLD5rsuNsJcqlUf05pQPc17qfalEI78vG7GdRyNh
 sM8XnJatqKC5NmXHrkzrdfqC2ahdYie/cI8uM1rn3negly3HDQGhmiFbRCYJCvTa
 Ly6p2niQlBSkcxYSUDdIV5/bSI+A8bC1ClGfVk/arBoREbvyIRLyuHfAD696hB4B
 fSRMG5w1oRHg72jRP4Gb0g3eHc2gJXTJAhaohcss9+zynV/d61ABa5s1G7aS1EdS
 ijUtZrn1Mu7873KT6mO0cDS7QgLu/0r62h9BYCYu+A3boBiN39O2kVOpj07HfY1A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgj1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NA8XLF024303;
 Thu, 23 Oct 2025 11:44:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5dsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBihFB34537798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4454B20049;
 Thu, 23 Oct 2025 11:44:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A42D20040;
 Thu, 23 Oct 2025 11:44:42 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/32] ppc/spapr: remove deprecated machine pseries-4.2
Date: Thu, 23 Oct 2025 17:13:58 +0530
Message-ID: <20251023114422.3675018-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LIOrwgYOJnaETbg0OLYLPEIMHRSqd1KY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5IrtneQB3F7s
 AKQ0LcJglAHSrd0CploUnr5JjI4eBnQAGFriSEuJ2G9INEqpTLtPz1lPe60xtqE/mCyDvV9ko5s
 w/rdq9lE0d/1wHqpnwAAiSLsJ6CvWu56yTz4NXHbc3MkB4k/t60giCl9o7luZWss0fU8GrqiCic
 zLE5rnRqXP5TGfn5tEfobvHYK6t5zSVjmXjz8fAmswLedlU5l5IwI1xV1F6hB6hzxoiQ9T4AXpY
 5U5zUaxWBcw90LLi7wn7lGTJhVbI+0AvV3M/P1DozItdVhqKya2zc9JxO8XLh4m+O8lqfHjcMaw
 hCAxqyDpR7VdT7yM025ZQDm3iSbmS0PASw7bEojQ0+drgRnpnVAdy9buGzz5Wm+A5zSLjI8mvfc
 tXRYUAwk9bmOEtQOCpqCtcKLLg0diw==
X-Proofpoint-GUID: LIOrwgYOJnaETbg0OLYLPEIMHRSqd1KY
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa152d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=aow-egSQAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=MSIEXOgWn6CInn48Bo0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove the pseries-4.2 machine specific logic as had been deprecated and
due for removal now as per policy.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-12-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 27 ---------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60d9a8a037..b9d884745f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -141,7 +141,6 @@ struct SpaprCapabilities {
 struct SpaprMachineClass {
     MachineClass parent_class;
 
-    hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
     bool pre_6_2_numa_affinity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0e6218dc9c..117da76a3d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2729,7 +2729,6 @@ static PCIHostState *spapr_create_default_phb(void)
 static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr rma_size = machine->ram_size;
     hwaddr node0_size = spapr_node0_size(machine);
 
@@ -2742,15 +2741,6 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
      */
     rma_size = MIN(rma_size, 1 * TiB);
 
-    /*
-     * Clamp the RMA size based on machine type.  This is for
-     * migration compatibility with older qemu versions, which limited
-     * the RMA size for complicated and mostly bad reasons.
-     */
-    if (smc->rma_limit) {
-        rma_size = MIN(rma_size, smc->rma_limit);
-    }
-
     if (rma_size < MIN_RMA_SLOF) {
         error_setg(errp,
                    "pSeries SLOF firmware requires >= %" HWADDR_PRIx
@@ -4913,23 +4903,6 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(5, 0);
 
-/*
- * pseries-4.2
- */
-static void spapr_machine_4_2_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_5_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_OFF;
-    smc->rma_limit = 16 * GiB;
-    mc->nvdimm_supported = false;
-}
-
-DEFINE_SPAPR_MACHINE(4, 2);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.43.5



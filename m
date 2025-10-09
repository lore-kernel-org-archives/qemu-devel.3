Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1758CCD188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6n2n-0005zl-2K; Thu, 09 Oct 2025 05:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2l-0005yO-HZ; Thu, 09 Oct 2025 05:34:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2d-0001nw-T5; Thu, 09 Oct 2025 05:34:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5993RMWU006790;
 Thu, 9 Oct 2025 09:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=U1lZCN
 5t5t2cUWc2MJRZQdkpuGhvGJX+V8WiiTSTB9M=; b=GuJi/0aWqgxjzSLaJ+0f4m
 tZ3hZIF3jyIDY774MAvmQAsLLqOypN8g0X9DC7lGWtdMp1PG3zdE5x+1c/8eDkep
 ck5+S4R77w1T3SW5x07XwGe+Z5WWO7Hkgh46ixC6a+gvrH7Ko79zy8iwUeM+vvZV
 tLiKQouevOzPuEah3R47l6D64W20AQyO2OxmXM1sBiKjKVnkV7KpWn3cVrKCZcik
 QTUFsW5tXNe7jXNwgY3snwMBkjid3wBeZLVdEDvaKt0PgqRh4EM/hpl+C0Iea2rM
 LSGdTxwvaTW6Y9RXnX/ii6JKsTS2AmFHDecr0xXN256y5iIeQEAnqyhSyZV5oyhQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv803xxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5999P4DM020182;
 Thu, 9 Oct 2025 09:34:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv803xxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998GOMK008377;
 Thu, 9 Oct 2025 09:34:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvanurs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5999YEVn56885734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 09:34:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F78C20084;
 Thu,  9 Oct 2025 09:34:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DBB320072;
 Thu,  9 Oct 2025 09:34:13 +0000 (GMT)
Received: from ltcfuji9aw-lp7.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 09:34:13 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, philmd@linaro.org
Cc: npiggin@gmail.com
Subject: [PATCH v2 5/5] ppc/spapr: remove deprecated machine pseries-4.2
Date: Thu,  9 Oct 2025 14:40:57 -0400
Message-ID: <20251009184057.19973-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009184057.19973-1-harshpb@linux.ibm.com>
References: <20251009184057.19973-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NsDcssdJ c=1 sm=1 tr=0 ts=68e7819a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=f2lMtB83b2L1IpRQv6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: D2ZnYGKcuMjg37tQtEJTV1P3VRvZ1I4z
X-Proofpoint-ORIG-GUID: 5-elUU47LxH8vU2idb2gZKhzG3NLBbo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6KsRE0tKhhyN
 GEmTT/jgGZdYB9rMjmJQRiu/ZI/M7sfEWk7RgkKMfSOyD1phnrstNKn5+76QcWNUcc5SlAiB7n3
 vCI9wrfl3+uN2bzxss+0ex1+z3l3z7ziRLechzgObwQqQ8epcwzcP+zyq9iYvS6PWFUY0C7SsNe
 9PEy1JZwkeBys++KU8ZIbWiOG3X21StY7o+X0t3wB5gihDj6dZayEE/kg4BdioHBez22cIz4VoS
 So+IsQcIl4pDYkV8lcH1cTGhh+Diz6ruox0/iztV3ez25qa0eYlma7/NFwggGr7B4hNvKvd1eTk
 fYUV+UdwsU+5qeb9D4nuou8i3b2t/0cpaFHsRAgqZFinA1fLgYI8rcaidK/J2TlQ5/SW0F0wnZa
 MWX46oyfXm0Rt+eJKEsMnnXjiwy89A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         | 27 ---------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 96ee868e88..a9cf8677ac 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -144,7 +144,6 @@ struct SpaprMachineClass {
 
     /*< public >*/
     uint32_t nr_xirqs;
-    hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
     bool pre_6_2_numa_affinity;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 780688deaf..d704b8ce21 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2735,7 +2735,6 @@ static PCIHostState *spapr_create_default_phb(void)
 static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr rma_size = machine->ram_size;
     hwaddr node0_size = spapr_node0_size(machine);
 
@@ -2748,15 +2747,6 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
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
@@ -4924,23 +4914,6 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
 
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
2.51.0



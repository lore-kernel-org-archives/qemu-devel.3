Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724CBC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLcz-0003k7-Aw; Tue, 20 Feb 2024 03:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLck-0003Sr-E1; Tue, 20 Feb 2024 03:37:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLcS-00057m-Nu; Tue, 20 Feb 2024 03:37:08 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8VYJI009754; Tue, 20 Feb 2024 08:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oPl19dcLxfA5p8nZMRYMwxlthODMHZ4bVYBBJaGfAAQ=;
 b=SYZByfaxccrsQi3qFalaNu1yeVc2qbnzX9dLGKz436ddMEFwPL8Moq7YSxdvc2NMomMS
 5vwXkzxPI4xVl523jK8G8yw5CuiUaUfVMYiTilfdniNfqxkuNug3iCJdbIkUkG7vZxAe
 v/H+cYhNcAdUhbcyjTXLW/vtJkyfKgVG7WqUeY8qpC3yrY1riCWm0HuflXLjah9CK6Kf
 c7a2KH9KqVsMYJK4fOB6AwdB5aDPPLFKiCxRYscyocXThrCwDeEfQROZaYe4bwyzHWj6
 6/TWhRZdgVQFs55X2OoLML666liqcQPkf8SlO+rKLychKXp+1c2uFEVKQBWxDZ0YOwc/ TA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpgaat6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:48 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8W0w6012142;
 Tue, 20 Feb 2024 08:36:48 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcpgaat6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7M1GS003620; Tue, 20 Feb 2024 08:36:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tf9am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8afh312059188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8DB520043;
 Tue, 20 Feb 2024 08:36:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D89A20040;
 Tue, 20 Feb 2024 08:36:40 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:39 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 12/15] spapr: nested: Use correct source for parttbl info
 for nested PAPR API.
Date: Tue, 20 Feb 2024 14:06:06 +0530
Message-Id: <20240220083609.748325-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240220083609.748325-1-harshpb@linux.ibm.com>
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pfsWiH2cqHjL_zlLL8qAjYfrd7kEJNbV
X-Proofpoint-ORIG-GUID: km_i6kW7Bv_iiJhRU63BSvsezU1lxBWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=822 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
partition table info, use the same in spapr_get_pate_nested() via
helper.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_nested.h |  4 ++++
 hw/ppc/spapr.c                |  2 ++
 hw/ppc/spapr_nested.c         | 20 +++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 1b7e55f12a..da918d2dd0 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -511,4 +511,8 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
 void spapr_nested_init(SpaprMachineState *spapr);
 uint8_t spapr_nested_api(SpaprMachineState *spapr);
 void spapr_nested_gsb_init(void);
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry);
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong lpid);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 51a1be027a..3453b30a57 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1379,6 +1379,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         assert(spapr_nested_api(spapr));
         if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
             return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        } else if (spapr_nested_api(spapr) == NESTED_API_PAPR) {
+            return spapr_get_pate_nested_papr(spapr, cpu, lpid, entry);
         }
         return false;
     }
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index aba4b25da6..0edb362709 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -52,6 +52,19 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return true;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    SpaprMachineStateNestedGuest *guest;
+    assert(lpid != 0);
+    guest = spapr_get_nested_guest(spapr, lpid);
+    assert(guest != NULL);
+
+    entry->dw0 = guest->parttbl[0];
+    entry->dw1 = guest->parttbl[1];
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -536,7 +549,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
 }
 
-static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
@@ -1558,6 +1570,12 @@ bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
     return false;
 }
 
+bool spapr_get_pate_nested_papr(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                                target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
+
 void spapr_register_nested_papr(void)
 {
     /* DO NOTHING */
-- 
2.39.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74FFC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 04:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC9vp-0000lO-KP; Tue, 06 May 2025 00:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uC9vo-0000l5-DS; Tue, 06 May 2025 00:29:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uC9vm-0001G1-83; Tue, 06 May 2025 00:29:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545Lh2im015169;
 Tue, 6 May 2025 04:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=cP9r3p/MzHElDzQbDZrlI8u6NO2FvJjtNy+K+kr+K
 qw=; b=tCcFw2mCsDLyc5q0pkndbEp+sXaw6trUKMUageHFrXYrnGfZ8S6XrQKoF
 TLSTPX6L3iAIOt52t/escPvM3WUmVqPAJt3zi8X1UbBSOndSTff1rF3CjcNdpXmN
 YGndRF+al34zWWKeDsZ64bOOVZ7czwJACLwiTh+PdGsGItByVmtFV+4XJkZ2nO3A
 j5MZUTFyEOgHhHZYljPrkes5ofASrfQDiKDixt2zIWEVLuFL3G561IolUfa3ldnf
 it+TlxwSMC/tiv9hcZlPwNH6899YWoMU0F0bhuojlnwY9+6ODo035N1pDxFRngN8
 0PXQ9DYTitM6Hksce9WBcwt555tpw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw15kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 04:29:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5464THYv026377;
 Tue, 6 May 2025 04:29:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw15km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 04:29:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5463XvKZ025807;
 Tue, 6 May 2025 04:29:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuysv4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 04:29:16 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5464TEhr27328918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 04:29:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDED72004E;
 Tue,  6 May 2025 04:29:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F5992004D;
 Tue,  6 May 2025 04:29:14 +0000 (GMT)
Received: from ltcblue8v9-lp2.aus.stglabs.ibm.com (unknown [9.40.192.95])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 May 2025 04:29:13 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, npiggin@gmail.com
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH] ppc/spapr: init lrdr-capapcity phys with ram size if maxmem
 not provided
Date: Tue,  6 May 2025 00:29:03 -0400
Message-ID: <20250506042903.76250-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDAzNiBTYWx0ZWRfX/OCEimyB6Ol+
 KdYqaXlzQRVEDJuvj3ubV+CEDGVZetcn+1a4fdPgqXmzL3WRtX0C5OF8+ZRxsaJ5S7DIBxModMp
 E/x3LSUfzRJF+S9IMpHn335uoYpu7PAZmZZvcVvRe/OQQArBETYxTCKiO8Q7rnTarvhoouvjpyx
 pNwZFc4WFKotvX/dLqrwHQzStjI/Z5hOaF7lvsLnobrNQwauYFg8jRw7+Ifi0upicE1ZAEkCHp9
 oKsEYNgzJ+rQOyk1FDY2A+QfGSlJV6eTJnCBtC/G4pcVHn1UVySHvGNA515voVSHuBmHMdqK1Ss
 iEm1uEuttiSaIq8D0M0zYuc8YHmkVh+/uqR26KbrjN6uZXDKzOC6gvWYOBeOof65NnQcEoaPj+1
 uejGoC69F0VfW7d2+RzFEQ3xFzQDCLJRIi4ZijuiH+hbFL4xy00AjTSJKcGxf0EKbCdm8Kn5
X-Proofpoint-ORIG-GUID: dlt4BCuwlsHfZsVAVl3dP336x29L3cmV
X-Proofpoint-GUID: 3Zlczyw8OvdEoahVa4-tziJFLBSsE_Gm
X-Authority-Analysis: v=2.4 cv=IaaHWXqa c=1 sm=1 tr=0 ts=6819901e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=dt9VzEwgFbYA:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8 a=J1cxJhNvERGw7pREUikA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_02,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

lrdr-capacity contains phys field which communicates the maximum address
in bytes and therefore, the most memory that can be allocated to this
partition. This is usually populated when maxmem is provided alongwith
memory size on qemu command line. However since maxmem is an optional
param, this leads to bits being set to 0 in absence of maxmem param.
Fix this by initializing the respective bits as per total mem size in
such case.

Reported-by: Gaurav Batra <gbatra@us.ibm.com>
Tested-by: David Christensen <drc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 702f774cda..9f18642734 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -907,6 +907,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     int rtas;
     GString *hypertas = g_string_sized_new(256);
     GString *qemu_hypertas = g_string_sized_new(256);
+    uint64_t max_device_addr = 0;
     uint32_t lrdr_capacity[] = {
         0,
         0,
@@ -917,13 +918,15 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 
     /* Do we have device memory? */
     if (MACHINE(spapr)->device_memory) {
-        uint64_t max_device_addr = MACHINE(spapr)->device_memory->base +
+        max_device_addr = MACHINE(spapr)->device_memory->base +
             memory_region_size(&MACHINE(spapr)->device_memory->mr);
-
-        lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
-        lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+    } else if (ms->ram_size == ms->maxram_size) {
+        max_device_addr = ms->ram_size;
     }
 
+    lrdr_capacity[0] = cpu_to_be32(max_device_addr >> 32);
+    lrdr_capacity[1] = cpu_to_be32(max_device_addr & 0xffffffff);
+
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
 
     /* hypertas */
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD5ECD5BC2
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 16:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQpCa-0007ee-Dt; Sat, 23 May 2026 12:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCY-0007e5-W8
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCX-0001VD-Co
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64NCDjFK3074604
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=R5ZwBQsZP8XD2Xa2W
 QTE+zUweiw4Y2Jp2/gIutjJsDI=; b=CHW1qFEnT/e1/c893NHI9664QI27XP7Ua
 czxRYRbhZyZa0OxuJw1Nnqs50f+a+bYqpn0DSny4fbHpLb4nRPpbN6BN0ZEpykLW
 64N5gEYU9o/gFmV0uMTzH+tNgUxC1YMJKASFrQTCi4IwLZ6dnvqXHVjJbWipVIkb
 7xDtWqL++qqDAPsuTN5sqSd82NVYXD6Nfkhb1SYyAuB0sC/F2RZAV88zYSG6Y/vO
 CIKFdJjHN8mG69Wgoccl7QokuoL8VHYQJMHXisvTkmYnwpnZE502wcamwCdA6AJP
 u+ZzSua0AL8+QuI1wNR34I/q9Wbk7CC46QmJchtfcyo4Bv3TvLBcA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4npscbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NGO4ea022702
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb480hrh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NGRhaZ59572564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 23 May 2026 16:27:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACE5E2004D;
 Sat, 23 May 2026 16:27:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DA4D20043;
 Sat, 23 May 2026 16:27:42 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 23 May 2026 16:27:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PULL 5/5] ppc/spapr: Make Power11 as default cpu for pseries
Date: Sat, 23 May 2026 21:57:24 +0530
Message-ID: <20260523162724.95229-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523162724.95229-1-harshpb@linux.ibm.com>
References: <20260523162724.95229-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WJ6m3tSxOxHcHcvrubhFIMhL6uJtRd0B
X-Proofpoint-ORIG-GUID: WJ6m3tSxOxHcHcvrubhFIMhL6uJtRd0B
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a11d584 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ao_pOPHRJG_XwDkW-DoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2NSBTYWx0ZWRfX4vMAolQpru5T
 ChWac1AiBNiiQgzbBFyIyZusvt++iOWoL1w0rGKQWnS7aLlaGnVuseriWKMcnrEFz3SaSKCMzML
 pWEHb324utWQrv5N7THB18gkriztqvlB0eA0yJ1R0ZaDSYD8IR1MX815q/ZS7nqu44JTkk3ZkE9
 knRqmw3lNt+dLQZbZEY/HxVVbVDiMLCfkwEu1/bOSeHRMlFDf58m5vZDiqBHozNvE8uBMXdFLMe
 FQuvOisrxmRSsyQeXulZlgDVmnaEP36/JdvpFblvTpK/4aze3JGlGmwYZFjWRmf/mnu/PFaNCec
 tCLh++dr9gLAQG6MhEjV1TDyiz9HQSORGzaOC+8wEIMbaQ6DltlOt3GmEfvYZW8FIFQYT7ZxVxL
 t04IX6TU4FrESwMjq1g4qY4JJ2NLyib1LytMHjJhks3j1O5C/yQuJwV7KkKit1vm8Ne7o0hi3FC
 zFnvk9hER3f3273g5pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605230165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Aditya Gupta <adityag@linux.ibm.com>

With Power11 being the newest supportied Power processor in QEMU, and
sufficiently tested, make Power11 as default CPU type for pseries
machine

Retain Power10 as default CPU for pseries-11.0 and older versions

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260521200844.1449023-3-adityag@linux.ibm.com
[harshpb: commit title, Amit's email updated]
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d40af312fa..191f7431bd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4644,7 +4644,7 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
@@ -4777,6 +4777,7 @@ static void spapr_machine_11_0_class_options(MachineClass *mc)
 {
     spapr_machine_11_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
 }
 
 DEFINE_SPAPR_MACHINE(11, 0);
-- 
2.52.0



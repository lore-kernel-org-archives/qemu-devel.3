Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64063CD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9hh-000271-9c; Thu, 21 May 2026 16:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQ9hg-00026V-1g; Thu, 21 May 2026 16:09:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQ9he-00073l-IB; Thu, 21 May 2026 16:09:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LAJtSD709576; Thu, 21 May 2026 20:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fQ37CIDkp9CqUV08H
 I4IAZCvTEmlxlrYWrucHlCfiWc=; b=fIeGtDV+nU8QpXkkVvW4WWldfW3Zxme4H
 xITcGb9hoQ7YTdIRcIT7ytPJ65umV688tckqpd4p5ZtasqclveNS0APZOpEPCP9M
 hc4enKaGYsFsJ7XMXSPrWkC3PXuQcVp+tf9YuL6nkjdgSdA9FPYPlevNN2CsAoM/
 pYnXwH9Eg8tnQEIJjwK+1OVBr0u+idwO4VVj+12S7nZSnZNKOFtkRxv1LBrVjHQl
 a0CIiiejyIp18FG63ygd4jPbWLejJEzRWq9w9rL1Iq7nKAZZQgYmRPqyTJjfgCzF
 ZB5YcfUlIUPNFowSrTqeSf6B85pQcHFjAVAknkc2g/V9yb5c69G4w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h758u5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 20:09:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LJs6sY014327;
 Thu, 21 May 2026 20:09:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kydmxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 20:09:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64LK8vXq30802388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 20:08:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28C132004B;
 Thu, 21 May 2026 20:08:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3238020043;
 Thu, 21 May 2026 20:08:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.116]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 May 2026 20:08:53 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PATCH 2/2] ppc/pseries: Make Power11 as default cpu for pseries
Date: Fri, 22 May 2026 01:38:44 +0530
Message-ID: <20260521200844.1449023-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521200844.1449023-1-adityag@linux.ibm.com>
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0f665d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wnoTkFhnbxb0mKSpKhwA:9
X-Proofpoint-ORIG-GUID: wbVBTeTXTvfcj8D13uLHpe3CvVsLFldf
X-Proofpoint-GUID: MNY0-uJVtWgru13riyXw3zSPODmCPJKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwMiBTYWx0ZWRfX01PoqloC2osp
 kWIP5kHQ0c0jy93hPuP/V62v3Z7GI0oXMKfugDmF7Xi6EAaXW5GedQXP01vI29v0mgR232vd2jY
 gkgEcOl0Myg2tSZGx4FRtzFFNs27Q3BNBgPkB+ImIUT8qe2vuJPCd3UEP0ysWEDhJXaJchVkPiJ
 DzKH3jAN7kjO/w34MfgV36cbRw8M/BNOLvVl3iD/93EzB2uRsgDAv2MMCt66iHE0l0Clpt+yocj
 Ur6sbSv7NLfqxfDhJgT5l4IKnBIMSsKQDywkW4RbeTcO1C97dv3MUCltxJvjCYzxBRzaSob7wgr
 wV1W/iY9ZGKzYsfDT4WOXoW2izAphhrx3Jq/4yA3c8UnBF8AfNq+0mhvm0pscFqo2lbPAPq7Wm6
 bjGqocrfLDETpWfxW2MnyL0Yj6n/MeK4JkgPF4IVDCAYoj860I6sL8lOjI/NGrydG7h2rZomSlr
 jhfWZVitcJlxExW1kag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210202
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

With Power11 being the newest support Power processor in QEMU, and
sufficiently tested, make Power11 as default CPU type for pseries
machine

Retain Power10 as default CPU for pseries-11.0 and older versions

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d40af312fae1..191f7431bdf5 100644
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
2.54.0



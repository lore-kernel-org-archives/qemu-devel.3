Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC0C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz6if-00015V-Sz; Wed, 26 Aug 2026 02:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wz6ie-000150-Mn; Wed, 26 Aug 2026 02:02:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wz6ic-0006bv-Q8; Wed, 26 Aug 2026 02:02:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3VlRD2830892; Wed, 26 Aug 2026 06:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=wlTFJ9+o+xKzxmsmfpHCJrVORnqBX99gZ/oG40efH
 d0=; b=ff3q50BhR594Yoid0jd8cDHQJtGDpCpwyf5ePQNDXtuxCc3/KnSwbccnR
 A10HgfQdGfMLa5ybG37Ny6OeXZxUDykx41XQTYrouglixg7JE6HJcF/6WX3gv2M8
 mVh432/HzkfA1waaPWCOyFeptd089DOH3Ez08jMY8KwRcB/7EM39OQrS6Ef/eU/Q
 It5ayfWP4fxjDj9RHzJuJs5QhzZtjE4+Ma80vWrg1snX9mr+A3eFlKGgCEZRRGw9
 ZhPt0igZznVJkT1FWrkVxCxqb5wauQim7R2OiMc6xpRyz55LsOk8emARCCZWIyPU
 Q4z6VmYP5dn8Qoo0HV//sUW/qfIew==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4vvce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 06:02:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q5uQSR017473;
 Wed, 26 Aug 2026 06:02:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh8aq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 06:02:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67Q62SQb41222430
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 06:02:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5A6D20043;
 Wed, 26 Aug 2026 06:02:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A70620040;
 Wed, 26 Aug 2026 06:02:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.125])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 06:02:26 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: milesg@linux.ibm.com, clg@kaod.org, harshpb@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PATCH v2] ppc/xive: Trigger the pending interrupt for a guest after
 migration
Date: Wed, 26 Aug 2026 11:32:15 +0530
Message-ID: <20260826060217.24978-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OKS36hUW9W2JhMfileSsy9gam279hZZ7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA0OCBTYWx0ZWRfX58neTq9eSbVB
 oBPOvyIBVDP2bgO+d+F+GWGjpOixOj11+LR8YQaildn/TcyMMyh9VMOshwRp4I/hzJSqOb60OZd
 5KcBALnIlMKlK3Rpbj3jDIWeF9EeE9w=
X-Proofpoint-GUID: OKS36hUW9W2JhMfileSsy9gam279hZZ7
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8e817a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=s8C7O4VJWu0c45J7ejMA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA0OCBTYWx0ZWRfX1aiewyzVm0vP
 TYDpyAVTDqz+FMxyuJAztFCcKXiVqYsh5ic2BKy5I5gIo/OssoEO8RbIumYTh3lAhUteupzyaqc
 eKrn5RfprSFn0OYIUaYgM8m4y+3ccwysgyfRzbS9dxmy0YWpF1eOPzP+cdcKM30PUUCfW6/M3xl
 fxl+hVaqxtdrwj767N/VqBg8sFMODLoOrLek6Y+9IAUQkbgD87imWPRbtieyM38us2VUwIyqzvF
 r8R/mdiGSfApFRU9mE7JmYi1g5tR1s7UcDv7X+XaEiQp2tPMlSJtbC/xAOwEUGmHRG0l440EcG9
 yT4gJ+1A5h6j36ZKJ4rQdHfWb9WQaGg5gxRNofY4PYKEVXwefkVMlU6YmkM690ECn58NwDb18G0
 Mm/HDuEnoofugNHzZF9lGOlPYHSW/gFtsHfFKo2Jrs++bTTIiQVmAGvB8a5qBQNgeypqg/H0pJE
 f3ZtUFCYQCrmbwRu9ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260048
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
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

When a KVM guest is migrated to another LPAR while a stress-ng workload
is running, lockups are seen when the guest resumes on the destination
LPAR. This root cause is that if there was a pending interrupt for a cpu
on the source machine but it was not presented yet when the migration
started, the interrupt is not retriggered on the destination LPAR. This
is evident when running 'info pic' on the destination LPAR:

$ virsh qemu-monitor-command --hmp migrate 'info pic' | grep -e OS -e MSI
CPU[0000]:   OS    00   ff  00    ff   ff  00  ff   ff  80000400
CPU[0001]:   OS    00   ff  00    ff   ff  00  ff   ff  80000401
CPU[0002]:   OS    00   ff  00    ff   ff  00  ff   ff  80000402
CPU[0003]:   OS    00   ff  00    ff   ff  00  ff   ff  80000403
CPU[0004]:   OS    00   ff  00    ff   ff  00  ff   ff  80000404
CPU[0005]:   OS    00   ff  00    ff   ff  00  ff   ff  80000405
CPU[0006]:   OS    80   ff  02    ff   ff  00  ff   06  80000406
CPU[0007]:   OS    00   ff  00    ff   ff  00  ff   ff  80000407
  00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
  00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
  00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
  00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
  00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]

Fix this by calling xive_tctx_pipr_set() in
vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
present the interrupt. This fix is relevant only for setups where KVM
guests rely on emulated XIVE provided by QEMU, since the native XIVE
case is already handled.

Cc: qemu-stable@nongnu.org
Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Anushree Mathur<anushree.mathur@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Add a line in patch body for clarifying the setup where this fix
is relevant (Nikhil)

 hw/intc/xive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f473e6ac77..712498d4af 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
             error_report_err(local_err);
             return ret;
         }
+    } else {
+        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
+        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
     }
 
     return 0;
-- 
2.53.0



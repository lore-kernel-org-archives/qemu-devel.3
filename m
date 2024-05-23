Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFD7C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 05:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA0n1-0002SZ-97; Thu, 23 May 2024 01:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mo-0002Mp-50; Thu, 23 May 2024 01:14:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sA0mj-0000nX-L8; Thu, 23 May 2024 01:14:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N4jDQ2009113; Thu, 23 May 2024 05:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8SERiCKR0NmGW/+CEl8fOxF4R3OYIlYYsKz5ybrAH5k=;
 b=YRQxtl1cp0ZDTu7XteMKdrAz3rj4Ci6YMVYpMRJRZpaESzDKrZiGTD/CjjzaQV/lKg0v
 Q/85dTta602hRgPnp0wzlLxtEBgNt2iYL5UfNpRoocoJDxjD8Y9u0BhKuFK+S9Pb9BJ5
 GkmHwl0fVwTE2FlsYSEFQc88jS3lyexAx3fy5Y06rinEz3HgcEiLsa0NdbvMCim3HETP
 hNSz5VIWHwMmflaMONORm/J6YHTpuiKT64GS3vQY51j5FeocY33i0sRnVq2XQRgo6+L+
 tdVrKSnivQ5Bq2xrBbDuMI85iC+DTDfTMiZpZbmIDgtzV5VNZUPXNS/01Jd8x7sk9rBb 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9xe484uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:26 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N5EPma018530;
 Thu, 23 May 2024 05:14:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9xe484uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44N4bYi4023459; Thu, 23 May 2024 05:14:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77npg4r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 May 2024 05:14:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44N5ELTQ31851012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 May 2024 05:14:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F9CB20043;
 Thu, 23 May 2024 05:14:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B96720040;
 Thu, 23 May 2024 05:14:20 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.165])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 May 2024 05:14:19 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v2 0/7] target/ppc: misc ppc improvements/optimizations
Date: Thu, 23 May 2024 10:44:05 +0530
Message-Id: <20240523051412.226970-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MtLilOdRZlcIlKnCk6MZQySIgLMVAMlD
X-Proofpoint-GUID: uQXfdFL0z7kVIrtKSCwAJfDJuSbcHUzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_02,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=280 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This a set of misc ppc arch specific code improvements/optimizations.
Although there exists similar instances for potential improvements in
the legacy ppc code, however, that can be taken up later as well.

Changelog:
v2: addressed review comments from BALATON Zoltan
v1: Initial patch

Harsh Prateek Bora (7):
  target/ppc: use locally stored msr and avoid indirect access
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize p9 exception handling routines
  target/ppc: optimize p9 exception handling routines for lpcr
  target/ppc: reduce duplicate code between init_proc_POWER{9,10}
  target/ppc: redue code duplication across Power9/10 init code

 target/ppc/cpu_init.h    |  77 ++++++++++++++++++
 target/ppc/cpu_init.c    | 166 ++++++---------------------------------
 target/ppc/excp_helper.c |  72 +++++++++--------
 target/ppc/helper_regs.c |  19 ++---
 4 files changed, 150 insertions(+), 184 deletions(-)
 create mode 100644 target/ppc/cpu_init.h

-- 
2.39.3



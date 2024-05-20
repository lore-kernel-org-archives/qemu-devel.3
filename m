Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E976C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 10:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s90Kw-0000gn-Lj; Mon, 20 May 2024 06:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90Kv-0000gN-6c; Mon, 20 May 2024 06:33:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1s90Ks-0008Ut-SF; Mon, 20 May 2024 06:33:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44KASA5K021186; Mon, 20 May 2024 10:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=T/GrVZ5hHd3+M0vyzMup29UGRYf8Ys1DoK+B0KnGikk=;
 b=k8WmoIpR1UE19im8AR+SfmF0W9ftpX+JpAwMs+3I6iF9XZR3Y/hOBBSJz8o+p2rXQSyn
 LAhkmk+zdwJnOBlILRNg5KffX0eMM+j6ND95B0uxAUGAot4ezl2Oo7k8QL2OA52z8YiM
 SyaLKMjk709z+daJR9LNjt3XLbvCc6fLsmLpaqBnS7YemMoTLnOkT+Zu5APk1CLeqaCD
 eUtWjX7RJxm9igt0RjxzeEnKAqTO4di7xgOjuhWUSt6i98vq6QHRTl3vN6qDlre1KHTs
 Fbe2AibLszqnI5ywIK1LgHNerfV5mkPnTKepFcFD3cItysMycs7uY0SASF+DZooC99Ld Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y84sc00b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:39 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KAXcHl030423;
 Mon, 20 May 2024 10:33:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y84sc00b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44KAFEff026457; Mon, 20 May 2024 10:33:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785m73nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 May 2024 10:33:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44KAXXmA38928828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 May 2024 10:33:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50C472004E;
 Mon, 20 May 2024 10:33:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD35C2006A;
 Mon, 20 May 2024 10:33:31 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com (unknown
 [9.195.33.101]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 May 2024 10:33:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/ppc: misc ppc improvements/optimizations
Date: Mon, 20 May 2024 16:03:23 +0530
Message-Id: <20240520103329.381158-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mt68jJv0P6MlrLcXe2TneKjoDHKarObN
X-Proofpoint-GUID: rNE7VoAPrOoYNZ4jfJ8YVQa5bo1dyiBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=1 suspectscore=0 bulkscore=0
 adultscore=1 impostorscore=0 clxscore=1015 mlxlogscore=219 malwarescore=0
 mlxscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Harsh Prateek Bora (6):
  target/ppc: use locally stored msr and avoid indirect access
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize p9 exception handling routines
  target/ppc: reduce duplicate code between init_proc_POWER{9,10}
  target/ppc: redue code duplication across Power9/10 init code

 target/ppc/cpu_init.h    |  79 +++++++++++++++++++
 target/ppc/cpu_init.c    | 166 ++++++---------------------------------
 target/ppc/excp_helper.c |  39 ++++-----
 target/ppc/helper_regs.c |  19 ++---
 4 files changed, 134 insertions(+), 169 deletions(-)
 create mode 100644 target/ppc/cpu_init.h

-- 
2.39.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8027FEEEC08
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxh4-0001PG-Ko; Fri, 13 Sep 2024 00:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxh1-0001Ig-Dv; Fri, 13 Sep 2024 00:13:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soxgz-0002Vx-8x; Fri, 13 Sep 2024 00:13:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CH8foX006920;
 Fri, 13 Sep 2024 04:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=c2zgAuUXOY8QTIAR3DQMvUQI+Q
 AAPNnc90kLP8WkU5M=; b=KmgWMCO5r7ygGMJYy5PBB473azrCI7ibDMH6uz2LRV
 ok/akgzPeY1GU9MBb/83uHczPdKpy+Di+DaV7SpxfuuyoxE7dGFDia3khe8eIFEO
 9w8WoYAMNVpBACSR9iyC1BjMTbbd2DQeY92UfMo0B3SFKMXOBvYohDlUawlonFKM
 iGRqejmwUiNlOjkK16cEKK2+hLqwDubIaTZ8xolb7IxfI/YDdtWSVB2z2eYfXzWH
 ISJUq3NnJNhrMBzmVylsK2pOa9Pd3kX61dUE09CkDhwfBHPIWQyhsqaZZFc3jLvH
 jedwp32/CvWSRoqXBmu5DmDLtm/Wj8KkmkWBI80S3MjQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyy8m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4DjQ8010927;
 Fri, 13 Sep 2024 04:13:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefyy8m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D2Sxvi014576;
 Fri, 13 Sep 2024 04:13:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmkmaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:13:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4Dhnw41222562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:13:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A2302004E;
 Fri, 13 Sep 2024 04:13:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 574C92004D;
 Fri, 13 Sep 2024 04:13:42 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:13:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v3 00/10] misc ppc improvements/optimizations
Date: Fri, 13 Sep 2024 09:43:27 +0530
Message-ID: <20240913041337.912876-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dNJen3rEjOuH4jPEyCYDpRSqICPvkt47
X-Proofpoint-ORIG-GUID: fnz8PpTPALSiWh1cyE2oiuRDxo4l9i5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=302 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130028
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
This version of series extended improvements to p7 and p8 alongwith
additional minor improvements.

Since patch 7/7 of v2 series have been picked by Aditya in his patchset
for P11 support, I have excluded that patch in this series and based on
top of his v6 series which contains the required patch as 1/5.
Based on: <20240731055022.696051-1-adityag@linux.ibm.com>

Changelog:
v3: extended improvements to other Power arch p7, p8 (Nick)
    other minor improvements
v2: addressed review comments from BALATON Zoltan
v1: Initial patch

Harsh Prateek Bora (10):
  target/ppc: use locally stored msr and avoid indirect access
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize p9 exception handling routines
  target/ppc: optimize p9 exception handling routines for lpcr
  target/ppc: reduce duplicate code between init_proc_POWER{9, 10}
  target/ppc: optimize p8 exception handling routines
  target/ppc: optimize p7 exception handling routines
  target/ppc: simplify var usage in ppc_next_unmasked_interrupt
  target/ppc: combine multiple ail checks into one

 target/ppc/cpu_init.c    |  58 ++--------
 target/ppc/excp_helper.c | 230 ++++++++++++++++++++-------------------
 target/ppc/helper_regs.c |  19 ++--
 3 files changed, 141 insertions(+), 166 deletions(-)

-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F016CEACC6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdUY-0000n5-S3; Tue, 01 Oct 2024 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1svdUQ-0000j7-FB; Tue, 01 Oct 2024 10:04:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1svdTa-0000SH-21; Tue, 01 Oct 2024 10:04:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917KFHn021704;
 Tue, 1 Oct 2024 09:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=TiJFy0g3/XvNVAn8raES3V0JPB
 03wJ8jXglaTSwJ6r0=; b=jRDqcVAfThDLS2VpLkM6A8hWIZDEUfYrunfvs/QvVQ
 ldlHdtxz4NT+2x+y27yqT/9FC12RhRL+iEisfgOA6wBOr9+vyKbFX80+8FHDI+bF
 msbYxiJPZLDRGQ2ZFvLdeAeRwcsBgNNZqsniSOLvlJULL4ggQ5+PRB2NyLN3vQ6u
 yBKm+ZA7fwEwU9Xo3OvRki4hq1lH+xYqGlhWjH0s0tdcNNR9sW2mCe2td/R8YRsS
 ZzU51yG7P3RKSzqU0og4C+Y2b5UdcFDNrAYQ4TtL6aNI9OuifRye+YB0NlyxX+UU
 /wgrnQIanVdGoFZMh0B1jBIn2pTKtzVJsvUL7WWiHYhQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckngm8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4919R144028801;
 Tue, 1 Oct 2024 09:29:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckngm8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4916U3Vj014609;
 Tue, 1 Oct 2024 09:29:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk3bs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 09:29:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4919TF4E30671378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 09:29:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 329A82004B;
 Tue,  1 Oct 2024 09:29:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4186720040;
 Tue,  1 Oct 2024 09:29:14 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 09:29:14 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v2 00/11] ppc/spapr: remove deprecated machines specific code
Date: Tue,  1 Oct 2024 14:58:59 +0530
Message-ID: <20241001092910.1030913-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w9f5KAUZmcPYCwjmDC8hXiWRu2UQLxAx
X-Proofpoint-ORIG-GUID: KrSKxUOFrCSQQcXiV3ZC0UgqugrEo8U9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=527
 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing the arch specific code for the now deprecated machine types.

v2: Addressed review comments from Cedric
v1: <20240917060300.943496-1-harshpb@linux.ibm.com>
 
Harsh Prateek Bora (11):
  ppc/spapr: remove deprecated machine pseries-2.1
  ppc/spapr: remove deprecated machine pseries-2.2
  ppc/spapr: remove deprecated machine pseries-2.3
  ppc/spapr: remove deprecated machine pseries-2.4
  ppc/spapr: remove deprecated machine pseries-2.5
  ppc/spapr: remove deprecated machine pseries-2.6
  ppc/spapr: remove deprecated machine pseries-2.7
  ppc/spapr: remove deprecated machine pseries-2.8
  ppc/spapr: remove deprecated machine pseries-2.9
  ppc/spapr: remove deprecated machine pseries-2.10
  ppc/spapr: remove deprecated machine pseries-2.11

 include/hw/pci-host/spapr.h |   4 -
 target/ppc/cpu.h            |   6 -
 hw/ppc/spapr.c              | 235 ------------------------------------
 hw/ppc/spapr_pci.c          |  28 -----
 target/ppc/cpu_init.c       |   3 -
 target/ppc/machine.c        |  54 +--------
 6 files changed, 1 insertion(+), 329 deletions(-)

-- 
2.45.2



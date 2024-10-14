Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01FCD16257
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KAr-0008Ss-4Z; Mon, 14 Oct 2024 08:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KAp-0008SS-Bp; Mon, 14 Oct 2024 08:27:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t0KAn-0002N4-79; Mon, 14 Oct 2024 08:27:43 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAKrVw018878;
 Mon, 14 Oct 2024 12:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=wFYO1ZzNxKFap
 a/BkLrj/a2ikVZ2KkasRTklykwM8do=; b=NVisiFl9+UxHPeSX6uQSp0Nh/xOuF
 tk7F7f2r7lwu/zG7NitXKgF1uD0YxIbHgWx2D+cX3YOgOEecYaTuM6Ov0BMafhno
 A6LJC+6Waq5CDVZCxno7n9bxKArRB6st3B6OAOKyWwrDESPQGCLSMUgQZA3LlHh8
 bY5XvmnWDarh8S5t48k+WR7XCh6swINM0VMcuUHY3BPsJ+T6sCv1vrZMcx3LKjZf
 H89/OkEoBITVM1+ZlMDbLytwQSLBYVcxJ7+EAiF8bfozIx7mCimqxXglB8Mv8zu0
 C/XsB7FI943P8tkXFbM6zzSaBA21AZy1aqDASTNQIziJ5o3vmaSmwauOg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECRZ0H011577;
 Mon, 14 Oct 2024 12:27:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291f88k7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAYSF5027452;
 Mon, 14 Oct 2024 12:27:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txejx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 12:27:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ECRXCr56557840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 12:27:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D81020043;
 Mon, 14 Oct 2024 12:27:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2501320040;
 Mon, 14 Oct 2024 12:27:32 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 12:27:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v4 00/13] ppc/spapr: remove deprecated machines specific code
Date: Mon, 14 Oct 2024 17:57:16 +0530
Message-ID: <20241014122729.1136809-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6hfgfD5RKPW4Lc3LHfLr8Jv3NRYBXcK1
X-Proofpoint-ORIG-GUID: 0JutnH2bqPY7CvH58-i5xuatqT7yGMKb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=711 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

As per Qemu's deprecation policy [1], and the legacy pseries machines
being marked as deprecated in earlier commits, this patchset aims at
removing the respective code for machines which are now deprecated.

[1] https://www.qemu.org/docs/master/about/deprecated.html

v4: Removed hw_compat_2_{1,2,3}[_len] in patches 1,2,3 (Philippe)
    Removed DEFINE_SPAPR_MACHINE_TAGGED in patch 12 (Cedric)
    Updated version_id to 2 for vmstate_slb in patch 13 (Cedric)
    Dropped removal of pseries-3.0 patch 14 (Cedric)
    Added R-bys from Cedric in patch 3, 4 and 5
    Patches awaiting R-bys: 12, 13.
v3: Addressed review comments from Cedric on v2 patchset
    Removed some more pre-2.10 migration hacks in patch 9/14
    Removed pseries-2.12 and pseries-3.10 also as due for removal.

v2: <20241001092910.1030913-1-harshpb@linux.ibm.com>
v1: <20240917060300.943496-1-harshpb@linux.ibm.com>

Harsh Prateek Bora (13):
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
  ppc/spapr: remove deprecated machine pseries-2.12-sxxm
  ppc/spapr: remove deprecated machine pseries-2.12

 docs/about/deprecated.rst       |   8 -
 include/hw/boards.h             |   9 -
 include/hw/pci-host/spapr.h     |   5 -
 include/hw/ppc/spapr.h          |   3 -
 include/hw/ppc/spapr_cpu_core.h |   1 -
 target/ppc/cpu.h                |  10 -
 hw/core/machine.c               |  27 ---
 hw/intc/xics.c                  |  16 --
 hw/ppc/spapr.c                  | 387 +-------------------------------
 hw/ppc/spapr_cpu_core.c         |  12 +-
 hw/ppc/spapr_pci.c              |  92 +-------
 migration/savevm.c              |  19 --
 target/ppc/cpu_init.c           |   6 +-
 target/ppc/machine.c            |  72 +-----
 14 files changed, 18 insertions(+), 649 deletions(-)

-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2443E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 03:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTYFm-0005ZO-EL; Thu, 02 Jan 2025 22:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tTYFk-0005YN-DB; Thu, 02 Jan 2025 22:21:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1tTYFi-0001gV-8c; Thu, 02 Jan 2025 22:21:35 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502IJgwl000608;
 Fri, 3 Jan 2025 03:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ieOdErS3TPZHUGtJEBRPCxFig9ZC8aU6tfkklfncX
 nM=; b=PO7g74y+wdWpSUPdCxLMtQt7uRDSoK1B/cN2O2xbTWyXG8sgMMxHfIEGQ
 HLuId1UOc2Pd6sYU/NqWt7zWHXX57w6oR3fJAUrqYRCLSJX6qftNWSWRWPujF1OU
 YpbekqNmbkkzAZkKNrMa8Pq9lAtDLxDhoqKbY7oWBmP/kUWELDAk0rX9ZLPyAGph
 rUa+dX2NiFj0wUoLj5MmSsRgGtFG+MDdGrqvU369jxYFE/07H3xZaJNAhB/dHAnV
 nHCZexlKpYB5v3L7ffW/ObAieyCgrSdtrSb6y2xnjAUE0rDUuva53B81eDRC68vl
 BVwieI95IjIjoF9Lsu928hHtUgh/g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43wk9bck2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 03:21:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5033KG19011303;
 Fri, 3 Jan 2025 03:21:29 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43wk9bck2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 03:21:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5030PDNN014606;
 Fri, 3 Jan 2025 03:21:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunsvun4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 03:21:28 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5033LRiU30474994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jan 2025 03:21:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D61E858055;
 Fri,  3 Jan 2025 03:21:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD33D58043;
 Fri,  3 Jan 2025 03:21:27 +0000 (GMT)
Received: from gfwa829.aus.stglabs.ibm.com (unknown [9.3.84.19])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jan 2025 03:21:27 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, dantan@linux.ibm.com
Subject: [PATCH v2 0/2] Add new PowerPC Special Purpose Registers
Date: Thu,  2 Jan 2025 21:21:10 -0600
Message-Id: <20250103032112.18247-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8FUN29pa5XI1_pdwGEOtcE0Z74TjIwNW
X-Proofpoint-ORIG-GUID: FixyFP3AiPjXJly2LWY3alBPi-9CoMAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=669
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030023
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: dan tan <dantan@linux.ibm.com>

*** BLURB HERE ***
Version 2 summary:
    (DAWR1,DAWRX1):
        - spec reference: https://files.openpower.foundation/s/EgCy7C43p2NSRfR
        - corrected commit message format
        - combine DAWR(0/1) handling into a single function
        - add DAWR1 & DAWRX1 to init_proc_POWER10() only.

    RWMR (Region Weighted Mode Register) -
        - corrected the previous definition as ITV1
        - spec reference:
            https://ibm.ent.box.com/s/tmklq90ze7aj8f4n32er1mu3sy9u8k3k (Power9)
        - it appears that part of the previous upstream request SPRs
          (SPR_POWER_MMCR3, SPR_POWER_SIER2, SPR_POWER_SIER3) are
          already in the current master. Therefore, removed those
          from this request.

dan tan (2):
  ppc/pnv: Add new PowerPC Special Purpose Registers (DAWR1,DAWRX1)
  ppc/pnv: Add new PowerPC Special Purpose Registers (RWMR)

 include/hw/ppc/spapr.h   |  2 +-
 target/ppc/cpu.h         |  8 +++--
 target/ppc/helper.h      |  4 +--
 target/ppc/spr_common.h  |  2 ++
 hw/ppc/spapr_hcall.c     | 24 ++++++++------
 target/ppc/cpu.c         | 69 ++++++++++++++++++++++++++--------------
 target/ppc/cpu_init.c    | 20 ++++++++++++
 target/ppc/excp_helper.c | 11 ++++++-
 target/ppc/machine.c     |  5 ++-
 target/ppc/misc_helper.c |  8 ++---
 target/ppc/translate.c   | 21 ++++++++++--
 11 files changed, 127 insertions(+), 47 deletions(-)

-- 
2.39.5



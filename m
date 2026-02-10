Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9A5EA8115
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo50-0007ST-TR; Tue, 10 Feb 2026 08:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo4v-0007RE-VM; Tue, 10 Feb 2026 08:47:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vpo4u-00052A-2d; Tue, 10 Feb 2026 08:46:57 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A9U6Yh169452; Tue, 10 Feb 2026 13:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Pe453rDwToRChHAO124jyqiUlaMCqYOpjOL4XdZgN
 Mo=; b=CIpuA2tx9+Qp4d6jTRdtjNUYEndQJojMMYBXER+xYidbu3EFDWgh5QBTL
 9hwxeVpQHhy+mKIPy03zv5l6LLTGLm1iZ1F5UShOLeczq1WBp0nnjggivirD2WeI
 lZ7+P4nDJxBzeeFbs5qYzwMcg5XHoWyrxcik500wnZQN50rJEz1XWYPAdhg3xxpQ
 gJArEvu8fikZ0PmaDNcYbXnI01OYQ/KaBze72IdCL/lGN2j2/5ze/qXdICpuhS4k
 vsGx4tNOG7AK/hE1oFXVEC2bIDSZhLtBSlSzMYFNZ9vUFe1jxdJQQS99WSujR+d3
 /TAZxmVMxFpzZn3VwMOIz+MMRdCEw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w4fda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ABnpAK001819;
 Tue, 10 Feb 2026 13:46:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je216ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:46:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADkpXt24642300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:46:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D4AD58054;
 Tue, 10 Feb 2026 13:46:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C564258050;
 Tue, 10 Feb 2026 13:46:50 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:46:50 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v2 0/3] Power10 PowerVM bringup fixes
Date: Tue, 10 Feb 2026 07:46:44 -0600
Message-ID: <20260210134647.2050821-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698b36ce cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=wsckn3v4uuCIM04AuRIA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: yyDA9Z72D8h9gDCGHBoNR3YH1Cfbzl3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExNiBTYWx0ZWRfX1B4sD2K0pysL
 hZPPe754kctd23JBO0dV0AmB/MnSxYOaw5JPlYNJCT2vf8BoaVMNbVZjyodteCyntnASUMEP7XH
 lOGg+i5E644UyaqnI/N/F99DbGI6Jg+/TyHyJxvMpf5/t6pMPFn4B0WKKF9VE9qJ4kVqA4bWLkU
 PjAzzBayQAJSX4ZVuNQ5lMVguZ689jdo4/l67yj98rvlQ838DjH3La3I9M8MkAP6KEEYAWAJIzH
 Q7pHN/paJA/iRjr+EHXaexq53QkGiPtVd+YnckFb6iwLh2gvHPyewm2XWW4mGtx//DfIAkdcMjJ
 oQJ6UFWuw6smOD/KZeBYcN+tvds/n0DKieRNQ46X3AK94PETrXbc0RJpV9kkk5g09xXGE+3yROR
 qzagECkKLASsHHknEvV3ASXyiGPE3D/jUvRk5JIMjwRoFDEbD9QGI6e0PkWKm9yaAl2Z/phMyZk
 5jUXqSCtRJqNB87N3+g==
X-Proofpoint-ORIG-GUID: YxndTaVmiXfXXDN72hbg9-0nop8TXt2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Updates in V3:
- Register comments added to pnv_core.c

Updates in V2:
- Removed pnv_chiptod patch, per review comments
- Spelling cleanup in pnv_occ.c

Tested:
passed make check

Glenn Miles (1):
  ppc/pnv: Support for SECURITY_SWITCH XSCOM register access

Chalapathi V (2):
  ppc/pnv: Add unimplemented quad and core regs
  ppc/pnv: Add OCC FLAG registers

 hw/ppc/pnv_core.c        | 87 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++--
 hw/ppc/pnv_xscom.c       |  2 +
 include/hw/ppc/pnv_occ.h |  4 ++
 4 files changed, 145 insertions(+), 3 deletions(-)

-- 
2.47.3



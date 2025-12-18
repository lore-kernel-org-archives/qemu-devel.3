Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A653D6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWKEL-0005NZ-AU; Thu, 18 Dec 2025 15:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEG-0005My-Q6; Thu, 18 Dec 2025 15:04:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vWKEF-000841-91; Thu, 18 Dec 2025 15:04:04 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJmGcK031748;
 Thu, 18 Dec 2025 20:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=E8tsIE9G1YWq14FWee9S3pxOT3j7j1AWLK45ZRKRi
 rs=; b=fbumvNeTGsJ1hc4WnekzIXJxYXtsbWiO+Q8nQH1WBXMswial6gd3otFA0
 pMT19o7ctE9ElsVNMEadwpmlbl5tXS3HTWG3kS2gltxAdF3hPNofvyedXmHMOos9
 Xhf4fB1ztXRTvNAxbfqObBAJETBwV1vtjnLACvcfW06Dfdia/9F2y2uEyvxw7s9z
 GJEZJblN7jx6o7XQSxfsPuY1e9GK35O8UweTmolIuomBhi3KXXwVA7OGdyV7ub2O
 msZGRRKncugIM1BEUW+WCb6fqmQsar/4mduPi2xPCpj9rNMh7VsNyN2r/Hg/MFlD
 5Ie7027weRf9RrBv2mmzL87dSzgcA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3dg2xa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIK40qA032218;
 Thu, 18 Dec 2025 20:04:00 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3dg2x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:04:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJXuYu029562;
 Thu, 18 Dec 2025 20:03:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b4qvqr4my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 20:03:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIK3wCm32375426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 20:03:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63C8C58055;
 Thu, 18 Dec 2025 20:03:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF17658043;
 Thu, 18 Dec 2025 20:03:57 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 20:03:57 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH 0/4] Power10 PowerVM bringup fixes
Date: Thu, 18 Dec 2025 14:03:49 -0600
Message-ID: <20251218200353.301866-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qJQGFY8oUzCmqpSZ-FFiPbdp5A76j-y7
X-Proofpoint-GUID: jkWMWuWryazPM4Evf1RwPTbrs9SCaca0
X-Authority-Analysis: v=2.4 cv=KrZAGGWN c=1 sm=1 tr=0 ts=69445e30 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VzSv0io4npWpOklQZk0A:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2NCBTYWx0ZWRfX3aZvG0eBgSt/
 V1cYw2/KeIbNXnb+r75exFi1ZykOWJP9seM5XKtDp6fd7T7g0LFkYUC01Qbc1KrrPRrMtwlDITD
 lGDpqt/6/TLDkvgKKENJJY5OP1igustaUOuA+gDjRR3gSlWgr+OaFS29pM663TXXjZNKW53RqC4
 40lTEXrafw/cDdi/PgbNHf+Da6ApvcV8MdfvHsIEXyGdJOrD9o+bzOUmQbqPdQhFMiBdFznZkv4
 453kyRg53+ujqljxLCnMEyuB7YHyuWQ3bTh9EXIPG7tKWAWCuLuEMDlqSMqiJG21B3/hmWULlAh
 UiIuiFP+NlYKSDHVwaJBXCfxb9EfJxFG/hlbZPG1/uWKK/8YUA9wAxR4pqTVqS9k+oNizB84eBE
 GQJ4Oy5lSl9QQgbqYcoND6uEwpaLDtXT6Is7eABz3N3e8QcQyfnpDr7BYMaJ5FttXo5JPC1zTcS
 iRzJ+WIkUQNFoEXGoIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512180164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Additional fixes for bringing up PowerVM on Power10 ranging from
chiptod, security, core, and OCC.

Tested:
passed make check

Glenn Miles (2):
  ppc/pnv: Suppress some "pnv_chiptod unimplemented register" messages
  ppc/pnv: Support for SECURITY_SWITCH XSCOM register access

Chalapathi V (2):
  ppc/pnv: Add unimplemented quad and core regs
  ppc/pnv: Add OCC FLAG registers

 hw/ppc/pnv_chiptod.c     | 18 +++++++++
 hw/ppc/pnv_core.c        | 81 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++--
 hw/ppc/pnv_xscom.c       |  2 +
 include/hw/ppc/pnv_occ.h |  4 ++
 5 files changed, 157 insertions(+), 3 deletions(-)

-- 
2.47.3



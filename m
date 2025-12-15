Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9EED5B84D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCDb-0002Uz-0U; Mon, 15 Dec 2025 12:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDP-000293-8N; Mon, 15 Dec 2025 12:18:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVCDJ-0002gZ-Tu; Mon, 15 Dec 2025 12:18:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFBm7no004481;
 Mon, 15 Dec 2025 17:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TP6+tWwfM0xS5x43f0hZAWrYtdGpRP4P4/0a+VTbb
 F8=; b=S/ZQFFLcmlkH49bukkysoGTwPZbqkZAIY2yJzHJl9A8+VoAur/tqs6FXt
 2ZJF60f96poouRk7yoypLssYgGUmOM1bJI10YrhtQQTaEvM2r3UAcVZ5pyffOxnM
 heKEMsbt97/UaQEYR13iucmRQ7q6DCCKAunOiI9JWG+92hp1SGQ/yE5bjc0xiEsW
 ZjxW/xT2REtnRoF2XZe70PCTKwTGuxkeWHWAyaa+ZcTxa63SCvgiHAQzE7OeY69m
 v1LHArkbRpTSOeWBBvUfgr09UTzHKspI8DkUDRwm2NxKY0+5sHShcVMRilEb1n33
 tLrpj15smWmXeyNH+vVrtGEFeJGuQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8b5xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BFHILNX024424;
 Mon, 15 Dec 2025 17:18:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8b5xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFExYDx012800;
 Mon, 15 Dec 2025 17:18:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juxytvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Dec 2025 17:18:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BFHIIvS4195018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Dec 2025 17:18:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 348285805A;
 Mon, 15 Dec 2025 17:18:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7FA558063;
 Mon, 15 Dec 2025 17:18:17 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Dec 2025 17:18:17 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v2 0/7] hw/ppc: Snapshot support for several ppc devices
Date: Mon, 15 Dec 2025 11:18:06 -0600
Message-ID: <20251215171813.1670241-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX0r0aEMMQ2HpN
 S21Viv/CRVfXG7rbSGFtu3o80Z/4oRoeywv9aGvDuIB8DqxK+Ut9BTlD/1f63fKfDtXl4sw3YSL
 NKFpMGoK/edKTTZZDcklrjfXvEL8hsmpZV8Z8uH7XLn2MbfCBu6vre70wTpLteLo4fl8SMujmyq
 nFWFnSI2/05SivpJcWYOlpMLi1LtZe51Aqe0qCJ9C4O/YluFNYEMtxR7OHtslIJJBqh4Sf5QZ99
 5E1tqxxV266divnir/IecFBy31YnJO+kEcqhuuPnAJProwM1+NUtzTIHfuYF9M9UTqzkYP9B9Ds
 VhnLmmdIQPRM4JO+m3l6w8/n61rN/E13ZO+vCbTRHGu/hTZYnfEeCNwAt+GTDACKnccjgdrOyZB
 +y2UskBkFq/gwR5tXRugQ4g+q4mX9w==
X-Proofpoint-GUID: yfMQ7CXrgQezSljg43a72m_abK-cpyTU
X-Proofpoint-ORIG-GUID: HXSSGDPCcgPSHAAbve6eI_PlhbRjHQ4V
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=694042dd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ne1qJFFQzzWKJjgbsqMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_04,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Addressing comments from V1 review:

Updates in V2:
- Added new patch set for PnvPsi support as it fits with the rest
- Added vmstate support for Power8 and Power9 for LPC
- Fixed pnv_core.c commit message

Tested:
passed make check

Thanks,
Caleb

Michael Kowal (2):
  hw/ppc: Add VMSTATE information for LPC model
  hw/ppc: Add VMSTATE information to PnvPsi

Caleb Schlossin (2):
  hw/ppc: Add pnv_spi vmstate support
  hw/ppc: Add pnv_i2c vmstate support

Angelo Jaramillo (3):
  hw/ppc: pnv_adu.c added vmstate support
  hw/ppc: pnv_core.c add vmstate support
  hw/ppc: pnv_chiptod.c add vmstate support
  

 hw/ppc/pnv_adu.c             | 12 ++++++++++
 hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c            | 22 +++++++++++++++++
 hw/ppc/pnv_i2c.c             | 11 +++++++++
 hw/ppc/pnv_lpc.c             | 41 ++++++++++++++++++++++++++++++++
 hw/ppc/pnv_psi.c             | 46 ++++++++++++++++++++++++++++++++++--
 hw/ssi/pnv_spi.c             | 27 +++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 8 files changed, 197 insertions(+), 2 deletions(-)

-- 
2.47.3



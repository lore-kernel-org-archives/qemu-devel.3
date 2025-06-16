Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4730FC71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAP5-0004Wb-7B; Mon, 16 Jun 2025 10:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAOu-0004N6-MG; Mon, 16 Jun 2025 10:01:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uRAOs-0002hW-37; Mon, 16 Jun 2025 10:01:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GABEwL019190;
 Mon, 16 Jun 2025 14:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=UZnuRWgBuZpJZ4P3qMgVtHBOtyRlXkD0pz4WrduOk
 3c=; b=QWL41nbZCkP6zqgX4O+q7/BDa4OmbSBc3TEQxjT7X6dxRoQrpbVGLGyft
 T3MiJUZ3WGYbpg4MLk6Wen0ukOXLVGGa3YAZSwq/PMYOX2qyzmSUGznkUJDY8Cj0
 dXe4aPsAFfw5EXhXFgMyj9aSXRnVGEPC33FXGXQ0dWl6GrS5hwELhIm6P/QZZATy
 5i+7Wlz4YM03UZzILEBmwicvcbXoESwlJ3FlPrQHBG96ZfG1WwL5L4V1+vlqRNTi
 vTQ5d0WrqtjE/JCvyWfrI1Q4DUDhEp2JFGPDj8kU2n1uwtdJeRdbW1KrjYFgAX4g
 /RTDwz0aMsxMw7dj6KaNjvoReaJOQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790tdt94r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GBv1YU010853;
 Mon, 16 Jun 2025 14:01:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdt6knn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 14:01:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55GE1IHS42467614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 14:01:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0AE220063;
 Mon, 16 Jun 2025 14:01:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 613262004F;
 Mon, 16 Jun 2025 14:01:18 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 14:01:18 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v6 0/3] Add SCLP event type CPI
Date: Mon, 16 Jun 2025 16:01:04 +0200
Message-ID: <20250616140107.990538-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C8vowDyZDjactYzjG3YmFKEG2KevNB7U
X-Proofpoint-GUID: C8vowDyZDjactYzjG3YmFKEG2KevNB7U
X-Authority-Analysis: v=2.4 cv=c92rQQ9l c=1 sm=1 tr=0 ts=685023b3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=f4h7crwb3-BDZkw7WFEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA4NyBTYWx0ZWRfXxu4MrtLCYNxS
 0oOLFlEALMM2qV9w9Xkb1fFA6WKeZYInHPO7/46i2dc2T6eL4pqs0Mzi/+ABUgsktwJhqv9Pv6Q
 TYrmAd/32kkvDkmroqZq1GoB7pIItAtTor4CZQXTbvwvJbF4sKzp7xeWGO+NSE9QBqznHneduee
 H7aB1HwMbi1FW/SulsMhD1zEfDT+sULDoSOc167NHUSGlclih3rjZ02VoU++2h5H/CwsQBgcyT8
 7mmN/OY+r5XEJjIc/kdnOeNpSR/Df4LXu3OVNq3Q7NbKg2JimyVR3xnMhr33Vugb8pyU45uKxF2
 PL1Te9Q/lAi+jNDQTjik+yhaaRwKIEu+RPbncunXr4SZ9aErwuZkOtN51+n0kug2KzZ15i8jVsp
 NbTHwCHrFRjeNUeEwplP0+IwefFei8ElkmLisXtqW5MQkyiuKW1qzHQwqTLqYDE9SUOvGawM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
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

Implement the Service-Call Logical Processor (SCLP) event
type Control-Program Identification (CPI) in QEMU.

Changed since v5:
- Add identifiers as class properties instead of object properties
- Add description for all the class properties
- Remove S390ControlProgramId as it is not needed anymore
- Update description of system_level identifier
- Add Reviewed-by tags

Changed since v4:
- Remove the object control-program-id and add the CPI attributes
  directly to the sclpcpi object
- Instantiate sclpcpi device from v10.1 instead of v10.0
- Other minor changes

Changed since v3:
- Add QOM object sclpcpi from ccw_init()
- Add SCLPEventCPI state to store the CPI data in the sclpcpi device
- Other minor changes

Changed since v2:
- Add SPDX license tag in the new file hw/s390x/sclpcpi.c
- Store the control-program Identification data in the sclpcpi device
- Update the description of CPI attributes
- Use ldq_be_p() intead of be64_to_cpu()
- Return the CPI attribute system-level as an integer in QMP
- Add compat handling for backward migration
- Other minor changes

Shalini Chellathurai Saroja (3):
  hw/s390x: add SCLP event type CPI
  hw/s390x: add Control-Program Identification to QOM
  hw/s390x: support migration of CPI data

 hw/s390x/event-facility.c          |   2 +
 hw/s390x/meson.build               |   1 +
 hw/s390x/s390-virtio-ccw.c         |  22 +++
 hw/s390x/sclpcpi.c                 | 213 +++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h  |  17 +++
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 6 files changed, 256 insertions(+)
 create mode 100644 hw/s390x/sclpcpi.c

-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C05C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 14:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzFhp-0007G9-2P; Mon, 31 Mar 2025 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhm-0007FE-13; Mon, 31 Mar 2025 10:01:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tzFhj-0002vt-Pl; Mon, 31 Mar 2025 10:01:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VCRteo026641;
 Mon, 31 Mar 2025 14:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iudA85r25R64LHp2CR1TIJG+6LNI6Y9hWtJpjMxbv
 GA=; b=cH/5We2sc9ZB2EjoUpmuK0MUm0lk1lo2BPlxwEBmw6D6vp6FAvwEFcrpF
 lZXOE07SkkKcegU13c79al/qIqr8uzrlqfHKSjbY331s2x1V3Ll404kWiHkhuWsh
 sDSeB7jqbaQpOZtwrHlembPHv588055XClxGIbt1RRi0Deib521mQk7Yus5wO4+p
 FgcVzhGIh9JsCQL16Mk1SlaL1GDU/Ds2RBTAP16YMkflWZoGmdi074O2SnE7LxGm
 73eI76gd/0Jr6FSTRBXY2zaGM1wVL8/L6Ym2niZXNUWdsnkYg9qG5xac833uILfg
 UnH6OntXyKHqr3x4xwXFXjjMCEAcw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qu328etc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VAbEig014555;
 Mon, 31 Mar 2025 14:01:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpkwy6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 14:01:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52VE1Alw21692740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Mar 2025 14:01:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 433DC20043;
 Mon, 31 Mar 2025 14:01:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17B0920040;
 Mon, 31 Mar 2025 14:01:10 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Mar 2025 14:01:10 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v3 0/4] *** Add SCLP event type CPI ***
Date: Mon, 31 Mar 2025 16:00:37 +0200
Message-ID: <20250331140041.3133621-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3FoWozYQdu9YrdaDAQh468uNWs7MDiQV
X-Proofpoint-ORIG-GUID: 3FoWozYQdu9YrdaDAQh468uNWs7MDiQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=801 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changed since v2:
- Add SPDX license tag in the new file hw/s390x/sclpcpi.c
- Store the control-program Identification data in the sclpcpi device
- Update the description of CPI attributes
- Use ldq_be_p() intead of be64_to_cpu() 	
- Return the CPI attribute system-level as an integer in QMP
- Add compat handling for backward migration
- Other minor changes

Shalini Chellathurai Saroja (4):
  hw/s390x: add SCLP event type CPI
  hw/s390x: add Control-Program Identification to QOM
  hw/s390x: support migration of CPI data
  hw/s390x: compat handling for backward migration

 hw/s390x/event-facility.c         |  28 ++++-
 hw/s390x/meson.build              |   1 +
 hw/s390x/s390-virtio-ccw.c        |   1 +
 hw/s390x/sclpcpi.c                | 196 ++++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h |  12 ++
 qapi/machine.json                 |  58 +++++++++
 6 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/sclpcpi.c

-- 
2.47.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF4EC369A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2tXo-0000uE-VU; Thu, 10 Apr 2025 11:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2tXi-0000t3-LI; Thu, 10 Apr 2025 11:10:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1u2tXg-0003Z0-5H; Thu, 10 Apr 2025 11:10:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9vhPO025345;
 Thu, 10 Apr 2025 15:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Ab/BHL0lArJCHUhVhBt1DPVWxV4INq05DYa7wyjNg
 hI=; b=FNjr6pfo0PMOeYBNjgaTagSTh/qec8ZWKk6Ujh5iXEGd2dpQtX2JRn1Qw
 QkAuXZ0QEW3Q2bt3h+b4zdFByddBg46jeNFvMEO/DJQJdMApi1LXzzOhLAZfI8+9
 YJ0avBIpuqNuhVS4CCGL6Gopvh93Q06p6Rz5eq+b9dPp4ZDcG9EdQOg94RDRt8pB
 a15LxK7lJDNNbtJLgGBWQhBqlzOX6nt2gnnnd+Y7YkXeKG2Pk0WtUE3hdSF7r2H8
 9eGQ8j08lxl15ckrR/R16zsDIzyAr/4kxXzcKmz2a09VOQ8jTtMkyk3VUJHivy7B
 6W5eyUOUGv+vDMkJAh9uUPeqy+4NA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ww2xeg6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 15:10:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACPNgR011062;
 Thu, 10 Apr 2025 15:10:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yxpk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 15:10:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53AFA2KH46072144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 15:10:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D90D820043;
 Thu, 10 Apr 2025 15:10:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E2020040;
 Thu, 10 Apr 2025 15:10:02 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 15:10:02 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v4 0/4] Add SCLP event type CPI
Date: Thu, 10 Apr 2025 17:09:30 +0200
Message-ID: <20250410150934.1331433-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A-PwLCh-Fvat5scaKFA_R8AjlqZ1KkGt
X-Proofpoint-ORIG-GUID: A-PwLCh-Fvat5scaKFA_R8AjlqZ1KkGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=995 bulkscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement the Service-Call Logical Processor (SCLP) event
type Control-Program Identification (CPI) in QEMU.

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

Shalini Chellathurai Saroja (4):
  hw/s390x: add SCLP event type CPI
  hw/s390x: add Control-Program Identification to QOM
  hw/s390x: support migration of CPI data
  hw/s390x: compat handling for backward migration

 hw/s390x/event-facility.c          |   2 +
 hw/s390x/meson.build               |   1 +
 hw/s390x/s390-virtio-ccw.c         |  22 ++++
 hw/s390x/sclpcpi.c                 | 156 +++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h  |  22 ++++
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 qapi/machine.json                  |  58 +++++++++++
 7 files changed, 262 insertions(+)
 create mode 100644 hw/s390x/sclpcpi.c

-- 
2.49.0



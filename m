Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827DDC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4guo-00072D-Ki; Tue, 15 Apr 2025 10:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u4gub-0006gs-76; Tue, 15 Apr 2025 10:05:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u4guX-0003RR-Ce; Tue, 15 Apr 2025 10:05:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F972Cl020523;
 Tue, 15 Apr 2025 14:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=X+73UDQsPC26s3Go6KW8Gjk0NsxdGKFvId6wG4sTQ
 wM=; b=O1H2q6WBOdypWvBs/he1Q+f4gxMkLWNHlLBnEtK5ch8MxxmCDPXvHeFqP
 Br8+Q7IjoBcS+auJDPXAfjp98D7i/R3qSYu9TapQvLcEaw/TrU0Ehpm4TOPoq8Av
 MzdC3KGko1y1qbix/S17O4W2lMiXdjsOSAsNGCE0vV5SkhKoDaCa+CocYwoY6jlh
 NYFh/e7ee5MCy1U3t2wD3uhqXEcZdm9v1kehWAx9MTDetT3PmrbVBBbJRuhbUHeb
 Eq1oUNREe1cTc5DfhZeVDJT7/9eyvlrcEpSjj2dva3KOvdAhtTG3a7Y5Y0cPGmcU
 MsXDBFab4rkE/9IDJ1D86LcW5bAfQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af5418r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 14:05:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAA5t6017174;
 Tue, 15 Apr 2025 14:05:09 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kua12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 14:05:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53FE58Ig17695314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 14:05:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0261F5805B;
 Tue, 15 Apr 2025 14:05:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9E4D58058;
 Tue, 15 Apr 2025 14:05:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.248.247])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Apr 2025 14:05:06 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v5 0/5] Report vfio-ap configuration changes
Date: Tue, 15 Apr 2025 10:05:01 -0400
Message-ID: <20250415140506.1516-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iI4rUVZ5Ho4USpsSTW-WDb4K0wp9o6a5
X-Proofpoint-GUID: iI4rUVZ5Ho4USpsSTW-WDb4K0wp9o6a5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Changelog:
v5:
- configuring using the '-without-default-devices' fails when building the code
- created a stub file for functions ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event
- add if_false for 'CONFIG_VFIO_AP' use ap-stub.c in meson.build
- add the use of the stub file to MAINTAINERS since it's a new file

v4:
- allocating cfg_chg_event before inserting into the queue
- calling nt0_have_event in if loop to check if there are any
elemenets in the queue, then calling QTAILQ_FIRST when the check
passes
- moving memset() after the check

v3:
- changes that were made to patch 3/5 should have been made in
patch 2/5

v2:
- removed warnings that weren't needed
- added unregister function
- removed whitelines
- changed variable names for consistency
- removed rc variable and returning 1 or 0 outright
- reversed logics for if statements
- using g_free() instead of free()
- replaced hardcoded numeric values by defining them with #define
in the header

--------------------------------------------------------------------------
This patch series creates and registers a handler that is called when
userspace is notified by the kernel that a guest's AP configuration has
changed. The handler in turn notifies the guest that its AP configuration
has changed. This allows the guest to immediately respond to AP
configuration changes rather than relying on polling or some other
inefficient mechanism for detecting config changes.

Rorie Reyes (5):
  linux-headers: NOTFORMERGE - placeholder uapi updates for AP config
    change
  hw/vfio/ap: notification handler for AP config changed event
  hw/vfio/ap: store object indicating AP config changed in a queue
  hw/vfio/ap: Storing event information for an AP configuration change
    event
  s390: implementing CHSC SEI for AP config change

 MAINTAINERS                  |  1 +
 hw/vfio/ap-stub.c            | 23 ++++++++++
 hw/vfio/ap.c                 | 82 ++++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build          |  1 +
 include/hw/s390x/ap-bridge.h | 22 ++++++++++
 linux-headers/linux/vfio.h   |  1 +
 target/s390x/ioinst.c        | 11 ++++-
 7 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/ap-stub.c

-- 
2.48.1



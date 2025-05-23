Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EB2C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIUsS-0003wX-Ou; Fri, 23 May 2025 12:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIUsF-0003tW-7Y; Fri, 23 May 2025 12:03:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIUsC-0002tV-0n; Fri, 23 May 2025 12:03:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NAargj025515;
 Fri, 23 May 2025 16:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7NRZwqa8N6fHssIVpdG0d8OITO04r58mgjtZMbCFO
 5s=; b=Weu9dBxslUf4LS/LuNYtrZw41/e+rnCIUQUksf7FDmPTl+VsAxMYXDFGe
 CR9k+RDqDVTw+AIrwJtq148EmVZ0u4F0ZC59idzSlbo8vq0+QuamQGeWTWmUxCiH
 2x4CTBb6qyerK29r1OznMOZQ//dbJxn2xBE3cxCZwrTfxWDYm4fiudFIBTwxBvwf
 l9QQCjlwfWu2pie84dY+qkK6qCW3TIbnCU6rFN8ygoK2dw2ovI0xtQEa0foNy7Tt
 K8E/mABVDP0T+8E3LO/FOAppuHNp7tyDHRj+MF/bePlhNiy+Cf+rnu4QbNxnUItc
 cJKz0DUhFIgtNaCVAe5GIrPowXs5w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9j957xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 16:03:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEuY53032076;
 Fri, 23 May 2025 16:03:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnmq9jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 16:03:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54NG3djD13697668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 16:03:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48C125805A;
 Fri, 23 May 2025 16:03:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86CA458051;
 Fri, 23 May 2025 16:03:38 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.240.236])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 16:03:38 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v11 0/4] Report vfio-ap configuration changes
Date: Fri, 23 May 2025 12:03:34 -0400
Message-ID: <20250523160338.41896-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N0X_dNsFOARs4NGFxWBKF7Gv0gRCd4rn
X-Authority-Analysis: v=2.4 cv=O6Y5vA9W c=1 sm=1 tr=0 ts=68309c5d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=dt9VzEwgFbYA:10 a=oB4wincVlwQkxkIkRscA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE0NSBTYWx0ZWRfX4Q2fwZO0tlyB
 6aoHJQ9NF/x1cBRAxup+vPqG2t6Jw/FwTx2BGZZA0MHD6dzV5wFrDRaQcO7hrgNOyfcOiz1jeS8
 D736w4Oitg6p7H6cXaQMFIIFcjuHnsuuXJonBgQgsHT3c+u2JMLNgqJ/5HkmJATbTzCJrzlyEfT
 AYDKSg4mklwE1Fz8RgpxGmPpm9kDmUVjOcDM4ePmNwJKjOhv3wKERl7Zm2RmzpJZRPIENSgrZzL
 7nvS7OhIHhOi0NDl0+rzfN6QPWNf/aC35YWO1KaBUrTN4pW3MmwPUwE9KgUOCxw9jFywhP6uiOG
 LDl3e7LDyYYWeULTVL+QrtQ9SHSkLBKey906kOTFnswGPJn87KgvIT5Do6AvtPWWG3edWkxmkor
 OCGNcZhLcs8s+ywPouGPfQ5tN4zYiNEhpy6YpAFa1oX+sZKA9/eeyIC48/j4aS6LN8bmyrj0
X-Proofpoint-ORIG-GUID: N0X_dNsFOARs4NGFxWBKF7Gv0gRCd4rn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230145
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
v11:
- reverted return type to int for 'ap_chsc_sei_nt0_get_event'
   - files reflected are 'ap.c', 'ap-bridge'h, and 'ap-stub.c'
- using defined variables to represent return 0 and 1 to reflect logical sense
- update documentation for 'ap_chsc_sei_nt0_get_event' to reflect return types

v10:
- Added reviewed by for patch 4 by Tony and Cedric
   - review needed for patch 2 and 3
- changed 'cfg_chg_events' to a static variable
- locked 'cfg_chg_events' using QemuMutex
- removed ';' at the end of the definition for NT0
- returning bools for 'ap_chsc_sei_nt0_get_event' and
'ap_chsc_sei_nt0_have_event'
- updated the header file that contains 'ap_chsc_sei_nt0_get_event' and
'ap_chsc_sei_nt0_have_event' to a bool function
- added documentation explaining the returning bool functions
- whitespace clean up

v9:
- added SPDX licensing to newly created file 'hw/s390x/ap-stub.c'

v8:
- fixed windows cross-compile build
- moved /hw/vfio/ap-stub.c to /hw/s390x/ap-stub.c
- updated the use of stub file to MAINTAINERS to reflect new location
- removed if_false for 'CONFIG_VFIO_AP' statement from /hw/vfio/meson.build
- added if_false for 'CONFIG_VFIO_AP' to use ap-stub.c in /hw/s390x/meson.build
- all those changes still address '--without-default-devices' issue from v5

v7:
- Dropped initial commit for linux-header file vfio.h since I created two new commits
to address the changes made in v6
- Moved patches 6 and 7 to the beginning of the series after dropping the first patch
   - Because I dropped the initial commit for linux-header file vfio.h, I had to add
VFIO_AP_CFG_CHG_IRQ_INDEX
- Resyncing latest to v6.15-rc3
- Still need Thomas Huth's review of v5 changes for patch 6/6

v6:
- Updating the update-linux-headers script to address kernel commit change 8a14
- Update headers to retrieve uapi information for vfio-ap for update to Linux v6.15-rc1
- Still need Thomas Huth's review of v5 changes for patch 7/7 (see below)

v5:
- configuring using the '--without-default-devices' fails when building the code
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

Rorie Reyes (4):
  hw/vfio/ap: notification handler for AP config changed event
  hw/vfio/ap: store object indicating AP config changed in a queue
  hw/vfio/ap: Storing event information for an AP configuration change
    event
  s390: implementing CHSC SEI for AP config change

 MAINTAINERS                  |  1 +
 hw/s390x/ap-stub.c           | 21 ++++++++
 hw/s390x/meson.build         |  1 +
 hw/vfio/ap.c                 | 96 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 39 +++++++++++++++
 target/s390x/ioinst.c        | 11 ++++-
 6 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

-- 
2.48.1



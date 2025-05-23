Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74D3C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 04:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIKK6-0003aq-QK; Fri, 23 May 2025 00:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKK1-0003YS-15; Fri, 23 May 2025 00:47:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKJw-0002Nv-D1; Fri, 23 May 2025 00:47:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNW3sh024626;
 Fri, 23 May 2025 04:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=oJxJrMbag1jomiczWLOyLGjfEXgja/1atBNbRGn1R
 ng=; b=QcBNJCSPmS/Lt0tC/9dOMJR8K0Lb9OCU6F7wieMLsQ0mxkPVb+bkONmO7
 3ZRVdYawIcFHgO3zk7h+4W5Io+v3zpTukfIl4NYfB4k+YEnQPmsWt5CAjziccHAn
 LaBZnPd+BvP7AtJDVg3hYdaY0fIPrlvl7bujrC/9FpxgZvgqZKAGY4XzZZH0ACWK
 BS3V8IBwDOvx/UWYl41uO+/A93HfUsG129TxQVGD3wo4ZqA6UrfcurMMj9j0cmmw
 pNydt8788oPgGq22zC0HPC7c1kDJHu38jb5gmYw/oc+gIR4DkGUGh2SpLfSRvht+
 reZXiG09mLqRHYNtxKCKnZfcCoGzw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwdnkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1XueB024664;
 Fri, 23 May 2025 04:47:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwkrcxj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54N4lgko24052438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 04:47:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 453D258064;
 Fri, 23 May 2025 04:47:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CAF258061;
 Fri, 23 May 2025 04:47:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.208])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 04:47:41 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v10 0/4] Report vfio-ap configuration changes
Date: Fri, 23 May 2025 00:47:37 -0400
Message-ID: <20250523044741.59936-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAzOCBTYWx0ZWRfX0unC+x+AfekO
 5l4p23Jtg7c+RHs3V8L7wJoGDn6Y3X83AGE7y6wc1PWRB8AA/PYhtr9q0nW59bWClO9pE0dPxpq
 Q4sEiGB4X1UPZm/5CEc8xq57FiA5TdswPe7BLxjF3vuQC80Inff5z7QVe+KPvs8X4E1Q3Q8dYgO
 vU2ZHWF5FlPcba49VF11/LGwvrHq+4gBO1Nc2wwu+hY6QKOYJ5u+SR1T/yaiWl9jCfqi1h5VMoD
 R6CkXkIIPFiUM+G5gU1z70bpOuJ66X3OoezWw/ci/lQnGXN4WyBswOViwC7F73R9OdgUZcJc2L7
 90VKzIvfpT9OITS2H5niN3ka1VghjdgC3STpqsZEq5KCuEmLJWRtCpwQnetIKqubP6+yFPswuhT
 W1fPeG9HY6CPPkleSfgk+SU//TOlAgGEGVdkXi6P/G97TaxB91CLZyJ6qMA+mDnavI5ZJoOG
X-Proofpoint-GUID: T5jacoRyqRoeL18IpE0Z5k9lSpccvckr
X-Authority-Analysis: v=2.4 cv=O685vA9W c=1 sm=1 tr=0 ts=682ffdf1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=b-2j7H-tuh0H-JaNz4oA:9
X-Proofpoint-ORIG-GUID: T5jacoRyqRoeL18IpE0Z5k9lSpccvckr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230038
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
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

Changelog:
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
 hw/s390x/ap-stub.c           | 25 ++++++++++
 hw/s390x/meson.build         |  1 +
 hw/vfio/ap.c                 | 96 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 36 ++++++++++++++
 target/s390x/ioinst.c        | 11 ++++-
 6 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

-- 
2.48.1



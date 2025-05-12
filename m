Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931FFC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXUI-0006TQ-M4; Mon, 12 May 2025 14:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uEXUD-0006Q8-77; Mon, 12 May 2025 14:02:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uEXU9-0007wL-P1; Mon, 12 May 2025 14:02:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CFq22n024635;
 Mon, 12 May 2025 18:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=OdDU+IsfUyB3rk3mZPTgu+qE9HG5yK8DPYIaWNbJ8
 pw=; b=ULOOVRqdxTfWTbgYVEFfdIm5KcglYJf28BULaiA0K1mDLWysf22CCV4x7
 OwGjqyLRSsyxY4S30TH9xQmk3g6JVxQvljV/2SzhFDNnRYjD1bJ3DhT5bg7fdoZG
 e6TbUKrQC5WSNjo3/bSKB7lX523JWn5o4e9DuJHCh5BEuouYaEaD0ijApCgCxX7M
 g/WmBlFAp9giQaB/NaBLcIonR5F8sMDtxJXoGDj9C176eWT/EYTuIbyNKXgZIPpJ
 6qJJ/KLiH/mABqND4Gj6BWA7lhyPVXPK0+CPrM/0pGL1KWfaBbKb7bP9J5OtczM/
 PsvsLRjOX0mw9l8WheAfVIFDmL8Qg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kbksu78a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 May 2025 18:02:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CEBDjJ024478;
 Mon, 12 May 2025 18:02:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmky2qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 May 2025 18:02:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54CI2VjN17105600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 18:02:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D97E658058;
 Mon, 12 May 2025 18:02:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13F6D58057;
 Mon, 12 May 2025 18:02:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.251.19])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 May 2025 18:02:30 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v9 0/4] Report vfio-ap configuration changes
Date: Mon, 12 May 2025 14:02:26 -0400
Message-ID: <20250512180230.50129-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DrhW+H/+ c=1 sm=1 tr=0 ts=682237ba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=b-2j7H-tuh0H-JaNz4oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4MSBTYWx0ZWRfX21V9jGILZxBc
 gpABStoe99ZMBZrGkPWMeq8wgvN51vDMPUMsNu3zNc5JqiQOUZhVSh0y8GZhPGYtxnV17IbgzAZ
 S6EocF1cyJ31SVy6u5JY0aTnJ9O7VXdwv/K3UW8PXggCAiKWgDpfaKslvmFIix9fq/HoEZfMkS+
 Kt0XvWN3cD2jhTUkl0w/bMiA2xLq/HwRuHXeabxpYjpRe0nigFmtbcRLWkZs83Ig1RDPcgiH+aQ
 X00TIpnhKvx35SlbQ6Smo7kEz92DIy8HzIzCGN02+L7uj4fW7qgE6fxxUopLAIL31i5F+Id5Yzy
 22yngucgsv+xqcqEJkOiaqjLdh5Q9ShEci3HFkqWaWx8I5uxf3YNo9fxEXWGyNCjeRUeANCtNt+
 d24CQ763qQmcn7CIqu+pxm6UocZeJy3HGu47YDvucB04AC3TjJzQKSof+vxK1e2QPD1qRjrL
X-Proofpoint-GUID: hiX8mdtaXYwj8s2hkMVYHWOuin6ZuVZT
X-Proofpoint-ORIG-GUID: hiX8mdtaXYwj8s2hkMVYHWOuin6ZuVZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120181
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
 hw/s390x/ap-stub.c           | 25 +++++++++++
 hw/s390x/meson.build         |  1 +
 hw/vfio/ap.c                 | 82 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 22 ++++++++++
 target/s390x/ioinst.c        | 11 ++++-
 6 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0A5C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNbwZ-0004F3-PJ; Fri, 06 Jun 2025 14:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwU-0004DQ-MN; Fri, 06 Jun 2025 14:37:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwS-0008Iq-5V; Fri, 06 Jun 2025 14:37:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F4p9M011268;
 Fri, 6 Jun 2025 18:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=cVKbOBi72xEJLWn1Y9G/3CMMGxYV
 qRgSmYcaPn76DLA=; b=F4YyPeSYzS7SaJtBEGq9xpYi7SRPZIlVKNFmz97c5ewO
 TYnyhybrkrDTfUjV9U6nIC0PBu165eRqeCJ2Tnz12BqtKzCS3r7O0wdTKWGWfthC
 fDjFx+/HCcMs/qbT5rZT3aWMEXcl96yTVorwXj1c4Hb78xqxkciVVfsuna1m2mf1
 A+sa43kEZxV/DDL0/qDPjJxAc94uPlRVr91MzAsPnsp9cMwyqkIwbq49EBt1PL9R
 HbkE4fBaEt7zT7K7vEd5H1C17WUDGcxlEVmCwny0H9f61wUtXFgqvLwwDxRz2EAd
 B6d6t4kvXucUTzOXmvL9GFSCQQlNaA7Mf4jkxi7+Lg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf07t9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556FbajL012511;
 Fri, 6 Jun 2025 18:37:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2teks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556IbHsq11403902
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 18:37:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF80858043;
 Fri,  6 Jun 2025 18:37:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9859A58053;
 Fri,  6 Jun 2025 18:37:16 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.255.166])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 18:37:16 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v12 0/4] Report vfio-ap configuration changes
Date: Fri,  6 Jun 2025 14:37:12 -0400
Message-ID: <20250606183716.26152-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Tnlh7H3ft8kOeWIwQKiClB7uDtzHaPw
X-Proofpoint-ORIG-GUID: 5Tnlh7H3ft8kOeWIwQKiClB7uDtzHaPw
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=6843355f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=b-2j7H-tuh0H-JaNz4oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE1OSBTYWx0ZWRfX8Et32hxc9j28
 0ssvKRUSfR22OKQCVfbHU4/sN+bHZAEyruWtfENv/DI1AcZEoc5ZOEhNwLM6BO9Lqm1jdRuXvZt
 +MOuv5o+1itu8o/Mr2wPzzAGZOR88tkKjWRQLXtsjWm5rl5eEclENy+SBFT3IfK0c/KMqnndND0
 oQm3cJbqTIu1MpmXE9nY8w4SUfyUO9p/avUncGx3nwLzTqiGmWCzltEDNwgac4lJoqV7WPO5yH5
 FnkRwqwfKkEEcayt6zQUJ8edLGBbW7y09uTQdqkjTRtgyyfwnngRpvb0AXIiKyduYkBx04B6Bpf
 kZajR1/4U/0TqeDiky7VGCBLmE+LoZrWX0gN9jMPzHq8pwuR+ozgei19A3K/8aMSrNIqHpj0rm9
 9BjrrrD4UbPhciKBvJpBl7xvdYPsMBF/XMsJ4zHX5EDeVKh5SDXxHobkcmBPsIQ9uMDBS6j1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
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

Changelog:
v12: 
- adding locks to 'ap_chsc_sei_nt0_have_event' and 'ap_chsc_sei_nt0_get_event'

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

Rorie Reyes (4):
  hw/vfio/ap: notification handler for AP config changed event
  hw/vfio/ap: store object indicating AP config changed in a queue
  hw/vfio/ap: Storing event information for an AP configuration change
    event
  s390: implementing CHSC SEI for AP config change

 MAINTAINERS                  |  1 +
 hw/s390x/ap-stub.c           | 21 +++++++++
 hw/s390x/meson.build         |  1 +
 hw/vfio/ap.c                 | 86 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++
 target/s390x/ioinst.c        | 11 ++++-
 6 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQin-0002Ba-Ot; Fri, 09 May 2025 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQic-00024u-5O; Fri, 09 May 2025 12:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiU-0000Bl-JB; Fri, 09 May 2025 12:36:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549D6PGg031537;
 Fri, 9 May 2025 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=2ji6DIMFZu6obA+EgFagMCy3b+RoXt6DPFqpVRchg
 bg=; b=LuTGP+3F3GzxgECZ9vImM1flGmS48ZfHBmGcPy9H6xEuNd/x8DjPKuBdZ
 pgwDvesY679l50oC9sD0eBuTCCKlu+Entl7oT/wLSbFJZUCMwley97QxS46EIDgF
 cyZIWq2CcAs5L4+4/J4A8sCDIPuGc+ifiqhKZi0bC8l0c6DgRBimSEGLrx88Uruw
 FHeXjPPTfpNzx7v3tuQFOH74moYKugG9XLIdimVGz8fZDyN2uWJ0+j2tsDnUoc8v
 /MWmM7g13u66wBiKtSuX36zWdbcmMLiqGqP4c5kAHhYELT5xV5NSyaHCzWACwb+H
 eSmWbkD/Z0sEP6y6QY/F4qliXAt6Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwd261-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549F6Uel004221;
 Fri, 9 May 2025 16:36:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2h3am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 549Gakbh27722406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 May 2025 16:36:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 472EC58043;
 Fri,  9 May 2025 16:36:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F0DF5805D;
 Fri,  9 May 2025 16:36:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.92])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 May 2025 16:36:45 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v8 0/6] Report vfio-ap configuration changes
Date: Fri,  9 May 2025 12:36:39 -0400
Message-ID: <20250509163645.33050-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e2f20 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=v06zkurBhH7fz-2jiH4A:9
X-Proofpoint-GUID: 2uecBFTHGlty0iYYSap1Fvp_f9lVnlZW
X-Proofpoint-ORIG-GUID: 2uecBFTHGlty0iYYSap1Fvp_f9lVnlZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE2NCBTYWx0ZWRfX4UASMuA+3kwM
 Qsf7nl5RzBSGMthpmkRNBYSuFzk5xYSsvyKRt3S2hGzrnbk2hhsbnLgIghOb7JXONzfxuKLFbVW
 RpZJhJy5K3GI0J7JPz1kaV5jndxaEfoaD3wuESjGgD3JnsXwbyE7GJMd4AFHyN+KO3bVFVs8AhE
 NLJLxP82Y0NqBZdJR5YXT+ianX41nRyC2jrurOXWZSpKoxX4SKvOVY72dJ/nG/rG1jDx3XMlra1
 sC+3o/rwVRO0RYJ0+e/UUJtjKCmM3vyRhVkrrjuMB3EHae6bDcoKJWEtKFMy1/agFXzhSi8+iA4
 G3jx0b3kpmpm52QNDytUgiUjK8VDkUL5vaSUHYTAT88hyOobOeS2GNven07dE4ebnFA/stXIl1g
 0WCoD39gvfEawLEw7oSj887qzKq2JuwzSWIS9dUPFjK9PwOhID/ugWF5sNEb3/iygq/MZWu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Rorie Reyes (6):
  linux-header: update-linux-header script changes
  linux-headers: Update to Linux v6.15-rc3
  hw/vfio/ap: notification handler for AP config changed event
  hw/vfio/ap: store object indicating AP config changed in a queue
  hw/vfio/ap: Storing event information for an AP configuration change
    event
  s390: implementing CHSC SEI for AP config change

 MAINTAINERS                                   |   1 +
 hw/s390x/ap-stub.c                            |  23 ++++
 hw/s390x/meson.build                          |   1 +
 hw/vfio/ap.c                                  |  82 +++++++++++
 include/hw/s390x/ap-bridge.h                  |  22 +++
 include/standard-headers/asm-x86/setup_data.h |   4 +-
 include/standard-headers/drm/drm_fourcc.h     |  41 ++++++
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/ethtool.h      |  22 +++
 include/standard-headers/linux/fuse.h         |  12 +-
 include/standard-headers/linux/pci_regs.h     |  13 +-
 include/standard-headers/linux/virtio_net.h   |  13 ++
 include/standard-headers/linux/virtio_snd.h   |   2 +-
 linux-headers/asm-arm64/kvm.h                 |  11 ++
 linux-headers/asm-arm64/unistd_64.h           |   1 +
 linux-headers/asm-generic/mman-common.h       |   1 +
 linux-headers/asm-generic/unistd.h            |   4 +-
 linux-headers/asm-loongarch/unistd_64.h       |   1 +
 linux-headers/asm-mips/unistd_n32.h           |   1 +
 linux-headers/asm-mips/unistd_n64.h           |   1 +
 linux-headers/asm-mips/unistd_o32.h           |   1 +
 linux-headers/asm-powerpc/unistd_32.h         |   1 +
 linux-headers/asm-powerpc/unistd_64.h         |   1 +
 linux-headers/asm-riscv/kvm.h                 |   2 +
 linux-headers/asm-riscv/unistd_32.h           |   1 +
 linux-headers/asm-riscv/unistd_64.h           |   1 +
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/asm-x86/unistd_32.h             |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   8 +-
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/iommufd.h                 | 129 +++++++++++++++++-
 linux-headers/linux/kvm.h                     |   1 +
 linux-headers/linux/psp-sev.h                 |  21 ++-
 linux-headers/linux/stddef.h                  |   2 +
 linux-headers/linux/vfio.h                    |  30 ++--
 scripts/update-linux-headers.sh               |   2 +-
 target/s390x/ioinst.c                         |  11 +-
 41 files changed, 440 insertions(+), 39 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

-- 
2.48.1



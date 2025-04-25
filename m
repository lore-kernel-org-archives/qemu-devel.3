Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5458EC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 05:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8BY7-0008W8-81; Fri, 25 Apr 2025 01:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXp-0008TL-3r; Fri, 25 Apr 2025 01:24:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXm-0004Gq-Ev; Fri, 25 Apr 2025 01:24:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OLdXSn006742;
 Fri, 25 Apr 2025 05:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7eQhWNqwH51NW8snEgio0pOBHtr4mdBfd8RXeLSmy
 cs=; b=BJNQD915CXs/UN+fGKJo1/VHY51PKLxnqxEspExc9ZRVWW8KWcBhvGUR0
 IGceD+R+ypauY0c4NNlvh4x3DeaNfy/4mxAat2oEOxkBuHEwMuTaEU9zMZhPyYSX
 aCWsiiWr+tCV9mxjyegl2XPg9XoF23qcI+TZSvP0qWcl5JeSMVXyq0JbLlPsqzcQ
 1sUp78VVd47wbuXpLWP9nzfQkB9/sqW68HnDhVeQo6Z979k4+rTg2DmOd7zqOiQg
 3yCmqOlPtPPZ6fHgv2doZc1Hm3Ivv9luI8Q/al0RldpIRng39IqDN2xlEy431KFi
 3cCa98ANggx8qY29pLnKgYSUtFKCA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9hfcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P4U1kF001318;
 Fri, 25 Apr 2025 05:24:04 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfy3qp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53P5O2Eg23265862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 05:24:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B960758051;
 Fri, 25 Apr 2025 05:24:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA9735805A;
 Fri, 25 Apr 2025 05:24:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.76])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Apr 2025 05:24:01 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v7 0/6] Report vfio-ap configuration changes
Date: Fri, 25 Apr 2025 01:23:55 -0400
Message-ID: <20250425052401.8287-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ix99NfHTh_qbPpvtbFOvE6IIlJgsiTzG
X-Proofpoint-ORIG-GUID: ix99NfHTh_qbPpvtbFOvE6IIlJgsiTzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzNSBTYWx0ZWRfX5z9llIsaN7Df
 IabI+uOZ0H2UgtZbR5qjDLlAwNqoUWuIN+CLoBmk4LRj5q8Azp05mCpm1Fs25u+8fjrtzGD+rTY
 M0yQVqiNGlsH3kQ0ifDq964dT/YfJztttYlHmML0KT6sK6NPuObqp4/H02buVjWoOsEmTvOuTc+
 DAStpA8LillMsDLoWBJDYi6z6faNMw7P/97Qm/7dXPrQHWUIo3MbShfA5F73mmqUU7Tkah2bcI6
 EQhKb/BJwc/lAzbC6DcN72ZBNbk168hj/uW6be1L33T+6/XxFUpYeGRLrOy4ermO3CDQiOW211k
 JN6sYsrMRh0Kx5VOKaQ1MWnOnLMbhM6Vu33D3+DEA8fASvFwdDMtM4xBDfkhcB90UQuvrtlYznU
 3p+EsHWkBf7274yYKoDh9Vd5OmrELdJ2pLBAltB0PUD07TuT2WD1hLJ6bOwHjy06XCvyCOm0
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680b1c75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=XR8D0OoHHMoA:10 a=hL4k6ZGhHxQC2pQgH1QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Rorie Reyes (6):
  linux-header: update-linux-header script changes
  linux-headers: Update to Linux v6.15-rc3
  hw/vfio/ap: notification handler for AP config changed event
  hw/vfio/ap: store object indicating AP config changed in a queue
  hw/vfio/ap: Storing event information for an AP configuration change
    event
  s390: implementing CHSC SEI for AP config change

 MAINTAINERS                                   |   1 +
 hw/vfio/ap-stub.c                             |  23 ++++
 hw/vfio/ap.c                                  |  82 +++++++++++
 hw/vfio/meson.build                           |   1 +
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
 create mode 100644 hw/vfio/ap-stub.c

-- 
2.48.1



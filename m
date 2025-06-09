Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF64C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfc6-00024S-Je; Mon, 09 Jun 2025 12:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOfbr-0001zn-OM; Mon, 09 Jun 2025 12:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uOfbn-0003fW-Q4; Mon, 09 Jun 2025 12:44:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559CrmHV001022;
 Mon, 9 Jun 2025 16:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=u7L9YGVH4qKiawdeopJ1Aw2H5lda
 tpSPLNOpk83IPNg=; b=oP5I/q7RvsqJSJnYMrMnZLS4aHHkahNUBcf5ymic56XC
 YWJ77NBL4amOx+KlqlmH13Zs8bwiQJhedHw+tK/sLZkKhadECJplIjt7hZhmYM3+
 vU9PYkx0NHGM8bqRkO/IWrTkOztT5g/oTO45uUVeodC7G4aZlDx6BaLuuVm/2fh3
 zU3kmj977PPaebEPurMxpm87vd7RYl5/QbIXZQvwMa0aiBtHgQ54dRTlGcELpAKa
 KVwRvewqE14rbgcOOo70cRgZRQmclk6F31cllTbC65xY3C8r4EGtnRLCwU1ZEWlM
 7CHnCsPBEfpg43NDpAZkfS8LuWQgsXs6fNCpny1ysA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4kxw00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 16:44:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559FeZ1R003347;
 Mon, 9 Jun 2025 16:44:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykec1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 16:44:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 559GiKUB28639858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Jun 2025 16:44:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A243358054;
 Mon,  9 Jun 2025 16:44:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7BCA5805D;
 Mon,  9 Jun 2025 16:44:18 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.253.10])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Jun 2025 16:44:18 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v13 0/4] Report vfio-ap configuration changes
Date: Mon,  9 Jun 2025 12:44:14 -0400
Message-ID: <20250609164418.17585-1-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=68470f67 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=b-2j7H-tuh0H-JaNz4oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 89IaCWO02YUAw_JoW5oik8ZL21SiIgjZ
X-Proofpoint-ORIG-GUID: 89IaCWO02YUAw_JoW5oik8ZL21SiIgjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyMSBTYWx0ZWRfXzP+3pn2qt92T
 U0Ij3KYwbU3k/9xFdtNi7le4e0h8guwR5RH59fqbawb2s04LEUnpPUz4iJlVSyEZQmdZuj19YAd
 w+yfyumdeWQ0kCo2Oyp7baBpvEbLSEIwnUujnQsHNUnCYzHE9jHiybehuAlsRJX6F0E1GahXh2Y
 KWxEBTQZnYrqUYabEeceNvDYu+5yQiWX3427wR3MveGscRq2d6S8NaNpkWyiWKj8awKhNqHqvoA
 XIvmb8vsHB23DGos9RXnAAYcNA2jnUB7VZpGWUklvYzj2u/lrhk+jsmOc8rDONwlrUMqXAk1zga
 TWF3QJOkY3MFId+V2ZAZhWAkLgeXufG6nIkSdqK37DSJHYTsAPJc1YkYbxD6pkDdsy5ox9ErfZI
 3GolhtRCmcDlFCXj7tu74yhxZEXRtwvbSodxMyodjvUAwIVF8crDQx8Jah4aGBwg3pvUCXGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090121
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
v13:
- added lock to 'vfio_ap_cfg_chg_notifier_handler' in patch 2
- added RBs for patch 2 and 3 from Tony

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
 hw/vfio/ap.c                 | 88 ++++++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++
 target/s390x/ioinst.c        | 11 ++++-
 6 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

-- 
2.48.1



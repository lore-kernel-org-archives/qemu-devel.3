Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789D2D3C912
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 01:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2Klh-0008HD-F9; Sat, 19 Oct 2024 21:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Klf-0008FS-Vb; Sat, 19 Oct 2024 21:30:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t2Kld-0005AK-R1; Sat, 19 Oct 2024 21:30:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49JNeSPK027695;
 Sun, 20 Oct 2024 01:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=W9pwxI2Gnyub3JO82A0Xev55liYQjS/VG9SXWgCom
 R4=; b=gDgH3dGxncP7OfTZOzNGcMMOX3jpCBCB07lePEYwkI3b5QPzny161BWRY
 g5Jv3lR6AtaT3C93FORWEUYngeMjCN8wfokfsv8vD3lj/cC6zX8LyqM7H+n+QXsh
 ZpZeE0NscEsRsy2VQ8LTksRUcC2Vlf/Gyr5A0FLtkV1gSxdmEvWiffsckX+r7/xS
 DcEu9N47Z+JL/KbU8I5u3GW2RxDrrpteW5ySFHGcAIgUJFWJyseoLiq2jpcgOyRF
 RDVBgQ12l13qDn9uI01y1+dQl3cjBmjRpkpGdxDtelhz8kAF8jF17K/41qQxIDqB
 i1lfDlPfsUuhMqSGunazPi/VYeF/A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fsk1sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:29:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49K0BR7Q026471;
 Sun, 20 Oct 2024 01:29:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3s07sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 20 Oct 2024 01:29:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49K1TuD336503938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 20 Oct 2024 01:29:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A041E5805A;
 Sun, 20 Oct 2024 01:29:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1B1458054;
 Sun, 20 Oct 2024 01:29:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.54.50])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 20 Oct 2024 01:29:55 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v5 00/19] s390x: Add Full Boot Order Support
Date: Sat, 19 Oct 2024 21:29:34 -0400
Message-ID: <20241020012953.1380075-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6w0hZxEznfidHkFCylVU2DJ67J-B4Siy
X-Proofpoint-ORIG-GUID: 6w0hZxEznfidHkFCylVU2DJ67J-B4Siy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=852 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410200009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

changes v4 -> v5:
- Fix a bug with per-deice loadparm support:
    The machine loadparm is no longer overwritten by device values, which now
    allows an empty machine loadparm to propagate to later devices even if
    the primary boot device set an initial loadparm
- Fix two instances where changes were squashed into wrong patch
- Fix an instance where NULL_BLOCK_NR was returned instead of ERROR_BLOCK_NR
- Fix an instance of logical AND being used instead of bitwise AND
- Standardize all error values to be negative in all device type paths
- Minor stylistic changes and code simplification


changes v3 -> v4:
- Ensure signed-ness of return values is appropriate
- Add missing newline character in replacements of sclp_print_int()
- Add a missing return in a SCSI error path
- Restore break that was incorrectly removed for Virtio CU devices
- Remove an extra/early return that caused probing to end early
- Convert "good" device to scsi-cd in a cdrom-test for better coverage
- Minor stylistic clean-ups and variable name clarifications

Jared Rossi (19):
  hw/s390x/ipl: Provide more memory to the s390-ccw.img firmware
  pc-bios/s390-ccw: Use the libc from SLOF and remove sclp prints
  pc-bios/s390-ccw: Link the netboot code into the main s390-ccw.img
    binary
  hw/s390x: Remove the possibility to load the s390-netboot.img binary
  pc-bios/s390-ccw: Merge netboot.mak into the main Makefile
  docs/system/s390x/bootdevices: Update the documentation about network
    booting
  pc-bios/s390-ccw: Remove panics from ISO IPL path
  pc-bios/s390-ccw: Remove panics from ECKD IPL path
  pc-bios/s390-ccw: Remove panics from SCSI IPL path
  pc-bios/s390-ccw: Remove panics from DASD IPL path
  pc-bios/s390-ccw: Remove panics from Netboot IPL path
  pc-bios/s390-ccw: Enable failed IPL to return after error
  include/hw/s390x: Add include files for common IPL structs
  s390x: Add individual loadparm assignment to CCW device
  hw/s390x: Build an IPLB for each boot device
  s390x: Rebuild IPLB for SCSI device directly from DIAG308
  pc-bios/s390x: Enable multi-device boot loop
  docs/system: Update documentation for s390x IPL
  tests/qtest: Add s390x boot order tests to cdrom-test.c

 docs/system/bootindex.rst         |   7 +-
 docs/system/s390x/bootdevices.rst |  29 +-
 pc-bios/s390-ccw/netboot.mak      |  62 ----
 hw/s390x/ccw-device.h             |   2 +
 hw/s390x/ipl.h                    | 123 +-------
 include/hw/s390x/ipl/qipl.h       | 127 +++++++++
 pc-bios/s390-ccw/bootmap.h        |  20 +-
 pc-bios/s390-ccw/cio.h            |   2 +
 pc-bios/s390-ccw/dasd-ipl.h       |   2 +-
 pc-bios/s390-ccw/iplb.h           | 108 ++-----
 pc-bios/s390-ccw/libc.h           |  89 ------
 pc-bios/s390-ccw/s390-ccw.h       |  36 +--
 pc-bios/s390-ccw/virtio.h         |   3 +-
 hw/s390x/ccw-device.c             |  46 +++
 hw/s390x/ipl.c                    | 282 +++++++++---------
 hw/s390x/s390-virtio-ccw.c        |  28 +-
 hw/s390x/sclp.c                   |   9 +-
 pc-bios/s390-ccw/bootmap.c        | 455 ++++++++++++++++++++----------
 pc-bios/s390-ccw/cio.c            |  81 +++---
 pc-bios/s390-ccw/dasd-ipl.c       |  71 ++---
 pc-bios/s390-ccw/jump2ipl.c       |  22 +-
 pc-bios/s390-ccw/libc.c           |  88 ------
 pc-bios/s390-ccw/main.c           |  97 ++++---
 pc-bios/s390-ccw/menu.c           |  51 ++--
 pc-bios/s390-ccw/netmain.c        |  38 ++-
 pc-bios/s390-ccw/sclp.c           |   7 +-
 pc-bios/s390-ccw/virtio-blkdev.c  |  12 +-
 pc-bios/s390-ccw/virtio-net.c     |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c    | 160 +++++++----
 pc-bios/s390-ccw/virtio.c         |  67 +++--
 target/s390x/diag.c               |   9 +-
 tests/qtest/cdrom-test.c          |  24 ++
 pc-bios/meson.build               |   1 -
 pc-bios/s390-ccw/Makefile         |  69 ++++-
 pc-bios/s390-netboot.img          | Bin 67232 -> 0 bytes
 35 files changed, 1158 insertions(+), 1076 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 include/hw/s390x/ipl/qipl.h
 delete mode 100644 pc-bios/s390-ccw/libc.h
 delete mode 100644 pc-bios/s390-ccw/libc.c
 delete mode 100644 pc-bios/s390-netboot.img

-- 
2.45.1



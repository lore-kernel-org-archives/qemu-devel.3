Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979EDCED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxypd-00042t-C1; Mon, 07 Oct 2024 21:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypb-00041O-8n; Mon, 07 Oct 2024 21:16:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypX-0008C2-0Z; Mon, 07 Oct 2024 21:16:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4980o2P7008562;
 Tue, 8 Oct 2024 01:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=0LJxQcjoQjQyDR1seKFxlP/9eN
 IzLa41G+HMhjIyBXc=; b=QI06N5+wEP9Q43iI0SBKyFdtnabArO9QK3ME+Ha7HP
 UfaHWBgsc8pOBMJ6f6qRTMRsutbWu5aFP0Z3tMpP1dvpudGE5w9oU1ie9DeH1Dty
 lhXyWhBQ1Z/qhFA6u6kxFV/nHb3sgg6LDRyLIcR/FfKH7cQKmJl5Siuq4azPNbeD
 SL1ESqUr6Ng+q6Pu1xCgbkpdyy7mW5DIahIAZsLNxf0J1djxe7waCB6/FQL/6/NU
 T9erk/NkwMR48RIquxBSnE8CLYJ4o7IryTxldhuQ3+V+Whxc1XgDp5nSM0qNLHFU
 y3GohfnWzlJTCDt7ibL2QqqqwSWE/6ywRzn93l6VisFQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thq02hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:15:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981Fwr1026668;
 Tue, 8 Oct 2024 01:15:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424thq02hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:15:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49816PCm011521;
 Tue, 8 Oct 2024 01:15:57 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xhpus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:15:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981FuXh47645168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:15:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BA8058055;
 Tue,  8 Oct 2024 01:15:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E875258043;
 Tue,  8 Oct 2024 01:15:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:15:55 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 00/19] s390x: Add Full Boot Order Support
Date: Mon,  7 Oct 2024 21:15:33 -0400
Message-ID: <20241008011552.2645520-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Ie49rSyhTOszPuTZSiZxyJve2UiqbA3
X-Proofpoint-GUID: 9-dXWziNr-mwha34dtA1ByMU7pbMP0BY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080006
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Version 3 fixes ISO IPL and restores the ability to probe for boot devices when
no primary b0ot device has been specified.

Two automated qtests are added, one that tests a cdrom device as the only
fallback device after the primary boot target fails and one that that defines
the seven failing devices before one that succeeds.

Note: Although the qtest with multiple invalid IPL devices passes, it may
generate a log message about zero sized buffers. This message does not appear
to be directly related to the IPLB chaining or loading process, and it also
does not appear to cause any unexpected behavior during IPL. The log message
seems to be triggered when multiple virtio-scsi devices fail to IPL in
succession, but the exact cause is still unclear.

changes v2 -> v3:

- Fix return code mismatch in ISO IPL path
- Introduce a new RC for loading ECKD segments rather than rely on block 0
- Fix bug causing false negative in some SCSI device error cases
- Terminate entire IPL on bad PBT instead of trying next device
- Simplify routine for building IPLB chain
- Restore device probing
- Add qtests
- Minor stylistic clean-ups and comment clarifications

Changes v1 -> v2:

- Use the libc from SLOF and replace sclp_print calls with put/printf
- Merge netboot into the main s390-ccw.img
- Rework pc-bios to return on error instead of panic
- Handle non-archetected IPLB types (QEMU SCSI) from DIAG308
- Remove code jumps and instead restart the IPL using a traditional loop

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
 pc-bios/s390-ccw/netboot.mak      |  62 -----
 hw/s390x/ccw-device.h             |   2 +
 hw/s390x/ipl.h                    | 123 +--------
 include/hw/s390x/ipl/qipl.h       | 126 +++++++++
 pc-bios/s390-ccw/bootmap.h        |  19 +-
 pc-bios/s390-ccw/cio.h            |   2 +
 pc-bios/s390-ccw/dasd-ipl.h       |   2 +-
 pc-bios/s390-ccw/iplb.h           | 107 ++------
 pc-bios/s390-ccw/libc.h           |  89 ------
 pc-bios/s390-ccw/s390-ccw.h       |  37 +--
 pc-bios/s390-ccw/virtio.h         |   3 +-
 hw/s390x/ccw-device.c             |  46 ++++
 hw/s390x/ipl.c                    | 279 +++++++++----------
 hw/s390x/s390-virtio-ccw.c        |  28 +-
 hw/s390x/sclp.c                   |   3 +-
 pc-bios/s390-ccw/bootmap.c        | 442 ++++++++++++++++++++----------
 pc-bios/s390-ccw/cio.c            |  81 +++---
 pc-bios/s390-ccw/dasd-ipl.c       |  71 ++---
 pc-bios/s390-ccw/jump2ipl.c       |  23 +-
 pc-bios/s390-ccw/libc.c           |  88 ------
 pc-bios/s390-ccw/main.c           | 100 ++++---
 pc-bios/s390-ccw/menu.c           |  51 ++--
 pc-bios/s390-ccw/netmain.c        |  39 ++-
 pc-bios/s390-ccw/sclp.c           |   7 +-
 pc-bios/s390-ccw/virtio-blkdev.c  |  14 +-
 pc-bios/s390-ccw/virtio-net.c     |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c    | 165 +++++++----
 pc-bios/s390-ccw/virtio.c         |  67 +++--
 target/s390x/diag.c               |   9 +-
 tests/qtest/cdrom-test.c          |  24 ++
 pc-bios/meson.build               |   1 -
 pc-bios/s390-ccw/Makefile         |  69 ++++-
 pc-bios/s390-netboot.img          | Bin 67232 -> 0 bytes
 35 files changed, 1150 insertions(+), 1072 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 include/hw/s390x/ipl/qipl.h
 delete mode 100644 pc-bios/s390-ccw/libc.h
 delete mode 100644 pc-bios/s390-ccw/libc.c
 delete mode 100644 pc-bios/s390-netboot.img

-- 
2.45.1



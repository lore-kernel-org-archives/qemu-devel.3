Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E9CEBF63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 00:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stzCo-0002HX-52; Thu, 26 Sep 2024 20:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCm-0002Cl-6R; Thu, 26 Sep 2024 20:51:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1stzCj-0007EV-83; Thu, 26 Sep 2024 20:51:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFK7P3012801;
 Fri, 27 Sep 2024 00:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=7HyIVBOfXuTzwYBweT3mx2FCz395Aq03lFo4KHb
 Wxgg=; b=OheMXVO0Sx5of3jGSRHcnGLFhGsrCLFW9FfWIAMz+TU4E15yUqZ09ol
 QgBmq1+eaFQ0uRLyoODd2RNWQ/Ey3ykv9xupsePsgShWMAn0cWr+8++KZJV/iXXh
 UsiVW7dE6CoE/+g+J0thjU0o66PZPXLNfC1aSMq093homP8Uw7bK5VHnWBqmtoq/
 zp0eBzbqgk3ycEnv4fhTzoun+AN6xctfZ++zxoYeEwZ18EX1Myn4rUkEJnwBSwUJ
 pvx2sZgNeIY+tpz6r8+a7vnyYEIciT+Xf0B/gIUtBzuePW7b98ozBF+/IHxEt0YY
 2DQypsoqctsUHcOXs+AqpcqOTctx8xg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R0pNe5006261;
 Fri, 27 Sep 2024 00:51:24 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjk91r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48QNR6hu020838;
 Fri, 27 Sep 2024 00:51:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb63httk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 00:51:23 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48R0pLMZ14615042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 00:51:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D3CF58056;
 Fri, 27 Sep 2024 00:51:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 149585805D;
 Fri, 27 Sep 2024 00:51:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.154.26])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Sep 2024 00:51:20 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH V2 0/18] s390x: Add Full Boot Order Support
Date: Thu, 26 Sep 2024 20:50:59 -0400
Message-ID: <20240927005117.1679506-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1vVjV5cwmaArNAVjRRslSWyv-CYcgNNq
X-Proofpoint-GUID: qi3kEbY-WV3SSVojsOLndT5FElhwuE4E
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_06,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270002
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Loosely a v2, this updated patch set is a significant rework to most aspects of
the initially proposed multi-device boot order. Of particular note, the
original patch set used code jumps to restart the IPL while this version
does not. In order to remove the code jumps, two significant prerequisite
changes are required for the pc-bios. Firstly, the netboot code is linked into
the main s390-ccw.img, which allows for return after a failed netboot, based on
the patch set from Thomas Huth <thuth@redhat.com>
(https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg03956.html).
Secondly, IPL errors that result in an immediate termination are converted
to instead provide a return value back to the main IPL calling function.

The routines for building and loading fallback device IPLBs are largely
unchanged: An IPLB is built for each device with a boot index
specified (up to 8 devices). The IPLBs location in memory is passed to the guest
using the global QIPL structure, which is stored at a fixed address. If the
first device in the boot order successfully IPLs, then the additional IPLBs are
never used; however, if the first device fails, subsequent IPLBs are retrieved
from memory and the IPL process restarts using the specifications contained in
the new IPLB.

This continues until IPL is successful or there are no IPLBs left to try.

The per-device loadparm attribute is still uniformly added to CCW devices
although it may only be assigned a value if the device has a boot index.
This will need further rework if a more targeted approach is desired.

Two automated test cases are planned for v3: a minimal test where a guest has
two boot devices defined and the first fails, and also a limit test where the
guest has 8 boot devices defined but only the last one can actually IPL.

Changes v1 -> v2:

- Use the libc from SLOF and replace sclp_print calls with put/printf
- Merge netboot into the main s390-ccw.img
- Rework pc-bios to return on error instead of panic
- Handle non-archetected IPLB types (QEMU SCSI) from DIAG308
- Remove code jumps and instead restart the IPL using a traditional loop

Jared Rossi (18):
  hw/s390x/ipl: Provide more memory to the s390-ccw.img firmware
  pc-bios/s390-ccw: Use the libc from SLOF and remove sclp prints
  pc-bios/s390-ccw: Link the netboot code into the main s390-ccw.img
    binary
  hw/s390x: Remove the possibility to load the s390-netboot.img binary
  pc-bios/s390-ccw: Merge netboot.mak into the main Makefile
  docs/system/s390x/bootdevices: Update the documentation about network
    booting
  pc-bios/s390-ccw: Remove panics from ISO IPL path
  pc-bios/s390-ccw: Remove panics from SCSI IPL path
  pc-bios/s390-ccw: Remove panics from ECKD IPL path
  pc-bios/s390-ccw: Remove panics from DASD IPL path
  pc-bios/s390-ccw: Remove panics from netboot IPL path
  pc-bios/s390-ccw: Enable failed IPL to return after error
  include/hw/s390x: Add include files for common IPL structs
  s390x: Add individual loadparm assignment to CCW device
  s390x: Build an IPLB for each boot device
  s390x: Rebuild IPLB for SCSI device directly from DIAG308
  pc-bios/s390x: Enable multi-device boot loop
  docs/system: Update documentation for s390x IPL

 docs/system/bootindex.rst         |   7 +-
 docs/system/s390x/bootdevices.rst |  29 +-
 pc-bios/s390-ccw/netboot.mak      |  62 -----
 hw/s390x/ccw-device.h             |   2 +
 hw/s390x/ipl.h                    | 123 +--------
 include/hw/s390x/ipl/qipl.h       | 126 +++++++++
 pc-bios/s390-ccw/bootmap.h        |  21 +-
 pc-bios/s390-ccw/cio.h            |   2 +
 pc-bios/s390-ccw/dasd-ipl.h       |   2 +-
 pc-bios/s390-ccw/iplb.h           | 107 ++------
 pc-bios/s390-ccw/libc.h           |  89 -------
 pc-bios/s390-ccw/s390-ccw.h       |  36 +--
 pc-bios/s390-ccw/virtio.h         |   3 +-
 hw/s390x/ccw-device.c             |  46 ++++
 hw/s390x/ipl.c                    | 314 +++++++++++-----------
 hw/s390x/s390-virtio-ccw.c        |  28 +-
 hw/s390x/sclp.c                   |   3 +-
 pc-bios/s390-ccw/bootmap.c        | 428 ++++++++++++++++++++----------
 pc-bios/s390-ccw/cio.c            |  81 +++---
 pc-bios/s390-ccw/dasd-ipl.c       |  71 ++---
 pc-bios/s390-ccw/jump2ipl.c       |  22 +-
 pc-bios/s390-ccw/libc.c           |  88 ------
 pc-bios/s390-ccw/main.c           | 125 ++++-----
 pc-bios/s390-ccw/menu.c           |  51 ++--
 pc-bios/s390-ccw/netmain.c        |  44 ++-
 pc-bios/s390-ccw/sclp.c           |   7 +-
 pc-bios/s390-ccw/virtio-blkdev.c  |  14 +-
 pc-bios/s390-ccw/virtio-net.c     |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c    | 164 ++++++++----
 pc-bios/s390-ccw/virtio.c         |  67 +++--
 target/s390x/diag.c               |   9 +-
 pc-bios/meson.build               |   1 -
 pc-bios/s390-ccw/Makefile         |  69 ++++-
 pc-bios/s390-netboot.img          | Bin 67232 -> 0 bytes
 34 files changed, 1143 insertions(+), 1105 deletions(-)
 delete mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 include/hw/s390x/ipl/qipl.h
 delete mode 100644 pc-bios/s390-ccw/libc.h
 delete mode 100644 pc-bios/s390-ccw/libc.c
 delete mode 100644 pc-bios/s390-netboot.img

-- 
2.45.1



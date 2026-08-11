Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D237C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkV-0002Sl-D0; Tue, 11 Aug 2026 10:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkT-0002QP-LF; Tue, 11 Aug 2026 10:46:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkS-0003eM-0x; Tue, 11 Aug 2026 10:46:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWjmY492651; Tue, 11 Aug 2026 14:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=b7c/5LENnpBe0g0sRxlQwpOxYn9XwAQei4Y1lWALX
 Mk=; b=A9S9zq4+EE4Db6Kdql+2r1vAnmsBPSFIJOOZyH3mwZlolVzyBC7ttqpCI
 vZhObA8FC1VrzZw62kVI37YgL3R3FwR33PBz00Qw66N3vU+CmHnee8EScjmAJlHO
 o8ScfBEMIB8PqmoRxurygewgzgk1/pdcaUQTG2Qj9FqNtWQuty0s5wn5qdMEYs9F
 kkAYOu/r5blUnTNcYFLTA3Vosk+PGSDyxLhWPLhy7nWnXfcsUGe8V24tj4rJTNCY
 OdfnZZTlSRZARxassdBIInOsl7e1ijhTHve+mWxfr9vlf5UpjZi7Z806bDxSYDpx
 7qK4oGF0xkHeM5jZjdkrB6+c8/8kg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9deen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfHeF023470;
 Tue, 11 Aug 2026 14:46:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1981-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkUFT22872612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8980058043;
 Tue, 11 Aug 2026 14:46:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0ACF58059;
 Tue, 11 Aug 2026 14:46:29 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:29 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 0/8] s390x: Add support for virtio-scsi-pci boot device
Date: Tue, 11 Aug 2026 10:46:21 -0400
Message-ID: <20260811144629.866641-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0-NwVx8yE02gcb35OzejezAzGSoyNXxX
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b35c9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0ZV2Om_ZCBc2LQEt9ocA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX2+SiBvtvX0r2
 5cKuJPkcngCk/8YiF8JdWza/etXIYV4zfihPCd0v63GIUWRNRaVGtGPLe8F9rxJDWaIcUPv6nQG
 kTPF8wYnCfIh47yuXyZKPejwqHl0AgZHls/GsKvlErvIbwg+sYvlyTOUJuj8s7fxPrYB4CvGXid
 bjC5Nv+sAWWkro3AaNq8Jc0siv1VSRY2tvzuUhhMO/4bKGbRKittIxOlIkDxml96dGYPIuJ4dja
 0anakq74NsnGcpb4RZsbL9UN/YVdiGPJpPqOTJMmbVwK+LwcTMYYxMOyDkrlgFQRqOuVj/6qSda
 mnWTCR0mmTXBNrJe+jh7g7aQu07AzhvvbBVHQ/vTKwc2lth0OfGBmeXCKDy1/9mvsgwSN5QwATl
 P/vTuI/TIkc0/HSzDtvq1xhdtYYbF0LvQY6J9EzSJTR+aZSgrU7L27Y9aAHdqGb3q1o7EXRYGUk
 zq31Cg5kxGbp7kcSt1w==
X-Proofpoint-ORIG-GUID: 0-NwVx8yE02gcb35OzejezAzGSoyNXxX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXxQ/Lj5PkoP6F
 L9VAsVW5yzzMn5J1r8cUf1NdW9MOLNniX3LyZZ982XZlFXzvMrGBIJfFmJnCJa/31/Xs9WnAaPs
 moaFJzqJr783sB+wwc4fdHuizp6pprk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add support for booting from SCSI devices with a virtio-scsi-pci controller.

Some minor clean-up is done with naming in order to clarify if the function
or value used with CCW, PCI, or generic IPL and to check if a PCI function
is already enabled.

Changes v1 -> v2:
    - Add fix for PCI IPLB length
    - Use a universal scsi IPLB rather than creating a new one for PCI
    - When enabling a PCI function, first check if it is already online
    - Handle multiple boot targets assigned to a single scsi controller

Jared Rossi (8):
  pc-bios/s390-ccw: Check if a PCI function is already enabled before
    trying to enable it
  hw/s390x/ipl: Fix incorrect PCI IPL block length constant
  s390x/ipl: Add PCI and bus fields to iplBlockQemuScsi
  pc-bios/s390-ccw: Use bus specific IPL_TYPE directly for scsi IPL
  pc-bios/s390-ccw: Abstract virtio_run() for generic use
  pc-bios/s390-ccw: Add support for virtio-scsi-pci IPL
  s390x: Find scsi-pci boot device and build IPLB
  tests/qtest: Add s390x PCI SCSI fallback test to cdrom-test.c

 hw/s390x/ipl.c                   | 40 ++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h                   |  4 +++-
 include/hw/s390x/ipl/qipl.h      | 13 +++++++----
 pc-bios/s390-ccw/clp.c           |  4 ++++
 pc-bios/s390-ccw/main.c          | 19 +++++++++++----
 pc-bios/s390-ccw/virtio-blkdev.c |  1 -
 pc-bios/s390-ccw/virtio-ccw.c    | 17 --------------
 pc-bios/s390-ccw/virtio-ccw.h    |  1 -
 pc-bios/s390-ccw/virtio-pci.c    | 31 ++++++++++++++++++++++++-
 pc-bios/s390-ccw/virtio-scsi.c   | 12 +++++++++-
 pc-bios/s390-ccw/virtio.c        | 21 +++++++++--------
 tests/qtest/cdrom-test.c         |  8 +++++++
 12 files changed, 131 insertions(+), 40 deletions(-)

-- 
2.54.0



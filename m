Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CA7C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x180Y-0000Hw-7X; Mon, 31 Aug 2026 15:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180W-0000Hg-8f; Mon, 31 Aug 2026 15:49:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x180U-0002az-K1; Mon, 31 Aug 2026 15:49:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVm613164739; Mon, 31 Aug 2026 19:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=l60cJXdXKPyjIW1Gz4tzveVdaYDzOCzclPOatRXBl
 CA=; b=QE1BWWd5dGyv/am5V6rX0F6Y56eCpeEMryADBDlET4/QjEw7dYq6wKtom
 XMbBcQmfhNIkNjSi7WxZ5cW78agRjxc8mlo1+0S+IQPcn0os0F5aydBxBQTD+e+v
 3S7n572pkc9w4Enmbk2HJBp0dLtJeoctygE/0+HO7sIne/tjr5P6cxKIVO5Fv7l7
 sb3sG1qEopdRMmQWaAZTx41ggNaZBQgdh32qYTrfWaovcXaQJWV0LIl6Xi7Itn1j
 amnXClUXrYXnmBr5xOAOUWEDYuhfVCQKEQv14lTXrpyrlrjMTYnLcxJ8Vsm42xxB
 3OAwRR/LhhjldDB01gzcobWFOsHCw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t39ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VJfMkm012839;
 Mon, 31 Aug 2026 19:49:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vyune-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 19:49:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VJnLnn24511114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 19:49:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE10B58052;
 Mon, 31 Aug 2026 19:49:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5394A58056;
 Mon, 31 Aug 2026 19:49:21 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.69.254])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 19:49:21 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 zycai@linux.ibm.com
Subject: [PATCH v3 0/8] s390x: Add support for virtio-scsi-pci boot device
Date: Mon, 31 Aug 2026 15:49:11 -0400
Message-ID: <20260831194919.3830270-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a95dac3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=v67RXZh9NETehd4EobsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfXwMy9lBcHyd5Q
 +9eWZFo3OPfB9rnQO5oSD/o3yFZo7zGqLGeOigCiWinJU+oLmUDIJXQhf18mMhrQVt/SMpvOCpQ
 cYCokNqQvRYo2qwGtjR/5JWLbB2XyJs=
X-Proofpoint-ORIG-GUID: 80duf0_D1RPkQKs0X5oxLekSMufZFcW5
X-Proofpoint-GUID: 80duf0_D1RPkQKs0X5oxLekSMufZFcW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2OSBTYWx0ZWRfX8Gjn9cyvBsW/
 4qvzd5wB9y8MjjfgHHcjZYjdybMh72H8Gg9L3iKW0MKbkFc5FMVT3HTbMjzGK3QQgqtyrY9xZaJ
 fBRPjCOWXIiW0wnC2RYau1pYHdm8GBVj4UMNz2yjF9MbivLGs2KtOoipPCcT+bZVNa3orNXSbRQ
 x7UTNCFHwn4YHj+o3JP5rjgwttEMmEi3b9HZXF64Yf2Wr22ghg6o4oWERoRUH5Ky6GBtGyDF1+o
 LvDzS43kPf0NrgE88Ib/3UhiiAuO4va4qdtlRRICozxBGnzkSMZHIvI0Feo7qCO0Z6WLvkdAeWD
 j++EhS6PsXDqfG7HXPDU1k/7pLj0ke+6fEWHcmb6ESduhGo/nIFd1ifkyIqOCWA+h5qr/DphUbQ
 6a5PXAiKmIHZ49oiHwb1KG/HRCC1XMU4sDWK0spll0rZFTGORseSAMG5TfWQngESJ1Ia+AMk2tn
 cNxx/E55p5492u5wemw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add support for booting from SCSI devices with a virtio-scsi-pci controller.

Some minor clean-up is done with naming in order to clarify if the function
or value used with CCW, PCI, or generic IPL and to check if a PCI function
is already enabled.

Changes v2 -> v3:
    - Rebase on recently added Secure IPL features added to BIOS
    - Define PCI IPLB length using offset and sizeof rather than magic
    - Check for virtio setup failures during scsi setup
    - Fix commit messages
    - Update the title of patch 3 to indicate multiple lengths change

Jared Rossi (8):
  pc-bios/s390-ccw: Check if a PCI function is already enabled before
    trying to enable it
  hw/s390x/ipl: Fix incorrect PCI IPL block lengths
  pc-bios/s390-ccw: Use bus specific IPL_TYPE directly for scsi IPL
  s390x/ipl: Add PCI and bus fields to IplBlockQemuScsi
  pc-bios/s390-ccw: Abstract virtio_run() for generic use
  pc-bios/s390-ccw: Add support for virtio-scsi-pci IPL
  s390x: Find scsi-pci boot device and build IPLB
  tests/qtest: Add s390x PCI SCSI fallback test to cdrom-test.c

 hw/s390x/ipl.c                   | 40 ++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h                   |  2 ++
 include/hw/s390x/ipl/qipl.h      | 15 ++++++++----
 pc-bios/s390-ccw/clp.c           |  4 ++++
 pc-bios/s390-ccw/main.c          | 19 +++++++++++----
 pc-bios/s390-ccw/virtio-blkdev.c |  1 -
 pc-bios/s390-ccw/virtio-ccw.c    | 17 --------------
 pc-bios/s390-ccw/virtio-ccw.h    |  1 -
 pc-bios/s390-ccw/virtio-pci.c    | 31 ++++++++++++++++++++++++-
 pc-bios/s390-ccw/virtio-scsi.c   | 18 +++++++++++++-
 pc-bios/s390-ccw/virtio.c        | 21 +++++++++--------
 tests/qtest/cdrom-test.c         |  8 +++++++
 12 files changed, 137 insertions(+), 40 deletions(-)

-- 
2.54.0



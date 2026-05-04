Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A57FCD342F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1b2-00020E-ET; Mon, 04 May 2026 18:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ab-0001vc-UM; Mon, 04 May 2026 18:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1aQ-0002qm-U1; Mon, 04 May 2026 18:16:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644El9Xu2560652; Mon, 4 May 2026 22:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=BuZIdsYfVkd2Yb0jHc3HjsXsSbLZ+0BrtwOwL2XB3
 cU=; b=lHDHhexCG/zeHjqZ1Dulf3e7QoEuDtFs1+2tPENTVt/xVYFytlob58R5L
 dM7h5YffDeawRtfLVy88Y7BMgfGa5FVDVgsrEkmtCCpohYAzbDhuCbZ5dYlPhJi9
 LJAujUeMbKpaH3klv3ItJziQPlXJHWjlmc634tXTGMAbYschW3ownrvOv+PISya5
 NZ76O2LFVpaviR9B6oZLgCf1U8ifBL2PuavfUdX9zrUzrqQ1QsPU8exsqcXzmORR
 uLEG/AE8Dki3D1ezN7bbBR6aWN7KQjyCmOe8IwcDFT792oR18m7NmeuEqeODfNIg
 pm4wd/WCjSnRR6MToVXur3Sv4qwjw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4gvfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9k9T020334;
 Mon, 4 May 2026 22:16:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq775u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MGGpD5178116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:16:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CD4158055;
 Mon,  4 May 2026 22:16:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4ADC58043;
 Mon,  4 May 2026 22:16:15 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:15 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 0/6] s390x: Add support for virtio-scsi-pci boot device
Date: Mon,  4 May 2026 18:16:07 -0400
Message-ID: <20260504221613.826825-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfX3mNRs9lA70Fs
 tVuQWsr1QmUgwsvxfO2kGMLIdIPqv+qYIg6FfRQXUWbyAvVijBpy4kvtHZBZHsmL0Ud2rjs8Msx
 HhmUEnvSd+i1ZOcN5+uNmost5g7P/4HqanJEH9eHROM5rMV/Nx1YKvxQKElWVEUwvjBfTXKt215
 RJ7/cibJXooR8eARfjokx1dgBdgm5lIDGWULHwIcKrJ5PnggVZ9yofk9unjvJErBnmFed8LqKBF
 7joVUrU+yIStlNIJ89drI0qxe+wCWRgHx70DXK6KR3/oNuMI7M3anEp7B02oeQIvHY/zxoGbvo1
 iAg869uqF79IatlYCV3j38lEsCPuupUqkRPhcwlRbudiB0/dgDkc+mQvRg6K/uyI3spWJDKQyMJ
 uW/EXs12U1kkv8MPnottNIUZkSmMK/AFGoge9Lfw5ekv9g2UWJY+BOLAFbRW6dPpRErwLr50D4v
 bVAg9pujk2j81ahSuhA==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f91ab3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=xPwaWfB8G5FIH4WeaT8A:9
X-Proofpoint-GUID: EZsbje1GS7oN_pvu9K3yP-Uc-tc89PiW
X-Proofpoint-ORIG-GUID: EZsbje1GS7oN_pvu9K3yP-Uc-tc89PiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add support for booting from SCSI devices with a virtio-scsi-pci controller.

Some minor clean-up is done with naming in order to clarify if the function or
value used with CCW, PCI, or generic IPL.

Jared Rossi (6):
  s390x: Rename SCSI IPL type to indicate CCW bus
  pc-bios/s390-ccw: Add per-queue notification offset for multi-queue
    virtio configurations
  pc-bios/s390-ccw: Rename Virtio CCW run function for generic use
  s390x: Introduce PCI SCSI IPLB and boot type
  S390x: Enable IPL from Virtio PCI SCSI devices
  tests/qtest: Add s390x PCI SCSI fallback test to cdrom-test.c

 hw/s390x/ipl.c                   | 50 ++++++++++++++++++++----
 hw/s390x/ipl.h                   |  2 +-
 include/hw/s390x/ipl/qipl.h      | 23 +++++++++--
 pc-bios/s390-ccw/jump2ipl.c      |  4 +-
 pc-bios/s390-ccw/main.c          | 27 ++++++++-----
 pc-bios/s390-ccw/virtio-blkdev.c |  2 +-
 pc-bios/s390-ccw/virtio-ccw.c    | 17 ---------
 pc-bios/s390-ccw/virtio-ccw.h    |  1 -
 pc-bios/s390-ccw/virtio-pci.c    | 65 +++++++++++++++++++++++++-------
 pc-bios/s390-ccw/virtio-pci.h    |  3 +-
 pc-bios/s390-ccw/virtio-scsi.c   | 14 ++++++-
 pc-bios/s390-ccw/virtio.c        | 40 ++++++++++++++++----
 pc-bios/s390-ccw/virtio.h        |  1 +
 target/s390x/diag.c              |  3 +-
 tests/qtest/cdrom-test.c         |  8 ++++
 15 files changed, 194 insertions(+), 66 deletions(-)

-- 
2.52.0




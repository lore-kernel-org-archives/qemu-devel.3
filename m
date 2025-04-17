Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2E5C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OWP-0001de-R2; Thu, 17 Apr 2025 08:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5OVH-0001Jz-S8; Thu, 17 Apr 2025 08:38:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5OVG-00038f-0J; Thu, 17 Apr 2025 08:38:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9msCK017898;
 Thu, 17 Apr 2025 12:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=WmlcoUs3YDbKRdQxsj7Dp8W4GAwA883V/6ODs4Sok
 jo=; b=ftisltXl8NZs1rjaNG07qvubOmAtT6avcgZWKA/Ynv5rbUkUqoSQPmi5K
 HJuntxrwtEinzAS+55WtH8+sFtSKP21qbbXtCZOBEbPo3DQy6Qc0QqmFyWNEw24B
 aKmQHKEaoxvQQTaKsEaBMebITYHt4fHn+TZgP1wsqSeOfFbWM8wslP6ky9ycXsAI
 2xN9oz3ks2HZD4iLu6oCBRW2GYT1Wx+PrfKO/cx/6h9/ZgTsSbqzidzZvDUVaX1y
 xftOQ96T/UfRsUBveziajLw9UMua0mr9GN0IKpj7tUArCz/+NHKAi/ZUobbCSWj9
 nNcF5F0HsdVdqiP4rx3EsfunJosNA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462ph0axpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 12:37:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9oT4G031061;
 Thu, 17 Apr 2025 12:37:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnwpdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 12:37:59 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HCbwxv29295290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 12:37:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3FAB58052;
 Thu, 17 Apr 2025 12:37:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D484F58056;
 Thu, 17 Apr 2025 12:37:56 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Apr 2025 12:37:56 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v4 0/3] DIAG 308: extend subcode 10 to return UVC cmd id,
 RC and RRC values upon failure to enter secure mode
Date: Thu, 17 Apr 2025 14:37:53 +0200
Message-ID: <20250417123756.729132-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QJdoRhLL c=1 sm=1 tr=0 ts=6800f627 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=9lonpTW9IpegU1W_ekgA:9
X-Proofpoint-GUID: Xp4QsFEKTYow39DWW5sJetSmiBsr6Y3I
X-Proofpoint-ORIG-GUID: Xp4QsFEKTYow39DWW5sJetSmiBsr6Y3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=916 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504170090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ggala@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DIAG 308 (subcode 10 - performing secure execution unpack) response
code when the configuration is unable to enter secure mode has limited
usability as it is a fixed value (0xa02) for variety of different
reasons. The aim is to extend this DIAG to return UVC command ID, RC
and RRC values in addition to the diag response code. This feature can
be used by the stage3a bootloader (s390-tools/rust/pvimg/boot) to read
these new values from the corresponding register and print an
appropriate error message to help pin point the cause.

The response code, UVC RC, RRC, and command ID are returned in bit
positions 48-63, 32-47, 16-31, and 0-15 of register R1 + 1 if the
function does not complete successfully (Previously, only the
response code was returned in bits 48-63).

This patch version contains updates based on feedback from Janosch Frank
in message-id: <81a4da88-0af0-4fa6-8bfc-e26ae4a7c88f@linux.ibm.com>

Gautam Gala (3):
  target/s390x: Introduce constant when checking if PV header couldn't
    be decrypted
  target/s390x: Introduce function when exiting PV
  target/s390x: Return UVC cmd code, RC and RRC value when DIAG 308
    Subcode 10 fails to enter secure mode

 hw/s390x/ipl.c             | 11 ++++---
 hw/s390x/ipl.h             |  6 ++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++----
 target/s390x/kvm/pv.c      | 64 ++++++++++++++++++++++++--------------
 target/s390x/kvm/pv.h      | 26 +++++++++++-----
 5 files changed, 78 insertions(+), 43 deletions(-)

-- 
2.49.0



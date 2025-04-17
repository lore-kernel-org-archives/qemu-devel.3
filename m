Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14803C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 07:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5JsR-0005Wp-8F; Thu, 17 Apr 2025 03:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5JsO-0005Ud-2h; Thu, 17 Apr 2025 03:41:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5JsM-0004Qu-8q; Thu, 17 Apr 2025 03:41:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GNkdfK018802;
 Thu, 17 Apr 2025 07:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Dd0pbhRwsw2I5Xsw52a1Y3ZbH7oGsSwlIlpKqh3Lr
 RY=; b=nfhVlX77CUHN0yLBlySSIX/q1atmFMwlHco9tBRbhYs3iKEtjlhXMUsVb
 yVzTcYccHcLKaT/MK8gZP5W5bqn9Jr9tPAmJPpMphuD8hM7fyLnqRgtAd4SD7iyN
 8DAlvhotDIPuMR1sNxwa1/S+yoeOJKzKenSHJrrg08Qt8dhcVE20DljfNSjUMnNy
 xZSxtZduIA+J2wm0VxMXq/H3Un+M5/iKfhaLhymC40TkJtA1vbu8wfsBWAdFVi/M
 RqPNIVyIj7/E3ctSGZCmGv0Gr9WUv82fzNeo9IzihOea9ztG3OwsVoY8Hhmjk9Hf
 EX15NVevu2vD/3C+s14bNE2Lg+p7Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462ph09p6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 07:40:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H7EUiN017195;
 Thu, 17 Apr 2025 07:40:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m4frr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 07:40:30 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53H7eTp222413916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 07:40:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87039580F9;
 Thu, 17 Apr 2025 07:40:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70ACD58232;
 Thu, 17 Apr 2025 07:40:28 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Apr 2025 07:40:28 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v3 0/3] DIAG 308: extend subcode 10 to return UVC cmd id,
 RC and RRC values upon failure to enter secure mode
Date: Thu, 17 Apr 2025 09:40:24 +0200
Message-ID: <20250417074027.711076-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QJdoRhLL c=1 sm=1 tr=0 ts=6800b06f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=9lonpTW9IpegU1W_ekgA:9
X-Proofpoint-GUID: uhfEBGIsZuyiToYen8Iwdb1sQ5YZvTAw
X-Proofpoint-ORIG-GUID: uhfEBGIsZuyiToYen8Iwdb1sQ5YZvTAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=921 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504170057
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

This patch version contains updates based on feedback from Thomas Huth 
in Message-ID: <88084780-38b2-4ca9-a2ff-ecd70d62c361@redhat.com>.

Gautam Gala (3):
  target/s390x: Introduce constant when checking if PV header couldn't
    be decrypted
  target/s390x: Introduce function when exiting PV
  target/s390x: Return UVC cmd code, RC and RRC value when DIAG 308
    Subcode 10 fails to enter secure mode

 hw/s390x/ipl.c             | 11 +++++----
 hw/s390x/ipl.h             |  6 +++--
 hw/s390x/s390-virtio-ccw.c | 23 +++++++++++++-----
 target/s390x/kvm/pv.c      | 50 ++++++++++++++++++++------------------
 target/s390x/kvm/pv.h      | 24 ++++++++++++------
 5 files changed, 71 insertions(+), 43 deletions(-)

-- 
2.49.0



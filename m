Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F534C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4M3R-0001Jk-EJ; Mon, 14 Apr 2025 11:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u4M3G-0001ID-Mk; Mon, 14 Apr 2025 11:48:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u4M3B-0002FO-V5; Mon, 14 Apr 2025 11:48:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAVBgb002076;
 Mon, 14 Apr 2025 15:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ORvaS/vY2VC+68bh89HCG/joyf+6d2rsMWzB2irxd
 DM=; b=dam6wGYT+/NYJc142OEKc1d4YzSgRsHN9kD1A0PfpmAcu6Y03Yk66qJD/
 gGdRZTAB1g8kEu0nwH9SbPdUIhoBudFTG5gyR4LmmbLv53/42YLr3aTpXxDwEmsM
 opr0XfbiTsERxUjNL0H5/j2H727WJXcb7BpRYyhkeyvy34JP5lHCDOjTERn6d0Rl
 s8C/lBSs6be9OTyBs6K+Hc24XdHG57BbiFYJSKc5WXeSzdgnLOOY6J1NEQy4Z0z1
 yxyTx+yn+GwmVGyQLtbvhy9MmqvXc00Q6Bna81y0ZCBVtp3H/qZNUs0cz+n7UMms
 P1iDxWVTcy3D8IUYl7iaGoP+g2lEg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460nc4c7jy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 15:48:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EFQEWK001308;
 Mon, 14 Apr 2025 15:48:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyq2md-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 15:48:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EFmep727329052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 15:48:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59F925805A;
 Mon, 14 Apr 2025 15:48:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59E0858051;
 Mon, 14 Apr 2025 15:48:39 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Apr 2025 15:48:39 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, seiden@linux.ibm.com
Subject: [PATCH v2 0/3] DIAG 308: extend subcode 10 to return UVC cmd id,
 RC and RRC values upon failure to enter secure mode
Date: Mon, 14 Apr 2025 17:48:35 +0200
Message-ID: <20250414154838.556265-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vzro1IEtjmd2iGpZqs7QTzHeTBBC1JNQ
X-Proofpoint-ORIG-GUID: vzro1IEtjmd2iGpZqs7QTzHeTBBC1JNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=943
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

These patches contains updates based on feedback from Steffen Eiden
from message-ID <20250414133845.61624-D-seiden@linux.ibm.com> and
<20250414140340.61624-E-seiden@linux.ibm.com>

Gautam Gala (3):
  target/s390x: Introduce constant when checking if PV header couldn't
    be decrypted
  target/s390x: introduce function when exiting PV
  target/s390x: Return UVC cmd code, RC and RRC value when DIAG 308
    Subcode 10 fails to enter secure mode

 hw/s390x/ipl.c             | 11 ++++---
 hw/s390x/ipl.h             |  5 ++--
 hw/s390x/s390-virtio-ccw.c | 24 ++++++++++++----
 target/s390x/kvm/pv.c      | 59 +++++++++++++++++++++++---------------
 target/s390x/kvm/pv.h      | 27 +++++++++++------
 5 files changed, 83 insertions(+), 43 deletions(-)

-- 
2.49.0



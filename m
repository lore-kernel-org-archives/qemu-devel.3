Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C1C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLSZ-0005jc-5T; Wed, 29 May 2024 11:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSX-0005iq-98; Wed, 29 May 2024 11:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sCLSU-0006vi-Ty; Wed, 29 May 2024 11:43:25 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TF3XxA008270; Wed, 29 May 2024 15:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=pgLLNT3rqwZbbn9rbbCT2i2SSSib6ITWpDHqrhbSmCQ=;
 b=atIDk3BBNNShTs/DZKsqKedMXcvzHOrBwMu/+dsz5f20VrTuValO4Khz2ZiqFMwrKVe5
 BhjOxWO+Ch/yyIgK3+9qUBaSESPnFwGl6Ibxi7WTyUOdh0G9Q23WkysYMhTAOZupTebc
 ZYA+hvxClK+HsgqJgibiX9WNDYomvgslN4p6F6EWaHyP3BmpaKn5h5UYOFst9f7dHMvb
 rWWxgjELdGxZ00diMeE7vH4O/ahbcBNO6bXcVIOz8yjjvpdiL1cyOr1d8fM4TE1Oi6Yp
 x3b7LqN62QQPGwsdlIshXy40IL3ksiAxwpvrKpDY4kUQ1WVb67WM9B64f/CCfBqtsMi8 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye6nr83rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:19 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44TFhIAv005634;
 Wed, 29 May 2024 15:43:18 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ye6nr83rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44TF8isE009806; Wed, 29 May 2024 15:43:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpbbmjma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 May 2024 15:43:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44TFhEUq34734678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 May 2024 15:43:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FA1658060;
 Wed, 29 May 2024 15:43:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A62EF58064;
 Wed, 29 May 2024 15:43:13 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.67.55.69])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 May 2024 15:43:13 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH 0/5] s390x: Add Full Boot Order Support
Date: Wed, 29 May 2024 11:43:06 -0400
Message-Id: <20240529154311.734548-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dvMV36j26SE148Gn6OPhk32Ovf_YEPYR
X-Proofpoint-ORIG-GUID: POUYCm77QQtMdB3OKIHlK_nRcVohHiUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=563 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch set primarily adds support for the specification of multiple boot
devices, allowing for the guest to automatically use an alternative device on
a failed boot without needing to be reconfigured. It additionally provides the
ability to define the loadparm attribute on a per-device bases, which allows
boot devices to use different loadparm values if needed.

In brief, an IPLB is generated for each designated boot device (up to a maximum
of 8) and stored in guest memory immediately before BIOS. If a device fails to
boot, the next IPLB is retrieved and we jump back to the start of BIOS.

Devices can be specified using the standard qemu device tag "bootindex" as with
other architectures. Lower number indices are tried first, with "bootindex=0"
indicating the first device to try.

A subsequent Libvirt patch will be necessary to allow assignment of per-device
loadparms in the guest XML

Jared Rossi (5):
  Create include files for s390x IPL definitions
  Add loadparm to CcwDevice
  Build IPLB chain for multiple boot devices
  Add boot device fallback infrastructure
  Enable and document boot device fallback on panic

 docs/system/bootindex.rst         |   7 +-
 docs/system/s390x/bootdevices.rst |   9 +-
 hw/s390x/ccw-device.h             |   2 +
 hw/s390x/ipl.h                    | 117 +-------------------
 include/hw/s390x/ipl/qipl.h       | 128 ++++++++++++++++++++++
 pc-bios/s390-ccw/bootmap.h        |   5 +
 pc-bios/s390-ccw/iplb.h           | 108 +++++--------------
 pc-bios/s390-ccw/s390-ccw.h       |   6 ++
 hw/s390x/ccw-device.c             |  49 +++++++++
 hw/s390x/ipl.c                    | 170 ++++++++++++++++++++++--------
 hw/s390x/s390-virtio-ccw.c        |  18 +---
 hw/s390x/sclp.c                   |   3 +-
 pc-bios/s390-ccw/bootmap.c        |  41 ++++---
 pc-bios/s390-ccw/main.c           |  25 +++--
 pc-bios/s390-ccw/netmain.c        |   4 +
 pc-bios/s390-ccw/Makefile         |   2 +-
 16 files changed, 413 insertions(+), 281 deletions(-)
 create mode 100644 include/hw/s390x/ipl/qipl.h

-- 
2.45.1



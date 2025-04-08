Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F36C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28Gb-0004zI-6D; Tue, 08 Apr 2025 08:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u28GS-0004vR-VD; Tue, 08 Apr 2025 08:41:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u28GQ-0003KM-Ra; Tue, 08 Apr 2025 08:41:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CS5nN017819;
 Tue, 8 Apr 2025 12:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=FTHsySPRgTJXcsWPvetcbDbvCKSz
 sNVKalprySfLnJQ=; b=i5VHQL+o2n5sKq0JwTWCcG3iP+SDSBm3V2ge77jGzvyl
 I9y6NXQa/AFeMFai50Q+fRW5O6Pv2gHmiPcRJSX48VBbnkgWxkLFj8wTQzkMwGNd
 wVqMSVKU2YsBreYwT9OUUcbARwco/h5zu0wmc81S9eKnFdZP/Ld3BbsehUgCMOWv
 /WeT6xueGAEOUxn8C5SQdaw6lyRwlPXskQ7cLzWLjspYriumZX0saOfuRtOLGlIq
 OrvBWzVKZtkyzyrelE75yak6IhoVZ07WVl59cKoLRUHYnoBXxPNZxb94YTHepH8B
 I7HwmRmRxHYr4b2JnsPmPEOlQi62kBSMJfZ/4Xoheg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u301qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:11 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 538Catt4002015;
 Tue, 8 Apr 2025 12:41:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u301qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5389cSK5018873;
 Tue, 8 Apr 2025 12:41:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uhj2aahk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 12:41:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538Cf6al58786140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 12:41:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E460820043;
 Tue,  8 Apr 2025 12:41:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA9A72004D;
 Tue,  8 Apr 2025 12:41:04 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.in.ibm.com (unknown
 [9.109.198.22]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 12:41:04 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 0/2] vfio/spapr: Fix L2 crash with PCI device passthrough
Date: Tue,  8 Apr 2025 18:10:40 +0530
Message-ID: <20250408124042.2695955-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -e6PA2Ym4ETsQJd9f5PTmpiKnDPpewMd
X-Proofpoint-ORIG-GUID: 5QfemKx_R7zejZhYGnCB58DrVS27V8Tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_04,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,

This patch series addresses two aspects in vfio_spapr_create_window() that
includes the enhancement in error handling in this function and also fixes an
issue with KVM guests (L2) inside a pSeries logical partition (LPAR) with larger
memory configurations and PCI device passthrough.

The structure of the patch series is as below:

1. The first patch introduces structured error reporting in
   `vfio_spapr_create_window()` by adding an `Error **` parameter. This allows
   better propagation of failure details to the caller.

2. The second patch fixes a crash observed when booting an L2 KVM guest inside a
   pSeries LPAR with memory more than 128 GB and PCI device passthrough. The
   crash occurs due a check in KVM preventing multi-level TCEs because of not
   being supported by PowerVM hypervisor. This patch ensures that such
   configurations are avoided by first checking the supported number of levels
   returned by the `VFIO_IOMMU_SPAPR_TCE_GET_INFO` ioctl.

The fix has been tested with KVM guests on PowerVM and bare-metal enviroments
with memory sizes up to 390 GB and 450 GB respectively.

Thanks,
Amit

Changes in v3:
  * Change vfio_spapr_create_window() to return bool
  * Replace error_setg() with error_setg_errono() in vfio_spapr_create_window()
  * Pass errp instead of local Error object in vfio_spapr_create_window()
    while calling from vfio_spapr_add_section_window()
  * Modified patch #2 subject

Changes in v2:
  * Link: https://lore.kernel.org/all/20250407143119.1304513-1-amachhiw@linux.ibm.com/
  * Added Error ** parameter in vfio_spapr_create_window() for enhanced error
    handling with error_setg() and friends

v1: https://lore.kernel.org/all/20250404091721.2653539-1-amachhiw@linux.ibm.com/

Amit Machhiwal (2):
  vfio/spapr: Enhance error handling in vfio_spapr_create_window()
  vfio/spapr: Fix L2 crash with PCI device passthrough and memory > 128G

 hw/vfio/spapr.c | 69 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 26 deletions(-)


base-commit: dfaecc04c46d298e9ee81bd0ca96d8754f1c27ed
-- 
2.49.0



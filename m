Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B67C8303F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 21:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqehA-0002Rj-Cs; Mon, 25 Aug 2025 17:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uqegk-00028u-Qn; Mon, 25 Aug 2025 17:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uqegK-0001qg-3J; Mon, 25 Aug 2025 17:25:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PL16a4000840;
 Mon, 25 Aug 2025 21:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=wvw9DWlGJo4XlDpvIK1mgsIeHYiQZRWExZ/swtIve
 Bc=; b=PrDbIRBj8zd8PNMbAqrW/GE9EZ9LjRLim9calnkCWRkTBsITCF1B/OLt7
 DhUVVFesZaiZX8pTOCyB8ozLuVvebx0HEC6BY791Dy/xtNyyId7nkn7tEuxoCyqM
 4MKCingb04kQTa54YQR5CEOGVGcy8KdUYUPULtBS8ZJKpa6KFVbW3qMWDFRRfjEe
 jxJhhueIx7JwNXeATGSAX3hYd5XBjYW1hBTBizhnuATtZ2CpwiqUdh64M5dJufm1
 YOl4tzjg62Ga9cSs0Yuk+78p8QIIPnVdPMF+T3vH/FLfC55i1E9XSWyetFZif7FO
 FeLpgo63Ma+6svccGc1dGdrxLx5ag==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q557u9p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 21:24:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57PJOGUd018009;
 Mon, 25 Aug 2025 21:24:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp37gk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 21:24:36 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57PLOZFX4260464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 21:24:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18A025805F;
 Mon, 25 Aug 2025 21:24:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70D8958043;
 Mon, 25 Aug 2025 21:24:34 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.253])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Aug 2025 21:24:34 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v2 0/4] Error recovery for zPCI passthrough devices
Date: Mon, 25 Aug 2025 14:24:29 -0700
Message-ID: <20250825212434.2255-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: udU-qzV5N5ZW1tTMP8j_OUIwRv959SEP
X-Proofpoint-ORIG-GUID: udU-qzV5N5ZW1tTMP8j_OUIwRv959SEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+p46iibmd8QP
 BcZJE+YAYGg/634lbjl3zp6myaqP5M4/d87K82tMMMfl8LUtau/w+1yI04NCba3rzOXTB20yBYA
 pKjucwPz1IqshvjOFBpRJ+yvplsDjki6zTZ+xaCvWcS76HH0hiINXV9Bti8gJyOJAzYQMJRFzk3
 92Gfuyo0ja2CfSahAbS2+rUN2RzIOlzilYWegA5xOXiZZ2BXVdOwa7edKTGdEzQU3Om7ET7d5H3
 3QRjJ4Epuzcti71LvefeTS86D77P9EIoRkcSdbmlmjAgCn3gLcJAycZhoXe+cB8GRrPvgKtAZr9
 7zjvyjkTdsNl0A+Ifc5OslanMyMRh7wjw3l7bdSfqATs2QJVmIVPjDSo4wbetw5b+egYrTeg6Jm
 Q3tgVG6n
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68acd495 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=lZbu965hNiywPBjdC2AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch series introduces support for error recovery for passthrough
PCI devices on System Z (s390x). This is the user space component for the Linux
kernel patches [1]. For QEMU on eventfd notification for PCI error from vfio-pci
driver we call the vfio error handler. We can use an architecture specific error
handler to override the default vfio error handler. 

For s390x specific error handler, we retrieve the architecture specific PCI error
information and inject the information into the guest. Once the guest receives
the error information, the guest drivers will drive the error recovery.
Typically recovery involves a device reset which translate to CLP
disable/enable cycle for the device.

I would appreciate some feedback on this patch series.

Thanks
Farhan

[1] https://lore.kernel.org/all/20250825171226.1602-1-alifm@linux.ibm.com/

ChangeLog
---------
v1 https://lore.kernel.org/qemu-devel/20250813174152.1238-1-alifm@linux.ibm.com/
v1 -> v2
   - Use VFIO_DEVICE_FEATURE ioctl to get device error information.
   (Based on Alex's feedback on kernel series)

Farhan Ali (4):
  [NOTFORMERGE] linux-headers: Update for zpci vfio device
  vfio/pci: Add an architecture specific error handler
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

 hw/s390x/s390-pci-bus.c          | 12 +++++
 hw/s390x/s390-pci-vfio.c         | 82 ++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                    |  5 ++
 hw/vfio/pci.h                    |  1 +
 include/hw/s390x/s390-pci-bus.h  |  1 +
 include/hw/s390x/s390-pci-vfio.h |  4 ++
 linux-headers/linux/vfio.h       | 14 ++++++
 7 files changed, 119 insertions(+)

-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1C5C98307
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9487-0001R8-0n; Tue, 22 Sep 2026 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x9485-0001Q8-Kh; Tue, 22 Sep 2026 13:18:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x9483-00054H-MS; Tue, 22 Sep 2026 13:18:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5sR1588827; Tue, 22 Sep 2026 17:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hlMXpSalStD1tNctsG200sAvrwpJoWpM42RLNOWgS
 PI=; b=iy33sAV39wCF1zGCD8MoXjzyaiI2N53OB5s3TRwsRCXf80BtwGGrnIyQR
 Xbm59XFTPYRHOJdzt5suUAi1ZE5QnuXRiUvDgrJEQz7T7CpSiH+X9a1KIUB3a86d
 CoV2K5bx32l9dictp4GvpMIYrjqUzPg3JeajG9NLbiSk8Ii+H9hQ0MBviO/e3Hrs
 oSRJs/6JZimx81uQX6XpB1sxXyLmuVeiuXp88tSlIu3BZtKf1bVYB6wqk4MUoPFT
 PopYKjA1hlQA5jZRnN92LLc2JKsu1d0cDajL2mmBdy4zY6FFuxk7FDgn8eScAYk9
 N7rVXxF1nCfF68ABdgSAws9RqS37Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1euhb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:18:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MElYdL2965387; Tue, 22 Sep 2026 17:17:59 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjtsbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:17:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MHHwPm29229592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 17:17:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92FF658055;
 Tue, 22 Sep 2026 17:17:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03DA558059;
 Tue, 22 Sep 2026 17:17:58 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 17:17:57 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
Subject: [PATCH v6 0/2] Error recovery for zPCI passthrough devices
Date: Tue, 22 Sep 2026 10:17:54 -0700
Message-ID: <20260922171756.920-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FzNOLdq_g8uO9wdFkCL_EXzA7FGJXmB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX2nPf0jz0bQBi
 nyEBXZ52WjbnwYTwVRJU96dQXFCiooabeCNGxHBnXNS1ttNCu4wjz/YFZzne5/Q7OPiZkk/rvbf
 1EvxFre9orf7XbslxjD4MqloPPDVrUrRNSBfxdn5jWZzrPTSniMvyWMyA2+xR5+U12p8F51pL71
 OKofPnX4UYquEzpka03JEPncWq7LKRzualeqoIYoZdcZQmpmQh9ZdgNHL6oOcV4AULIr5Wn2qQt
 ehKeQn4MjOdLE465VZZCJsaMNbA0112cSWnehDk4owSsoNowVpZ4/BNxEfbbqQYyuWYnj/FLtfu
 Xjxq6in45NWBz1GHLs/57FH6ADgOT2gHjKRnDnymV4pDNZGpJKBKyUIiisSTI4Z9+t4cyYwVlhb
 XHJ3ksoYHR+ijAc2YVDgsSXpJ0TAfTk3FZ5fr5E/Sbg2hbCDAgJeHwFnx1RGaccZl3atztfFJa2
 EIp9DoipIAh4L2355pw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2b848 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=VnNF1IyMAAAA:8
 a=7proyq5jN0fAEejWBk8A:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX06GscCHBsQSq
 QOujWDF+QiFeyIuArvOiR3dZD6v7wu1lFQ1klO+C6Sls7GLMXbImHaU+PRj2y+Dec9nEKd+iNMc
 4O3PakgXw8orqwhLqeeEhrscsZIRFKA=
X-Proofpoint-GUID: FzNOLdq_g8uO9wdFkCL_EXzA7FGJXmB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220250
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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

Hi,

This patch series introduces support for error recovery for passthrough PCI
devices on System Z (s390x). This is the user space component for the Linux
kernel patches [1]. The kernel patches were merged for 7.3 release.

The current design for QEMU updates the callback for vfio error notifier to
an s390x specific error handler if the kernel supports the new device
feature VFIO_DEVICE_FEATURE_ZPCI_ERROR, for s390 vfio-pci devices. So now
on an eventfd notification for error notifier it will invoke the s390x
specific error handler.  The s390x error handler will retrieve the
architecture specific PCI error information and inject the information into
the guest. Once the guest receives the error information, the guest drivers
will drive the error recovery.  Typically recovery involves a device reset
which translate to CLP disable/enable cycle for the device.

I would appreciate some feedback on this patch series.

Thanks Farhan

[1] https://lore.kernel.org/all/20260818164326.387bb27b@shazbot.org/

ChangeLog
---------
v5 https://lore.kernel.org/all/20260914174420.12309-1-alifm@linux.ibm.com/
v5 -> v6
    - Address Cedric's feedback (patch 1).
    - Update error handling to follow QEMU style (patch 1).
    - Rebase on master.
    - Remove linux-headers update as latest QEMU master has the VFIO headers
    merged.

v4 https://lore.kernel.org/all/20260831183151.12626-1-alifm@linux.ibm.com/
v4 -> v5
    - Remove err_handler() callback in vfio pci core.
    - Update the vfio error notifier callback to an s390x specific callback
    for s390x devices
    - Include linux headers for 7.3-rc3.
v3 https://lore.kernel.org/qemu-devel/20250925174852.1302-1-alifm@linux.ibm.com/
v3 -> v4
    - Include linux headers for 7.3-rc1.
    - Rework VFIO API changes based on the kernel API (patch 3).
    - Address Markus's comments from v3 (patch 2).

v2 https://lore.kernel.org/qemu-devel/20250825212434.2255-1-alifm@linux.ibm.com/
v2 -> v3
    - Update arch_err_handler to err_handler and include Error ** in
    function definition. (patch 2)

    - Introduce helper function to hide the internal indirection of device_feature()
    (patch 3)

    - Update function definitions to include Error ** (patch 4)
    


v1 https://lore.kernel.org/qemu-devel/20250813174152.1238-1-alifm@linux.ibm.com/
v1 -> v2
   - Use VFIO_DEVICE_FEATURE ioctl to get device error information.
   (Based on Alex's feedback on kernel series)


Farhan Ali (2):
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

 hw/s390x/s390-pci-bus.c          |  13 ++++
 hw/s390x/s390-pci-vfio-stubs.c   |  10 +++
 hw/s390x/s390-pci-vfio.c         | 130 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   1 +
 include/hw/s390x/s390-pci-vfio.h |   2 +
 5 files changed, 156 insertions(+)

-- 
2.43.0



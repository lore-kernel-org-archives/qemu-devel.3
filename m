Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59516CAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1q64-000478-TH; Thu, 25 Sep 2025 13:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5f-0003uE-IV; Thu, 25 Sep 2025 13:49:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5X-0008Kd-TH; Thu, 25 Sep 2025 13:49:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PGWu7q006661;
 Thu, 25 Sep 2025 17:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=jsGbxG6h9uZs36hxKXzlIG2/0Ol7
 ayOVLqUiI8yRLOs=; b=fwXjukxEjO5G2guKkVkWQtVnPrtmGP2ibTDmhtgHOF/m
 hH/PSvD8FeWPCWRHzw0qAbk+SSbE0is7Cg4swd4mfevF132gQAFVpspKCfZlfT/q
 GcsrnHxE8027gsey4r1Mi49DrLcvh5reytlTShQj4zFIhlbYd/XWCNDDrZ9jdJ0A
 qIOQ4PqLERYskWmP1145l/Mhm6bpEZjIA7Y+WT+VgB6WQmfCmJphyDdEqnMgsM6C
 OGlDnNBn5qSLTeHfnC1iv+SDqlgzKRpKzDNTrl224a7MmdcoY2i5hx74gmnH3GxU
 P50y+fXSPFPz8pBd+Xh6MkWxBCfFJcfZH3XhJWWsdg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyxhjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PH1SK0013355;
 Thu, 25 Sep 2025 17:48:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj34ed5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHmsi632637574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:48:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CDE458059;
 Thu, 25 Sep 2025 17:48:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7241458055;
 Thu, 25 Sep 2025 17:48:53 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.202])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:48:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v3 0/5] Error recovery for zPCI passthrough devices
Date: Thu, 25 Sep 2025 10:48:47 -0700
Message-ID: <20250925174852.1302-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d58088 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ke6MbEJ8MNV9wfzKq5UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Qtn98ku4spklaN9JAJyLJm7HYcJc5ViA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfXxfx5Z86bizJy
 FR7YOyQIWSqvFBnsCGoc02RbPellgvbfWMcHqdxxI8ieRq6tqlqhORGGTqrfupXaBScVwshJHHn
 RP9BnRXJ71z4Rwcgc0FdlPKe+O+AcX9eZIAyYPIiFs9gDintsyTTfrvQHyBdFhVv0fGhUmdfY+o
 LkoSZ14G6TpnTN9+ENWN54prfxpghWSNjtV+Z5YAKds+JPm5WHkhq09YoY3QsNyptyBcfikMSVW
 wBaqWHHmFJGnngPDn1OEJI2QI63nYdXlmb9GuzIa82Hc1ZKO/4kiX6YK1eNQYxWefX+To1+TGdW
 OB7lOgxjHhfjGotUoijgRzdgT5qWab6xSsBGfx4WzDCRnYFr7DxWvqj85Mfh3zDwqEqwTRJtt20
 vU9Oeldx
X-Proofpoint-ORIG-GUID: Qtn98ku4spklaN9JAJyLJm7HYcJc5ViA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

This patch series introduces support for error recovery for passthrough
PCI devices on System Z (s390x). This is the user space component for the Linux
kernel patches [1]. For QEMU on eventfd notification for PCI error from vfio-pci
driver we call the vfio error handler. We can use a per device error
handler callback to override the default vfio error handler. 

For s390x specific error handler, we retrieve the architecture specific PCI error
information and inject the information into the guest. Once the guest receives
the error information, the guest drivers will drive the error recovery.
Typically recovery involves a device reset which translate to CLP
disable/enable cycle for the device.

I would appreciate some feedback on this patch series.

Thanks
Farhan

[1] https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/

ChangeLog
---------
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

Farhan Ali (5):
  [NOTFORMERGE] linux-headers: Update for zpci vfio device
  vfio/pci: Add an error handler callback
  vfio: Introduce vfio_device_feature helper function
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

 hw/s390x/s390-pci-bus.c          | 16 ++++++
 hw/s390x/s390-pci-vfio.c         | 87 ++++++++++++++++++++++++++++++++
 hw/vfio/device.c                 |  6 +++
 hw/vfio/pci.c                    |  8 +++
 hw/vfio/pci.h                    |  1 +
 include/hw/s390x/s390-pci-bus.h  |  1 +
 include/hw/s390x/s390-pci-vfio.h |  8 +++
 include/hw/vfio/vfio-device.h    |  2 +
 linux-headers/linux/vfio.h       | 15 ++++++
 9 files changed, 144 insertions(+)

-- 
2.43.0



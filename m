Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A20CA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDmim-0001LW-HU; Mon, 05 Oct 2026 13:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDmij-0001Kf-4P; Mon, 05 Oct 2026 13:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDmig-0007Xz-FS; Mon, 05 Oct 2026 13:43:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZWxe1131263; Mon, 5 Oct 2026 17:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=bpQ8h/Sievmykzfy0+BudaEcmZA4YvfVjfV+DWrWX
 Z4=; b=rW0RBpN9/bfUkkn2O6u4OINQsIVMF3ATS72ONcYHIVunjM5IC+ofax30K
 4wH5fToX9VwpCIo9LeXp+tRmzY/yYQ5BBhcs5bqg9ynWnDklVY7SP9icN3IpkHi/
 2tkqvyOon3mTqJaEFwLKYZ2JWluTwm/tf1oDVFuBuAsN82eskYMfcrH6+WURawgw
 YwTk6pJLdrt4tkvv2a1LKVm8/BD6whp+geMRm95XZrVfpqMh8JyGFUfCNhK8irho
 Tbvh+X9mQYtrasL6/+V2AtTHvbzR44dIIEBk2GfI4qPz6qLfxAYz+ICDwFxbDNys
 dYwwdcXdmgVN6Dwki3ez0HBJjtfXA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jk906-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 17:43:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HMf8X1977504; Mon, 5 Oct 2026 17:43:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g6a0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 17:43:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695HhGmC50987372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 17:43:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7D2358060;
 Mon,  5 Oct 2026 17:43:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BF0A58056;
 Mon,  5 Oct 2026 17:43:15 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.223])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 17:43:15 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
Subject: [PATCH v7 0/2] Error recovery for zPCI passthrough devices
Date: Mon,  5 Oct 2026 10:43:12 -0700
Message-ID: <20261005174314.871-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E1GDXAFmlcyk65NZj34zfvpaLcWFbFs0
X-Proofpoint-GUID: E1GDXAFmlcyk65NZj34zfvpaLcWFbFs0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfXw0h9RbCEVr5J
 6ITSHxg+qXA+hl3a81wZS+cz8UblscS4bPX5jOCbLy4oY06PHF9kkAJJYvtyinvkc6rZSVa+aOF
 wjYVRD/Y2CzafJQYJzq5WhT3E/f5F9w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX87ps1ukw8vPB
 yQj560tOP3GIrbXH5ODbkIw/0Rr1bYTEhOIWqBWflsNRX2SiotLe+kKMSBW2KQKZRPwzmhgtban
 TU1brf9P1H+g3Nm6emkiltD9VlQQIsvPe+mK2P4ZHTOABRaCiwsu6ZWSFjQatpAYIQl4XQti2mu
 Fh6UrYhvIIiC9BQ8ajcB2Tm5DLgm9IzucvzTrDKJXh36SxILP4gwSflbLNPMdT27tlyUXkCs9C1
 MPOlIBAWkp8u+F4b9D5/ZtPJjk2v1k2jQlbJPt0PLGJJlRQT5IN67Tm2mfFnum/OHPn3o8TQ+Kf
 F1cd9hgT9NPFObajZXFJAqDH7lQPyGJG0Jbac3hzARPT7gQcohC3uRfM0ZTGMRM7AINI8aoEBDJ
 yY+/4HedDCcELZivgZ+jbJ1ijEgx81zVN8thTaoySm7zhZdDE6m3gFJrwa+982BZhDwKSzK3EVh
 AwJB7mN7X94+ojnS3Jw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3e1b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=VnNF1IyMAAAA:8
 a=x2-CgtUBMEov7oSTZx4A:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050069
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

Thanks 
Farhan

[1] https://lore.kernel.org/all/20260818164326.387bb27b@shazbot.org/

ChangeLog
---------
v6 https://lore.kernel.org/all/20260922171756.920-1-alifm@linux.ibm.com/
v6 -> v7
    - Address Matt's feedback.
    - Add an explicit check for pci_aer (patch 1).
    - Change return code for s390_pci_get_feature_err() to return <0 on error
    and 0 (on ENOMSG) or 1 on success as suggested by Matt.
    - Use common code function pci_device_reset() as it will invoke the 
    VFIO_RESET_DEVICE ioctl.
    - Change state from ZPCI_FS_ERROR to ZPCI_FS_DISABLED on a reset from error state.


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

 hw/s390x/s390-pci-bus.c          |  21 ++++++
 hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
 hw/s390x/s390-pci-vfio.c         | 123 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   1 +
 include/hw/s390x/s390-pci-vfio.h |   1 +
 5 files changed, 152 insertions(+)

-- 
2.43.0



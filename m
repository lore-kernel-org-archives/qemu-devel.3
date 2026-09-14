Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF9C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AkI-0001Ce-1V; Mon, 14 Sep 2026 13:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6AjI-0000i7-0W; Mon, 14 Sep 2026 13:44:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6AjE-0007ML-9g; Mon, 14 Sep 2026 13:44:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EFvkMV607523; Mon, 14 Sep 2026 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=i1ZBhMhBtrH1jHWox5b2SA8pkS6RJVVYZjL5VJLmK
 ew=; b=kq98GZN0tGwBdqzzgfgZ+PK1PurTaig2q8aYcb2AWMl9qvULf+JaFZ2FU
 VYFBf4glcqpmxTyBqGWEewuQMzziqp9X7i0h+h7m+NylZcnag0fNEizW0XuObwEC
 9+T6032e3qjMnwmQAkWp1mw2cvLLwohjOzJclRCLCjtdJar1PSzOgnE4mzghorPR
 AX6QME7pjkg/8f0VVi2rKIbmvVL8I0Nt9FKcSel5b811d2TuerA6F5bpNOfc7Fj3
 aShnt7NNfY9q+EU2tvxDlNjra1uBHk01qaDtCL87FSWeyCtJIV3yug6JU6ndCcHj
 fYFeuj5vuObM0I2QsOnk5nCALfB/g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq317m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:44:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EGbc872359981; Mon, 14 Sep 2026 17:44:22 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pyhxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:44:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EHiL4631916736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 17:44:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BCA358055;
 Mon, 14 Sep 2026 17:44:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7BC158043;
 Mon, 14 Sep 2026 17:44:20 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.224])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 17:44:20 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v5 0/3] Error recovery for zPCI passthrough devices
Date: Mon, 14 Sep 2026 10:44:17 -0700
Message-ID: <20260914174420.12309-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX6xCZoFlLpJw1
 w9gt50vW1ZeWO+bsiqaQBSZGxkEbOinPNaNPyzysBkipuET49ZTihF8D+R3yTDgxaxdMJyDEpE6
 1Q4+C7kz5B7h9UvEw8p1elvA5lCvZF6KFeq2/4GRGwUDrNZwgLBveKZoe4uoRtlfMQELutmdAGV
 HYby3gTnflaCsq4d11Y1OzzQIedndA+8u8RYYxhrfyfdKaTBTgNPncUTM+UVf3Gqbv3kob9qHjj
 1FJ0tEapeEs5lH1r7chVCvWRSIbsC4WOIlzCzONXTzNKbg6gbdkmWqSnl3F7UV8PA11vpWaxXlu
 8Vs8VPabbV6ldZewjEFYdYxKGuyXVB60eFwdAP9GLuXnXGUL83LxpqUEDR0OKSDeun304PSn8fv
 Y1MH3wvf2FtkBbljU8MmKROVF5JbYsvPpBQhYwY1YNlCXCeM4LrvQqyesQAWAzgH/cC5GUBVriN
 Invnr1iQZp8tZLvzAlg==
X-Proofpoint-GUID: f7324kA2_34SR9h3Cb6Q5Hauyhf08BBb
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa83277 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8 a=VnNF1IyMAAAA:8
 a=7proyq5jN0fAEejWBk8A:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: f7324kA2_34SR9h3Cb6Q5Hauyhf08BBb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX7WB1eiQL+Cbm
 qulXbOtbr//x9VW/Ds2OadiX7ag5Liq6DqXFEYmY4ymqoz1H0aPB1b3mUj4IUI1W/56Ul6Oz6hm
 lyPXVOP1dxzY+eX0OrezBQaOeUGo5fs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140248
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


Farhan Ali (3):
  linux-headers: Update Linux header to 7.3-rc3
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

 hw/s390x/s390-pci-bus.c                   |  13 ++
 hw/s390x/s390-pci-vfio-stubs.c            |  10 ++
 hw/s390x/s390-pci-vfio.c                  | 124 +++++++++++++
 include/hw/s390x/s390-pci-bus.h           |   1 +
 include/hw/s390x/s390-pci-vfio.h          |   2 +
 include/standard-headers/drm/drm_fourcc.h | 209 ++++++++++++++++++++--
 include/standard-headers/linux/fuse.h     |  63 ++++++-
 linux-headers/asm-arm64/kvm.h             |   1 +
 linux-headers/asm-riscv/kvm.h             |  13 ++
 linux-headers/linux/kvm.h                 |   1 +
 10 files changed, 417 insertions(+), 20 deletions(-)

-- 
2.43.0



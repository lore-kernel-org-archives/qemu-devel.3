Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C175CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCjD-0001vz-29; Tue, 21 Oct 2025 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCj9-0001us-Gz; Tue, 21 Oct 2025 09:48:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCj6-0006nt-MW; Tue, 21 Oct 2025 09:48:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBbhVE017699;
 Tue, 21 Oct 2025 13:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=p9xYzrSuULCjYN4zHsL2hyaUDlGl
 ia52wfrtxg6IY2Y=; b=oQaHfWkpRFhnBRJqWESq/Mk7pWoRoqP0k77/8IbRr4gC
 +SoH6En/maCq22h64OskV+C1FZa9SzcuYTvJjbNNyWJGFgXFF3JGVgMAeWDp2Yp/
 yE34+FucvpubaJ1/RWSUlku5MK7mtY77vBr17BNH94QCMmP/dea+hhX9YI7Xdpqo
 4qlhPa5kPsv9zqTBOTKCp34h+g1+tL23/QO2UrTVupfmBzYfLvhi7xWy5o3B+8FA
 6JiYa33pS0y8RzfJ+Y7Rf8Xrj1kOYq0NusrxtLKn5HR3r551Urw4K+lIuZizA0LB
 ZFxP7foSI95pqMZI7g8z57JeYyXsDMsDtqrnsTvoEA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vnyjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LDmXra017058;
 Tue, 21 Oct 2025 13:48:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vnyjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCuYXc011049;
 Tue, 21 Oct 2025 13:48:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx12qyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LDmSV932571812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 13:48:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60FFD2004B;
 Tue, 21 Oct 2025 13:48:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F62220040;
 Tue, 21 Oct 2025 13:48:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.222.96]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 13:48:25 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 0/8] Implement Firmware Assisted Dump for PSeries
Date: Tue, 21 Oct 2025 19:18:10 +0530
Message-ID: <20251021134823.1861675-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SKg7EzX1TXteYYDGs6ZgQy0yvbuhr4DJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5DyrKFlM/68x
 Hy7Nj7KOCULBKe8GCI/jajwNQsCKlAf2uyOGtOPZj0rrHakx1u1SaCNLzq3AXeVLPGLFYym3968
 BLdyGCoxxkoyiWYghnSZX//FtfUQmXWYnn9iVoXF3IiganvYqjqQ6lMOCSjM3+gZkhwhKRfwPxW
 hBChbrf4QBk5UAHsN0PIzBaBlGsFwz8P0PtR5F1l1U79auvwAV73pXAUUQKd1jGDJoH1rrKRYtD
 wbN+tTSkdZNiyx6LVRxh1EmeMJRyKMjbpdISoRwLKSYlyPoSGaX5sMNYNiWOwBCjFPgNNu/vKwx
 oUabYOclL0bhe6u20CiRK/fVYurX74xzpx8KWKHS7zicTXUgcnjfwe3fdp1Rkdcv9I+4hqhW+VF
 pyhKsR/c+amYvj7R2eSE5FpMOKXB6w==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f78f31 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=wEDoamZ1AAAA:20 a=NEAV23lmAAAA:8 a=9QOFE4DMaUSoLvWVQo8A:9
 a=QEXdDO2ut3YA:10 a=poXaRoVlC6wW9_mwW8W4:22 a=yULaImgL6KKpOYXvFmjq:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: 8jmXaxnCjeJYcyLVjxCSfvZXJ7M67urz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

Overview
=========

Implemented Firmware Assisted Dump (fadump) on PSeries machine in QEMU.

Fadump is an alternative dump mechanism to kdump, in which we the firmware
does a memory preserving boot, and the second/crashkernel is booted fresh
like a normal system reset, instead of the crashed kernel loading the
second/crashkernel in case of kdump.

This requires implementing the "ibm,configure-kernel-dump" RTAS call in
QEMU.

While booting with fadump=on, Linux will register fadump memory regions.

Some memory regions like Real Mode Memory regions, and custom memory
regions declared by OS basically require copying the requested memory
range to a destination

While other memory regions are populated by the firmware/platform (QEMU in
this case), such as CPU State Data and HPTE.
We pass the sizes for these data segment to the kernel as it needs to know
how much memory to reserve (ibm,configure-kernel-dump-sizes).

Then after a crash, once Linux does a OS terminate call, we trigger fadump
if fadump was registered.

Implementing the fadump boot as:
    * pause all vcpus (will save registers later)
    * preserve memory regions specified by fadump
    * do a memory preserving reboot (using GUEST_RESET as it doesn't clear
      the memory)

And then we pass a metadata (firmware memory structure) as
"ibm,kernel-dump" in the device tree, containing all details of the
preserved memory regions to the kernel.

Refer the Patch #7: "hw/ppc: Enable fadump for PSeries" for logs of a
succesfful fadump crash

Note: HPTE region has not been implemented. It's not planned as of now.

Testing
=======

Has been tested with following QEMU options:

* make check-functional-ppc64
* smt1/smt4
* with/without e1000e device
* gitlab ci: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2111480523

Following vmcore has been generated with v5 of this series, booted with
-smp 4: https://ibm.box.com/s/dv92hdi67hh0588xn8cbvkjmlcy04d7h

Git Tree for Testing
====================

https://github.com/adi-g15-ibm/qemu/tree/fadump-pseries-v5

Note: You will need a way to get the /proc/vmcore out of the VM for testing
with crash-utility

I use the following command line which sets up networking:
    "-net user,hostfwd=tcp::10022-:22 -net nic"

And a rootfs with ssh support, then copy the /proc/vmcore with networking
(can do compression using gzip before ssh, but compression might take lot
of time if done inside the VM)

Changelog
=========
v5:
  + rebased to upstream, implemented reviews by sourabh and harsh
  + [patch #1]: patch #1 and #2 of v4 merged into one
  + [patch #3]: copy memory region in chunks of 32MB instead of all at once
  + [patch #4]: fix endianness of vcpu id in CPUSTRT/CPUEND entries
  + [patch #5]: replaced type __be32 with uint32_t
  + [patch #7]: increased timeout for few messages to 20 seconds
  + [patch #8]: update maintainers file for fadump

v4
  + [patch #8/8]: fixed kvm testcase, add license

v3:
  + [patch #3,7]: fix compile errors (#define declared in a later patch
                  but used in this patch, unused var)
  + [patch #4/8]: use 'g_autofree' for cpu buffer, and replace g_malloc with
                  g_try_malloc
  + [patch #5/8]: use 'g_new' instead of 'malloc', add null check for cpu
                  region
  - nothing in other patches has been changed compared to v2

v2:
  + rearrange code so that no unused functions get introduced in any patch
  + add functional test for pseries as suggested by nick
  + fix multiple issues pointed by harsh and nick
  + fix bug in cpu register saving where it was being stored in
    little-endian
  - removed 'is_next_boot_fadump' and used fadump header's status flag to
    store it
  + fixed multiple style issues (naming, unneeded diffs etc)

Aditya Gupta (8):
  hw/ppc: Implement fadump register command
  hw/ppc: Trigger Fadump boot if fadump is registered
  hw/ppc: Preserve memory regions registered for fadump
  hw/ppc: Implement saving CPU state in Fadump
  hw/ppc: Pass dump-sizes property for fadump in device tree
  hw/ppc: Enable fadump for PSeries
  tests/functional: Add test for fadump in PSeries
  MAINTAINERS: Add entry for FADump (pSeries)

 MAINTAINERS                               |   8 +
 hw/ppc/meson.build                        |   1 +
 hw/ppc/spapr.c                            |  69 ++
 hw/ppc/spapr_fadump.c                     | 730 ++++++++++++++++++++++
 hw/ppc/spapr_rtas.c                       |  76 +++
 include/hw/ppc/spapr.h                    |  11 +-
 include/hw/ppc/spapr_fadump.h             | 124 ++++
 tests/functional/ppc64/meson.build        |   2 +
 tests/functional/ppc64/test_fadump.py     | 182 ++++++
 tests/functional/qemu_test/linuxkernel.py |  59 ++
 10 files changed, 1261 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_fadump.c
 create mode 100644 include/hw/ppc/spapr_fadump.h
 create mode 100755 tests/functional/ppc64/test_fadump.py

-- 
2.51.0



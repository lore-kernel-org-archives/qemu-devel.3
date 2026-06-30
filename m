Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF1CC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wec5Z-0001eI-UE; Tue, 30 Jun 2026 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wec5U-0001d7-IQ; Tue, 30 Jun 2026 13:17:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wec5Q-0004W4-PE; Tue, 30 Jun 2026 13:17:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIcwD2171251; Tue, 30 Jun 2026 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=hsQLRkoDUImkQI7KVgcwWB+TMLnOhc4fN8moV2JGI
 4k=; b=GgAV0jLhi2LF3Lio5DRV/IzShgH0LQnQ+9Ty7MR7QxhXB/BpQfoXrW0vV
 XHRWQY19KVTOwXrKCgrkZz8wJKmu5YDcolL+Io2XfDiEKXWEAlZ1CozVVN0fcEGM
 HLJk73ZQuMfigyEJVLOrSR/wMTqaRV0079hdqkowsZlIkC+IgNEExOcC4oVFEukG
 cGuSre9+yqQC1oQTa9FR5/kpASHvt0bF5U2n7VKk5Ggzta0Jodh+aBTiZIbqlR1R
 qm46gdMSAem2AudufOdKidLh8Pegxv71a2fx+IiGgYpxDz0UW4T0iB3NbqK98kmJ
 3PvN/zU9NmfbVy/lJi9hj8Gn3oFiQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26reytvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:17:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UH4a87014984;
 Tue, 30 Jun 2026 17:17:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gb7q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:17:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UHHCf249545490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 17:17:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 008AF20043;
 Tue, 30 Jun 2026 17:17:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 252CA20040;
 Tue, 30 Jun 2026 17:17:06 +0000 (GMT)
Received: from shivang.com (unknown [9.39.22.216])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 17:17:05 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [RFC PATCH 0/2] change cpu->breakpoints to a GTree
Date: Tue, 30 Jun 2026 22:45:53 +0530
Message-ID: <20260630171555.114844-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a43fa1d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=t_0_BxdfAAAA:20 a=4QNSBkfG2Dk2eB4mYasA:9
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: xfktXwgMulAPe7A8l15lOCItX_4lAbs3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfXxx3C4cgtWA/o
 qHTBAhuiM/qMXgellhjgwFBeujPLZOG0IsnDE+8HFNo3z+tzHoP3bCqruDbruUvTifgPIJRJY3f
 GS1txaLpcc7izedJUdePXi7zroz/JnNhoN18QA46WGGpgcgFShwssvLnGPymwdS42hzMg15RJ5q
 dMZ1aXI9cGI4NmE0PWHWF4pZ31/+1hsohO5QFgh3O4a2I62GWFBbRq30R6ZabhiN77zRMyC0ZDS
 pEYg67lHA8Xq8DOCZGXPNcPuVXrTjDU8hDhBNCBNoBY2okvzIHyu2z/Gz0pCiCxyn8d3RunL1pK
 nFRpyR9tnpJo6OtZ3v8yHRO7dBN/N+FTcsHqewPt4i1QNiIt/RLpOvoS9looN9jiHqsHOfMnynO
 8SgAtHLJjvKqHR4QneGZtoOdAebzOwuIh62bZ9yBAPsANzoBghEwTNbx3Y41i0P1j1aj9S6n+wK
 dF05NZhkoW3ZdvnY/eQ==
X-Proofpoint-GUID: 0krZYqliyAo8JlLC53xZ6vcENsyTTH76
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfXwXxhlFUuyYCV
 pNuoV1acmdwYNumpA7IfXpKm+OysjK4TEahfX/Va8bQtJAEVAuCoAOk3VL5Z9KhN3EfE+keS2GD
 1CaStdQddTxZrWvJQRMe/u6J8Zcx0HQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Because of compiler inlining, a single source-level
breakpoint may correspond to many guest physical addresses.
For example, on ppc64:

    (gdb)
        Breakpoint 1  at 0xc000000000019964: arch_set_bit (1846 locations)
        Breakpoint 10 at 0xc00000000006fc80: eeh_readl     (1705 locations)

qemu currently stores breakpoints in a QLIST. While
insertion is O(1), every translated instruction must
linearly scan the list to determine whether the current PC
matches a breakpoint. As the number of breakpoints grows,
this check becomes a significant execution bottleneck.

This is particularly noticeable when debugging kernels built
with heavy compiler inlining, where a relatively small
number of logical breakpoints expand into thousands of
breakpoint locations. On a ppc64 guest running under TCG on
x86, firmware boot time increases from about 1 second to
over 50 seconds with roughly 1800 breakpoint locations.

Replace the QLIST with a GTree so breakpoint lookup becomes
O(log n) instead of O(n), while preserving efficient
insertion and removal.

Measured on the same workload (ppc64 skiboot bringup):

| Configuration             | Firmware boot time |
| ------------------------- | -----------------: |
| No breakpoints            |             ~1.0 s |
| ~1846 breakpoints (QLIST) |              ~52 s |
| ~1846 breakpoints (GTree) |             ~1.4 s |

This removes the linear breakpoint lookup overhead and
restores near-baseline TCG execution performance even with
thousands of breakpoint locations.

At present, this series has been tested only with TCG. I was
unable to test other accelerators, such as WHPX, because I
do not have access to a Windows environment. I would
appreciate feedback from the WHPX maintainers, particularly
regarding any accelerator-specific changes required for the
migration of cpu->breakpoints from QLIST to GTree. I also
noticed an existing code comment referencing a future
migration of the breakpoint data structure from QLIST to a
tree [1].

[1] https://github.com/qemu/qemu/blob/master/target/i386/whpx/whpx-all.c#L1733

Shivang Upadhyay (2):
  accel/tcg: use GTree for faster breakpoint lookups
  riscv/debug: migrate debug_check_breakpoint to use GTree breakpoints

 accel/tcg/cpu-exec.c      |  26 +++++----
 cpu-common.c              | 108 +++++++++++++++++++++++++++++++-------
 hw/core/cpu-common.c      |   1 -
 include/exec/breakpoint.h |   1 -
 include/hw/core/cpu.h     |  14 ++---
 linux-user/main.c         |  13 +++--
 target/riscv/debug.c      |  71 ++++++++++++++-----------
 7 files changed, 159 insertions(+), 75 deletions(-)

-- 
2.54.0



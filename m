Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A2CC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jSM-00059g-Js; Wed, 02 Sep 2026 07:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1jSL-00059Q-DV; Wed, 02 Sep 2026 07:48:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1jSJ-0002Oy-Pm; Wed, 02 Sep 2026 07:48:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6829VtxK3694637; Wed, 2 Sep 2026 11:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=USTCtr7IRUFza9a1Vxxu5AlPiXGSsAWt48Jnq2DH7
 PE=; b=eBLexd2TV2FVjdPkRv/LU67f/YK6KHBqtkO2OfJ5xM31AK1XXXFI7TE4S
 l2QYoqn7k2Ovt5yjzUMUPCvDkcV3rEHYUkSFWn4fPlf5wubHc+M7z4xdCyIcRYcb
 ANJDs/x5ZQsG9alfe+P7B4Fsw9RAXgSBG0AhmEsnC88lP5UwELpVecEbXv4xOSEd
 P/EnEnZ3C1XLFkSuIJxZ+8VLNikOv6r6z3GP+oT9TsGtRshEau3mAMz39ajynf25
 cOgSapUJ4otSJlGWY5mFCI7VM8LWjF0r0pUAEnqxdr8TWa0CUtQpwFZIQj/TbpaI
 6FH5oGqyBfOIPnTbmPFjl3IB6l00Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhx1tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 11:48:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682BfHPR028909;
 Wed, 2 Sep 2026 11:48:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjahsva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 11:48:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682BmUoG49676654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 11:48:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C95362004B;
 Wed,  2 Sep 2026 11:48:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8908820040;
 Wed,  2 Sep 2026 11:48:28 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 11:48:28 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 adityag@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH 0/2] ppc/spapr: Fix MSI-X shadow and BAR mmap handling during
 EEH PE reset
Date: Wed,  2 Sep 2026 17:17:56 +0530
Message-ID: <20260902114758.85160-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: H8LpZkh_ti2dRuQj18AWl8HXQ3U3zPsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX1X/4jtmAvYYy
 OEtsuu4T8s6QNqNfcPasj7siIg+7VEDT5JzwS/VpIURF5XCBbzb494Tr+rgZVEaLKXw/44TN/K/
 s061xd6u1KzhN1E5xZf8NrV0Dzapl8jVm8A0PQua9DeOrMoy6aB0vLUNUmVzDfNiP75q6lwzKQy
 Md75hLEnzVi5L1bokvZD18VA2h50EYi33QX24iug2DpYUOYIx6n0t/OPbfWbgRWiaGNHPq8x+sP
 iokw+IZDfNyyM1483XCsBj7MXA1RByYv1w6PA65kEiSlwRBK4dfqjYkOH7GZImpsUxoVMrkoLC9
 S2Od0wVq06oID8Nbc7LFrmxrWp/8XzHonYXzsX0tiI9JOanAmZ0cGn60EOwZK8hdXmUD42R/PqX
 tLoyIKYJFFmwH/o++W+PMlsonXZELizCNz7inCgaWIhTPsFqwfwlpJF2ddFlLVMxLggS4FD/shA
 ME4i1YD46gfcaXFsTUw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a980d15 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=uBxslTfDUGcfhsyFpxsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX23siQ5Y6KqQr
 w8jtEeWoCYFBLdf5kpbfFre2zb9DDG+0Nf5a8SPjepsp0B2rQ/Ahh9AZZDEz5+pR6BIFw8ve5QJ
 L4WxypidE6Q/7FpR0uIZAshpnRI7Fxg=
X-Proofpoint-ORIG-GUID: AGs3hHLAVJocdUvtS_yYoeyudLoAgDrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020102
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

This series fixes two independent but related problems in the sPAPR
EEH PE reset path for VFIO pass-through devices.

Patch 1 fixes a regression in MSI-X interrupt delivery after EEH
recovery.  The previous code called msix_reset() during PE pre-reset,
which wiped the MSI-X table shadow.  On pSeries the shadow is
populated via ibm,change-msi -> spapr_msi_setmsg() -> msix_set_message()
and is not necessarily rebuilt before the guest re-enables MSI-X.
vfio_msix_enable() -> vfio_msix_vector_do_use() re-arms KVM irqfd
routes from the existing shadow, so wiping it breaks interrupt delivery.
The fix clears only MSI-X Enable using the cached config shadow and
dispatches through pci_host_config_write_common() so that
vfio_msix_disable() tears down vectors cleanly without touching the
shadow table.

Patch 2 closes a race between the synchronous PE reset ioctl and QEMU's
direct-mapped BAR mmap windows.  While the hardware is held in PCI reset
the device BARs are inaccessible.  Any guest MMIO fault that is serviced
through an active mmap during this window can produce an indeterminate
result.  The fix disables all BAR mmaps before issuing the reset ioctl
and re-enables them after VFIO_EEH_PE_CONFIGURE succeeds.  Any pending
INTx mmap re-enable timer is also cancelled to prevent the timer from
re-arming the mmap window before configure completes.

without patch:
<snip>
[   21.549925][  T251] EEH: Beginning: 'resume'
[   21.550086][  T251] PCI 0001:00:01.0#0001: EEH: Invoking tg3->resume()
[   21.605321][  T251] PCI 0001:00:01.0#0001: EEH: tg3 driver reports: 'none'
[   21.605462][  T251] EEH: Finished:'resume'
[   21.605552][  T251] EEH: Recovery successful.
</snip>
<snip>
# ethtool enP1p0s1 |grep Link 
        Link detected: no
</snip>

with patch:
<snip>
[ 5696.920423][  T250] EEH: Beginning: 'resume'
[ 5696.920497][  T250] PCI 0001:00:01.0#0001: EEH: Invoking tg3->resume()
[ 5696.975922][  T250] PCI 0001:00:01.0#0001: EEH: tg3 driver reports: 'none'
[ 5696.976165][  T250] EEH: Finished:'resume'
[ 5696.976298][  T250] EEH: Recovery successful.
[ 5700.086095][   C28] tg3 0001:00:01.0 enP1p0s1: Link is up at 1000 Mbps, full duplex
[ 5700.086330][   C28] tg3 0001:00:01.0 enP1p0s1: Flow control is on for TX and on for RX
</snip>
<snip>
# ethtool enP1p0s1 |grep Link 
        Link detected: yes
</snip>


Narayana Murty N (2):
  ppc/spapr: Preserve MSI-X shadow across EEH PE reset
  ppc/spapr: Temporarily disable VFIO BAR mmap during EEH PE reset

 hw/ppc/spapr_pci_vfio.c | 122 ++++++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 22 deletions(-)

-- 
2.54.0


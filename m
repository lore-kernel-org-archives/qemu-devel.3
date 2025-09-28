Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9897ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uMj-0004gt-Ug; Sun, 28 Sep 2025 12:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1v2uMd-0004VE-Qf; Sun, 28 Sep 2025 12:35:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1v2uML-0006Th-02; Sun, 28 Sep 2025 12:35:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SFUFE6016782;
 Sun, 28 Sep 2025 16:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=VUAp64DstNcA8NRVIi8B+U1UC3MfgC
 cjVqBnXRNoGGc=; b=TkoU+FIvkbI7P/FYybXHOdr3//Q0EIXFKjD1MBbAEthxOj
 S54c14U+3Kyan3tWXqiMid0z+P8J9bp61oN0J9pLyaosvSpzP/4oYUjad9bO+ne9
 guv2FnyC94W5W15lTQ7EZLaenYzLAYSJIYmU0JAFQTwwxvzZdUSttIJbcrMoNXCf
 mH2NWxeSRV5uG8T3alJJ1Gt+TSTJdXgGrhNCTy0QYQhb9iGuTGUW9i8CwPkM7ck0
 k4HLy1aabRGhEpWXKA+MvpPcr82H5C9xm83a0WHlUuxzV/gAU4WdXvy06zKXfxrG
 haHPe5sNnSFHMY3L/LPWrlyFqq5Gy8tro9q6a19A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh69c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 16:34:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58SGYYBT007277;
 Sun, 28 Sep 2025 16:34:34 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh69bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 16:34:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SBvO7C020061;
 Sun, 28 Sep 2025 16:34:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8rthn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 16:34:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SGYUm418022736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 16:34:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57B9020043;
 Sun, 28 Sep 2025 16:34:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4486E20040;
 Sun, 28 Sep 2025 16:34:28 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.43.72.95])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 28 Sep 2025 16:34:28 +0000 (GMT)
Date: Sun, 28 Sep 2025 22:04:23 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v10 0/8] Power11 support for QEMU [PowerNV]
Message-ID: <20250928215358.5440fe8f-37-amachhiw@linux.ibm.com>
Mail-Followup-To: Aditya Gupta <adityag@linux.ibm.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, 
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>, 
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d9639b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=8cx5piBbeFFleSexYagA:9
 a=CjuIK1q_8ugA:10 a=gFNbaldVC-z-bsjSTzMo:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX4cw6UqPBN4FZ
 AfmZmg8r7BHbgRS7Fkrk2kolZ07ReLlDFsJMZLkUW2cCpPN+fLo99vY79AZuG4FLFm6JjZf5RP2
 jcvcZHuSI6nb3YocusuZoJAbHNxjk4vu6/6ARamZrGOFgdTwyLtVFCxc5N4N03pTGkb37BEQ5Bq
 7GeZP8VTkJFIAQ8quZSwXBtpeH6EyCmkXoqGj0RsQsTNmYoBn+IYhHSm2uzdQCe2ByNqDDPgAXW
 WOUj0t8VH23t+MUVZwZdtOzI01DkAmVhiphtaxCwSjrM2CcxAU/4obcEQFay6GjFJaMOvtTKuXR
 hj34maRVZLhdca4FJQreKU0Kh7E2ettWqj3Setj1NRAmIzh3N3ZK3Z5mIBuLA5VdOnJSPMmdbGn
 dLZXWjku7TA2q7+FpXZB8xU2FCqm4A==
X-Proofpoint-GUID: IjQCbovaDsmzb_DjZA3XfNCdLcqFwfBE
X-Proofpoint-ORIG-GUID: TE3wcs4R8X0LsCwkZ5HWOqUHgxWm2h07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On 2025/09/25 11:00 PM, Aditya Gupta wrote:
> Overview
> ============
> 
> Add support for Power11 powernv machine type.
> 
> As Power11 core is same as Power10, hence much of the code has been reused
> from Power10.
> 
> Power11 PSeries already added in QEMU in:
>   commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")
> 
> Git Tree for Testing
> ====================
> 
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v10
> 
> The patches apply cleanly on below commit:
>   95b9e0d2ade5 ("Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging")
> 
> Tests ran:
> * `make check`
> * '-M powernv' / '-M powernv10' / '-M powernv11'
> * '-smp' option tested
> * 'e1000e' device
> * tested changing irq affinities to remote chips for xive functionality
> * compile test with --without-default-devices
> 
> skiboot with Power11 support: https://github.com/open-power/skiboot, since
> commit 785a5e3
> 
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1
> 

Boot tested a powernv11 guest with these patches applied.

  # cat /proc/cpuinfo
  processor       : 0
  cpu             : Power11, altivec supported
  clock           : 4000.000000MHz
  revision        : 18.0 (pvr 0082 1200)

  timebase        : 512000000
  platform        : PowerNV
  model           : IBM PowerNV (emulated by qemu)
  machine         : PowerNV IBM PowerNV (emulated by qemu)
  firmware        : OPAL
  MMU             : Radix

Also, booted a KVM guest (L1) inside it.

  [    0.000000][    T0] Hardware name: IBM pSeries (emulated by qemu) Power11 (architected) 0x821200 0xf000007 of:SLOF,git-ee03ae hv:linux,kvm pSeries

  # cat /proc/cpuinfo
  processor       : 0
  cpu             : Power11 (architected), altivec supported
  clock           : 1000.000000MHz
  revision        : 18.0 (pvr 0082 1200)

  timebase        : 512000000
  platform        : pSeries
  model           : IBM pSeries (emulated by qemu)
  machine         : CHRP IBM pSeries (emulated by qemu)
  MMU             : Radix

Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> Changelog
> =========
> v10:
>   + [PATCH 1/8]: Do same change for Power11 as done for Power10 in commit 46d03b,
>     as changes required for successful build with --without-default-devices
>   + [PATCH 3/8]: Added new patch to remove assuming chip as Power10 in xive2
>   + rebase to upstream
> 
> v9 (https://lore.kernel.org/qemu-devel/20250808115929.1073910-1-adityag@linux.ibm.com/):
>   + [PATCH 1/7]: apply hunks from commit cf0eb929e59cb, and commit
>     24c8fa968a6d8, for changes that were done for Power10, as those changes
>     make sense for Power11 also
>   + [PATCH 3/7]: fixed build breakage identified with QEMU CI, due to changes
>     in upstream function pointer types
> 
> v8 (https://lore.kernel.org/qemu-devel/20250608182842.2717225-1-adityag@linux.ibm.com/):
>   + rebase to upstream
>   + propose myself as a powernv reviewer
> 
> v7 (https://lore.kernel.org/qemu-devel/20250327200738.1524401-1-adityag@linux.ibm.com/):
>   + use Power10 models of homer, sbe, occ, psi, lpc. As they are same.
>   + switch powernv tests to use buildroot images instead of op-build images
>   + add functional test for powernv11
>   - remove dynamic sysbus device for PHBs, so no more dynamic number of
>   PHBs in Power11 as it became complex to handle it and not much used
> 
> v6 (https://lore.kernel.org/qemu-devel/20250325112319.927190-1-adityag@linux.ibm.com/):
>   + make Pnv11Chip's parent as PnvChip, instead of Pnv10Chip
>   + rebase on upstream/master
> 
> v5 (https://lore.kernel.org/qemu-devel/57ce8d50-db92-44f0-96a9-e1297eea949f@kaod.org/):
>   + add chiptod
>   + add instance_init for P11 to use P11 models
>   + move patch introducing Pnv11Chip to the last
>   + update skiboot.lid to skiboot's upstream/master
> 
> v4:
>   + patch #5: fix memory leak in pnv_chip_power10_quad_realize
>   - no change in other patches
> 
> v3:
>   + patch #1: version power11 as power11_v2.0
>   + patch #2: split target hw/pseries code into patch #2
>   + patch #3,#4: fix regression due to Power10 and Power11 having same PCR
>   + patch #5: create pnv_chip_power11_dt_populate and split pnv_chip_power10_common_realize as per review
>   + patch #6-#11: no change
>   - remove commit to make Power11 as default
> 
> v2:
>   + split powernv patch into homer,lpc,occ,psi,sbe
>   + reduce code duplication by reusing power10 code
>   + make power11 as default
>   + rebase on qemu upstream/master
>   + add more information in commit descriptions
>   + update docs
>   + update skiboot.lid
> 
> 
> Aditya Gupta (8):
>   ppc/pnv: Introduce Pnv11Chip
>   ppc/pnv: Introduce Power11 PowerNV machine
>   ppc/pnv: Add PnvChipClass handler to get reference to interrupt
>     controller
>   ppc/pnv: Add XIVE2 controller to Power11
>   ppc/pnv: Add PHB5 PCIe Host bridge to Power11
>   ppc/pnv: Add ChipTOD model for Power11
>   tests/powernv: Switch to buildroot images instead of op-build
>   tests/powernv: Add PowerNV test for Power11
> 
>  docs/system/ppc/powernv.rst            |   9 +-
>  hw/intc/pnv_xive2.c                    |   4 +-
>  hw/ppc/pnv.c                           | 560 +++++++++++++++++++++++++
>  hw/ppc/pnv_chiptod.c                   |  59 +++
>  hw/ppc/pnv_core.c                      |  17 +
>  include/hw/ppc/pnv.h                   |  38 ++
>  include/hw/ppc/pnv_chip.h              |   8 +
>  include/hw/ppc/pnv_chiptod.h           |   2 +
>  include/hw/ppc/pnv_xscom.h             |  49 +++
>  tests/functional/ppc64/test_powernv.py |  34 +-
>  10 files changed, 760 insertions(+), 20 deletions(-)
> 
> -- 
> 2.50.1
> 
> 


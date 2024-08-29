Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B7AC83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfD2-0003nB-S7; Thu, 29 Aug 2024 09:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1sje7d-0003xB-Iz; Thu, 29 Aug 2024 08:19:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1sje7a-0008AM-TW; Thu, 29 Aug 2024 08:19:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T3Poa8015583;
 Thu, 29 Aug 2024 12:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:message-id:references:content-type
 :in-reply-to:mime-version; s=pp1; bh=elXBKp3D9qMlFIbftT+K2XigBxw
 V9bQ16hHoYPke5ds=; b=nEz4MYCLwIH3wjL3nfK4N7l9siaXUgJOLhmcPyfxorA
 GRi1zPGvQgKkq7x2L2UlC+tEj373PuJwyjvhzq9nWIiOK6wdbcnMwfi0Fv/PlaSD
 85QFtCa9pUQLDNc+bNgNIIWNPFEU33BVq44at+6RiwVpFU5I4IT7EO7w26ESc4WU
 8+ycSre7rwnDa7qXxdXW/ONtPTOAWXVadd4diIGpDI8qu0d2aGHISD8hMaMGt61R
 Z1gOSwQCxwn2RVhXIzGlvGBHFENmvCIvDUTmEMMMN++RiZjrD/CrP8A1ZdtqrRQH
 fb7K+bZKhE+7tV41gh9jfSmNTFkbEW3ZC/Wlecy0crw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8q7vry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 12:19:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TCJMRj031628;
 Thu, 29 Aug 2024 12:19:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8q7vru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 12:19:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TAXM3Q003100;
 Thu, 29 Aug 2024 12:19:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417tuq4k35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2024 12:19:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47TCJHwS15794540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2024 12:19:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A00B20040;
 Thu, 29 Aug 2024 12:19:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB08F2004B;
 Thu, 29 Aug 2024 12:19:15 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown
 [9.124.208.246])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 Aug 2024 12:19:15 +0000 (GMT)
Date: Thu, 29 Aug 2024 17:49:10 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v6 RESEND 0/5] Power11 support for QEMU [PSeries]
Message-ID: <20240829174443.06c0b2ae-eb-amachhiw@linux.ibm.com>
Mail-Followup-To: Aditya Gupta <adityag@linux.ibm.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20240731055022.696051-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731055022.696051-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JJGMGPiLj_C1L7qQn7qPdFOUMcG6DbDC
X-Proofpoint-ORIG-GUID: qE27b-IviDFnSEHpPsE_kj3PuKUnBOc9
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=100 phishscore=0
 mlxlogscore=-999 mlxscore=100 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408290085
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Aug 2024 09:29:04 -0400
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

Hi Aditya,

On 2024/07/31 11:20 AM, Aditya Gupta wrote:
> Overview
> ============
> 
> Split "Power11 support for QEMU" into 2 patch series: pseries & powernv.
> 
> This patch series is for pseries support for Power11.
> 
> As Power11 core is same as Power10, hence much of the code has been reused from
> Power10.
> 
> Power11 was added in Linux in:
>   commit c2ed087ed35c ("powerpc: Add Power11 architected and raw mode")
> 
> Git Tree for Testing
> ====================
> 
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v6-pseries
> 
> Has been tested with following cases:
> * '-M pseries' / '-M pseries -cpu Power11'

I tried the below command with mailine QEMU and this patch series applied. I
could boot the guest with -cpu Power11 option but when I check inside the guest
with `lscpu`, I can still see the Model name being reported as "Power 10" while
the PVR value looks fine corresponding to Power11.

Did you see "Power 11" while you were testing this?

  $ qemu-system-ppc64 -m 4G -smp 4 -nographic -drive file=/root/testing/debian-12-generic-ppc64el.qcow2,format=qcow2 -accel tcg -cpu Power11

  root@localhost:~# lscpu
  Architecture:             ppc64le
    Byte Order:             Little Endian
  CPU(s):                   4
    On-line CPU(s) list:    0-3
  Model name:               POWER10 (architected), altivec supported
    Model:                  18.0 (pvr 0082 1200)

Thanks,
Amit

> * '-smp' option tested
> * with compat mode: 'max-cpu-compat=power10' and 'max-cpu-compat=power9'
> * with/without device 'virtio-scsi-pci'
> * with/without -kernel and -drive with qcow_file
> 
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1
> 
> Changelog
> =========
> v6 RESEND:
>   + added my initials instead of PMM in patch #1 description
> 
> v6: 
>   + reorganised patches such that Power11 introduction is at end, and
>   cleanups and fixes is done before
>   + patch #1: renamed macros from POWER_* to PCC_*
>   + patch #2: rename 'logical_pvr' to 'spapr_logical_pvr' to better convey
>   the context
> 
> v5:
>   + split patch series into pseries+powernv
>   + patch #1: apply harsh's patch to reduce duplication
>   + patch #2: simplified, by removing duplication
>   + patch #3: update docs, according to harsh's suggestion
>   + patch #4: no functional change, #define used for P9 & P10 pcr_supported
>   + patch #5: no change
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
> Aditya Gupta (4):
>   target/ppc: Introduce 'PowerPCCPUClass::spapr_logical_pvr'
>   target/ppc: Fix regression due to Power10 and Power11 having same PCR
>   target/ppc: Add Power11 DD2.0 processor
>   ppc/pseries: Add Power11 cpu type
> 
> Harsh Prateek Bora (1):
>   target/ppc: Reduce code duplication across Power9/10 init code
> 
>  docs/system/ppc/pseries.rst |  17 +++-
>  hw/ppc/spapr_cpu_core.c     |   1 +
>  target/ppc/compat.c         |  11 +++
>  target/ppc/cpu-models.c     |   3 +
>  target/ppc/cpu-models.h     |   3 +
>  target/ppc/cpu.h            |   3 +
>  target/ppc/cpu_init.c       | 188 +++++++++++++++---------------------
>  target/ppc/cpu_init.h       |  92 ++++++++++++++++++
>  8 files changed, 205 insertions(+), 113 deletions(-)
>  create mode 100644 target/ppc/cpu_init.h
> 
> -- 
> 2.45.2
> 
> 


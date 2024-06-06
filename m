Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B442C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFC99-0004B8-AS; Thu, 06 Jun 2024 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC98-0004Al-8d; Thu, 06 Jun 2024 08:23:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sFC96-000795-97; Thu, 06 Jun 2024 08:23:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 456C1WfC005227; Thu, 6 Jun 2024 12:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=pYJHETSFs8cR99YV8pr3K0T/znMAyvHmcqo4MG8YFLk=;
 b=NsDIqmNqpGrS9M/EBxReZuDYEumo44EN/uuC4pr/dfbrQTei+Vxj9jPTrdRfr7PhOgu+
 4EE9WF8kmGDYaHKLTAqHTCzzitd5R+9L5NpzTrMeAcAo3B3d+B4qlG8YA9BZUgVQmbAa
 EFRj5olpGa9k2RGGB+FIIZBpjg8ZVL3Ye7Y6rRS+RBUYAyhBynBMcJtnlLqULBq5sqUE
 v2hETk7td/25xARA0DIwbTVA9ijI6YHWlWh7dmUwzfrX2SePXT9XY4vl4RXGHi4cgFx1
 JIF1DfnuHJKo1cH0Deh6DN28cbdU7wnBAuHkYl3B+KD/HVgiGuzSBYF5bNLqj5VZjdPy OA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykb340cem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:23:04 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456CN4ND005336;
 Thu, 6 Jun 2024 12:23:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykb340cek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:23:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45690XUL026624; Thu, 6 Jun 2024 12:23:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffnaaq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Jun 2024 12:23:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 456CMv5u40567066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2024 12:22:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7022020043;
 Thu,  6 Jun 2024 12:22:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1F372004B;
 Thu,  6 Jun 2024 12:22:55 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2024 12:22:55 +0000 (GMT)
Message-ID: <b18923a9-5ea0-48d2-b5df-a8e4f48a53af@linux.ibm.com>
Date: Thu, 6 Jun 2024 17:52:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Power11 support for QEMU [PSeries]
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20240606121657.254308-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240606121657.254308-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wRHDgI2MFTUV3LcCadjOW1bIFBSLfpEX
X-Proofpoint-ORIG-GUID: Nm1tIk0TWY9wI2N65TE_l0sqT_tz6A9m
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060091
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Nick & Cedric,

Based on your comments on considering the pseries for 9.1, and having to 
wait for skiboot parts for powernv, I have split the patch series into 
pseries and powernv.

There might be little delay in posting the powernv part, where I am 
still looking into having power11's instance_init.

Also, I have applied Harsh's patch that should simplify the rest of the 
patches.


Thanks,

Aditya Gupta

On 06/06/24 17:46, Aditya Gupta wrote:
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
>    commit c2ed087ed35c ("powerpc: Add Power11 architected and raw mode")
>
> Git Tree for Testing
> ====================
>
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v5-pseries
>
> Has been tested with following cases:
> * '-M pseries' / '-M pseries -cpu Power11'
> * '-smp' option tested
> * with compat mode: 'max-cpu-compat=power10' and 'max-cpu-compat=power9'
> * with/without device 'virtio-scsi-pci'
> * with/without -kernel and -drive with qcow_file
>
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1
>
> Changelog
> =========
> v5:
>    + split patch series into pseries+powernv
>    + patch #1: apply harsh's patch to reduce duplication
>    + patch #2: simplified, by removing duplication
>    + patch #3: update docs, according to harsh's suggestion
>    + patch #4: no functional change, #define used for P9 & P10 pcr_supported
>    + patch #5: no change
>
> v4:
>    + patch #5: fix memory leak in pnv_chip_power10_quad_realize
>    - no change in other patches
>
> v3:
>    + patch #1: version power11 as power11_v2.0
>    + patch #2: split target hw/pseries code into patch #2
>    + patch #3,#4: fix regression due to Power10 and Power11 having same PCR
>    + patch #5: create pnv_chip_power11_dt_populate and split pnv_chip_power10_common_realize as per review
>    + patch #6-#11: no change
>    - remove commit to make Power11 as default
>
> v2:
>    + split powernv patch into homer,lpc,occ,psi,sbe
>    + reduce code duplication by reusing power10 code
>    + make power11 as default
>    + rebase on qemu upstream/master
>    + add more information in commit descriptions
>    + update docs
>    + update skiboot.lid
>
>
> Aditya Gupta (4):
>    target/ppc: Add Power11 DD2.0 processor
>    ppc/pseries: Add Power11 cpu type
>    target/ppc: Introduce 'PowerPCCPUClass::logical_pvr'
>    target/ppc: Fix regression due to Power10 and Power11 having same PCR
>
> Harsh Prateek Bora (1):
>    target/ppc: reduce code duplication across Power9/10 init code
>
>   docs/system/ppc/pseries.rst |  17 +++-
>   hw/ppc/spapr_cpu_core.c     |   1 +
>   target/ppc/compat.c         |  11 +++
>   target/ppc/cpu-models.c     |   3 +
>   target/ppc/cpu-models.h     |   3 +
>   target/ppc/cpu.h            |   1 +
>   target/ppc/cpu_init.c       | 183 +++++++++++++++---------------------
>   target/ppc/cpu_init.h       |  78 +++++++++++++++
>   8 files changed, 184 insertions(+), 113 deletions(-)
>   create mode 100644 target/ppc/cpu_init.h
>


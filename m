Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3B3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpBj-0007AG-Re; Mon, 22 Jul 2024 05:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sVpBh-000751-Mz; Mon, 22 Jul 2024 05:18:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sVpBe-000707-TR; Mon, 22 Jul 2024 05:18:33 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M8R2cQ019478;
 Mon, 22 Jul 2024 09:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 fqsMJDbDFkoL65U9ankgIPX0mPAkJ0b1dw4bEw9b/TA=; b=ezKyR93BrWLyXhGc
 lB4dl5rQK3/6gIQEqKmQRn6LR0W0RUq9/d5EPsschtQueaNvePplQT8UbctnjRw8
 OKI1XqFqR6Fpn8oWZnNXVXMRgHnH33lLC5jBB2oyXEY7GAc2P7Uyg72owNvlUW+W
 I7HprEXvNv3CnzeDzanWM9ktXjVg6SuE6P+DjPN2lSgu3saYrRzbxbDk2FleCLvk
 Okb+x69wr35l6E0idZf+SDxT+KmEPTRVjO/zFBIiqeAjMvq2C3MHm0iEe63wmj1L
 G3reaCv0guf9W7srwQJY87orpmgdBfGQdHbCP2tIdj9+ySlwRL7JQY+cZkojcY3X
 PPdN9Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gr8vtpb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 09:12:41 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46M9CfBV023510;
 Mon, 22 Jul 2024 09:12:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40gr8vtpb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 09:12:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46M8j1AB007907; Mon, 22 Jul 2024 09:12:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn9mgd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jul 2024 09:12:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46M9CYIK27525794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:12:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 522F12004E;
 Mon, 22 Jul 2024 09:12:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF112005A;
 Mon, 22 Jul 2024 09:12:32 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jul 2024 09:12:32 +0000 (GMT)
Message-ID: <c3c2ab69-777f-4bb2-8e39-974fca3ab8ad@linux.ibm.com>
Date: Mon, 22 Jul 2024 14:42:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Power11 support for QEMU [PSeries]
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
References: <20240606121657.254308-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240606121657.254308-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IIQuInh3hve37p4yYkbIqi4iWzK-Hx2k
X-Proofpoint-ORIG-GUID: pP3T6rrSm15bu60JBI2f-Q-IAn1yayVK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407220068
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Any comments on this ?

This series is containing only the pseries support for Power11, hence 
independent of skiboot patches. powernv is on hold till skiboot changes 
are released.


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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA7C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcTG-0003DI-CO; Mon, 23 Jun 2025 04:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uTcTE-0003A0-Mm; Mon, 23 Jun 2025 04:24:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uTcTB-0008Pm-S9; Mon, 23 Jun 2025 04:24:04 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MLPWtp021390;
 Mon, 23 Jun 2025 08:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=YgYZCj01q4SKJob1tPxvhFjVmxVUKf
 7Ro6d52Qmb/Vg=; b=tYQh5KjWx6IFwzNddHbds2OaIFTVro+BH3mNPIx9QcEr1B
 r5L/sE6iNlRdcWAbF6Ag699ePmvFlxmds1jIqfNjhMQp7MaCwFY9YIfzysMaCTPw
 V9wSMuDza+9GJWmyqKfICznamdF3rGo7gf2w1pS5L3JxCeSkUvBo4s2pOoxrPSWY
 /EDzLpDlG9GRhifxwKJrHZpRH6p0YEioDek/LKxBkRw9c5mQWy570RIXLTsdsIET
 ftjcqN7TcjP41tp9SW3R9Oj3i/LM5QbXdl+wPGLEtR0TLXBIQrxWzwcrScPK7UnS
 3F3KlYvFSEnRFVQlhzrA0Q1TJfupETiwz4qVUsiA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tgdsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 08:23:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55N7x7Qn019932;
 Mon, 23 Jun 2025 08:23:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tgdsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 08:23:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7sq3k030552;
 Mon, 23 Jun 2025 08:23:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eync2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 08:23:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55N8NtUr57606520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 08:23:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37769200CB;
 Mon, 23 Jun 2025 08:23:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11B66200CA;
 Mon, 23 Jun 2025 08:23:53 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.128])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Jun 2025 08:23:52 +0000 (GMT)
Date: Mon, 23 Jun 2025 13:53:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v8 0/8] Power11 support for QEMU [PowerNV]
Message-ID: <zd73t2zwkqfpvr4q45hrw62vvc55va243g5zjzulygr25et56n@bjmaqcmo22yo>
References: <20250608182842.2717225-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608182842.2717225-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RW-THaYWLNeNGTsuUjyWkczf1C7os_6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA0OCBTYWx0ZWRfX/XStsxCo8t4P
 DD6OJZ1QWt6EHuTt4SY/f92r0cDTxxR9JSLbfdlLrBtB1NpSKNospKnmlGzt+uqXHoKfvIX2o05
 /WV0LBINGJg/nDm/QeRYkyGh17ujis2OS6/BrteD4bWdHmA24Nof5izZN9T7bfoml0rMla9Ap2R
 fAtMCmneasuq2cVDTYbf/k66hreP94fa6ceqVswMo/QUWsFLtESMhBJ72DzvrO5nlrgs1KJE8lA
 +hy5zgO5WmZSPow1ScXGZsB+C9AkLsyY679OHRojC9HTHyiPn0r/44Aw21+zQGClHOrzgW04xIA
 4zlyydabOWIV3E8uRwlCtxDJEXmMFdgAD6FVkliw2+BS9AAsmyR4n8Y4lHvLHjFO0Xp+LLNFHk2
 X7vaUbUowXfNGx9tjcrs7D2JS7WJCnYPw4k9rIyJu6G/U/emUZwy4CiE7X5mDATCn/7EV6Jl
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68590f1f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8
 a=ZnpntpnzSE2FJ3BR_F4A:9 a=CjuIK1q_8ugA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: Tv-RkcRHaI1OoqOKYdHDJHexdOCcJOiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello,

Ping. Any comments on the series ? This doesn't have any code changes
from v6, other than fixing merge conflicts on rebase to upstream.

Thanks,
- Aditya G

On 25/06/08 11:58PM, Aditya Gupta wrote:
> Overview
> ============
> 
> Note: No changes from v7, fixed minor merge conflicts on rebase.
> 
> Add support for Power11 powernv machine type.
> 
> As Power11 core is same as Power10, hence much of the code has been reused
> from Power10.
> 
> Split Powernv11 chip/machine code into commits introducing: chip,machine,xive,phb
> This is to try to keep the code smaller in each commit, but can squash the
> xive/phb commits into respective chip/machine commit
> 
> Power11 PSeries already added in QEMU in:
>   commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")
> 
> Note: Also added a patch proposing myself as a reviewer.
> 
> Git Tree for Testing
> ====================
> 
> QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v8
> 
> Has been tested with following cases:
> * '-M powernv' / '-M powernv10' / '-M powernv11'
> * '-smp' option tested
> 
> skiboot with Power11 support: https://github.com/open-power/skiboot, since
> commit 785a5e3
> 
> Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1
> 
> Changelog
> =========
> v8:
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
>   ppc/pnv: Add XIVE2 controller to Power11
>   ppc/pnv: Add PHB5 PCIe Host bridge to Power11
>   ppc/pnv: Add ChipTOD model for Power11
>   tests/powernv: Switch to buildroot images instead of op-build
>   tests/powernv: Add PowerNV test for Power11
>   MAINTAINERS: Add myself as a reviewer of PowerNV emulation
> 
>  MAINTAINERS                            |   1 +
>  docs/system/ppc/powernv.rst            |   9 +-
>  hw/ppc/pnv.c                           | 546 +++++++++++++++++++++++++
>  hw/ppc/pnv_chiptod.c                   |  59 +++
>  hw/ppc/pnv_core.c                      |  17 +
>  include/hw/ppc/pnv.h                   |  38 ++
>  include/hw/ppc/pnv_chip.h              |   7 +
>  include/hw/ppc/pnv_chiptod.h           |   2 +
>  include/hw/ppc/pnv_xscom.h             |  49 +++
>  tests/functional/test_ppc64_powernv.py |  34 +-
>  10 files changed, 744 insertions(+), 18 deletions(-)
> 
> -- 
> 2.49.0
> 


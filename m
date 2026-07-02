Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B55C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfFWZ-0007IX-Po; Thu, 02 Jul 2026 07:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfFWX-0007Fd-5Y; Thu, 02 Jul 2026 07:24:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfFWV-0002vb-53; Thu, 02 Jul 2026 07:24:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621L3572348150; Thu, 2 Jul 2026 11:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lBZFy3
 /gKn3/7zPK68VP9F5Qi/eMnbSWP6cqB0+60Xc=; b=cIgv2rNyAvbxEtS7HQqAXn
 1vG3EY06MAI/3YD3ROkCzCqnWdfxTy/xJ8F6ab98SwzDxoFTsiHcP/QXgR6BqI7G
 3c5Tt4wmF3NEsQ6/9xtyCVx5k64+Bw4tZ/CP19n/HhuX42YmBDdyGGHoKybZCaVT
 ZzlJZ5IvH3jrcddsQDKSUPVfvtGdUD5cIadVQy0nOxHBOuZzDZQ0Vbgyeoj27huu
 vQORH0wKhS/5rovmHhqHLCKUZX4xtCl59lcZ+JnWAerQAZ+nDlZuOWXL5tTEsB1d
 fR3TowVxSo1ITJtts7b3FHcVnk3tPhogmbX3sIb+oI0wFtCUDdEoK1hBWxBqm/dg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk16yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 11:24:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662BJqDR018328;
 Thu, 2 Jul 2026 11:24:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhykg9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 11:24:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662BNtB949938940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 11:23:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2A6C2004B;
 Thu,  2 Jul 2026 11:23:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A72C020040;
 Thu,  2 Jul 2026 11:23:54 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 11:23:54 +0000 (GMT)
Message-ID: <595c4ea3-d40e-403d-ac7e-be42ca8175a4@linux.ibm.com>
Date: Thu, 2 Jul 2026 16:53:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] powerpc: Testcase improvements and Power8E/NVL
 removal
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Miles Glenn <milesg@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExOCBTYWx0ZWRfXzvAiBfsOiK62
 wMdF+5aU397jDLRq2dHOeZ7BZDWy7g97APaeApd9coKLgVdnqEGzAacxH3aIoPGm3nM1Yyilvf1
 E+/WM1IhKpAaWCkPPGwUR/SM9JuMv4pfLo4wsWJK7ee7Ay0V2wOuucTt4nbvncSZ1oD9u051NZ+
 ZN4a8prUIbi6RSmehXqYiDwSmH8EmdSmCf/3bYh4RQAlAa9cKPdXDXe0xlOe8cyYWGCw/TMX1r7
 /wV/0B3ISQeLI98Fj+g/r99IGuolasNfBxDF8aNG44UB+bf4TYAqNYTlUlSrxap8Gae3K6A8Rmb
 9wJgcWUn9zRLzrcFZ/8FElUDc0GPCsMP5a+gOIjXetKJ2Qbg64hNI0gTRyiOV00T7q6d09Xgu4j
 9Oym+GDiX73Nd5B8djbiAOWcIZtS727zOvrvPZ/qHjpJVBMqV8/RuTVCHEC5+8ZyxQ+llytSgkA
 rQ+W9/24+6EysQa4I5g==
X-Proofpoint-GUID: IaOD_7a85ZwOhhLJYQiT0rg6oO2wQXz4
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a464a51 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=peDO8-P9qwNcHxEO984A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExOCBTYWx0ZWRfX9ovopNIB6B4S
 tDOkZrl/uABv+LjwDQNI27HlrCLqc/HGYOAP44D/zswYCSWbA7wpm7fp+4Xn0Bpzy/K6auB6geB
 DyQn6jBOucivU+4qhPV0MihLIGCkpWA=
X-Proofpoint-ORIG-GUID: IaOD_7a85ZwOhhLJYQiT0rg6oO2wQXz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 01/07/26 02:33, Aditya Gupta wrote:

> Overview
> ========
>
> This patch series merged two patch series sent earlier:
> 	"Testcase improvements for PowerNV"
> 	"Remove deprecated Power8E and 8NVL CPUs"
> since the Power8E removal series depended on the former due to pnv-spi test
>
> Broadly contains 3 changes:
> 1. Testcase improvements:
>      Add a testcase to detect regression in remote interrupts when XIVE changes,
>      since such regression had occurred during Power11 XIVE changes:
>      https://lore.kernel.org/qemu-devel/baf6c854-832b-4a2e-922f-d34e6dadf821@redhat.com/
>
>      Also add Power11 chip and testcase in qtests, and fadump functional test
>
> 2. Power8E/Power8NVL removal
>      Power8E and Power8NVL were deprecated since QEMU 10.1, with
>      commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>      
>      Hence, remove usage (chip and core types) of Power8E and 8NVL from PowerNV,
>      PSeries as well as testcases.
>
> 3. Maintainer changes
>      Add myself as maintainer for PowerNV machine
>
> Testing
> =======
>
> * Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/feat_maintainer-v4
> * Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2641510943
> * Successful ppc64 functional tests, qtests, boot tests, builds at all commits
>
> Changelog
> =========
> v4:
> + #1: added cores=1, as suggested by cedric, no functional change
> + #3: remove unneeded headers, as suggested by cedric
> + #3: keep power10 xive2 test, as suggested by nikhil
>
> v3:
> + #3: use machine_type array in pnv_xscom_addr, as suggested by shivang, harsh and balaton
>
> v2:
> + #1: put e1000e on socket 1, and disable it's cpu, as suggested by cedric
> + #1: pull out command fail checks into a helper, as suggested by shivang
> + #2: use g_autofree, suggested by cedric
> + #3: use g_autofree in tests updated
> + #8: remove G:, as suggested by daniel
> + rebased to upstream
>
> from previous split series:
> + #1: added checks to see if network is up and interrupts happened, based on shivang's review
> + #3: replaced common if-else-if check for machine type with pnv_get_machine_type
> + #7: added doc in removed-features, as suggested by cedric
> + #6,7: added rb from philippe
> + #8: new patch, maintainer change
>
> Aditya Gupta (8):
>    tests/functional: Add remote interrupts test for PowerNV
>    tests/qtest/pnv_spi: Test Power11 PNV_SPI
>    tests/qtest: Add Power11 chip & machine to qtests
>    tests/functional: Use default powernv machine instead of power10
>    ppc/pnv: Replace Power8E with Power11 for 'none' machine test
>    ppc/pnv: Remove Power8E and Power8NVL pnv chips
>    ppc/pnv: Remove Power8E and Power8NVL CPUs
>    MAINTAINERS: Add self as maintainer for PowerNV
>
>   MAINTAINERS                            |  2 +-
>   docs/about/deprecated.rst              |  9 ---
>   docs/about/removed-features.rst        |  8 +++
>   docs/system/ppc/powernv.rst            |  2 +-
>   docs/system/ppc/pseries.rst            |  2 +-
>   hw/ppc/pnv.c                           | 62 -----------------
>   hw/ppc/pnv_core.c                      |  2 -
>   hw/ppc/spapr_cpu_core.c                |  2 -
>   include/hw/ppc/pnv.h                   |  8 ---
>   target/ppc/cpu-models.c                |  6 --
>   target/ppc/cpu-models.h                |  4 --
>   target/ppc/cpu_init.c                  |  6 --
>   target/ppc/kvm.c                       |  4 +-
>   tests/functional/ppc64/test_fadump.py  |  2 +-
>   tests/functional/ppc64/test_powernv.py | 95 ++++++++++++++++++++++++++
>   tests/qtest/machine-none-test.c        |  2 +-
>   tests/qtest/pnv-host-i2c-test.c        | 10 ++-
>   tests/qtest/pnv-spi-seeprom-test.c     | 20 ++++--
>   tests/qtest/pnv-xive2-test.c           | 21 ++++--
>   tests/qtest/pnv-xscom-test.c           | 22 ++----
>   tests/qtest/pnv-xscom.h                | 38 +++++++----
>   21 files changed, 175 insertions(+), 152 deletions(-)

Hi Glenn,

Do you have any comments on the series, can you give an ack or rb ?


Thanks,
- Aditya G

>
> base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0


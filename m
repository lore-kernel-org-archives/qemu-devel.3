Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3A6CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xeO-0006yK-S8; Tue, 23 Sep 2025 03:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1v0xeL-0006xK-38; Tue, 23 Sep 2025 03:41:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1v0xeG-0003vZ-8r; Tue, 23 Sep 2025 03:41:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7J42i010287;
 Tue, 23 Sep 2025 07:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kSqoBo
 G4fH09VJjUt10n190d3W+7yCtjp6SvcpIgl2g=; b=PY7AyxTbOsVXX40UJadCxk
 11BnOCPqCvaeI4oT7cmqY3GCi9xlp72Il5gBaqA1fW3H/NDJAytiI6KRyqGYgt/Y
 4OqV61WKeThsDkkXzoyn+2Xj3v0+QFunqATflXLSe9+koRiAo+bw9IrRJYDdi4qr
 4FT9VPHEXIbNq43rqfNMlSBBkv4u7q/p/lMVidWq5CLkkrPUhkGB4HE08t13kR61
 kYEOw1tAlgD22fdtAPklFfNRoxuU/hs0pytwAhDTCbi7LWbNoVXKSJVgf0SzUO0K
 99MLMHdMTZMXqQA6ww+Miy3/m+fB5/xPVmKh0ynJsCf9DeK25ALjWRcMvXjeDj4g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq7c0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 07:41:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58N7YQK5019501;
 Tue, 23 Sep 2025 07:41:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq7c0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 07:41:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N4vxsL008826;
 Tue, 23 Sep 2025 07:41:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxtav0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 07:41:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58N7f4Km10158918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 07:41:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDE3358054;
 Tue, 23 Sep 2025 07:41:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5887358050;
 Tue, 23 Sep 2025 07:40:56 +0000 (GMT)
Received: from [9.61.250.51] (unknown [9.61.250.51])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Sep 2025 07:40:56 +0000 (GMT)
Message-ID: <7188cc7c-4388-488d-b9ed-4ca9be4159cf@linux.ibm.com>
Date: Tue, 23 Sep 2025 13:10:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, anushree.mathur@linux.ibm.com
References: <20250607110412.2342511-1-adityag@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20250607110412.2342511-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d24f12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JhCwfkVEemZAe76ZZ40A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NiqPC1_LDM84FE_XhjirPoz124jGIoNJ
X-Proofpoint-GUID: r_g_sv4UTnDW_G9OsQ1o86EDBwlkqJ8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX7PnnoebKW4I+
 APwuz/piRmGIFXLbinRmYvTG2z05AWE5HIQXL69CYO4ybg8uBbsyz1deXo92NcFZ3Z9Kv1+mP/Q
 Rrv0JBMNFikHS3EAsK2h83x2OIDLLF/UzmbSkmFCukjxSmENWAa7aawnFHuZvJp0JhjzoM+oEEi
 owez3zF8Gg7sWHAV2Y6yfSsFhldeZGraOPGTx6sy7WvaRSYEus/cljnwR5B5giUWLda6eHFcP5z
 5SFBT/1yo4nDJY0H0xne5RBzt9rc3CAcV3DDuIeBcHYzxrWcJbpC2hw0xH1dtET9begXg2EXCyC
 gZYsuhKfUawAHalF0MiizDL06sTuuynhmK9fKN8xBq2ECIP6JHDFZ+uR/GTV+CvRqmM5GyfJA0c
 BarCgUU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 07/06/25 4:34 PM, Aditya Gupta wrote:
> Note: No changes, only change compared to v6 is rebased to upstream
>
> Power8E and Power8NVL are not maintained, and not useful to qemu, and
> upstream skiboot also has removed support till Power8 DD1.
> Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
> to be exact:
>
>      commit c5424f683ee3 ("Remove support for POWER8 DD1")
>
> No direct way to deprecate the pnv chips, a field like deprecation_note
> could be added, but felt not needed as the chip will only get used if
> the user requests corresponding 8E / 8NVL CPU, which will print
> deprecation warning.
>
> Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> which will throw the deprecation warning. So just deprecating CPUs should
> be enough.
>
> Changelog
> =========
> v7:
>    + rebased to upstream
> v6:
>    + change qemu version from 10.0 to 10.1 in doc
> v5 (https://lore.kernel.org/qemu-devel/20250422043843.26115-1-adityag@linux.ibm.com/):
>    + split into 2 patches, defining macro, and deprecating 8e & 8nvl
> v4 (https://lore.kernel.org/qemu-devel/20250330211012.2932258-1-adityag@linux.ibm.com/):
>    + remove unnecessary 'if'
> v3:
>    + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
> v2:
>    + add mention to docs/about/deprecated.rst
>    + add '(deprecated)' in output of qemu-system-ppc64 --cpu help
>
> Base Commit: 96215036f47403438c7c7869b7cd419bd7a11f82
>
> Aditya Gupta (2):
>    target/ppc: Introduce macro for deprecating PowerPC CPUs
>    target/ppc: Deprecate Power8E and Power8NVL
>
>   docs/about/deprecated.rst |  9 +++++++++
>   target/ppc/cpu-models.c   | 20 +++++++++++++++-----
>   target/ppc/cpu_init.c     |  7 ++++++-
>   3 files changed, 30 insertions(+), 6 deletions(-)
>
>
Hi Aditya,

I have tested this patch, it is giving proper mention as deprecated
for the CPU model Power8E and Power8NVL and  here is my observation:

Without the patch it is not showing any cpu-model as deprecated

# qemu-system-ppc64 --cpu help | grep power8
   power8e_v2.1     PVR 004b0201
   power8e          (alias for power8e_v2.1)
   power8nvl_v1.0   PVR 004c0100
   power8nvl        (alias for power8nvl_v1.0)
   power8_v2.0      PVR 004d0200
   power8           (alias for power8_v2.0)


# qemu-system-ppc64 --cpu help | grep deprecated
No output for this


After applying the patch
# ./qemu-system-ppc64 --cpu help | grep deprecated
  power8e_v2.1   PVR 004b0201 (deprecated)
  power8nvl_v1.0  PVR 004c0100 (deprecated)


# ./qemu-system-ppc64 --cpu help | grep power8
   power8e_v2.1     PVR 004b0201 (deprecated)
   power8e          (alias for power8e_v2.1)
   power8nvl_v1.0   PVR 004c0100 (deprecated)
   power8nvl        (alias for power8nvl_v1.0)
   power8_v2.0      PVR 004d0200
   power8           (alias for power8_v2.0)

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>


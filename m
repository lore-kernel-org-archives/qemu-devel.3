Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CA0C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcSZ-00026S-4y; Mon, 23 Jun 2025 04:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uTcSX-00025i-6o; Mon, 23 Jun 2025 04:23:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uTcSU-0008L6-Jt; Mon, 23 Jun 2025 04:23:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N3i5cW021411;
 Mon, 23 Jun 2025 08:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Dn149TXpT0yQFMPw4lnEER6IPO3/De
 YvCrEBx0lmvSU=; b=FgIMXPGpLKEiJ+ixs2Hm0ivzUas+UrYef6+cOOv5wwjArQ
 XlQirNdJFpM0c+EUl3A2tk2xa/8FA0Urr2wL7h3Jkceqf3sZQ6q/E+C7chDZYv57
 YcPgSBEeDmn4e8M9VK0HWvmgAA2DVsbKCi4wLPsOOim6IIFs39AjI+lWO9MzRQGh
 lZQ6wS6/eANZ87+nwdZ6bzaDqsges90zTqSfu/3+HCohJCnTnn5LiFrYGxrUV2tX
 58yU3w4prG3wnrxl9R82qqPJVaRF0XiuYqweafMqQAprufWqikF/nea9E7s7dSwj
 keTQ7gnMpVbnhCyIqyA+t8amhiOxeeHnBpjDeVqQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tgdps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 08:23:13 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55N88KDm008571;
 Mon, 23 Jun 2025 08:23:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5tgdpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 08:23:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8CSgH030533;
 Mon, 23 Jun 2025 08:23:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eync04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 08:23:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55N8N8nD13828386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 08:23:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FF1A20091;
 Mon, 23 Jun 2025 08:23:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31CC22006E;
 Mon, 23 Jun 2025 08:23:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.128])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 23 Jun 2025 08:23:02 +0000 (GMT)
Date: Mon, 23 Jun 2025 13:53:00 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v7 0/2] Deprecate Power8E and Power8NVL
Message-ID: <n5qbv2yfdestvu6rv6cgpjsgdh5ngavvw2dz27m7faakaurpbk@aynkkpwvu65g>
References: <20250607110412.2342511-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607110412.2342511-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xuC0N14e-oYaQBDoWmm_1uS0e1ffdMFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA0OCBTYWx0ZWRfXyQeFbwd4X6c8
 hRekHgVkIk6aHnHvyxINUSZyvg+ZVMQvg8OXDW+GWZva5aF2i2XevPbvM4VNYoMN45jc+x7l7T7
 bQzPXf4kyVS4Pyec75coVo/HQuyTEiNvFC1TSoPs9/nGc1I5ot1JT1e3UD2jlBryWBEVcayEvUj
 K488Bpz6gccmsWkvf4V2OVqZ918T8KxIOAtyGGF/0RzGyrO0s73J843w3UftiORBjnm2dCBw1Er
 trjNCC8zQjyrdoPHA3ojxw3xaNaaG04vwQhsWyadDEInkisYNJ3AQBwUj1ZV3vUqj2CvSDTApUN
 Z9z9XAVsBN9qpBRk7h9bo1ngupYp1cWSR2fwAgICGwR4fTzjh3bC12YGdsCYVi4B+EgwpHW66le
 fl5JpsXYQ+vjQq/A5Qwe6vxzPQxx6xwB31ovuJE1qi/cnPqbhVVpEAvEi9HZR9TUFG1X2UqP
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68590ef1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EYEdIVbIVQ_7ibUKAqMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fdO8vQr24GR49z_7qWHoGUwdyoVCOyzF
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

Ping. Any comments on the series ?

Thanks,
- Aditya G

On 25/06/07 04:34PM, Aditya Gupta wrote:
> Note: No changes, only change compared to v6 is rebased to upstream
> 
> Power8E and Power8NVL are not maintained, and not useful to qemu, and
> upstream skiboot also has removed support till Power8 DD1.
> Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
> to be exact:
> 
>     commit c5424f683ee3 ("Remove support for POWER8 DD1")
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
>   + rebased to upstream
> v6:
>   + change qemu version from 10.0 to 10.1 in doc
> v5 (https://lore.kernel.org/qemu-devel/20250422043843.26115-1-adityag@linux.ibm.com/):
>   + split into 2 patches, defining macro, and deprecating 8e & 8nvl
> v4 (https://lore.kernel.org/qemu-devel/20250330211012.2932258-1-adityag@linux.ibm.com/):
>   + remove unnecessary 'if'
> v3:
>   + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
> v2:
>   + add mention to docs/about/deprecated.rst
>   + add '(deprecated)' in output of qemu-system-ppc64 --cpu help
> 
> Base Commit: 96215036f47403438c7c7869b7cd419bd7a11f82
> 
> Aditya Gupta (2):
>   target/ppc: Introduce macro for deprecating PowerPC CPUs
>   target/ppc: Deprecate Power8E and Power8NVL
> 
>  docs/about/deprecated.rst |  9 +++++++++
>  target/ppc/cpu-models.c   | 20 +++++++++++++++-----
>  target/ppc/cpu_init.c     |  7 ++++++-
>  3 files changed, 30 insertions(+), 6 deletions(-)
> 
> -- 
> 2.49.0
> 


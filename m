Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC8CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 04:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLD5o-0007sX-Bv; Mon, 17 Nov 2025 23:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vLD5m-0007s8-68; Mon, 17 Nov 2025 23:13:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vLD5k-0003jO-CD; Mon, 17 Nov 2025 23:13:21 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHEeecd004368;
 Tue, 18 Nov 2025 04:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0lJPia
 oyi9ca0H01LmhMDPET+xuk8uP7ZzvGbB7+08c=; b=ma0bxW/LQ8ZzTjI3pNNtbO
 CNa+UO16/N0P3BizDry+qB9J4UDEcPeOY6XRbSbxfWEvvf8OrHuVzH0MsPWxZ//4
 /a/udtMDiwOufRCgpJDw15NzNWr99bRwPPu8P7/E4h5Ek6rZJT6sNzXIxKwBEPqE
 iTvBMDJYJ8DbHxjzDapBtUUOnb/NdKFmZHCbkfIz4zcM7l16q+TOmEbxvtUwUN8F
 J9LTX1uOPmh568UAEx7mOTwyKAFZ9eRXqSb+4P5JkxsBtjKAXkmuUcty8hmZD02D
 Z9Vzw1v2BZp/ScM/pzlWXkEHwpHy3PYGJyrCbLEaYNh5AyS1EjZgHZAmFi8e/Zeg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw11y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 04:13:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AI4DCbO006028;
 Tue, 18 Nov 2025 04:13:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw11xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 04:13:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI37DVo005122;
 Tue, 18 Nov 2025 04:13:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bk1803-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 04:13:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AI4DAlO56885726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 04:13:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B13958056;
 Tue, 18 Nov 2025 04:13:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10AD358052;
 Tue, 18 Nov 2025 04:13:07 +0000 (GMT)
Received: from [9.124.214.28] (unknown [9.124.214.28])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Nov 2025 04:13:06 +0000 (GMT)
Message-ID: <ad71f1b6-8812-4321-bbb3-c71bc444df89@linux.ibm.com>
Date: Tue, 18 Nov 2025 09:42:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v3 2/2] docs: Mention 32-bit PPC host as removed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>
References: <20251117171236.80472-1-philmd@linaro.org>
 <20251117171236.80472-3-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251117171236.80472-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691bf258 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=xhG6Rwe5lPNu1tIRiWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX5OBGTKAS4GD3
 rUiG1sUVT3c8rh7mICBWDTLXTpESDG19PNtWthr5p1Ii+WcD0VDfN5tT1tcR05Mzn89iE2iZgNl
 JF1x6Hk4aQgpkuW5KmTHMn/3z5G5LvKFPVvh7yq7I5y9b5ZrVpPPAQLsVmfoOl32u9e3sQbv9aJ
 QREP14oofk8bqsVYYvw0dO0rfQ4a0VdsUsERrzX6qB4EsfcgXGP4/5rbgS8RBzssGavsS30xOYU
 4o91zazvlbKzxiOAihDNzaWYNA82bk2md8+XaS0ZaqdQhgWletBEAkB5ElRmL9z0Wkygc4XlJos
 37A7lW9LQ5NqMVR9oBYZTSffTkn0+Xi93kHI7bI+3hL/maARw0Kzuo+Vjap6p7TBRBnY/nrScHL
 JGXnuefDQODp3KvRRDoV9AQnE/cTBw==
X-Proofpoint-GUID: 77Vr9Qhye5aCr2204-zcq6LY04oxt2Xw
X-Proofpoint-ORIG-GUID: Q-pVOZ77vScSkYWnQfM6zCmCJki2cqLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 11/17/25 22:42, Philippe Mathieu-Daudé wrote:
> We removed support for 32-bit PPC hosts in commit 5c1ec5a1ee0
> ("tcg/ppc: Remove support for 32-bit hosts").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   docs/about/removed-features.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index a72df26dd24..422b9c98d35 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -902,6 +902,11 @@ From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
>   Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
>   maintain our cross-compilation CI tests of the architecture.
>   
> +32-bit PPC (since 10.2)
> +'''''''''''''''''''''''
> +
> +The QEMU project no longer supports 32-bit host builds.
> +
>   Guest Emulator ISAs
>   -------------------
>   


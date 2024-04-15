Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52508C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 06:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwG5T-0007qn-9C; Mon, 15 Apr 2024 02:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rwG5O-0007pC-Fe; Mon, 15 Apr 2024 02:45:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rwG5M-0003Ls-L4; Mon, 15 Apr 2024 02:45:02 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43F5xhgi026847; Mon, 15 Apr 2024 06:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2f3mC0MveLoqAGzbHuJcz1A+T3asq6NfIjFNB9xmYb4=;
 b=ctSEyN2b+YEPzOJ1wrS4msUyq0RyZIydDFwLHnT7rVuyQxfHmyCWQDwk2y6IW/jZvP2U
 O44ZFvnOOR6zz38m5PwD/L7eRG19nn4wNpB36U1BgoAPO8qBvaQ5TUIWl2pQFhhGPNi8
 qHkuxQI93IVgsxMwdhhvzuV1mLZANxyXKIUXSDwIiibyIUFWXQeB1YruD/ImgK1+MWi4
 W75JDm+42uK8Ol2FGKFG66Q9q824tbax8DK53SUzkvcJ4m24LBd+GdbILT+nQvSefoy4
 S8+vGfkdL171zoiEna2SbqIP6kaZW2bIVOvMHZsTUb0LPdZKB7uYM8N0/0F4pxBZqQvp wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgmufgt6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Apr 2024 06:44:51 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F6ipi6028057;
 Mon, 15 Apr 2024 06:44:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgmufgt6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Apr 2024 06:44:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43F6bvDF015506; Mon, 15 Apr 2024 06:44:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vkx73b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Apr 2024 06:44:50 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43F6il1P26215088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 06:44:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E362B58052;
 Mon, 15 Apr 2024 06:44:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C53058068;
 Mon, 15 Apr 2024 06:44:45 +0000 (GMT)
Received: from [9.195.42.95] (unknown [9.195.42.95])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Apr 2024 06:44:44 +0000 (GMT)
Message-ID: <216f09dd-6a19-4c0d-9994-1942f21e6bb5@linux.ibm.com>
Date: Mon, 15 Apr 2024 12:14:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] hw/ppc/spapr: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-4-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240411101550.99392-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xxuKvwJwfZtagdCsY4kBxebyUYp9AJsu
X-Proofpoint-ORIG-GUID: 2JTZClb7UQzMyNNBDm8OfOYX8dzR2Xmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=828
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
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



On 4/11/24 15:45, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.

s/developper/developer ?

> 
> Replace sprintf() by snprintf() in order to avoid:
> 
>    hw/ppc/spapr.c:385:5: warning: 'sprintf' is deprecated:
>      This function is provided for compatibility reasons only.
>      Due to security concerns inherent in the design of sprintf(3),
>      it is highly recommended that you use snprintf(3) instead.
>      [-Wdeprecated-declarations]
>        sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
>        ^
>    1 warning generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

With the typo fixed,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   hw/ppc/spapr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e9bc97fee0..9e97992c79 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -382,7 +382,7 @@ static int spapr_dt_memory_node(SpaprMachineState *spapr, void *fdt, int nodeid,
>       mem_reg_property[0] = cpu_to_be64(start);
>       mem_reg_property[1] = cpu_to_be64(size);
>   
> -    sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
> +    snprintf(mem_name, sizeof(mem_name), "memory@%" HWADDR_PRIx, start);
>       off = fdt_add_subnode(fdt, 0, mem_name);
>       _FDT(off);
>       _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));


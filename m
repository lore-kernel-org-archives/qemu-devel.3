Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AC0E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 05:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN3Qq-0000uu-Sm; Mon, 16 Dec 2024 00:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tN3Qh-0000uY-Go
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 00:14:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tN3Qf-0006aU-N6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 00:14:03 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qPAL011476;
 Mon, 16 Dec 2024 05:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SeUmPb
 Wo6GVkGAzzgUbYmLYMJTEXueMXl1QcLcrHF3I=; b=o3Np+i7/2Ewqa6afexOucC
 1xNtAjNKlNUIaTdtrfIoUkN3YPCvkDTeRDMU7kPycEWMldXDfHtQUPFIK5OZWzMo
 FylQD9crAfebKDVa+jNkZGsAvb+kd/RPIVO6N9odsKURfFr6HCofMawElpcZ74uA
 /Oo1TMCaBHcwTV61O9VRcy8pdel6nQiO5G8ox5uCitaO6iNOBVDu0C+tUJGBpT37
 3MGds48MJ4p2tBnZDHvzQKl6PIWbD3F9MfFf0NZYgLi4eAXnnRPcQ4OPueR+I6t0
 +8y+xdZDBn0nTmJyuiwvK0+BgAMV+agbkXEfpkwyT0ibF6Zz7P6RYnPkNzFpq/fA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb08x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 05:13:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG0ItrZ024027;
 Mon, 16 Dec 2024 05:13:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnuk4ct9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 05:13:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BG5DuUX23986726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 05:13:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2A758059;
 Mon, 16 Dec 2024 05:13:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4343F58058;
 Mon, 16 Dec 2024 05:13:55 +0000 (GMT)
Received: from [9.124.213.164] (unknown [9.124.213.164])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2024 05:13:54 +0000 (GMT)
Message-ID: <0c29e977-2210-4bd7-9ccd-fef07a630c4a@linux.ibm.com>
Date: Mon, 16 Dec 2024 10:43:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] target/ppc: Remove empty property list
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
 <20241216035109.3486070-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241216035109.3486070-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JXhaqvZLqTmLScqtw0_BSz5KT1r2_iXO
X-Proofpoint-GUID: JXhaqvZLqTmLScqtw0_BSz5KT1r2_iXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160038
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.168, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 12/16/24 09:20, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/cpu_init.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 1253dbf622..5e95790def 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7414,11 +7414,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
>   #endif
>   }
>   
> -static Property ppc_cpu_properties[] = {
> -    /* add default property here */
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/core/sysemu-cpu-ops.h"
>   
> @@ -7468,7 +7463,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>       device_class_set_parent_unrealize(dc, ppc_cpu_unrealize,
>                                         &pcc->parent_unrealize);
>       pcc->pvr_match = ppc_pvr_match_default;
> -    device_class_set_props(dc, ppc_cpu_properties);
>   
>       resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
>                                          &pcc->parent_phases);


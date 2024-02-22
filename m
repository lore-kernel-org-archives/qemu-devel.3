Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FF3C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Tv-0006Ja-6i; Thu, 22 Feb 2024 04:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rd5Ts-0006Ii-37; Thu, 22 Feb 2024 04:35:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rd5Tq-00041E-Hp; Thu, 22 Feb 2024 04:35:03 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41M9D00U009573; Thu, 22 Feb 2024 09:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3VCUI0JQqZoHmiUFs8/nzOtlc81PfO3pveBkPgkn7VY=;
 b=de7PMCXKoj8JpWwZyIeUhrRqAx1F6rGFhzg8XDgsJGjIvaXFSx0dPFqSwTpS2VckKStQ
 HLpqmhuIWJPw3oQKgkUrkfzTP7VpXH8w/YwO11zN85IlJjPRgNW5idCDc38LderebWdd
 X5VXk5xJntXqdFTvqBKvgb9yCbSbyys2uSGdzseUIb/Y2bf5/2rDOnbiedUfLkBwXqZ7
 Fo9wbxAe/ZRfOMFL96CNrHM9rSCBrWrt8ubhK+6G8Zzve0QZqw9UEeiZJdRs+zxFM8o7
 djxY4Bg7t/hpeKLEsNqvt7dBr+mWRWMxDS5qHyeWy6weeqbNQ03jT4oJHX/JMabBdvBQ aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we3ek8gqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 09:34:52 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41M9UsZu019375;
 Thu, 22 Feb 2024 09:34:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3we3ek8gq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 09:34:52 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41M7jE7w013452; Thu, 22 Feb 2024 09:34:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0neuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Feb 2024 09:34:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41M9Yn5127787896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 09:34:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 426DE5803F;
 Thu, 22 Feb 2024 09:34:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DA8458054;
 Thu, 22 Feb 2024 09:34:47 +0000 (GMT)
Received: from [9.179.15.207] (unknown [9.179.15.207])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Feb 2024 09:34:46 +0000 (GMT)
Message-ID: <a60f2ec8-52ff-4c00-948c-438ed6bc66a0@linux.ibm.com>
Date: Thu, 22 Feb 2024 15:04:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/ppc: Clean up ifdefs in excp_helper.c, part
 2
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
References: <cover.1705614747.git.balaton@eik.bme.hu>
 <7f3984701b06b581f72b39dd8bd804bb128982b1.1705614747.git.balaton@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <7f3984701b06b581f72b39dd8bd804bb128982b1.1705614747.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W8fCHbdbXilvU-Po5nl9G5RYU3rrb3sE
X-Proofpoint-ORIG-GUID: wkAia_eA9UP8ksD59zHebcVxdKwP-IsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 mlxlogscore=895 impostorscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220075
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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



On 1/19/24 03:31, BALATON Zoltan wrote:
> Remove check for !defined(CONFIG_USER_ONLY) as this is already within
> an #ifndef CONFIG_USER_ONLY block.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   target/ppc/excp_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index d8eab4ff6c..2d4a72883f 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -2607,7 +2607,7 @@ void helper_hrfid(CPUPPCState *env)
>   }
>   #endif /* TARGET_PPC64 */
>   
> -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> +#ifdef TARGET_PPC64
>   void helper_rfebb(CPUPPCState *env, target_ulong s)
>   {
>       target_ulong msr = env->msr;
> @@ -2682,7 +2682,7 @@ void raise_ebb_perfm_exception(CPUPPCState *env)
>   
>       do_ebb(env, POWERPC_EXCP_PERFM_EBB);
>   }
> -#endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
> +#endif /* TARGET_PPC64 */
>   
>   /*****************************************************************************/
>   /* Embedded PowerPC specific helpers */


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBCC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FBO-0003UF-6B; Tue, 07 May 2024 03:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s4FBM-0003Ti-9f; Tue, 07 May 2024 03:24:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s4FBK-0000Dx-9u; Tue, 07 May 2024 03:24:12 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4476bVks013754; Tue, 7 May 2024 07:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ck2eB8lvT3L2jvOTpk2hGG9iy1LNsWxR58Ji5tGgd0s=;
 b=Q3t5nsDQudzTRWaYRXuAtoey4P6BjfQYxBw31HrCN+ONJhKTVQmOPHAOQ5rfgNVxbD6B
 hz0gDYk7ASn4X0MjzkLzbf5mn9neN1FcMCvJPD/OMy8Fzu/rQIJS9pusJenl8oJpaWNZ
 4abyPbr9KfmzjwIxvDHzRriXkizZls3pso5EzZe3FVCFvTx193gkngId0kBOpMUyMdse
 Hvkr7dHp3ld0U/hM6Zt5dv8InJFdmjVXVsrB6XU54esXJuPeYL9rWtENQlN/KaytKUjo
 K8tX3L82mr53ccatDbQyV2vkn6BJTncy/1FKm+ykvVuHIgMWK1d9+CxKHdk0gBlITvGB bw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyf6fr3qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 07:24:07 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4477O7Mr026519;
 Tue, 7 May 2024 07:24:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyf6fr3qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 07:24:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44742a2d013977; Tue, 7 May 2024 07:24:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222va9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 07:24:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4477O2jh44761566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2024 07:24:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFBE520049;
 Tue,  7 May 2024 07:24:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A137A20040;
 Tue,  7 May 2024 07:24:01 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 May 2024 07:24:01 +0000 (GMT)
Message-ID: <f9c27a7a-4898-457c-ab3d-6da7c87126d4@linux.vnet.ibm.com>
Date: Tue, 7 May 2024 12:54:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Fix embedded memory barriers
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20240501130435.941189-1-npiggin@gmail.com>
 <20240501130435.941189-3-npiggin@gmail.com>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <20240501130435.941189-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: slgf31n8-SFt4X6leOjd7Rdr0F_ZYNcK
X-Proofpoint-ORIG-GUID: 1tbMl_IyfDjuKB31QCxagcOcwN72A9vG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070050
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 5/1/24 18:34, Nicholas Piggin wrote:
> Memory barriers are supposed to do something on BookE systems, these
> were probably just missed during MTTCG enablement, maybe no targets
> support SMP. Either way, add proper BookE implementations.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/translate/misc-impl.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
> index f58bf8b848..9226467f81 100644
> --- a/target/ppc/translate/misc-impl.c.inc
> +++ b/target/ppc/translate/misc-impl.c.inc
> @@ -34,8 +34,7 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
>        */
>       if (!(ctx->insns_flags & PPC_MEM_SYNC)) {
>           if (ctx->insns_flags & PPC_BOOKE) {
> -            /* msync replaces sync on 440, interpreted as nop */
> -            /* XXX: this also catches e200 */
> +            tcg_gen_mb(bar | TCG_BAR_SC);
>               return true;
>           }
>   
> @@ -80,6 +79,7 @@ static bool trans_EIEIO(DisasContext *ctx, arg_EIEIO *a)
>       if (!(ctx->insns_flags & PPC_MEM_EIEIO)) {
>           if ((ctx->insns_flags & PPC_BOOKE) ||
>               (ctx->insns_flags2 & PPC2_BOOKE206)) {
> +            tcg_gen_mb(bar | TCG_BAR_SC);
>               return true;
>           }
>           return false;



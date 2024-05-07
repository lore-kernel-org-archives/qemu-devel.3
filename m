Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86955C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Eww-00018r-1j; Tue, 07 May 2024 03:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s4Ewt-000186-7N; Tue, 07 May 2024 03:09:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1s4Ewq-0008Mv-PJ; Tue, 07 May 2024 03:09:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4476CAnF013123; Tue, 7 May 2024 07:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Lyxw7bbZMWp/YqtteOw7RNEDOMzF2yqOTuzjWmD/t30=;
 b=aDKOXHHOocQnCOh+SH+uOco1LIsDEfuSYz5H5RswdE2yMCWgUXop2/6IyapRfYpNFo5q
 CF9e/7PtMYdWgjVWG7gspCHiONr6oJFOBNe2UIKFRxvuxEBwXrmWUKrxYFf5ouuWFlGE
 /PbaFfiklnxOdHvP2lDNC3B0kfkUEnz4+JELtbyxQFP0eeZYp9hkQvsIZ+BwaeKFC/a3
 4jytXhO6HAc9uxk96QguuvqTQCn8nenyTwknD+lnKOqI2gI4KPEZVT08R2sBqUJ213vz
 9DAF7z1nxzeddeQcZWpOJEGRgnFeBvOjOlx3gVQdbfJq+UvO+qY40tnxgx55cYwiv5M2 vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyetp04kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 07:09:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447744BS031718;
 Tue, 7 May 2024 07:09:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xyetp04kp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 07:09:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44742dIn013942; Tue, 7 May 2024 07:09:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222v8ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 May 2024 07:09:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 447794Ak54854124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2024 07:09:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAFC320049;
 Tue,  7 May 2024 07:09:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E125120040;
 Tue,  7 May 2024 07:09:03 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 May 2024 07:09:03 +0000 (GMT)
Message-ID: <2bd50388-2bb0-42c5-a2ce-8c243c2051dd@linux.vnet.ibm.com>
Date: Tue, 7 May 2024 12:39:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Add ISA v3.1 variants of sync instruction
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20240501130435.941189-1-npiggin@gmail.com>
 <20240501130435.941189-4-npiggin@gmail.com>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <20240501130435.941189-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4xCsf_1LuHEPIoC6UMIXiaAC5esIjp6t
X-Proofpoint-ORIG-GUID: Smhv1pXMGR8wUzI0TIJKy3iH-9hEdfUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=967 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070048
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
> POWER10 adds a new field to sync for store-store syncs, and some
> new variants of the existing syncs that include persistent memory.
>
> Implement the store-store syncs and plwsync/phwsync.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode             |  6 ++--
>   target/ppc/translate/misc-impl.c.inc | 41 ++++++++++++++++++++--------
>   2 files changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 6b89804b15..a180380750 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1001,7 +1001,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
>   
>   # Memory Barrier Instructions
>   
> -&X_sync         l
> -@X_sync         ...... ... l:2 ..... ..... .......... .           &X_sync
> -SYNC            011111 --- ..  ----- ----- 1001010110 -           @X_sync
> +&X_sync         l sc
> +@X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
> +SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
>   EIEIO           011111 ----- ----- ----- 1101010110 -
> diff --git a/target/ppc/translate/misc-impl.c.inc b/target/ppc/translate/misc-impl.c.inc
> index 9226467f81..3467b49d0d 100644
> --- a/target/ppc/translate/misc-impl.c.inc
> +++ b/target/ppc/translate/misc-impl.c.inc
> @@ -25,6 +25,7 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
>   {
>       TCGBar bar = TCG_MO_ALL;
>       uint32_t l = a->l;
> +    uint32_t sc = a->sc;
>   
>       /*
>        * BookE uses the msync mnemonic. This means hwsync, except in the
> @@ -46,20 +47,36 @@ static bool trans_SYNC(DisasContext *ctx, arg_X_sync *a)
>           gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>       }
>   
> -    if ((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) {
> -        bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
> -    }
> -
>       /*
> -     * We may need to check for a pending TLB flush.
> -     *
> -     * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
> -     *
> -     * Additionally, this can only happen in kernel mode however so
> -     * check MSR_PR as well.
> +     * In ISA v3.1, the L field grew one bit. Mask that out to ignore it in
> +     * older processors. It also added the SC field, zero this to ignore
> +     * it too.
>        */
> -    if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
> -        gen_check_tlb_flush(ctx, true);
> +    if (!(ctx->insns_flags2 & PPC2_ISA310)) {
> +        l &= 0x3;
> +        sc = 0;
> +    }
> +
> +    if (sc) {
> +        /* Store syncs [stsync, stcisync, stncisync]. These ignore L. */
> +        bar = TCG_MO_ST_ST;
> +    } else {
> +        if (((l == 1) && (ctx->insns_flags2 & PPC2_MEM_LWSYNC)) || (l == 5)) {
> +            /* lwsync, or plwsync on POWER10 and later */
> +            bar = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST;
> +        }
> +
> +        /*
> +         * We may need to check for a pending TLB flush.
> +         *
> +         * We do this on ptesync (l == 2) on ppc64 and any sync on ppc32.
> +         *
> +         * Additionally, this can only happen in kernel mode however so
> +         * check MSR_PR as well.
> +         */
> +        if (((l == 2) || !(ctx->insns_flags & PPC_64B)) && !ctx->pr) {
> +            gen_check_tlb_flush(ctx, true);
> +        }
>       }
>   
>       tcg_gen_mb(bar | TCG_BAR_SC);


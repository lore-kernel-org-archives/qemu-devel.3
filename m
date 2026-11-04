Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A420606E81D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOjQ6-0002su-Gi; Wed, 04 Nov 2026 17:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xOjQ1-0002s6-9d; Wed, 04 Nov 2026 17:25:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xOjPz-0001Ot-3u; Wed, 04 Nov 2026 17:25:20 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A0F4660C347;
 Wed, 04 Nov 2026 23:25:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lR5quDjnFhsn; Wed,  4 Nov 2026 23:25:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3CBE160C0F3; Wed, 04 Nov 2026 23:25:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3AC06139920;
 Wed, 04 Nov 2026 23:25:12 +0100 (CET)
Date: Wed, 4 Nov 2026 23:25:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bin Meng <bin.meng@processmission.com>
cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 05/17] target/ppc: Complete e500mc and e5500 L1 cache
 configuration
In-Reply-To: <20261104173329.706635-6-bin.meng@processmission.com>
Message-ID: <c8a25962-b452-5f67-9a80-fcabad783e2d@eik.bme.hu>
References: <20261104173329.706635-1-bin.meng@processmission.com>
 <20261104173329.706635-6-bin.meng@processmission.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026, Bin Meng wrote:
> The e500mc and e5500 manuals specify pseudo-LRU replacement, cache
> locking and parity detection for both L1 caches. The reset values
> describe the block size, associativity and capacity, but leave
> CREPL/ICREPL, CLA/ICLA and CPA/ICPA clear.
>
> Set those fields to their documented values so both L1CFG0 and
> L1CFG1 reset to 0x00B83820, including the shared eight-way, 32 KiB
> cache geometry.
>
> Reference:
> - E500MCRM (Rev.3), section 2.14.4 and 2.14.5
>  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
> - E5500RM (Rev.4), section 2.14.4 and 2.14.5
>  https://www.nxp.com/webapp/Download?colCode=E5500RM

I'm not sure we want URLs that can go away in commit messages (or 
comments). I't probably enough to list the manual and section or move this 
whole reference section below --- to help review but not record it in the 
commit. But if others think it's good to preserve this in commit message I 
don't mind.

> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
> (no changes since v1)
>
> target/ppc/cpu_init.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 3be3e44aad..e2182720a3 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -2886,8 +2886,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
>     case fsl_e5500:
>         env->dcache_line_size = 64;
>         env->icache_line_size = 64;
> -        l1cfg0 |= 0x00800000; /* 64 byte cache block size */
> -        l1cfg1 |= 0x00800000; /* 64 byte cache block size */
> +        /* 64 byte blocks, pseudo-LRU replacement, cache locking and parity */
> +        l1cfg0 |= 0x00B80000;
> +        l1cfg1 |= 0x00B80000;

These were changed two patches ago. Do we need that separate patch or if 
you don't want to squash the two patches maybe move them next to each 
other without unrelated patch inbetween.

Regards,
BALATON Zoltan

>         break;
>     case fsl_e6500:
>         env->dcache_line_size = 64;
>


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8D606AB15
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOjX0-0004RV-QJ; Wed, 04 Nov 2026 17:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xOjWz-0004RJ-T7; Wed, 04 Nov 2026 17:32:33 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xOjWx-0001nM-Pq; Wed, 04 Nov 2026 17:32:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C61F60C349;
 Wed, 04 Nov 2026 23:32:29 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id cDLsTIk-ULjS; Wed,  4 Nov 2026 23:32:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2F8A360C347; Wed, 04 Nov 2026 23:32:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2DE6413991F;
 Wed, 04 Nov 2026 23:32:27 +0100 (CET)
Date: Wed, 4 Nov 2026 23:32:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bin Meng <bin.meng@processmission.com>
cc: QEMU <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 11/17] target/ppc: Register IVOR42 on e6500
In-Reply-To: <20261104173329.706635-12-bin.meng@processmission.com>
Message-ID: <96682bf3-9c32-6d15-05b0-31315501b05a@eik.bme.hu>
References: <20261104173329.706635-1-bin.meng@processmission.com>
 <20261104173329.706635-12-bin.meng@processmission.com>
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
> The e6500 core manual defines IVOR42 as the LRAT error interrupt
> offset register. U-Boot programs it during interrupt setup, but
> currently the QEMU e6500 IVOR mask currently excludes bit 42.

"currently" is doubled, one of them is enough.

Regards,
BALATON Zoltan

> Include IVOR42 in the mask so the existing BookE SPR registration
> exposes its offset. This permits the register accesses without
> implementing LRAT translation or LRAT exception delivery.
>
> Reference: E6500RM (Rev.0), section 2.9.5 and 4.9.22
> https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
>
> (no changes since v1)
>
> target/ppc/cpu_init.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index cc702d7c7d..224e1ff77b 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -2824,7 +2824,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
>         ivor_mask = 0x000003FE0000FFFFULL;
>         break;
>     case fsl_e6500:
> -        ivor_mask = 0x000003FF0000FFFFULL;
> +        ivor_mask = 0x000007FF0000FFFFULL;
>         break;
>     }
>     register_BookE_sprs(env, ivor_mask);
>


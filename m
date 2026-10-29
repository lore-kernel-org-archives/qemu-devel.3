Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A998606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMNKp-00065w-Aw; Thu, 29 Oct 2026 06:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xMNKl-00065e-FG; Thu, 29 Oct 2026 06:26:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xMNKj-0003ne-Kh; Thu, 29 Oct 2026 06:26:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2AFB860C0F3;
 Thu, 29 Oct 2026 11:26:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MazwyICZzQbk; Thu, 29 Oct 2026 11:26:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C261660C0DB; Thu, 29 Oct 2026 11:26:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C0D0713996F;
 Thu, 29 Oct 2026 11:26:00 +0100 (CET)
Date: Thu, 29 Oct 2026 11:26:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Showta Ishizaki <zakinko@snowrabbit.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/ppc: Register the 745's HID0 and HID1 once
In-Reply-To: <179325247250.65414.17031704056960380956.745-hid@snowrabbit.org>
Message-ID: <9f93cbf6-875d-a8d4-a8a4-e74bab5104f9@eik.bme.hu>
References: <179325247250.65414.17031704056960380956.745-hid@snowrabbit.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Thu, 29 Oct 2026, Showta Ishizaki wrote:
> init_proc_745(), which the 755 shares, calls register_7xx_sprs() and
> then register_745_sprs().  Since HID0 and HID1 moved into
> register_7xx_sprs(), both functions register them the same way, and
> _spr_register() asserts that no SPR is registered twice, so the 745 and
> the 755 cannot be created at all:
>
>  $ qemu-system-ppc -M none -cpu 745
>  Assertion failed: (spr->name == NULL), function _spr_register,
>  file helper_regs.c, line 419.
>
> Leave the two to register_7xx_sprs().
>
> Fixes: 0301b39c78c8 ("target/ppc: cpu_init: Deduplicate 7xx SPR registration")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
> ---
> target/ppc/cpu_init.c | 15 ++++-----------
> 1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7f3036d903e..9fb05ff265d 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -86,17 +86,10 @@ static void register_745_sprs(CPUPPCState *env)
>                  &spr_read_generic, &spr_write_generic,
>                  0x00000000);
>
> -    /* Hardware implementation registers */
> -    spr_register(env, SPR_HID0, "HID0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> -    spr_register(env, SPR_HID1, "HID1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -
> +    /*
> +     * Hardware implementation registers.  HID0 and HID1 are registered by
> +     * register_7xx_sprs(), which init_proc_745() calls first.
> +     */

We don't have comments elsewhere so I'm not sure it's needed here.

Regards,
BALATON Zoltan

>     spr_register(env, SPR_HID2, "HID2",
>                  SPR_NOACCESS, SPR_NOACCESS,
>                  &spr_read_generic, &spr_write_generic,
>
> base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
>


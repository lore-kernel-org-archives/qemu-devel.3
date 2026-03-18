Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B842A107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2yB5-00011Z-Go; Wed, 18 Mar 2026 17:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2yB3-00011M-Ou
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 17:11:41 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2yB1-0008P1-G6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 17:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=G06vPmWlnPfrQb0I43Tb6uUDW5ywFLDiUjEyl/cL62o=; b=t0HzVCnHWAzeKjL
 8tG5aWiAP4K5o4llu+Dkny4DUVVfFOvIH5nbKZqzNXUao3ohXMHW6CnDkuisZpOEqqbRBvQvwfU9c
 zzZwYof3j5wE7H2+vYJUCLuLRMjWMJux7sKpx6xkv3HiVE08ddjCCO6F04FPiKUjl8LatD1HmYrsN
 r0=;
Date: Wed, 18 Mar 2026 22:15:21 +0100
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 5/6] hw/hppa: Fix crash of 64-bit HP-UX 11 while flushing
 caches
Message-ID: <absVMqAQvZEuZ3My@hive.localdomain>
References: <20260317195149.8386-1-deller@kernel.org>
 <20260317195149.8386-6-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317195149.8386-6-deller@kernel.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/03/26, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> HP-UX 11 64-bit reads at bootup a word from address CPU_HPA + 0x500
> while flushing the the cache of a T600.
> Add a memory handler to avoid crashing while reading this word.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/machine.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index e72dda2a68..7e8ebbca3b 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c


Changeset looks good apart from breaking coding convention


> @@ -313,6 +313,22 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
>          memory_region_add_subregion(addr_space,
>                                      translate(NULL, CPU_HPA + i * 0x1000),
>                                      cpu_region);
> +
> +        if (!hppa_is_pa20(&cpu[0]->env))
> +            continue;

braces around if statement


> +
> +        /* HP-UX 11 64-bit reads a word from address CPU_HPA + 0x500
> +         * while flushing the the cache of a T600, which was the first
> +         * server with a 64-bit PA-RISC 2.0 CPU.
> +         * We return 0, since the value isn't used anyway. */

/*
 * HP-UX 11 64-bit reads a word from address CPU_HPA + 0x500
 * while flushing the the cache of a T600, which was the first
 * server with a 64-bit PA-RISC 2.0 CPU.
 * We return 0, since the value isn't used anyway.
 */
 

> +        g_autofree char *cflush_name;

declare at top of for() scope, or top of function


> +        cflush_name = g_strdup_printf("cpu%u-T600-cacheflush", i);
> +        MemoryRegion *cflush = g_new(MemoryRegion, 1);

likewise


> +        memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
> +                              NULL, cflush_name, 4);
> +        memory_region_add_subregion(addr_space,
> +                              translate(NULL, CPU_HPA + i * 0x1000 + 0x500),
> +                              cflush);
>      }
>  
>      /* RTC and DebugOutputPort on CPU #0 */
> -- 
> 2.53.0
> 

Other than that

Reviewed-by: Anton Johansson <anjo@rev.ng>


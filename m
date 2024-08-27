Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8FC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Bg-0004kT-4e; Tue, 27 Aug 2024 13:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GG8b=P2=kaod.org=clg@ozlabs.org>)
 id 1sj0Be-0004jy-Tm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:40:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GG8b=P2=kaod.org=clg@ozlabs.org>)
 id 1sj0Bb-0008V7-Rx
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:40:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WtZZp51SVz4x8C;
 Wed, 28 Aug 2024 03:40:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtZZn1nvtz4wcl;
 Wed, 28 Aug 2024 03:40:48 +1000 (AEST)
Message-ID: <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
Date: Tue, 27 Aug 2024 19:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20240715084639.983127-1-chigot@adacore.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240715084639.983127-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GG8b=P2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Clément,

On 7/15/24 10:46, Clément Chigot wrote:
> The BookE decrementer stops at 0, meaning that it won't decremented
> towards "negative" values.
> However, the current logic is inverted: decr is updated solely when
> the resulting value would be negative.

How did you hit the issue ? which machine ? I didn't see any error
when booting Linux 6.6.3 on mpc8544ds, e500mc, e5500 and e6500.

> Signed-off-by: Clément Chigot <chigot@adacore.com>
> Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")

LGTM,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

We have some automated tests with the ppce500 machine which it would be
interesting  to extend to have a better coverage of booke.

Thanks,

C.



> ---
>   hw/ppc/ppc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index e6fa5580c0..9fc85c7de0 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCState *env, int64_t now,
>       int64_t decr;
>   
>       n = ns_to_tb(tb_env->decr_freq, now);
> -    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
> +
> +    /* BookE timers stop when reaching 0.  */
> +    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
>           decr = 0;
>       } else {
>           decr = next - n;




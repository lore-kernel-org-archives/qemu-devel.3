Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1ABFD8FE0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvevJ-0007PU-Eg; Thu, 26 Feb 2026 12:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vvevG-0007Oz-UI
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:13:10 -0500
Received: from out-172.mta1.migadu.com ([95.215.58.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vvevE-00019Z-Pr
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:13:10 -0500
Message-ID: <c805cd6f-e69c-4cf1-8773-0a45bfb677f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1772125984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQ2E11vmARMbm0XjMwkBECua6RVPsNj4Cuf6gp22r0k=;
 b=Fx3PSGKdJmkvkBUd/NP6DrPaV6vpjABjI7C+HGXm8bboo/xnbWKxvMFoWtR758JEmCqrEG
 kftmOwhYoXt8J843lJv7mRH4cFAlvWuA2p9RCIVgiTjyiHnpAGuGHVnFop2mcjTRht+Lbd
 t917L3Dhx8wZ4LPVLFSABt/HQRnOuNQ=
Date: Fri, 27 Feb 2026 01:12:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 08/84] target/arm: Skip AF and DB updates for
 AccessType_AT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-9-richard.henderson@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20250830054128.448363-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.172; envelope-from=zenghui.yu@linux.dev;
 helo=out-172.mta1.migadu.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/30/25 1:40 PM, Richard Henderson wrote:
> We are required to skip DB update for AT instructions, and
> we are allowed to skip AF updates.  Choose to skip both.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8925c9a610..089eeff845 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -58,6 +58,12 @@ typedef struct S1Translate {
>       * and will not change the state of the softmmu TLBs.
>       */
>      bool in_debug;
> +    /*
> +     * in_at: is this AccessType_AT?
> +     * This is also set for debug, because at heart that is also
> +     * an address translation, and simplifies a test.
> +     */
> +    bool in_at;
>      /*
>       * If this is stage 2 of a stage 1+2 page table walk, then this must
>       * be true if stage 1 is an EL0 access; otherwise this is ignored.
> @@ -1929,7 +1935,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>      descaddr &= ~(hwaddr)(page_size - 1);
>      descaddr |= (address & (page_size - 1));
>  
> -    if (likely(!ptw->in_debug)) {
> +    /*
> +     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
> +     * and it is IMPLEMENTATION DEFINED whether AF is updated
> +     * (AArch64.SetAccessFlag; qemu chooses to not update).
> +     */
> +    if (likely(!ptw->in_at)) {
>          /*
>           * Access flag.
>           * If HA is enabled, prepare to update the descriptor below.

|           * Otherwise, pass the access fault on to software.
|           */
|          if (!(descriptor & (1 << 10))) {
|              if (param.ha) {
|                  new_descriptor |= 1 << 10; /* AF */
|              } else {
|                  fi->type = ARMFault_AccessFlag;
|                  goto do_fault;

This also skips the access flag fault which could be generated by an AT
instruction. Is this an expected change?

Thanks,
Zenghui


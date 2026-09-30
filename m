Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E159DCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq7R-0003gr-Eb; Wed, 30 Sep 2026 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBq7P-0003g6-OR; Wed, 30 Sep 2026 04:56:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xBq7M-00034k-FY; Wed, 30 Sep 2026 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790758605; bh=QMtZLDE4GhUYYT1r5pWy36FpqzdOf8yjefTPHveRf+U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Eu1cuqnH8cODJaIrY9Ng8+ITSP93w2KL8ujULMJWUJ0Lk8L+OL59eAlifNLloFh2k
 ypwPxWTklZKpp+wevrOcA07EJC+etyj14420rvNbN+f6HiASA582HwoK3P2ekrhXEF
 TXMDD2/kWkm3nk8PF7K/09BBzilJfHy3MvKC74PEkFLM07kcgZ7X6R1U7eo28Dmrrv
 KGiIOLcgkTbfa5hIYW5XohBrmnleWWaheMGFtdJhEAs2NH/iJiIJH6jlouiglr6UIV
 22x61djxZoHzi5Zf0GyjPZC5oJyAB5FgtyALb+UYY2fyVq3Zr1lmfaTHSsPNb66fEe
 0NgpsxRtCuwkQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4920F1D9C49;
 Wed, 30 Sep 2026 11:56:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2DB4E4360C3;
 Wed, 30 Sep 2026 11:56:45 +0300 (MSK)
Message-ID: <5eb74929-f605-4acf-875b-e561385182f0@tls.msk.ru>
Date: Wed, 30 Sep 2026 11:56:45 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] target/arm: Fix WFxT timeouts when the offset puts
 the count ahead
To: Fuad Tabba <fuad.tabba@linux.dev>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20260921074451.3158645-1-fuad.tabba@linux.dev>
 <20260921074451.3158645-3-fuad.tabba@linux.dev>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260921074451.3158645-3-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[This has been applied to the master branch as 998b6db69e3ec58fd52ddc7a06ece6cf286f3c77]

On 9/21/26 10:44, Fuad Tabba wrote:
> The WFIT and WFET helpers arm the wakeup timer at count == timeout +
> offset, treating an overflow of that sum as "beyond the counter's
> wrap" and arming at INT64_MAX. As in gt_recalc_timer(), that reading
> is valid only when offset <= count: with a CNTVOFF_EL2 that puts the
> virtual count ahead of the physical count, the sum overflows for
> every timeout still in the future and the wrapped value was the
> correct wakeup. The CPU then waits until an interrupt or event
> instead of waking at its timeout. A Linux guest uses WFIT and WFET in
> __delay() when FEAT_WFxT is present, which -cpu max advertises.
> 
> Arm cntval + (timeout - cntvct) instead, so only a physical count past
> 2^64 is "never", and add a tcg system test that issues WFIT and WFET
> with such an offset, with a timer interrupt 1s out so a broken WFxT
> still returns: before this change both wake at the interrupt, after
> it at their timeout.
> 
> Fixes: a96edb687e76 ("target/arm: Implement FEAT WFxT and enable for '-cpu max'")
> Fixes: da9b86c35fa8 ("target/arm: implement WFET")

Hi.

For stable-10.0.x LTS series, which does not support WFET (commit
da9b86c35fa8), I'm picking up just the first half of this patch,
and half of the test.

An alternative is to pick da9b86c35fa8 ("target/arm: implement WFET")
for 10.0.x, which does not actually look bad.  It will probably require
v11.0.0-332-g4575da5ecb7 "target/arm: report register in WFIT syndromes"
too.

What do you think?

Thanks,

/mjt

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>   target/arm/tcg/op_helper.c           |   6 +-
>   tests/tcg/aarch64/system/meson.build |   7 ++
>   tests/tcg/aarch64/system/wfxt.c      | 118 +++++++++++++++++++++++++++
>   3 files changed, 129 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/aarch64/system/wfxt.c
> 
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index c2b09176cb..562f11f390 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -448,7 +448,8 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>           raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFIT, false), target_el);
>       }
>   
> -    if (uadd64_overflow(timeout, offset, &nexttick)) {
> +    /* Physical count at the timeout. Only an overflow of it is "never". */
> +    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
>           nexttick = UINT64_MAX;
>       }
>       if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
> @@ -705,7 +706,8 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
>        * The WFET should time out when CNTVCT_EL0 >= the specified value.
>        */
>       cpu = env_archcpu(env);
> -    if (uadd64_overflow(timeout, offset, &nexttick)) {
> +    /* Physical count at the timeout. Only an overflow of it is "never". */
> +    if (uadd64_overflow(cntval, timeout - cntvct, &nexttick)) {
>           nexttick = UINT64_MAX;
>       }
>       if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {



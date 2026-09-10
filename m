Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62061C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4j2x-00088n-Am; Thu, 10 Sep 2026 13:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4j2v-00088U-Pe; Thu, 10 Sep 2026 13:58:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x4j2t-00020p-1t; Thu, 10 Sep 2026 13:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789063092; bh=8ISu6uli5v8O+wr8bwEltVIqySHYrcpo+LjeEnqLdJc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oaZldUwGZGXrQBHXlfIaXrDcJdyvTwPwY/rJrU44DNHw1ZDA3wYKwFWPGdF+s+Sev
 s605nP4UDQJ/BOuwG+HouUQKJ/ETbOAV4DBhuLpLNeX3/Dj+a9Ny7NuzMpz4Hh/Goa
 7kveC8AhMvltOirUVGdQiMMjOI18+HYk7+I/fHj7O26PDB4j2+BEjmdQJ8xyvjwNIx
 bYQkSeS6Pep0fX/xdFJIqAhEVXdqPG5Jjo/D5W5XVsQgKr3LcRBn9mm9ipk+2YqmX5
 3jmSrWfzX1cz8N6LVrQB5lOHKYD5jeSrSaZ0c+Or/k5a+Xv+pKlhat58GS1DN1+iDt
 cUIHVzMl8/XeA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 42EA11D3890;
 Thu, 10 Sep 2026 20:58:12 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 29CBA4258AF;
 Thu, 10 Sep 2026 20:58:43 +0300 (MSK)
Message-ID: <560e3a61-373a-4947-8aae-9d9a160ce27a@tls.msk.ru>
Date: Thu, 10 Sep 2026 20:58:43 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] target/i386: Fix FXCH to unconditionally clear C1
To: Simon Scherer <scherer.simon89@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260902085424.148650-1-scherer.simon89@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260902085424.148650-1-scherer.simon89@gmail.com>
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

On 9/2/26 11:54, Simon Scherer wrote:
> Per the SDM, FXCH unconditionally clears the FPU status word's C1
> flag. QEMU's helper_fxchg_ST0_STN swaps ST(0) and ST(i) but never
> touches fpus, so C1 is left untouched from whatever prior instruction
> set it.
> 
> This patch clears C1 after the exchange matching the SDM.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4399
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
> See also my earlier patch (20260828082235.128360-1-scherer.simon89@gmail.com)
> to unconditionally clear C1 for the x87 compare instructions.

Hi!

Is this a qemu-stable material?

Thanks,

/mjt

>   target/i386/tcg/fpu_helper.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index b812125efa..32af8b79f4 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -519,6 +519,9 @@ void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
>       tmp = ST(st_index);
>       ST(st_index) = ST0;
>       ST0 = tmp;
> +
> +    /* C1 is unconditionally cleared to 0 */
> +    env->fpus &= ~0x0200;
>   }
>   
>   /* FPU operations */



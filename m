Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13941606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=cX6IrIN4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWnb-00042m-32; Mon, 09 Nov 2026 16:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xQWn7-0003xj-Tl; Mon, 09 Nov 2026 16:20:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xQWn4-0004Re-GC; Mon, 09 Nov 2026 16:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794259215; bh=Z0sKJOcY2nanQqVZA945Gr8EyR/g+RngOjb2q7/jl/s=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=cX6IrIN4tjgsjd5C6r6TM+0MvJ1JeNQoJR6TfQL3CyIk85mZA9S9irvmeNQD3vXVf
 8s7pgKeP/YNljFGpuwJn26clPokZL9SZzFxI8ly9/Gv8uERRlkqLYcE4fTGlm9Rfs6
 e+IZH9s+fV8LI7qzkZJDfZU1m40KfR3rDy8voRLuaOfiX90GWsExMUw1gIfUg/5npl
 I2a9+eUedt7XETmoDDTJ57CMisoQmmlsULnAxH4N4JLULcf4nTCPacLqRGN5Ex9XrQ
 lkDaHBJhP2jRsQOvHqSqU92lHgqd0m+iZJbMRad/u/EWumns00Qnapwzzrv5qONgpH
 ZgZDNyunwFuWw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2BE3D1E4EA7;
 Tue, 10 Nov 2026 00:20:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EBB26457A39;
 Tue, 10 Nov 2026 00:20:14 +0300 (MSK)
Message-ID: <155f5d5c-969e-4850-959c-289665004859@tls.msk.ru>
Date: Tue, 10 Nov 2026 00:20:14 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
To: Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20261010174742.3552498-1-aurelien@aurel32.net>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261010174742.3552498-1-aurelien@aurel32.net>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/10/26 20:46, Aurelien Jarno wrote:
> For logical vector operations (in the case of the RISC-V backend that
> corresponds to and_vec, or_vec and xor_vec), VECE is unused. However,
> tcg_target_const_match() always treat it as an element size to extract
> the corresponding constant element from the whole constant.
> 
> This causes the following aarch64 instruction
>    bic v4.8h, #0xf0
> to be translated into the following op:
>    ...
>    and_vec v128,e8,tmp5,tmp4,v128$0xff0fff0fff0fff0f
>    ...
> which is then translated to the following RISC-V instruction:
>    vand.vi v1,v1,15
> 
> Fix that by, when VECE is 0 aka MO_8, only extracting the element if the
> it can actually be represented as a duplicated constant.
> 
> Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   tcg/riscv64/tcg-target.c.inc | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Changes v1 -> v2:
> - Use dup_const() instead of open coding the constant duplication.

Ping?

Can we get this one for 11.2?

Thanks,

/mjt

> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 14a397117a..1262b71a62 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -392,8 +392,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
>           return 1;
>       }
>       if (type >= TCG_TYPE_V64) {
> -        /* Val is replicated by VECE; extract the highest element. */
> -        val >>= (-8 << vece) & 63;
> +        /*
> +         * For vector logical operations, VECE is unused and equals to 0, so
> +         * we need to check that the constant can properly be represented after
> +         * replication.
> +         */
> +        if ((vece != MO_8) || (val == dup_const(vece, val))) {
> +            /* Val is replicated by VECE; extract the highest element. */
> +            val >>= (-8 << vece) & 63;
> +        }
>       }
>       /*
>        * Sign extended from 12 bits: [-0x800, 0x7ff].



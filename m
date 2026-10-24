Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B3606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=OWe4KStL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZE1-0001Qm-Ua; Sat, 24 Oct 2026 06:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xKZDs-0001Ie-IZ; Sat, 24 Oct 2026 06:43:36 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1xKZDq-0008PR-56; Sat, 24 Oct 2026 06:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Content-Transfer-Encoding:Cc:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=VT/4UJl9updzsWQfObstPsyD6isRysQR22RlBZ7p9dI=; b=OWe4KStLCFnAVbVDcsAqTkZLKR
 jUl6HeX77CzDLbVHJoBdefw28rQiLrSP0ZokASgMyrmRD+1kFKLz01wdNqeCIEyP5tQTxkQA/uewv
 cg13Z5MhuXleecSrVejtzCeRjfzZmthVymG0CJ3pXUQC7yPwjCGJZ3MWmJfSYmzr2TpjjrOYuGvpS
 LMuWFtKLqZpk1j3q3PD5XqB0V3/Kg+6eYyU4Jq7MSljYFnUluIN8WMYDwVlqUXRaGsmiAnfOry9Pm
 qsL9g49q97mJqOaECqyfN7zCLaCypkplbNr8lit7wVdSpx+WzJ5+22pG4Gvh7hRrMPxP8quC1BQt6
 iwGyy62Q==;
Received: from authenticated user by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <aurelien@aurel32.net>) id 1xKZDe-0000000GfBQ-104W;
 Sat, 24 Oct 2026 12:43:22 +0200
Date: Sat, 24 Oct 2026 12:43:21 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
Message-ID: <atyLyczXNyirpj1o@aurel32.net>
References: <20261010174742.3552498-1-aurelien@aurel32.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010174742.3552498-1-aurelien@aurel32.net>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-10 19:46, Aurelien Jarno wrote:
> For logical vector operations (in the case of the RISC-V backend that
> corresponds to and_vec, or_vec and xor_vec), VECE is unused. However,
> tcg_target_const_match() always treat it as an element size to extract
> the corresponding constant element from the whole constant.
> 
> This causes the following aarch64 instruction
>   bic v4.8h, #0xf0
> to be translated into the following op:
>   ...
>   and_vec v128,e8,tmp5,tmp4,v128$0xff0fff0fff0fff0f
>   ...
> which is then translated to the following RISC-V instruction:
>   vand.vi v1,v1,15
> 
> Fix that by, when VECE is 0 aka MO_8, only extracting the element if the
> it can actually be represented as a duplicated constant.
> 
> Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  tcg/riscv64/tcg-target.c.inc | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Changes v1 -> v2:
> - Use dup_const() instead of open coding the constant duplication.
> 
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 14a397117a..1262b71a62 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -392,8 +392,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
>          return 1;
>      }
>      if (type >= TCG_TYPE_V64) {
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
>      }
>      /*
>       * Sign extended from 12 bits: [-0x800, 0x7ff].

Gentle ping about this patch. Are there more things to fix?

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net


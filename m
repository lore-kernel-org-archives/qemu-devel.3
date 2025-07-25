Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5F7C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 06:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCJW-0007GJ-VP; Fri, 25 Jul 2025 02:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1ufCDx-0000Cs-CM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:48:09 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ebiggers@kernel.org>)
 id 1ufCDv-0005nJ-M7
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:48:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E62643E0F;
 Fri, 25 Jul 2025 06:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517BDC4CEE7;
 Fri, 25 Jul 2025 06:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753426085;
 bh=ShuoGeySIEBOdub3tSr/OlnmMPsbiuchGXXr34fF4sg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cmpj7PH4NaG+xPw2a7DFIzd323FNxqcu9NvNyvzljiz5OCQ2SuwhtjXf0oZjB3KbH
 C1c4LQeM8pAbkA1kPLaNq8tdIuU3DaRGCJlbG13ELkDbFJ4p4ESH0EIKtf06ifiZX7
 /8D40EC6tSpJjr5pKH1GafHqU/kOBsLgp3GdEEPv7iXS1oNNSf2nE87mUQ8tdONma5
 qrHsH5Zz3BK6mg4z4TUf3QZI1jV27bFpaToUUFUec3X437LtJ7KfDOWlnze3TVvMrI
 6Nbs5AnK3hkS3BVJ4ZO8siBZiHHGq9cmJqgiGdWPyrT+IlV75fB4IIb+X07pvxn4aw
 WaPX0m4fdr3Dw==
Date: Thu, 24 Jul 2025 23:47:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] target/i386: fix width of third operand of VINSERTx128
Message-ID: <20250725064715.GB37178@sol>
References: <20250725061736.1096206-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725061736.1096206-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=ebiggers@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 25, 2025 at 08:17:36AM +0200, Paolo Bonzini wrote:
> Table A-5 of the Intel manual incorrectly lists the third operand of
> VINSERTx128 as Wqq, but it is actually a 128-bit value.

That's annoying.  I wonder what the way to report that is.

FWIW, AMD's manual gets it right.

> This is
> visible when W is a memory operand close to the end of the page.
> 
> Fixes the recently-added poly1305_kunit test in linux-next.
> 
> (No testcase yet, but I plan to modify test-avx2 to use memory
> close to the end of the page.  This would work because the test
> vectors correctly have the memory operand as xmm2/m128).
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 853b1c8bf95..51038657f0f 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -878,10 +878,10 @@ static const X86OpEntry opcodes_0F3A[256] = {
>      [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
>      [0x0f] = X86_OP_ENTRY4(PALIGNR,    V,x,  H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
>  
> -    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
> +    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX) p_66),
>      [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX) p_66),
>  
> -    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
> +    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX2) p_66),
>      [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX2) p_66),
>  
>      /* Listed incorrectly as type 4 */

Tested-by: Eric Biggers <ebiggers@kernel.org>

Thanks,

- Eric


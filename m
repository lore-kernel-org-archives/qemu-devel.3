Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97B8CE8D69
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 17:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJy2l-0001R2-Gi; Fri, 14 Nov 2025 12:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJy1W-0006bH-1X
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 12:55:50 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJy1U-0006xw-5V
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 12:55:49 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63f97c4eccaso2265007d50.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 09:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763142947; x=1763747747; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FRMYRidkD/W22S4d0e3BlO/F33MY9yXrkayb4cUZBvo=;
 b=lKJH0i5VRFemuxPKJ0pOr+MRHfnEIt7oHXuSbCvKjaoy/z5e6Z4LdeVcZgquMg54hR
 7I8jHMNTkj+brXV8+0TsLOp6m7GtUYkJQD8TjCanidN2iSCqCsXfkpt0frp+NAl8RlR1
 XaS1FDR3XcNuehRE4z7CYA3XfjT9y6h0q1ND4pb/PWmXinSfjhQZdq8VtH7sJG/t6MVD
 R5NgsyKoxBtewSwVY7iEOoKZLQWGrxRFr46sLCzL5fbpWxyAaPrzjuGw0kTfNd8uQv3J
 ZxVpzpTUF7qZUjn9YLcO/X0vFxThRHJL2j7VHroPWQn1EyxOm3w+p7f/J//nbIrvD662
 ZlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763142947; x=1763747747;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FRMYRidkD/W22S4d0e3BlO/F33MY9yXrkayb4cUZBvo=;
 b=tjagYbmNjLYElMDoFdtyfvbGKzB88oA+q8Y4Q6iLeGRC+VfOa5yfEnzV29OVrqiZTn
 8rXWtf4+vlcoWprgNcZolU7NGejDmcRg4gZJTp3BIB1J+h5gZ9ux3A+3uu+S0qU31x0o
 K5S8A++zUnWEVEX3XbKUflDagIJ4GM8MWYQecATT8egPyziBYwBIRvD/PwWwgS5jbQik
 CHjM4oZHjVpxk5O4Ci7piT9Yp/WXA/YuBIDS7JhCdDZwUlG5rLYSBKGzoa9nu1QwBq8m
 vUM9/uQMpWiZkDDUqHYHQQqtFixUVQG82uMCujXwmIfLJAtzDcJO5xG6I9y7s9oU1VSS
 sa9Q==
X-Gm-Message-State: AOJu0YydC0PjC88yP9bKsw7Mubs9ywogtxnzP5CBICsP5DKuMxVzxoL+
 HNIoe4wDIFIlq2+cADraJvEIg6zBaD9vgSw70/VeLjGdFsKxJ3M5+yFNujEKVEVxxn9lrKHns8N
 nQhqkQKAnOBGFsQvV6iAYwUfF6WPToDcVYW7VsHCKynZmE16e4kG5jJ4=
X-Gm-Gg: ASbGncvX5J9sk5X3Jzk3YtBt7wQbmBTQQJE+6fZVkiKMCTZa/xuqu85UWZLw68ITyS/
 v0Djl/1djJJGwPdArwAr5XMxP3FKmLMNt77H3nQ6w1bx2XIRiD2tnTHpfPruAvnAhnoPqMTfK0j
 cX6fmkjYHBKr0RJdDvU8GJTMpx9QeCY4dqx/oTarhvN8DALs1aSDiO0GXAxgVPWuYk3zYMhjMoC
 08OlqpLUs7+7DwojkBy9iGVbFQstYo2f8V1sUizZR2FdqrKp7PvLA2eg5P8kLvVq1QY+Fei
X-Google-Smtp-Source: AGHT+IGOH97fQeZoUaR6pjIuIgI52jyTT/fWLDSaybXSwbCre/1sK+TN1EtyXcqlWsLrqJNe0Or57Zqk9pArFiFRlEE=
X-Received: by 2002:a05:690e:1596:20b0:63f:c6b3:ccd0 with SMTP id
 956f58d0204a3-641e757adacmr3084599d50.29.1763142946978; Fri, 14 Nov 2025
 09:55:46 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 17:55:35 +0000
X-Gm-Features: AWmQ_bleMIQQ2KDCp2vdNPqdWzuGPDpGoXeUgPw1Enho4da8tDrQZjbPYQ7tloE
Message-ID: <CAFEAcA-goNF38nxoYaG8_rn0c9mtDeu0h_PmcQL437qszbWGHw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Mark VPERMILPS as not valid with prefix 0
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Obviously the subject prefix here should be "target/i386" -- fingers
on autopilot ;-)

-- PMM

On Fri, 14 Nov 2025 at 17:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> There are a small set of binary SSE insns which have no MMX
> equivalent, which we create the gen functions for with the
> BINARY_INT_SSE() macro.  This forwards to gen_binary_int_sse() with a
> NULL pointer for 'mmx'.
>
> For almost all of these insns we correctly mark them in the decode
> table as not permitting a zero prefix byte; however we got this wrong
> for VPERMILPS, with the result that a bogus instruction would get
> through the decode checks and end up in gen_binary_int_sse() trying
> to call a NULL pointer.
>
> Correct the decode table entry for VPERMILPD so that we get the
> expected #UD exception.
>
> In the x86 SDM, table A-4 "Three-byte Opcode Map: 08H-FFH
> (First Two Bytes are 0F 38H)" confirms that there is no pfx 0
> version of VPERMILPS.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3199
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/i386/tcg/decode-new.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index f4192f10068..805cfd08e83 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -643,7 +643,7 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
>      [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
>      [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
>      /* Listed incorrectly as type 4 */
> -    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_00_66),
> +    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
>      [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
>      [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
>      [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
> --
> 2.43.0
>


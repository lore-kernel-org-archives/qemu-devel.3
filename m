Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27068F8E486
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVKZ-0007Ql-Kx; Thu, 16 Apr 2026 18:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVKX-0007QL-ES
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:37:01 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVKV-0002pM-Nz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 18:37:01 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so92019a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776379018; x=1776983818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EJiiVFQAGTwr/xgsk5epml8ba8nhOgvN1MNWGGE1Igs=;
 b=vGPGq2Xc1PtwQ9mywQ/eDtNeOytZep8PYuhywLjhdbLqnAVVm25KCGibIWt1rDtQXi
 6fPLuKVD2zhq0SXMupOgsgnFAiyKD61WIyDB1kE5K+u2wZEnqBCIx6Oxz+dKR8fo9R6j
 RMSIGQIChZLsahJFo2cTt09gqEfPFnrEXgL/ZLY8hZ6MOXFzF+/9nwNIEiN6q7Mno/JJ
 0ei9Z2pyUC+w4Y2gBRQB764o/DcMZgNdcDmCV4DEKFAuVDvJR9RV1LgpFwFLZSItztQ5
 ynHdEu1foG0kXoedTwpFnt8DaWExfQuDyth+HvRwkcczHnWHTvT05oxPF/8pKXvswGyf
 ZVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776379018; x=1776983818;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJiiVFQAGTwr/xgsk5epml8ba8nhOgvN1MNWGGE1Igs=;
 b=d5288MHNFMUWmSB1a5sczOkuLZR1wafuEcc0j+qx3xEK698LGxOUyr7vd5xOTyZ+AV
 23y/6KMDHNExN+m0ubB05ROyVrM/1CRJN/G+rbNyj21OC0KwcLayrEBfDyN8O2JZX5jR
 8g1dpI+tdkSVnZPb1WhYEYUC1p5DWso8ODhs369Inj2n8EFiUy1YKQU4SS2GqsndVoC3
 ePzdr1FiFu8MkYM8Zla0IjHVM7fbTEExwAIYtOGl7Oe5j4baSNjV7N0S6EI2dMCIqhS1
 LFM1n/JJndWYAlyuj0vCrhfa83YM5iqNbIRM5wdzhN6a8Wo+/Myg9O5d8RsLcwKWHq2E
 0fLg==
X-Gm-Message-State: AOJu0YxTkcG2fmrTXeBd4r60njdnY1HeXE5JWwrfPfRaP9282y1lfpMH
 hmtj5K5XJrzh8BFF/TEnwBb/WpPhK+NbckPpG7kjMAffJa55VOIMnEfDEZfvzi5so8eiSgP0FiV
 osT27AU0=
X-Gm-Gg: AeBDieuv3wix2sc1sOyCYZyd7J01FVwy8rw8z43rgC5RXLfp97JSTwMC+hSIg/JnQXG
 qkHf1tnb4B573m/JXomjgPCqWfpjGWVRZWCCW9xoNm+xDhU4IXF47P1LJJm3hDQ0h1zW2d9QyIl
 UbZwV1DjCRp5HoKfJLV/CcqQ0pJmdMgectyyu0Gbdv1f9r3cxr1VHWOPYA53clioGJXd/N6s+M4
 6qKFNTH1r1eEi35+l+1q9UdV2PMyhT0hQtouDGenSAErzazPl8WL5zxIa9D7zIWGQiK41AeSnDH
 nUxTEfWcKPqPStzbXa/crMg99A18ZnsnU2tG/X7ZQ9vNhONwb1uZlpR3jBnpBWDnXVV1vwRtehG
 qZMY15uwUXUsyjQrqT2G6uoO7GrowzLsE0y1nuC5WfwTRAvVZyj0N1vloY7rGrD1IuhGN8pW515
 Z86yvnOcGGyoF59YoFz8XVWaQsuy7qSTQQL6IpKabDNk0wUmSYH4HC+DcgQqTO8uhxVRSZ7eck2
 Wsnhjpdu8uyCqkTf6Ypm3AN
X-Received: by 2002:a17:903:1ac6:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b5f9e77d75mr2863505ad.1.1776379017544; 
 Thu, 16 Apr 2026 15:36:57 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 ([2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa58b49fsm290015ad.51.2026.04.16.15.36.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 15:36:57 -0700 (PDT)
Message-ID: <5fb0432b-6c1c-40bc-b022-939d73f2115d@linaro.org>
Date: Fri, 17 Apr 2026 08:36:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm/ptw.c: Add two new spaces to the granule
 protection case
To: qemu-devel@nongnu.org
References: <20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org>
 <20260416-jmac-feat_rme_gdi-v1-2-d9fa0781ed58@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416-jmac-feat_rme_gdi-v1-2-d9fa0781ed58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 4/16/26 21:12, Jim MacArthur wrote:
> This makes no functional difference, it just marks out two cases for
> future use.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/ptw.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 7b993bb5b3..d4b63a365a 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -510,6 +510,11 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
>           break;
>       case 0b1111: /* all access */
>           return true;
> +    case 0b0100: /* system agent only */
> +    case 0b0101: /* non-secure protected */
> +        /* System Agent and Non-secure Protected are GDI extensions. */
> +        /* No processing element should have access to these. */
> +        goto fault_walk;
>       case 0b1000: /* secure */
>           if (!config.support_sel2) {
>               goto fault_walk;
> 

There's no real point to this patch, since we get the same effect from the default case.

It should be trivial to "properly" implement these two cases for the CPU, since

     R_QCLPTA:  PE is not permitted to access memory within the NSP
     or the SA PA spaces, from any Security state.

Access to these spaces is only allowed from external devices via the SMMU.

The only effect on the PE is to check the various GPCCR fields (SA, NSP, NA6, NA7) to 
transform them from one type of fault to another: fault_walk -> fault_fail (i.e. break).

There will have to be some modifications at a later date to actually allow these cases for 
the SMMU, but at this point none of the SMMU patches to use GPC are upstream.  So it's not 
worth worrying about at this time.


r~


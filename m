Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713FBE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNdvP-0002nT-I7; Tue, 17 Dec 2024 15:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdvL-0002mi-G4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:12:07 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNdvF-0007Ms-6u
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:12:07 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso50416135ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734466318; x=1735071118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tAH1J5fp5VRWwPXKMoQxyI1m+V3SpOz6pk36bLdUziY=;
 b=gt4ADS4VG6IVVinuf/833s4zLxGKZ0iYdF2TcYHLWqeaxmmED5MjacwFPFpuJfn0Ow
 Eb2ZsjPyFvMBGMT78xcs6xGp55jeSkLpjPqBnhgbGrT014QQoC98hH2C/wE3ilogUm0q
 6mvc4VYFTl41aYYQ0hCEVcSNHVbKZOdBfr4o6eaeI8c6zK0Y2v28RonLzw6jip2EEwMm
 70RPsLANnh62otfTk8+YbBLkXThjCYjiLuq/lOrGTfHeRLqebgfwSWqn2wxaY4f2zz2m
 C57Lvpr/nquK9pJgtaufYjaa3s2TzBFd2oGQE12IatjX7Ypqe+LS8uy41G62DHBLXyZY
 lYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466318; x=1735071118;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tAH1J5fp5VRWwPXKMoQxyI1m+V3SpOz6pk36bLdUziY=;
 b=lXQ3BHSAb1gz9LJwr5MZGegWUv7CwFPnP6/YcT/G5bQ/nLylLp7mP2SeVW8PvCR31K
 VVMUwrSYrTbhSS/0nAOd2LCgqmPdIR7BSRAvWG9ZZkSG90ZjaW8GGVkNk7ihWzvdgEGE
 yn+1B/6838ePlB1HkUnptqZb9RbDjgInRhkTtX5vAMI/8kS3JD35b8q/gHTS3UZxCGTE
 JrnQgwIifiUXzAS5SKJQUiJv39k2ne0qF1dxTZIOBznWtoZgu7moFq10HFznnh3HTEEi
 cDgWQxGKXAXj2pg1aSlFmSVhv+to1khdNmtUpIo5wRwcTEAGzp8ORzb+n3M7Ub2oltte
 hn7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU11jRrlvjPe0pwuRIXY+NFfEM8hAm2r0kB5AiK6nWPuvcjEnWwmSKO9lyDaGRTmdGWL94xJwToWrY1@nongnu.org
X-Gm-Message-State: AOJu0YxihFLSX5d7ApEtuc0BHcZIBc8yeldBQAHXn0S3ed7Pc6nso3A7
 9NZAak1XOnUGKQQfGCtKKRcTcRD7qeIeBcBN1AO8na6f7Z43pTUHbgVGQzOmS4I=
X-Gm-Gg: ASbGncsSxNTiYYt/briX4Cz9faThulR1sLabpL+raw97Gexx98dEDaTB8w5eQA4Neq3
 71H5tRXETLacvrno34sokkyILiY0TPgqsgVF6nF+kt9BTZbcvw5U8uesAaHJXy1hSebiZvkLtTn
 mU5fnutWK36/Nd85QmH9+CqB+EKmKw6BnGBdNW1J0vTvdZI+y+WbqsoRl5fvf2i/uv/YO4/lcUN
 R6LGgT8D9RLCdAEJDVHqoYxbVRj//qw5NcwR2Js9uCzr50sHn0WlYlE24tpZ5QCvnxYPQ==
X-Google-Smtp-Source: AGHT+IHou1OwYKV2Mq1K969AVQSAd1ym3/6W6Yguqms3dRzrz6i/iYNb5gSH8BpOvZv1YsFzq8ytXw==
X-Received: by 2002:a17:903:2a8f:b0:216:3dc5:1240 with SMTP id
 d9443c01a7336-218d725a876mr1432935ad.45.1734466318338; 
 Tue, 17 Dec 2024 12:11:58 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e5c4d3sm63212795ad.182.2024.12.17.12.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:11:57 -0800 (PST)
Message-ID: <dc64d495-f048-4fc7-9bd1-8059c13ae40d@linaro.org>
Date: Tue, 17 Dec 2024 12:11:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] tcg: Remove in-flight mask data from OptContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> The desire is to start re-using some of the fold_* functions
> while lowering or simplifying operations during tcg_optmize.
> 
> Many of these fold_* functions set z_mask, s_mask, and a_mask,
> which hang around until the end of the tcg_optmize loop and
> are applied by finish_folding.  This disconnect between set
> and apply is a problem -- we would no longer be applying the
> masks to the correct opcode.
> 

A general question on this:

Where do the s_ (sign?) and a_ (?) names comes from?
Reading the description of those struct members, I can't really connect 
to their names, except for z_mask.

> Fix this by making the masks local variables, passed down to
> be applied immediately to the opcode being processed.
> 
> 
> r~
> 
> 
> Richard Henderson (46):
>    tcg/optimize: Split out finish_bb, finish_ebb
>    tcg/optimize: Copy mask writeback to fold_masks
>    tcg/optimize: Add fold_masks_zsa, fold_masks_zs, fold_masks_z
>    tcg/optimize: Use finish_folding in fold_add, fold_add_vec
>    tcg/optimize: Use finish_folding in fold_addsub2
>    tcg/optimize: Use fold_masks_zsa in fold_and
>    tcg/optimize: Use fold_masks_zsa in fold_andc
>    tcg/optimize: Use fold_masks_zs in fold_bswap
>    tcg/optimize: Use fold_masks_z in fold_count_zeros
>    tcg/optimize: Use fold_masks_z in fold_ctpop
>    tcg/optimize: Use fold_and and fold_masks_z in fold_deposit
>    tcg/optimize: Use finish_folding in fold_divide
>    tcg/optimize: Use finish_folding in fold_dup, fold_dup2
>    tcg/optimize: Use fold_masks_zs in fold_eqv
>    tcg/optimize: Use fold_masks_zsa in fold_extract
>    tcg/optimize: Use finish_folding in fold_extract2
>    tcg/optimize: Use fold_masks_zsa in fold_exts
>    tcg/optimize: Use fold_masks_zsa in fold_extu
>    tcg/optimize: Use fold_masks_zs in fold_movcond
>    tcg/optimize: Use finish_folding in fold_mul*
>    tcg/optimize: Use fold_masks_zs in fold_nand
>    tcg/optimize: Use fold_masks_z in fold_neg_no_const
>    tcg/optimize: Use fold_masks_zs in fold_nor
>    tcg/optimize: Use fold_masks_zs in fold_not
>    tcg/optimize: Use fold_masks_zs in fold_or
>    tcg/optimize: Use fold_masks_zs in fold_orc
>    tcg/optimize: Use fold_masks_zs in fold_qemu_ld
>    tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
>    tcg/optimize: Use finish_folding in fold_remainder
>    tcg/optimize: Distinguish simplification in fold_setcond_zmask
>    tcg/optimize: Use fold_masks_z in fold_setcond
>    tcg/optimize: Use fold_masks_zs in fold_negsetcond
>    tcg/optimize: Use fold_masks_z in fold_setcond2
>    tcg/optimize: Use finish_folding in fold_cmp_vec
>    tcg/optimize: Use finish_folding in fold_cmpsel_vec
>    tcg/optimize: Use fold_masks_zsa in fold_sextract
>    tcg/optimize: Use fold_masks_zs in fold_shift
>    tcg/optimize: Use finish_folding in fold_sub, fold_sub_vec
>    tcg/optimize: Use fold_masks_zs in fold_tcg_ld
>    tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
>    tcg/optimize: Use fold_masks_zs in fold_xor
>    tcg/optimize: Use finish_folding in fold_bitsel_vec
>    tcg/optimize: Use finish_folding as default in tcg_optimize
>    tcg/optimize: Remove [zsa]_mask from OptContext
>    tcg/optimize: Move fold_bitsel_vec into alphabetic sort
>    tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec into alphabetic sort
> 
>   tcg/optimize.c | 597 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 315 insertions(+), 282 deletions(-)
> 



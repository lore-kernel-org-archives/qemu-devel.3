Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99505E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBt0-0002sO-Sw; Mon, 16 Dec 2024 09:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBsu-0002s3-T5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:15:45 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBst-0008ID-4o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:15:44 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ebb669df2eso891084b6e.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358542; x=1734963342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8FdsXbztcrItqR7EEzd+OWsMEmiInfpWD7Mu2qvhs0g=;
 b=FnToGeokn3y7lpoVEyO+5ysBaMUBD+qPiN1Tl1oEhY1RDa8/BH57+sEYMY2AUZiO3o
 +C87WL19nZKckCqc1/jkpPg/VgI4QPiX+LqCmbsTCBuJKPmYNZ2s1PndGdDHFyNyqz1D
 85HVPEyDD8tQ9raFBWf9zzz9iyjcDWtdevzuZm7CNamMtNrFaeNK228hoV0gsnv87xk5
 krJXRVxpuhDx/H2gaxDYjwIk4FjO1+m4sy9a42iDRCniRS3+3v489JuvCE6Oi94l+0o0
 pKN+ipM7irokZLqqaEZS+55AIRxljoCXceuJPFjrhaDX+700S/ldNO0nVI73egAbEJxg
 QnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358542; x=1734963342;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8FdsXbztcrItqR7EEzd+OWsMEmiInfpWD7Mu2qvhs0g=;
 b=IJn5IWTr7srie7t23Q0R6mBsJGq+rni7avQn4ukg5TK6dw4E76VsOfv01cor7klxlm
 vI24MqA2stXAwt+bphvxKvcLLh/liofV12+FakMw1cpXgUXvMUOpU0gPkp1hA6LO0hDk
 Gydbco7XHlIM+VCWf65bGfqQ07NnoAOCIMnqMCE0jX7sgYOZG9/5LHyId/mVzuOP9+wH
 mua7Y9vLcbkArgI81wZRLxWw6+FfExpGFDfcZwNXIniL1ZSeupT47HQuktvEhxiKnExJ
 znhBPlr9y3eg/X7wx60rwi8Lh2QGe95iwgBFqhuevF5q9UcoKADtRFpLMRYg8Vnblxd+
 w0mg==
X-Gm-Message-State: AOJu0Yxp+xeWd60XzGDs+G/NljVs66ypS+BwW0rFcnPKHfwEoyVzVKrv
 2gH0uB5C57Gw5VeBRfxr0bVNSxEnbKDWd4/2fLlu3koPmc8IaIeMGSr9HTFD3j1nyRMA5tHzQ9T
 rs3+Y1NA0
X-Gm-Gg: ASbGncv6dJNJYqsEAwmavadivmu6K6phy5wl9P+QqohPfqzo5Z8kXRVvgunRwQzx73R
 /ekOPi8V78NlXgbvbqB+Cs7XEmsuJJ0cg/aPWgEGEV8B8k7DKkBmrL24FV55us8URqXTVxu+v0U
 CzUbAQlrOcyxqnDkpAtm8GbHTZO9GkwE94XrPvV/RSqTR7ZEur31qQWWW++Xg5s5mt52dKUIwLo
 uCLZFrSVdH53om8BDya/DGQABbIeveyQbE3l0l+XQfVnBoQYY2kVbuhRozHiBjvfYK42ZPN7O6+
 vG793gJbVU68eL7d3+6cgWRQ1BA6zcuYDHI=
X-Google-Smtp-Source: AGHT+IFXRuH4l9zECHlxM/MWwge1VX2FldMaFOlzT/7j0ewCCCEm6rxznjYkGrE2I88W4j5Q5Dmp+w==
X-Received: by 2002:a05:6808:250b:b0:3eb:8236:d17 with SMTP id
 5614622812f47-3eb94ef2aa5mr8769003b6e.11.1734358541822; 
 Mon, 16 Dec 2024 06:15:41 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb479d2a4sm1538315b6e.16.2024.12.16.06.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 06:15:41 -0800 (PST)
Message-ID: <97666202-d34d-449a-a763-99cbf353cdd5@linaro.org>
Date: Mon, 16 Dec 2024 08:15:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] tcg: Remove in-flight mask data from OptContext
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

Ping.

On 12/10/24 09:23, Richard Henderson wrote:
> The desire is to start re-using some of the fold_* functions
> while lowering or simplifying operations during tcg_optmize.
> 
> Many of these fold_* functions set z_mask, s_mask, and a_mask,
> which hang around until the end of the tcg_optimize loop and
> are applied by finish_folding.  This disconnect between set
> and apply is a problem -- we would no longer be applying the
> masks to the correct opcode.
> 
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98800F9D0F6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 01:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCp29-0004m9-Ax; Tue, 14 Apr 2026 21:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCp27-0004lv-RG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 21:27:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCp26-0000Zb-2L
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 21:27:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b24fdac394so56041835ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776216428; x=1776821228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XynT0EczAe7k0mKnD6hXNvdOASv2G7X6Ot7hgnaIJUo=;
 b=qBQFS+pG1W5n7Ptg7lBF7qbS1y7X5W7Z0+BV+F/Refn+Zh8q2kY7wfj5oOUyIsWkf2
 SDLiuabELC2VvIxlR9dkzOOESOgV0IAAHjkYytAp5WaFdADrqwzp2YXKcFPrIo0VRM3d
 AAccUzsuPsShJdVLESxlIkO7PF7Xj6Ac2jOozvMUJEZABdDAav/5lAFMPERIgpO2cMbX
 SwGGt44ujhHNgjw420UpRSVEYwhy/E5huEPBdCk6eiEZV5Oyux8FizuVHKavG4zB4CcA
 YexjoLTUq1NEnKf3AAkV00SG1XVcfIKzqwnEQmJnow+AspVw2LJvRTaiVVyzvDjMsttf
 dgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776216428; x=1776821228;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XynT0EczAe7k0mKnD6hXNvdOASv2G7X6Ot7hgnaIJUo=;
 b=K4XCGiSQnZvkbgKdego39KJlX3h1phQgyZUfUvZyArKv7yM9ce5m6uKmHD1cALAlDV
 akHeH0jJ7YzVU7WZiNWFytbJp+mclvRWVF7gDlZLCEf08OVyjVIhh/2IZquuxZ6U9kNV
 6OPhkxSDsa7PlvHY7X/dVDe0udwo/HSKXRoOKAjdd40Lit5hNplWri981kTEiwJV6OK3
 sBQqw+oe3j8X3Km2VEquwyErZHVjZYr018QYLlCytcdmhHaTk4MhRHSOQ5Uv8+wYE5sR
 KkoUAFqC4MNnRMgkcZTyovD85cujcoTJqMLpiblzZtpg1Tp6Sqhu4KKGLutOprIN61hJ
 uDbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CDrDQbsPsB3a1W/J5er7rv4R2tXtchwdMtACRy1cKGAwcGYG1SAYc80mc+WeMMUa6mBPrkB4FhIqP@nongnu.org
X-Gm-Message-State: AOJu0YwgyYWb07EM0M0JFjZjg4UU46pi3zDRGjnQg2yTx+YmgwweL4OW
 ZsV9H/iGxPKpY0ADlSBgJR7r7jc0kOob/F3lkgEq4IwHdMF3Qq0GwWiVZASnkjZJkl0=
X-Gm-Gg: AeBDieuZLhCgtXfiN8lsO2Rv+sMEiqGPNw24R4cQtNr8xyt945As4zuYVDI3YpzFnSH
 5F/2ipYDxroE0n4rD1NbuA/clT06yhfvb1ukXtIUesu+xB4UH/ZziFdobhrTgu1vmaBIqMMgJJH
 tJkwhbPTSdwkzjPxqxlbxrllBAfLaKrkOnZd+lsQ+mUwDx8vU8VPcjoGMOI3IRQLrmaMsodubUu
 m45haATRKZRnMkGTcqKP93eYyEsoOTzc53GHiLOVVrgDks5aY1BuNBJYBMhM0aU3BixoTUISLqD
 k5TQipN2Rx8HYw7U7Lv7EH/HlpssFui7h4gIi694OQCdS4xPZk52GAGW+f1fgLiA3s5ipwVEb0n
 Y9BSLNJuHUqAE0lk08ZnWhj9EG1JI43DStnUxg6TIaxcu2+EY2HOYPwRvZnU+NLQpLYkhY2KzfD
 Iv9e2uOHwCnB1qoBXJr750W/qLgXvMzerGB+/TfDrd3G33P3nSExVztroT45VwnsvY3fggGMtGC
 hWUizU6MTV0VckQQILfLnWXOKTN6OPz7OYEG6v/gwC/gUx+1D/x/ALuxzpe5a61cA==
X-Received: by 2002:a17:902:f801:b0:2b2:eaec:c810 with SMTP id
 d9443c01a7336-2b2eaeccbc0mr94560985ad.8.1776216427863; 
 Tue, 14 Apr 2026 18:27:07 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:d886:79ed:f42e:d433?
 (bg30dj07kclk5whmtq5x.ip6.superloop.au.
 [2401:d002:dc0f:2100:d886:79ed:f42e:d433])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810b4d7sm2497485ad.20.2026.04.14.18.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 18:27:07 -0700 (PDT)
Message-ID: <cb1f6e18-33d2-42fb-a3cc-377821697105@linaro.org>
Date: Wed, 15 Apr 2026 11:26:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/2] target/mips: Translate MSA vector load opcode
 (LD.df)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260414213108.66786-1-philmd@linaro.org>
 <20260414213108.66786-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414213108.66786-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/15/26 07:31, Philippe Mathieu-Daudé wrote:
> +static bool trans_LD(DisasContext *ctx, arg_msa_i *a)
> +{
> +    TCGv_va addr;
> +    TCGv_i128 d16;
> +    MemOp mop;
> +    int d0 = a->wd << 1;
> +    int d1 = d0 + 1;
> +
> +    if (!check_msa_enabled(ctx)) {
> +        return true;
> +    }
> +
> +    addr = tcgv_va_temp_new();
> +    gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
> +
> +    mop = MO_128 | MO_LE;
> +    if (a->df == 0) {
> +        mop |= MO_ATOM_NONE;
> +    } else if (a->df == 3) {
> +        mop |= MO_ATOM_IFALIGN_PAIR;
> +    } else {
> +        mop |= MO_ATOM_SUBALIGN; /* slightly stronger than required */
> +    }
> +    mop |= a->df << MO_ASHIFT; /* MO_ALIGN */
> +
> +    d16 = tcg_temp_new_i128();
> +    tcg_gen_qemu_ld_i128(d16, addr, ctx->mem_idx, mop);
> +
> +    tcg_gen_st_i128(d16, tcg_env, offsetof(CPUMIPSState, active_fpu.fpr[d0]));

You cannot write to slots that have ...

> +
> +    if (mo_endian(ctx) != MO_LE) {
> +        if (a->df == 1) {
> +            tcg_gen_hswap_i64(msa_wr_d[d0], msa_wr_d[d0]);
> +            tcg_gen_hswap_i64(msa_wr_d[d1], msa_wr_d[d1]);

... tcg globals associated with them.

You need

	tcg_gen_extr_i128_i64(msa_wr_d[lo], msa_wr_d[hi], d16);

to extract the halves into existing TCGv_i64.

I can't follow the endianness assumptions in msa_helper.c.
I suspect it can't handle both big and little-endian host.

But hswap and wswap don't match bswap16x4 and bswap32x2,

Before:
   LE load, then bswap elements without swapping element ordering.

After:
   LE load, then swap element ordering without bswap elements.

I think you were looking for:
   BE load, then swap element ordering without bswap elements.

But in any case, it's an algorithm change.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B5CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 19:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96wx-00057r-D2; Wed, 15 Oct 2025 15:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v96wv-00057E-Ob
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:14:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v96wi-0007Vd-P8
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:14:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso9623053b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760555631; x=1761160431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X1eKwywWgTFyzvIi7dt72yCxC9y365YeECwDesP6yds=;
 b=WE49gGhnsESUuEcu/73GicJ8QnIbpWopz31f6DWznFwWSpCBn3oHLa9RGEGoT/4gGT
 E0VYqYckH19vFdeJE3IEIATPJd6c7IPYemsSXPrb+7yddo2Bnps4F6xMAiaZTJCmROBv
 90bUcd59jCClesY+BlibLeRe6js0VqfI2GjMTE4EJj2qBv4cG4NUgMkzOiukf45BRMDR
 +8M4HTI2CuQfYNgmFRlxZ90WJR1GvI6yYT/GXFEBdO16g2HHJh0fvb+iOGsuDvAy3G2v
 wQbQcp2Eg+wPctVtQZOpD/6VJDYWJaGHG/Kwu4+Am0DNcZkXPP/hrVdxep3mnCnGfOmp
 J+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555631; x=1761160431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X1eKwywWgTFyzvIi7dt72yCxC9y365YeECwDesP6yds=;
 b=bk5OxrfaVStXA0X1ZaalkV/Lo10vr8wYSJHQRxkw+LAZw9gM0ZpaYiSJXJ4P8pNk3p
 daKDqs/0rMeD572fKa/zztNxyqIjXh/ijranReLTWhKpFB2fK0ii56KJ/ghVrSTZR7Lc
 99sjqKxN5y78OupyTAGMbwJXodxgT5By9RkGW8k+clpN/r0bnXqPi9dwUoebuE1m/O+v
 opriTuvgbF1j1BAxlGpaJtuISbRzHpZqxQPns4Cwt6x901DeKdkD5EDdrFXKOR4rRcFr
 ZcUzsmz9sZHuaE1hFUZA4fgJj0MIxRTQpQ9WqOj/DgsvzC49pnFL1NAKsIsNuvL9MLXO
 4+Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJeXI5/qWimohcbkFOczf7yEr+tjes4mxgIy0EKRRCJ4P871Lyk7rCGAj/sOgOpC6tVfwGts+0jACO@nongnu.org
X-Gm-Message-State: AOJu0YwfFmb/JUnD9bcx1i9oQvc0j+hfpln4lfqab2qiCShZrINI54Jl
 4wCK2HMqJJtH96xArR8eiKluUnqHfQiv3CoW9jAGFNxhYSTeowrjowGj3+h6yGOjDoxOQmVyEYF
 yaBH3
X-Gm-Gg: ASbGncsx9/ydzM8/jwFwtW2fpmyjJXQP5NpH3a6bBGHUWmGOG8vpA/6esg62Y6XaWg1
 x2ee7Bl8wpyCGM2ZWjcEwCbYoXNbONzg54RkPLXzj23uxWE6Tr1UoleKueoCYqWnNWFQv6vB2wN
 T5hARhLuWaSmxO7f4cJHIwZI9OqcwCN1DE8tD+eThiCkdYLHDKmJHKHwX7kuos3S5p/yCqe22pV
 o07q1kc4w8n5VGxgqmGNRfxOwtTdD76eZB3xZzEVYpqDIqzThUQtsEwVT79KFU3mA0mYH3oGh72
 oQqqC8QmUS5zorwIPkUUSkVGZeZTwLj8amfYGgE9sF4JfkFbXiK4WRDM1Xe0GXuOrmH5SNWTjgB
 95wXAs/zv1xZ5nYdyrGVeMCJtPU42AMEM2XGYEzPOLr5O0HslH5y+OQ+OG1owvua3OabnuvuDyr
 S6VAQ=
X-Google-Smtp-Source: AGHT+IEqdXdxPPw9uirducn4fkMPG3lBzLPE6J7raPTJa3xax77r/z+ucq2cswr/bMBjF7BtnZZgVQ==
X-Received: by 2002:a05:6a00:628e:b0:7a1:373f:c216 with SMTP id
 d2e1a72fcca58-7a1373fc4c5mr4822199b3a.14.1760555630923; 
 Wed, 15 Oct 2025 12:13:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb1e50dsm19687194b3a.33.2025.10.15.12.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 12:13:50 -0700 (PDT)
Message-ID: <a93ef85b-1bef-470e-926f-f3182abe9f51@linaro.org>
Date: Wed, 15 Oct 2025 12:13:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/34] target/riscv: Fix size of gpr and gprh
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-11-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251014203512.26282-11-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/14/25 1:34 PM, Anton Johansson wrote:
> gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
> fixing their size to 64 bits makes sense.
> 
> gpr is also fixed to 64 bits since all direct uses of env->gpr
> correctly zero extend/truncate to/from target_ulong, meaning
> !TARGET_RISCV64 will behave as expected.
> 
> We do however need to be a bit careful when mapping 64-bit fields to
> 32-bit TCGv globals on big endian hosts.
> 
> Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
> older versions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h            |  4 ++--
>   target/riscv/cpu.c            |  2 +-
>   target/riscv/machine.c        |  8 ++++----
>   target/riscv/riscv-qmp-cmds.c |  2 +-
>   target/riscv/translate.c      | 17 +++++++++++++++--
>   5 files changed, 23 insertions(+), 10 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



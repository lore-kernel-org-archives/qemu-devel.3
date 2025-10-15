Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAEECCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95rq-0007it-7o; Wed, 15 Oct 2025 14:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95rp-0007bt-99
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:04:53 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v95ra-0006h9-MI
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:04:50 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-33067909400so5033053a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551474; x=1761156274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hiE6nKxlxT3dKWxxJ2StkUUJLaYjvE3FN25uqfGzX0=;
 b=NI1LsbXFsxMuaxZeHKxwgdzxe2+PQWYzMTD1QIqjlaowKVAa7R0P0MnBjZVo31JoQS
 dlFqzA1ru/hzDIhkJ9PymH1LoDpApvHMZYoX7Y+/tWGFsukUHMpPuUGMU/yoco+f5OM4
 vTtoPMZ15nq9XsizQDNHIalXj/cG57M/rU08dt7xlAaHrC9NPsP2+G884J5dpo75hgdI
 ZiJe7hhcInpiFpyKgKSpokB3Yid/L3uPe5QgGwFAHHY+2FrbG21tQIXnZ6CrsnRInm+I
 O4tl+3rcu/beXjZf7FBDRZL+lRYW44a8BRtqCLCh9OkQlIR9rMuzIyo3dJtQ4n6FAyAD
 G3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551474; x=1761156274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hiE6nKxlxT3dKWxxJ2StkUUJLaYjvE3FN25uqfGzX0=;
 b=SpS2TSbM16n3Yhq6JTGb8X0jnDpre8a914DuMovAZ87tHSNOum+Nz/czZ9EVONP/jW
 NkJXvTQ+70IeZxT7+q7kPqX5kPk/ofuzSyTRJow4dtLfINdmpUGIWOs7BqiL2v4f/4dy
 ZAji9knKJypn7Bs1rukOy+IWGz4yJ0qJGdsbxNApuztHU75ILWgwLj8QpX8oO6kiDcek
 KsJqPL6rIv/Eep+yHfvVTdA3gOiail6HDtYYFmExQQc18ZgMphRzOEUrcVrBJKeu0b1D
 ofyXgfY+rthSzaQqqF2rX8+n5kL8rW4DKGpllqIOyiCUPcPz5teiWLVsEHWnRza3il8h
 bfPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXESp1iqGLVR9ZrXgtLbFXwzcQrgq2WWYOplo6IymbBxIL1erKCY0kTi2BqUi3bwZ3HeqJFquhZIuzH@nongnu.org
X-Gm-Message-State: AOJu0YxhrLqXNvY2CR9cabLQxzEbbHAPySSBGKdggQimUVeD0UHDqiN5
 GrMtqt8pde2YUyFRecFchGMUVGg4iui+2zTff334tJ51qHpur7JDuitsKDyVVZLNQcw=
X-Gm-Gg: ASbGncuEcph6UAefocIUTb9aTVwVJS3TcXYUlO2nmxmuakKRJBHdxtmDlyVCWNki9yX
 dh4ySfycjYFg3iI5/iZPPbmhJa0CZwBeaHdpDlRqrF7QCF41LNLem1DByoFl1m9ZlOAkoeYWmxJ
 6N7jSAcyT/e/C7wqB5icFgPM0EqYbWxdaRVEVomTkfwwQN2nlcvckFYXVfU92k8GdXPFWnuf8QD
 3ypC68PjrUpwDJ/vZ9//NiyDpCkBiDePhuETEK3ECNV23BjIujmA8TE6gZQtJ7i1W+WY45BvY1N
 LaUyXwUwJrwNNbtdjMUpZfIh40JewD7Id9C6sZqPO6rqDNgh7TD2NNMwr1pFtLA9PksHT3Bc6M3
 eaAihN0EQHiqG6e0BY1v8+rt670/vh9nVsRqpPwkJIhB4lmzGXli8+C72BX45Pyja1xIzgaGjGJ
 RnCxaUhAimB8gHA6nF
X-Google-Smtp-Source: AGHT+IFQJJVSEbMiTR2M9+stAr1D9/2mbt3XeAAZQJJD1tKFMmT1tJ8A2hxNYVwjwe9OpkXa/C+sxQ==
X-Received: by 2002:a17:90b:38c3:b0:32b:d8af:b636 with SMTP id
 98e67ed59e1d1-33b51377d87mr41413433a91.19.1760551474072; 
 Wed, 15 Oct 2025 11:04:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b9786e602sm3303778a91.11.2025.10.15.11.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:04:33 -0700 (PDT)
Message-ID: <f50ee036-8c6a-46c6-bd9d-9cad63c20229@linaro.org>
Date: Wed, 15 Oct 2025 11:04:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Name gen_goto_tb()'s TB slot index as
 @tb_slot_idx
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20251010031745.37528-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251010031745.37528-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 10/9/25 8:17 PM, Philippe Mathieu-Daudé wrote:
> tcg_gen_goto_tb() takes an unsigned index to the TB slot (0 or 1).
> Declare the argument as unsigned and rename it as @tb_slot_idx
> (which is more descriptive than @n) on all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c         | 8 ++++----
>   target/arm/tcg/translate-a64.c   | 8 ++++----
>   target/arm/tcg/translate.c       | 8 ++++----
>   target/avr/translate.c           | 7 ++++---
>   target/hexagon/translate.c       | 8 ++++----
>   target/loongarch/tcg/translate.c | 7 ++++---
>   target/microblaze/translate.c    | 7 ++++---
>   target/mips/tcg/translate.c      | 7 ++++---
>   target/ppc/translate.c           | 7 ++++---
>   target/riscv/translate.c         | 9 +++++----
>   target/rx/translate.c            | 7 ++++---
>   target/sh4/translate.c           | 7 ++++---
>   target/sparc/translate.c         | 6 +++---
>   target/tricore/translate.c       | 7 ++++---
>   14 files changed, 56 insertions(+), 47 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



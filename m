Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD637CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PiC-0001R2-Rf; Thu, 02 Oct 2025 16:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PiB-0001Nk-0I
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:15:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Phv-0005Oc-Rx
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:15:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-781251eec51so1377577b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436107; x=1760040907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KUSLO1VQCX9X67eQvinvbZmdSrQOztg0kQcS8qTTLGA=;
 b=wAYcGsUUaj7aLetmByChvNuFZCrlYWp4xnBauXn4MI9DuSGUcxRlQymsAEBH2LXpzX
 2zHLpk6Ei+Q76unJLSB7g3eRZgydg8L6XQM19jZQJ9FU7JsWwOQ0lYGijeQTDs9MRP5l
 +phqbFmX1/5eD9ayzz+dKNKZ8zOiO/2WJ/BvpJcIhMUkERyNYA20BztsB7ZlH+v/hzmR
 JHDl+XoHQjteWTPYxIQSnhv97r+gFoU3slQne4q0uqk3gGEouI2mXHqG5vmazJCB06TI
 cnpQMEgcBGAgegpd90yHkJfhuRXjtLr+0vEyaeK9xhuDLkhXHBBs+iqo0jgB25Ve3ErP
 exbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436107; x=1760040907;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KUSLO1VQCX9X67eQvinvbZmdSrQOztg0kQcS8qTTLGA=;
 b=lo4hhBXCdcijJsX0M7OxJGnLzo59oO1HmliNA+iTk/SDSjz4xJFnIF7PcFajW++fgB
 q26fjXejqtYsgZVVKPFehfzc0zGuyPGLvFqLSvmB1tMq4gTUeK5pZybZNG4Kwfy84KdC
 kEDIPX2yD2JS3TJUlaeAmp5hRWf5yN/J7R0yg49S3LyKouhar9a16xeQ2ze0BdcU7gbD
 jJ7qdOT9Nc5yzrIo9e9E5G4kmHw2WYVYlpTYHIMpFSfH94jPfV3h3ji42AK0rEAnoo8j
 NLJxT3m/ghIf/em2TOqK43QJROIHACK+YTa11ev9SNqrVn/m+xa4ah2Op/jJX8qYea+u
 3/pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzifJZbFMlwNU1oEArmL6SpwmFSrnJoS9ww3MEZqSLYx8Ds9lcVhdEgN1JfP257akaiBJHDc+BvRue@nongnu.org
X-Gm-Message-State: AOJu0YwlbgVxyfbBQUrdH5SPZUblaq4Nz4kPJRasjoplnwpnOuiPQ/j3
 lwfPEIrYC+IgFobyqvnAAFum4jzx8ZDrcJvXqCtJZz75VpLbkFoA+dTZXdJnpyJIme0=
X-Gm-Gg: ASbGncvhpJSWryJfwUJncOQdYKec6/KF7GbE7YF1ZYZThArBQK7rT/nJyvfAcp1r00L
 TCwQYQKM0AFhmVA64tBdi4ZKfWVX+dhlfjRsuYtIlTEnmhvSOpXy92uw1pzFSkqxLH9AH/iA7OE
 0yRC1qHz2Uax7nY0o99R7ygcRe9SkCnXZEfL+yyUoDBvGNfY6xr2s10fGf/wqiJcekVHQCdcvN3
 ymoiXFkxElMUnzTJsfJr9XYY43jiwvuCuPvxYQ88sItN58wj6w1CdD9GYLytOgFfmQ28dZvqYwn
 odNxcMWaW4rNkuEpzGn6AFoRQXN7qz9D0dJyPaJoon5UNaLfJqPdodI1dRbweu0gDa1cMYBh0XN
 FzyEvsYa1wEAaSXbqW8p/JvrYZT+qxj3FjVCoNvcs3tzzm53BzkP+2UvdAS2DFuI=
X-Google-Smtp-Source: AGHT+IF/5+vmdBO2J/O1rIhVumEQfmg6MVr20MLT6wQtjgLZSeT0S/4x2SA59KKMOZKwIkuGCKjmyA==
X-Received: by 2002:a05:6a20:7f8b:b0:263:616e:b62a with SMTP id
 adf61e73a8af0-32b61e548c3mr839827637.13.1759436107271; 
 Thu, 02 Oct 2025 13:15:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099adbcbesm2619366a12.4.2025.10.02.13.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:15:06 -0700 (PDT)
Message-ID: <e151a3cf-a4a4-4b99-a5ce-787800b0dbf8@linaro.org>
Date: Thu, 2 Oct 2025 13:15:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/33] target/riscv: Fix arguments to board IMSIC
 emulation callbacks
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-24-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-24-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> In hw/ the relevant RISCVIMSICState fields
> eidelivery, eithreshold, eistate are uint32_t.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        | 42 ++++++++++++++++++++-------------------
>   hw/intc/riscv_imsic.c     | 34 +++++++++++++++----------------
>   target/riscv/cpu_helper.c | 12 ++++-------
>   target/riscv/csr.c        | 24 ++++++++++++----------
>   4 files changed, 57 insertions(+), 55 deletions(-)

Fix + refactor, but it's ok to read.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


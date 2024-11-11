Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCCD2E9C5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 15:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAWK4-0007Dz-SL; Mon, 11 Nov 2024 10:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAWK2-0007Dj-SZ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:27:23 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAWK0-0006O5-HE
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:27:22 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so4079473a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 07:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731338838; x=1731943638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=peXt1wGsaoIow0BySWPCWxrjpU+ntCIsjWNnSs480IM=;
 b=BZU+1MKGq4cIOszf39mRt6wzSt3AXgeQWGV6GDwAjKo4XLFRDJT3P57E6fnS0o+7YL
 sXSpyWRgna6Pd3Jp339wgO2x9Afn2xJxfVA1mXNZpiFRGSUr05ES14VOwxUs/aYWoT54
 cWyBp7gYkUCF73MTxgCdMyjq3GTgAXSFd8bHOjG/eLmpqohicNSKqIhcdeFca8/XVQTa
 BwjI8JYaD9kjV+AbqwArM2xRvV4CXdOox5SrQP7wzUh6wunuu+L6lK+zJkSwP50TbwdI
 R5VDFs74Z+8MCiVry/75KpnlkF5Clr2FeNJPhzU40d4pzzku52nREz3YmVyF/pKbTPIc
 anxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731338838; x=1731943638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=peXt1wGsaoIow0BySWPCWxrjpU+ntCIsjWNnSs480IM=;
 b=gSOt2Mhgq+V26shtYn1d7Rz3ch/R6q1EbBQdgCBAqV7HFBa9P3WtBVCQXrZaY8D2N8
 KkdVHc6cQqGgiJz75LUG+YTofTyxiUf45gqd/yImXHSDMs5W1O6rScczMhqWG2YwhBCy
 bD1tqQeZLwG2Lsyopuw06t7nhak6zkz3U40Op98J6SsE52xuAED6qsXA1NtVdWjDePNf
 70K0bsit0sqkkIePX9dyqoGoswNITG9dF7bqR5Dyq/6X+EVS/74K9G7kNStA3r6/GxLf
 xXcc7Sbv8ikNGl7Xe8RndJYHaZ1LZ99lY2S6OclOwt3ayW/4lRIUliwFSncaQUgfa2IC
 W5ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLQcXOJcFbW1Pw3nKFAZnvJxzEz4p1Yws+ZTaNdOy2B8q5S51K5ptmWU5Ez1Yt7DkFtpjhieYGucW6@nongnu.org
X-Gm-Message-State: AOJu0YxF7nnB8tiexdV1XghcBBGAUHsWwelrQ+C17CEhcZnGiU16fnk0
 k6aJxO3OwcVZq+jOskUk8geloNQ16M8r2psj/GBTNe0EZq5D0Vix1VULijfobWU=
X-Google-Smtp-Source: AGHT+IHO2cCFrCDXc4Bw9OuMInatsFlh/vOwhuvD69EMSOxWSCLmlTU+6BRFjceg7GdA1V4Dvnaqrw==
X-Received: by 2002:a17:90b:2dcc:b0:2e2:e6bf:cd64 with SMTP id
 98e67ed59e1d1-2e9b16e66fcmr16226354a91.5.1731338838498; 
 Mon, 11 Nov 2024 07:27:18 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5fd17d8sm8764854a91.41.2024.11.11.07.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 07:27:17 -0800 (PST)
Message-ID: <e67eeffa-ce03-46cc-a413-cd6803d54632@linaro.org>
Date: Mon, 11 Nov 2024 07:27:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/riscv: Add new CSR fields for S{sn,mn,m}pm
 extensions as part of Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
 <20241108060116.37397-3-baturo.alexey@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241108060116.37397-3-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/7/24 22:01, baturo.alexey@gmail.com wrote:
> @@ -2424,6 +2433,12 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
>       uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +    if (env_archcpu(env)->cfg.ext_ssnpm &&
> +        riscv_cpu_mxl(env) == MXL_RV64 &&
> +        (get_field(val, SENVCFG_PMM) != PMM_FIELD_RESERVED)) {
> +        mask |= SENVCFG_PMM;
> +    }
>       RISCVException ret;
>   
>       ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);

Do not insert statements into the declarations at the start of the block.
Drop the unnecessary () around != (multiple instances).

> @@ -3525,6 +3546,15 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
>   static RISCVException write_hstatus(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
> +    uint64_t mask = (target_ulong)-1;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +    if (env_archcpu(env)->cfg.ext_ssnpm &&
> +        (riscv_cpu_mxl(env) == MXL_RV64) &&
> +        (get_field(val, HSTATUS_HUPMM) == PMM_FIELD_RESERVED)) {
> +        mask &= ~HSTATUS_HUPMM;
> +    }

Surely you'd not install HUPMM if ext_ssnpm is false?
Is this missing other extension checks?


> +    env->hstatus = (env->hstatus & ~mask) | (val & mask);
> +
>       env->hstatus = val;

Failure to remove previous assignment.


r~


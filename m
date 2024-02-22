Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6614C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 19:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdExe-0000L0-A2; Thu, 22 Feb 2024 14:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdExb-0000AJ-Du
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:42:23 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdExZ-0008BN-82
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:42:23 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dbf1fe91fcso42842685ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708630939; x=1709235739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a14YzswJfF0EVEHKLUWnJPofJa7eJqbabN6+JNQY+fU=;
 b=fI9lpwMk1jOLwFGNMxxk70hh5ssDSETHXHqPr7XvRcrJa63S7mqFyROnuEH1VW+xQO
 8ooIanYTC3lJIDw6gw5puUDzsbw6n7h8FdMZmYu+g6U47OWMIUQhkSWHFpYXlfk7PigW
 nzOydzE8BFCm8DlMMJD1VtyQ2Nhs2Ve913FDDN1dv3jEtSDSXSejj38HaxAKY2rxWSsZ
 lobdQE+AuNn2h+ra483JuUXwFhBoLDLqUAnXh50zrHl0XD2avBWOFm+fFeCXdeHuWRTA
 mn6ITJpYUqd1Uu9ANpSVEEtfKuORwGrTL2FvOJ5EQVvefGT8daKixM1XRgZJfkY1e/xP
 b8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708630939; x=1709235739;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a14YzswJfF0EVEHKLUWnJPofJa7eJqbabN6+JNQY+fU=;
 b=R/gJWBrWQttYtfUT0a3tdf1sOIwr8R0uSuCF41TmbPkzigVO/EFQuz/7u2deQ1VNA2
 HgKpQzT3wpLw9nI3aHDwssd1egY9aUoCYqriEFa2wAFAdgE5QPuFQAO2SiLJY/e8Gqsh
 /xdiHTaCpWwXup93eFhTaZ2AdBqNmI+Vg5nPn0WlO1mTetiqtatFWjiPmtrvb48TefMA
 puoWg7PQJ1gxDthrfWykv1h+Ka/hv25fkwDXwl65q0/jP1Ho+glx2CsM4HeHolR3lDGq
 7kPFmI6dpypC5tcAeKVH3oir/62QTR2hBvOKAiG7KKSTdiCl1Y7LwJ/iuCD7UFsTj0Gr
 H0+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEmJgCsEXzoGCC/iXMq964DS///k45pV1XwGxcfjUdw8b8QNQw0sEXQL16eLznkzHZp+MepcIN4OPZE3xGK1b8I2hCSTM=
X-Gm-Message-State: AOJu0YyxD0jZbcMWpgbi7WpbeefqWiLVN07Pm7KL2mNiMvaR9uVDdTwG
 802Fg4ymX85/z+0cb73iOwNJNR0eLxnaJpVYiwyU3ZRaDTTekVa3Z2F5PHGKHxg=
X-Google-Smtp-Source: AGHT+IHm1DFCPLE8zyNu5UL1ksxvAidrIzOEeiLxzbw0vJBZWUvReVUj4CNkHbIW2/7I01+C42WwXA==
X-Received: by 2002:a17:902:db06:b0:1db:8fd6:915e with SMTP id
 m6-20020a170902db0600b001db8fd6915emr10523752plx.33.1708630939286; 
 Thu, 22 Feb 2024 11:42:19 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001db70183611sm10248011plk.270.2024.02.22.11.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 11:42:18 -0800 (PST)
Message-ID: <7a8e193b-c266-4723-9dae-198a975d77f7@linaro.org>
Date: Thu, 22 Feb 2024 09:42:15 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/22] target/arm: Implement ALLINT MSR (immediate)
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-5-ruanjinjie@huawei.com>
 <9fb9c74e-e4d3-4a8b-b736-c8603414245c@linaro.org>
 <0911d6a4-7fd6-4d0f-83a8-ec4ba8420297@linaro.org>
In-Reply-To: <0911d6a4-7fd6-4d0f-83a8-ec4ba8420297@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/21/24 10:41, Richard Henderson wrote:
> Ho hum..  I just noticed that TALLINT only traps immediate write of 1, not also immediate 
> write of 0.  So one helper for both MSR Xt and MSR imm is not practical.

Quick follow up to say that means you can do

static bool trans_MSR_i_ALLINT(DisasContext *s, arg_i *a)
{
     if (!dc_isar_feature(aa64_nmi, s)
         || s->current_el == 0
         || (a->imm & ~1)) {
         return false;
     }
     if (!a->imm) {
         clear_pstate_bits(PSTATE_ALLINT);
     } else if (arm_dc_feature(s, ARM_FEATURE_EL2) && s->current_el == 1) {
         /* Use helper for runtime check against HCRX_EL2.TALLINT. */
         gen_helper_msr_set_allint_el1(tcg_env);
     } else {
         set_pstate_bits(PSTATE_ALLINT);
     }
     return true;
}

Generate inline bit ops whenever TALLINT does not apply.
This also means the helper need not check current_el, because we've already done it here.


r~


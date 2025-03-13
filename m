Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39577C35FF3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslih-0000mm-P6; Thu, 13 Mar 2025 12:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsliG-0000OI-2q
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:47:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsliA-0008J9-Rs
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:47:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-225b5448519so23285805ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741884428; x=1742489228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+XSzqBLq8bPQ3u3KOM4voyDRt6Rcp6KlTxGjBiVo0eQ=;
 b=Cxs6qjWyqj1e3nzy1WVPd6sy+5WXj+Uj2Eua4ug5f0lZaTDD+yaTpj2AK2h/ym2joo
 43F3j3kwkvtOEuaIrfcassAR3LdR2WFWR516v8zXB81yhbVes+5CW7FMOZ2Ytyh5WD2B
 r2ZKSRUwIr9feQ+je4x4kJgI8OiPC3kIsJ085khURBeWXxdRH5jRsns6+dWjbZngztth
 4KgIHq8zldePllpLZoculH6S5+wRH6GdgQni98es54dghHwXu6Q0aAhAIyEzJwjjjfOL
 nOSMuYtICA12iq2MzLaWgh+OIwWpP+6IQMqGWnF7qFLBsdVolEZfZFRhHxr2gnicUEk4
 cOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741884428; x=1742489228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+XSzqBLq8bPQ3u3KOM4voyDRt6Rcp6KlTxGjBiVo0eQ=;
 b=q8PABm7hvODegdYmTNiEXxhgAbngrUbIZuDcR8QdX44UlHEQcpR8BW100sSvojp/3k
 +4Igjd530S1tEWU9i/I0SGAVKDemXtkePfOVBclPohax2iI0PV+Wjym984m70OzVBzU7
 FeDLQ4Tw8jEkbFot3U9jA/im0JqbhAk1xNvNHXI2CEhQczAmA+B4fH/B1Sqq0D+SDdMM
 +wGjufrH2zrCy64lXjv6DqUpcBH0ZQcGh/OVIdB9NOSZIQU3IRaZMeCIaS9zvYEOxRqT
 4hR+OP/KOPWdIyPJyaWTY9xswAMZUikP0f2YMhT3ccqdw34MzBGXjd0jXwNwJCD4tolV
 umjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXztijATh93kG9lNa1b6J11+19T1l7LdV4Cz497g+9r4MmvZb8qimbVCnVvtIGItfCuI0BUru1dB8W5@nongnu.org
X-Gm-Message-State: AOJu0YwxTQxT3LNKzm33AToEvV9uoJUkeSiNL+lAQIGQbBCgBEN5bT5x
 brfvEw9bn/UU5pwDWQLElsEt7c+mT0yMsw7LhOEXuL/VevyO0QjJGjfdhYBZHFuBuR7REhGs5fz
 J
X-Gm-Gg: ASbGnctXU9F+Ocw3bKDVJFtAKME4G9X4h4zoFp5HSi9w5xzLZppxNsUMixWKhzySgcB
 ZHLWoTJ0Efhu4Skmtv+m8vw/bkxFr/tlmZ2w2OWxNbnThK3NJ9dKl1B0uS1G2onl3DIxWjpNPkr
 66eIAMGafA211lb/SpDv0XShcI6kIEEbHRQdM/QgBuWKTiUJfAC83qxovKOj1cg6TfsNcvCWd3h
 iv+Vmzfgt8cys/ZzkJbscp9Of36/sDa0LFrn4ZslLdf9LqExhoqE5ny1qo8+6CbLZZyNu2Z1ioy
 FGbBRDFf5X9mc4gZrjQx1y5DUdZ9o7SbJk8IYdLJ0KsOy2HC10eCEHFRjC3CuBGNZJou7Rbfobc
 mz5pmAkhK
X-Google-Smtp-Source: AGHT+IHc+qFvW+/witFXy6ElRqpDsbecky8LIJgV45wbNHix9VOmO5JNrZw3yY0Z/SFTTwnPgwTegw==
X-Received: by 2002:a05:6a00:990:b0:736:7960:981f with SMTP id
 d2e1a72fcca58-7371f0ecac3mr401620b3a.8.1741884428316; 
 Thu, 13 Mar 2025 09:47:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578dfesm1553300b3a.79.2025.03.13.09.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 09:47:08 -0700 (PDT)
Message-ID: <060c3a5f-0506-4678-a7f0-28f6e1e16d86@linaro.org>
Date: Thu, 13 Mar 2025 09:47:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] include/exec/memory: move devend functions to
 memory-internal.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250313163903.1738581-1-pierrick.bouvier@linaro.org>
 <20250313163903.1738581-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250313163903.1738581-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/13/25 09:39, Pierrick Bouvier wrote:
> Only system/physmem.c and system/memory.c use those functions, so we can
> move then to internal header.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory-internal.h | 19 +++++++++++++++++++
>   include/exec/memory.h          | 18 ------------------
>   2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


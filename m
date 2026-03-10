Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FEDFCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq1O-0006BL-Of; Tue, 10 Mar 2026 01:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzq1K-0006B6-Iu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:52:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzq1I-0005N3-F4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:52:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso19874545e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773121959; x=1773726759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5PlFoEV9CScvBhotNMSH+VG3/KVF2EiLj6VvdN0pJvY=;
 b=TkGpJMIZMU8e2TD74atvjiFuvmXchJIPaR1p+BHghA3TJVEbdbtsD2GckZmw6EnWU3
 Nt1W7ssLxLX4xnyLIvwYYBX2U9x1TkLvrOWf2zeKYVHBEaRmewyG5uc3qrQjtfi8C7iU
 YxsM8Uzhccec4XCA3wOzddhQIQaAkHI1rO5sqsL63B4a3umV3txFXZEQHDYGLqXmUkhe
 RLwYntNuN/QtACj48mm+BOhdMPufjdvomfvhAL3KMla8Akzv9eMvQHROJ/UzZIZYqu9I
 PA6K0eeKNDncYG6uqVu23hkb9Waz7cBra1Obd8HHHHfFcQPrnWkCG/RHXVgKEwNB9ljY
 3LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773121959; x=1773726759;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5PlFoEV9CScvBhotNMSH+VG3/KVF2EiLj6VvdN0pJvY=;
 b=vGtPcbnt0c7Km4VP88lIqerkdKsoEWf1cIxT368sqAqUD6sIqKyVg01LJJzdyAfaYN
 SZl9A3HSEqeBpgYDt3nUveRkg2vl426My93enIZeIqAQQruM1Tqo3bEMN5FTzP8FktUV
 oufyKpMjd18MjuCz9qKyi1PX9+JvVk7kxoZGv/g3oBohNdOlekLFAsQqATVfF+gLqEwF
 8R91HRm7kOFQllTY2rZWffIFIqvYO+onFcERE3LCwxYuFhiuEDW8/GeqPJoltQ4z0swd
 XMs/FhK2mLV3jJGZhZc8X2KFqSH1/IC9eEqqY0KAlKBEqbKXYclBybacVwuZRHOY7Yr0
 n5zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXktKrWauqHbyfigZs6ZA98EoYezM/fDG8KwHP46jbOw/XXWwFs/toW5pS4GGmnFtZjDEjZzCpF+JxT@nongnu.org
X-Gm-Message-State: AOJu0YzWPEjuGRr/k8oHsgozRCg8G6bui+WymqG7rF8QQzmvNVV1D4FO
 4LxvpuUT5s9jOdzueYhb8Rv3WyIScyyEygzxJFOEFranmvuLQxr1vjQ60REHond0/Y4=
X-Gm-Gg: ATEYQzypk1u25ndYg8LZP0PquJF/MTWOXEXonkeasy/RXOT9xOiuPXQ4v5D3Bc0Wmvq
 j2Yrg9bFpkjFZSP3b+2klnKxk+Xx+p0jZl4RXJfIq00/bd8Zlw8kXRCSU37BDsdf0TyLKeaMALP
 JuD3fzplPi9iB5WvJvZH26i1vI01lWEO5SbpJ449Hg7PKfvFlDrJFI5H2oVXth4q+sXJn7NGtvU
 1Ue+XSPN4qaFi9N7eEAsOOsrAmUKliS6IviloZwd1KcRp5EyUiBho399UeyAAdsaHJRNlAKW+Wi
 6LuAJWZ9EH//cGPR9lnx5Y0j3xq29qc0iOHGpvGxtF6y4DmacmCl/if+ZdDr6YmkAaG2LP9ZpVa
 mLDBgZU1qPtTF38oEOQ/bdYIpNmvKCP8ZmNsBfmFVVmypAMb+yjlbF81eN9ptIAQ9KTAKk8qw1l
 7UDg7CVmPPvPbLXQXwQ3OdGWThLVtr3ZkMdGUW2sffRSWJL79uNZKIykewHJLJA8YZfw==
X-Received: by 2002:a05:600c:138e:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-485419d759amr35361075e9.9.1773121958616; 
 Mon, 09 Mar 2026 22:52:38 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73easm46357405e9.3.2026.03.09.22.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 22:52:37 -0700 (PDT)
Message-ID: <3b96d438-962b-479c-9eed-15359343c54f@linaro.org>
Date: Tue, 10 Mar 2026 06:52:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] tcg: Improve extract and deposit code gen
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 3/3/26 02:08, Richard Henderson wrote:

> Paolo Bonzini (2):
>    tcg: Add tcg_op_imm_match
>    tcg: target-dependent lowering of extract to shr/and
> 
> Richard Henderson (5):
>    tcg: Drop extract+shl expansions in tcg_gen_deposit_z_*
>    tcg/optimize: Lower unsupported deposit during optimize
>    tcg/optimize: Lower unsupported extract2 during optimize
>    tcg: Expand missing rotri with extract2
>    tcg/optimize: possibly expand deposit into zero with shifts

Series queued, thanks.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718F0D3B99E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 22:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT6Pa-0003Bx-5i; Tue, 09 Dec 2025 17:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vT6PY-0003Bg-O6
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 17:42:24 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vT6PX-0007vB-1y
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 17:42:24 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c77ed036c3so216077a34.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 14:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765320141; x=1765924941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AyZo4JaNoHslfVnSaXQlL4UcQtpZDbIKq9lZLs8gO8=;
 b=ITuMVCxtqjhFOKZ8sNmG5rCD4OkBL4fwNUr723MlaHbv6C+6K95O/SSH+gqIs4TrDD
 Knlovh+2RrffN3gW/slgAixVVHdwGVDKhiFDuxw2QkVYEHHOTeiJWdGlO2qirOwxvdaT
 LHar9hQ9p2uimU2MeIE9wEZjKkarmefvE1y9iNPSvi9XHiaEdspg6tuHy+upfo5D//cy
 GNtYaku0lDTrjVePascvTYcsP39mPxUqszawJ+oMhYlrXPCht+z73zjdXFkdZCeCfaqh
 8UCPUDtXioEWEKcN7ellGx9zciVd1hRngcjZ2qZyIdU4Zc2SOvnUb17Z/xX25cMUpsb1
 URKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765320141; x=1765924941;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+AyZo4JaNoHslfVnSaXQlL4UcQtpZDbIKq9lZLs8gO8=;
 b=EPr98mZd8xibyPbQQLgponaT4yP3Fgd6nMgNCfqI7wF/Woj2/5HIYSPYKIPBRCb7X0
 QOSujTGwxrNXzHOGojXeBYwoI33RxGD7pfh9piYeK2OjlFi/FL96xFEimgFiDflYKwbE
 9wKNp6J4W3X6DRN1FTl+JepiUjIJ3OehpHnbeS2YvRB580CDEESRqgEtPvvB45/GyLlQ
 hJ54huZJKKCMdqsiFBGBjHvUE4WdUR2dbs8H8f9vfaUymURT7cNY4qy3htP8I+wImTyd
 Sn/ILWU8N09tEoF+P21y0uGKjdwFeshtZB7TExhVG1MofoAsNjGpJVyQvsIAh7XC/Lt8
 cdJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0EUIPw0F6VmZv5DMAY3BjpR1D1gaWUUtroRw04SZBvNTXUMyvuwpR78c3wN9BgOjsDkFE4ycvtrC7@nongnu.org
X-Gm-Message-State: AOJu0Yx+CsXsEsNozn2mRfGw3npsztPHVp06ZZDQvUEwmpsS/+oZ62Yw
 IkCyi7J9h2sqm7L+rZNNOmVxkC8I5TaOxvTSGBopA1vm1qiBg03m9RSqLLWAVQRdxhs=
X-Gm-Gg: ASbGncsfImHGqdH5BDWtDmAmxwGsk308Y6kPQ/YsKrx93xVyiLteppznRDLBD2SKsAP
 +ZgI9QNsDvvRYgfsTT2OTnI6tHDaAs3+3Ul986amQYbcZJJ6NydsZnJ0SGByMP0MmhugmauMdTD
 yiHk8TLsdSxP8wyEPL4g4jNkHiSkV8+lMoEgtsBYmd2x7eLzUCUk3mRyfTvKXRGiuYdXpilQ6ba
 8nG05LfttItnHULQO+KUx/qZdnIgQRbxt5QKgV9vhr9YY8/Xk8mRzhkZgG8LwNgTzR8BxIp+bcZ
 436B8cAjBRPOQZfBKnucIJWhijfNmK11KV3G0N95YJ7BaNm+dglI81k6A/lTuH7pT2TxYlWrKVX
 9eGXMVnLGWJrbtejpju3ysnYA3887F3Xub8MNzTzDQqKwe/3jNfsko6RMV+MXXe6gQc+GKoeDKR
 PYKAIjkFI/5bBL67PeM49U+W29q/RjhsU5+m7kVNXLmIX6iznCcGM=
X-Google-Smtp-Source: AGHT+IEL5T7/fXziOKOSWCa1LAz3tJ76taKamNUSsDZXUpxXNooqzPzfkGyn1tl9UDeHlpD1Qli6kQ==
X-Received: by 2002:a05:6820:1628:b0:659:9a49:8ed7 with SMTP id
 006d021491bc7-65b2b09ebd0mr212769eaf.11.1765320141220; 
 Tue, 09 Dec 2025 14:42:21 -0800 (PST)
Received: from [10.152.62.227] ([172.58.182.152])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ec25ed1sm8791316eaf.1.2025.12.09.14.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 14:42:20 -0800 (PST)
Message-ID: <3adbbf9b-e13e-471f-8ffb-d1cfcced0d8d@linaro.org>
Date: Tue, 9 Dec 2025 16:42:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Misc HW patches for 2025-12-09
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251209200537.84097-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 12/9/25 14:05, Philippe Mathieu-Daudé wrote:
> The following changes since commit 2257f52a97f28ce3be4366817ea8817ad866562b:
> 
>    Merge tag 'pull-10.2-final-fixes-051225-2' ofhttps://gitlab.com/stsquad/qemu into staging (2025-12-05 12:38:37 -0600)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251209
> 
> for you to fetch changes up to efd6b3d1768d04d5491b62ad7385f623fb12f627:
> 
>    Revert "hw/net/virtio-net: make VirtIONet.vlans an array instead of a pointer" (2025-12-09 21:00:15 +0100)
> 
> ----------------------------------------------------------------
> Misc HW / migration / typo fixes


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


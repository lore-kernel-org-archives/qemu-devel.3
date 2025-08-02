Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB28CC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLlJ-0000Bk-88; Sat, 02 Aug 2025 19:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLlD-0008Ht-Ab
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:35:31 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLlB-0005dU-G1
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:35:31 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-61998205433so136394eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177728; x=1754782528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5XTpRLabasFGIFX0ncth0L9jgGIA/Ho4PN64mD2Jcm8=;
 b=biyjLhVd/qFZZ1PfLJ0xES8tg2UPNeWMKrMAuMP+fN58KCKXhqL0gUemV23geFqdTA
 VS2yi7jBtr2eemXzDuYz4Ao7aXb9yx6OjM9L6wm5z9fg8xXDS272/eUZN8StBnJO1djO
 wDfWS86XThjk5ynNWFJT2uaW8RLDKhjr/HUhoAZLSGGtOxiCH8bE/6Zr893srb+ipDpk
 H4mBA/DO47SCMc/+96bnzHvdzxiV1KzzXXE6w5c0MbQnEPGqz4u6j6tHIZMQaDHuTQvv
 FsDIN+90Lt5RJQMLHb9GnmVdyu8MqIfTRMnizUbxUcznFODqdGhBGjtvCl9KgJc36FTz
 STQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177728; x=1754782528;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5XTpRLabasFGIFX0ncth0L9jgGIA/Ho4PN64mD2Jcm8=;
 b=BRWPehEw2z42S1PuXvdgguEuKpFhsQ0/ZDSrH6CBB26sjsrxXfifnBhmr2aMHZqYxt
 CVVLS61++VN2g6DvrO/WmCiLf2KGnP3ww505wZqJsplS3N8xlGeaLtUTYbxjiiJ7qE5f
 15LKkKazegMan//fD3Ndyn4qgmH4OdMzb7dMooILOv+YE7lnzlOdcdaXDI50oOPO4dJ+
 +lhsF9MIulq0Z7FpG2V1PxlJ5jSkEQsHXJSBL0CtO33qhjASLt3mJRijRD4IddRTtl9R
 T4mvR4XacwJ/ieVifbphDZ+zlU/QH09CIG67L+2kgWM8BcdqjebKMyFyWGOfSBIg945u
 ElJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDJvuxIENpFKXVJKQsYeelSP42tmyA4n/K/scp6MFRyk77dxU4grx+uONkvhi528DuFqbL4ovCcKX5@nongnu.org
X-Gm-Message-State: AOJu0YxU8DSElEVLtpNXGigYWwuEvfcF4Rz2RqxFr8rjNB70vcDPhE+k
 oOQ6sUW6q8iENMoFA3X/noV1uro2N98MQdoma9/mxARyQZxsjjT0IVc959SlxmReNRM=
X-Gm-Gg: ASbGncseXQkF+7/+v79sO0jgSsC8Kohf1a9rnqQCr8C6zMUABFYXrBTKwhhXjK8IM2C
 uqSHqEPpoBasRvcT9M2rfCLNrDBkYOKyCX1EGHOGt5jrEYUiwyuCQRymlKZ0Q+7/gs0oqJOP7KS
 NwSpzQwvNN+RwlrqTqWXQEO3C31qbQ64O8xYvokWPv3V0dPoCLRNs/WQerCBf9kZrdWAchGUQMe
 s2AuAllZLR1OxQ0/Gi95BJCeBTuPkXTRAkbFl5i8qmEeDZi0HsE+uWkqyv8IIas9PHw5F+4hkt9
 K2b9HZ2AG/olm3POmLqI+NU4WrggrHkIeoHsJY75xNWLhIE/deGAI4eKPNFbh9VjDF8qY8a1bN0
 CWvMZueFAWCL3IbOekIcaW9ZvGM2AdWW1SUHSmr8N4zC+Qtv/RuUmTghAA8S9qyjO
X-Google-Smtp-Source: AGHT+IHrXZv2S0toFcObVwLoDDCHgP3u3zz6UnLINerYEHkTo4rPuceXuYxdG5I3KohP3eaEQwhwDQ==
X-Received: by 2002:a05:6871:7a16:b0:29e:5de2:cffb with SMTP id
 586e51a60fabf-30b6768d4fbmr2578002fac.17.1754177728286; 
 Sat, 02 Aug 2025 16:35:28 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a748b451sm1725618fac.38.2025.08.02.16.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 16:35:27 -0700 (PDT)
Message-ID: <5b0c0d73-5da7-476b-b297-ea6642c5af92@linaro.org>
Date: Sun, 3 Aug 2025 09:35:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] semihosting/syscalls: compile once in system and
 per target for user mode
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
 <20250801232609.2744557-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250801232609.2744557-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 8/2/25 09:25, Pierrick Bouvier wrote:
> We replace target_ulong mechanically by uint64_t.
> We can't compile (easily) this code once for user, as it relies on
> various target/function types, so leave it in specific_ss for user mode.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/semihosting/syscalls.h | 30 ++++++------
>   semihosting/arm-compat-semi.c  |  1 +
>   semihosting/syscalls.c         | 89 +++++++++++++++++-----------------
>   semihosting/meson.build        |  4 +-
>   4 files changed, 63 insertions(+), 61 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for the syscalls.h changes.
Other addresses can be cleaned to vaddr later.


r~


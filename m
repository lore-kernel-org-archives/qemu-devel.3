Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD56E88D73
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 00:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8pCe-0005It-0b; Fri, 03 Apr 2026 20:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8pCU-0005Ah-RL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 20:49:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8pCS-0002NK-Hx
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 20:49:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so16332845ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775263759; x=1775868559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EbJI6zW/sRL1mS2mAsDa4rvCIFEIK142ElrJa537/58=;
 b=IClaUCcGg17Ng6YLnyvtm04flxflELGcBTkB45VApT5njYvM8Is+T0/f4aTHEHHywA
 2ICx19G1OdSfpjcaAz+ijslj7SAYsdRh69C7rnnv6PqYpdq38seLoM/VaCL3zuQI0wGu
 nO7PVn1ylztrltVSeYg+XQSpTZc7H9myWt8XPY+GTACpyEx1EjmRLlks1u5uRx88eAv5
 1NzLLppBaLAUxt8qiW3Qo1dofjSzXKAliad2tOwz0WfAna0Uk5jgPYacxmw5NFm8w2sT
 BYmIH5H9JMJz06Z1YIr7dxW3iFEKok+Xg/C24LvkQnFEdA0iXIbuY9Kwu9yFelOPkZU5
 WQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775263759; x=1775868559;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbJI6zW/sRL1mS2mAsDa4rvCIFEIK142ElrJa537/58=;
 b=a5vCI1MLn2Ck7DEu9gUHW14aw96GSY967gjvIwMnJ4zy1WsV7YmYjHOFgudwywv+c5
 cBhWzne9QZoDIW7ocdxx4zpdb0EyI7M70Il2X65/I5Jr7QNeaLNkTtpZG/ODzdnnANvR
 kS9ANwWpVsQ2SVvpkyZOJtUBWbb4tbXjLPuhsDP5LNKbRkt8/v3ia3ZEuf/e3AbhnLLv
 KnqwOvlDjzjZ9TUHCs3ICxUsGVhl08nibAMoQ8IzXvwNkpNab5Z3bwcWrxtjRQsrjs8W
 PA7Np+UQruPhbkwa6b/kiwlV3meETZR6fH58IPYGLAyaX3s/FhHZazAPgGbHSpDN9kM4
 2H/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbw/+HjPkynei60pd5EkvQt6MbDBbzSlwBaTaZSWqGkrCxGzNU98yZJs1S0KoG72fMeXUAybsedHU+@nongnu.org
X-Gm-Message-State: AOJu0YwEwtDWQlwgE02ZmlrSo71Vuqm4lWW40p96PSHAQY4dnlLglXKP
 qBp4pIxD7HcTUN4YpDTrqk0vlaGxlrbp0xW0jg47RxWn5BZMU0Jl7N3QQiR8byvcEYSBMn3OU10
 6NozxHQA=
X-Gm-Gg: AeBDietLKzujsbxYHY3BxxKWc0ZWk9gvl9l7xUhFludKtkHnP0bh+nYfvkiUXqnbXnz
 nGFg9m7l64UvksM5sPPtioijRsThuyXkbMPcEK3rZojdYv93eEvIfA/xdmSkCRBAC5KEZhQzR+e
 3Rm/XvZ1st8g/CVzhUhxBu4utA9GNjX4ChRWfouhIAQ/+CBfcKHgEGPeHcFDfhd+XwzOtkA25Kx
 DMsVWmYR4osQhlItq0VPIRBYiwZCNNf0LLw8p55zYGmTix7bI4FvSgDfeGdNMM7kdPL0ljyiEul
 pPMC5zetzgb72he2D4Cz9MXPtxcQ4upkAXE4Zn68g/LE3PYSxlBa/b+7eRkCcAJP3Bj3KReNCLO
 ItlsaJ3X1Uok/OE0aYp4wGykZvUX80/bnggCWJcUAKKyZ8grAWNOEbSfyHEHlRK/A4qVI+pTaE1
 XceaAsMyEdlVd16TZ8hdU/KHBx9RG8IT5Z4571ywf/Tjfl1GgZQKBXiuHWaF2xEQGPJ20=
X-Received: by 2002:a17:903:287:b0:2b0:c2d9:270a with SMTP id
 d9443c01a7336-2b28198d6e9mr44702315ad.42.1775263758846; 
 Fri, 03 Apr 2026 17:49:18 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478b658sm73420175ad.31.2026.04.03.17.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 17:49:18 -0700 (PDT)
Message-ID: <5a6f0a78-85aa-4d80-9dc2-4a58100bf6ba@linaro.org>
Date: Sat, 4 Apr 2026 10:49:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] alpha: Define Typhoon instance_init
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-2-yodel.eldar@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401170454.32045-2-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/2/26 03:04, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/alpha_sys.h |  4 +++-
>   hw/alpha/dp264.c     |  8 +++++++-
>   hw/alpha/typhoon.c   | 24 ++++++++++++------------
>   3 files changed, 22 insertions(+), 14 deletions(-)

This is doing more than one thing.

The subject says adding typhoon_pcihost_instance_init, but that would just be moving two 
lines out of typhoon_init.

Creating the typhoon object in clipper_init is a different change, and I don't see how 
that's even helpful at this stage, since typhoon_obj is not used in clipper_init.


r~


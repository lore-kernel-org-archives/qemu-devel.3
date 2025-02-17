Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95111C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvpq-0004Jt-K6; Mon, 17 Feb 2025 02:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvpo-0004Jk-IH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:46:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvpl-0006LB-9s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:46:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4396d2e32b7so13264635e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778387; x=1740383187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0yQYzWLU4PNYJ3usd8Fx0oFEU5s3IzrbPh8uhOyi8rY=;
 b=Ak+mpZ2OhGEqAwMlUxgSwFeZPkSYyypu44zT8+s+hADUcHICqUjkPVmJ6/7yqWoEEJ
 WQ/FUfNItI8SaEP3TFFmL1TUUIhKm+TC9goQVY203j0MUoJKOFPI0np+bZwtc1LWP53z
 8DdZP7DEDicXoTxUcdkm1Nq4r8Lt0UD1hIQSzYObyJxtnMfZIQN8WswjpCqKl1EmiGK3
 vSgkHPrNdbnYqnpbx/Hm/eHJwSB9xK7IBbgt7/Iwc730GhrhVeirRYnPUnesGu26cjCW
 Sq4WCgEfvANynzi5R1kWQJz5Ky2gbW6Kbg2QhOSMJK3Y6BEpgeaTgNTXXunr/EmHluhZ
 JwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778387; x=1740383187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0yQYzWLU4PNYJ3usd8Fx0oFEU5s3IzrbPh8uhOyi8rY=;
 b=oEfAeDnqb37dpkQow8SSCeVmXDvipLrH6aXbKn1hjLu7K3bp4jsSNKx8D5OrgF0HhN
 5UVG24fUMFjraeFPA97LrEwrCkQPgxnnHHQ5ytNEFh/gMrLBoMUXiGU96QlXB6p5tuA8
 P9LLhESvnytmS7rd1A6eUJ9JaqESbwu22AEjKnXsh9N4WJ5632C8XA12dOXISAPx6xJr
 XfsqqB+mZ14uMokAOBxtsqkdfBZzMIaAeq+GCccKO0rLHnoCirJUFX3j9sG6cb4r4E8K
 yObwSSwCgFcOkkWXuBkjk2pX4WqVsB8Hk4gcy36fcnkEYZB5Zzwdxiz5/jjGZGZ061OG
 RHRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXluE98bBdeqbtGC5VVgZhtXnSa5+y0pQbkCQuN3/oGGC/mFsZwkE+eP0HLW9ORLTOOo6c8wXmli6Xv@nongnu.org
X-Gm-Message-State: AOJu0Yz15Vtpzj0+ZqI+tbBnqD0iDVS1/KoihZFXyAT361CmeUd5w2PX
 Epm03pJp7ouPxYramB51u7H2lqQrIiui2y+zMUeXuT9pqVJzQUwVcdwUIKOpywMqewdhLqZWZ4L
 l
X-Gm-Gg: ASbGnctcfMaSW8ziXvTEUtYKAyY2bFAfrZn8ZNUdZiB1rgtVKmbehCamHTnPPPfowU6
 nRl37SsASO31EtAGA/cV5CXa0rnxyjCZcleXtHQdOoiOAmLZht8qyoYYXBdQMg23RXZyWgvWjMx
 Ah8xSuv2wuINOzntfl/eNcU8DPrB6k4hjMUGsWkKOuBZjgbSGWnxMYx7oBjZcnIbJJXozNhSS1k
 bVU5tsPWm4iHBy3kgHim7M9r7PexzmNdvui6HoqKwdVPDwNyAGw7XyCk8V7PSdjb62EM3akRW8i
 u4wKpJaZzYe7IUVammrMx9SMF7t1jCjoCfs=
X-Google-Smtp-Source: AGHT+IHO7So/gZKLo+T3QAclW9SiWMzUG7NYXzElgey1vNB6jVEHi093IYyLLQlTc31Tex6AGGfIpg==
X-Received: by 2002:a05:600c:19d0:b0:439:66ba:bc07 with SMTP id
 5b1f17b1804b1-4396e5bae17mr98705585e9.0.1739778387586; 
 Sun, 16 Feb 2025 23:46:27 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee48sm145297765e9.3.2025.02.16.23.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:46:27 -0800 (PST)
Message-ID: <df2635bc-392d-4ddb-b742-fbbe7ded8ec0@linaro.org>
Date: Mon, 17 Feb 2025 08:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 039/162] tcg: Merge INDEX_op_mulsh_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-40-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h  |  3 +--
>   tcg/optimize.c         | 10 +++++-----
>   tcg/tcg-op.c           |  8 ++++----
>   tcg/tcg.c              | 14 ++++----------
>   docs/devel/tcg-ops.rst |  2 +-
>   5 files changed, 15 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



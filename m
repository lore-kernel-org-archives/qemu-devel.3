Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58570C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizwK-0006F0-OJ; Mon, 04 Aug 2025 14:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyBc-0003SX-4H
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:37:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyBa-0004mI-Bw
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:37:19 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76bd7676e60so2484181b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754325437; x=1754930237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7mXhA60e2cN9jRzAk2ZGqZKGqdjjwRs6sAuI6h0mwTg=;
 b=XKFafKUjqWq5I1tmaHuR90YLaXFT/MCROa4KG6sBHfmRGrts/Tj2b3cO1taJslLZXk
 c3F59EeT+zJ0pJJJi53ZkML5aKUtxQ1M+r3E9u8NOFVppTqkSYPounp3Ddm06sQw0NV9
 GqdbtY+rHbt3ETKL7oe6D7mQOmIrWAnJhjzzculVC8IQqHUTmRA3xBEu0oXCBAhC/Wui
 tQdReVsvT7jfGZ2Pg276hmKE9OeFNlvsymaX99wUDhuaYEUYYcewbC72PzJsA2JACoG8
 4ZA0NoSmXFVtW9JItO4e4SUepUPGOlJqXPxBy3QHihY24T54ZiBkpGfAbE6xUR4hjQf/
 B+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325437; x=1754930237;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7mXhA60e2cN9jRzAk2ZGqZKGqdjjwRs6sAuI6h0mwTg=;
 b=XsZsOvOu8x47JVnRtfosFcUDL70xZq4JpptC1tszGQFFBE5EnRPT9/EiwX7KpXiTZ5
 8LtjD/GHOghUSGyJS+vGxfG/kzdGFNtW347v9JGByxWsOevmO6tPVDy12GDohFRf/CYu
 bAWnfLtPF7MCXmM73KFLEX2inJsHrm9X6mvlFN+WFoaAxqiP0Zn4BJebTdneF0y93KRU
 WO6L7V7VJ4baWatZ3dYTjFqwYHvDVX/nFX2u9xu9WJkl31PUxyA6ERp/JdAg+ZZKYN2u
 Idcb6eF4SqnFchUVbt5mPmELjabohHhQgoKTI0z1DeJrJH4SoRzrtX07bil5PUQE+qGM
 w5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0e/aOovC9hXSSL35OeqEQ/pz0kydK/RmgTFOiWEz/mN+y4X1pACeksg5HomtsciVYrKBwf6Utxhic@nongnu.org
X-Gm-Message-State: AOJu0Yz3oae6KZEt+S+n8i4MSRpcCrsTYckyCTCLQZo1+3y2FCNo+jaq
 BqErCVYIuQHrfcy7ljPAoXtZu5iKRyJHT2rjxGjQUouRM1BjPg1Tiwk0kTo5tkQDZo8=
X-Gm-Gg: ASbGncublbVQpmJ4y/TVNPLih0+1wfvkXVi5o4/mw5xdemw9ZUhX3J+BvG6SvnZfTfN
 TZAflFkFPJYwXJPQl5FtJrf3EmlVBngr+WYNTjRWQL498re1DKxIXKDip+LqPgrfkkdS7ZO61p0
 p41neFEn6QI7eW+UXx/xjT6ALKm5md+6Ux5hRU4YHWToaFdslqr+pHpnLIDX/WZL1MZYdt9n5Rl
 2OnceF50nU/wG98WlaihAEy1Qe8LaGLBdkyrEMPcpnHiL1V6mwtpKA73YZu+hb3UmuI2afwqhfk
 qFnpwfKtMEvgXC4u9LRY+WrRnXl9IS3Y+am+AXOAfdeLe3Nkw6l3QesyFAJuYB+vEb/dNpm1P/f
 Jt+D+641QXDFcawK4w3ObQKVqyfrkY6FCvkU=
X-Google-Smtp-Source: AGHT+IEbN303v1qTZb4v81O8W+8ShCzf4yl9fOxuQdYSBgoncbOhM3OjJvF2LDLmMs6LUjl/I3LMEg==
X-Received: by 2002:a05:6a20:3d83:b0:240:17d2:c004 with SMTP id
 adf61e73a8af0-24017d2c357mr3272955637.43.1754325436477; 
 Mon, 04 Aug 2025 09:37:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76be718b2d6sm7151170b3a.56.2025.08.04.09.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:37:16 -0700 (PDT)
Message-ID: <e433820a-25f8-498d-801a-b451a22f682a@linaro.org>
Date: Mon, 4 Aug 2025 09:37:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <cc6f1489159379da7f259f3cfd77e6ded89aeba1.1754310749.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cc6f1489159379da7f259f3cfd77e6ded89aeba1.1754310749.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/4/25 5:57 AM, Kohei Tokunaga wrote:
> This commit fixes Dockerfile of the wasm build to support both of wasm32 and
> wasm64 build. Dockerfile takes the following build arguments and use these
> values for building dependencies.
> 
> - TARGET_CPU: target wasm arch (wasm32 or wasm64)
> - WASM64_MEMORY64: target -sMEMORY64 mode (1 or 2)
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   MAINTAINERS                                   |  2 +-
>   ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
>   2 files changed, 23 insertions(+), 8 deletions(-)
>   rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



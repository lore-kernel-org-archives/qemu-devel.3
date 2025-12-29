Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB73E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3qv-0000v3-Cv; Sun, 28 Dec 2025 22:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3qq-0000uv-Nx
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:23:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3qp-0005qc-Dj
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:23:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso110836005ad.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978598; x=1767583398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQwv/1oqRvt5dweiAQNYu7Wt5brMpd4tGkRr1Ku2cVA=;
 b=PtN5u9yvohU13ZvGYlYx5zlvmHbhDwQeS+AbXeRj8qPNFw2FgSJ268hBXn5jsd2ilC
 d7Fai4MUNdIhR1A9wnfhlzEwyyuOPF/kws+Bgwsk8JUMFMJCaf4OUH8FnQAUjW1tTNXT
 WAZ/xQ5hpud3in3MUwEWufGLr1sDKOMwsAUbD3NmI2N009nht6IChbhXATNgnyYi+tyY
 7JEXftQz//bQgwzQuIZwMoy9Tm48ot2m+HtMp42UOQ2dYqKmw67L1NwTTjzdvK7aHYQQ
 Cwp4GSWcu3U7aY/M1dITm8Ig7HtU53kZp2nbzbEFQ7/ZITrfsuos+bo9WgI3mnq12Dfs
 CECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978598; x=1767583398;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQwv/1oqRvt5dweiAQNYu7Wt5brMpd4tGkRr1Ku2cVA=;
 b=FkhFggUBzNoqCJ5W/fhfwBktvzqt+zrRv2YM2UbNb9Y3+d/43Cv/aWW8QlzJ+rsTE7
 nNIg3k4hn5EwtNirwsa6eEcFJmNqDRh+kkih9rSsZL6xcC1SX0usgZFTwccnXKuiOBKa
 0rqKSf+DElzx/q/0E8XKpJ0qPTGgdsoa/4SzxCWxXrZ5t+GaXqZ2/cUsoUVCSc+k4Lpy
 Kt6O0IWhAAxq3WlB8nnqTmjQvQtqCWg/uY/YfeexuoSyUf+IKN2vXZWABVnJiVq8iXGY
 EozteViXfekCL4artbSjMf92r6hqMVPakAjNaWFjDjGZWu+Iz0wZNuEdO9tpmJOnXJuA
 nqVQ==
X-Gm-Message-State: AOJu0Yz4xZiMq5JKeDvtPmC8/tCY1wX188UShYxFdyII2S1e92fQ1/Gg
 BFdxJghp0Df19yKGwHDzXmImhzb027pw22bTy9WsKpl6zv4xBnrYU9EYGhZGYS1+xL0bSIvhT78
 am4pxnSk=
X-Gm-Gg: AY/fxX6zGV1k4AAiaDG4ITZ6pptB0GM8DSV5uQ2W8m2+9PFPDghFTo97BQOslHSHPus
 akAJVIdtVmo91ELcPLtMhYG2CHvh6sR30c9o5L+6cOmBS5YothPvIYcE+G/0MsfMkza8h63d15+
 mWmMMkd9oPcsu8OZJmi8fLt8/8CrDnXgWgqVoSn5VxU64n3ebJ3xdN/RnAlvMtg31ZtqbOkTwtg
 ym+1/LuG3q4HUzoe9YwpMO17gbxA0jBkwoDIB3seVfyQJg9Ts4jtKMH45fuerbZtXrAXgPtaBLj
 xokTmMVOT+6hMFziQxkTwdb34hhUYvtrZLkEDqcfsohmfPDsWh5YulyLELCsjrvxx+FlS2wVX3v
 f1R92INTQEq4zI2Zb7nBvd1rO6sPpWVb2EdGe6EHj1bPnT1RIUeNJAu0LEKS/tX5xSmURAiYaQP
 usKpE8wlw2krlvCkgMSL/JsqgPE7QMNCTv5i6y9VrrVhqBZVaKclJcBC15Z3Pdbwx+Ndsa8A==
X-Google-Smtp-Source: AGHT+IEokxuhNFs5iW4kOcCd/j+vBwp65eqMYrEeqvgUy3QshSX5lkkyGoCIjYsZpd8uXZg8NEVg/g==
X-Received: by 2002:a17:902:e950:b0:29e:a615:f509 with SMTP id
 d9443c01a7336-2a2f2426e77mr252070555ad.17.1766978598045; 
 Sun, 28 Dec 2025 19:23:18 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c8d10esm254685355ad.42.2025.12.28.19.23.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:23:17 -0800 (PST)
Message-ID: <1ad3b9aa-2b60-47d7-a307-11c474aa942d@linaro.org>
Date: Mon, 29 Dec 2025 14:23:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] hw/virtio: Reduce virtio_lduw/stw_phys_cached() scope
To: qemu-devel@nongnu.org
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224151351.86733-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/25/25 02:13, Philippe Mathieu-Daudé wrote:
> virtio_lduw_phys_cached() and virtio_stw_phys_cached() are
> only used within hw/virtio/virtio.c: reduce their scope by
> moving their definitions there.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 21 ---------------------
>   hw/virtio/virtio.c                | 21 +++++++++++++++++++++
>   2 files changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


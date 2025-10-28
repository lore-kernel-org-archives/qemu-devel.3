Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0CACCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiyO-0000LL-Op; Tue, 28 Oct 2025 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiyM-0000Kv-9L
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:38:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiyG-0005iV-NU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:38:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475dc6029b6so31613965e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761655117; x=1762259917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hm1uqPXDRRIRXg64gln/GpSOapuZJZVYX9Z9cGadBYs=;
 b=r0q/XdVkBCXssWLK48PvoCKXgIYn39CMQm8EWdSyrKU8X9vcaCFqMHJxMVSTWp+l1q
 oEpXEEqqxG5TbSdfuSm46t5pv1ov9FjH7elAeG2swOjDmWdBzvNJeY1N9nnR5s0gELC+
 R9y7q3LQKN87seUfUIftgX2fdSg8COdc8yxowGznGUHbvVcJkcYPp3znp1bLwk/ua8Tr
 eTsm7k8LyJw0U2QuMTGrUfUVPjU+0c/j+IGmMaEb8wJWBiUzjM+N1HnAIYBdBx1fcPb8
 +E6X69jtnmh2zwww7o2hZ8NmAXoAFR0mDqNKWrViA5bs/G3OsGRTDrdB37NWMbyeN/DE
 M2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761655117; x=1762259917;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hm1uqPXDRRIRXg64gln/GpSOapuZJZVYX9Z9cGadBYs=;
 b=Jsf4oP016ts+ea0EvwyBWpj28REJ/eKsvvh2VQDaWtBjpWLA74020nhbeDbTa1ky2j
 8r2O3LCSq3ymIdzgjHdzk+/PcG2T+EQsfx6AXBE8B/Q+XEDbm21MxXG53VWG1KGy/BZY
 0uQrnlfu6mxXhWS1RZfcYFp5wbpg4FRareY/vbDJuZ4KJvV4mbgPT9VvgVk7VxYxAVYQ
 3jBuI8d24en3cwcKFoD9ELE+Xk9yoNEFowbjhcvH6g1d/q2zBCbD+0gXgWSTpmAT48vs
 6YWwY9V646Y96aE+y+5MVc8GhEvg5Tal5OC6QCR0JLQ561Q7JtIz0zDIBEapWcSScfMY
 eC7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGuEUUEC1lD62bzFxORlRjbPxvOuqlyGHh95bTHtMgHiMiKxfqimW2B9KDwS5+6fla5F6t8zeNj87F@nongnu.org
X-Gm-Message-State: AOJu0YwtA+zdx+SfWb6gRmG+Oi9jQ+Nb63l/u7qiE9vbdyblY2H5WX8v
 k3C5OHqpYVtAvNKZ3lLKsqjlLLW11qQ1SkzbOU1TV5KtKAd1t4VN+85MVJtkLf4tNCE=
X-Gm-Gg: ASbGncs9+X6qNZJgIOdYGfB/Quapf13Ra/OCVV7TfJm1B2Hku/Rue+nxbsVSLM2egLl
 JoH3zI+46HK/+Jb11Qyyt9wPq/GAC/VZ6YKAHs5ZiJlOMi0ibv4D2PzTFg93Bv/MuIR0qin8KaO
 vAbHHEE90bC97UAtsF5T4K8MkrWOTPtSKHNtGHlQ2waY07piyzR28fYowd3F3gZ5l793L3BOCo+
 ImMkA4mK+DrRBuwvBftZkAb7FjNDfUN4CHbWPtmKCfvv32caoaJ96pLKARuzyz55EIT7p24GLO8
 8ZIGeXGsIbB7M3PNREeOUZhJUfIArR+yrRqbKi47/POhGhML/yvuDdolk5+8vm1ErVweHhmLXmr
 fDftRn57A31DcpaYNM9Tc9nCUJ5axEqBzEwFaleWxtwWCzYAljOPtS7FEsosVU358jIvNOIOhPy
 MVmnjdY56PzVRP8+ubS6ITAWG68QM=
X-Google-Smtp-Source: AGHT+IG0Gt4kn4xrlWfGfvTs1RB3ifL9cgRNkA5WuS9e5kR4K3buNKBr/INlMgEmxKp2HRVpOikKSg==
X-Received: by 2002:a05:600c:45c7:b0:476:57b4:72b6 with SMTP id
 5b1f17b1804b1-47717df8103mr34347285e9.8.1761655117221; 
 Tue, 28 Oct 2025 05:38:37 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd37467esm203770765e9.10.2025.10.28.05.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:38:36 -0700 (PDT)
Message-ID: <32ca6c1b-bed6-4ae1-9602-d2d593d758d1@linaro.org>
Date: Tue, 28 Oct 2025 13:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/35] ci: clean-up remaining bits of armhf builds.
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
 <20251027110344.2289945-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251027110344.2289945-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/27/25 12:03, Alex Bennée wrote:
> We no longer need to support 32 bit builds and we missed this while
> cleaning up.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   docs/devel/testing/ci-jobs.rst.inc            | 7 -------
>   scripts/ci/setup/ubuntu/build-environment.yml | 6 ------
>   2 files changed, 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


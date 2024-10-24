Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945B2CE8E91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 16:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t40ew-0007xJ-1M; Thu, 24 Oct 2024 12:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t40et-0007xA-Gz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:25:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t40er-0007f6-Jq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:25:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso10651195e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729787155; x=1730391955; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnY08WiEGepntZFD+7RsExWl8pcrtNG0EcQot7SLthM=;
 b=Da8CPWzpAo/fN42IEjBGhEhQI8iiV6OWwgmAh8SpaouH7BgYiKX1OU9ofANnbWECuY
 ZDCaBjGGJVIG4Nw9t0FPkz3L7dMj/ScfbsoC21xfcXpLaCbewEynipZ9qFIfCRbcN3Yz
 dn6IozZEhnyUYwu++eM539MixotL/eXGzbCCC7Nnyq8KpbpUmpuZRfhVZDnI326Pbg2r
 8nCzMXhk5r4lS6efP5jRxBq2bxMF8G23N0aJxWOimuNLB2FW+n5Q8i92L1u136gzh5kD
 SWrryZh+jEHeWhKCAbP0EHI4pCismPG9HAp03npYgYBTh9ZaGXrri1h8QBWgMi4ZuI+r
 W1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729787155; x=1730391955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnY08WiEGepntZFD+7RsExWl8pcrtNG0EcQot7SLthM=;
 b=IFQu8gb7fpbIoHUgMkR33yEk4vuTONpHRU1Unq6VJ5GNsZcBXPbcYtIvaHrco4cKGd
 YLhr57yftnhX3MTgOjoz58OJEFi9jl7xWI3Qdhp1RJ1dJtafpS0DHFw9YLw6B1wm14fq
 d/BSL8VcffkZKVd9KbAUETM4zJ9TJpoxaFtDDK0J+YQx6n3nwDNHQmJz65wwtokacdlr
 lOQhefDbZfaflaVB86OeQiOzu9u5oRrF4e37uTaQx+ducniE8Wx7wl0X6Vel8jxQOq3n
 8UiaasM5jQr+Fmalw3yrE1SENORwZdAnRdLxnmcyVe1MUJRXIwh60ku4m1vObA7I0Z7n
 CF5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsGeo7qv/LS29gFG6Vq85AnJu/H7orsK+x3DmfNrjfK1VwIGnez87m2a7c7/q8lfrQ/OWa8VR49SjT@nongnu.org
X-Gm-Message-State: AOJu0YxXIGcnNpgxzfor6Z3BUx8Eac5Tz85yTBvJeS/oUvbwiGM13R4h
 zu/ab+pVDw47KB/D5DFN9j+6eaLEsWdUa4Ksseq9eySJ9Dwr/npEKuNsX4M1hP8=
X-Google-Smtp-Source: AGHT+IGadBfRC4Y/CeOmWJaGHqwU4RElmLToloXtOxWlUdYa+NGerJ4jdVyiNteQL8XqucBXBcQm6Q==
X-Received: by 2002:a05:600c:1d84:b0:431:51e5:22fb with SMTP id
 5b1f17b1804b1-4318413f0a8mr62787635e9.14.1729787155089; 
 Thu, 24 Oct 2024 09:25:55 -0700 (PDT)
Received: from [192.168.15.227] ([78.33.32.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c1db2csm50683115e9.40.2024.10.24.09.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 09:25:54 -0700 (PDT)
Message-ID: <66320518-0270-4426-8daf-9be3ae7bfce7@linaro.org>
Date: Thu, 24 Oct 2024 17:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: fix hang when using slow path for
 ptw_setl
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
 <20241023222026.1430014-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023222026.1430014-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/23/24 23:20, Pierrick Bouvier wrote:
> When instrumenting memory accesses for plugin, we force memory accesses
> to use the slow path for mmu. [1]
> This create a situation where we end up calling ptw_setl_slow.
> 
> Since this function gets called during a cpu_exec, start_exclusive then
> hangs. This exclusive section was introduced initially for security
> reasons [2].
> 
> I suspect this code path was never triggered, because ptw_setl_slow
> would always be called transitively from cpu_exec, resulting in a hang.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
> [2] https://gitlab.com/qemu-project/qemu/-/issues/279
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Oh, wow.  I believe this will be fixed by

https://lore.kernel.org/qemu-devel/20241023033432.1353830-19-richard.henderson@linaro.org/

which is in a pending PR.


r~


> ---
>   target/i386/tcg/sysemu/excp_helper.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 8fb05b1f531..f30102b5362 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -108,6 +108,9 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>   {
>       uint32_t cmp;
>   
> +    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
> +    g_assert(current_cpu && current_cpu->running);
> +    cpu_exec_end(current_cpu);
>       /* Does x86 really perform a rmw cycle on mmio for ptw? */
>       start_exclusive();
>       cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
> @@ -115,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>           cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
>       }
>       end_exclusive();
> +    cpu_exec_start(current_cpu);
>       return cmp == old;
>   }
>   



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1387DC982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 01:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MzK-0003gE-Hl; Thu, 17 Sep 2026 21:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Mz5-0003e5-G7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:01:47 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Mz2-0003wB-Kq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 21:01:45 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c2c08ff3f8so187854b6e.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789693303; x=1790298103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Aik5sFwlalLnUfKz+zkmrZ6cbCxIkUg4vWw9IcoTeLA=;
 b=su57qftQUXiWwVR/BL3HQ7sNH/X6/giyagvx4dQdo53y4kw4Oyl6hsAjz7U8LEUu3I
 hkyoFGCLgh5GvbH8c7p87hIFXQIzIJjINCPRmhsxXFEfUXB4l5hekujScr2jdhJPRSXF
 WMzRRhHle1MlgDHXegRGEBw2CqJKYvpO3/FjlZUNjT515mZT3OFbG52DBwh9cgRXyE/B
 Vtws8QG1/dAqTuvRDVxeOXnQyEzXzp1UHvvp2qtWt65x5ndGVqI7c3e+Az4PMFJy8zmn
 Fg0OO9fKAMWMAS0ug7zZMq77oop4oofwnNtKKQ0R5k/mj2sqEfdFhlwmcDiKyjEK1D0c
 tniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789693303; x=1790298103;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Aik5sFwlalLnUfKz+zkmrZ6cbCxIkUg4vWw9IcoTeLA=;
 b=F8+8btD6prx0DIoFyFXSjRprYB/bwpdTQOVlEofGfIoI0r8l6kNaBsMJV+ervsbfpd
 mrAHEUgIfdilB4x2ywYVwazFanqhGRm9qH0bDI6jc4OiSrrUk2ldbNJYh0PqopUrjHMz
 V2NXYNiAUPdkW6CajJCzAxCL5qTQcv1o83y2LbEjXCicrFNGOP1OcnzD0nfjOIBvWRHb
 f9Zscw0y8AmWWhGjNGE2fwPPIOuvGAbly/uVDg/0LmlIx2Cmbgm/gmPrIWrF9Fa2sTrm
 8zNa2gWmmibq+VgxFko9mvDtj8yJAD5DeS1YOhbFEyT1/2FyoPhI9dJBE+Cdh+PtpqTs
 uA5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByAEmBbvzSkv/8tBZYlL/cZCwSEOysh5rUhNWrH8S2bjrGINospaP/49M/p3pVuvPks670SliFfBsq/@nongnu.org
X-Gm-Message-State: AFuF++mC1sT+B2db6aevN6/EFXOZrmXIQZhthT1npdbjPVOL6pEr8fgx
 AGlw5ZM/KLF730ID0uYc3l6jRw0ERdWeSSVRF3QyvhggAQvbyFQFL2iO6L8c4GYmU00=
X-Gm-Gg: AYBFou0cAqqI2clYbCcLJcRgPTqkDQ80Y0bExxl08XhE5jYEvJpSght7nVn8oIf4dKu
 N7ik1LkMfuKmiD0Gr3oqxyok422XJANy+SgMOIj+aZZCmXkoevDH+7tZNl4lgJvMdWMPe/8QkEa
 zitcxnXuUFqCfkx8CCdN0YVRU8XvTWoJYgQuzAgUUS803lCKfFqebW4/YRVSTACts2+IT7mG2yp
 jZNQNNWT3Lfjf7Czh81NwOU5pHwu9l6InPNqLhDWMnvAFAZPcvi58lmp13qwt3NvfmxTByy1DM8
 n2o47uEPeOOKL+xpbvtJw6W3uaPEBJxQ7aBz9HlzhP9nHmKj/yBRn3QgIk9xxVV0VpH/ukraYp+
 MIgfNvbGPG4nSOKrTNsr8xfPxtSaSAo6JTXy1BvD8SZNUX58RrJZ9/k5+XKwyK2lzije4+Oc5Oe
 NYFXP3N6UBSu1WQBtie53TKfxU/XE9BayaMDp14i+vF174v4QmfV+emd1cW5DhlVFl9FpoW+jEI
 WSX+22kx+XU4JOrij0YevhmDUmH8SmN7GtojEv++IxXrAXHWo3u70Rh6OVTqnAYhgr/Vu5T
X-Received: by 2002:a05:6808:1a1a:b0:4c3:9388:db43 with SMTP id
 5614622812f47-4ccf53702dbmr1374598b6e.9.1789693303132; 
 Thu, 17 Sep 2026 18:01:43 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:83aa:9d68:3956:350a?
 ([2603:800c:7900:ed00:83aa:9d68:3956:350a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c19424994sm4928120eec.12.2026.09.17.18.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 18:01:42 -0700 (PDT)
Message-ID: <724e2043-fbd3-4c1d-85b3-a2e6056b9ec8@linaro.org>
Date: Thu, 17 Sep 2026 15:01:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] accel/tcg: add helper raise_excp
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-4-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918004225.827-4-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/17/26 14:42, Yonggang Luo wrote:
> Add TCG raise_excp (env, exception, restore) that exits with GETPC()
> or 0 via cpu_loop_exit_excp.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   accel/tcg/tcg-runtime.c |  6 ++++++
>   accel/tcg/tcg-runtime.h | 11 +++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 7c0aab98a80..ae93765b09e 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -130,6 +130,12 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
>       return ctpop64(arg);
>   }
>   
> +void HELPER(raise_excp)(CPUArchState *env, uint32_t exception,
> +                        uint32_t restore)
> +{
> +    cpu_loop_exit_excp(env_cpu(env), exception, restore ? GETPC() : 0);
> +}
> +
>   void HELPER(exit_atomic)(CPUArchState *env)
>   {
>       cpu_loop_exit_atomic(env_cpu(env), GETPC());
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index 0b832176b33..036a33d566b 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -22,6 +22,17 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
>   
>   DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
>   
> +/**
> + * raise_excp:
> + * @arg1: env -- CPU env
> + * @arg2: exception -- EXCP_* or target trap number
> + * @arg3: restore -- 0 skip unwind, 1 use GETPC()
> + *
> + * Shared TCG exception raise. Translate calls gen_helper_raise_excp.
> + * Exits via cpu_loop_exit_excp.
> + */
> +DEF_HELPER_FLAGS_3(raise_excp, TCG_CALL_NO_WG, noreturn, env, i32, i32)
> +
>   DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>   
>   #ifndef IN_HELPER_PROTO

(1) Put the comment before the implementation, not the header.
That avoids whatever you're concerned about vs patch 2.

(2) Don't pass an extra argument that changes behavior like this.
Better to have two separate functions, each doing one thing.

(3) Maybe better to place the functions in cpu-exec-common.c, so that 
the compiler can see all the definitions at once.


r~


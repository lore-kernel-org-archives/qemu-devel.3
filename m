Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9D6D6ACF3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGL3q-0000Fh-AR; Wed, 27 Nov 2024 11:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGL3p-0000F6-2W
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:38:41 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGL3n-0008UE-Lu
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:38:40 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53dd59a2bc1so6546636e87.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732725518; x=1733330318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OqMzsdoyJZ+OGQakis+tfg7rq3fJZU2EWVYfBTnrnhw=;
 b=zRFDKxyQkhjR402S7GEuovXz8wAyopxP+9RtSMzwF9U/vlErnBHEQuhMt34r8ZGcgd
 Itx3hZEESSTtsvW/L4WKTiUqztscUvZiItJnfYbVEzuA9En9U7n0bZjfkMGgHT2XvEYV
 Sx9UgX6kRpbtGXc7iPafV5C9ucY4kkK/L9dVO9OqSpB3kBkJ4YBPhNDf+Kw2TPfVpU7X
 rgQyln2nDmirEQlHq6O+h3+vVP5Tdq2W2Q7WnfsjH5bvlWMkHVLogr2Rqf+BE4SVrUI6
 nHWrFFj6XHVL2QrpjqSc5FV7fHTwXdy5vBhhzKDELdzFXZoqAvZ74r5zInhr84OcmV4C
 WTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732725518; x=1733330318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OqMzsdoyJZ+OGQakis+tfg7rq3fJZU2EWVYfBTnrnhw=;
 b=cZE1OkFtATTe53g2IGVSbPmu+qKSNoXXxD7GsaCUllwjkdEYf2PfNNxgRuJCMBwb3X
 LVsWoPGHm9mVtliaD7/HWgNeJCyfojv72Wln0ry207zaedev+tYspPPqNzlRPkejv1QC
 ywtvLJqOtDtXor83AuFWnATKXKiVeAAwNVVz6xKf7wNq8UX6e89BVIBRLRVAnOlDobU6
 cKtSAgM1y+n+lM0xaK4q+YNAzuC9U5TqWbCVybrhPu6LXYtESvGD4WIGBGCd86zE7sIF
 GV3DJFC6IsGJdx+Bie4QJZ0/bK3JQhadvRamsYWQylfvA8iDY3gOc8YVku3IZ3tPjJH3
 2/aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4+Z/aJd5kbYBEM2BF9kJKsm0LRndHiAk9eXqNkrUHwmqPHnlKxH7JieRgE2zIaurmQLi4aE0iXheo@nongnu.org
X-Gm-Message-State: AOJu0YzvNECPhDdgidBNIlbOpQx0p29APsO/pgTRk/5CpSAZ/B9+WU0I
 KrNUpeGQWrJRR/QdoSHFLYlN3IdXQbuW8/mUmxQbP2zUKXMiR16jCjsIxQzHq2Bud4XtAgAvUBh
 uG3U=
X-Gm-Gg: ASbGncuC/Tmicyx4Iyl8yKLoNZJRCI1Gg0X/VytiNipK2gVLxpcYeyrcezew3Pbc2Dv
 +1IkVtiD2Iaj7CY23hU7ZEkPQLp2grhHFMs4Vkd67fjb57QD4QnnS2YshlULV23w9EG72GVTFHb
 AR6I29qriT6LKCiu2D5PH2K8j5ajKbHyrI5F3GdOyerYemi0dbDntyxQzfwhBAh2jtYQZumIdwn
 ZtRPNb66K5m7dwSnz0MxACnNC6ZveMiyvdVolKs5n+lCogGcLFoFz9I86PQ+R8VjIz5
X-Google-Smtp-Source: AGHT+IE97dTHZx8N4c44nCwRBkMIi3daCTPJmSRoo9ZRnEQHBIOh2iSWPGDvck3a0l3X/4Bv/vKh+A==
X-Received: by 2002:a05:6512:39d0:b0:53d:ec93:fbb7 with SMTP id
 2adb3069b0e04-53df00a9782mr2560159e87.9.1732725514386; 
 Wed, 27 Nov 2024 08:38:34 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.71])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53def3051c3sm337952e87.221.2024.11.27.08.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:38:33 -0800 (PST)
Message-ID: <e8686e7e-c10a-411d-a485-8789247251dd@linaro.org>
Date: Wed, 27 Nov 2024 10:38:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 2/6] accel/tcg: Declare local tcg_ops variable in
 tcg_exec_realizefn()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241127121658.88966-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

On 11/27/24 06:16, Philippe Mathieu-Daudé wrote:
> Ease reading code by declaring a local 'tcg_ops' variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 8163295f34b..18d9cf0ea58 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1070,15 +1070,15 @@ int cpu_exec(CPUState *cpu)
>   
>   bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>   {
> -    static bool tcg_target_initialized;
> +    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>   
>       if (!tcg_target_initialized) {
>           /* Check mandatory TCGCPUOps handlers */
>   #ifndef CONFIG_USER_ONLY
> -        assert(cpu->cc->tcg_ops->cpu_exec_halt);
> -        assert(cpu->cc->tcg_ops->cpu_exec_interrupt);
> +        assert(tcg_ops->cpu_exec_halt);
> +        assert(tcg_ops->cpu_exec_interrupt);
>   #endif /* !CONFIG_USER_ONLY */
> -        cpu->cc->tcg_ops->initialize();
> +        tcg_ops->initialize();
>           tcg_target_initialized = true;
>       }
>   



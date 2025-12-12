Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96EDD59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU63t-00023s-Eg; Fri, 12 Dec 2025 11:32:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU63r-000232-O8
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:32:07 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU63q-00083W-8L
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:32:07 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7cae2330765so903698a34.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765557125; x=1766161925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vl9iVkBfObl5N6PlswhPVnwhktT3W/MAm7tJwr0yy48=;
 b=dE2sdpuXzRVq18BJ6dbdoA4ukneaZZO8sYHa2qU9iOp3SL8Xr5kxbRKH4jckECQ9Io
 6oJXDTz6td7SwY9y9upo/qkPBh51RDItatkbpeWZfPSYhMEm30DBETYBlSA6HBnZ9Q+X
 9xGhRohTuDEB8HCzfBl97Kj5ajCEdCO1kB6tT6kG6WN+0/oASV/krGmVPOCT16Uf+lrL
 VHKZE+h7otGfzZuaeLrF3kh2tw0gEG7RbOSyJWOHOWC6ogJmDpP3mMNetfcEQn4Ceftm
 BXAUMdxlasFXpLNjWSZ4K/kDFowlajEtrYJOMNxEz/RSz9M00u9Sw5tnTT0KtyIjGlkG
 9q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765557125; x=1766161925;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vl9iVkBfObl5N6PlswhPVnwhktT3W/MAm7tJwr0yy48=;
 b=Irx+oyuUnn6xrpwm1NeTd2JasZnKTZDz/qETXPxLz5zrEPt19SmGh95ctmpBYIo1e9
 y3HuOvvkdpf0SJjpmWK79YfnBdKE3ZRyS1Q4vuOz6ynWtCpnQLOWc2yRV4GQkd9Kq9qf
 6CzYDQtki0ld2LlveJnCHU4gIag3V+LLBnqPy4Lcft2OmGYGRuu22ExmpvNFHNcJPmo1
 yi1WmIZD93VLBNXz5UeZomfanTHSIoG3fgR3bVMXGpLIyvNvgAwrbpjeox+OFFZgprs/
 M3wwBUfskihpqjvP9rH8oJKm/fX2JyeSCqYMcVUvfL0yIU6GVrlvmduDeprOigFx3KfH
 +L/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfSBiwmAdUHvMEmc9Fi/3NEPctKOjl5LskyL9XBYxktEq/1cLn2kzxGgIg6oWefze4IvwqE25Q8SI/@nongnu.org
X-Gm-Message-State: AOJu0YwEt8lwjKfKjolB521dcSnFUji629s8cgkgdyJy2nl3heZLc+FW
 X91hSGbGnGGZxpZ7Bwo/SDaMYCETMv6BhGV30NeJ7KnbKB51ytjrSUQEtLW2ux95Zaw=
X-Gm-Gg: AY/fxX714hjAPKd1HR70zzstqGO/CSR8LyXQF9ubsup+t7uSt1mB//ccO7Gcz752h+h
 XeRPQIURqSe78Stu8/fA5jBfK/j1b7vvNJP5rQX23aCOrZ8dOZRMFT8yTGuSU5mnu7LxqZ4u7WV
 VQz124o9mQgwMV95Pc1QU5fBLgo5Ds1lpYb7UDPYYJKfoFhCtXhzgZURLbW9fp8YDF3KUyZYBA2
 7Bve41/SMRZvos6yjabYLoBFLNPkhn3WCPoLH9PmhCSCBy2f/2NxaYmwdviu2y281qhXg8BUsF0
 guqZh3SAef5apcCax0/RUcUgAX8q5s9EKpvBerJpMljDmM2yZvyOJtaFlD+fM0D9sSjs186fyhq
 +TmFYqRp8jDhFRANmGXnFqEJdkcXGMMFBsOuDHrNixIGoejj29VYATs7yvICUTsDeHDE5fTOnJf
 2efHon23JGf8b1pxNYRTPaTX4d+8tw
X-Google-Smtp-Source: AGHT+IGF1n9Weehk0SfB9PGke5xkam/FAYO8eLERGPDv+zdZXwFRUpnneJn/VfmEQoJmOOaYDKMDdQ==
X-Received: by 2002:a05:6830:2b1f:b0:7c7:e3b:4860 with SMTP id
 46e09a7af769-7cae7fbb6bdmr1507984a34.10.1765557124910; 
 Fri, 12 Dec 2025 08:32:04 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1d1089sm3700515a34.6.2025.12.12.08.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:32:04 -0800 (PST)
Message-ID: <b6af39c3-c7c1-4442-a149-7b00bb867f87@linaro.org>
Date: Fri, 12 Dec 2025 10:32:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 12/22] target/mips: Introduce loadu8() &
 loads4() helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> +static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
> +                           unsigned mem_idx, uintptr_t ra)
> +{
> +    return (target_long)(int32_t)cpu_ldl_mmuidx_ra(env, arg, mem_idx, ra);
> +}
> +HELPER_LD_ATOMIC(ll, 0x3, loads4)
>   #ifdef TARGET_MIPS64
> -HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
> +static target_ulong loadu8(CPUMIPSState *env, target_ulong arg,
> +                           unsigned mem_idx, uintptr_t ra)
> +{
> +    return (target_ulong)cpu_ldq_mmuidx_ra(env, arg, mem_idx, ra);
> +}

You don't need the casts to target_ulong -- those are implied by the return type.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


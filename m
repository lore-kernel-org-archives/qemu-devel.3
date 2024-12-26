Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BE0E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwcA-00035y-O9; Thu, 26 Dec 2024 17:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwc3-00035R-9p
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:45:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwc1-0004fF-IG
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:45:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so45688865e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253148; x=1735857948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AL0H08UNOR6e9omrXtEO7vZuIP/t4UGbf/QM8OwrBOI=;
 b=aKQaG6LkhPH9GINHVPni/Rlpz3Yu/2ZGuV+/rMJR/wfGyBqthAnXdaazKM+RGI3cPU
 bB9i0C55E3ql9op32u10t+ravCIT6Hswxm63goMRdIZvv0S0r6pQpJfV8OwtJB/JXJgI
 QlKle66NpBkrRrs4sLfHGkiJxoh9JRrJSv3uilUiSIIKBCIs8TgA7hx1bYmgO870FzXM
 RQjo9l2oVGQIh1WTHgrjia2/EzBm3u/wuu8YlV4xel8RBgFn4N+ZfS+XMe0Ch2AS8e/8
 pkaWORN6zxxXlNQJYUfaWJPD9PI2MZ1hZG1NGtJYvLCB3+I89lao7E5NO/MK1J5Nj00i
 3WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253148; x=1735857948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AL0H08UNOR6e9omrXtEO7vZuIP/t4UGbf/QM8OwrBOI=;
 b=EL52KSTejj13yHZEze7e6qFAGQQFR8xixfx+4HIzFP1bNJz/8qXtO3vSwjHFbKG4Ys
 Ng1iR7xt281cOO14Vq4aZoIWQi7C7C8AdcBr9enk/nazIUW0iaxZfUE6DALZ69ee/dgK
 pYqlSMcKh/5KlEGbBdCA068tRBEjujKm7RX816r9idh/0BOEhT87axDXO+gxBS/ICfdD
 rjerSrWTiH6ayLr0ImtYqeseljSsYUeDaZNk7GzD1gQMDbOd3O1DCsuwS7Oo/Otj5ekk
 srNlg7OqOodRbw9aJnKCdN1gl4stzgjzvM32O+ZlV77Vcab2MXnjTCi90eTC7jjgt2RC
 UCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQpJdK76DTXkGVBr+kALFZqib2S0Z9t7YMaVB4WQ/SxM1jbdaIZRzs7B0L1jWo9dI2oeb5B0r+6ArH@nongnu.org
X-Gm-Message-State: AOJu0YzriOsQfAF1ZzIiEVFf9SvM1NvG758+119vpCgKhWx/DjdgJ4jT
 /BKCgTkqqFvjIcV9un9x8peBamwamjQ1zV2jAUYdOa6gVMySMcvWV27Lhwh6rbM=
X-Gm-Gg: ASbGncvpnhEWBIPXNcCdOFIL3vDYUEo0dK1lwGv6o9AjhLwOKq+WMKUICDD+JZ2Ptzr
 WAqYoI5dnJ/KyxIXpKQB4oDaqnTjI7+q/2AbB3RAsy8xB8ndEE28qxL+DKNNtPupf9pFakhDGCp
 ppfYGbQkdNQJLY2sGIdmu/UT22Ka+pFuBFf25vbGYZdQadRndtXUwIx96DI3fYhBlGS/m6gj8HC
 VRpJw1cy3o5PVJqYS64bQCJwwE1Lf6xdVIuuJpNLfA8MQJW3uOzgoa1QbV1Aajr0F0w83DjTxdj
 tDzv7wZdQc8KT04q+mdZ0g==
X-Google-Smtp-Source: AGHT+IHBdt56XOWI+GQfok3e3qC+UsDYJDvr8GkOZT35qI6B+lwR7jogNpNIENmvi0Ue+WLWd7HOkw==
X-Received: by 2002:adf:b511:0:b0:38a:372b:ff2c with SMTP id
 ffacd0b85a97d-38a372bff53mr7044545f8f.17.1735253147492; 
 Thu, 26 Dec 2024 14:45:47 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832ec4sm20316813f8f.26.2024.12.26.14.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:45:46 -0800 (PST)
Message-ID: <db7a97c1-f917-4c06-8298-7c21918a7cf4@linaro.org>
Date: Thu, 26 Dec 2024 23:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] target/loongarch: Use target_ulong for iocsrrd
 helper results
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-5-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-5-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 26/12/24 22:19, Jiaxun Yang wrote:
> Those results are all targeting TCGv values, which means they should
> be in target_ulong type.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/helper.h           | 8 ++++----
>   target/loongarch/tcg/iocsr_helper.c | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index b3b64a021536255a3f9decfc10ff61fe8380e2ae..409d93a5b0808f0e32b8c0e2e17cebac9feaf8ed 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -104,10 +104,10 @@ DEF_HELPER_2(csrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
>   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
>   DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> -DEF_HELPER_2(iocsrrd_b, i64, env, tl)
> -DEF_HELPER_2(iocsrrd_h, i64, env, tl)
> -DEF_HELPER_2(iocsrrd_w, i64, env, tl)
> -DEF_HELPER_2(iocsrrd_d, i64, env, tl)
> +DEF_HELPER_2(iocsrrd_b, tl, env, tl)
> +DEF_HELPER_2(iocsrrd_h, tl, env, tl)
> +DEF_HELPER_2(iocsrrd_w, tl, env, tl)
> +DEF_HELPER_2(iocsrrd_d, tl, env, tl)
>   DEF_HELPER_3(iocsrwr_b, void, env, tl, tl)
>   DEF_HELPER_3(iocsrwr_h, void, env, tl, tl)
>   DEF_HELPER_3(iocsrwr_w, void, env, tl, tl)
> diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
> index db30de2523fff01bcc8923eb12c7fca7bedca7bf..23d819de0ef9790eb82741f1e8a0e20dc139bf4b 100644
> --- a/target/loongarch/tcg/iocsr_helper.c
> +++ b/target/loongarch/tcg/iocsr_helper.c
> @@ -15,25 +15,25 @@
>   #define GET_MEMTXATTRS(cas) \
>           ((MemTxAttrs){.requester_id = env_cpu(cas)->cpu_index})
>   
> -uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
> +target_ulong helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
>   {
>       return (int8_t)address_space_ldub(env->address_space_iocsr, r_addr,
>                                         GET_MEMTXATTRS(env), NULL);
>   }
>   
> -uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
> +target_ulong helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
>   {
>       return (int16_t)address_space_lduw(env->address_space_iocsr, r_addr,
>                                          GET_MEMTXATTRS(env), NULL);
>   }
>   
> -uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
> +target_ulong helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
>   {
>       return (int32_t)address_space_ldl(env->address_space_iocsr, r_addr,
>                                         GET_MEMTXATTRS(env), NULL);
>   }
>   
> -uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
> +target_ulong helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
>   {
>       return address_space_ldq(env->address_space_iocsr, r_addr,
>                                GET_MEMTXATTRS(env), NULL);
> 

We could reduce code duplication adding address_space_ldn().

Anyhow, for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



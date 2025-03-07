Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0012C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd83-0000Sa-6H; Fri, 07 Mar 2025 14:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd7x-0000Jf-9M
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:12:58 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd7v-000645-Pc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:12:57 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2241053582dso17523065ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374774; x=1741979574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFboTrno7592ZcVuTMJBsNGbCejgaDbqbHuitBs7Bn8=;
 b=zWdAIVxyAEbc74qs3ZblrctQajXrahZNloWMx9T5YTil14BqCSM5zTi6fyWGYdH3vH
 /TBW+ipjVKlCsE7ktqmVEHafBffoNUSlbZHqWB4YqfKFLbk6xkTRVJR9Jera2SeaJqlz
 3fjNnQTqRoyGYQz1CD9oY3j/5d3KuYEaem4bG0Bin2f8C1hHxugi4TUG7GEjgUyvSsBA
 9Q7F+Qv9FtjK/b02rPWJNXVLjq3RsRbuA/OoTe/HoDElgqM5qCSpTRzh3o2qgPiksx+0
 CL2fgrOWVkiCHInWWE4v3Hn76HedEjH+l6H+eTHvlHmOd+Od8FC+4a05HeMm5KrosDEe
 h1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374774; x=1741979574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFboTrno7592ZcVuTMJBsNGbCejgaDbqbHuitBs7Bn8=;
 b=PqiH7ovLtmjulE4n6krA9Y2sATOtP9HN5jswMA2MykfAIibNI+u7Y8BM9+KnlZ5dxN
 OMYBNUoJ+UL7ifj2rGQOBLoLKAUrGdNg+p9mxffDeu9eCYnFn3mDKlrMpJTuL9YkSy4e
 D1/eiBf+/DP5/D3fXHS3YSOZWzMfzIZtHIjC/HKC/388rxrEpTl44nLx8KveT+U/O0mp
 6pTky2qF08L87vfmGFBcGFyK/nPMKAF37MODzsy+o1GZfVhSmMUA4sruNTwcoswzvSWW
 MxjPcTr8EvcVmM2+Yq3XnQXUSDB4xtTp7h29gQKGwjnInOmmTMFp6Px4aFJBrVfC3FE5
 JlEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfWzJZaQdFW4mU1h2swBQ7+Oq0TiO4kN/6f8syMfo0xDr0wZvd3cCvLXIKReK1FWHcev0TJS+Diyz9@nongnu.org
X-Gm-Message-State: AOJu0YyjlF69yMsk8IwIRjqTzF1HZxt+0++McQBnwTvCBjUEwlL0JXox
 vKdrSjyCgSBkamtGAgS1CbTYJwkkhkXRrM8VUbdwrar57PYamMwL6xIP1Bo5lds=
X-Gm-Gg: ASbGncsoBfQbVFA10Wy3uS670+ZniAtT3k0rUG7l0kwBufG3RtPmUK/MLf2n1D42Ut+
 LUx7bR3M1I15R18RnnJ8bZw2Lc5Be7jmZ2dJj4vMqsmE+tbP1S+cn+fjaS5wSQuz6iseaFfuGY6
 VWHvSXwqJLC0tA3+On2nVlZJCsB+5wU0nTt0fZs3cHv1ZCmLMsRDDnzImNX8xRGQUPdBV1m00eI
 dUdDdb1V7IGzS1iffEpapgICd8O5SUSYdaS0PBgERCJKCmplATAaPGLa+abZYSv0nUy6enKHNEG
 vUjyeE1RKM7PbdYcxpY8fIeZJdUmcJHGuqqx30uQbRSpoHAPlZXw4nlCMQ==
X-Google-Smtp-Source: AGHT+IGGSwin1DNueBMQQohYnV1JUkF60iAxgJWwuMLMPs1uuzOcm2vOyMHmtiZq5VbxXBXKrB8TyA==
X-Received: by 2002:aa7:8583:0:b0:736:ab48:ea35 with SMTP id
 d2e1a72fcca58-736ab48ec80mr4702528b3a.1.1741374774328; 
 Fri, 07 Mar 2025 11:12:54 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984507b4sm3631746b3a.82.2025.03.07.11.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:12:53 -0800 (PST)
Message-ID: <ba7dac92-9a12-474c-8eba-ec84c09ccad6@linaro.org>
Date: Fri, 7 Mar 2025 11:12:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] system: Build watchpoint.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/7/25 10:56, Richard Henderson wrote:
> Now that watchpoint.c uses cputlb.h instead of exec-all.h,
> it can be built once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/meson.build b/system/meson.build
> index 4952f4b2c7..c83d80fa24 100644
> --- a/system/meson.build
> +++ b/system/meson.build
> @@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
>     'ioport.c',
>     'memory.c',
>     'physmem.c',
> -  'watchpoint.c',
>   )])
>   
>   system_ss.add(files(
> @@ -24,6 +23,7 @@ system_ss.add(files(
>     'runstate.c',
>     'tpm-hmp-cmds.c',
>     'vl.c',
> +  'watchpoint.c',
>   ), sdl, libpmem, libdaxctl)
>   
>   if have_tpm

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C3CA0FFD
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 22:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usThj-0001y3-7H; Sat, 30 Aug 2025 18:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usThg-0001cS-9G
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:05:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usThe-0000Ku-Fg
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:05:43 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3277c603b83so1949073a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756591541; x=1757196341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hBRX8Zs/RtLSvt4/+woLghDT/BNjcE4UMcP1ePlzP+g=;
 b=EB29z81yc3t4o5I6M5NU1Gfl20VqsA5Tu4IJ5PAeYp9AUMFAhKSlnYrlpU3YyjvCea
 /J8S4snhMqtbhkhgD3C1CNgedLOzov8fBEvmQAx0QlWbgXWl3DgYuxlfTUqNhvXHeulz
 0sryvkehavjU3M4SEpmZxoDRY76dV29tML6oYncAHJlI/AgHod73zDrQggaVQFlesX3v
 BnYvUxENQk9JZQqsEAAwjbB91Vo5zwwo0xcsz5lXkF9jSHBR3N6XTk++Ku4GNUpAhHBO
 VHdReedw9ayWHAPgjddi0le4n+fHtffwdVvkKBarvjGkf6g/ulQEPFr/CiHDVpmRL4xI
 t8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756591541; x=1757196341;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hBRX8Zs/RtLSvt4/+woLghDT/BNjcE4UMcP1ePlzP+g=;
 b=nwMh6sFjdUoAaZpBOU3JL3p3gFMoJ0lhSqj71hxnaL2CkvpfsrFaYqGn6xLRFISXjM
 G8PS9pyUdyOY0BpVtOhwvj8b4XRrD+XUZADpYwcjUDPG5iJcEVnzvYFu15J3TNbwZkn/
 rOo+AJZJe9dLmqe6gXAiFRideuR+7VpWtM1nraf9HWIsizFd4007PlpJimsL+GjZz/Vb
 hlh7gI4Xb2RSE3p/jCcoGRITlF7iLiHV6G3lU6YWY1l1RrrLhy9oa2t7UoZwLf2sM3T9
 6KiTRnzj5XQaxwiTvwQFZVVonfxM7lLdFKXu54qn/UpdClVvZY5zHi29iQuOwyWGJdbp
 uPSw==
X-Gm-Message-State: AOJu0YzRGnDnVlUWe9i+kCqvVan+oKNullz0nGKkVeuhmJlc4gGzKCJd
 84OU1Vza9ymtQjxjLYFxqbhKbWIE10bCct2ameUMFSjfadhyHkrM8mBi7gnHE4hBt6HdurTKKaU
 P78jlrjc=
X-Gm-Gg: ASbGncuKOPBvFVx0tEp2HJPW/e65ZDDGszvwMEdL+l5N2uGY4YN8pSd3QLdg2l9IOD8
 AA/1vowa4vW7MpSJWU/biVXZwuI/FHvB3xtMk2e9rhWBkYPQKpp9WVauootIGtAc4A6cUsZUCvZ
 uqIkvkh2DHwSyLRfKn9NSLzev6a/6e6X88cW8CVMVbvKJ3S4QRcDjiusnLkPYS9mwJlthMM8O7Z
 7RZJtvHAgUOmzJm+sQbLIZ7R+G9pZj74KOW20ucsSnei9xY+HGO2110GIPlDwn4MjvRJEqmSVjf
 yR+F4BCnqQ9Vac9CVB9TocOirTvaZFvY9NWMVoJwtcIHMUb5tR8UV99kb8S9f7b0QtSB2C/Wx0/
 zo4Y68I+s6FqlMFAEg7sl0fcyrNrZuk8ubQQ+la7jJIlgb/DP8/9DQ2CSsGfMInk9ykdk3g==
X-Google-Smtp-Source: AGHT+IG7vdwPXtX/oWbOtapZ6jlNol27B+L7DODVgnFhLjm+2HdrETUGSV5FD0H3kE0drFFmisCf/g==
X-Received: by 2002:a17:90b:2884:b0:327:ca0a:67b4 with SMTP id
 98e67ed59e1d1-3281544fe3amr5334533a91.12.1756591540901; 
 Sat, 30 Aug 2025 15:05:40 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327da8e5ad5sm6715553a91.18.2025.08.30.15.05.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 15:05:40 -0700 (PDT)
Message-ID: <63194843-8937-41ac-8fad-43952e2ce899@linaro.org>
Date: Sun, 31 Aug 2025 08:05:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] audio: make jackaudio use qemu_thread_set_name
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-6-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> This has greater portability than directly call pthread_setname_np,
> which is only 1 out of 3 possible functions for pthreads that can
> set the name.
> 
> The new API requires a trampoline function, since it can only set
> the name of the current thread.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   audio/jackaudio.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 974a3caad3..48ffbf735f 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -629,18 +629,36 @@ static void qjack_enable_in(HWVoiceIn *hw, bool enable)
>       ji->c.enabled = enable;
>   }
>   
> -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +#if !defined(WIN32)
> +struct QJackThreadData {
> +    void *(*function)(void *);
> +    void *arg;
> +};
> +
> +static void *qjack_thread_trampoline(void *targ)
> +{
> +    struct QJackThreadData *data = targ;
> +    void *(*function)(void *) = data->function;
> +    void *arg = data->arg;
> +
> +    g_free(data);
> +    qemu_thread_set_name("jack-client");
> +
> +    return function(arg);
> +}
> +
>   static int qjack_thread_creator(jack_native_thread_t *thread,
>       const pthread_attr_t *attr, void *(*function)(void *), void *arg)
>   {
> -    int ret = pthread_create(thread, attr, function, arg);
> +    struct QJackThreadData *data = g_new0(struct QJackThreadData, 1);
> +    data->function = function;
> +    data->arg = arg;
> +    int ret = pthread_create(thread, attr, qjack_thread_trampoline, data);
>       if (ret != 0) {
> +        g_free(data);
>           return ret;
>       }
>   
> -    /* set the name of the thread */
> -    pthread_setname_np(*thread, "jack-client");
> -

You need to make jack_set_thread_creator later on unconditional as well.


r~


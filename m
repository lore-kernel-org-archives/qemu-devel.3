Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BECF2570
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 05:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLaz6-0006eN-KP; Wed, 19 Nov 2025 00:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLaz5-0006dF-Qc
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:44:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLaz4-0007ZH-5I
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 00:44:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so40789105e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 21:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763531040; x=1764135840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9uzkrBpW4jmD0VWVe+U/rJhag1WofAgx/mM29GPz4Fc=;
 b=DNjmTzHDCqCLhqU1877Gx/CfjExRJsH4pi4S7SLMtr1KWJ+tQmk4A8rR8P0HnBGytx
 sMlLmZuJrmxhvoDdR9k4+McDLwhhutYK4jvVT1gzcfaokQTakwOaUuTrHX4fJHpeXPnW
 FYdgPLgVZHj0mmp0t3o4R/1RkU53KIejshy2VLsku6QXWa5w5DtoQ4CauosbN7zhDPoP
 YNfo1vGJVrpZIQOdq04BArTz6d+a2p68Av0/hJSxduJQ5Xhtq0bSwnUzPax7eIW/lYN2
 VNPorP45dfGCboIqQafBhq4MDAitVxS3Gv4gUUZcAN1L6io2aYYXrgYASFWVl30ph1Mf
 SNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763531040; x=1764135840;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9uzkrBpW4jmD0VWVe+U/rJhag1WofAgx/mM29GPz4Fc=;
 b=XwFeVVy37sUStSqfDPn1FQjgqvSqhpU1wWGXKs6S6h7aR4q5athTBNdiZ6Wbav90Fj
 nBY246F7EB9tmwKLbSHzTu0+HwASEraC6Jo0mJJsgV7p4ORsco51suRpKMC9UGRfeqrw
 4bL0v9zVURgjVz80JN36ee8imc692OAywhbYK/RXkmTwCyjd8k3RALiphjwZS2erBcaZ
 jL8fOApdbmT63kt3b4ZUmfeDoCSEi53JLEjJ+6wndiCwXXk4aW80SYo8/D6hKYk7jwKq
 bamrcsxXlXoST6DApXlrO1tZ8JhyL6q+mz5E8ovSxm7u/KisEN+RP0gLl9IF6NTDpaOr
 32vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPfl8u6HTbjidPltQm2pKSXCQuIeFH/rQ9uCxfKhJ/56OWL5ZDU6w7X2GCVh5lK1256rGTbSzyTJbL@nongnu.org
X-Gm-Message-State: AOJu0YxW+147pbF5666rmfdByKboIN2ulxJOMZ8ZjP+t5/Y6zAxEoyCy
 8GLFD5rpNo9z+WbGq5RDNNLVw7yhIy1yT724HK9PWhQxOiaAdEAsowF/iX8+62b384w=
X-Gm-Gg: ASbGncvMzQg5JWE36bV5gF5SlxKnAw7XhBHGZC7mHLkUJlzjWqJGGaFArzzmzIPune+
 qeeJnTd61vZAMN+TQW9ija4CDcwwTCzebIbY7PZTtczB+I02xMgC2KUemRwF0RYF34OaYVWsb7e
 i3OjvnMigH+84f503pBG1QRwoGw+uvZGUv5mQkNe8Ly2jlgMaj4CMfoVx781d7a0jVLo9bsVHTR
 c2YbWzPODz966hfoW4UV1HM1J4d+gxMwe38x/qsKju82HTvmoa5OkOkVx4d9UBDO5EP0Mp4LaoD
 e9NYl/28WVpAVtS6+wBCT/pfbo7mlU1ycsJkfxYl7q2zJMveP3YO1v6RIIcbUjPYrgVO3UF6jmA
 GZ6hFlMUKMKWRmhdj4mwzdwLP49g1Fr//e6oJebniDKEphiKE7OXTeZzm7vnY3ofQwxStQdB8Tl
 baQEuVbW5PoEFRyW0oVuEUgNEwOdCKv7VKe1mAXis3ERsLCyinJWd6R8rZgePgDKF7
X-Google-Smtp-Source: AGHT+IFX6W/rQ1hlCpypr9gBMWxJzIfzbtvS/YOi4VmEhZWZsYvrHV+Gjbvet8kwWJmnX8W4F/RhBQ==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-4778fe5c820mr205500655e9.10.1763531040486; 
 Tue, 18 Nov 2025 21:44:00 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84a4fsm35728828f8f.11.2025.11.18.21.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 21:43:59 -0800 (PST)
Message-ID: <670babe1-7742-4f74-8eb4-cdcfdd7fb7ff@linaro.org>
Date: Wed, 19 Nov 2025 06:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: add tracing events
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251118162513.730659-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251118162513.730659-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/11/25 17:25, Paolo Bonzini wrote:
> The replay subsystem does not have any way to see what's going on and
> how the replay events interleave with other things happening in QEMU.
> 
> Add trace events to improve debuggability; to avoid having too many
> events reimplement all functions in terms of (non-traced)
> replay_getc and replay_putc and add a single trace event for each
> datum that is extracted or written.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build              |  1 +
>   replay/trace.h           |  1 +
>   replay/replay-internal.c | 70 ++++++++++++++++++++++++++++++----------
>   replay/trace-events      | 12 +++++++
>   4 files changed, 67 insertions(+), 17 deletions(-)
>   create mode 100644 replay/trace.h
>   create mode 100644 replay/trace-events


>   void replay_put_dword(uint32_t dword)
>   {
> -    replay_put_word(dword >> 16);
> -    replay_put_word(dword);
> +    int i;
> +
> +    trace_replay_put_dword(dword);
> +    for (i = 24; i >= 0; i -= 8) {

Matter of taste, this looks more natural to me:

        for (i = 32; i > 0; i -= 8) {

> +        replay_putc(dword >> i);
> +    }
>   }
>   
>   void replay_put_qword(int64_t qword)
>   {
> -    replay_put_dword(qword >> 32);
> -    replay_put_dword(qword);
> +    int i;
> +
> +    trace_replay_put_qword(qword);
> +    for (i = 56; i >= 0; i -= 8) {

Ditto, etc.

> +        replay_putc(qword >> i);
> +    }
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Also, still taste, I'd have used trace_replay_{put,get}{8,16,32,64} ;)


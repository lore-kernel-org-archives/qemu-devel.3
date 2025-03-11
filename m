Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 09:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvUk-00040X-Lz; Tue, 11 Mar 2025 05:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvUL-0003EZ-Of
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:01:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trvUE-000252-Is
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 05:01:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso14865045e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741683675; x=1742288475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PTnMl+LwpyUuxwQWpr4yTuH+ktyfBqsl7s/0FLPGbnw=;
 b=rLl+7VJr7RrH+saJpxiTaDOKwbAFFkN+HNOkFfUF9FbcbBR8jsrKMR/rq6Omh76qJ6
 sKz0b82wExmqyA1r7EyieqJMzUKQ3I1977gvIfO+6CZW1do8H7FxXr/etQXmYb/MVgW+
 +2gVUzh6B44EYtpiby97nNEqJYxYpHPb7emE2XXa1bnRitLUjDSxGroeXNURTlOcVFT5
 Ob1VuJ7DwTvWg238jqfXaHOMnEQNtGXNpC44LgnQZE+MA1USc3eSAV+mo48M9u9gCF2/
 ZgLEYLHMw8D7hS+obUxRCBHf75oO/A2tc8a3XmXjMWrwlTzy1uUFt7ubikmh1XPx1au5
 Ey4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741683675; x=1742288475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PTnMl+LwpyUuxwQWpr4yTuH+ktyfBqsl7s/0FLPGbnw=;
 b=lt1RWIlq1LqePEbcP4P3nVpW9c+VkRnnYDMrRkyk62/moMKj2IEjggITa+Kc6XlzFo
 n41Pd94nWbWs1e7bnrl3a29XOOYoZAkwmOAPBK6cTFwq5XnYMvpWZaWJpSH7SMCG21bP
 LlSpiJ4QzMtlmlmdoBJajpxqcBdOzIDM+APqOC1hjl8sDOH/sNcykRq4T4WEaH44/zTp
 galu+7re5mHM0XmiQt2WLbNYO7wN+itepiBx3u1F0NYSD+/81+O5gDOa2hMfdvQcb3nE
 OMHBCl8OicUAs1QOtcH3sEix2Wa6JVn4odExRugY4/KeCZJ6exFifvg1yEWXD7RNrkth
 MeFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+yhL2KoTwENV54y884NGbQHCxhd2UASPXqBXcVg/9z8HtVeqRnEovZJoevwOfq0Z20+Sy5sys1p4O@nongnu.org
X-Gm-Message-State: AOJu0YwGeUnMEzo0GxzYHwr6bfJr/kFHtWAAtFCH0QdhCWrV2OBMRPZY
 VHR0kjR8co3dE9SsyggS79BToyFCGs5N6rMBmFspv0fMPb4CrZ24SuwfnoU8tNM=
X-Gm-Gg: ASbGncsobmz+3eT0t0sCh4WiAH0ktsCHMYsZ4x1dPsKw6BmnwkNu+pN8CJcB4l9972R
 gf6J4f1ADTlGVcZKI739QiMp0mHnXBVhUnEZd5ZMpZ/1vSEWvB00IQ0Nf2ZdcbMvXyxhc5Htvlu
 waZSb3MNcTbvmLngupdm34xBfuqcAZMQJS2LK2ZDwXTlv7yeO2jvJdSCZjMuLBO74+FZLefbDjW
 86as9v/74UO1uRauOY2cEYAlaR+JQWoI4Sb0f8jEltYfimyIkpIIo7DjN74Vv+U7tg8+D9trXue
 sPbZZLMZsT6pSEc/XsLZKSTk0yrtEmAVgMgxZ8qiABCCKRVHypHZ9PSE4lU6x0TrYkzdnlPOInf
 4SjTrdYS45ID1
X-Google-Smtp-Source: AGHT+IFN37Pf9IKgcGgzQlu3uQos5TTB9q1aXuFqznGpbKjXeavUg0ZE6IkYwUccgsbeXXThSQTw3Q==
X-Received: by 2002:a05:6000:156f:b0:391:ba6:c066 with SMTP id
 ffacd0b85a97d-39132d9870emr17337399f8f.35.1741683675564; 
 Tue, 11 Mar 2025 02:01:15 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf595a771sm71103315e9.36.2025.03.11.02.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 02:01:14 -0700 (PDT)
Message-ID: <f325c69e-6a30-4d16-bce1-8f7b4de72de1@linaro.org>
Date: Tue, 11 Mar 2025 10:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/smc91c111: Don't allow data register access to
 overrun buffer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250228191652.1957208-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250228191652.1957208-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/2/25 20:16, Peter Maydell wrote:
> For accesses to the 91c111 data register, the address within the
> packet's data frame is determined by a combination of the pointer
> register and the offset used to access the data register, so that you
> can access data at effectively wider than byte width.  The pointer
> register's pointer field is 11 bits wide, which is exactly the size
> to index a 2048-byte data frame.
> 
> We weren't quite getting the logic right for ensuring that we end up
> with a pointer value to use in the s->data[][] array that isn't out
> of bounds:
> 
>   * we correctly mask when getting the initial pointer value
>   * for the "autoincrement the pointer register" case, we
>     correctly mask after adding 1 so that the pointer register
>     wraps back around at the 2048 byte mark
>   * but for the non-autoincrement case where we have to add the
>     low 2 bits of the data register offset, we don't account
>     for the possibility that the pointer register is 0x7ff
>     and the addition should wrap
> 
> Fix this bug by factoring out the "get the p value to use as an array
> index" into a function, making it use FIELD macro names rather than
> hard-coded constants, and having a utility function that does "add a
> value and wrap it" that we can use both for the "autoincrement" and
> "add the offset bits" codepaths.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2758
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


> ---
>   hw/net/smc91c111.c | 65 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 53 insertions(+), 12 deletions(-)

Patch queued via hw-misc (except if another tree is preferred), thanks!


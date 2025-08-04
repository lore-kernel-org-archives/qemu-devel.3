Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460D3C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizfB-0003br-NW; Mon, 04 Aug 2025 14:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyAX-0000oz-Aj
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:36:16 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uiyAU-0004c7-7x
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:36:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76be6f0557aso3515882b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754325366; x=1754930166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D063vvEj0J9OMfSTWVg+LqERRLKQeyYGp2PncOECy8s=;
 b=fdgxXjuDrJUM+O6+VGB+ukvd58RentBfyVipv/iVL+fRnAK2y2RvkEkIHzZ/YyS/8O
 xO1CC4RWswUUO2oL8AVg2VMQETfLkDTCXPZaKdG+XjpeLwsNGamP4HJw1kn7ZRXw8Vsg
 q4kqO1d8fVhuR4G1LUw7BdtG3cEIaHtXL+yhAYp7zZ/bX4MkuaomCYNcvUcKRPo3wb+J
 ripq58fn7DLv5YtHzsExXfs4jtUFjqmoRhi2xza2IJEsXgGr6aRyc2TJQ2uctSe1o9XG
 +DTiYGDPEEvdmZ8lFSkGWs5renECdYNNLWJ6uDa1KDPXRt8y1V0EPiyvC+5YHu9sDDr7
 RdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325366; x=1754930166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D063vvEj0J9OMfSTWVg+LqERRLKQeyYGp2PncOECy8s=;
 b=YcNsZA+RgGFJ89NERc6pBwQZMME7MWztDyHi4ALYdkGu8HfIa4YQQy+ijh2Q9REREL
 LxsR5th7S++4xCHBA27MdvgKfX+yqKJjtxFKWFRFozWtgTTre3ASNpOnqvjUBS/78UwC
 9dvdhZiGKMixxqJYH1SRYquBRqdQa5gjY5BgzumDYRzq5QBv904V0GF50lcfI5HV6DXT
 EZ9r7/hhzwwWvqvQUc9T0EftIooDMR63YdV94s3djFukenQgOPFkFu1tSi6HSFfbkHt1
 5Ou9kjMjcekja2jlek55kAkLdG0W3xSW4RRTfHn17hJgRg/964jDF9eQCBAkQF8MB5gc
 nilw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyd8+l7sIEgRDdIu9DzCoXy0X7sLCb3QNY1s7ShIsTnSbDnXS4IioT1xlh/a0zsqOwAimSlM36m2DG@nongnu.org
X-Gm-Message-State: AOJu0YyfssKWDW+VowQMSZQm0JyEmQSZ0F/9mIJvxutDdk9D+bWXwnSX
 UEDrV6JqOilaj8+Ij9eZ2dE5n4fl3cqNCCg1QrcHQbjD65xKgJSNjaEh64RdGcSA9n6NCqd1kEq
 YmQyk
X-Gm-Gg: ASbGncuYBA4KwL0mpoHoqu592Mt+sM2ikd0t4IaCMCTzbFdcEe+w02+I5u/6neeOKae
 1OKIq0eTlmpQYNU/LvIX1uP+imf7lgikR0efp2ESkXgE9zbcCNEn5IRqlhkpUX8bjHq9EtbvV53
 u1cMtnh+bfQaQbG3BBOrzzW4atJB88LZdV6BFZusQk04n12zZQRA67e2WBBVyDN2FN421PEgNAy
 x4/Ont4HkpL/49WidaKxoNTOWoXD+OeXhZbkoGW2v5lgNiceOMzoZ49fF50tJTYdkiLEHMKj97x
 UpLsrVgZaMOgPy4pyEUP2ghXufXt8wOugLCboZOfoq0DIQ+YBjpN6FmQsklUyrhmxyUDb8cpaq6
 U9DXUntBioAZunvkdoxIABCR1pvd32i5fVbY=
X-Google-Smtp-Source: AGHT+IGuuE6mknhNCAZoTqCLJK4mIGqzxnx9blivFxgD9ySAVc5eTRpZpRWJkfm9vN8bmFsMvmq+Jg==
X-Received: by 2002:a05:6a20:12ce:b0:220:3870:c61e with SMTP id
 adf61e73a8af0-23df9717c23mr13643392637.4.1754325366229; 
 Mon, 04 Aug 2025 09:36:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b7d9dafsm9173403a12.23.2025.08.04.09.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 09:36:05 -0700 (PDT)
Message-ID: <f8218125-7848-48ce-a822-7f64594695dd@linaro.org>
Date: Mon, 4 Aug 2025 09:36:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/4/25 5:57 AM, Kohei Tokunaga wrote:
> Currently there are some engines that don't support wasm64 (e.g. unsupported
> on Safari[1]). To mitigate this issue, the configure script allows the user
> to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].
> 
> Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
> this flag lowers the output binary into wasm32, with limiting the maximum
> memory size to 4GB. So QEMU can run on wasm32 engines.
> 
> This commit adds "--wasm64-memory64" flag to the configure script. This
> takes the value to propagate to Emscripten's -sMEMORY64. 1(default) targets
> wasm64 engines and 2 targets wasm32 engines with still enabling 64bit
> pointers.
> 
> [1] https://webassembly.org/features/
> [2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   configure | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

It could be worth adding the link to documentation in commit description 
directly in configure also.
As well, the --wasm64-memory64 option help could explain that in a few 
words.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


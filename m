Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8083D5B87A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRW-0001bR-Ro; Tue, 29 Oct 2024 02:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRO-0001TO-L5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRK-0007CP-OI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so51730605e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182248; x=1730787048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dr5gG7alOxyt+rvgQ6PSLMiyYakYCBZKPAhsqjmYRJw=;
 b=kHuPNgoE15Uakj4PLiu9hYyTk/zlGBDJCYRhxXTfHdmh4UtlkEAHPdGl6w9jXdXBwb
 pm0tmPBiRxfAI/l7SGY9s1EnWUH28cPKQ80jyXr8eT+oII2uYdB+FJ3japFhUdBuY0/n
 vYBs5aDzZzqjBtzim7QaUAnFdT5WtZ3WpadK+H/baXEwUIgup+yvKg5Xn5khagFGa9rl
 n3KKJx3iyeXetcYq+kNfrFKY/kYI5tbO7EgVlfZROzT8gZ0paasXNH4b6U/mXIPXUbOg
 AkAX5XvjuxeWhbkZX9ZYw4yR+yv4pXj7OXt5GeMSBMiMTD1ouJVvzWL1IlBPohGn3ONR
 MnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182248; x=1730787048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dr5gG7alOxyt+rvgQ6PSLMiyYakYCBZKPAhsqjmYRJw=;
 b=jqUge/qTOtRBu+djlU7kPml2m2P/Gy+xbErdR7jjjykPQ+PLARTTwTAJy6oNzsD6pw
 gz6yGSG+1Ih/fn7hrFvMnxi/6NsPQRV3MV3H6OG+vmZfyB7MZDw9jSPGBJJ+C2MM7x0m
 YqJCazVmRa0BoFDJSS3noB17uvhnf9oXMSk8eoNW4S5XU3iZxDc58+gOfaiY6XwT0jlK
 1PXWiLcIJFJsqlJHYmLe1qBztP3UeZVSk263alt0aZnfHZQzp8L959j5K/mcbm8ORn/t
 g01iUoxpHDo+yOll80r02mevbqToJbNAJQ8xdNd8HFkDwXEyBPZLO280IJtIBWTJBT+8
 /2Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNMajzJQJoCX28yM/63Jt7WboieuWkKGE5S46AOkfuN66J2tJawuOBvxaLlXTc2oQ7Nt9zY0Psj22R@nongnu.org
X-Gm-Message-State: AOJu0YzfJTv8Z2bGGzQ/WnZdVcFpjacYaCHJnR+muhPSp6563gqDd0hf
 48j7QKLigLC1nIkxf0qFhnNt6cS4fd71Yh7fXK4qlY6Ksi8u8RwEl2I6PMHRBEE=
X-Google-Smtp-Source: AGHT+IHwLDhKto2V1uR7aBCIMFCzCnEasQGS77vOTh2r94LTg21rkudslORAWlwk78uBQtMQLmayIg==
X-Received: by 2002:a05:600c:1989:b0:42f:7ed4:4c26 with SMTP id
 5b1f17b1804b1-4319aca5580mr82238635e9.12.1730182247613; 
 Mon, 28 Oct 2024 23:10:47 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f5e1sm165298915e9.14.2024.10.28.23.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:47 -0700 (PDT)
Message-ID: <24aad2c1-68d3-489e-a3cf-f6cc9420728f@linaro.org>
Date: Mon, 28 Oct 2024 12:19:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] target/m68k: Initialize float_status fields in gdb
 set/get functions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we use a temporary
> float_status variable to pass to floatx80_to_float64() and
> float64_to_floatx80(), but we don't initialize it, meaning that those
> functions could access uninitialized data.  Zero-init the structs.
> 
> (We don't need to set a NaN-propagation rule here because we
> don't use these with a 2-argument fpu operation.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Spotted by code-inspection while I was doing the 2-NaN propagation
> patches.
> ---
>   target/m68k/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


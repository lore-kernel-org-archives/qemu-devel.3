Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A82D5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRI-0001Py-Sc; Tue, 29 Oct 2024 02:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR3-0001Lp-I3
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fR0-000774-F2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso3763121f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182227; x=1730787027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LBYlIYtb56QjZCFiyBqEfxu1SvmGl3VLxj/CV2vqNcc=;
 b=l+xJYClmbjEo6f6imrKankZAGr1LwALRZGIFzFgQDsQH/3DXRS23oiUk0LqUGzidTq
 8nAp+0i8g0YjBQXWitJiwjUCKBE5aosDwWEzLX9vp7lZQgoYd0D3foNRq84dfGGnpWk4
 0xAP6cGvo0xsQu/yKx95AvS6NrOdH4qLgt78uMLkWRVxlb0iEPxjVvb+A6K3dpRF8Jxt
 N9OCdUb6AKIxj/JAFIfaEgI761ZSApyFF0bbCMgIIyzugzD42DkqjBrOfG4yZRchqtgs
 QUl6ir74PscTCeqOtkMe+PCXqDKZNh/YueEUddGaT1E/nvLUV4XmOIbV/yxRtexDrZF5
 wOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182227; x=1730787027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBYlIYtb56QjZCFiyBqEfxu1SvmGl3VLxj/CV2vqNcc=;
 b=a9yricidgBikaT4puyiTA7S1Uv9mtP4P5tgxLFoDFHUAa8C3Pwcyl74zWpjdB0Min6
 Hu5+sQCq4TevQIoqpAXbVLtfpsa5QFZO0xVYjvHzJCXcP4GeSaO465H5mul5HU9MJiXA
 6E6i2roz8zI0QQYws/xeiVk6z6KaTdeHLppLFsQi0k2b2J7+/siGZSiTUjizdwjXn7YI
 4eaDSoZVQcpBLisUmUuEzTT000M0kGcWluSZhD3Hl/vNRNhrsUFOBwOEeFLjQvnAEjuE
 9YqrpeJuYUXUfjHGPUbqwldRp39p8/M/Cw7beNuYALIQak22vmGdUciE6ieywkCtgef4
 SdsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/BNOhDbbn97YRNLAZUuQPeOGbLfx23woogVgVb/v/6n2t/qfLiWmlkluJkcsdDen+NavNUgjccJ1j@nongnu.org
X-Gm-Message-State: AOJu0YxwUYZMmv0GO18h5VlqFH4ZrBhMGPb42Y9zUivqaPyYljpc5U75
 ftKoA7qT3plXRBofpyiL+YCoMi0dnaq4jZktySJuXUMgWGXI1FVrDxFkyiCytig=
X-Google-Smtp-Source: AGHT+IFdtFbMOj449aVu5jRWariMT4S7TuC6Wj0sPDHtWdxpM1+tORNum1Aw16GIPVgVJsHqPw+JNA==
X-Received: by 2002:adf:e2c6:0:b0:374:c92e:f69f with SMTP id
 ffacd0b85a97d-380611282f0mr7941989f8f.16.1730182227467; 
 Mon, 28 Oct 2024 23:10:27 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b70bc1sm11560253f8f.70.2024.10.28.23.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:26 -0700 (PDT)
Message-ID: <f1e6c7d1-b976-4b5c-af37-31e8e1a6352f@linaro.org>
Date: Mon, 28 Oct 2024 12:07:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] tests/fp: Explicitly set 2-NaN propagation rule
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
 <20241025141254.2141506-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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
> Explicitly set a 2-NaN propagation rule in the softfloat tests.  In
> meson.build we put -DTARGET_ARM in fpcflags, and so we should select
> here the Arm propagation rule of float_2nan_prop_s_ab.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/fp/fp-bench.c     | 2 ++
>   tests/fp/fp-test-log2.c | 1 +
>   tests/fp/fp-test.c      | 2 ++
>   3 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


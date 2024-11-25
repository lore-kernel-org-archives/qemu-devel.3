Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EA9D59D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgwC-0004H6-Ot; Mon, 25 Nov 2024 16:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFgw7-0004Gp-I9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:48:03 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tFgw6-0004mp-0X
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:48:03 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-724d8422f37so3550926b3a.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 13:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732571280; x=1733176080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3bNvHpfTjRt7/bPSvTZ0d/tYkWYtP2OxyJf3WnQjOV0=;
 b=JR0bPzD2otoBLunhCQeShZJNyXfTJp6D9xkeBEyPFQMpCsjXLAZn/FCtj0aqHBtt+N
 v53Aa5nXWuuFJIRRtNL9wMo8FV1Z0yIXn09dvX/voZDDqO2st8YRMEN+v/NvQLJyH8pZ
 OtooSdRUYObvbt9ZfAFpU501MlVys0AEIlCpHRaR1AQV6e03Y9opyteB8lc6h8qSRcVp
 9zQhekk23hNEC18FlXh4Nrnf73+OZQAh1eAEIQVewMCirFN8/hmYN80sAjJCU4ZbtB90
 zDGYVFB5ivVjUsmXuupSqvmFJRV7Ffa5RS8U1o04nRj2sdeUxb3n0kUJGcUxYfxC311h
 zgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732571280; x=1733176080;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bNvHpfTjRt7/bPSvTZ0d/tYkWYtP2OxyJf3WnQjOV0=;
 b=VSBTS9GDGcPIUDr7CWCvecmb9q3YG+ZBhQYXcAo48hax+1/NS1B+wurKP3JUoqbg86
 SGBDSD+HFU5P0zw76ofcPwiXKtDJO3Hs8BocsfRE4cbOLuK1gbUS3G3MaQUaIsYm3HdU
 /Qevz/vLxH2Y0YiH7zuDYigsMLm3WbzBiyqksllYu1ckb67/j+F0T+w0NR0Az29BwHOY
 vKv4gbP+DW+jSqI8fhuE+xiD+BTdvvtSQGPKl5WYBiJxInll6lAIxAOcL1yiGGyZbKGV
 DIWpow11/qEn3iTo/jax19NsbGfsL+X5nyZ5Fdcr6yCXDUzHTV5Ozd8Ogho77RlwU+7o
 oLUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWLz7h0dLPMHRxXjI3yqJkPx9z9PZA2yJC5vQefV5SNv3hbRjejalOnCV9g7lGRab7faV2rK8AiNxl@nongnu.org
X-Gm-Message-State: AOJu0Yw4p0pl8Ee8xDWy9CFQxLbS/lLrF08pbsQzrBCUZSpj7pFs89P+
 +1bSE75lDoMvT7gzkEqNafU34UHSzJrn2iq3IyJpRGzBTVoqkMMzOp53uiCJitE=
X-Gm-Gg: ASbGnctwkFAuQ4r9fm5EI5VSqqcy8rjrAivEl8NRjWVLJnrdCjTKHToGjdUPZ1QUCrh
 XS1aUcXM2c+oe6UR+5FHAhYlRDLSWbZpQ58QX7yO++dPQvQ2jQAjuUNAmU7MYSX9N4wMdCKDqz+
 7JSHw8IT8l2nUzQ3Df5vGbXnx0gxxjzMaJ+VNZeRSbi/SrAYVn0q1T2vnfN19GHmqZZJx4RGuxE
 JX679wAc2exEMI+Eetd+WOiCAb9TkekwMUoWSXB/q9ru51b2OH93MrE5OqXssT9J3ptcc/QgqxP
 aWj0Cbr/bVyc+X7C6h5A4A==
X-Google-Smtp-Source: AGHT+IFAtOAy9meIGGTX1vckVBbOJBQhy8nAY4xSePvp5NCZqthvXrCH4CGpt9+FkjVLuPPd780YpA==
X-Received: by 2002:a17:902:ccc5:b0:211:6b21:73d9 with SMTP id
 d9443c01a7336-2129f81e8a5mr217340945ad.37.1732571279968; 
 Mon, 25 Nov 2024 13:47:59 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm7177583b3a.65.2024.11.25.13.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 13:47:59 -0800 (PST)
Message-ID: <b01bf9cc-45b8-47ee-a63f-667150209e16@linaro.org>
Date: Mon, 25 Nov 2024 13:47:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
 <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
 <05108195-009e-4d06-bc79-065b1e3432ed@redhat.com>
 <d02f2221-ffa6-4232-bfcf-a19deee6d1ac@linaro.org>
 <CAFEAcA9vPC40B1cJpuzhN2-mfQG4sY6Sth8jhB+9RwC7aVvDsw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9vPC40B1cJpuzhN2-mfQG4sY6Sth8jhB+9RwC7aVvDsw@mail.gmail.com>
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

On 11/25/24 09:05, Peter Maydell wrote:
> On Mon, 25 Nov 2024 at 16:48, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> Before sending the a series removing gcc_struct and editing the
>> documentation, do we all agree here it's the right move forward?
>> If yes, should we apply this to 9.2 release?
> 
> I would prefer not to put it into the 9.2 release -- it's one
> of those "small change with global effects" which it's hard to be
> sure don't have unexpected consequences[*], this isn't a
> regression, and we're already some way into the freeze-and-rc
> process.
> 

Ok! no rush then.

I'll send a series with that removal and the doc edit (+ fixing plugins 
build for clang on windows).
I'm just waiting for plugin build with meson to be merged in, which 
should be very soon as Alex already sent the PR for this.

> [*] though in this case the stuff you've done with comparing
> binaries is great and very reassuring
> 
> thanks
> -- PMM

Thanks,
Pierrick



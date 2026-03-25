Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7090109C05D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vy0-0002YG-Vk; Wed, 25 Mar 2026 17:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vxr-0002PG-43
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:40:36 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vxp-00012l-Is
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:40:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35a1f3f07ebso144461a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774474832; x=1775079632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AqY74GIkxDhgv9giN7CVEBVtSobQTerq/fbQw/LQO6o=;
 b=uAVFYOliFb+DatQvq5YWr2IQH6RMe/vgCOGvjHbo+G3wVvxOimGapFjBPCKLHaux1o
 J7jwP7IxRPQnVAtTZErmu6I1zfdVQTu94cPwhyc0SrCprrtmrYOpocnATCzigYFNCWFV
 WC1MFFcETBrQupDeohqRhnc/qqZa+elYRJqdGfJUHC4+J/MxD0m7I7n+RtaYh3RrvyYN
 s0KsfaD54aK37qC5KBMjM6LeuuPre/iPiqYrd8PYkoWliTc/eP8S7bYfudYRBkpkTFiR
 BX0mN/pgKEIDF36K2XvqFJxIs3/1dZm4W7vNn3OGWiYXr+bGrC57Yj5vK+4qGzQ3r6Z2
 cJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774474832; x=1775079632;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AqY74GIkxDhgv9giN7CVEBVtSobQTerq/fbQw/LQO6o=;
 b=QOlQURiMqmreB22zlheAFLHWgtBl+tNY32ceWj4yHz1P3D1JU7yNj+Kuaqn1t50gP8
 a5fMu0WuYCTQWJMronFZAO35BeCeznJOP0jTPZLKSYH1sgnmTpC5bN+88ui0DHIF5BAt
 RV3KeKXbXMIk0dexxwfFC67rsRt48jsSRLsErMAupoiYnclNKfjnaYehbTOBT4gMAWiJ
 7ewZJvQ4yfrAePTTBGbQK58RZaxjFuQHMTl9AhrKo5LjkBmGZ/0qypz84Ws77fCs0hCQ
 6MtFBXTSysBxbM/NH8JSRgJ2X4BgCLQv4acR+xLLZs7KWMYBE5sL0JGJuAsY6ifOEgTn
 t5bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaFI7+jEmCb8ssZi7+DBIP7q/63Qx0tpd94aGhZfksyoQ+xZwGbCeqX5DHNJEE4Xe/hTuuFJKUHxpO@nongnu.org
X-Gm-Message-State: AOJu0YyVV6d0IAAfJlIULHhObYc4G6iBgflElKiPvUgRdGFGg7tutSxn
 bf6uaWOhLfP/cKXoz5rBfVu+XiPdo6zXE9b+ndydtJcSWkUqW/c5J2aNTDxuc1pllRk=
X-Gm-Gg: ATEYQzzHXQhrZ4TGSVu3k1TFYo8tHLyybDjfKZuAJ78SoLClgRGruZddwjKJfM+vUZF
 x4NZWbPU0/sDq5w/B6518ZrkvZezutzyQcshjYC7qA1chqZOh+3zkJnfTSRzmo8yKidlOpThGZ3
 lQxkrdTW41WGrBTcqEYaSkrG+XLnr6/q3ZNeVXm7NuQ6Sq6etgf2NdPTn6/aRlWdvr3UIvABTpY
 D4ID8hO1wTpXv8oda7Jk6N+dNz0chhDYIKbYu08BjUjAqznGpfwq/mKC0PJvFPVYas1szPgtAep
 VzTpH6dq5ljqYBQQVJkG1FKst2WIxrNTHjTlG1yVyIaPO650yJWUP4XGaLOwnNmIgxt4gH+S2nm
 kvMNd8xEY7A9WgdQS+05A8MG4ZpKjTdKgQfLXJQGxlu8WTAEy1bxynpz9zWVsbDWDXmP+M61gG3
 UVqqEF4zbQvS1kWXJWsdlt6QdJlgFRoc5jdpqQPFac36zF66+JEKMB91sedPscAYOojpcXr3jGT
 kZ/u4w=
X-Received: by 2002:a17:90b:1d88:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-35c0dd43d5dmr4527017a91.22.1774474831630; 
 Wed, 25 Mar 2026 14:40:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76739b5ec9sm347353a12.32.2026.03.25.14.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:40:31 -0700 (PDT)
Message-ID: <a2bc0441-1d8f-45bc-bb6a-82ab93180836@linaro.org>
Date: Wed, 25 Mar 2026 14:40:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 05/10] target/sparc: Inline qemu_get/put_betl()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> Use TargetInfo target_long_bits() helper at runtime to migrate
> the FSR register as 32 or 64-bits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/migration/cpu.h |  4 ----
>   target/sparc/machine.c  | 17 +++++++++++++----
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


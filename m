Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABC9C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 15:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURnS-0006lh-1x; Wed, 25 Jun 2025 11:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURnQ-0006l9-Bb
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:12:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURnO-0002tD-Hz
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 11:12:20 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748f54dfa5fso29586b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750864336; x=1751469136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/qMeMhPelSpcJ0gJ14dnSjD3jHGx1/A0gA2Na72Fbwg=;
 b=xuoh4AQaWUssgL/BZoFzq03nS/wNSOlwiey22Tna7i9GODqBFHqAr2fEtoNL/IIbvK
 2pTZ8eSZ69aaacTuxvNr9K81HuAWeJdAqhJgl87uFSVXyATq3eGZp+jJnHVSkukM7fFQ
 jkEsAuo3R53U5CIsQNCNnqq6jV/ks6Hlvmp6iGeGBOmGM0OIroYgztiwcmkRQFH1mzMX
 h8SVcKi4I6Wj6LyX+d5ojRHG9dtlA4wb6BC9DBb0/L3VmYZugSDhCOxqKm5Vb67d7qBA
 rUalqf0sXneQMZ+SZLL/UDd0ufdvxrD4n8jJkprRnB/IltCQTydD+cRJpG+nqjd0TX83
 6LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750864336; x=1751469136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/qMeMhPelSpcJ0gJ14dnSjD3jHGx1/A0gA2Na72Fbwg=;
 b=Wfez8cB928ZBtqEZg0GOFgfRfDOBfR6Ft/mKEaajZD9pDzFygxFgQmxrM6T02IffUc
 EfOv7JdUf+G5zlZ/xwNAaKhrfEu+SwleILkeJ4iCXae/8c7Pg+ctossDx1E2U4TATkHp
 tmkfofWKGU6dWemVQlPqxDBY+rsyW+9xKaCZOQgQ90IgbiHeBRgMEuFcXLKNGmlfhH0r
 /KU8eav2g/4g1IDaXk93z2nN9xVayxCjVBAxKH4Pn+RxKAC8RAcEYAf3KTuZE4s4QQxq
 UQnPCQQ1gvPJewQPnfDsHIYdZFg9Xx0qBW0CXAMfw+aq9PGVBaQclkRtXQm+zA+zNY+O
 IsnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC351g1z/rssoqgYNWRMBwzpceDGjDQsBrJNSH29TjbJhHUOsA+lLN5yimeLlDrVgQ8uWHH3+pz9Lc@nongnu.org
X-Gm-Message-State: AOJu0YwqXiF4Xo0RKAZ2n4rrkc8UZMM6+j0gbyEJE24aAMayi1m/BvtS
 8QRi59slio5iaCFxgkF89tU0pE8kuMpSmdLo04BGGbfKELmg1HO2BxI+a8zRaS7A4v9mhP8DomO
 kdj6JBaU=
X-Gm-Gg: ASbGncueh18a3LfXtJHQ4tzGRnUX4uXlWHioD7HUddALAkEZXOiazLY3EDSiC/7Hv9K
 awCrA5jpitc0EWdo4Fvkf0UPky+gAwX2yAQYbibnfY4QPE8EDOb0D6+93PADyw/PYo0Z+zxb6nI
 V2/NJZbKXv+D+SW/w+Xuo862BIzcWeDdmJz2jmnrwW1NKJO53aa/qBUa3Ify+8Rtbvb4xj+EmCm
 HCdcVA1AuqSyqzd2DPxzneEFho4spjls3ujQdQiUSqOnfxCWg1/Iv0bZOg2flonkWz7RSS3R+oI
 gBfCRKBaI3Z8gJUUBtj3B4m3oumNTyKVbI9iqx508zrtF036hQuKlzUlBMqEiKmayZV1E+lFnvU
 JXBC+atENrg==
X-Google-Smtp-Source: AGHT+IGCI4OltHnjeZ8wmnsoagl2YId79GZjZBNxf6qaTX19UI8dhcybN5J4UzW7CwbjgTdGFziIHg==
X-Received: by 2002:a05:6a00:2302:b0:748:2e1a:84e3 with SMTP id
 d2e1a72fcca58-74ad4410aa8mr5718334b3a.8.1750864336323; 
 Wed, 25 Jun 2025 08:12:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e09750sm4695867b3a.26.2025.06.25.08.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 08:12:15 -0700 (PDT)
Message-ID: <b5005da8-ff10-4644-8815-b288a719e0ee@linaro.org>
Date: Wed, 25 Jun 2025 08:12:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/26] target/arm/hvf: Directly re-lock BQL after
 hv_vcpu_run()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250623121845.7214-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/23/25 5:18 AM, Philippe Mathieu-Daudé wrote:
> Keep bql_unlock() / bql_lock() close.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index c1ed8b510db..ef76dcd28de 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1914,7 +1914,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>       flush_cpu_state(cpu);
>   
>       bql_unlock();
> -    assert_hvf_ok(hv_vcpu_run(cpu->accel->fd));
> +    r = hv_vcpu_run(cpu->accel->fd);
> +    bql_lock();
> +    assert_hvf_ok(r);
>   
>       /* handle VMEXIT */
>       uint64_t exit_reason = hvf_exit->reason;
> @@ -1922,7 +1924,6 @@ int hvf_vcpu_exec(CPUState *cpu)
>       uint32_t ec = syn_get_ec(syndrome);
>   
>       ret = 0;
> -    bql_lock();
>       switch (exit_reason) {
>       case HV_EXIT_REASON_EXCEPTION:
>           /* This is the main one, handle below. */

Just moves the lock a few lines up, does not impact what is protected.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


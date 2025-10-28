Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC21CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhxn-0005qt-2g; Tue, 28 Oct 2025 07:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDhxk-0005qT-V6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:34:05 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDhxV-0004Mq-Sh
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:34:00 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so1040496066b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761651225; x=1762256025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oqywvgzht8w+QYLBZHYhDDhSx7n3vcr9BzmjlX4F8Wk=;
 b=YXZTUnZD85ok7amHaCPkCee6NAGyli8hfHTXjrioXxOgHXESgUs/p+KuNy0mN7FsXd
 C0AbPdeWLASGL4RtL2ZkmIk9jaPRueQJLux1unRlctAJg7f2C4oWmLiB1m9Okr6tsd09
 cTdTa4LBfnAgtmjYBwX2Ve/GlD5Wx8fkznmiZKuXUci6fO+p2iNx3jGHMwuzWRB5ptQi
 TflR9k5tQdu0W1xVVi9owWNBPigauZdWV6GoC5YLVMVnQSlGmM81PIcrOYKn1HTdGeCN
 fYQb9a3huAVj4UkgK+0aCiMqbejRkIDz/DskFxgiGx+TysQ+0+1OTudixRq1KOvVZoMZ
 +iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761651225; x=1762256025;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oqywvgzht8w+QYLBZHYhDDhSx7n3vcr9BzmjlX4F8Wk=;
 b=p3AMzjq/XbwWDHIJIUm58bRtNAVDx9mLco59K9zfquV5fME3aZEwxUAiF45ozk7XHO
 m4aSc5QTdaRjXbfeNvGNEViETduUXqJH3IWkWn45SkHtOAsQbf2YhQcpoc7R5jfkMKyd
 9OfH4/vSrrWoY5x1ROMLiyESpSzY2DlJr2QhQZLViP2UWPIdAfuCuCwLg+OWV+jD5moO
 JBCRfHi/ebqbh2t1TCdvhBswULRWvXqKPVAUma9hRmhiHdHyBaIbB8gBH1QZvT69UmUO
 FerEkHwzqT8JklqT30iUExou0yKang4sWNDcd5ElVfXI0666hKd65NRTujMBwqCyKvoy
 tPfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrzgwRGTOSyR/TUefcIrCY+HG38k6zbmhr0R13hJ08v3tgO/X883PzlsdcsK/E0BC3PrvM+AdOM+wV@nongnu.org
X-Gm-Message-State: AOJu0Yzakkh7x55iJ2miAM7iTDqf6IZvhHgf9/emoGwK80+58CUNrjpG
 K3W1geMNnaMY8fpSCGC8bM42aDVhlxcicxZNiN2C5/9lJ0ZRSr5pZuEFR8ehxh5D3Dg=
X-Gm-Gg: ASbGnct6WPGd55+feaasC05t0weDKlHbhZeE1inqIqUouzKvS+dIhbTShRnsXgGBJQb
 VifNniwzN3pC6qlchKWgWJVeywm+XPe7Oi/JmPx4z35jIB0CIds+Gg/h4H/yrr7lIfYvY81VL8z
 /ISsPTh/Rjm8oZtNZ6GuZusAYj0azXNJSSLcyL3Rd9Yu36bLFwels+kF/MfZWpNd1PaTdAlnU8h
 jAoE5VDta2d/Ho+I43MN4jvV4lIJ3/DoRXv+/WYBzsIJSCRvbULM71/8RBd5wckJgMqgSBbuKaN
 yIV4tEn2zsTVZedw7fzjAQ0po+gHH83vudBW0kY54zJO/p0Le1vzIG3BpEpKT1QAogg/iLtUjqB
 gmOHGAq3b0DChUPEEX7Y/1Xz2Gh9fijouslWPGtVK2V+F2fnqUD8qKOY2kXIm79ps7I/ipxGrgk
 4UVQzVL51PmccW05El
X-Google-Smtp-Source: AGHT+IFMoRg1/y3PZv2+uRaFlAvgg4YnbPPx2lLpiafEXjau4rq+KbbGtpDpF/AvigWc+kF0KMtaaQ==
X-Received: by 2002:a17:907:2da2:b0:b6d:7859:61eb with SMTP id
 a640c23a62f3a-b6dba4a2ec5mr312011366b.29.1761651225369; 
 Tue, 28 Oct 2025 04:33:45 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85369675sm1073348866b.28.2025.10.28.04.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:33:44 -0700 (PDT)
Message-ID: <434ca97e-7a77-46fe-b6f5-2be5e9387743@linaro.org>
Date: Tue, 28 Oct 2025 12:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/59] target/arm/hvf: Simplify
 hvf_arm_get_host_cpu_features()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 10/28/25 06:41, Philippe Mathieu-Daudé wrote:
> Use index in the structure, dereference &host_isar.idregs[] once.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


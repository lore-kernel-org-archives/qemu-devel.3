Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493E5CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmli-000794-4g; Wed, 03 Sep 2025 08:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmlg-00078C-8R
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:39:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmld-0005hX-Ig
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:39:16 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61e8fdfd9b4so1915812a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756903151; x=1757507951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z3dnTggf/aXiLs2mixonXKXQs68HM3zX5ZINDqYdG1c=;
 b=kbKjAPFAqttTQFSxqw+mz6S7kMAWZmMJmoaBZ9SZm9MEaoXMzZ31sKYO4+yHeFtA0u
 tRhEJQP6X9vzTD/fdVX6ESeKXKd0XIr4MjsFZQ5zhyUGBW7XZZueyHJvgUVwMM9URkRS
 orVGg4FXDP949G3O2mOzpch1uHINiFq7GzoNht7UkuXRaU8FRcBydSPym45ItJLlHWIf
 wm48cA0O4mXU9sDzdrvMXbMFvY5xPAjD9TMr1Wo+xEoV654pt3WGFsFO6CgvSJCX8Nq2
 MwWi8NRInn1FrbpXMvUTrvhlLZNlPaZ/4hFTPAngEM3HY+iHu7YRKgInZ4lFdE5o1S6i
 2G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756903151; x=1757507951;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3dnTggf/aXiLs2mixonXKXQs68HM3zX5ZINDqYdG1c=;
 b=IbhyO/GjFfPXJUPytobbgY3rruzuLUwsOIVubf2KGTdGoi6J8aVe3kpubzb2j3yX1f
 Rbd3GdJ5RtDuIcV45sbE7tNzEhenGcvmDqjZVYLYNhvYs1omlMEMXT27a3ms15LdQAEx
 3iZNk/6ZGnl28oi+nxMST2TKUV6PhGYjnmx67ggtPvMR0LkS5AaA10fTIx+Mi/Fg0gms
 4Z6+MFkMU8Eyd7RRXlw+o5TFmGGp0HisyA0EcJMlKnIddvzS36tNSOTy0C8oB/hlSpym
 VsGw0V7SgRGFJO4Ptd6taLIexNpiBSLlB9HpoZ8Cg05wEQrLthUJRp2usqK9Ovf0knFo
 EU2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+HYvqlvGsZuH0ehylMOP8cF4ghraDW79erqzNzX1mvTn9JvAOQ/B9r1hGP7rIhWbdiScLuBL05d5R@nongnu.org
X-Gm-Message-State: AOJu0YxFFiatBNp96T+DNVypPESP+g7Q94zY4zliFltkkB6Pq84OOXaY
 NHVOKzisLjfx2ddCd/vepj9ij9AUpQJBJWT1Wo9wNKzD36Q+i4U1o3d5RkhNBD/JA1U=
X-Gm-Gg: ASbGncsAmkKYsm2A46sbVPpknIjBEvuRc1o1hnbABDNmNAXBnUWsKSTfX+NQycjZQKu
 3QxN6/vBYVxjGIbPJQth6pD8TrLy2mrXRl9B4hJ9Q00fBrTuKBPsVWqP+4z37BcgzEJY1cH2KcT
 YVPeU19pBWpN/sUUM85yuQOHWJ2+tbZGOjW0ThaS2tkre5LC1h2jaN6nlPLpBocTKlJi6QhxrfW
 aF0NPcjDp68IH/HuR/BB7/SE+BLuXhMCPnSdOhrXkxR5+TtxHLqPuYO+kfjsY/DAz6DgNxa81pR
 WuWLmcAdirjI+2BOOKsNA+mR0pkG6qRFKYB0Italwpriip8QDN4Jy5Ulz7sumcWVJfhE67An7zT
 gYQkoADeUxhTrlKqpkYnR5gN+NYe09fZdltCvucZWFQZKutO2Kb+NbVdVFKjKRP288WODpeS+Nz
 laNdfNgA==
X-Google-Smtp-Source: AGHT+IFMVaiBiu2X/r3QXWVJDz+O9j+wp2iaJ86qCxQeGkQXicDdtLEJ4APQsJCWltcqVmG5msEH5w==
X-Received: by 2002:a05:6402:2681:b0:61c:d3f1:9b02 with SMTP id
 4fb4d7f45d1cf-61d22f522f3mr15137413a12.14.1756903151470; 
 Wed, 03 Sep 2025 05:39:11 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4bbd09sm12070989a12.33.2025.09.03.05.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:39:10 -0700 (PDT)
Message-ID: <b5896eba-54cb-48c7-93c4-e9191e08bf52@linaro.org>
Date: Wed, 3 Sep 2025 14:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] cpus: Trace cpu_exec_start() and cpu_exec_end()
 calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-common.c | 3 +++
>   trace-events | 2 ++
>   2 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


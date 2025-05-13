Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D53C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmXU-000721-K5; Tue, 13 May 2025 06:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmXH-0006ye-0x
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:06:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmXF-0007rD-4Q
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:06:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso40277745e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130812; x=1747735612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rkdCcb2R7zHmNwKVh1SyhRx36X2sK+MN/Vsql2qiJgk=;
 b=eQOTyEEm8XJgvlynobMzxzae0/EePqsPwP5V5sxoAFWQ5do12DjfJhvTLKbGJUk08X
 3sTK0RJSDHiOYklSP9hcFJ9BPPJ6rc9qdPPF0+a9jByCLCuYyWEw1MizSBBpDLPoQEw1
 kOmGbasf+N9wa6RvBXmq0oS8KE2Jf+YowgZ5sk0yYaqZcy2HSe5wzRNor7lS65v1D+P8
 ZQNl/my+LKwDUz+MOYLF9f0GiOo8Gj4Av+AeP1cKLP6PrGPEXXitaS8tHWkXfzPNRU2T
 eIFDx9r6DVWu6OAkQ96wfmgUSCdLiL4R7CD+VOmxblq68JJdTOXBtA1Ej4WYiTG+A9zj
 SzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130812; x=1747735612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkdCcb2R7zHmNwKVh1SyhRx36X2sK+MN/Vsql2qiJgk=;
 b=oXu4+DlfTFZkqQVsAofneglgjALwppoaXTcAKS9YqSSXz9TuCZM5WWWcZg26lAsFPd
 mlcJF5aXjuTe1zNRMgKdy0kgaoIGGZCSAngjinc/d8jmnkbyM+Bw3z0Exnt2kTobHGt3
 hdX3zBqrS6eK+HhTftrFZHl8u2WqDY5nW0cd9cLT27guEYC3f4h/qOKTWjkoDuhOiJjW
 W1fdLDofjwMWzvXHyrPr/GwWqL6twYfBgpcWoyRfCw9fejFcEKTpFxFYbErodqu5Ci9n
 mLszbRJAxsCKibrMhXCYXRPF0hJAUQh+hyIg132CaN4BbXmsJwI22aWkvaXvUOflQkrc
 DfqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaBQRgsaU8I8Dr8zfQwS/CiFkpGmG5BKOlL42Iv8ehCC+qa0mFCF4KmE0DD3MB0HQlAtHLQ4vujbe6@nongnu.org
X-Gm-Message-State: AOJu0YxYLrfqQPKONDw3Fy9ul6aLvQVgkGxq/EmsAy+Kpn5nXHSFZG8M
 hPEUUcjHi2x5fOf9Jk/rP/fqWaYGvs4pXmlt6eqTByjWDj2piSeXAbV+MyuqdmI=
X-Gm-Gg: ASbGnctL46RRZ4vNgTwxquCwsFk1epW+30iZX/TzVcyq7NvtZw5SE6rBkNwzrLtJLDh
 MDTv+rwGZAnO2MbjZ9d4XQ+61a93v2kKf1PaLyd+3fj7DRQRfpFjJJc3IY6Ou3+iOj2c00a0dED
 /gHz82rx1mL+MVHjjMMLY6UgBgvXQ2lLSDm0RAr4DKAuMRXvynIJ2dkeyn8bOm/sEdVJMp3NIaP
 +zBsHtp0zOB5/EiO85rM+naMXps2PDrfiXLqrIXrHHeFpVJo++RAe5GHcmIRvMZm4xuoh+Xf90Q
 cwQzaE3xGNyMpdyvCelEWJhFRd+jLyPz4zxbGWV2lJcKmQAZK1vjvCq3cIcRUOIOS1H+rV0iYXq
 sYn1L4QUwp3pNhFGvJBR3eEVsupEm
X-Google-Smtp-Source: AGHT+IF59XNEL81dS1oW7vVGPK6GR9EouAGp2ff4bHfb3hVB+cV5LDsiKzGWKG5GHhh+AJSeeOHVVw==
X-Received: by 2002:a05:600c:4694:b0:440:94a2:95b8 with SMTP id
 5b1f17b1804b1-442d6d6b65fmr152597255e9.16.1747130811611; 
 Tue, 13 May 2025 03:06:51 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67efd26sm161229615e9.23.2025.05.13.03.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:06:51 -0700 (PDT)
Message-ID: <8a01f62b-f7f7-4ef1-babe-dce4cb536700@linaro.org>
Date: Tue, 13 May 2025 11:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/48] target/arm/helper: compile file twice (user,
 system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-24-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-24-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AAFC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxO8-0004RN-R3; Thu, 06 Feb 2025 03:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxNv-0004Ol-7Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:37:20 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxNt-0005iE-DR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 03:37:18 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38da713b9daso489821f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738831035; x=1739435835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9OCOaRltNue5Ngv30f5dYaLHviUSZEC0cNjJfmBP3lY=;
 b=nkVxqp5Aah17fEc80yJ1mL/ttNGqJLpuMlUV30ril45sQkxDkiezENTJzq/QxKqPfY
 ps+NyB/QFbi1cZogUt3UKY2hTe6G4y8c2fBJoysBPHaYUgnfwIDJVD21lGK+voMCZRH3
 raSoJzt0zku1FrIFpS8X6/7BU19dV1PUUOfC9eeqpMGY0H4l6ttiPkniOpZsPYf6YfLd
 /5P3LL8s87oWD+RtvltbuXqdnoMKnFGk2GQ4fDVVrkUeKYAbTcAR1RLA7u237TL+duc0
 V9F+yUK7ZX/IOSFo89WlSZvxftr36vbVus5lU5/wqqkaOmzpx/OB8O7rPWMEbo3uq7G/
 guOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738831035; x=1739435835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9OCOaRltNue5Ngv30f5dYaLHviUSZEC0cNjJfmBP3lY=;
 b=GFcXZciei+IUdd02D0KLeg31BBUyF014+miXyjgXUfNzCwbOy2PIvUrE7QGhkCbK26
 N60N6ScDiTblhz1IDniCj2p7Ex6q4n4tG27tNIu9Ld1+UYqQ/guy7PUNLNlMfjii82RR
 dXDEEayh38jTtG3YNSt1VLvkpwtEOtJS6/v2lCdVqqh7jXLZRqnAzrKQgi7anHfwWFQo
 QZJHvKw7hAZ8bxF8KJ5encBx2MmIZpTi/un6ZWGDOCd924WFig/x0YtH1JZlVyiHmmBV
 b1dvtBbCUv/bw2pwzPv60MjTR+eM2MHEIOui0ffacgyEpoBznVNaNCWihpzhMcnSMR80
 tg1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4fV5n4QNtBAi8PrLWHBvCwj1a/Nfxx+8qTERUNJm4XtMQELARSEb9Z3C6lTM5HImYzIrlgTxMHl26@nongnu.org
X-Gm-Message-State: AOJu0YzYgC9Mo+psTYFjpW6vC3Wkfbl3gm8nRRlGa9aY98ET/8IHIIkB
 YCnQSJ5BGp4cF+6ZM5pCz2DYB6w9WVTZzysphrGWbNZ/OWNPqdcWzxHwHC797Po=
X-Gm-Gg: ASbGncuDYP3xH5oIZh09NiaLwLMlUZVGNEBK0K0ovN5ujAgHJ/Mgb3IIoh/03ihI1vw
 6P51HXD6JCSSyjOv68W6Xd2XSuXtoR1HWsJwcfkiulR7+kFSLe+0TcH6M+De8Liv9fLlzCkZubf
 smTY6n2ima5j47AbH/0fuEYJ+foXw2gjfDSZTo+v+Eo1RJAJTKJNuG89bMrVKcZMJS7tg+UxJR5
 o6b1YJus8twAEP2L1kd5aEHbpe2EYQI0N5rVw4M6m/6aVxoAvpZyRjbyyyuLU7ZoBFHJyyH3/Xx
 awE6c8euK44Flvohb3TfvJD4PQcNhFJMcrPEomV+r+sc6J7vGFhMvtpMt10=
X-Google-Smtp-Source: AGHT+IGX9l2Ei3H3nwhlummAg9aYuRGdBKC3ztY+UjetgIiKNmf953A75YsCG2S7j8effw7LLqqdlQ==
X-Received: by 2002:a5d:6acb:0:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38db4912832mr4152331f8f.46.1738831035200; 
 Thu, 06 Feb 2025 00:37:15 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde2fc01sm1101935f8f.93.2025.02.06.00.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 00:37:14 -0800 (PST)
Message-ID: <3de1e53e-e36d-404c-bab4-a648bb7fdbe1@linaro.org>
Date: Thu, 6 Feb 2025 09:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] rust: qdev: make ObjectImpl a supertrait of
 DeviceImpl
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-8-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117194003.1173231-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/1/25 20:40, Paolo Bonzini wrote:
> In practice it has to be implemented always in order to access an
> implementation of ClassInitImpl<ObjectClass>.  Make the relationship
> explicit in the code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/qemu-api/src/qdev.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



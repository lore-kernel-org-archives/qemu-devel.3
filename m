Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66B2D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7TT-0006iq-RV; Fri, 09 Jan 2026 03:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7TC-0006Ue-HE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:03:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7TA-0006Qy-Eb
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:03:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so28772095e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767945818; x=1768550618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mfhHegDc74WGrwOfDKvwkkHDAJPYBArRiRpOofWUAXk=;
 b=eMpHHQU0yWzrs6lYsMNeuG9d6CUyUBxEoZP3DQBzy5cComdeO7t5vQsuUayzQKxaXk
 IU91B/ZBq4IVw16O/3T22u/oogaZpUwlXWMbjatCo1LZIB9mW2VAjMF0VaT779Gq1S+k
 ZQMI9+KPpwfPuXRIhS15fKDQlkbGA/B4qWiEvUnJ7+hGWIbo1QfhoRvVxCZD1vA8rxzk
 cDRx4MxM+QCCSNE8cKf4UXsd3j6lT548sYyYrgOSQvzRQXFISkw1+xFl7YmlR75C68vT
 ua3YaTcifvBWxAGmQhWt8ByE4fnYOcUAvVRER110lwfvVYaD+IVD+S/x8B6d3gQUvo1r
 AryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767945818; x=1768550618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfhHegDc74WGrwOfDKvwkkHDAJPYBArRiRpOofWUAXk=;
 b=ZnLT43wgqzu+FrQi0JVAwlQGEKhWWkaRTUjeSNuVAc4Cc6Uzi5dUmvYkK25tmnk7KD
 eA7vbvBSfAzhTqcG7P/5fm4KTw757hi6br3Il0aupdBO59ZZW7De5QooRorc4kFVhSM9
 sGRls8kawLLRz5eNawrhQxHZjrrPUTx7v86sJp0dp9ViT90buwhoAzlxLay6pTYAQ2rP
 3f4cFGE6HMXmNfgLG7PzdaIRif8RjLYGTNaW50py/z2fJhXASeiaU6kIGBzo1zcS4Y5m
 BJKJEGYxmYwEtZ2UYImJBWSh2yydHBr9UgubKV93zhScV/H+OQ+cEr9IzRVGzSTF1ahh
 IUSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgfJ9iGOG5KpOz4Q0p2FZmam1fclLD0r+B59Ahe9M7JhHTXZ2JRJMptYZcsNoBqyGF956PkqxmuG4D@nongnu.org
X-Gm-Message-State: AOJu0YzWVrqDLZFMuGBwmU8GYTWDMlTLXTyxRqIV6gcFjSadT4DZHgKv
 EQZo2mnjtLDJz9N5aZ7td0m4A7529pLSoDEIWRWnwAg9NdlDvnYzQYC4vtS17XHoofM=
X-Gm-Gg: AY/fxX7vc5ZZi9OCgDQ2f2BIjWvGOJx3VXaN8YVK1d8ftdLp+JTELLYFU4X68SXjuX4
 bIxOFyv84HpnwKGg2cTctoN0aYUoy0ILGJRZmVHEa0W2uEK2xPOLvjCKnWfRVkBKAJ/aH8nRBS4
 kReD9qfmiIRT75TvhmuUbngWcPusGRdrVGUMewaApYBTgoL6kjyWgp6OJcZwAsR8h6Vosmu4J7F
 sbj18l61CoR8Y4e3FyEalIjSeF1qr4yMYARAdsAqxX1wLzd2tmH02l+FnBk2+6O7RwXUB2QOJc9
 aVx48JDNfRzOvbmxVr82KgXgDXrn0VewduiRnqi4APOCHaNBtgyGLlGMA/Ki5pLJ2BwjLvo39Tv
 UJd7bztmxOQQgKPDCFL9rrsKb7emNFxwNqEIBRgrqqm32MNfQhbItr5E3F164yjAOlgqpDbGZnT
 p7CIwcxnY4H1evU3BbxBlHT3A5Sdqh4oXJ0p2h0sF2TYjK5wQ9Vqpd6A==
X-Google-Smtp-Source: AGHT+IG1Ug181x+Ss6uZVxtz1deZ0xmbFGtIOM2BAenknRrO2EVF5tVi4aw1snK5LYFI062Vf1yo7w==
X-Received: by 2002:a05:600c:190e:b0:479:3a88:de60 with SMTP id
 5b1f17b1804b1-47d84b3fa79mr87572505e9.37.1767945818282; 
 Fri, 09 Jan 2026 00:03:38 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7035f2sm185504405e9.12.2026.01.09.00.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:03:36 -0800 (PST)
Message-ID: <7a448f9f-63d9-4f0c-9cac-b1dab6ecf0eb@linaro.org>
Date: Fri, 9 Jan 2026 09:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
> variant every source file is written for. Compared to before, it means
> that addr_type will now vary per tb translation, where it was constant
> for a given target previously.
> 
> Instead of introducing a new parameter to translator_loop(), we simply
> add this information in TCGTBCPUState, which is returned by
> get_tb_cpu_state() during the translation, and passed down to
> tb_gen_code().
> 
> To avoid modifying all target with this new field, we simply define a
> default value that is equivalent to current state: use
> target_long_bits(). With this, we can progressively convert new
> architectures.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
>   accel/tcg/translate-all.c        | 15 ++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)

Also nice :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1685FC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbKC-00054E-Ia; Tue, 04 Mar 2025 18:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpbKB-00050R-5Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:05:19 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpbK9-0002AW-07
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:05:18 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2232aead377so121818475ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741129514; x=1741734314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gAwQLNlRdPDXf7LeVsoQuS4UDCbGdvEaVoHfmAKOWo=;
 b=AvzLDmC9yBmfuaOskUteTt3dZ4UNK8CCjqFgH5uo2BZeQ/6tSDR1qz1PrhMRCwd/Sg
 753hv9TWuCtrV1BjLMmsU1HYvPXU7wXuJ29iXSvWuve4axjagf5SaImgjijRPsb4SkVA
 dh1BNbo9aOnRXejdTWWgLit/Keu/xr+3rQ7A5g4UjjV5SxBOFoH7hz3BTRV+eMHJSeve
 /h/MibnbDi02B6xJZZa8f1DYln6hHfOPq+1xojC5eWODd1EE5dDRUbWvdpRFF+z6TPTD
 Vz9wL/Jbfx2YsCIcEAc5QOP+nO9f/enU1tz8pN9DehsU3a4ekqjUnC7OlLlbO4OUN//K
 H57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741129514; x=1741734314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6gAwQLNlRdPDXf7LeVsoQuS4UDCbGdvEaVoHfmAKOWo=;
 b=rVjAfM/xfQoQ8UuXf6G6Bor0LaDlcwz9IwMes66mHGmwXhaLyJiusd0/Px6E162cxH
 2P+JqKpiDnXHyZtX9xjNRPG9XmyS0St7glvASDdOuMDWAzMhxJ2zz35qwwd3O3pgSMzg
 neE+uuNfeCQMCx4a8l38nU9aljm2Ys9sUmNrlG4Ow5A64kyMDHed4/gy4Ak3nO77zZJQ
 BtFcIPH5UTNVus7NuW7pf/r5WxtRz4TfZou483GbF6OxCkHP6ejTOGIxugeteGiaBbaE
 z4Ezzn71XeF5BzbPQn1cxDqr6uRwOpDhRef4obrqD1NMbZPcmLPIDKh0vfOhi0h38WJd
 hiww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcTcVsd0N/nSqwLYQiabyg4kuVfKpGosIJ7CzNduhNelgViity+/o51JbehyB35jMIsSb62+OG5kPm@nongnu.org
X-Gm-Message-State: AOJu0Yw9HG9qh3zWwGSR5MpB1Doi0AaL3FLky7+G4Md1hU7sb78KGMWQ
 hjMY5d2kL7DYYRztaiI7Yb4bvzfWQoDGwz8Fmoipb+IG7qXJABSUnaba3MtFIm0=
X-Gm-Gg: ASbGncsZJ9Py4p44YZAxidlyec9yg+QxICCUuZOCRGrTQvm+vRVkuKP48D0mVfF8Nqy
 Cg/RdIGVJfA83A2lJsDZIoRGctAc5SSj15TeQWCSKK8I+Lv7xvA5AdJOs255OFgbOF1Xfg6yenZ
 KD80fgzcmbcb1jhCEVlRLo7hw2C/FJlbssZyPI4/CyELVhIeo74Jd3VoKVrgASECnD+9HLQdnBw
 u7Fvjdng2jOegAtCHc8EGLykLgZqdRfOXnY+HQuAHZ7sJCM5uhx1sr4gqA6r2GrMUVBiF/47DNl
 pd89VmmRj15KNJwJSu24qwWkSkwQ7wANTiqkvx2zF/Opf9cy2PeFqwt7XNIIO4ObmmVpNl8Hs7I
 la0RYCAf4
X-Google-Smtp-Source: AGHT+IEFU+glJEtCnYjd9JlxpIr2nRvKb91cHv9dmfgXVTDWqgpRKGZHN8aUyEXWPQed29LlnNa9AQ==
X-Received: by 2002:a05:6a21:78a8:b0:1f3:2c55:8d8a with SMTP id
 adf61e73a8af0-1f349477595mr1602764637.12.1741129514474; 
 Tue, 04 Mar 2025 15:05:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-735e66ef952sm9206300b3a.98.2025.03.04.15.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 15:05:14 -0800 (PST)
Message-ID: <f408e1f2-d828-430a-8ae9-bb1854494156@linaro.org>
Date: Tue, 4 Mar 2025 15:05:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/32] meson.build: default to -gsplit-dwarf for debug
 info
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-33-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250304222439.2035603-33-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/4/25 14:24, Alex Bennée wrote:
> -option_cflags = (get_option('debug') ? ['-g'] : [])
> +option_cflags = []
> +if get_option('debug')
> +  option_cflags += [get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g']]
> +endif

I think you've got too many [] there.
I don't think you need any of them, actually -- += will append the scalar string to the 
(empty) array.


r~


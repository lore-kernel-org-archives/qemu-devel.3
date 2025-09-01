Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06114CA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyHh-0006pR-Dk; Mon, 01 Sep 2025 02:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyHf-0006og-8W
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:44:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyHX-0002A9-Vt
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:44:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b86157e18so7575265e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709084; x=1757313884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zDUffA5+txK0ReURnF/Mw9qGx7ZmMC0xYBT3N9MqGTI=;
 b=dSt7uUwhtpiBQ8wRuoNSE2mVNxRT+IUsNhU43U2idlM1tgsAKLGav/8BHnvsGIuJBU
 GTzRqW89SrFH+fiaYjbWY1s17028Kpn5zUd3Xafi2UY+drhXvDWEiZl4tSP6UFCoEkNC
 EEQl7+p5oVZ/ZJZ7uJMGvaidso7s2wHWOyyiF5W8mXtCcKxZyiiXQxXWoqHQmF+q8Rl7
 +AgNIEz0x23zj+s8WBlJxmjGiLQ7C8/g9qhhHrita6u4FrtKXTkP1vfcjYoBCxKz58Ks
 647i/wG+ETQW36cuRSKHLYEARV8xsvaEgrebQscDw4uctcM2AFta/jscwDFG3XKVdGMH
 ShrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709084; x=1757313884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zDUffA5+txK0ReURnF/Mw9qGx7ZmMC0xYBT3N9MqGTI=;
 b=a0ug5CFOmDie1O/QfiJo83cmWlFt6zOL+YO0TW6NwKuC+GAVN35sLyzuBp4jmAE1gr
 OxH/J6bjpbPFfjJU+mG/P0d2dCewGW+CPJh8v4c2ZwUjjj9N0tK0XaOPEzC2je7JS0hb
 gtlITzYDCjoo/LVSaPqKcLjFfW7y45jSOqlDtMwod0/4M2xF/56CqIrUAp7ibcD9Aarv
 Y3MGaoMKOn6nPSlU7SFVOR2dZSmQnxQuKTHHeG69JGNgn+BIJL8i2UD44aiK03cFY2Q4
 2VhloPkO1qskxr/t9pF4mRQgvGhivzd3lfCu1DW+CG+sxttXcZ2U4azB99ZtlyNRyZDl
 3EsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhUJeS04Cp0uqJVNAPote1L+xl77S6gVt0aQTb9dkbINqahTFZA/J1Jyhe7Y+akXWP/6Z5P8zAyqKC@nongnu.org
X-Gm-Message-State: AOJu0YxDqUZtu6tI6k3cCd9HKO7InJQl7q1kgckGbJ0CpQEh1YLJVJTp
 ZYQxW2MYimb0KCZ8LtE8SiXm0dbj5dxeOdS2Tx5ORiNX5d/v3AxZqbV+wjKrUOjj+Rg=
X-Gm-Gg: ASbGncvIaw/nInHXypYpOnkAoeCrOr7K7ARgEGpjO5Vn46f3Wdzd/LbxnI4YjgBJc/W
 OwFOz4kfh1oKLKNgWCor1s3x3FOBPWvqSQeogO7v9JRf4qWd3U8MKIWPnTQT3UofXohiUSrdoui
 6Il2N1xsvkkeXdr5u8zk3a8qTS9AgVvEO5RJ4jeQ488Ikm67FFUv4REyK/JTKzfVDz94/V5HBPa
 VNAgpD5QTY9g0XQta5sruzzppSGV03SGy7BvsT9RCSMPD8nLldB80D/Jzck1nww6zsoeH0k77Pz
 W8ZUVh/9/xyQmXpVQeZr4MgqWyVkkq9lnozZ2thAuG0MtKl6/fwKKSm9tr052r1UrJEvcLrfLvb
 JaY7PM3R6o9Irta9njDs/KN3f2BEsASbQ4oLbP3aXFtN5W8Y3Wv75ynAa/gyXx0vdOOhnd2FUqE
 gO
X-Google-Smtp-Source: AGHT+IFRe798liJw7x3zrN49lDsa+gkjcdNnIK0tKQLPN8+fKayJnlvhqLbIRiBJxsQRyqzyl55hJg==
X-Received: by 2002:a05:600c:4f02:b0:45b:8f0a:889d with SMTP id
 5b1f17b1804b1-45b8f51eaebmr5848485e9.30.1756709083578; 
 Sun, 31 Aug 2025 23:44:43 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm9602845e9.19.2025.08.31.23.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:44:43 -0700 (PDT)
Message-ID: <7617dd28-7682-45a3-9c8b-2b81d1b6c2d3@linaro.org>
Date: Mon, 1 Sep 2025 08:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] tcg/i386: Use canonical operand ordering in
 expand_vec_sari
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250830033926.372955-1-richard.henderson@linaro.org>
 <20250830033926.372955-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250830033926.372955-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

On 30/8/25 05:39, Richard Henderson wrote:
> The optimizer prefers to have constants as the second operand,

Should we document this somewhere?

> so expand LT x,0 instead of GT 0,x.  This will not affect the
> generated code at all.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



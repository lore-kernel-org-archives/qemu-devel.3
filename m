Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B55CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 12:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulnvH-0005Lv-Ov; Tue, 12 Aug 2025 08:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulnvE-0005Kc-6V
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 08:16:08 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulnuP-0004Ff-RQ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 08:15:31 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b3bdab4bf19so4350735a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755000911; x=1755605711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Bxrg56B2/1q5rYYI/G2b6ZimfDVJ2Y7Pz0uWdUj5Bg=;
 b=GVsUaD9TEisCJuuJ5Tv1ZGgMnXWcwlBtAy3VaDNqrfvWW8cNNmSmMoqD0N4gtZNZHW
 VsnVR4k1DnDRzoJZ2n6mPzyWiJ90XJLeHB9U+hooMJtbIDlSSmE0y9JBpKUDqcRAsHbL
 WURXKrGX9A2sRVKEX4dmLnQqJSCU24rA+UwU0tgxpPrNhxe0xiKNh4i/y3NsC2lVhYFS
 8GOqGVPh5KdY5W7TCUy8xgkFHlvVUUQss1U81SGJ+J/879XuR37E9QzTROEcRO+KfDiZ
 xpkNUtW9taJW1CcDeHAK1IhJFxAvJ7L28BgB+C5ROg/a+LjgKA74TLgnhziHT6PZ2QA/
 nB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755000911; x=1755605711;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Bxrg56B2/1q5rYYI/G2b6ZimfDVJ2Y7Pz0uWdUj5Bg=;
 b=HpI54GMve9CgTXy9K3K3NuVx+H/upqO9v7IfJP5/HHfTdKoZpqa3obiSugkbePSDX9
 gBGTNjCFwtCMuKJJDNhDgO4VVZEfeWSNHfWN3hJUxGGOXzuSxC3PCGCwR7uyamKXbzF5
 9Bn9LWE/PRii5wex/dT9+TdtlnXeGphmoDKdtQhH37PpvUqZO+R7b7orN/EbmDM1FJ76
 aYyG59uUUvRdAE9idnupR8JI60wCrm6gvAneYvPlP0wTn0m6SIeaVpaYi+oCAv+kZEpj
 yQGJV90Pxk20koG2QuE/afnZ222pvOnYWY4z17xAP8+oECgsuZhb7yrGCUyVgtC6rcDZ
 dHXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEnvls8lVfxVKwgmhYKfnyWUcXM74FYNG7oQ2CAVWAvF+JxmKRYpWpOlEmJTCpqpZSJz3lJgoK09kL@nongnu.org
X-Gm-Message-State: AOJu0Yy9umFy9FV58aOWdTYMw1OhLuG1dOMJtmHZbAa/2LL+7F/cTuWw
 IQBzlzhqryo1/LALDztaJehpUKmp1qIyFSOgij6HNjXRxPHvvDSsvB0tgZwf6ZEvyjE=
X-Gm-Gg: ASbGncvRV78wvJJMGqxEYQZ0YoOT6Vc3z1s0QmxUPOkPKtHOZ+w+UrEzLSFhdQcI0Bf
 IsjDe8TiUBAP9NhiZF4xfd8y0iSxdOjxIJkld8dn4BAx/Ij/rHitEQfE52BkIE6ybHIQAJwyV35
 1WA5HiFLm4EvmBax2C5xu5tx1v4ktq8vPC84ldCi3iMMSq0MyVbkEFswpXOnhVtRyW6zkJ9gFTJ
 61c45Ykg+Qn/vE+Qkzefa3qEfhix3M4bIVa6O+h94xetVPvEulqVUf3RjuDSXA1afTaUo5KNDB6
 9wPbO+Mvy9dPF5++GDZgxxVbumIDCek4/ItIDq6vse7EPwhq4DMVzla1jacuHB8tEELL6EA1zkh
 kzAswX2ZXtH0Hh0wJy4y/U5kyOapH9rJFjmAgr+tg
X-Google-Smtp-Source: AGHT+IFgEEPe1PYImXF6BdjNXMF+vuKs+96kB+FXLsF9hCy3+s8nYPHK1OoZI08fRo0TXTkFhTwKaQ==
X-Received: by 2002:a17:902:f78b:b0:240:66ff:b276 with SMTP id
 d9443c01a7336-242fc315e6amr49899765ad.31.1755000911106; 
 Tue, 12 Aug 2025 05:15:11 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a48sm297685785ad.104.2025.08.12.05.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 05:15:10 -0700 (PDT)
Message-ID: <d7e55a44-03ef-4d13-9705-a743921138be@linaro.org>
Date: Tue, 12 Aug 2025 22:15:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/85] target/arm: Expand syndrome parameter to
 raise_exception*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-24-richard.henderson@linaro.org>
 <3abbb8de-bbe6-4404-9714-50b487c46a8d@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <3abbb8de-bbe6-4404-9714-50b487c46a8d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 8/12/25 16:26, Philippe Mathieu-Daudé wrote:
> On 3/8/25 01:28, Richard Henderson wrote:
>> Prepare for raising exceptions with 64-bit syndromes.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/internals.h     | 6 +++---
>>   target/arm/tcg-stubs.c     | 2 +-
>>   target/arm/tcg/op_helper.c | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> Maybe re-order with previous patch?

No.  With this order, the destination is never smaller than the source.

(1) Widen env->exception.syndrome
(2) Widen raise_exception syndrome
(3) Generate a 64-bit syndrome during translate.


r~


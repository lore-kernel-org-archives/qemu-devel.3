Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CADC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5a8-0005DH-Nb; Mon, 17 Feb 2025 13:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5Zk-000560-RP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:10:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk5Zi-00063N-At
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:10:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220e83d65e5so68737785ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739815833; x=1740420633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OcunpXZEDVw2rmp9mUhdoB/SS2eJArS+5xk/Ou/G9fA=;
 b=BBUuus4iQH7f241VQM+twFqfo2SRNC6LiyQYzv4BmatiZFBg7i5yofTMSIKfcJ6mF9
 badvrWzuf3LxN1m0G2PVX53ZOqD54Wct+PXYzD3VrihiUvUhrN1tLqwHFMr9gbQeI+oK
 kHHvS+jJxnhif+9X80zEUh3mC6SMFLdiSxl/uWnvmw+9Z5sbxJiTs6Qxr96vaDU92vC/
 AuuqpKUD5rqOlweg84ze68IVceiKHJlWBe7RRXkDeyHW+Qr1MPopKLCpXvRxLS1+9tDb
 4WikGzjfuXSB+Y0W7wW5vsJzWjgmDLkYocWu628POhn2NPWcBNW88GbKKteusd95UEz5
 3+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815833; x=1740420633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OcunpXZEDVw2rmp9mUhdoB/SS2eJArS+5xk/Ou/G9fA=;
 b=G5Voukm9O74eYgLh7gjUdV8y9nijQtsiwPwBiVBcgD6rMkvQgEozYn030Gj2+6GXhf
 i7nobVx+t7vW1MGd7ZBgy2VMvhBHI/ZaYy2vVMgOIGxdt1GDTgWxfixDYy+0820M5pDK
 BPkjKLM0BTa9fpKdeAa8a+3EAYycTQ26gfBgB1L/QYm2AutKfvRG7oLKuMaKX+2mtOJ8
 jD4Y4XYLnzmJpXfKVn14X1tU3WowiTyYzW7YS6Ape8l2CsFCBFPank2tHNYPu2uWqjR9
 mXoI6ifk1/D1K77BV23iKjQUBu88qNrtgi02Y6hcTsEFeNlnoFqx5MaQfzPtKjRi7i61
 ye/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsRsHc2xtqleRplJqg2WSQHgvgmyTGqoq0Ycr6eGbmi3lv6fqh1/NkVLCuSCJ7lLKUaLrzzOkG8wIw@nongnu.org
X-Gm-Message-State: AOJu0Ywt0630ywnAOGTYY4LyPYMU4+nZgh3+T5jRMfzXWBVHKsMlDjaf
 Z6Z3S7cZK8Owf7v2nURhSF56c+7oeRlLjN/Cy368phPVSFLOZLFQg+wn2uYliTw=
X-Gm-Gg: ASbGnctiAz+gKV3yGcu+jHUnq6IfTY0i1EP3S4gWXUnhtRMvKsERe/nWs5rCRBmIH/P
 jRisVVvMzM3KffKH6AhLx8HEWtA3q7TwDnXRJIgFmYO6HddHsH/iDJoNxxmbU1bMXr9dg5fcPeQ
 CHUTH3GuKpBneoGfO9s5bOwP6JMp9GqT2+VhZW2+x5W+uzD/t3pIY+DdJjCUKh26KlMoLLAtQPL
 u667nTaMKaiNu3HFfVhx2tHKyrpKvxGq7STmAUhNySnGmofdTNWtK3Kl73LOgLU6Z40GWQByeMI
 dtZLVcd5cinCE1GkRg49guXNCJLxaIJAYzEwXxcJu8flJt/+QpbCjDY=
X-Google-Smtp-Source: AGHT+IE43fOy0UQCt3rzryo47l75gDBtTcJT79k9Qw1LGwcp3O+rm47WiTAvLLO98jRQq59yQYg8iA==
X-Received: by 2002:a05:6a00:18a4:b0:730:9567:c3d4 with SMTP id
 d2e1a72fcca58-7326177fc46mr21673375b3a.3.1739815832731; 
 Mon, 17 Feb 2025 10:10:32 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732550dca17sm6416480b3a.46.2025.02.17.10.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:10:31 -0800 (PST)
Message-ID: <a61915c5-0b8e-4887-b1ff-eb7fd83be2db@linaro.org>
Date: Mon, 17 Feb 2025 10:10:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/i386: Avoid using floatx80_infinity global
 const
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 2/17/25 04:50, Peter Maydell wrote:
> The global const floatx80_infinity is (unlike all the other
> float*_infinity values) target-specific, because whether the explicit
> Integer bit is set or not varies between m68k and i386.  We want to
> be able to compile softfloat once for multiple targets, so we can't
> continue to use a single global whose value needs to be different
> between targets.
> 
> Replace the direct uses of floatx80_infinity in target/i386 with
> calls to the new floatx80_default_inf() function.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


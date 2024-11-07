Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823D7D5AE7D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zKA-0001Fx-KN; Thu, 07 Nov 2024 05:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zK6-0001Fd-SM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:01:09 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zK5-0005fS-1Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:01:06 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso998341e87.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973663; x=1731578463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QNJkyOXb5iDFAHDhDSDsBeeTjcy8mpwh+NVrU5tBQj0=;
 b=RdsbNaax3E8BGIRIQ3ogOuCYOnDpHb1QeKtrJhWtpFHehyBtTd2QmAqWDhWAc/oqke
 TV54qpcWpJHCPc472vmdwV8dFcWJNwDKicqMIXPOONsjsag7iTs9ejc0NsW/CiD/j9XN
 INVHquMgOriDSa56EtunBQOZS1al4FeWtR5purh9S9986BXFwCPfy9vQ2MCguihHVqXH
 srR4zSY6qP/x9onYtgZWVFn61kdx+tGXjel5oT04247hy4BsUrFfMbm900oAXCHF29TK
 nolDhC+I+Mjnm51KFyBoqs49UPvPY+d1T2CsJiiLsl3S53fufCEsn6eNjlrjA0wuu+eP
 FHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973663; x=1731578463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QNJkyOXb5iDFAHDhDSDsBeeTjcy8mpwh+NVrU5tBQj0=;
 b=W25xJtcbXIrhExr0zQKJDcspHVbp/7WAWqx+BdFBnJikjrv/vJTaJmNZkioiOIse1N
 Baet0Ns1+J6xlMK77KgbFl7bm1lSvmmYfoPAoBENY4il3Uk6o+dZQ4ZPW8RblM5A0zkK
 zvQakJhZa16isSEEXLiOLtqUFHUjCREalRr4NoGKfDiu87WaGs2/jByXhJhpEDddxjSr
 00Uex1Za6VzswXO2bdc/lVHUQVv+c6IWkbfjeBsy5tYl9fQ3K+Rygi0T6WP5DP/dZV0S
 8Ak2B3Khz3jypyawsH6c8cRosIHbIuxdEr0Y99P/1kxwJerEiXb9Ir8WmowAZbHjHP4U
 hDLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJbNGutuhkw//P6YoW14jxgJgpJru9KeC1KkMrwE7botxhc4Z/TLNXQUoVRj2JFt5RuhtXehBXIErq@nongnu.org
X-Gm-Message-State: AOJu0YzlXeDnKaHbXqCEULY2Qzzu68pTLJZ+S6ZMh321qyAur81fk0Z8
 49L8EAdp9N0TDZAOmhau+wunMzk/ha5lC8/eGL5J1vO3f7OEzZejea6CIKtzRLYDLrNChUUQlha
 AIFc=
X-Google-Smtp-Source: AGHT+IHubmpLDIZycSh0AyVO74QgMrJBILiHFGsPWQR4d6y+wlc6ltAAlyo+HeEZ96Cc1cCoMapbDQ==
X-Received: by 2002:a05:6512:124c:b0:539:9ee4:baab with SMTP id
 2adb3069b0e04-53d65df2701mr18264993e87.30.1730973662792; 
 Thu, 07 Nov 2024 02:01:02 -0800 (PST)
Received: from [172.16.23.118] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0defbdcsm70614666b.159.2024.11.07.02.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:01:02 -0800 (PST)
Message-ID: <d4f84208-efcd-4568-8f1c-3d76c32d9600@linaro.org>
Date: Thu, 7 Nov 2024 10:01:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/tricore: Mark devices as little-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241106184612.71897-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
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

On 11/6/24 18:46, Philippe Mathieu-Daudé wrote:
> These devices are only used by the TriCore target, which is
> only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
> DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/tricore/tricore_testdevice.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


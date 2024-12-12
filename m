Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B301BE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLl4w-0003rK-JX; Thu, 12 Dec 2024 10:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl4r-0003qs-EX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:26:09 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl4p-0007Fu-Lm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:26:09 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb4ac63dc2so368676b6e.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734017166; x=1734621966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6mbZ0l8FTqSe+2g9kb0F/fCQern+/oNDBdH3qI/D/gY=;
 b=YPbbUA+0tDLRl4UVmjo1zeEKmNLwZ01NLxu1qaH7AJ8MotKfidMjYtl0MfD/vveCsD
 rWvoAIJQoEKZJfL0fwq5Aprya+LFJMJrrisWpM4ito+Dtj26cGorTjLE7zeUU4N8/Cg4
 ARS8kBxVyXzUU9LsVYb+DIR4pIZAS6A5x1ogeH70ewpe7dS9GWKZGK+DLdB3Rz2jKzpZ
 1wVFtPzRwatbwfaI8Wi+ccfag0Q5Mj/A93qYBM8tALVBvoiZB5OZYiNLYhgaSkBiwaiN
 DRHETK6PwdjXH/0VxogD7VHfgZ3On/y0/Sl8Zm+UamRMeNGUFIYQElMiVEE8U0S1AelQ
 wJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017166; x=1734621966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mbZ0l8FTqSe+2g9kb0F/fCQern+/oNDBdH3qI/D/gY=;
 b=CNxuUoAjpRHAojmCLi8neAMy1jF4+ocqX6iW1xa4sUqzmDEFyzrxhWvtN/TU4p9fQd
 fA30MO/M+8RWVJcsDvu0YAMUwB8X+T9KruwEdSq3xkIYAU0mlMHy6L2TPGchF64Ep/5Y
 /ST9lW3HDnVWbjXN1o5DQ97510Wv5HqRg38wiu/xK97wl4rDpUe+CBNtnFF6jT0wlBLa
 X0vuZ9p6eSbED7g85ndmEKYiz+rKzKvi2UPGtETgBgXMjWo+fKLfxcUGlJ2ouJJ7RC3O
 2qphv3cX5TPJC2A26zFsX7NY5OUzXhuJWlamM07Z9/X5GyC2IKe2Duak6+zmuI8o2nCG
 JEww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy7Qx9EYZuFSaus7y+pnCX0WFfyPZ1durE/P4G0/IO1ftogV0+stac0J2gzrgZ2sEZaSex+7sRrvEt@nongnu.org
X-Gm-Message-State: AOJu0YycOZ92dVj4a9c8bt65yoIRE/c6sLGvZHBY1FmAX0R9Ll3wYw1c
 kSL3cvgHqFe5LFbCwerm1DfNx/jglAz6+IzhL4ynCyAeMfRO1IIUeZHf/PaSXqI=
X-Gm-Gg: ASbGncv9d+zCZpB8364PHX2UdRWIIkxrzNeefgIk6zSC2h96TTY8qRadS0xTUEGqSB8
 6jHggEyhIq8Y8ZBH/Rb/nQdlV8uhVJTFUIVZ9EfEd6vBru/GQ9Djh1KRr9mYB70ybl2vXqbKdVB
 uIOGklCC/EfFcmVrEZcU22lvVhisC4iwqBu4mnGCirnnJKVwl42nhpjYXylq/Lzj1ikn08yQprl
 ReD4h+mdbIzmOUMv1wlqK04rqlTp0cwW1auY71RIog/4wv4YKeUGLSxe082fw7jYXICZiSxnLqV
 UfapgzHw0OSiaK4IrCmed4wAGUXci1DX540=
X-Google-Smtp-Source: AGHT+IFB/8dCY4nN8SzPzVhi6FrLr6P3QJwup2J9Ob7t3czZ5x0eZ+C6E8d48VrswKuI3mi9K5QUcg==
X-Received: by 2002:a05:6808:3198:b0:3e7:b149:79a0 with SMTP id
 5614622812f47-3eb85b50558mr4501611b6e.23.1734017165930; 
 Thu, 12 Dec 2024 07:26:05 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2bce1d0d3sm1882020eaf.40.2024.12.12.07.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:26:05 -0800 (PST)
Message-ID: <8c5c6854-8ddc-4ac9-b327-409f17191e2f@linaro.org>
Date: Thu, 12 Dec 2024 09:26:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] target/ppc: introduce gen_ld_tl() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-2-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> This function is intended to be used for all memory load operations. Convert the
> GEN_QEMU_LOAD_TL() macro to use it as a starting point.
> 
> Signed-off-by: Mark Cave-Aykand<mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97576C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27o-0002yK-CH; Tue, 10 Jun 2025 12:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP0Fr-0004a1-Qq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:47:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP0Fp-0007b5-Up
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:47:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234b9dfb842so49361165ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749566827; x=1750171627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AxfRbBzexLSGyxB6CTcg6kF88s1FlbjgE48KUwNmwH0=;
 b=HWhv2cDG+1VfPSwGZNgEBlTLuoUQF50jeCFJJVF69kYDzA5QiZsBF24JLLUknt/5IQ
 uxtqWe7T2t9ssLd7tx4h/DqPCbU47KLnUgVT06MtZdd58uGUIVcaNBJ7OyuwA7vl7Sae
 dPyx+WSVvCirmErxfeZQfYBw08OwaUK7L4IsHc98GpaPjumM1TIGqQ7sQi9YhzDcYtai
 tpBTEZ6HhrRyKrWsg80wUG+lWH1+eF9oug9hRN0BaanfqnVhmmZ1ch3Xxus/0sjhes1Z
 NTorrY8stRfeJMhSMg4ySPGDFIJuLXDt4yXxbG8an/uJ4BX8Nah54B7W/pKNBXRwud2w
 B6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749566827; x=1750171627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AxfRbBzexLSGyxB6CTcg6kF88s1FlbjgE48KUwNmwH0=;
 b=jxcCqi3xxhB7UaOAwouTr0vM3w+NOY+mTm3n9l1yOaqNToqvSE0QBvvolCtYrcrAHT
 HQ8DmYDuBIAsLV/fD9PuEzqSqNm7Jnmyu2EoeTuV/u2AMqbWI2eDk+Q2ruVMuq9TnZ1e
 WOnoUm7U48StYVYcQYpwaCxEwL1jhocv59ThoYHUzcxozfRsiJyG5wrgsOA7RT5TVzj/
 C8DOWsggU4R3pYwpFesPQQw9uVjNdIfQ9g94nEEdCk3qQM33pzv6zX7Rk0JuH+rrJOvk
 NZJqYz5q6bfBG9O2QV/k6H+soSziUDuuwGOph34+q92GW9lWO9hqTTR60RSUPDS+DGKv
 e8JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+W6res/IzB8gTFaLOXWNJv5ES29MfK/LgEOnle6t9F/z8jGr3mGISD1c/lR/M85OcEJbaihdIAzq6@nongnu.org
X-Gm-Message-State: AOJu0YzjIH0E1g700Ll8FxpZj+Z+3IdP33oTjozjez25//O63LOet5pu
 K9SKfFaqefr0FPPFBiitgB6vcpbdY7436U1dr386yzVjvnG5rHQqJJrGJ/1dn41XBCQ=
X-Gm-Gg: ASbGncskiIOPcIP9XR7JdXY7+SlFVCeYYdzBSadHQ3mzJt7X5gPUpF6mjBiSt6AwIy/
 QhDfryM2HK89bQ822Qt0lv87hhEcFfJyVDJo2YJrOTpjWmz0JlB4Myts9aeJH2oK1xmPHr4IwMk
 XiGwLg20apc+CPgOLZwWEXKG8NaEl35DmLA3vPe0tMhNSeddXQyaJIVptIQZ1FarvMFiCQhEZgp
 Q8vYf4tm+P0jMZ4i6Uv9KA80MvHhOqqzbafDsrlYDATSXyIovcfVHFAsojRw5/VKQnnPwUo75I+
 tFCT4aUL7vEgpKojvLWI4y5mGJEFPPiN6PlO92spSHVrLuCtR7Yjrdg928X6xUuxNt2mQuLS4no
 =
X-Google-Smtp-Source: AGHT+IHs0PjW5mI4BDUjuKJk71RqSvaLnXoarENPYdHQMFts2oLbqI/pum8FdBBkFLyMCjlduvBLuA==
X-Received: by 2002:a17:902:ecd0:b0:234:a139:120a with SMTP id
 d9443c01a7336-23601dcb77fmr258577685ad.32.1749566826611; 
 Tue, 10 Jun 2025 07:47:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236034050fasm71860655ad.146.2025.06.10.07.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 07:47:06 -0700 (PDT)
Message-ID: <2e644619-d995-4410-894e-9e759ba06ed7@linaro.org>
Date: Tue, 10 Jun 2025 07:47:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Controlling time in QEMU
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
 <8CDF867E-5AB2-43B6-B271-B350E833316E@gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8CDF867E-5AB2-43B6-B271-B350E833316E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Hi Bernard,

On 6/10/25 3:22 AM, Bernhard Beschow wrote:
>> As it seems a bit too good to be true, time for questions:
>> - Has it already been considered?
>> - Any obvious downside I might have skipped?
> 
> The only downside I can see is that it seems to disturb QEMU's internal timekeeping. The GTK gui freezes for quite some time when the time facor is very low, e.g. 0.001.
> 
> Best regards,
> Bernhard
>

Yes, faking all the calls to gettimeofday is not the best solution, as 
it impacts qemu beyond its clock management.
This could be a good argument to have something implemented in QEMU, 
which impacts only get_clock() and get_clock_realtime().

Thanks,
Pierrick



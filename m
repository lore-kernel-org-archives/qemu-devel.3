Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFA8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Di-0003Yb-TI; Wed, 17 Jul 2024 06:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2Dg-0003PX-JY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2De-0001Ss-RX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3678f36f154so3981932f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213349; x=1721818149; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cev8W6CWSvjm9UdOgs7HnfWmh1qJUbjyYUjNfDWB29Y=;
 b=YpHNr3IAqBOIurVKbXmhP+8vpoWlIQCJ9dfT4M+yIt6s5AzyNE+cMCi6pYm/JKfBiy
 +D0hu39quNvlM+sYmaz/iNRufJi6OQPobRUBBZzzrccss4HH1h1BjEi9Sygq5GZPsJBx
 dd66MBsc2lHc4lcEAkRHpUsxkAkXRFBIjfEL3RDBLXSbqBdO2bQ6OJ/tzdoZKq43a/iT
 a/SBAm4dfJrr7GOjdur5QxhiMxHjCvYUSxlNg/bpgWxrUKuET0cetyK0G4SXRx/uh7+1
 8KT42P3jM99BSfeamd1YPnLyAWLCjdR30iH6Vuck1ver+wehCyTJkfT+eXwVlqgymVCG
 tU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213349; x=1721818149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cev8W6CWSvjm9UdOgs7HnfWmh1qJUbjyYUjNfDWB29Y=;
 b=TpRhdn2fVCiGtr2Uly5LpBLY+JHj2iks3Bv8qQ2J5bnKguON8POZ7a5JCRQctA7kzJ
 5Cfs3DiczKr0B1l5rfPlW5scStU2gZwv6TlImAeoEm5oFvjS6GjrCBNN0YyKHlAWEkha
 A2KtmjAfs/hKAIOHq0HHIwctzmvoTFDwmzb4rozTD5V81b4hNqWx8mYFTDude+ZLwd4p
 qYiRzDTkXZLVp7UFQmu3vXBuIhYl0EFxIQiVoHIcSoJFleHTKefrzVzC4SZsHkSqhHc8
 sRxdpemHqeTKxHw4Zq6Nfzkq9vyPao0L0WbKjotU2v2ndNz7EnIcG38aHvsnIKRS5Nih
 ZiKQ==
X-Gm-Message-State: AOJu0YzYAf7wqugyqQRsv37eIx/Q1AFlhSwfyFlGT4evbqvHeF/26ECB
 LfZwP3VoblSvKHQxFpQX0ewpKaiY8Uw25NDFxvTYQoGo9FoHl1oj5dCcumO+xMU=
X-Google-Smtp-Source: AGHT+IF0hHDKdMOwjmU86b2nY+5bijcS+F576XWabFe4OLoDZIwh9cFZvl925mHLQfhx3H1lReVT/g==
X-Received: by 2002:a05:6000:dc2:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-368315e7717mr1114178f8f.9.1721213349125; 
 Wed, 17 Jul 2024 03:49:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368312a761esm1187625f8f.73.2024.07.17.03.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:49:08 -0700 (PDT)
Message-ID: <0c51907b-f9c5-4ae4-b153-9e575d0083cd@linaro.org>
Date: Wed, 17 Jul 2024 12:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
 <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
 <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
 <5c913504-d917-4fd1-86d5-85d3bc293623@linaro.org>
 <CABgObfZ_V+K6mShNVpb3KXG_uyNJatk=0btY8grcpMvoo=seYA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZ_V+K6mShNVpb3KXG_uyNJatk=0btY8grcpMvoo=seYA@mail.gmail.com>
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

On 19/6/24 09:49, Paolo Bonzini wrote:
> On Wed, Jun 12, 2024 at 3:13 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>> Building qemu-system-mips configured with --without-default-devices:
>>
>> Undefined symbols for architecture arm64:
>>     "_qemu_semihosting_console_write", referenced from:
>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>     "_semihost_sys_close", referenced from:
>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>     "_uaccess_strlen_user", referenced from:
>>         _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>>     ...
>>
>> So this one has to use "select".
>>
>> Similarly m68k:
>>
>> Undefined symbols for architecture arm64:
>>     "_semihost_sys_close", referenced from:
>>         _do_m68k_semihosting in target_m68k_m68k-semi.c.o
>>     ...
> 

> The file to be stubbed would have
> to be target/m68k/m68k-semi.c (for do_m68k_semihosting) and
> target/mips/tcg/sysemu/mips-semi.c (for mips_semihosting), not the
> common code.

Yes! Thank you, I'm was to blind to realize that...



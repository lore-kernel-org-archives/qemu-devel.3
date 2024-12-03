Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0348CE64AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITP6-0004yw-5u; Tue, 03 Dec 2024 08:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tITOz-0004yb-3F
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:57:21 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tITOx-0003om-7s
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:57:20 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e63e5c0c50so3036721b6e.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733234237; x=1733839037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JLiChfJblwp1Jernog2B9tk/jaBR2orXqcxknU+ARjU=;
 b=Pb9VVYnVzUBQDMjqA3IHylzbhoSyBlVVEwxdiOTGhxPT6WN/CLFMxKrFGaUCQ3Hbu/
 37shCXWA9/BNaApccgwRullpjFw27xSmI86OrSvCchp5tXuVhKBu5KipMMULrj8GY/Np
 6uzJhiDmKA7jjN+qcKR1+nK9WmpGbrpMcjrlRNnvzXbOS6sOO1HOnAiaCFVbp64KoARC
 P4EUfASewu3CMUBVyTjNk6MMheMQ3PS4+F4RakDBCsWTAFSRhkEyHsUhk5fr+bc/Rn3r
 NICb6LNehUhGEie6XjAt45wb/WpqG12o3g2EP/J1JHr3/oHCDflnToxKM4fOKbL191Hb
 iXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733234237; x=1733839037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLiChfJblwp1Jernog2B9tk/jaBR2orXqcxknU+ARjU=;
 b=c7mRCqajsRzCdlQ41+q90l//XRkIw4tf4vWPDqOqVIOSsBeXDO3Cq5JGJi2onjG7Sv
 6FGlUgYgK7hSYHIyG58bLZ2schin2Ob6XgnSx7csAm/wp4NlQoBNYHUNtHXpmC3I2ykT
 yFkXm0yCxTw91lj/FeCe64CIeqbLUTa8z+rmShHjTgVcefXeG1TffTJxwMy+Occdv84r
 gixIr9dO3yH2yERj0/eWZ9wLWK7SCvRJ+cYgO4r+0gsNFuPeAWFu9Oq7nTTWKG6J9Ujm
 vBtDejvq+fhXekpmCKsBNeMCbHvd7rNTlCRmwnNAIkaTm+JmjzNFRqs2LpR6gExNj2yd
 7nzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaDC195b0hdkAdSgFOBogeVK1ouKqMSdxB4qIcwucNAwx9HvjAg43h6jKYpft2ceyFWKWJ+lLsC1Ql@nongnu.org
X-Gm-Message-State: AOJu0YyXVx6ztfU5DbgJJxEsGf3H3f5/ykwhJcuQBDtbi5YNeFrFIMYF
 ixWXUJWbt/WEHcpHODpQyfWTFpvJrsFQmXRBf7unJsvWFRR/TxZs+ijNxJVddBM=
X-Gm-Gg: ASbGncsgIk4K1/ifOlyKwjMjUXF+KILjHz3GPaBXWVvd6Y6uC6fh6lMoR6MTVLp3v02
 aZodeABUWwG36TSLs4xKUwEUUkoCxwfdzRnm8NhtcxcWCN32tInsqce/jcL4hva1s//vacXbbgL
 gZo0JrvHMmppRKBRQnuRELxmt3Bu/CqXiSQH8P9yC322mS16W2+W4ILBtbrXS3xpZc1hWjYnmTU
 TzDMg2C8X/63TXMMM5RNnoBArIZUPIRWcyce7z81sEmfRom6SX8/i/IBW/0xseoS5ujRx9I+RbK
 +16f3YNcq/qyxWVHyFvvrzwPCsG6
X-Google-Smtp-Source: AGHT+IEVbM8PhUusv77qpoJJpeOozVDN7LWm9z8IQppVZz7euJmbwCQRW5ZDtjkB5Jkzzu2iWx/Y1Q==
X-Received: by 2002:a05:6808:1a22:b0:3ea:4b5c:60a8 with SMTP id
 5614622812f47-3eae4a2c931mr1388363b6e.17.1733234237640; 
 Tue, 03 Dec 2024 05:57:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86218084sm2812674b6e.37.2024.12.03.05.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 05:57:16 -0800 (PST)
Message-ID: <dc1b450a-f250-4b84-80bd-6f14888ce327@linaro.org>
Date: Tue, 3 Dec 2024 07:57:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt: Don't consider riscv{32,64} part of the same
 family
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 David Abdurachmanov <davidlt@rivosinc.com>, Mark Corbin <mark@dibsco.co.uk>
References: <20241203094702.124748-1-abologna@redhat.com>
 <cb079b65-e5fc-4667-aa63-9ff347666b6e@linaro.org>
 <Z07a_kYh4duwWKWw@redhat.com>
 <CAFEAcA8BAW4=Yk5q0CgQNL4UZpUJXiwRV6VD-52_Rw0SN=E1Cg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8BAW4=Yk5q0CgQNL4UZpUJXiwRV6VD-52_Rw0SN=E1Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 12/3/24 04:35, Peter Maydell wrote:
> On Tue, 3 Dec 2024 at 10:19, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> Separatley this from patch, we should also consider whether
>> it is time to do the same for aarch64/arm7.
>>
>> If I look at this page:
>>
>>    https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html
>>
>> and sort by 'announced' to see msot recent CPUs first, then
>> almost all of them have "NO" in the "aarch32 support" column.
>>
>> IOW, on modern aarch64 CPUs, qemu-arm is the only viable way
>> to run 32-bit usermode binaries AFAICT, and suggests we ought
>> to be creating a binfmt rule for that on aarch64 hosts.
> 
> What happens if you have a host CPU that *does* support 32-bit
> natively and you also register the binfmt rule? Does the
> host kernel prefer to execute natively or does it invoke
> QEMU? I don't think we want to roll out something that
> silently downgrades native execution to emulation...

The registered rule applies and the kernel invokes qemu.


r~


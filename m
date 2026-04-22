Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13219F94CDF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSkN-0003s8-Bc; Wed, 22 Apr 2026 04:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSkM-0003rT-1w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFSkJ-0004rJ-7M
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776845741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eQdyfY1jQxG4gLiI7uG4o49bJPwhFevJ5PdPg/0p38w=;
 b=hPkWHSzg2bPksGMehdmDGysKDdwBemrMQCEn7vJi8ZSLVaqk6awVrfrBX8Npf5o/Wu04oy
 ukq7gd457maLSYRFwprx9UiqXJaaTnd+Paw+xRynIZkWb0V5pjUbbSRS2HO4m3DHJcgGN8
 LCfrNkZNsZoT4yeA8n29IMa/pYdYrfM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-6gp9WUYKP3qVNvZPDgsZqg-1; Wed, 22 Apr 2026 04:15:40 -0400
X-MC-Unique: 6gp9WUYKP3qVNvZPDgsZqg-1
X-Mimecast-MFC-AGG-ID: 6gp9WUYKP3qVNvZPDgsZqg_1776845739
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48906aa28cbso25857595e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776845739; x=1777450539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eQdyfY1jQxG4gLiI7uG4o49bJPwhFevJ5PdPg/0p38w=;
 b=IjzLuDjozO0nkAXH5Bo3ok74iVkElNzw1ma0GG+cLf3nU58PstOKSAOTsqCRN5OctZ
 0NS4VqrbfuPyrhrNppjlIhgRKEWw8AYRjKXcO5mLx2Ev07SstWVD8oW3M5IaVdtlKs41
 W8z/oVo6ZJ7TMYVrTYkFJ9yhBDouO6awkKEojFOkhsgkwIHBtGC1nNe4o4sL/xZmWjSG
 Kzw7L0YAfndeLD+0mn6yn4ZyYh/zYL0fn9wZQ8Yg74+RWSkFJbnw/eG7XjIqBKkS5t5y
 gQls4izTR+u6pYpRsPlmQcylZTKtVgD4kLHtVLrab1n+SBvuuBijR090BrZvhGthORXy
 FRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845739; x=1777450539;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQdyfY1jQxG4gLiI7uG4o49bJPwhFevJ5PdPg/0p38w=;
 b=V0TZ12+EXzTPrlvWGalKUe/MJy3IEXCPaMXu24BA4kXMLm20YH098m1GTj8D+7kcpk
 OhRLFaA8h6BhvZ9sMcmiv7F9+nTeTOtLGyVE2HphTWINrHpYeNd+zBNSUhym0xmeoVWH
 Pf+joP3XP5ro2cxntuKckJtiw7T+AKITzI/onl+Dsj5w5RoWY8R0fbvRXA3Nxxhe8Z3r
 swxic13C9W2rFMPv0ybf5MVmEczJDKp4ks5k1IKUkwIuE03wwc/MY1ASGbhScdux9n5Q
 tHNXqW5LS3z6Al9UYqZAbhNJHegE1cNAyjKbuHAOWCK4klKYnTP/9FjK80Q2gZSf0ZOe
 /7bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pfSxJVci7uFKJbcXhN4/iikY348yhBC/iMWmjG+0w+vbHxpVpf+LMt1Fvro9s+MfOC4GWLSlhQ9Cy@nongnu.org
X-Gm-Message-State: AOJu0YyiZt0rIDstfkGM7rbd9nDjSdTI6Nw5E4i4s0/YFgchfxwwGwYs
 iWTLV4hyLZDNZcSpQjKLiVSaAy48SlBzyvdwUbH6Zh7yeIXb4n24cVRbeNRH2xGZFEyCV2XJYad
 xlK1XcnbdNkDzMraaJaZUKQnst4YSaOaWbKU2tMiwopJPh034vgi4hUtn
X-Gm-Gg: AeBDietsV0aYTo9i30UdqBAy27Le+wk0WF+ISySRTmcZVdn5OVpvz1T1KzZnnOEdw57
 Rc4VpKPkxVP9cTkAEfOzD9gyb9upWpL1k73OdX34yuYnoFS55QtEUYx2J7uIE2Pr0X/pBRWg6ak
 oRHXYzjSwWGUf1bsN6kZU2m1+v6VRWzX7zOde24G4KXAMLlu1o9S0BIYAJ6fIdyl12ApHq9IF1E
 DeKvtNg0Xo2OPA+u+ovVqDGZTOYIviv+AG1vMzAyjlS0zdtfZbw0oOK/ux7UBiK4zllPQchftI2
 kKFsIoVaRAH36u0I5Sl8JYPWiyE0hFSOhGpDniD8z6B7SHom9txxyIwPZuMQ/dYBO5wSF3PZ6c+
 KCgYiaTW+iMVxLNOe/oE39ySVlQvCog==
X-Received: by 2002:a05:600c:6c8:b0:48a:5236:7f38 with SMTP id
 5b1f17b1804b1-48a52368058mr82988605e9.14.1776845738976; 
 Wed, 22 Apr 2026 01:15:38 -0700 (PDT)
X-Received: by 2002:a05:600c:6c8:b0:48a:5236:7f38 with SMTP id
 5b1f17b1804b1-48a52368058mr82988185e9.14.1776845738481; 
 Wed, 22 Apr 2026 01:15:38 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm39718245f8f.32.2026.04.22.01.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 01:15:37 -0700 (PDT)
Message-ID: <6d0bca64-52f6-4e49-a065-d5e0a2c22853@redhat.com>
Date: Wed, 22 Apr 2026 10:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] MAINTAINERS: Remove my disfunctional emails
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bin Meng <bmeng.cn@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org
References: <20260422080406.62638-1-philmd@linaro.org>
 <20260422080406.62638-3-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260422080406.62638-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/04/2026 10.03, Philippe Mathieu-Daudé wrote:
> With retrospective, mentioning email in authorship wasn't
> really useful, more now than these addresses are dead:
>   - f4bug@amsat.org
>   - philmd@redhat.com
> Simply remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sdmmc-internal.h                      | 2 +-
>   include/crypto/tls-cipher-suites.h          | 2 +-
>   include/hw/i2c/arm_sbcon_i2c.h              | 2 +-
>   include/hw/misc/bcm2835_thermal.h           | 2 +-
>   include/hw/misc/led.h                       | 2 +-
>   include/hw/timer/bcm2835_systmr.h           | 2 +-
>   include/qemu/units.h                        | 2 +-
>   crypto/tls-cipher-suites.c                  | 2 +-
>   hw/i386/fw_cfg.c                            | 2 +-
>   hw/i386/pc_sysfw_ovmf-stubs.c               | 2 +-
>   hw/misc/bcm2835_thermal.c                   | 2 +-
>   hw/misc/led.c                               | 2 +-
>   hw/ppc/fw_cfg.c                             | 2 +-
>   hw/sd/sd.c                                  | 2 +-
>   hw/timer/bcm2835_systmr.c                   | 2 +-
>   hw/usb/bus-stub.c                           | 2 +-
>   stubs/fw_cfg.c                              | 2 +-
>   stubs/hotplug-stubs.c                       | 2 +-
>   stubs/qdev.c                                | 2 +-
>   tests/qtest/fuzz-sb16-test.c                | 2 +-
>   tests/qtest/fuzz-sdcard-test.c              | 2 +-
>   tests/qtest/sdhci-test.c                    | 2 +-
>   tests/functional/aarch64/test_raspi3.py     | 2 +-
>   tests/functional/arm/test_bflt.py           | 2 +-
>   tests/functional/arm/test_raspi2.py         | 2 +-
>   tests/functional/m68k/test_nextcube.py      | 2 +-
>   tests/functional/mips/test_malta.py         | 2 +-
>   tests/functional/mips64el/test_fuloong2e.py | 2 +-
>   tests/functional/mips64el/test_malta.py     | 2 +-
>   tests/functional/mipsel/test_malta.py       | 2 +-
>   tests/functional/ppc/test_40p.py            | 2 +-
>   tests/functional/qemu_test/tesseract.py     | 2 +-
>   32 files changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



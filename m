Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE19D4976E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 13:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHk6H-0004Nh-Lg; Sun, 01 Dec 2024 08:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tHk6F-0004N9-5r
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 08:34:59 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tHk6D-0007Zd-I0
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 08:34:58 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa531a70416so224917866b.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733060096; x=1733664896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NGCMlNJwJWoPBUMYqj5ryk/jTzepTBn3oHHeeRGVIxM=;
 b=YfR5H/3B54eGCnkz4H1r04AU38zuIRLec/A+SgMCAlrnUzvsN1E6T8U1RlU3RKdI9P
 VuQ+ECD+8rKTHokG/YLeEEOJrV7qqbDE12hujq1JZN7itYzfRkbzt9g6tihSBgzZ7Muv
 cJMGF+kGin7H6gQWHcgQpSleOYFJ/VPynBKamm2NaEwvqAhb4GzG68Vv2ZVpUIK8xdJN
 cyhN4bRiXURsDEQwTQZfcERAXV3OhKKHQyMIvrlIdspuZO9wvzHxTHHwIuLIEFD7+tPH
 ZvtbUUeDw+kjSHv/FbD8ffjuOLmP1KI3tyQPBQxHCPsNK8dl00iL+IQYqAojHrcVRjsn
 7RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733060096; x=1733664896;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGCMlNJwJWoPBUMYqj5ryk/jTzepTBn3oHHeeRGVIxM=;
 b=CMaOsqjjKHZ9xjxfqb7nUl+ht/IhPx5BWdbhvxZLAHM4Vy+eEFPLd1nwK7OIigghLf
 zabRZREJ/AgB9tVL+AAeb88qOAd1fmPKQp3ZLP5Hfw7WxskVPkOWyr7l10MSVTACOUsn
 P/LL2zaIF06HjZXb3Y9Z4VNrpfZiS2pF113QTqEhzwzphwiFaVFvmEKOAW7S71ocYhKx
 foUfEq6wxSBb1gLCKwJ1XzWQnDsL96ozIy0DCD45tRKJvb0EkCOhO3U8XK/BlHcw2EcF
 XemYKbDO/EGF/h/gmh0Xf4qxAzSXYW1MUkWkJnbNM+Pp+J234/dy6VYC9M7IGML7I9QY
 TL2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4GPDKLVGrkLUV11yxpej7IntHi5vvWnWd7+PPREYwxHZZkna6ZF2LHTAmv0ycHPYOoEjaxyPi0WkA@nongnu.org
X-Gm-Message-State: AOJu0YxM6yyCMzbtSprL/iekX/BwO5un+zG+Gam6jkL+/QooAb6Xl3b7
 B1mhkxbdnQrHiJEWLDx4xais5h7N1Z7WW/fJSMniBh0x5rz+Mgc5p1dlKCI8+t0=
X-Gm-Gg: ASbGncv7wRBApQAinHNOB1D2H7Y3XzZaXk/qMDv/pQRn4ax1T8nx56+Up5pDnGkhVg3
 U4QHQ1msTUgRMFgVpYW+K9ZQffziTHWWdkRYfS1wfTFJ5dou/rsvBtiePKcQlS18mfDy43BcDkF
 SQ1csEA5MBLtzI6bJTFaHKbGaCqt+PtTuUkd/Tf65W9aHRXbhFcisHptFrR4MhX62LOioTLzW4y
 jnyoifNg5PCiRb9WtpGDE2DV6K1Dk5yfOsx3pPX50Z1hKVS5FIdWcjhd3M7ePpSyFd4utZJ7LyR
 DSG5cjM+S9BtAR2Tf/S9iBflqzLl
X-Google-Smtp-Source: AGHT+IFHZqpJqSlEtwdeIDHp6W4GiXOVY24VRNGVAeNSPU88fdKNrEXs5cfmhllQnQH3wfEOvZZm3Q==
X-Received: by 2002:a05:6402:401a:b0:5d0:ccce:34b2 with SMTP id
 4fb4d7f45d1cf-5d0ccce8ba0mr9020357a12.29.1733060095554; 
 Sun, 01 Dec 2024 05:34:55 -0800 (PST)
Received: from [192.168.210.26] (83.11.10.28.ipv4.supernova.orange.pl.
 [83.11.10.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59990a9dfsm394070566b.157.2024.12.01.05.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 05:34:55 -0800 (PST)
Message-ID: <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
Date: Sun, 1 Dec 2024 14:34:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

W dniu 28.11.2024 o 22:37, Pierrick Bouvier pisze:
> This boot an OP-TEE environment, and launch a nested guest VM inside it
> using the Realms feature. We do it for virt and sbsa-ref platforms.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 5c048cfac6d..b975a1560df 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -13,6 +13,8 @@ endif
>   test_timeouts = {
>     'aarch64_aspeed' : 600,
>     'aarch64_raspi4' : 480,

> +  'aarch64_rme_virt' : 720,

Took 2974.95s on M1 Pro macbook.

> +  'aarch64_rme_sbsaref' : 720,

This one needed 2288.29s.

>     'aarch64_sbsaref_alpine' : 720,

Have to check cause timed out.

>     'aarch64_sbsaref_freebsd' : 720,

331.65s

So RME tests probably need longer timeouts or would not run at all.


> +++ b/tests/functional/test_aarch64_rme_sbsaref.py

> +        self.vm.add_args('-accel', 'tcg')

That's default value so can be skipped.

> +        self.vm.add_args('-cpu', 'max,x-rme=on')

> +        self.vm.add_args('-m', '2G')

I sent patch to bump default memsize to 2G recently.

> +        self.vm.add_args('-M', 'sbsa-ref')
> +        self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
> +        self.vm.add_args('-drive', f'file={pflash1},format=raw,if=pflash')
> +        self.vm.add_args('-drive', f'file=fat:rw:{virtual},format=raw')

> +        self.vm.add_args('-drive', f'format=raw,if=none,file={drive},id=hd0')
> +        self.vm.add_args('-device', 'virtio-blk-pci,drive=hd0')

sbsa-ref is fully emulated target. There is AHCI controller built-in so 
only "-drive" argument should be needed (no "-device" one).

> +        self.vm.add_args('-device', 'virtio-9p-pci,fsdev=shr0,mount_tag=shr0')
> +        self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')

> +        self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
> +        self.vm.add_args('-netdev', 'user,id=net0')

e1000e is built-in already


As both virt and sbsa-ref tests do "more or less" the same stuff then it 
would be good to make common file/class and reuse it both tests by 
adding hardware differences.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F78C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texSi-0008Bv-OM; Mon, 03 Feb 2025 09:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texSW-00085g-3d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:29:56 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texST-0000zC-Gh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:29:54 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso771341666b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738592991; x=1739197791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q81kVMqrner4fCkOlgrEemCKHgFVSH6RMhCgwmU8w1s=;
 b=WqZ32Q5wkT/yjNboQCqS/7U7mYntRSgQG4uZEGxT24eTdqmZoTCvEs1NzbS0hzg023
 5SudZ46Dd95wlbblIUJ/9LC3Mmru1un8mNCVKWOqkyMwTgOceS2Mqq4lmMhEEr6ZMS//
 Tvmd9vXdYxNt1E+hma5o2eupf0BUU597YWJ3Y8BvR/vUMbGbPfUn9YG3lW5kcJd+iqAN
 p2bp2OFeEaV4K1jsnQkfNtmqwPhPMny13q2xE2edfCHKpy+lSZouIYIK34KZnWMmwfkx
 ZiBxdTssZ2JA8NUllZuNZ9O9u0J40RE4mrIy42MxZV2yVLVnECpdoBUTNh1FYINYt4ph
 BNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738592991; x=1739197791;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q81kVMqrner4fCkOlgrEemCKHgFVSH6RMhCgwmU8w1s=;
 b=FnkRuNii3vk3dmi+CNoQI10CFubXFJoZ88rqdT9kF+d71vWd9/7JjtCcG+erVRIetH
 wGDkgDqsPEKg7I8GShdNpOtGXEMqMUFiBTWs0QeXvIvxxBa2Ro0YHSZYq6r7u1AQyLwK
 YxRG66G6EfzIGDwFc5+Q0q1/tzoiivjwSW9UzydJ5DHT5bxG9KjWzP1BG7Rx3xp1umS+
 mAFaLhJyAGzaEEva8Ev3hkpLRRKtY8DM20NpG0tCYEwMJH9BSNHh0Wxe0Lmf5tUx/tkP
 z7/DGn/ntp+xyJSHZneLotN3bHDYOaY45hOtyB6wP+MVj+/RgbTyebqiKlRPW7f3mxeF
 K4MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAZkE/Nb8Wpzb8KELY4wxRj6bohmb03u98dXQz6nljsFVaHI/rKMvli1WKX4szeHM41UffVeot4/Ws@nongnu.org
X-Gm-Message-State: AOJu0Yx3tGMLPcnIwNdrcF2GJYnSJWjpM3/5mZScOhJ9auQOMy9BO7HT
 V7Ht1j07w1/Ao3o3PSgwBXq7IunWsC4GW1iXcl6AdKNNMwuBS091qMP9TZkWjU0=
X-Gm-Gg: ASbGnctzIe/FOJL6Ww08mouWKXYzgyeTYhPWacy18KF/MY1calngnxbup7GvyXTqUZr
 fHXwNMxwv2yqzZPyZG2yEb8feUfRNVL2N4RTHH8900/FfV00srx8RTuJ87Qta6EXYhoFhVGVZHd
 KY3+RzFVDuQOR3u38YbX7HL1QxPp0ubZU/01Sk7tam/PQOZjlp0aF/Kl2qdPZfDT1Jjew7XcN/4
 ST2l36FYOvT7xr+hgWx9VHtn6klxezk4xK+TXLzXaLH9Fn0wxoEQjzzJH8r673DbzsYMjVnKWZc
 6gyaUZDG/gv5xdc6mA==
X-Google-Smtp-Source: AGHT+IFYKv+hyjFiSxTc1l9pJGe0iMDtdJ/EflTD0xCRvAIyNftvHRTxwT4OL9GIMdGkRD1zM18nRQ==
X-Received: by 2002:a17:906:6a1a:b0:ab3:ae1d:8abf with SMTP id
 a640c23a62f3a-ab6cfe12f29mr2345641066b.56.1738592991014; 
 Mon, 03 Feb 2025 06:29:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6edd6acf5sm697886266b.25.2025.02.03.06.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:29:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B0CC5F8BF;
 Mon,  3 Feb 2025 14:29:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Jared Mauch
 <jared+home@puck.nether.net>,  qemu-arm@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
In-Reply-To: <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 (Peter Maydell's message of "Sat, 1 Feb 2025 13:51:21 +0000")
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 14:29:49 +0000
Message-ID: <87ed0fayoy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Sat, 1 Feb 2025, Philippe Mathieu-Daud=C3=A9 wrote:
>> > - Deprecate the 'raspi4b' machine name, renaming it as
>> >  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
>> > - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
>> >  respectively 4GB and 8GB of DRAM.
>>
>> IMHO (meaning you can ignore it, just my opinion) if the only difference
>> is the memory size -machine raspi4b -memory 4g would be better user
>> experience than having a lot of different machines.
>
> Yes, I think I agree. We have a way for users to specify
> how much memory they want, and I think it makes more sense
> to use that than to have lots of different machine types.

I guess for the Pi we should validate the -memory supplied is on of the
supported grid of devices rather than an arbitrary value?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


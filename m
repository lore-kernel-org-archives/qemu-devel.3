Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E702C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKOq-0004fG-FN; Tue, 04 Feb 2025 09:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfKOf-0004dT-Q6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:59:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfKOe-0002tb-9E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:59:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so66073585e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681166; x=1739285966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G8anBbyMT55oA4TitLuKWWu2XDaUG1CFB4kIBNGpbGw=;
 b=YLJkkFlOldn4I0SyT8Xbdou0zQTy1gOjj7wmU1TG8rviyyKwy+HPkccDsJWMecb78I
 upjZOiNln1M+1sNlfrvghU3tG76tADDstTh1YXlOHgvHYQaTT0hUFKcX0m5i6TJAVUQ/
 XYrdIfZI9fbvCdyTIEXHND2ya09ydvROP9ygDeJyvf6N0BUVt5MkWH/28wbzrok2tcCf
 5T4wE9DG7WHo8nIvx7zUgUqnL+qM1PH7aYSiX/2FZbEIAyejdlr4rFH76QWX74LHLzB2
 O4CjPdWceyd8LaA95YLdl/mLvSHEq9FOfY58Zde/aGolnlHCA/YBEdcZL7vM87qdfuLv
 5Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681166; x=1739285966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G8anBbyMT55oA4TitLuKWWu2XDaUG1CFB4kIBNGpbGw=;
 b=wmfwqjTSJTsG+louYmgrBv0Be4SgOKXhdJ+vrU1VPBOc7heZOJzCOGuF7nDF+kbjj1
 Uz5yPkfeDr4MOwbwnk6ckB29gW0ihcRkrHtPbwDWMu/auuzSdc12oAw/XbICNL4aC6Ru
 VtyTlbRpdfkjguSTx2kyGDgHYFZ1YeH4iEd4CeQVxXkl7eJrCB84ZUSCqcmgxs2jgexl
 G63sw0U7CuFg9VABHgi9dW1i68bgcsmow5oNZLkGOSeHytPtk33iUDxr946il8pjyZZi
 9ajcYSMywsOG6g4JMscQ2Kac6D5F6/DvRlrrKug5s7QFH8tcRI+a+eZ1umUzhrhE0Paj
 q8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTtFgqdaq99DX6Tuaz5UT98vBNeF4B3RUapzVeonDsEDuut4sbyOX8Yb3qOo/7sP5iesW46vqtyFTb@nongnu.org
X-Gm-Message-State: AOJu0Yy2ZQrRTYyjPxcM24nVkXZsY4UWgusDYzUsHPtUaw/0a7KS7Czb
 kbaQtjSDlgdWhI6FDcZ4SRlo0I5aarEQvpCWIawZo6EHC4EgPsj+aVn8Sy2G2q8=
X-Gm-Gg: ASbGnctj84qr/Zck86zg4H1/rka+PrTgs2Tv2GqpEWvWBM4sbB0UTNlRjFT5JRO4y8G
 5hVV1z42QNy7XTU1eY4EO9DeBtvhwQOhotX1oiJZYp76FimEqMnIumz6BOCIs/6NJNIPV/xyceZ
 IKNnq0PRFGThNaw+6dqSGx06D4/tzVvk4SD37JXGu2X4Ybb1p32xKl4gQngxe592fC2QrgRAZ9U
 3S694eY09Eu07t2SbddXLCyvQszNnAGSgQO0uyz8HrrTufczZ1WVKEIYf8s5NPirWe2NUfqPyXY
 VHN7fsNu9h4CMTQmGAEXzQb1Tl2dop7aWBLZZ5+DAWF7ltctHkg71g3i+t8=
X-Google-Smtp-Source: AGHT+IEu5vViV42ffKjJRwQusiGEU2jHEczefEeY2w30sljGmqFRrYksEhjWr66LJJC4E5zny08+5w==
X-Received: by 2002:a05:600c:500b:b0:436:fa4f:a1cf with SMTP id
 5b1f17b1804b1-438dc42551fmr232683835e9.29.1738681165971; 
 Tue, 04 Feb 2025 06:59:25 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f41esm193956215e9.36.2025.02.04.06.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 06:59:25 -0800 (PST)
Message-ID: <e368b476-5958-404a-98e0-591e8f638d34@linaro.org>
Date: Tue, 4 Feb 2025 15:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <Z6HklNsu0Mzgh7bC@redhat.com>
 <CAFEAcA9m8g=K-0RU31kswbNSKWnUqA78KxNkcXEAqR=BhWc9bA@mail.gmail.com>
 <8616891b-9747-4388-99dc-d6e53e090001@linaro.org>
 <CAFEAcA9weFzHW+kL8W0GD26A+QTWpC7Baf9-=Oc3t2yw77=RCA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9weFzHW+kL8W0GD26A+QTWpC7Baf9-=Oc3t2yw77=RCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/2/25 14:52, Peter Maydell wrote:
> On Tue, 4 Feb 2025 at 13:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 4/2/25 12:13, Peter Maydell wrote:
>>> On Tue, 4 Feb 2025 at 09:57, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> IMHO we can have distinct machines for each model, but
>>>> *NOT* have further machines for each RAM size within a
>>>> model.
>>>
>>> Yes, this was what I was intending to suggest. Apologies
>>> if I was confusing with what I said the previous time round.
>>
>> OK, let's see if we understand each other correctly as developer,
>> before explaining to users, taking the 4B model as example.
>>
>> The 4B come in 4 physical variants, depending on the amount of
>> DRAM: 1G, 2G, 4G and 8G.
>>
>> We can not allocate 2G on 32-bit hosts, so to have a reproducible
>> guest behavior on 32/64-bit hosts, it makes sense to takes the
>> model with 1G of DRAM as default for the 'raspi4b' machine.
> 
> At the moment we create the 1GB version on 32-bit hosts and
> the 2GB version on 64-bit hosts. I dunno that that's ideal,
> but I think it's probably best not to change that at this point.

Well this is annoying in my "unify qemu-system-{arm/aarch64}" effort,
but not a blocker.

>> If an user specify -m 2G ... 8G, we can adapt the 'board_rev'
>> register to expose the corresponding amount of ram. Now, how /
>> where to tell the users 1/ the default is 1G, and 2/ they can use
>> 2/4/8G?
> 
> In the documentation: docs/system/arm/raspi.rst .

OK.

Back to this series, please tell me if patches 1-7 aren't useful or
if you prefer them in a separate series:

   hw/arm/raspi: Access SoC parent object using  BCM283X_BASE() macro
   hw/arm/raspi: Merge model 4B with other models
   hw/arm/raspi: Unify RASPI_MACHINE types
   hw/arm/raspi: Pass board_rev as argument to raspi_base_machine_init()
   hw/arm/raspi: Consider processor id in types[] array
   hw/arm/raspi: Consider network interface for B models
   hw/arm/raspi: Check ramsize is within chipset aperture

Thanks,

Phil.


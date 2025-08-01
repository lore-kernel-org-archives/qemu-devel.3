Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A79FC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuU9-0005EQ-UZ; Fri, 01 Aug 2025 14:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uht0u-0000Nh-J9
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:53:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uht0s-0005kb-Oc
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:53:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2403df11a2aso14025165ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754067225; x=1754672025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RdgW7c2eroL9g4iq9Ekphc8v95mGb3W34QRHwdPUOdw=;
 b=etkCOYKEep73vpCz3guwwNyeotZu0F3IRbSaTLvajk6GSFwFSBCVPzlingYIA4driz
 mQiX7e/HWsAQoVJbeFsU7R2sZvQt7Lq1aEP4nWBpbuj1O7rbv+dLcU3hl2L2EAXuARlL
 MBoh16IG+gsJkb+sbpgXs6D3R6w9W/DJwFrtbtLYlRcLQbGbBojo1/kV73zf7Y96TuYI
 SiHL0vDNPkd4Fi9jEdIJdqdKXFi4o+9ksRK9k0GtwNYUy2Pi23ZYVhTqi/mu+NlPQrPD
 RS9+0oKup60YyBGfD+ffNy6PpCetQh9iImzNvxyFbBq5T31rvQXT+sqCC1CCZkK10hEh
 CmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754067225; x=1754672025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RdgW7c2eroL9g4iq9Ekphc8v95mGb3W34QRHwdPUOdw=;
 b=VRCr2FZEEUynT8Gnr46A7tYl0HohjiX1GN3vlIKHu+gnBTQC/G2SlZmSuZhUApMjL7
 k4aLkPAs1sBjPMdM47U5GWPlnsfncMYKS31ptH5Nw8MQ21eeRAJSsJfIE1aKpHRNdaPJ
 cRhbqoFFI8fr9Yr5+ruuD+GMoXg4IBnkK5b7Tmn5+4WHZRZ+ccIM6bka1ulXqInYieJ3
 7KzPgMezyqJpm+FjLf7FbVJCvXE03lV3tC5aQypOSax6VcbuirVYJTmUsgN9vtHJG6qZ
 xZxt5Y8i2uArFQ9eq79g12iZHqLH89iZRM9qsTS4GrthWD3v9muvq+IYxsa33gqpDDZW
 vqYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPtlOXiZQIdWltSqMbIrt8dbd7xUMKa1yyR4uOTSRcms1ifmTyMQQ57CFigE57u3fFMMbR6G3Mot8D@nongnu.org
X-Gm-Message-State: AOJu0YxipnSgC2jPsz6gRHMJsw8mYrb9w2zrtOlEm0pSExRXU+WLJw+9
 C4gBTmJD5kXKE4895WwDxeDUYS9UU5WBdkC63WNcRiIqpl+yDwXqqplEvcv9sQRCXvo=
X-Gm-Gg: ASbGncsex5gKTv/q3JWLR9xbpqTgAbPcjdLXaIroKhYQfQ/ybsAcyVze0yI6bMpfxek
 kr7OHZ2Joe0KpKK5HiSkdYOjI8uzNkuk7qOv2jvTnk+UmQc4zOWLRaZ2536b7hzVtgXCxhDnpi9
 VeAA0+/UMHLY1gCJ/5ybyv4XSD9rQMbEhWPPtlmGnWqjIsiesbh/N935Jc3076oT/ACdCNJrT0z
 jQ52ZFyLf0BURBMSekFf5zymLAzMXPFgiKJYyUZub5kLYmKFxUP6JYycJBLsC8BL/j0ehK2AT0N
 qsZp8Nld2BVSfOkjLGoPgXVC3PpIhDHs4ACqti4JVzouSFt3CzNV8XVzQkHU5Vtwq9rMOj25nLb
 gT0Cu7RGwy67Lq3w+rMwhShiNLOj/B8fkRLY=
X-Google-Smtp-Source: AGHT+IH1dp6cL2w8xYX+B6GrGB/3vHDERha/bl+iTTGg6uvKQNsyEjMwv1c9eDxqx6sHnl39Uycq8g==
X-Received: by 2002:a17:902:f304:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-24246f667acmr2140435ad.13.1754067224847; 
 Fri, 01 Aug 2025 09:53:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ac02c9sm47460505ad.184.2025.08.01.09.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:53:44 -0700 (PDT)
Message-ID: <cf097501-98b4-453e-9d89-e4af8d0e192a@linaro.org>
Date: Fri, 1 Aug 2025 09:53:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
 <2c337408-5caa-4e24-a8dd-d947203a1dc3@linaro.org>
 <CAFEAcA-LmS0dus5ZW6P+-VXkw=m4K3MaE6O+Qtj5i3H7ULJFFQ@mail.gmail.com>
 <cedc5b94-78e3-4d9a-bdd8-60c82673c136@linaro.org>
 <CAFEAcA8j7S6qVxmd8dairF=4kpn2=uBeFFxY22M5FgyTnjcJ+Q@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8j7S6qVxmd8dairF=4kpn2=uBeFFxY22M5FgyTnjcJ+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/1/25 9:44 AM, Peter Maydell wrote:
> On Fri, 1 Aug 2025 at 17:41, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/1/25 9:37 AM, Peter Maydell wrote:
>>> We do at least define the fields so you get a nice view of it:
>>>
>>> (gdb) print $cpsr
>>> $4 = [ EL=0 BTYPE=0 Z ]
>>>
>>
>> Do you have specific pretty printers installed? On my debian trixie (gdb
>> 16.3), there is no pretty printer for cpsr by default.
> 
> I'm not aware of having installed any. This is
> GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
> 

Trying with a ubuntu 24.04 container, I don't see it neither. Maybe 
something is missing in my gdbinit.

> I was assuming that this was just plain gdb doing something
> useful because the xml defines the field names and bitpositions
> (at least if your QEMU has commit 63070ce368e1a where Manos
> synced our xml to upstream gdb's to add these).
> 
> -- PMM



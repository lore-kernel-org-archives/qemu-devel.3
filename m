Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75002CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 14:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxp9e-0001fa-CH; Mon, 07 Oct 2024 10:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxp9b-0001fB-5J
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:56:07 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxp9X-0004zD-MV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 10:56:05 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a0c9ff90b1so15173045ab.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728312961; x=1728917761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BKdgXElvtmC3BjQfBOpKZHEnG7ZOBX48jxp32nA7fXo=;
 b=BOHO7VSWB6DJpmms9eVdYrSdIxiRHwfQoe1sQTbgsXHkL04VYSkK9fxjri5BxyoszM
 JJ3voX4nc60xqABmHA9Llx2zlC5calC/RxgufZBKcfVhlprdek/wbO73IcFfsnNYPkXj
 38Cvr7s9Yf0Ub3YAEu7LXumZ2n71J0S34HA7PzG9idQZaB8B8NuIJdxWm/26fqd4pK9X
 +0oVyIWAKKLsvG3oqKjOWZ42oC82EBwfsrnMmS1c6k0P5y7ix3pJnLvajYD1avyUfhj8
 288wEoks/glrZxwKap3WdyVDHm5FYguHpZv8KgwPL0Ht4DCsbjk21KoCKBoFxBT6l+di
 OcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728312961; x=1728917761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BKdgXElvtmC3BjQfBOpKZHEnG7ZOBX48jxp32nA7fXo=;
 b=arI0WIjHrTJQ2Q5avw7drcZ1EPGFrlVoMyDt2itQPYFLhvK7I4QdXKeSqqcov/sxIS
 Oqtq9T9oWa1jbr/A797j3yKPehY5Ktv/DMO4rAzUAy76+F/iGHJe0/wZelyLjHEL5FDw
 lFJo2KWWm1MSErj02sULd6E+SC8rrrButP30o7wa1EVDk4UpT4EeGQL6uLseN4o7cUDQ
 ifOBEWKH/HDVPNJ849pW3EB1TkP64wiJtGVt825zD3n7qd0cRSvLLiwwaZ4O854krOuU
 xMsfbuWzch1Eye3itv5wh5L5jHgrxqiLUnu/Ur693FadBjnYKOIxFNEiyQYnsSsQvUhN
 X9HQ==
X-Gm-Message-State: AOJu0YzGMmqOrDYNgAhQpmJKAr5OM8hQLrF0lFE0P59xB/VLB7hZFLcK
 qIXr8XsarpmG6g8zeHLZ3fYedWALnE+e9RsGLevmEaxKr3X3rbBAPnt54q/BLCg=
X-Google-Smtp-Source: AGHT+IHs+txySE7ClBpcV46ESWbYoaZZJnjz1fVRhUI0gxFEtBa3vfreuQKlyf8E2OE/YI23WadR5A==
X-Received: by 2002:a05:6e02:148c:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a375a9ac5emr97788365ab.15.1728312961146; 
 Mon, 07 Oct 2024 07:56:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c375b0sm5004071a12.69.2024.10.07.07.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 07:56:00 -0700 (PDT)
Message-ID: <9d0c83aa-a22d-43b1-bd96-6ef64ea9ae96@linaro.org>
Date: Mon, 7 Oct 2024 07:55:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson: define qemu_isa_flags
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 qemu-stable@nongnu.org, alex.bennee@linaro.org
References: <20241007084342.1264048-1-pbonzini@redhat.com>
 <20241007084342.1264048-2-pbonzini@redhat.com>
 <86423148-2cbb-4263-a351-dac0ece198e7@linaro.org>
 <CABgObfYu2jqKMJ_xrNv1Ci5B2NSxrcaaUO2piu=3o=Ca=Sn_tQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfYu2jqKMJ_xrNv1Ci5B2NSxrcaaUO2piu=3o=Ca=Sn_tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
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

On 10/7/24 07:48, Paolo Bonzini wrote:
> On Mon, Oct 7, 2024 at 4:46 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>> -  qemu_common_flags = ['-march=i486'] + qemu_common_flags
>>> +  qemu_isa_flags = ['-march=i486']
>>
>> Use += ?
> 
> Here the qemu_isa_flags are known to be empty.

... until we add something else beforehand and fail to update.
Surely it's easier to assume that it's not empty.

> I just didn't want to change behavior here (especially since this
> patch was already about subtle changes in behavior). But you're right
> that at least within qemu_isa_flags the order should not matter.

Fair enough.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28657C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWNM-0001Db-CX; Mon, 26 May 2025 07:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJWNC-0001Bd-Iq
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:52:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJWN9-0005N2-8b
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:52:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so16128125e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748260321; x=1748865121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5bj6bIwbgPkXidk1nsmH1ouD1Rr4jzxJndqN4ZKZ1sU=;
 b=YbtqnI9GPSVNCtho9tHtyFHr4tNEpcTruuUEliqH5+AVd0/eKQ8dZMrGIEcHfNJgpe
 h0MtwFmVxAoRyG39wc676J5zIEFjYd1nlYNTd1pmRMcsL0O0JnQ4ZPWKzGpvLHwtjESk
 6nXvm4mXIHdfk+MaGjrO0ufB0ImEAMi0BLn2tflF+rw+1Cbi8rHLdv3BO7omcqmWoXrP
 I3ftWdRXsyZzAs9kl27VzuVRdU+Tp1W8TdSo22eL0RH+ZBC1LMhyVHtpYzUBCJfG7Qg2
 Lc1yd6X3Z6rTY1UI4hBelnjUqkK3EjrwEewnjjZixmCyjuQEdRy6otCnlQ0CJmeMIOUj
 zupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748260321; x=1748865121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5bj6bIwbgPkXidk1nsmH1ouD1Rr4jzxJndqN4ZKZ1sU=;
 b=EwqTPpD+7Gb/M5vKGDVw8Y2M3hKxMbUZ7dr7Xx8rhQpBDeFQht3t0lIei68N1dpaRy
 A6xT213VK8QzX7oklsLTQ8UskbxAMBnkLod2Qvax5pkSkY+fvIndZJ2iM67dGHWfCmqw
 4wbaEzcoKMtQw2KQjrxxGV/uAjkSJuks02w2QYfpqdW/lEkfJuDurB7qPIG35A6JLNnb
 aEKuE/3TBOGKueSshc8hRdN4OcfHEmwPga0Cmxn7y6+gkPrmgA3gRW4F8oWq5aECflJZ
 YAPGJ9miRBLsFc95iEzdF+GkGWVbD/e1495HIJs03NkVsGtyMIZmlNSwieXHS6g7jmtR
 ZOjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhFrHLErL79JRl41VhK1i6Ze2jdQUMLA/X2GWp8QJCZ1mEUsps3etsbtM+Hj7+Jm8Ci+NK3NwdVGB/@nongnu.org
X-Gm-Message-State: AOJu0YyZhxtmSiPUNIfDpcD9aJ9KreIymEI4RhEkeUgJ7M6Ecvb77YHF
 UBGOKtfHF7uCKJEkg27bw+j8aXGH4ritNAU1qQsCevOW8RwkMzPD4W/fPfdOFtFp/QQ=
X-Gm-Gg: ASbGncsZBizpi/ja67ejfEwDhQ9Oy0WXTm+QI+XKOnQertPwJENAes48glD5Ryap5K1
 +J92vrUh7IOQ6R0NQnFbCyL7+i7+6NOnd8HgmLurAvGkwxQH7Xoi17t/zEyho0Op8bnf/7kCoy4
 9qoXp1As9ikjyO8niEviG1BCEdNfnqlsnnmrL1oomczsMoHKqBMBXouIC/RD0eNTNY1pklVmFht
 ilkxGj7O9gfxw7D6jHdMHjMvTzX+Hd7L/gO0MTGlRjPSSRj7jxWLQI6LK+HuGpEaYZFh3C4cXt7
 6w1HMbWMbLk2fBpj5JjlEt88FIfodiDNZE5+6TyhgXQtPPzSH+yZDPL8TFZmDXzbOuGy5qTmveA
 B5fGbmWGmQfHsnSj6bL48UnZX
X-Google-Smtp-Source: AGHT+IE1ejIXk88oBQMZiTtbVnM0TOne1rJvR8pzFBmoladnA925zty2zgka17YBrsh70WkX4zEUUg==
X-Received: by 2002:a05:600c:848e:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-44c7bda05dcmr83956955e9.10.1748260320745; 
 Mon, 26 May 2025 04:52:00 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d37498e8sm4860779f8f.16.2025.05.26.04.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 04:52:00 -0700 (PDT)
Message-ID: <ba766eae-e8e0-436a-ad30-625744b872e4@linaro.org>
Date: Mon, 26 May 2025 13:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-4-philmd@linaro.org>
 <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <eff37ca7-d977-450e-85e0-ca8e4f6f3d5a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/5/25 13:48, Cédric Le Goater wrote:
> On 5/26/25 13:23, Philippe Mathieu-Daudé wrote:
>> Since commit 9808ce6d5cb, building QEMU configured with
>> '--without-default-devices' fails:
>>
>>    Undefined symbols for architecture arm64:
>>      "_pnv_chip_find_core", referenced from:
>>          _helper_load_sprd in target_ppc_misc_helper.c.o
>>          _helper_store_sprd in target_ppc_misc_helper.c.o
>>    ld: symbol(s) not found for architecture arm64
>>    clang: error: linker command failed with exit code 1
>> > Fix by adding a stub when CONFIG_POWERNV is not available.
> 
> The fix would be to add an abstract handler to implement SPRD accesses
> on the PowerNV machine.

I don't know what "SPRD" is so I'll let someone more familiar with
this area do the proper cleanup.

Regards,

Phil.

> 
> Thanks,
> 
> C.



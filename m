Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18533E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaae-00062W-Eh; Fri, 20 Dec 2024 05:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaac-00062K-NC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:50:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaab-0000G0-1f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:50:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso12019985e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734691835; x=1735296635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4A6CNkM0JZP75dVobsqU+WcjQDgjCU182F092ynRV1g=;
 b=kA3LHFNVbRQIVV/huCaA64D/9O5DRYR7Z/ShsghQpRB+SorYukwtnrgfGI9xcp6N3j
 fGU2G8Opt71UCpQqAyIpfeHPSeYnc6hmwncyCtFWE7sn6ruGEOSgNxGrwql+4ZVS3En7
 r0GkP/nai19yYL60beIGNhYnmsg5okcZD8amD3BFPlU1GuG29kI34+rqDrETR/Pyu0OX
 151Nd0FCPucNEuJYlopqFCZ7fkU5nnHPbfuFqiX+sFC8ZsrizKPowep7d/Xiu206UewB
 ljGssJt9DIynNQF1o2LsxouZj6K1BRIaLamtoOTTHRjYzeQ7rVItRuWhwdIpqViqztVC
 hqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691835; x=1735296635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4A6CNkM0JZP75dVobsqU+WcjQDgjCU182F092ynRV1g=;
 b=DR25kfCdIAKG4Tk6u10TnF2N6bm1R7ZOLNTHbyBQ3rXcg73Lcgdfmg+mchDHz+BKWd
 N1kPj4VIr+34qoWjKR5XWeGIPPXkAC3iTjcWD9sSuO+kMCVGjouzoxEsoXa4uxbkdTOt
 hNTavNhvYDu0FufTSNTZcohmdvakhCF8bXywh3btZcCb3PHJ6f4Bgw/qT0+Onsa1QzwJ
 3/eIbEo+g2xqjzqvtLUyHqyUt7C6NJs/WR1J0lZG3xnYDh+iSFQ6r6RRaYaTGlbM+P6l
 2phSa3duiVIU7GKddFPo9WdvoO1nfJJlKdZc4D4qF07+1RIMc2fO4BAgE5iali5e3ATi
 7FGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4HwuyUkqwp7gcFE3gYA9GuYA0zzBaQZdUM6LeYo9YDp7Esf4PqQ09pbDzSVQz2MMmMP81GnpOsGNT@nongnu.org
X-Gm-Message-State: AOJu0YxueXNkfOr9mwgpJJvWotv1XHlHVgqlU7MS4bb7gm0lFSiKmxCs
 +mKFzLgjqHBvkEpjX8MHagcPt3I041ssRdN+8I14SV4GD8VHuxl1L9FkXo3KfNc=
X-Gm-Gg: ASbGncuuUGZfZVG6JNTw6G+eDgW7GzvY5Fiv2983R85wxKO7f8uCOgx8JHRnWeB3tto
 uVK0oefY22zX6M4Rk2f9jfa+MeYIK4p27aLCcVYAHeahQ8jxhLaFrTjmrKbov+N0awJVsW03BBp
 rLBLjPicgKsaNzVlkTLFGAuWAReKR889mC1avItPbmnb2HS5Ux+R4DHNn4DmuEEoESLz7wwPaDC
 b5YsXzh49eaDF5WKqMTal0Qq8FMmZQqrCMykWlk3I2pNDs49yAOl1Eu3INdF1CcIbqpDIg=
X-Google-Smtp-Source: AGHT+IGeyQcHac3HyW/mnpSv5DhHfvayzrpYJgn2HwexDMCrc+Zrgl74lAodnIuqXNVGyhJwWzGfZA==
X-Received: by 2002:a05:600c:3505:b0:434:fafe:edb with SMTP id
 5b1f17b1804b1-43668b5f326mr17131445e9.24.1734691834883; 
 Fri, 20 Dec 2024 02:50:34 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c829348sm3754834f8f.22.2024.12.20.02.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:50:34 -0800 (PST)
Message-ID: <b853ab30-fc7a-4e03-82da-0ed97fd4aa0b@linaro.org>
Date: Fri, 20 Dec 2024 11:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test assets not available anymore for
 tests/functional/test_rx_gdbsim.py
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <5f571195-39b9-45e5-ba03-fd835afb5012@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5f571195-39b9-45e5-ba03-fd835afb5012@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 19/12/24 20:47, Pierrick Bouvier wrote:
> Hi all,
> 
> assets for tests/functional/test_rx_gdbsim.py are not available anymore.
> 
> It seems that the directory "https://acc.dl.osdn.jp/users" vanished from 
> the web, and it's not a temporary issue.
> If someone still has those assets on their local cache, maybe it's a 
> good time to upload them somewhere else, and update the test.

I posted a patch for that 4 years ago but it got lost:
https://lore.kernel.org/qemu-devel/20200630202631.7345-1-f4bug@amsat.org/

I'll respin, thanks for noticing.


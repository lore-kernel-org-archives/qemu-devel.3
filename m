Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD2AFF8877
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHmh1-0001dY-Rx; Tue, 28 Apr 2026 13:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHmgx-0001dB-DV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:57:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHmgv-0005Sg-MZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:57:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44261378651so59556f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777399067; x=1778003867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5dLgzUq25eFXbjvfMZAItHmjh4pTq4+QRuSVfgK4SU=;
 b=WS0m8PCSQwSjKwA2VdvMmzRVyrDF7P+B2H0soD+6DqAm7rDXbx3KIO79ykwXT2ZOIj
 JEVpMmSGzYLKadXEk8ucEAis41+ZUHAfF810/gAkrSd77PNrYBYqd1DLD2qCfgb7yiJ6
 QA2d0Ow/coVky0vzuC29sWBUxL7bNwYD6x2Wiv9gG8+b9P4vudjEjOI9HcCt27QMARmj
 YKVgsX/300qDM7EgsU0gTlPDiYhZaP6Wlp6ERqSByAUQ7wVD9nKFahZe7dWcA3vGbKzd
 Mq6tRHyF/RnTjyTRZUgQogmga4yenuIBqu0gHGFb5CTdgHaCJG8snY3/LtloPSR/4wFY
 9aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399067; x=1778003867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e5dLgzUq25eFXbjvfMZAItHmjh4pTq4+QRuSVfgK4SU=;
 b=Xovf0i397mzyGzrX7/eEOZKRpzP4a7VHHhG25NIkaOD519zb+BskPbQk4mEhMbzXg2
 112p6B/dxJBqtqyVEgX3uwzYBIIvdjtxwYYQohENBN6norC42WV4cXsCxvr3cz2FVUua
 gmXdwVDoz3BsPHkD+qgGwPaf5lSZbPAr8QNbilqGaTvNA/Rxm76ittCKO1s2L0j7eUFw
 NofWFDp7dMzMR/IprieKAS2ZVtNTCIlAcBahCYd4qGf8vdPzJNqrU+Zl+jPRQhWQ+e0J
 3mi/7AwQWNwNwsfVIcwkCY8PXiqXXF8glv+Gak1qaz6ZNC1byuw44y8vHm2ryAy1GTxt
 VGKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+Io/DYmr7H9waNRDnK5H1EpScifLremC23Tu5mV1NDVtXuC/gS24Z14spPQ+APP97dsArnYIS3EsE@nongnu.org
X-Gm-Message-State: AOJu0Yxkq03Q86zJh5NJcLOKuLu/yhdiyn/yHgIVWZjg/wJcg24qMg/J
 uReSzfIct9fyFX3qSpYsioFq5Q5+0TOmfV01rWR3kQKh7JLUwPoxITfiEf1hfPgpIqQ=
X-Gm-Gg: AeBDieuz9O0IlXhzxGeppW9bxTJpzye6GOTYyPhOAEh2ov7d9Q5uIvs0maD/jMBiqb7
 x14GMLSPsf5ZDUXNvYp66EvkZE4zQctFJcLUS808tjUceNRjt5yFBCZxvh3MkX2rvG3OdKSZqTg
 nNTt9ontPGHUqQ9oOlcmoR9yQwcCDx6hhkaBWz5pdlJ4gZmB54rni6NefcVX1TXtVhhpQyqedbV
 7XZYfAx7ipBbmwM2atKwv4mL0jVvNCkjw9jiXasmRNFpS23I3285PymIKy7W3C6RnLClmIULewC
 g28JbAAj8ZOMecgmLUpFa6OhQQ0quQxN+BuGUzDZwr+9LUacTm/GYDGdV0UQ/u6/8BWGCObiN1h
 j4UKwLtNrsSkPWJsm92p+5Ln4gUpgNwXMu7Zla5z+c5IIlBwJfekusmE0k8/w9Xp1+ed5vDl2IS
 WCnMSqOIywD1PnMDiASSNP0M26eLJ1+FrkEu1aY8iVNydU3VJT8L7ZG8/cTPO20YvP2m4/grF0c
 A2Y
X-Received: by 2002:a05:600c:c08f:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-48a7beee40bmr244545e9.3.1777399067159; 
 Tue, 28 Apr 2026 10:57:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bea9824sm819825e9.13.2026.04.28.10.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 10:57:46 -0700 (PDT)
Message-ID: <24efbecd-446f-453f-abc2-2955a65d5e87@linaro.org>
Date: Tue, 28 Apr 2026 19:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] MAINTAINERS: Add myself as OpenRISC board maintainer
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260428172055.1525176-1-shorne@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428172055.1525176-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 28/4/26 19:20, Stafford Horne wrote:
> In the recent changes from Peter I realized the OpenRISC board maintainers were
> not properly documented.  Add myself and ensure virt is properly listed.

Thanks Stafford!

Series:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Stafford Horne (2):
>    MAINTAINERS: Add myself as maintainer for or1k-sim
>    MAINTAINERS: Add myself as the OpenRISC virt maintainer
> 
>   MAINTAINERS | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)



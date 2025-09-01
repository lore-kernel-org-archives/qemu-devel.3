Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7393CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7zt-00030K-8i; Mon, 01 Sep 2025 13:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut7zq-0002zu-TC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:07:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut7zp-0007MX-64
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:07:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3cef6debedcso1966141f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756746427; x=1757351227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AF7qG1gIeBf0mZ7HV9w8YrKoUQjnmOBHmT26Rgkjo5k=;
 b=Pwcp2i5CrM7J/trrxNeUlFGCAPp2Qy8x+tcTfHqFmDKzrMVYSS/QCwSdLCQJgpR98M
 qe3fZm3H4rW+sk3mtw6G9IRvxQOWzQOHbh10sj9Vp7DrtVxqYsg9gf7wuzbcSEYI4Rd5
 S64FuMhcPG20foVqJT6Krnv8LqRrmYvPvOTPJXEaj3LhaJdVKEl07DLP+9Erm0KhlAeG
 yh6/ilPYFgO0rpsd/GT5/7JP+ecAXNfA3ChQE9ld4LaRzJQ6SH3J0icBmERl+O9zE6Td
 lXJiuUiloRUS8bHNixXfROddY+d4bLtsvkYlWtPe6q+nZ7IbU8VpwK6r/JteyjZMsF8i
 UIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746427; x=1757351227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AF7qG1gIeBf0mZ7HV9w8YrKoUQjnmOBHmT26Rgkjo5k=;
 b=AAckNIc+crBl9mfrpJds+7ZkdImsJdONYAWpJZ0GUD6kZfdLEu6GxiKkPYzGiLfFQ0
 7ua38o9Qy5Dkisx6EgpEDNqkqeurm8QIxZTfeFYJs1WSf6yNn68L6BT9r1jomwC0cnyG
 vYXTBDYfeSoWCW5AKXRtDxt8isKNTAmFdJ4ubDAwRvCy7BHzYgBuyKyAX+t8RYP4gClH
 kShOaWBt+6DBkCPukJPQENyIQhF6b2ZGkte483ljM+/sxfmGo2CrH7HzCO9cwF4ncSZt
 6Hs0Dxef615uc0pFM/Aha42ez3HvYGsoByg94edyHnF7mOoUIK8JtS+Tl67S0DzC9Lqx
 YPXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Pa6wr40KicPHkZw011X0gH2v4XCpT67K+fbLgdx45IWc/V5/ItD1AaIcYCIm6dQDVj3oIrAXjVis@nongnu.org
X-Gm-Message-State: AOJu0YwWHzApBbD3/ycF09mLwDQYknFdjOXvZs/GHCl/nI/07BjL6mI1
 +pEVyZkPcS0gGYd4di/8OOE4o25cHt4gnd2l+jWtsvHNIRS6XPwi6VCIlNUY/8GXNMZ/HtoDZtA
 2Jc4x
X-Gm-Gg: ASbGncu2Wj0fsyAkSxF0arM+9LEYkU8aJFCxYDSkZWkzZCf5VobawfE0uYAgKaXuuIO
 0C+M5nMXHHl3mcWlTSuIT9yAxXpbXB78oOmurArChqqbHngjkoDv/EzF5oxFlp6l6wzZxPqg1yf
 CplN7N/tc8BBkbySO9BcsUhzcliZTXCpOl9I6JnfrA4MPMYEULRR0nBHcJAySr7Lh1aL1/gwHFT
 EDLqUffnx7cpiKqEDguB30SxaXICktf3MrN9Z2FWNvLm1s3u/+9ftO3A1PVUijKozO/Yq+AH4SS
 ZwaAWM/gjhpIXV9Yd019eAJb2PaT88DOJEiJ9lmT4dVMviprjAClGawZpu2zeLTe5w5K40391Bw
 nbWJQf1JU14QwigTz/zgNqgEuRWX2kZUzO55nKwxcZRxOcjhMXP+KRGLMiN7DRBIBANUXEfJuAM
 HU
X-Google-Smtp-Source: AGHT+IGfmFJRALRCwBCR7ROquLiFV7VMVDw5u4R8W5XW3JNFZXjFQGE2Cu1nUGdBSekQUeR8J3+aug==
X-Received: by 2002:a05:6000:24c4:b0:3d6:212b:9b01 with SMTP id
 ffacd0b85a97d-3d6212b9dfdmr4403277f8f.60.1756746427259; 
 Mon, 01 Sep 2025 10:07:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add504sm15881810f8f.30.2025.09.01.10.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 10:07:06 -0700 (PDT)
Message-ID: <10ff1180-1667-4918-9fec-4227bfbe947d@linaro.org>
Date: Mon, 1 Sep 2025 19:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/network: Remove hardcoded 0x40 prefix
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 qemu-devel@nongnu.org
References: <20250506164602.3897164-1-stgraber@stgraber.org>
 <aBsduLe2QDbr4Ol1@redhat.com>
 <CAFEAcA-3kqoLWA3WRuL+Lwk_ozo2cYOh_A3_AsPB=Crxu1Zhgg@mail.gmail.com>
 <CAFEAcA9twir+TeeiYVmdMVy0s0FcMuSDAmAun7uj3Bw8+Br9PA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9twir+TeeiYVmdMVy0s0FcMuSDAmAun7uj3Bw8+Br9PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 1/9/25 18:11, Peter Maydell wrote:
> On Mon, 12 May 2025 at 15:10, Peter Maydell <peter.maydell@linaro.org> wrote:


> I just noticed that we never picked up this patch. I've taken
> it into target-arm.next (and added some text to the commit message
> to reflect the comments in this thread).

Oops, I had this one tagged, but totally forgot about it... Thanks!


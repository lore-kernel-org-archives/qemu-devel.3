Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01168D33981
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYOd-0001UF-VA; Fri, 05 Dec 2025 11:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRYOa-0001Tl-CY
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:11:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRYOY-00063M-IQ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:10:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so14788325e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951056; x=1765555856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8iYWBpmG/1Qx33bkhw5SfusWJ16+6KqQZp3nHbtzhDk=;
 b=PTTKe8SO7qltMp7RO5a9z6Ld4RKq5bfdLd2kfqOVmtAVOmnbnXdNpqbzyU4iaBEC+K
 2ssb8DyzSMn7vq1PzMivXccbjsJ4zfcXIWizb0Vts312iaM5b/O0qyn7EQS3rgJy9YOl
 l+U1lK65H2REa0bi0W1abNPloC2S7vdY6QHluCxdUkOEQjmUhQW22AIq8puxaV+P59L1
 iPAGx5WOW/FoZrA7ppTGJcajhqzMhZL2+5NFIGfEiIRJkVjAGcrP/oVHWli64c3TkJku
 iMa3tG4nUJxaB3ZdXGBF36V/41A+pCuPi0PjinyiW5r2JvVrZjfa9HDiq7MrCyUw5mi1
 zDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951056; x=1765555856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8iYWBpmG/1Qx33bkhw5SfusWJ16+6KqQZp3nHbtzhDk=;
 b=AMbzXjEGpeVNtMA+b+5qfzULdKVe5Lxssqdj78Rf/Khc8K+oYu6+KYRvp3vI3eCgZn
 3Sw/V7h9bv5XSdi3fwzWNzIWxg+mNMIPIqaxW4uHO1gAl9rrkHBp4dC4QEMStWW5EEZG
 RgygZ86QYrQowsa0L5Efdan3S2xAXQD8wZFNBIgyegBm3rL/6hELw5AWiChcBScKdx6x
 qdm8Vo7LN7QuFBXUakoRTqw8Oehn0zN1RMRDCMgawH6aj5H4utawcSUHW8LK1cxAbpzi
 8zs6nx1hDODjEbVSPR1tniF2ieckM/PjJBOytOZPcBsBxJa4SDWvfY5q+5WUzVUT5EbF
 mSmg==
X-Gm-Message-State: AOJu0Yy8iPNRucmXzTBZRb2aYdcTZBczZ3KBcX8ugVf37XFplpAmEjrs
 2WBWiv0KuH32qCLGKf+uSRuSlnLPSFWKpyCzqS0hciqyixUQuAA7uLOsQ/heAHV06lk=
X-Gm-Gg: ASbGncv/wGnondOG/x/1JdanKGG/mL8g3ISmzbTLNrRkD2zQFFeHfZoHSTroowUDeIu
 vK48FroMfGk2tZgQ9gndqEhyFp4Hp+Dsu5YiZ2z2GmBqw3iwYsgMQqnsLizmGAwjaRUM536N42j
 B2YE4BBpYbNxkX7I5G7sroVnAuHfqREtckCK/br6/E5wk/lxG2G5ugmtj2xYIssCigSFBxdbmf5
 6tX6hvgECsLJPVh/BBngBXAFJCx/272bZNzAFI8qDs6+tiosVOcKeJaojeZ8Rf48fknK3Bk0ewv
 nkp0EdM6RjWNu5Ctn3lodbDxGpYqg+IvLcz+e67UUozXpI0oIfn1Zs1fPJJnoG/2Y6uMGfZhs/n
 XMfjU5M8v/4xuIHHA5Sl6Oy7yO44OQLIEMXCPmGNASAB7THKiNa1KrqKSJsfqnTmo2ownA38OBn
 jObvKJHCJoQ48vjLwzgirNdY1af3fOmLW4ijHrmhG+NPfq3l5LP+Qr
X-Google-Smtp-Source: AGHT+IGCnX5pWUq+ZTamslR6BmXiAWJ4zOMhk58mrOjit2ejkxj+c8KCXFsfQS3FE3AfJzlvIJrUsw==
X-Received: by 2002:a05:600c:5254:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-4792aee37famr95102035e9.9.1764951055752; 
 Fri, 05 Dec 2025 08:10:55 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:901:1329:d82a:8818?
 ([2a10:d582:31e:0:901:1329:d82a:8818])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311e7142sm91797405e9.11.2025.12.05.08.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 08:10:55 -0800 (PST)
Message-ID: <364a1c91-c7a0-41b1-8ae9-902b3158914c@linaro.org>
Date: Fri, 5 Dec 2025 16:10:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
 <87qztarkyf.fsf@draig.linaro.org>
 <a605c0b2-8122-424c-a917-7d6ad8371c34@linaro.org>
Content-Language: en-US
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <a605c0b2-8122-424c-a917-7d6ad8371c34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x334.google.com
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


On 12/5/25 15:57, Philippe Mathieu-Daudé wrote:
> On 4/12/25 22:33, Alex Bennée wrote:
>> Jim MacArthur <jim.macarthur@linaro.org> writes:
>>
>>> If both frame and element count are 65535, which appears valid from my
>>> reading of the OMAP5912 documentation, then some of the calculations
>>> will overflow the 32-bit signed integer range and produce a negative
>>> min_elems value.
>>>
>>> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
>>>
>>
>> nit:
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3204
>
> Format is:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3204
> Fixes: afbb5194d43 ("Handle on-chip DMA controllers in one place")
>
I'm unclear on whether this actually resolves or fixes the issue, so I 
just said 'Raised by'. The bug only includes a test case, not a text 
description of the problem. The test case will give a different error if 
this patch is applied, but still doesn't pass. I've mentioned this on 
the bug page.

Jim



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB60C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvrF-00034E-TN; Fri, 31 Jan 2025 13:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvrD-000322-Ji
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:35:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdvrB-0006gZ-S8
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:35:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so17378955e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738348508; x=1738953308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9UCZy8TyUsrwOWNX3ilWmw5qoD14pkKlKd6Nvuynf0=;
 b=S9RtXBL82uJUcRjI0gktTrQThJSTm1OX/UESlwfQYZbkZj5LBmgDJnG3TyFAdeIcOV
 0P0gxjT3qNa2Bxvk6UHjQ5cVjGoHE2xjUcV5tk+jTESzsvjTfem8njvokse51c5hVBl1
 BDWCSv0YOKQm9VXoQaNKB90xw0tS7lc87feYnzFsqCdMRx/N51BE2xpnDQU91LTx8waz
 jVY3hnO1kHQktOC27Sf5LfB5iMttFphnxI2OY9ZL1yWomrkY8KnFqGE1a8PaIFAc6o9F
 HUaNB39yda8XlStywSP0f1fVKOAX9ipP5zByt1Drupa5k250Wa9tptEWN220vqPOZ19x
 IIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348508; x=1738953308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i9UCZy8TyUsrwOWNX3ilWmw5qoD14pkKlKd6Nvuynf0=;
 b=n69gAXhcYy9ZYCxk5WWr3WoHfBjVGmiEbY4+dbw22bsYM9ZtV17KGUErnFLJAbaMJv
 A6LF5lavRODtukYPGV6nq0tuXMlXlhL9DQ1YbxwYPurUhA54lVXSZWueXPbt20YetFYc
 IWPam90O9xkYTh1PwReC3uM+AjzmfeIbHeUX89l0Gb5F527pSyHpRou/p9W795m4Etpq
 0PKgByrSw/qffh3wqj1x2NDQhUrQ0K3uHr6W0vJ/PnxhJDQl6pvvsSUIRWhvgxGBIseM
 ARAS8Ms6bLRkytb1kN9LA/x8oWvIsB1xZhnv2+AnTNXvlKfjspGCyCK75unDKfCOW8iw
 7nng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiq7E9lqXAqE2uYu2/zsJjmdGiQZYD6I+yKHtnb1yNKfm4FwKSD58I6b+/TOLISqbeh23iI4rxIvM1@nongnu.org
X-Gm-Message-State: AOJu0YyD4Q1TavPIekLKXqFSnMnboWPm4GUw0O77a8jLt6O3dNe4mHsF
 jwDkASgOiH0+snBth+/d9XsL2Js9QzHDjUSMxK+wGOYhAj80qhJaLO/sGydL38M=
X-Gm-Gg: ASbGncv93CEI85ukgjtm+ItVHECVFgS8z9IRfjUvvCtdfm60Spna1iGmuiOenujxHK7
 4UpJJd0fRJm47DV8kRLRkCtwfvPuFenHhyvcCQ02WHcxpPNZz8zjNpmvAdMXeUbJKtMrqG10Maz
 9uTMngtV500IXTkT4vD6ef5Q5OHJ08JZFdycG6BG3uKRC7dg+rFPmva0YOfB+xRvktKPShSmTzg
 uSlYh2YqYU0WgzQgkV0Hp+6a7vK4RBapkf5mTUTTPt7h4eI4wjd/0XxVHgy1ZpSFocUkEdCm/Fs
 kU/6dOi7CTOGH6E8bj4cXTCXMQrIuZlgrYagdiRYfiH1f5wJ4y3vWXsGJ0M=
X-Google-Smtp-Source: AGHT+IHw02jbYogO0+BsBx9fiWIitRGBud8wwnEBMHjQjg95m9If90oI2I/BG4HfNPmqbYxB1J0sAw==
X-Received: by 2002:a05:600c:b89:b0:438:a240:c54 with SMTP id
 5b1f17b1804b1-438dc3ae14bmr102274205e9.9.1738348506873; 
 Fri, 31 Jan 2025 10:35:06 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e384sm101291905e9.19.2025.01.31.10.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 10:35:06 -0800 (PST)
Message-ID: <562d0891-ef50-46e3-86fe-2d8a0509a7ab@linaro.org>
Date: Fri, 31 Jan 2025 19:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as HPPA maintainer
To: Helge Deller <deller@gmx.de>, deller@kernel.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
References: <20250128170914.13353-2-deller@kernel.org>
 <7484e0d5-66f7-4fb3-9262-7d698b2b1da7@linaro.org>
 <99c444aa-7acb-471b-81c1-653a924b315e@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <99c444aa-7acb-471b-81c1-653a924b315e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 31/1/25 19:30, Helge Deller wrote:
> On 1/31/25 19:15, Philippe Mathieu-Daudé wrote:
>> On 28/1/25 18:09, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Since I contribute quite some code to hppa, I'd like to step up and
>>> become the secondary maintainer for HPPA beside Richard.
>>> Additionally change status of hppa machines to maintained as I will
>>> take care of them.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>   MAINTAINERS | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> Patch queued, thanks!
> 
> Thank you, Philippe!
> But actually, I included it already in the series where I sent a pull 
> request.
> See mail thread: "[PULL v2 0/9] Hppa system mfdiag for v10 patches"

Oops OK :/


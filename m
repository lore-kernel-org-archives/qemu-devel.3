Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FD6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taU1I-0007R9-WD; Wed, 22 Jan 2025 01:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taU1G-0007Qj-QF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:15:18 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taU1E-0001PQ-Hf
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:15:18 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso9109923a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737526514; x=1738131314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iNWnK+aCA5MKNI6xkie02sWlLfCwsHox5kgxxdTz9v4=;
 b=YveDuOnl8BFY1c9WG9e+JMJq+Q3pBtIFFHJ1kEjTNXa+VKcE+PatqbdhV/PQkVnR6P
 UX+XwJqOO2oHfnhKIO50ZBJDrH91UmlTUJqdL/lZctHpm5am5dAD+fFxFCX0L1A1IuR+
 CYyh9c7NRw5e6rn/F02BOqF2KhzDolRiR8CGAXULGg9k+Vsbn3O7KumwW+Z4Ml00ZVoa
 UwjGQUqKaDRSphdi0VfrJxkevYIrYRL8kd/6EkV383npPA+OpiMzj3O7CD6q63GZrjWL
 EvWgv4e6330DUoseilDS3rNJbvLidRc1uzWGhEo/OuXB41fAzk/9ZRlNu9iiE03bCuM+
 onTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737526514; x=1738131314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNWnK+aCA5MKNI6xkie02sWlLfCwsHox5kgxxdTz9v4=;
 b=DcekNTS3AbGwkpHSYqAgF8YXUe/+2A/sjm53eZzw5mx9nk4Sfh9dqRCXwriykDpcPx
 BdkcAVXQxDfRZJ6jgQYDvZvo6+guJAuTwZSso0nsp00ob0KaKwO9kV3MNicgZDWesWvN
 9wBRlbqeJpoc5wDoVevnDjlKAnjU7NMoOsc2XY7b98gbZkE6INjSvy9P9TkHPLWqy3dU
 IsK35MGrqWRhi4kUZQshLqxLDpfC5fDBKSARaCR+7dXrFGu9hPgo42gOMdlINat6gM9C
 aqLV3sUeRllrBsQ4nSs07kcfGbGbRHkpBk+N+aWh/Ix3k5RicVNXuagHKbw7vYapWwoi
 ILqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa3vuTfSA6ejp4XCB5P92Yw2m/V9UxaBnb2gh09SM/qNLdZE1ZDsGhLxkR/ZEcX+yX9GIpCzs4MrJi@nongnu.org
X-Gm-Message-State: AOJu0YxQ6eux5VtlHiegnUN65ruASvxgmc6HcD7NalX9QikuChC9cvcP
 Dg7QE/kaoiGNm26ahPbQyL174dxevauOfNdG+iBMFhhm6fydjnYCERbtRPSHYqk=
X-Gm-Gg: ASbGncuHiQJHttrZPScOKJPu0nR+/gvlAtKlUeQTpI4STB6qjTKJ5oMKuhxyL5xbSIa
 Di+6CrTLwEpH7ELTeBUKKgSg2Ovjds1+7eLj6QPobiqjy9xFYtp+OmdLiitaouOsEfvTySEZvzW
 Qhdhs/DUAhiJO1hKE9woeDaYBeU6DGHj3CWL2/dGejUOcm1KWR2RbHWiDsU+lcPwYtnFR1v87Wb
 UYOzYkjditmJuOx0IuE8lRJ15lWhCWv6piXHzuT7Fzc0ReEd+TJ39DOiVdsnjBPDjI802suCQdv
 Qup7d80=
X-Google-Smtp-Source: AGHT+IH7fTeb5bH6WRRGgC8XB7kiMZ4QjQFBs41Ti9qY4zpaH0nRFq5YqaJzGwXO2IaBjuMzP9P5aQ==
X-Received: by 2002:a05:6a00:428d:b0:71e:4786:98ee with SMTP id
 d2e1a72fcca58-72dafae88b0mr27635424b3a.21.1737526514558; 
 Tue, 21 Jan 2025 22:15:14 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab845d25sm10076645b3a.77.2025.01.21.22.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 22:15:14 -0800 (PST)
Message-ID: <3b31922a-f25d-4d40-be33-1562755f8ea1@linaro.org>
Date: Tue, 21 Jan 2025 22:15:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vvfat: fix out of bounds array write
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20250105135929.6286-1-vr_qemu@t-online.de>
 <f616a4b4-2161-42c8-9f92-e3a939ba173a@tls.msk.ru>
 <54df1904-0e2c-4c4f-b242-1c8865ad0af1@linaro.org>
 <1e2389b1-07c5-49dd-96c6-8bac84d7c95e@tls.msk.ru>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1e2389b1-07c5-49dd-96c6-8bac84d7c95e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/21/25 19:47, Michael Tokarev wrote:
> 22.01.2025 02:14, Pierrick Bouvier wrote:
> ..
>> I agree the existing code (and this patch) is pretty cryptic for anyone not familiar with FAT format.
>> However, I think it could be a good thing to first merge this one (which is correct, and works), and refactor this in a second time, so the current
>> ubsan issue is fixed upstream as soon as possible.
> 
> For an actual *fix*, please take a look at
> https://lore.kernel.org/qemu-devel/20250119093233.9E4C450B6D@localhost.tls.msk.ru/
> 
> which is minimal, understandable, verified and works.
> 
> /mjt

Thanks, I was not sure what to choose between the different patches 
posted around this, to fix the problem on my personal tree.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064E4C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUjo-00088f-Q7; Mon, 10 Feb 2025 09:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUjd-00087J-IF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:26:05 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thUjb-0007H6-Nd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:26:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4368a293339so49614305e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739197562; x=1739802362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LS/9ozniDfX4A94JXkbw+nFKRoQQNx80cjyrk3WGbzo=;
 b=NSOFls6eFhHpSwt9LTUMnQJbSxtyWaKJoaNYp7WqAkHiYhBOPeMYnrgaUXXa3yDu/h
 XZbk9vpWBNMHIGRoaT8vZxj5PCcJf5o91u6UIWQ6LITKVYCgL1sxcwsZsjhUM34dEZJn
 wHu3ZWUmkQbWCW0AupXheIlEwYwlJuR/UpIjYdNxsCakOvDiZBqoVb7c/wQhXhNgOUyU
 N1nFG6PCabyrhVugru2s4vBO9ZjiUKxvMe6QJWnmdIrpINZ9w9LfJBLIt42zQ2jHTJjV
 I1Uxu8xJ4hJIEAgSc6hobtmt9V0MuMm1KW+Eqh1iLVb8IXluJ7WzBpTxl0+BQI6JpeLV
 mtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197562; x=1739802362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LS/9ozniDfX4A94JXkbw+nFKRoQQNx80cjyrk3WGbzo=;
 b=BZ+K15F3AKQptBVGQ8dwgIDulNrtMP21MRDgQzHwlrPsS1+7Z45Bl4M5SI4aLdYSih
 rICjbVjeivfGD+2Pyfp1OKykyDci5vSDOHAHa5tdlI5CszSHdRUIXqF7pMBbpiNvAf2r
 wRveLznlCoMJAgJxBxokRLJvShiPF47vwngI6HTopVbg3LeGqNHdnkozEDLG6SHrFWHG
 uY1zmrBwJMvycFjUuI/YHFWvm277szBcRtY55/hLk1xh1cH3utsQqi8NKou1F3G7VgDx
 8GHAN+VccCXz3SiMpGXcW6nGg9y0PyWdNpA0aM54KnLW9xf7JFphZ1ALLsDyZyEDMMsy
 81qg==
X-Gm-Message-State: AOJu0YzFmCl+iethkFj/XB6/1fDpXAhC+GChJLjmUW0sAhX9scYTS26Z
 hEUYxLB7zzUiWElcqXT9PwqroqoFg/z3CI/VPpPqT5C+OQQTVXefBI9QoLWVaeI=
X-Gm-Gg: ASbGncuThSSWx8/isNo9UMQ73ca4OuATDSVYQK/a30gtQmJueDB6GZQWJ3QuUGU9vsY
 hZ6q3Un3AxLdSPzQbJeH2b4eL0KOMyAHCauL4hbHlZYGNgE1YDUaFgm/YZyhYGcW+nys7rL4+1+
 k4cunl+qZE2iIQZKDWTldy4X3GIM768Q5BaX91U4XJtW/Lh2fR0Y4Rsrf8mU4nIQFz/MIw7Ssz4
 4ggnEjcAstmcsJObabHFcVRcWMbyTLlLfoX4S+x+jBja2jc0+W5racP+7r39PzbVw8UOUNz3g7X
 ZBO0cExvEg93NsYxaIVyKHP/B1GmBN461p9lETArZrY+1wPmzGkioWhhixQ=
X-Google-Smtp-Source: AGHT+IGCszs5Tkp4zy2NQlUWfIB2D3hFrZ61JSro6JWm+BMyfrH63QtY5GIubJxzAr7OTX4kfIaw3Q==
X-Received: by 2002:a05:600c:3d89:b0:439:4bcb:9627 with SMTP id
 5b1f17b1804b1-4394bcb9824mr6807865e9.19.1739197561859; 
 Mon, 10 Feb 2025 06:26:01 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ffd8sm145817385e9.10.2025.02.10.06.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:26:01 -0800 (PST)
Message-ID: <a8855d03-d207-4a0d-a16f-24e4436a3b66@linaro.org>
Date: Mon, 10 Feb 2025 15:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
To: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-19-shentey@gmail.com>
 <CAFEAcA_gxGWivT7byZh9gYc2QHfsTqbJ8vtxPDToOxLMdMvwQg@mail.gmail.com>
 <F8650CD9-AA03-4462-A74E-7A068820F1A2@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <F8650CD9-AA03-4462-A74E-7A068820F1A2@gmail.com>
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

On 6/2/25 22:58, Bernhard Beschow wrote:
> 
> 
> Am 6. Februar 2025 17:32:31 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
>> On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>>>
>>> The implementation just allows Linux to determine date and time.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>>   MAINTAINERS         |   1 +
>>>   hw/rtc/rs5c372.c    | 227 ++++++++++++++++++++++++++++++++++++++++++++
>>>   hw/rtc/Kconfig      |   5 +
>>>   hw/rtc/meson.build  |   1 +
>>>   hw/rtc/trace-events |   4 +
>>>   5 files changed, 238 insertions(+)
>>>   create mode 100644 hw/rtc/rs5c372.c
>>
>> Should there be a patch after this one that adds this device
>> to your board ?
> 
> As per Kconfig the board selects I2C_DEVICES and this device is "default y if I2C_DEVICES". I've deliberately not hardcoded this device to the board to make it emulate a plain i.MX 8M Plus SoC (see also board documentation).

Then maybe add a test to be sure it is not bitroting?


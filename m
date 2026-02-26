Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D6FD9E14
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjkc-0004Yz-Uq; Thu, 26 Feb 2026 17:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjkb-0004XQ-9k
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:29 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvjkZ-00067m-Pk
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:22:29 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-824adc96ad2so1484050b3a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772144546; x=1772749346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=urgp5LCrmaMBbbMcngKmljDrYt/xoL7XvSBYJ2lOuhg=;
 b=vpF/RQIu9q7bvVc69KBH3T/cgsEmO67LxBMw1W2L0225pqUOG65gpEuZWSfSGHIU+/
 0TvmT1w44XAKwdNMC89PIuI+CNColRt2tGRjQ370dfAaaj4NDPeAh9dOsv6XKdJDA5iI
 Hofi03jWHuUERJC3KEysB5EAYQAISv1RxXBtZUxoCUSoqabN506xWfd/CythjJZ9MbBI
 WEMd77TWpsNPghrMoRPb1uygcy5FJSR6vBUY0FJksGdCPZ+ciI8d3TGoxVOvl+w99Vm6
 qzF3VtwgrEG07BrAcahEKBEZOiykzxwMB/e4cbwQCte+ygfu1Zj2pFxVukJ5KmMDaB9G
 1BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772144546; x=1772749346;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=urgp5LCrmaMBbbMcngKmljDrYt/xoL7XvSBYJ2lOuhg=;
 b=UFj7Opay8MvANHQwEPYu0JULgay3iSWtvBbK1+Qny4XK4QIeCbdLuZXDu/5Mv0EBEn
 uzP04ywJk0FgJgk/hWuXDEXnsJaDXoT/U78d8/aSOoWbPSeP8586PlUDaAxGwwe0X5in
 6Rx+kz3WJADM/BcCYemwxjMTl93IUlUKcfDsmmFuvOfOTKYAwvIOQmw155bPDZr/W8R8
 Ya3x/DfA7FJ3WBmhnYo8O+cUCUUC+EtL7isXy5JkL9AEf5zXWIR76cRqL+cqeGVoGVBc
 kIYRTTOks/a9qznn/AEVTPUy415wY/BBmVOyj2gKBV2Km9jRFB1kM4ZrHvLJE4d3M9GA
 xwOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAK3OYqTT7Nq4Bx3TmP1bHTPv5APaxAe8+CT45XyrkgkVnCMaOqY5dpDCCltvnPGTYCwT8MnYMS5P+@nongnu.org
X-Gm-Message-State: AOJu0Yya/GXQ/pc7gFICXF2p4bAafnXdjOC+TaOUp15fEw10QKP4zDoy
 bdLYYEfwNvQlZIG/hSmqGQBnTrRYJMkYPWlVbqOwRZpxQyTz+rmzA6tVMXRtODOdx+M=
X-Gm-Gg: ATEYQzzZtOXSbBfVf03vmb3jw0DcHjzAvxtA1BQNUBatxUl4R3V44qW9GKSm1fJx9z9
 De/D3bOR6JBr5WcqOs31G2z4F+LfxTU8IL6ASmjopWCcbek6zPGBb+BP7swJm/CNNC8b2IsF168
 0T3vnYrMSuMXg7B99NLCZ49nPhdBSDZRD03T2Za4MEE9WVKwux92houe3VYSfWsRy2OdKhmyUdW
 11K2shlEF154vJJ8N4HI70/gw5GEZEbh7V5bui9GBSUfjoUOC05hKv9Aqf/PYn/2jw6/m6a7RwN
 15umbxD2ObUe9LcH6OwsVuRHnSJssd3MoOhyG3qNCmw836zyjRhswH5cl2R8A+RsVgQ6rLZLQ8W
 k7ofkLotHUY8JBjRqRO3lxTN5t/vRB/loDMUh0X16lvQge52MXulVOawnhhWpFlJ6q1ouEKYSl2
 LVEweV+Kv2ndN6nx8ebyo9UmnZ4Exx8kvs2GBLQemXlpeuZagtgm4wY3XFa5q1EpUY7xnH
X-Received: by 2002:a05:6a00:4186:b0:827:4526:50d with SMTP id
 d2e1a72fcca58-8274d9d0e40mr511256b3a.29.1772144545900; 
 Thu, 26 Feb 2026 14:22:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4c910sm3228503b3a.8.2026.02.26.14.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:22:25 -0800 (PST)
Message-ID: <34514996-2fb8-4a4c-a39d-c5272b7108c8@linaro.org>
Date: Thu, 26 Feb 2026 14:22:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] system/memory: Have memory_region_type() correctly
 describe containers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260226220226.20164-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 2/26/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> MemoryRegion containers are not I/O regions,
> describe them as 'container'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


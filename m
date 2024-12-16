Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0D2E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBXs-0001Fo-7X; Mon, 16 Dec 2024 08:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBXi-0001ET-Bg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:53:50 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBXg-0005TV-Fg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:53:50 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e15d9629bso823520a34.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734357225; x=1734962025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLtCAf+eVXoNIIuW1G6Wd/uZqC+dL8Cvt6AJHo37q+k=;
 b=mO/2Oh6BQ2yu/NSnOKni0+CBMcMZUxzjFSYAkfK9bZxM6tAl0zxAfixQyjfb0CEHY/
 Z9ydO2YeCF/TZscLZ1cqtG5fcVzkGeSxAT8dEb7D4QtrB9UDQpN8grtAWBndKptV9//D
 3+/pF3LCLUFEaKyRlQXwvfErl5hU2Ln40R0j9milUxTw8EaaTUfqM5lejQ1H0vFrRUEA
 kmYSpRm/jsKUer0HOMOjr4YO6pQItuc1nLwUPT4qpeZtQgBfgDkSR7HCYG06v7YaQuR/
 yPwBWsZrxBnPRaDhCh/+2d1IhmaPXfBW0bPFx4KJ013MQBVf5Zs5sfE2tqi92NiZOYeG
 Czsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734357225; x=1734962025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLtCAf+eVXoNIIuW1G6Wd/uZqC+dL8Cvt6AJHo37q+k=;
 b=sVhXQL3NYXDhnddI4XauIINDji3s1Cg85/L2GxpBhPeYMkbQKrUUyxF5DWdUw0C4hy
 qFJ1IWY36kL/CqQGXn3sHNp9qFYbAEcmG6+f0L5e7wBTidr3ntAQEqKWcnDMa3qHwNp4
 U6Zyax1ujyf3l/ow9QT2Q/XCYjXMP5T8Gw3SV/Lx5bOP4dx8ScTXJKurW/4kE1ieTb7q
 TfCIrhtPdJWcFisT4XTDv78U1K9BbRVAvIe/8MvM4Sm8t7THczx7PY3Dd/qGZsx+tHDU
 tAldunpurpzqmvpgPfIkPeTayN1Ax+tFAxlEDiZuXWTQziaiOMf1AEfFUL7DdzLC61EZ
 e7SQ==
X-Gm-Message-State: AOJu0YxIIzkHLqrT7PNoe1yW5XBeLOL55OrJdYrXdPqauFLx6L1i8PvE
 wuP8AQNW5181jndx8PVsnbvDd5Z3rieLIxIzu+46L/GFMrm93bP3LZO0QwvrFBI=
X-Gm-Gg: ASbGncuZiNIlGxk4hw3VnPUYbyg5YRQP67MFxeHQ9CIPZ5jFEng7DDlfTczSouzaMra
 fSR/vbLKUZTVkEgv64Z0gPyotLIqU/PXAomBXFT2hioEuNGq9wCKusZHJB78/yHl0ixltc4A+6f
 4e57hwC5SFPbNBcTQFQvjCwhAMYHmNp7a9+WPX6esHTJ0E/8vBm4AAEV3IuI0qMqpUdBS2gNBqJ
 7N15b5ytmzwHaQV14NHRASy0cPNMLfqM9BeEQHbD9XfSfsTlrvLjmJ4zooMFl38y16fDMgKZ5O8
 j/RmRuVoTYahO3DHkpJr8vVXbQ+WlAJYf0E=
X-Google-Smtp-Source: AGHT+IH/Pzqv0pgnXsbVVjDm3Isce94PPqSUfUnscAPQUUDL5kBowVZVn4PrNxCLbEZCBqJdxWC6KA==
X-Received: by 2002:a05:6830:4113:b0:71d:4b52:4e46 with SMTP id
 46e09a7af769-71e3b8916aamr6660441a34.15.1734357224332; 
 Mon, 16 Dec 2024 05:53:44 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e48353346sm1371019a34.16.2024.12.16.05.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 05:53:43 -0800 (PST)
Message-ID: <f9d9fffb-acf2-4bbe-aa60-2eed0aa8ee21@linaro.org>
Date: Mon, 16 Dec 2024 07:53:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] hw/ppc: Only register spapr_nvdimm_properties if
 CONFIG_LIBPMEM
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
 <20241216035109.3486070-7-richard.henderson@linaro.org>
 <1738e531-0f61-9b0e-c4ab-9879812e8d3e@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1738e531-0f61-9b0e-c4ab-9879812e8d3e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 12/16/24 05:36, BALATON Zoltan wrote:
> On Sun, 15 Dec 2024, Richard Henderson wrote:
>> Do not register an empty set of properties.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> hw/ppc/spapr_nvdimm.c | 10 +++++-----
>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
>> index 2ef6f29f3d..6f875d73b2 100644
>> --- a/hw/ppc/spapr_nvdimm.c
>> +++ b/hw/ppc/spapr_nvdimm.c
>> @@ -884,22 +884,22 @@ static void spapr_nvdimm_unrealize(NVDIMMDevice *dimm)
>>     vmstate_unregister(NULL, &vmstate_spapr_nvdimm_states, dimm);
>> }
>>
>> -static const Property spapr_nvdimm_properties[] = {
>> #ifdef CONFIG_LIBPMEM
>> +static const Property spapr_nvdimm_properties[] = {
>>     DEFINE_PROP_BOOL("pmem-override", SpaprNVDIMMDevice, pmem_override, false),
>> -#endif
>> -    DEFINE_PROP_END_OF_LIST(),
> 
> Is it too early to remove END_OF_LIST in this patch?

Yes.  I thought I'd fixed this when shuffling the patches around.
Ho hum.


r~


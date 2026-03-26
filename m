Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4539109E540
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5b4l-0005mJ-9Z; Wed, 25 Mar 2026 23:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5b4j-0005lp-IS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:08:01 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5b4i-0003Pm-1V
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:08:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso2622835ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 20:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774494477; x=1775099277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H8y6ST3TihdHa2j9JPQj+YFcQ4Qwxb87lbVmtImDUN8=;
 b=IPkem0FxMoO6WkbuHvSE2riHSNrrgWHEKrn5cEGkEKfCcvul4IiP2+kSIavMYw5Jdt
 ZNW2S8mJhq8flsjH84Ejb9J3NQZHE26hl/RixwNKweU5So8R353/Ko6T64Mg5yaoG0/n
 9cQeYqtE9dLmk1eWzbEnrweO7vIalUOEjSibcMArStjuz01S70QNKI3YaAj7pJSbX8le
 9lUZe9KTtaTD5/ElmGE/a035owNaSWbv6VuK9gP5lcDOr6hNcDo9mBSEAc3trWy+yWxB
 2UJ6jvQfWKcaGXlXch4bgXqOSQN1ZGxZe7kbdvolfdp7KdihGXIUJHCpMie4a/h9m4Gx
 tCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774494477; x=1775099277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H8y6ST3TihdHa2j9JPQj+YFcQ4Qwxb87lbVmtImDUN8=;
 b=q9aJdzJmQAjwnBEgw7jfPCirYzmk4qufdaa9Bogwq+hkYg78mbgej/xP9nmRBsbmcb
 kb9rbhD/iMWr/K8WBFiwdrgZK+wcExEnCpdWV1Mn9pqe++Zp/X2/Tkee8SXz3VtvNfN2
 2mZGZji1xBOZf1Mv2dGSg8YHZp/pwuH9QTT4iuJgJpXusWlT1TKgNuJ/CqQxPpjyB0BJ
 pxRlvWNjZfeshzLlboXe+Bs+8alFBgIXLMKr5FDxmU0nEnPoIXNG1WqNryq+MgmhIt0l
 P1ZM/0HH1T8Q+zIEFIEYh93G0gYf00VMOYXK1X7jl2MAm3OFOdL1/CLeFi3f7xgmezLy
 12Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5DNhESWgXbzp1FFWAf1hOy97HVrLOteWniFgmTJJccK+N0HM/UjOM9Uwdaoq5Y8EBPctUOIFlJekL@nongnu.org
X-Gm-Message-State: AOJu0YyzT42pYn0xiw+Lg7/MLNl2bRYT71ikBvEWMa0VxP1Vxu1YB7rg
 ET+bWGClA05gZLssG1xwloigVcAs9KNQUFoLwE+H1CcdV39+OKwqnvP10xRk+vkcrgT2GjeHTjh
 X9cmfve0=
X-Gm-Gg: ATEYQzwE5nQbZQZ/zyf6nBRo9wW1gsOzZzx5qeLsaTluBsm1rlDvbz02ATOeyC68s7G
 RzVUQIkQ4m4J7wEZZ3e+KAu5dtY41PTKd1xMgjIZVLGjFWwdeVD+tviIhh2nvy3S0OIQno8FYIn
 KiMx99uyO4RNKFbB3Afq6eJN1vA1NsYa0OZJds8a+/MSTxpT2u4937d+UoHd01zN6xzn43uvwNE
 KIAlWv2Zm214FnGOhmMW8ddSlSSA8KcRNvmRg5xjDn0r4xuJh5VXgDGxRGk3PtXsRQ92epS5Isq
 Y1HlD1b/zttYmZRdpyL2HFrbHMkBlmA959m5QvZ7iA1a728WqLy1bCJwtRFrBMVS66UpL23S0Nl
 Ig7P4dFXEoaXdjiVFBP1EtOfG1i0xirsa0yGgggGGZWSMLkVpZl0mBN/2g/qtTvSJ8pLUBHkC7I
 agtWBZhtxbtxtu9DbELBS1PvQyyCU9e7FnCWRaXFGw5NxeKMf1Mzt1
X-Received: by 2002:a17:903:166e:b0:2b0:bcda:76c3 with SMTP id
 d9443c01a7336-2b0bcda7a12mr17858895ad.23.1774494476652; 
 Wed, 25 Mar 2026 20:07:56 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7afad1sm15267515ad.31.2026.03.25.20.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 20:07:56 -0700 (PDT)
Message-ID: <614e25b5-74e1-4620-947a-3c92ed6f2a9f@linaro.org>
Date: Thu, 26 Mar 2026 13:07:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] hw/alpha/dp264: Validate kernel and initrd sizes
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-3-4375b00a85ff@yodel.dev>
 <979d9029-c49b-4bdd-823c-ca356d63a1c3@linaro.org>
 <7cd87657-f7fc-41c5-bdde-a5e6c5bf1399@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7cd87657-f7fc-41c5-bdde-a5e6c5bf1399@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/26/26 12:04, Yodel Eldar wrote:
> Hi, Richard
> 
> On 25/03/2026 19:11, Richard Henderson wrote:
>> On 3/11/26 08:31, Yodel Eldar wrote:
>>> @@ -192,7 +192,15 @@ static void clipper_init(MachineState *machine)
>>>               }
>>>               /* Put the initrd image as high in memory as possible.  */
>>> -            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
>>> +            if (usub64_overflow(ram_size, initrd_size, &initrd_base)) {
>>> +                error_report("initial ram disk exceeds allotted ram size");
>>> +                exit(1);
>>> +            }
>>> +            initrd_base &= TARGET_PAGE_MASK;
>>> +            if (initrd_base <= kernel_high) {
>>> +                warn_report("initial ram disk overlaps with kernel");
>>> +            }
>>
>> Why is the first an error and the second a warning?
>>
> 
> Initially, I had both as fatal, but then I figured a (mis)adventurous
> user may actually want to experiment with kernel/initrd overlap, whereas
> an underflow is something we can't allow (and initrd being larger than
> RAM is physically impossible AFAIK). I could make the overlap fatal,
> too, if that's better?

I can't see it being useful at all.


r~


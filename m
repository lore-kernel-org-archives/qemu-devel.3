Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCE3E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIiQV-0005OR-RM; Wed, 04 Dec 2024 00:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIiQM-0005Mg-1q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 00:59:47 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIiQJ-0004Vy-Nv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 00:59:45 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa5b0d8bd41so815193266b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 21:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733291980; x=1733896780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWMxp72gDfDEbetPrP7duXBl1wy0ey/eTbWhr+s1CwU=;
 b=X7ZNAbs7GqN63nxeUtxL8KMCTFzLcVC29wOl7N08pBvrsD1TOCotj2pJSZxfYBNDZy
 haDJK0F8xfa1YZ6QgYQEfj2SR1uTv8ZKht4wcKGfMlxm1jxrp1d9QIqcydA1zgsqAtnO
 xNRbTOE2Ho0q5vwgiIh1V6wF+drSMHZgcUdkrB5Zt91xrIG3QAdG/eJgqOlhRVJDaOue
 8Sky2W3aMUSvC5wkVLA0nwQvWJbo3sZk4RxW3zJE3bS8M3QGccU3hieJs2L2aujodCUF
 4PBzFsUG8fTEKNwcAB26HuE5vT6pp4q1yVlzXx5FXWhDuqgs88RsRsFOkRoWr147Y6MR
 I3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733291980; x=1733896780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWMxp72gDfDEbetPrP7duXBl1wy0ey/eTbWhr+s1CwU=;
 b=LoApSuMul22Fj2yoOJ/1rsW6IN2Nr1ETwDPceOQ9igoInzfSuMoUPsQ4SZE/gS43Xt
 EiOjQml5DSKiwYAPqyx9BRyNQUNkSebwQtFj6K+Ka15s1dOxSOY1Y80VSMpaMvr6z7CV
 EMbNuq3leNY8qxB/R2jfSSvqK/FhNzHdX6dMu1bRKaHlfUWWojp4jFPOgKU3b0/meRVy
 fLfsh3cFULkxqj0t26t+C9d/G0dStAdzeO5tAAdrx9ief3oIrehDXhRC8wRmiNfWsC2h
 vJ8DQVWWFruqsQNXThjGUuyS/nHBGN5aLoJcpyxy+11HQyamrAPYc/Csj719pQNbfSMX
 lPVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjix8cRIANbb8WvfAJDtyNYurJtGd4nd+dmkmPiO6SJZnSl5UetRkqst+54HZHTLBmmVq3wwPCkUYH@nongnu.org
X-Gm-Message-State: AOJu0YwP/p4Fua0W7odc2hrXpZNzHEm+Vkod/2qX5HnmFF3TjuiPEgwp
 f7u1aq1XxU3vETGICMCVZ8eZf2yf4kub9me/Ka7KRZldqIqE2iq8suVQ7Q45lk0=
X-Gm-Gg: ASbGncvOY5BBote8q7fkUQFU0mr53owSPIeQ4cIdll5msT+6bCR98+yk4Vc9n7YDXN7
 T26PPwMouRl9BVy65vXoxGFYIYqrC/gLPNPcmehZsm9iJyKxafaFxTf14HyqHbZLsoEYZ/cblgL
 c/yJvMjfCUXYTOi2V/cvzcfDDPkGnJOyPIsl8bYggHMryJls/GgJmCV+iQHuZ23p2KoCe+gYPcn
 cWCWl6Gkz6Szf0LIz6w/gOUXgs9STY4Zudezr33rX9vkrgu03v1pgqQkxOJNFO4SfhD51tMFq6I
 GrpURFpkY/r4mWyPWkZaqVTStRKGPqgWgsNomDLc1g==
X-Google-Smtp-Source: AGHT+IHwL6jRxDXTpAJTWwH0lE8YKUurxlsY8tu/Gbe7V5KCP98bz5eLqeBEh1LqF6Ds+rETtjlvKg==
X-Received: by 2002:a17:907:762d:b0:aa5:1d33:dc10 with SMTP id
 a640c23a62f3a-aa5f7f0b58bmr347232666b.45.1733291979772; 
 Tue, 03 Dec 2024 21:59:39 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5997d560asm694899866b.61.2024.12.03.21.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 21:59:38 -0800 (PST)
Message-ID: <793ffece-66b6-4201-bc78-cc774d8ec35b@linaro.org>
Date: Wed, 4 Dec 2024 06:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
 to set the different Capability Registers.
To: Jamin Lin <jamin_lin@aspeedtech.com>, Bernhard Beschow
 <shentey@gmail.com>, Jamin Lin via <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20241203021500.3986213-1-jamin_lin@aspeedtech.com>
 <20241203021500.3986213-4-jamin_lin@aspeedtech.com>
 <94E62126-BB97-465A-9021-2FB365E677A8@gmail.com>
 <SI2PR06MB5041216ED78069F9BBE4275FFC372@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SI2PR06MB5041216ED78069F9BBE4275FFC372@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 4/12/24 04:14, Jamin Lin wrote:
> Hi Bernhard,
> 
>> Subject: Re: [PATCH v2 3/6] hw:sdhci: Introduce a new "capareg" class member
>> to set the different Capability Registers.
> 
>> Am 3. Dezember 2024 02:14:57 UTC schrieb Jamin Lin via
>> <qemu-devel@nongnu.org>:
>>> Currently, it set the hardcode value of capability registers to all
>>> ASPEED SOCs However, the value of capability registers should be
>>> different for all ASPEED SOCs. For example: the bit 28 of the
>>> Capability Register 1 should be 1 for 64-bits System Bus support for AST2700.
>>>
>>> Introduce a new "capareg" class member whose data type is uint_64 to
>>> set the different Capability Registers to all ASPEED SOCs.
>>>
>>> The value of Capability Register is "0x0000000001e80080" for AST2400
>>> and AST2500. The value of Capability Register is "0x0000000701f80080" for
>> AST2600.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>> hw/arm/aspeed_ast2400.c      |  3 +-
>>> hw/arm/aspeed_ast2600.c      |  7 ++--
>>> hw/sd/aspeed_sdhci.c         | 72
>> +++++++++++++++++++++++++++++++-----
>>> include/hw/sd/aspeed_sdhci.h | 12 +++++-
>>> 4 files changed, 78 insertions(+), 16 deletions(-)


>>> diff --git a/include/hw/sd/aspeed_sdhci.h
>>> b/include/hw/sd/aspeed_sdhci.h index 057bc5f3d1..8083797e25 100644
>>> --- a/include/hw/sd/aspeed_sdhci.h
>>> +++ b/include/hw/sd/aspeed_sdhci.h
>>> @@ -13,9 +13,11 @@
>>> #include "qom/object.h"
>>>
>>> #define TYPE_ASPEED_SDHCI "aspeed.sdhci"
>>> -OBJECT_DECLARE_SIMPLE_TYPE(AspeedSDHCIState, ASPEED_SDHCI)
>>> +#define TYPE_ASPEED_2400_SDHCI TYPE_ASPEED_SDHCI "-ast2400"
>>> +#define TYPE_ASPEED_2500_SDHCI TYPE_ASPEED_SDHCI "-ast2500"
>>> +#define TYPE_ASPEED_2600_SDHCI TYPE_ASPEED_SDHCI "-ast2600"
>>> +OBJECT_DECLARE_TYPE(AspeedSDHCIState, AspeedSDHCIClass,
>> ASPEED_SDHCI)
>>>
>>> -#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
>>> #define ASPEED_SDHCI_NUM_SLOTS    2
>>> #define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE /
>> sizeof(uint32_t))
>>> #define ASPEED_SDHCI_REG_SIZE     0x100
>>> @@ -32,4 +34,10 @@ struct AspeedSDHCIState {
>>>      uint32_t regs[ASPEED_SDHCI_NUM_REGS];  };
>>>
>>> +struct AspeedSDHCIClass {
>>> +    SysBusDeviceClass parent_class;
>>> +
>>> +    uint64_t capareg;
>>> +};
>>
>> The struct seems not AST-specific and could be turned into a base class for all
>> SDHCI device models, no? That way one could also add further device-specific
>> constants other than capareg.
>>
> 
> Thanks for suggestion and review.
> 
> The common sdhci model(sdhci-internal.h) had this "capareg" property to make specific SDHCI model of ASPEED SOCs
> to set the different value Capability Register such as aspeed_sdhci.c
> https://github.com/qemu/qemu/blob/master/hw/sd/sdhci-internal.h#L318

DEFINE_SDHCI_COMMON_PROPERTIES() only sets default values,
you can overwrite them in your class_init().

> 
> In the previous design of aspeed_sdhci.c, it set the hardcode value of Capability Registers for all ASPEED SOCs.
> This patch set the different value of SDHCI Capability for AST2400, AST2500, AST2600 and AST2700.
> Thanks-Jamin
>> Best regards,
>> Bernhard
>>
>>> +
>>> #endif /* ASPEED_SDHCI_H */



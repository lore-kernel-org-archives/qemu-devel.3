Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB52D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf95-0000ps-Vh; Thu, 14 Nov 2024 14:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBf8r-0000nW-S7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:04:42 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBf8h-0004oM-P4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:04:26 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa2099efdc3so208133666b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731611062; x=1732215862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wLJ5bGe8PhcA5s4MkR8F5MzptCMjqAp4jO9kLmFUCA=;
 b=QZvf4m9+k88hxmD/7jKCc23oux7lGJLS0JAPA3Am4efV8GaDnc71iyOAdAcXJkKEpA
 zcjy2CRfh6PYeWW8WSNgVvJQHmFhj/BdS2B2HebZaX8Sp+oHkgQgqCzNAdCFAxUfiaw/
 YF8s+h4ZZhXiki6fdEwcojPjyauxfKYiVvc/Vlp0E988ZYQAAVa9kE9o2tyirQmdXExS
 YZceP8DkplaQ6N7CoPmmC6hjoe9zR8XN2IErdMSatR0cO5KWTPQcdj4huuj2aCFLS15u
 VN76dCb9vWzkfgB8ly17OnC3qxS29V3wmJyNJK91nj8WPc4H4UKYAN+LxeIMTXupSv1M
 hgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611062; x=1732215862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wLJ5bGe8PhcA5s4MkR8F5MzptCMjqAp4jO9kLmFUCA=;
 b=rbnqHl51B98mc1ZY2vxivIjrFij4qndUNZn9Lu0ZYMuAT0SUk6SscciKCh49aHhkan
 BwW6ic0dwPD5fcHE1GUbwKekJYE1zg7BHY6qZIPpNymhbDOG3ubkGNFDnvEMoRhhBuxm
 70BZayXHwkvIjWemgco9oqRtJokGolxg+e1oW9iQRfjNiwMlHdReq2byamj0IFn0xngh
 SYmOwggovOOJ4q5KPD/zTb7wuLM+sd7RW0KPEcQEndfbi41yDYRnxYWyToOCA3+OA+Al
 6IaTbPoBZUj+eaWPHAobR5Apdtx8JVpTC4G28unqUE9GA9VuolO1KJHeo+4bIw/Plwl5
 lAQQ==
X-Gm-Message-State: AOJu0Yy8xoHNHkmSQyPG8JWP0tiqBgIk7hg1+WmB+MQy2RyW+Lium5PF
 o6TdTeEMps2pXIkiM7wYAIyfXtzztga8bvNx0bmddElzjJprUKnRADirKefCPjA=
X-Google-Smtp-Source: AGHT+IHUUH3+mJVweYuJa8JXmFrF6sxDcV4hGYS629ungZmAus8XcXlvvnyKgbE8XcLBynOQZBQB2Q==
X-Received: by 2002:a17:907:2d92:b0:a9e:65a1:fdac with SMTP id
 a640c23a62f3a-aa48185cacdmr21369566b.7.1731611062107; 
 Thu, 14 Nov 2024 11:04:22 -0800 (PST)
Received: from [192.168.69.174] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df51ab1sm91362166b.57.2024.11.14.11.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:04:21 -0800 (PST)
Message-ID: <61989b7a-2dd2-4582-98ae-a78182c0b88c@linaro.org>
Date: Thu, 14 Nov 2024 20:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] hw/net/xilinx_ethlite: Add addr_to_port_index()
 helper
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-9-philmd@linaro.org> <ZzTEjun3kd5_wckb@zapote>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZzTEjun3kd5_wckb@zapote>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 13/11/24 15:23, Edgar E. Iglesias wrote:
> On Tue, Nov 12, 2024 at 07:10:32PM +0100, Philippe Mathieu-Daudé wrote:
>> For a particular physical address within the EthLite MMIO range,
>> addr_to_port_index() returns which port is accessed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/net/xilinx_ethlite.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
>> index 20919b4f54..fe91891310 100644
>> --- a/hw/net/xilinx_ethlite.c
>> +++ b/hw/net/xilinx_ethlite.c
>> @@ -24,6 +24,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/module.h"
>> +#include "qemu/bitops.h"
>>   #include "qom/object.h"
>>   #include "qapi/error.h"
>>   #include "exec/tswap.h"
>> @@ -86,6 +87,12 @@ static inline void eth_pulse_irq(XlnxXpsEthLite *s)
>>       }
>>   }
>>   
>> +__attribute__((unused))
>> +static unsigned addr_to_port_index(hwaddr addr)
>> +{
>> +    return extract64(addr, 11, 1);
>> +}
>> +
> 
> Shouldn't you add addr_to_port_index in the following patch and avoid
> the temporary unused attribute?

OK.

> 
>>   static uint64_t
>>   eth_read(void *opaque, hwaddr addr, unsigned int size)
>>   {
>> @@ -190,7 +197,8 @@ static bool eth_can_rx(NetClientState *nc)
>>   static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>>   {
>>       XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
>> -    unsigned int rxbase = s->port_index * (0x800 / 4);
>> +    unsigned int port_index = s->port_index;
>> +    unsigned int rxbase = port_index * (0x800 / 4);
> 
> 
> Hmm, AFAICT s->port_index is an unsigned int, what is the purpose of this change?

Likely a rebase mistake, this belongs to the next patch indeed.



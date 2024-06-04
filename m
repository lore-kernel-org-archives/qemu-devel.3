Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AFBC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVmo-0001QD-9X; Tue, 04 Jun 2024 11:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVmn-0001OB-AZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:09:17 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVmf-0000oq-Qy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:09:17 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a23997da3so6281804a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513747; x=1718118547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ue1rDUmoEAlvLY2WNgCDQS1Zxvw8NWzwwGErFpx84L4=;
 b=RbOklAYWmUFQm/Bl3KcVQN7Ae2hut5stAVDSMb5/SQtErB+fr/R0hbca3D6yPrOmEy
 KaUx11rWnCW0jl2G534vEi9AF4gpgn8enYNcNWlE4j8Gk56GuJ6RcUZOXUa1Nao6pllM
 MYDwPeOx3oF+BBd7SGdSJwiJhOn0WnlQF4Detrf5Fr8BDWD12O908hmXWJgh9ZSyu3lW
 Dd9js/mHlS0cWVHL1owUOm3c/t7kBplKgJdzw/q4/hGycVE2MALtEW9m7wnZodi8hDhx
 Kdl+yVfGOmzpvej7papt7jkCmWvX6NoFOWuphX9sXcQAHUQW03du5AVPREbvR/ZxClp4
 j8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513747; x=1718118547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ue1rDUmoEAlvLY2WNgCDQS1Zxvw8NWzwwGErFpx84L4=;
 b=n3eTCs6ClYFcVjcCtq8/p7VEaJmcxpeA+xTuzXQGIzPEgmeBpn973tdRHzgSAteEwJ
 n5q4bjI8LcWSKqmwD387rrsPB6lrBDM/SRpnAk8LQVH9fkR0CcXkWTQs/8oLeXlTVV25
 cyLhZQEf4jTFHXTT35vb6p6MRNeK8Wv+WDmMICaa+Gtd6PZAYMTkeqd5TAvbZnoZg0g4
 paSaXZwxhXFgpFdAfhYEyjQHHAFiOdh2ndg1cHJ4l9GTRrpRMgYnio8Kk8owEr1FZ9cb
 QFt18NXNDBUkVO9G6961c535rbHTDu6TCn8Og5hNIvXUQTFRKe1PZ3Uoqq+ZBvOkzeQL
 oJaQ==
X-Gm-Message-State: AOJu0YyAMIcsM5Z937orXq2JFUB1NmdELlRzYOdtdn/1faVR7jBvpjrN
 XtIJk9WanwPZzOFLDz21RvBsRa+Cl10Z4mIRr/G7DmqPSqbMTDp6FuD5BW19Smc=
X-Google-Smtp-Source: AGHT+IHO8ZepavG2SQhllhsevdMS5c393h1XD8/J66BdREXza0Ad/aQx+g0Xb1xmkXN3YwzvbMbqgg==
X-Received: by 2002:a50:8adc:0:b0:57a:2fb9:a0e1 with SMTP id
 4fb4d7f45d1cf-57a36384288mr7736271a12.15.1717513747369; 
 Tue, 04 Jun 2024 08:09:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a3ebc6751sm6874936a12.51.2024.06.04.08.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:09:06 -0700 (PDT)
Message-ID: <5a935eea-fc4f-4b11-b981-8670f03615f0@linaro.org>
Date: Tue, 4 Jun 2024 17:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/coverity-scan/COMPONENTS.md: Update paths to
 match gitlab CI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20240531142145.482361-1-peter.maydell@linaro.org>
 <77a5f792-6caa-4dd9-9de7-e13224573f30@linaro.org>
 <CAFEAcA8Wv5YCpdee5GZzsAj824WRUxPb6mmLLSQvXV6S68aLkQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8Wv5YCpdee5GZzsAj824WRUxPb6mmLLSQvXV6S68aLkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 4/6/24 15:32, Peter Maydell wrote:
> On Fri, 31 May 2024 at 16:17, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 31/5/24 16:21, Peter Maydell wrote:
> 
>>> If there are any other changes we want to make to our component
>>> regexes, now would be a great time to suggest them, because this
>>> change is going to involve "delete every existing component and
>>> recreate"...
>>> ---
>>>    scripts/coverity-scan/COMPONENTS.md | 104 ++++++++++++++--------------
>>>    1 file changed, 52 insertions(+), 52 deletions(-)
>>
>>
>>> diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
>>> index 1537e49cd5a..98d4bcd6a50 100644
>>> --- a/scripts/coverity-scan/COMPONENTS.md
>>> +++ b/scripts/coverity-scan/COMPONENTS.md
>>> @@ -1,157 +1,157 @@
>>>    This is the list of currently configured Coverity components:
>>
>>
>>>    block
>>> -  ~ (/qemu)?(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
>>> +  ~ .*/qemu(/block.*|(/include?)/(block|storage-daemon)/.*|(/include)?/hw/(block|ide|nvme)/.*|/qemu-(img|io).*|/util/(aio|async|thread-pool).*)
>>
>> util/block-helpers.[ch]
>>
>> I'd put hw/block/ to another bucket that the block subsystem.
> 
> MAINTAINERS considers both block/ and hw/block/ to be part of the
> "block layer core".

Personally I'd look at hw/block/ issues and skip block/ ones :P

>>>    disas
>>> -  ~ (/qemu)?((/include)?/disas.*)
>>> +  ~ .*/qemu((/include)?/disas.*)
>>
>> Missing:
>>
>> target/avr/disas.c
>> target/loongarch/disas.c
>> target/openrisc/disas.c
>> target/rx/disas.c
> 
> Why do these targets not put their disassembler in disas/
> like all the others? We can't really catch them with a
> wildcard, because the target entry earlier will match first.
> I'm kind of inclined to leave these as-is, because if
> somebody put the disassembler in target/ then having it
> appear in the component for that target is fine for it being
> basically classified to get the attention of the right person.

disas/ is for non-decodetree disassemblers imported from
BFD library. Decodetree based belong to each target/foo/.
So I agree keeping as-is is OK.

Regards,

Phil.


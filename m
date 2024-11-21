Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B87E64017
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 21:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEF0Q-0006aP-5S; Thu, 21 Nov 2024 16:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEF0I-0006ZP-1Y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 16:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEF0D-0000ZK-Ox
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 16:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732225577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aoP9X5/WXYDi3CAKaUX/uDhnqsjwwUUIkJkVbZ0bukE=;
 b=OlV6u4XyvK0IPCJGXkGF2Yx0aFOPSJP7C8jEXer6TCsjlC8GmQ46/5+Gj6tUBnDOi58D2s
 43RaYPwI+ulpSNjxMUKqNUZiLCpkRVbdIedUN0es/AKCuBRiQjYYNEiXxGGSST2UUYIND1
 p7aqaae/EcNopkhHN02FdhJuhFADMIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-V3kcxrQQMRyX-4-OLTSZiA-1; Thu, 21 Nov 2024 16:46:14 -0500
X-MC-Unique: V3kcxrQQMRyX-4-OLTSZiA-1
X-Mimecast-MFC-AGG-ID: V3kcxrQQMRyX-4-OLTSZiA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382440c1f83so1322369f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 13:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732225573; x=1732830373;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoP9X5/WXYDi3CAKaUX/uDhnqsjwwUUIkJkVbZ0bukE=;
 b=dblgWBLPiL/47V9LGvyJ1vMH9kev8NONwPX4jSclLbIQrxu8JNvRAlT3auJ7pBfq4E
 2DuLs02hhMF8HUd+qAYw/UUPt3BtvITN7FC6NhZhPeN/86aG7ZeIjWDaAlGpoRVE8W7E
 WNIGNavRysZW0X3FLg8RMFlEiaCtaa/f2ifnKkfieJtoJ6GOOmhzOPAyqGVmnibAQEM2
 EVu25tSJctQsqyMni8YHm7FfcDup9BKeeg5p4s8TDnGrVUawj3ORcCnJGGNV+6Kr3Y7b
 1wrmOrt48WFy8/2DR4K2KTvUDgMshKsGxU+NiR2jztEP5CtL5DMKziF3UmBAnhKr7cNf
 uY7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj25qGu25Nd/2A2hK6XUJM2j56BHUhXK9etxAXu6FyqiTyKVmsrw4EBGM9YtX8Vu8kUJnYNauethxu@nongnu.org
X-Gm-Message-State: AOJu0YznoXCChlGEyuTg1IYEgmlsH2RJjo7eey408SER2PhDx4CN+9Yo
 PmQ9ia0qMw6qkL4x0+Ley4gYgYgcJsT5pmHBBjjIdnQyy4At+egfJU0Dd6u3pB/LajBTx//tcox
 bCBwV5lKVFvCPwBDNlL1WYbQOMfhq8b9E/krFfGRcplDyWvnxuwG4
X-Gm-Gg: ASbGncvNZ9uxYiME65nNUSkvUEK5Ql6O+ZeB0K/Oyjy7PgRw5sAP5PRS2IZTankcehA
 Rkl36N0vecuXBTDzXVXqTzUFDBDu+OMAGPjypOUQCFJ+QBvaJSebTMOwL0k19J5mY+PIg5aV82E
 QdwXGfq0DFGPW9hB9LZz7fEg6i5L+/8D/KIzPMP/y4QJpatTfQZOjOCGIlMZ5RH4KFqCpMkc6zD
 g4ni4OFD3hxAdcOG3YDU1d8ltIas4kurvHOTx0g2aiX0CNrtzgJV1dXaYMw5m/iLRx9zX9/oFdb
 BBvZeuES5kS+
X-Received: by 2002:a05:6000:1f8a:b0:381:f15a:e91 with SMTP id
 ffacd0b85a97d-382604ec295mr474596f8f.11.1732225573584; 
 Thu, 21 Nov 2024 13:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiWV7XQ91mnuG7uyrAo0gRa4Vpd1XxBM7Eyz/Eaw8lq+61ea0pmejISp7XVhj3aAoY8fZygg==
X-Received: by 2002:a05:6000:1f8a:b0:381:f15a:e91 with SMTP id
 ffacd0b85a97d-382604ec295mr474558f8f.11.1732225573210; 
 Thu, 21 Nov 2024 13:46:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedf35sm618945f8f.99.2024.11.21.13.46.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 13:46:12 -0800 (PST)
Message-ID: <0cbbec0d-5be0-4ec2-8791-470c70d93e33@redhat.com>
Date: Thu, 21 Nov 2024 22:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] maintainer updates for -rc2 pre-PR
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <2b8f6079-f2ca-471f-8580-43352437625d@redhat.com>
 <a3935ca8-5a44-4f2a-a414-aaa39f8e193c@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a3935ca8-5a44-4f2a-a414-aaa39f8e193c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/21/24 20:10, Thomas Huth wrote:
> On 21/11/2024 20.03, Cédric Le Goater wrote:
>> Hello Alex,
>>
>> On 11/21/24 17:57, Alex Bennée wrote:
>>> This is a mostly testing focused set of patches but a few bug fixes as
>>> well. I plan to send the PR in on Monday. I can drop any patches that
>>> are objected to but I think its pretty safe.
>>>
>>> Contains:
>>>
>>>    - Daniel's clean-up of functional tests
>>>    - Another avocado->function conversion from Thomas
>>>    - Update the tuxrun baseline images
>>>    - Minor fix to the rust pl011 device
>>>    - Documentation clarification on identity
>>>
>>> The following could do with some review:
>>>
>>>    tests/functional: update the x86_64 tuxrun tests
>>>    tests/functional: update the sparc64 tuxrun tests
>>>    tests/functional: update the s390x tuxrun tests
>>>    tests/functional: update the riscv64 tuxrun tests
>>>    tests/functional: update the riscv32 tuxrun tests
>>>    tests/functional: update the ppc64 tuxrun tests
>>>    tests/functional: update the ppc32 tuxrun tests
>>>    tests/functional: update the mips64el tuxrun tests
>>>    tests/functional: update the mips64 tuxrun tests
>>>    tests/functional: update the mips32el tuxrun tests
>>>    tests/functional: update the mips32 tuxrun tests
>>>    tests/functional: add a m68k tuxrun tests
>>>    tests/functional: update the i386 tuxrun tests
>>>    tests/functional: update the aarch64 tuxrun tests
>>>    tests/functional: update the arm tuxrun tests
>>>    tests/functional: Convert the Avocado aarch64 tuxrun tests 
>>
>> Do you think we could include patches 2-4 from this series ?
>>
>> https://lore.kernel.org/all/20241112130246.970281-1-clg@redhat.com/
>>
>> Only patch 3 lacks a R-b.
> 
> I had a question on patch 3 and a suggestion on patch 4 ... could you maybe address them first? Thanks!

Oh Sorry I forgot.

I did address patch 4 in my tree ... In Patch 3, EXTRA_BOOTARGS was
added by Alex IIRC to work around the console issue. We ended up
adding the sleep call. I can resend tomorrow.

Thanks,

C.



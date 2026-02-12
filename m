Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B590EEDF055
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRlo-0006EZ-4N; Thu, 12 Feb 2026 03:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqRln-0006Dz-0r
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqRll-0001Jw-5U
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770883788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uQU6ihC1iE9DG45U8gTQtZu6W1HT8L2w+bGExVDZ26o=;
 b=Pa6sleCvmSmmWnT7/xMAZ+aBxT97GQ3hQCTtjdDY43GwR9nFj+9+p3ZH/A7SMIzNbeE4Zk
 q1EQH0Y3NaFqOI1ihXYBBjQKfUTEVCB+rZYp6faCtHIkV+06chcgMyBwFmm29pWSU3uQiD
 tCIkKv/9C7u/jOXIR7r2ryAtTf/AOGY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-QjrvCYjcPCOcIMfFQe_ujw-1; Thu, 12 Feb 2026 03:09:46 -0500
X-MC-Unique: QjrvCYjcPCOcIMfFQe_ujw-1
X-Mimecast-MFC-AGG-ID: QjrvCYjcPCOcIMfFQe_ujw_1770883785
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4376ec2b1cfso3362458f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 00:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770883785; x=1771488585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uQU6ihC1iE9DG45U8gTQtZu6W1HT8L2w+bGExVDZ26o=;
 b=tk6oyzDyC00n8MRSs827WPAwDkdtRca7wUiNPZl1AuYnYu+4y/pKz+baQvTHVeUaUd
 p3zfea1YjKlAPtV8Wx/92ewyVrwCk/sGhyUBMJ6Yn++Iyx3Mf4Ql5+uw5blOUUN9zc+g
 VfWe9/d2oYqCnVB6qrYJYrPwyNDVkx71bq6SThQVNiz2zXYxcvkaC7IqFqjQPdWwR5ri
 YZNWF5NAREEnxv6TDKaO5/thkFJ2/4LHC4jsP4U9nmmOHFwdhrt9lgyqyVvZ5yCE++m2
 XizNqurTkEL+sGCD4ZshkTRWx2RR2mcRiBNZZCAcNiT+So5rsTbvdpjzW+3oSZimypGv
 bQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770883785; x=1771488585;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQU6ihC1iE9DG45U8gTQtZu6W1HT8L2w+bGExVDZ26o=;
 b=TbT3w5fk8dwZIw0j6BApru+a9HLiq+wYvp9nJ81A0gpgLoaz8NjtZtcgH8dVJyuIzE
 qKHfVKCavT5QUx6ewb6adh9pbPopJlgKt2OwKFxfw3kv5AkHX1s+qS+xVr30II0tHH/Y
 hRjdB9iBPAIxBY8gy7bshzUxEoPIH4h6lRAHytcLJYB5XwTiQ6eoYN33Axgu6v919jM1
 MP6bdY8QM88fwXkeUzoeUMIx3/Hf6eWPFDw9vOyAgNlkzza25oKAdysdD8NNDErLT77/
 Y+X0gZMwmFGjF4wHw0Dh7Ez8YhlGPRECZq55CHnKKQ0fjv3c+VJzfVbYTYO75D8TmY4d
 aVcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0DymghbBz+OdJXteTpIIvOuQZPOsZ8HNSxHr3r4IvEvcEJDMKOuw0tBfSkpX5VFkE9gixZO4CMfXf@nongnu.org
X-Gm-Message-State: AOJu0YzY30NHKt6ZkL2ewu32rYgUXnh3l6PYN5H9MUvRVQtHLGofczE0
 LGNhjKl2CCNCiGjEorwEyQDaTi/pbjcm0ti442eaGYRGTLIQ29WIT6RjntSmTUk6Hu1kKheqFjQ
 1A495luMYZr25NZ2IW1uijrchfUqKlM4iysSZThZjdlgZq3c+6kvS4xhe
X-Gm-Gg: AZuq6aJ5goi+TvljvTYhT7Mzs8gOOP3KXtiVjk+UKW455popfswx0j7JqNP06iru1DA
 jMZfSa3e1Gq1P4NAUbUt7M03PgEQ6FMHh0mjpDuBl+xFXR4Jd/Xfe6ehG2Fcmb+hAxkjLDXbs3x
 T6MCR9ok0SUX4k4SdNzWNUI6hexHAUJb3X6fDc9w4DXxpeWAvkMxGG85gIPcteqcXxDiznJI4L1
 +n12NmnsRD0ci6xNfTOOkU/BieH40HO6X1Imc+QTxGQdEs0Qo7Tx6UV5U1rU6V712fiPnr6Oebi
 J54zkBbswjCKLvk5opXRieAkzJTLBuM/kI78hOYfFQiLqt4MqtvqEXBjyTnUAd9jt48uyIf1yO0
 XJGD+oG6OH0FL+GDS1onnMnkjKi/BrwQrw4n/+KgVKFW/A/pXryb4p1Ax5lh5
X-Received: by 2002:a05:6000:2403:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4378aa01e44mr3503146f8f.5.1770883784753; 
 Thu, 12 Feb 2026 00:09:44 -0800 (PST)
X-Received: by 2002:a05:6000:2403:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4378aa01e44mr3503088f8f.5.1770883784160; 
 Thu, 12 Feb 2026 00:09:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d46ec6sm10473516f8f.9.2026.02.12.00.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 00:09:43 -0800 (PST)
Message-ID: <16417646-e328-4ffd-b648-dcdda4492da3@redhat.com>
Date: Thu, 12 Feb 2026 09:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Thomas Huth <thuth@redhat.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <d56d900f-d9cd-4c6f-ac44-a0cb0e6e6b13@kaod.org>
 <SI6PR06MB7631B5BECA948F629031A0E1F760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <44801358-496e-4cef-a33e-ca91745a15c8@kaod.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <44801358-496e-4cef-a33e-ca91745a15c8@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/12/26 08:55, Cédric Le Goater wrote:
> Hello Kane,
> 
> On 2/12/26 04:39, Kane Chen wrote:
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@kaod.org>
>>> Sent: Wednesday, February 11, 2026 4:33 PM
>>> To: Cédric Le Goater <clg@redhat.com>; qemu-devel@nongnu.org;
>>> qemu-arm@nongnu.org
>>> Cc: Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Jamin Lin
>>> <jamin_lin@aspeedtech.com>; Andrew Jeffery
>>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Thomas
>>> Huth <thuth@redhat.com>; Kane Chen <kane_chen@aspeedtech.com>
>>> Subject: Re: [PATCH 0/2] tests/functional: Aspeed ARM tests enhancements
>>>
>>> Jamin, Kane,
>>>
>>> Could you please review this series ?
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>> On 2/9/26 07:50, Cédric Le Goater wrote:
>>>> Hi,
>>>>
>>>> This allows the functional test suite to run tests in parallel more
>>>> effectively and adds a new set of tests using the older Linux 5.15
>>>> kernel.
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>> Cédric Le Goater (2):
>>>>     tests/functional: Split Aspeed ARM tests into separate files
>>>>     tests/functional: Add SDK tests with Linux 5.15
>>>>
>>>>    tests/functional/arm/meson.build              | 18 ++++--
>>>>    tests/functional/arm/test_aspeed_ast1060.py   |  0
>>>>    ...00.py => test_aspeed_ast2500_buildroot.py} | 14 -----
>>>>    .../functional/arm/test_aspeed_ast2500_sdk.py | 29 +++++++++
>>>>    .../arm/test_aspeed_ast2500_sdk_515.py        | 29 +++++++++
>>>>    .../arm/test_aspeed_ast2600_buildroot.py      | 41 +------------
>>>>    .../arm/test_aspeed_ast2600_buildroot_tpm.py  | 60
>>> +++++++++++++++++++
>>>>    .../functional/arm/test_aspeed_ast2600_sdk.py | 15 -----
>>>>    .../arm/test_aspeed_ast2600_sdk_515.py        | 29 +++++++++
>>>>    .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++
>>>>    10 files changed, 196 insertions(+), 73 deletions(-)
>>>>    mode change 100644 => 100755
>>> tests/functional/arm/test_aspeed_ast1060.py
>>>>    rename tests/functional/arm/{test_aspeed_ast2500.py =>
>>> test_aspeed_ast2500_buildroot.py} (74%)
>>>>    create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
>>>>    create mode 100755
>>> tests/functional/arm/test_aspeed_ast2500_sdk_515.py
>>>>    create mode 100755
>>> tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
>>>>    create mode 100755
>>> tests/functional/arm/test_aspeed_ast2600_sdk_515.py
>>>>    create mode 100755
>>>> tests/functional/arm/test_aspeed_ast2600_sdk_otp.py
>>>>
>>
>> Hi Cédric,
>>
>> Thank you for the effort in improving the test suite. The separation
>> into firmware-specific files makes it much clearer.
>>
>> This series is reviewed.
> Could you please send a Reviewed-by: tag ?
you did. I received them on my @redhat.com email.

Thanks !

C.



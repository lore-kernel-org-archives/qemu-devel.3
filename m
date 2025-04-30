Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28292C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uABdk-0002OZ-42; Wed, 30 Apr 2025 13:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uABdh-0002Ng-L2
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uABdf-00025v-Om
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746035670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EtRSIw/7c03sySOED15QlpoVCopZmTyUah0yCc8TNo4=;
 b=Ha1rgvdfvWRN1hNAFtyJSyeL5NfM2wpp6hbvIw/ZMdm3AEqPubhnJPWjTYxfXC0TahMy1H
 4CZs9BDJiWNCTl+CyfpX4BLMY8kzEgk05vqokoTlwYmORo7poOXj4JrBFSsVwoSquVLHDj
 z3MS6t9GzDDYCitr/3JQZahLtrRY4TI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-4COjHEMUN-WIfAmSySucLA-1; Wed, 30 Apr 2025 13:54:28 -0400
X-MC-Unique: 4COjHEMUN-WIfAmSySucLA-1
X-Mimecast-MFC-AGG-ID: 4COjHEMUN-WIfAmSySucLA_1746035667
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac6b047c0dcso9381666b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746035667; x=1746640467;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EtRSIw/7c03sySOED15QlpoVCopZmTyUah0yCc8TNo4=;
 b=f6NehlZeTP44PWeDos3a6RSgrGvxhGwROoTyhslZxKG4T09YTU/I3XJEu4VTzp+WRl
 boCsTvHg0wZOmXIowPiTvMBWctEcAQB+9BIvPppbCLDXBiHGD2YbX1HCRLBdhHd/D0Yo
 Pk+cqkR2o/Z1QnpoGMYJXJtHLnC7RJ7C5I/eNMc9m85+LjLlgXC87IlI9D17SARqo3oK
 XTxQOc7dYTKwpr6HBsBemU/o/jV8nUGwoWnvtUD0G4G6HHCFzMF+5Lbr0IeiX7asRR0X
 JlmZ5FfDRkWH+GDxH1Bd5B0blaD5cyAkzPGWgWZAPKWEI0RSO2WrweN0++MTzYK9n/kj
 bcfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULed3W7pY55PM91wlWnzFERNRMmxNGUeFfG7tC6pamyXY/Eq4pkFBlsmWgb9zFvRkkoYURhfGPYd1V@nongnu.org
X-Gm-Message-State: AOJu0Yz1XEZxelWD93KpG50zz0qqmDJ1aplmLxHCl4O+isubfePx0KYO
 UEBc+0+cvnV1yzCFiQmHIIA64Is/b/USzpBX0/WXx0AZ5U9ufNGGL2L3TQu9nPJsEMqW7Cm7mdw
 sUkvLRGdh4pARIZU51z3jw6zrS1mwGJ+J1a+ptpHj+38asNIvrZ16
X-Gm-Gg: ASbGncuw7RZMoFpgJHSTgKHpsfyfVPoVsqFQ/12ancA6vrLS/hvEqQQfLBYb7sNNXh0
 kK13VVXENuP/ndg71Qwpwexyj8mxO5jWSYYFsZknWQeBjMQV9Ek19zkwP1BfcwQKj7cZVmjljDc
 mWSd8vb3mmNNj5Hm1q1qjj2yDkzPwDhEAf39ARTkBPVaILAVbhYGZ1h/bsBsOC1Hfjr4o2XCeIg
 cDmTGnwZTekkK6rRVoUOc2POFVt75M27t9k0DUZ5pa0jmwpFfGP+3QglbNIfqK2RZXMYZgyFLq0
 mcOPSfN2ln7EiTFmX9kdkrgMKrsNOYs5K4T6LVen
X-Received: by 2002:a17:907:3da3:b0:aca:d5a1:c324 with SMTP id
 a640c23a62f3a-acee1f107e8mr400385666b.0.1746035667149; 
 Wed, 30 Apr 2025 10:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0NRpABOWlocOMVwaKOWN785WIxNP8mrvCXyMZgbrMJLLbEul5Xxv/FBDw/1FszBGevMyfhA==
X-Received: by 2002:a17:907:3da3:b0:aca:d5a1:c324 with SMTP id
 a640c23a62f3a-acee1f107e8mr400383266b.0.1746035666755; 
 Wed, 30 Apr 2025 10:54:26 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e4f8814sm968511766b.69.2025.04.30.10.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:54:26 -0700 (PDT)
Message-ID: <82b79386-ee34-4f06-8e61-76f47b4aaad7@redhat.com>
Date: Wed, 30 Apr 2025 19:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/build-environment: enhance MSYS2 instructions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250305213853.3685771-1-pierrick.bouvier@linaro.org>
 <b28bf347-aa8e-405e-8009-025aaf61a984@linaro.org>
 <88d6e264-4793-4095-8bb6-bc45621abeea@linaro.org>
 <06666850-90a1-4b4a-b454-53df477de215@redhat.com>
 <42a0987f-4f51-4d36-a3f5-1daf267c3e0d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <42a0987f-4f51-4d36-a3f5-1daf267c3e0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/04/2025 16.34, Pierrick Bouvier wrote:
> On 4/30/25 3:09 AM, Thomas Huth wrote:
>> On 28/04/2025 21.35, Pierrick Bouvier wrote:
>>> On 3/24/25 10:47 AM, Pierrick Bouvier wrote:
>>>> On 3/5/25 13:38, Pierrick Bouvier wrote:
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>     docs/devel/build-environment.rst | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/docs/devel/build-environment.rst b/docs/devel/build-
>>>>> environment.rst
>>>>> index f133ef2e012..661f6ea8504 100644
>>>>> --- a/docs/devel/build-environment.rst
>>>>> +++ b/docs/devel/build-environment.rst
>>>>> @@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
>>>>>     ::
>>>>> -    pacman -S wget
>>>>> +    pacman -S wget base-devel git
>>>>>         wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/
>>>>> heads/master/mingw-w64-qemu/PKGBUILD
>>>>>         # Some packages may be missing for your environment, installation
>>>>> will still
>>>>>         # be done though.
>>>>> -    makepkg -s PKGBUILD || true
>>>>> +    makepkg --syncdeps --nobuild PKGBUILD || true
>>>>>     Build on windows-aarch64
>>>>>     ++++++++++++++++++++++++
>>>>
>>>> Gentle ping on this trivial change for doc.
>>>>
>>>
>>> Another gentle ping on this trivial doc change.
>>
>> Not really my turf, I don't have much clue about the MSYS2 environment, but
>> since there were no objections, I can add it to my next PR.
>>
> 
> Thank you, that's appreciated.

Could you still please provide a proper patch description, as Daniel suggested?

  Thanks,
   Thomas



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982C9E74916
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 11:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYN2F-0007uX-Qu; Wed, 24 Dec 2025 06:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vYN2E-0007uG-BE
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vYN2C-0001GY-PH
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766575683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PZ6zn7R3wkNHiXaSnws4jtl1POCE4Crp3iF9ihMOQO0=;
 b=A3Q93gqIc7U5EkDr47Qozaquz2nevqnImbiiOQHgXBkwMGC3G+KbBDLbEdU/oFj9EeexB3
 lRFI2oDnhMWRUSjjf2wQbS7UZVRBCg+ZzhTyQQUUFt7rFjBzvod0E7Qwu0z2CeBehBUJfB
 iCckCvHPJTit2lvn/H/i+EHR3fBEKPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-sFPLuurjMoCSeCQGrj2v1A-1; Wed, 24 Dec 2025 06:28:02 -0500
X-MC-Unique: sFPLuurjMoCSeCQGrj2v1A-1
X-Mimecast-MFC-AGG-ID: sFPLuurjMoCSeCQGrj2v1A_1766575681
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so41419445e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766575681; x=1767180481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ6zn7R3wkNHiXaSnws4jtl1POCE4Crp3iF9ihMOQO0=;
 b=TABLQatLlg9wprz72X9sw++4q/vxQhtAE2caUePc9zWmd336CFPR6yNEnMrIW3u/au
 RrKLz/MMwxJlma7/tAw3sTVpJYIpCjWaesWtMSubqupOTb4UT4+Rh4YpUPUrn0D4ZFbU
 ZxnOYPPHClLhNH/VqILlwt1pt2IggerRI9McrAieE7lsnEr26YYQFyGDtF9iUWv0yDZz
 XZlC44Ael67NIbBPtQUmqagYKa0hOgbBTqN1eERB3goOzudYKReFdIoOPAzNteGNqS7i
 igPF2ztf5rtoVsFXTNHNIwIDhnx+/VyMX/Omq8nNMDrydYJ5fnZZUuDpmfmo4MXb9Azz
 MtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766575681; x=1767180481;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZ6zn7R3wkNHiXaSnws4jtl1POCE4Crp3iF9ihMOQO0=;
 b=ECtZxeN30p4K41JCTv7m9ZCN5PLXwcy96mas2ECYBPX6L/JiPoknIE+ISXUlhSnR6J
 6Eig+YAn2WOgIppU7Qsvqr5YAVjDqQcwckZBDwARGnoEs7NYspTUo/HsUjGC1VWQcoBq
 nrfbXS8vGcZK6HW3gC6CmtAQDwI4XY5/F4u1z3y1UMpensUFJsoOC49VRCrGTd0KYXSz
 eyZviel+xrlkSD8ry9KU7LdgUpUDcz8Im1cLE8Dm1M5be9O+K3TaGH8BrYFTaQzVDqp5
 4ftbE38b93svc7USRZ8oegKG/BoZS86p/EAkVB8FZsRNYqPbkFC857XfI/nNJuH/MquZ
 q+6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIyKRVzgK7i1POLcDQvb0ESSN6e3kQ2tXFRJz74ygLY+32gxGuFnGm5Yi19R6pmgZ9TZR6/SDN1AaV@nongnu.org
X-Gm-Message-State: AOJu0Yxhe4AnTdHUlLyMIgvGxWqgLhpJV2H+tQz4H16b07hfn+CY8QkT
 8py0jZLkjoAVfRAOfYQTiLZHLahzJDblwALG0rHVjHewcgJUtxDUEZb4EnVCxXfx8xGUh5dH/qc
 sUGKarGfOlOUhiJSsoQjS7faomXCLnUwS+QYq36XMMqhdjIuDbxNodrVp
X-Gm-Gg: AY/fxX5j6QYQjCVGdtYF5cFf07Qz/At3aRilnuD2cb9tMX9UaB9hwZckR4dspKTCN7S
 7b1B7BTFtAeHzwCB2+GBPfuH68Z/eh6U3BeFw7MY97u1T+TvP+grXlucO/sH2fvfwLwqXhJ1eUz
 Qr2eYBVl25hdDBpTKSDlarRV78IgClOFQB/oC9LX4+GgnM8u/Hzg6BFDsF7MRn6lafOdXyKGGMT
 fzZYoNZhGIwgAGJC4yU0ivCtw2tEGHc6H0omMaCsDqsEKhr/xWn+GsjYObZNELrUJgltI9VRJ0q
 pBDJ/QSDr1XQaHk5RUbk1+J2yhXwigcQZgzduQl68QNzRATxQ0rDoWKxNRUij+8jKkhXY5fASsq
 Gl2X7sXA8YryAiShnYzng8ZBgMKaZG3cYsDvfXmiGKC0b6A==
X-Received: by 2002:a05:600c:470e:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47d19589469mr172088185e9.26.1766575680755; 
 Wed, 24 Dec 2025 03:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTd+8MJOWofRB0LqSyuU5kysEmhtxmNxhdusjwGuZO5pFHGEc2jZBVXtO3TYDN3sGZd7B8ZQ==
X-Received: by 2002:a05:600c:470e:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-47d19589469mr172087895e9.26.1766575680352; 
 Wed, 24 Dec 2025 03:28:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:107a:63db:9521:6057?
 ([2a01:e0a:165:d60:107a:63db:9521:6057])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193e329asm291537125e9.15.2025.12.24.03.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 03:27:59 -0800 (PST)
Message-ID: <b97c1b53-4f57-4b98-b1a9-c8c7b5367f87@redhat.com>
Date: Wed, 24 Dec 2025 12:27:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix URL of gb200nvl-bmc image
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Ed Tanous <etanous@nvidia.com>,
 Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251222073351.166720-1-clg@redhat.com>
 <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com>
 <589ced7e-0ad5-45cc-984a-102552cc8b5e@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <589ced7e-0ad5-45cc-984a-102552cc8b5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 12/24/25 11:51, Philippe Mathieu-Daudé wrote:
> On 22/12/25 13:52, Cédric Le Goater wrote:
>> On 12/22/25 08:33, Cédric Le Goater wrote:
>>> Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
>>> the associated functional test. Fix that.
>>>
>>> [1] https://github.com/legoater/qemu-aspeed-boot/ commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a
>>>
>>> Cc: Ed Tanous <etanous@nvidia.com>
>>> Cc: Patrick Williams <patrick@stwcx.xyz>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   tests/functional/arm/test_aspeed_gb200nvl_bmc.py | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/tests/ functional/arm/test_aspeed_gb200nvl_bmc.py
>>> index 8e8e3f05c1b2..e5f2dce0f569 100755
>>> --- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>>> +++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>>> @@ -11,7 +11,7 @@
>>>   class GB200Machine(AspeedTest):
>>>       ASSET_GB200_FLASH = Asset(
>>> -        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/ master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl- obmc-20250702182348.static.mtd.xz',
>>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/ master/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image- gb200nvl-obmc-20250702182348.static.mtd.xz',
>>> 'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
>>>       def test_arm_aspeed_gb200_openbmc(self):
>>
>> Applied to aspeed-next.
> 
> Thanks, this is part of the 2 build failures blocking current pull
> requests (other one being
> https://lore.kernel.org/qemu-devel/20251224085714.83169-1-philmd@linaro.org/).

Thanks, I was going to send an aspeed PR yesterday and then, I saw
the tests failing because of the missing v5.0.0 machines.

C.

> If we really want to consider our CI as source of truth (and blocking
> when not green), then please consider applying it directly on master
> as a build fix (maintainers Cc'ed).



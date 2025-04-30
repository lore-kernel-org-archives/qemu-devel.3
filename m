Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31ADC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4Nt-0002mn-Iy; Wed, 30 Apr 2025 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA4Nd-0002mJ-FX
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA4Nb-0007tJ-Iw
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746007766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nEXwRBGZ/dtdtNRGKgE/34N1gqkxrrK4jcQDdJQA3cA=;
 b=beBY8CRZcwG0iIEKiyVpwV1KO0m+F/clZwTc29lKLr+euhBH3EMHJFBIF1pQOOcfJBvQQf
 mWySUx9FLAS6tEfVBMkz7uqS17hCk/aE6zdZYR5BrPdRI+6Fcs2Dn9VX/WxJHVnxvkhg/+
 e0FIeizgbpZySQ7gTE7VgAOXC4SUWhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-8O2kriBwPCSIAa2tcqSUsQ-1; Wed, 30 Apr 2025 06:09:24 -0400
X-MC-Unique: 8O2kriBwPCSIAa2tcqSUsQ-1
X-Mimecast-MFC-AGG-ID: 8O2kriBwPCSIAa2tcqSUsQ_1746007763
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so38458065e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746007763; x=1746612563;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nEXwRBGZ/dtdtNRGKgE/34N1gqkxrrK4jcQDdJQA3cA=;
 b=w8Sf5FWg4TgZ+yd+qGEXcko1za2sRSoClGxrMw9D+KWgcTWNxleNqbzVzcylkiirJe
 n5zxSkMw2SQbM/DdlxlfJZkBVxaKfnEFBM1eFIyyrRRBGRRpyJLnzu9BhE4RwobsTUfW
 TUkEIBSxzMo3ynWtK6kNL3wjM8qAKbMvrKYPRZLpgtf3RDyr6zT0HKRxrucXc+Fnrx9B
 1KU0yTBfHzOo7r/AYNS0C6ZRdPi8emhTCOGV3RSbBDPJ/Ls/rM/jNXE3BYw3FP7YkaQr
 Fi4wbwHoisdN0s5LkyTD6xl40a4UQ90vQTlXinlHrjFd31ovTSAmLEuep2TDwPus0USC
 vtbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ep2XTw3aTQV/fJyb6VwdVd3BokEqfcMrhz/eChDlxbmfxt2LJH09smXkoiVw0ZOoAQywUl+ip0jZ@nongnu.org
X-Gm-Message-State: AOJu0YyRYNoemnGvX2DpkMEl3BbDyDi/by0gnwsYWoREu5xPP59Qwz2m
 M9sABWMoiOfWbnBPZN8dw6/x7wAlNMfJyKVdncJQB0k0ktWEGOsWaPEWGwvkQKUsulqJxTYzDAt
 GcMX+qvjxudhUnzlAalPwtRMernAMynhoaoQHa+q7zXmpvE3GWyW6
X-Gm-Gg: ASbGncuw4h661m6GF7X5g7Y7KQK8aYHQ/9+fb7GjDxTbKJxVPvH5Dtm64KCtep4SDo8
 7IszF4Vb7BLVCYLyZ8309VJvmiNJGpvNe/cMCfo5PVHC/80GxQPAvvv6+Y0jMIzuxASlo5Z88ZU
 NHzdWitBL7sK8aeAKdvPTI1y/JTgJEItsmKq6jxI8PWdaYXJl/gaNwH0ovgTg0KOt9UetOpfGkg
 aBgHK1gEhqDCK2nBj0Tm3W8S5YEtC37WEYbf+6dUp6957/eilJWlg6ReClolm6xpixoCjLYRDnB
 SCAM7m06DiKk4GwJ0hpybV0rwgc/fSa+bnlNI1Yf
X-Received: by 2002:a05:600c:1c21:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-441b1f3a3f2mr23743125e9.15.1746007763436; 
 Wed, 30 Apr 2025 03:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuMrhqSmqC6JYgThXx1apTBwLiTTehuBiMB+ySfVHxgOBwtKoqV2U4dxMRVlhGHNAfG7kPMw==
X-Received: by 2002:a05:600c:1c21:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-441b1f3a3f2mr23742805e9.15.1746007762990; 
 Wed, 30 Apr 2025 03:09:22 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b3ae0c19sm11942275e9.24.2025.04.30.03.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 03:09:22 -0700 (PDT)
Message-ID: <06666850-90a1-4b4a-b454-53df477de215@redhat.com>
Date: Wed, 30 Apr 2025 12:09:21 +0200
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
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <88d6e264-4793-4095-8bb6-bc45621abeea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On 28/04/2025 21.35, Pierrick Bouvier wrote:
> On 3/24/25 10:47 AM, Pierrick Bouvier wrote:
>> On 3/5/25 13:38, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    docs/devel/build-environment.rst | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/devel/build-environment.rst b/docs/devel/build- 
>>> environment.rst
>>> index f133ef2e012..661f6ea8504 100644
>>> --- a/docs/devel/build-environment.rst
>>> +++ b/docs/devel/build-environment.rst
>>> @@ -97,11 +97,11 @@ build QEMU in MSYS2 itself.
>>>    ::
>>> -    pacman -S wget
>>> +    pacman -S wget base-devel git
>>>        wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/ 
>>> heads/master/mingw-w64-qemu/PKGBUILD
>>>        # Some packages may be missing for your environment, installation 
>>> will still
>>>        # be done though.
>>> -    makepkg -s PKGBUILD || true
>>> +    makepkg --syncdeps --nobuild PKGBUILD || true
>>>    Build on windows-aarch64
>>>    ++++++++++++++++++++++++
>>
>> Gentle ping on this trivial change for doc.
>>
> 
> Another gentle ping on this trivial doc change.

Not really my turf, I don't have much clue about the MSYS2 environment, but 
since there were no objections, I can add it to my next PR.

  Thomas



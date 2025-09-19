Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EF5CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXjS-0001fo-7n; Fri, 19 Sep 2025 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzXjQ-0001ew-Bk
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzXjO-0003S8-3r
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758275320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KWFgdFGfHpFrX4XmqitwqkLXUsnYr3nv6eKS5SUMuuw=;
 b=bErcACrt73Nu69PIs6PNuTiXTBXhAENwkrf78R0PbtVKdY4x45HggUlNMRifIb4W005PBu
 2EoNCCzuvl6akNRh0jK1XJfOSAoa0IWDAqNZLnCQ3WZl96+D+/t3PnbcF7b09a2y0CyIFj
 2Y8kC/UEtySQe0ujWh4z3A065XQ0s2Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-fyz-KJlnP0-7H4nMpg7LmA-1; Fri, 19 Sep 2025 05:48:39 -0400
X-MC-Unique: fyz-KJlnP0-7H4nMpg7LmA-1
X-Mimecast-MFC-AGG-ID: fyz-KJlnP0-7H4nMpg7LmA_1758275318
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aff0df4c4abso172912766b.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758275317; x=1758880117;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KWFgdFGfHpFrX4XmqitwqkLXUsnYr3nv6eKS5SUMuuw=;
 b=VKs/YIyKNxSZffDhq9M6LtoKjsrwpG18nVgtThtzHr9rfgmJqaYjnQOw643FByWaRe
 XiuDRGQwUM7k/LY+AXw1No5BawUySslJxmiiMPSxaIaeklUy14cgVDtcukPosNg/So8i
 th82pwwwf0jluscS+WBOFb11+1jW4Tgg/sR20SJr3bseUfTPvSkAVJayd7f4BG6lypkm
 nDc8pmYL+GrbXOo7CvUoEpOKiIYIrXpnpiJs825czexHiL4tRADsZ88v2xQmLJLY1r9n
 NZuBLv8Uy2fBO77AEiDFijdTAE+0qh4nFo+DnBzJtqcU8Gl/badp+zJQgHEdio+LPtbP
 lISg==
X-Gm-Message-State: AOJu0YygsNpBDGuNs8GCDdiH6I5GOKLKjdgadGvd4aWzA9VRzFFdfCdK
 i5C7Kj4A086rS9YgJhba7/o/btGwZsEgt2h5Gd1UzcWFOvG1A8/B9JEJgzX+4q9zvummLyXg1f0
 SRZ33F3PduNoptFe3WF7pVRAKvzU+PS9msY19dk9eguWdg4XCOGO0/pOClbQOt1UO
X-Gm-Gg: ASbGncsT3IIuj794g594qoAuiv6QD7fp46UTlN/GZeETYbzUcLIQPWoM15ZUBmO3EuP
 YRxG3cpaQN0U8P8OFVGu9IErX/7p5bo8xnz9LsTh9qKoxqmUc5K6smxhs4rwId3cTfMvn5aZIlh
 X6D/JZSEvgEswYAGRDhlhxsx44DxoVwhVJacWJTrXtQUbR/Vf0Q064FH50adBCCO8AAO/XnFgAs
 vhU+r/ZXJuoY6tO96UNoe3DNc+jY9VpCCHLwsk7wkKQ4nR2dAeNxTKbScUTmffyPJ49mNuG3TKg
 yKFM4zTCwK9LpobJSnn4gxdIzD0Wvw44ISXJfm1d6qu1Br4Ckp8h/cfD6fXoHUV4fGRVZcoQNjz
 YJWz8AFydx4DYTctkb9dVQddKyj3h5PUfsL+ctXn2V/7fkQmwwZ77ArWN0gyxgwuis35mtSx95L
 5Rk62K
X-Received: by 2002:a17:906:c155:b0:b24:3412:7cfe with SMTP id
 a640c23a62f3a-b24f5b59e7dmr240522366b.63.1758275317294; 
 Fri, 19 Sep 2025 02:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH0OLpjKTkuSjCPUwnkf6u5NLD4XQDvXvhU9BiGgZ5da3xVY1N3sgEv2/38EoUl0uNCIjpAA==
X-Received: by 2002:a17:906:c155:b0:b24:3412:7cfe with SMTP id
 a640c23a62f3a-b24f5b59e7dmr240520866b.63.1758275316850; 
 Fri, 19 Sep 2025 02:48:36 -0700 (PDT)
Received: from [10.108.146.123] (93-45-222-212.ip104.fastwebnet.it.
 [93.45.222.212]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b25edd997d6sm102004666b.35.2025.09.19.02.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 02:48:36 -0700 (PDT)
Message-ID: <5756d351-e1d5-41b5-8cec-bb30a6bfb2c2@redhat.com>
Date: Fri, 19 Sep 2025 11:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: use the pyvenv version of Meson
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250919083621.86615-1-pbonzini@redhat.com>
 <aM0dPwlABhxqsT8Q@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aM0dPwlABhxqsT8Q@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/19/25 11:07, Daniel P. Berrangé wrote:
> On Fri, Sep 19, 2025 at 10:36:21AM +0200, Paolo Bonzini wrote:
>> The version in the system might be too old for QEMU; this will be
>> especially true if Rust is going to be enabled by default.
>>
>> Adjust the docs to suggest using pyvenv/bin/meson.
> 
> I presume this is essentially changing the docs to match
> what our "make" wrappers will be running internally ?

Yes, they use $(MESON) which is /home/user/qemu/build/pyvenv/bin/meson 
or something like that.  I made a mental note about this last week, 
since you and Thomas mentioned it.

Paolo

>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   docs/devel/build-system.rst | 2 +-
>>   docs/devel/rust.rst         | 2 +-
>>   docs/system/devices/igb.rst | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
>>
>> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
>> index 2c884197a20..6204aa6a72e 100644
>> --- a/docs/devel/build-system.rst
>> +++ b/docs/devel/build-system.rst
>> @@ -450,7 +450,7 @@ are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
>>   with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
>>   tests for all targets.
>>   
>> -If desired, it is also possible to use ``ninja`` and ``meson test``,
>> +If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
>>   respectively to build emulators and run tests defined in meson.build.
>>   The main difference is that ``make`` needs the ``-jN`` flag in order to
>>   enable parallel builds or tests.
>> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
>> index 13a20e86a16..2f0ab2e2821 100644
>> --- a/docs/devel/rust.rst
>> +++ b/docs/devel/rust.rst
>> @@ -66,7 +66,7 @@ __ https://mesonbuild.com/Commands.html#devenv
>>   As shown above, you can use the ``--tests`` option as usual to operate on test
>>   code.  Note however that you cannot *build* or run tests via ``cargo``, because
>>   they need support C code from QEMU that Cargo does not know about.  Tests can
>> -be run via ``meson test`` or ``make``::
>> +be run via Meson (``pyvenv/bin/meson test``) or ``make``::
>>   
>>      make check-rust
>>   
>> diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
>> index 71f31cb1160..50f625fd77e 100644
>> --- a/docs/system/devices/igb.rst
>> +++ b/docs/system/devices/igb.rst
>> @@ -54,7 +54,7 @@ directory:
>>   
>>   .. code-block:: shell
>>   
>> -  meson test qtest-x86_64/qos-test
>> +  pyvenv/bin/meson test qtest-x86_64/qos-test
>>   
>>   ethtool can test register accesses, interrupts, etc. It is automated as an
>>   functional test and can be run from the build directory with the following
>> -- 
>> 2.51.0
>>
> 
> With regards,
> Daniel



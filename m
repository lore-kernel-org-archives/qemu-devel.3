Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B069E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsg2b-0007YC-2J; Wed, 18 Feb 2026 06:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsg2Z-0007Xy-86
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsg2X-0002Ry-E6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wUT/HvBgcdIQYDEH3dIfDECP3bZ50fAQPAd2dGjtrU=;
 b=AGCNspf9FxidaiOMINXLupD8bC7Id1B19Kf1DmlRL+Qz8zAL2YwmZkPHLvraIjnX3cN0ha
 ftwu3fjr4CCOXQwNczUi63Qz9lz+wBGel+9BaW3etzn50IzCoFTKuBhsx1JttLwgjn1LFC
 Yc93UOac2Urh/Rwf0NIKRsfH+aDTgzU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-k_YIK2T4OmeB0GHzwRboow-1; Wed, 18 Feb 2026 06:48:18 -0500
X-MC-Unique: k_YIK2T4OmeB0GHzwRboow-1
X-Mimecast-MFC-AGG-ID: k_YIK2T4OmeB0GHzwRboow_1771415298
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435991d4a3aso3104281f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415297; x=1772020097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wUT/HvBgcdIQYDEH3dIfDECP3bZ50fAQPAd2dGjtrU=;
 b=OWrBYZB75ck0wJhT3J7UBoGXxjJXvGZpl3I0xR3b0kyxjNWJDde3cdEis8hXrHKGij
 TfAaJOFpGk7b5iNxePqxfXetzL1FK6ZQlm35t7x2L33lYSt3e0aTH602GDFwsdqM71Ci
 tCyBIqYW6ZWt2LAjqC/IdxptUeTGlDzEfenXRWc9/QE7M+1BgKfMsDDKpHMpsWn0KphZ
 dwFYPhk47Q02xQ2rt+851lDMBk6072STBQ5J+NuLS03WVG3hkVRT6R7bj8TvZ/2uNybq
 cySPcVXMMm9MW+36NN038H0995o8XaYMHhHhWQCjg/wRZnh4xBV2CrucU1gwi4o3NuDh
 /hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415297; x=1772020097;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wUT/HvBgcdIQYDEH3dIfDECP3bZ50fAQPAd2dGjtrU=;
 b=C72M71jqohCmswfDCXrjiIcigOJTiyG5JWpKAy9XEDDvXQnqaz+2cS/E1Dw4S5V+DR
 yZUxmYdpb146qeCl9J3uEy+Lo7WqWzCk5uTh1MQmylc9++PO6rE9o5jmTW5LC17Hbjj7
 wk3R0tLbVXgSKAq6TR6zFwBUhY1xVT07KWhFmU4sx099IEZkgXjMFmXYcBYzOExP9Fb7
 ZI48VJs2jRHbPBVE4439YeFnww2jxEGzW+N2zZPE15O/lJES3HyTc4nxdMUSwdDEUe4l
 bdJCo2bKt0OTX7/+OpB8jxGf4CpfGJxU+p2cMUr6rhWEErv6MDMy93Lf0izxZpW2swdF
 y0sg==
X-Gm-Message-State: AOJu0YzuhjhCmbpTh5hk6+Qnzk8CBf1vfCR+Wdbh6kHAO9QM0P82dJYj
 wPCOaUs1fXziyq7aby1PxgBJ74pXOwNCj56XOHoGjtyDd6a8D59CZXtC4qYvqqLebfTIHMRhyIG
 xfh4iNqHECcYaxAmo5dFjbqMO4F1xbEhwfsXPUHGmVWAg2JmwSLrzNK0l
X-Gm-Gg: AZuq6aKz8HDxtnA4vAJZw/SFM49zHP2LeuhgbrQIjGcTvZqzsMZGLF6Hk2YVEeY3hLU
 WnbHiftTVJmCFx09SrBOZ2uyJcrathbIAM2DeRkAN5U0e1ZtocEAtIerI/nFSTirK1dbszRCXag
 JwzOuEkqoRDoEL1X1fm5l33GpzwhXTFTBzYwv98fImH1ePCT7vpwaS9b1BxFzpLZ8blS7ed1zBP
 O2EFZMctLZTo2reXPQGPvBdh3e5cl4uLELbq2PXfgRfbN4GA5Wk/xYtTV5gtWhWjoCa5zUoRBE/
 uFvRbFsGuAmaaasGZ+4r3Qxzoa5Nn0Bm9cOBDpsiIwkF7TjE4ajqM6tOjBvZJy616jv2cib8O2C
 mxT4VWMfvjc/KFY1kp6ug3qU3Xf6+/vDNDNalqSuM9RcRuK45ij1c/P+mn1KX5QEesJ9dMWvKtt
 NYn70Z6owOXkahL2+MwBaZrZ2YWug=
X-Received: by 2002:a05:600c:1549:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48398adc614mr28445635e9.24.1771415297473; 
 Wed, 18 Feb 2026 03:48:17 -0800 (PST)
X-Received: by 2002:a05:600c:1549:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48398adc614mr28445195e9.24.1771415296937; 
 Wed, 18 Feb 2026 03:48:16 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm791857055e9.6.2026.02.18.03.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 03:48:16 -0800 (PST)
Message-ID: <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
Date: Wed, 18 Feb 2026 12:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CentOS 9, Python, and other Fairytales
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Daniel_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87wm0afsnh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>> With most of the new sticking points being debian 12 (EOL in June) or
>> FreeBSD (timeline uncertain for when they'll re-modernize their python
>> stack)
>>
>> One edge case here, however, is Sphinx, which does not actually have a
>> modern package in centOS stream 9.
>>
>> CentOS currently ships 3.4.3, but it would not be usable if using the
>> optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian 12
>> have sphinx 5.3.0 to offer us, which is a reasonable version jump, but
>> it means that CentOS would not be able to build docs unless you
>> enabled `--online` for configuring QEMU or sideloaded Sphinx
>> otherwise.
> 
> CentOS 9 reaches end of life on May 31 next year.  I do not think
> keeping its ability to build bleeding edge docs offline out of the box
> for its final year (give or take) is worth your time, or anybody's.

That's exactly the reason why we (John and I) introduced mkvenv.py, 
except it was CentOS 8 and SLES 15 at the time 
(https://www.qemu.org/2023/03/24/python/):

"Some of these tools are run through the python3 executable, while 
others are invoked directly as sphinx-build or meson, and this can 
create inconsistencies. For example, QEMU’s configure script checks for 
a minimum version of Python and rejects too-old interpreters. However, 
what would happen if code run by Sphinx used a different version?

This situation has been largely hypothetical until recently; QEMU’s 
Python code is already tested with a wide range of versions of the 
interpreter, and it would not be a huge issue if Sphinx used a different 
version of Python as long as both of them were supported. This will 
change in version 8.1 of QEMU, which will bump the minimum supported 
version of Python from 3.6 to 3.8. While all the distros that QEMU 
supports have a recent-enough interpreter, the default on RHEL8 and 
SLES15 is still version 3.6, and that is what all binaries in /usr/bin 
use unconditionally."

So yeah, there's precedent for doing this, and it's the right thing to 
do anyway.

>> My plan:
>> - Wait and see what happens after the current QEMU release
>> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
>> - Gleefully drop Debian 12 in June
>> - Hold my breath and see if FreeBSD happens to modernize by this point
>> (They have until October 2027 to do so, so it's a dice roll if they
>> will or not)
>> - Do a big round of Python modernization all at once; either to 3.11
>> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray for
>> forgiveness that I am removing CentOS stream 9's ability to build docs
>> offline so I don't have to wait another six months and then do another
>> big cleanup round

The main nice features of 3.12 are improved f-strings, which are nice 
but not really a necessity.

If I read it correctly, https://www.freshports.org/lang/python says it 
has 3.9 on PPC and 3.11 elsewhere, but 
https://www.freshports.org/lang/python311 says 3.11 exists on PPC as well.

I'd go for 3.11 and Sphinx 7.  For FreeBSD we can require Python from Ports.

Paolo



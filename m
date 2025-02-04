Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB69C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGTd-0004OU-SI; Tue, 04 Feb 2025 05:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfGTZ-0004MM-4o
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:48:17 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfGTW-0008AT-Nv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:48:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4368a293339so62719185e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738666093; x=1739270893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4hATsIhAPEZ088vEoX0wRpa5znwmory8rQu1kxTiuaM=;
 b=A0lLx6D5h+DNJOhilhD3Y/ZfMgluw0FV5sPCZSA4XZQvkrWG0zkow4xhKY/G0cCYbe
 kIjEMs3KZsTn7WhhJ5NvhPja6CfC5MASIg0cIsELEHrRZxEOCDwppNZd6mgQifGhA3sh
 8xLBKBStkKpRYiJlhnyO++mdrNjNuL9+u5D/P7hQHqSD8C5p3qQLB8fv+Xr9oEDxz/Qx
 4tSCzaUIxVewKy59YApfDTOvIBqE9ETR9Qo3gFiMLsXHbKYXNYHl7WvTUchYU2oimhuT
 UuDjrlHz6ubsjO5ecLRYIPF2+zJ9yKtcJxCS+Dl7832+hFyUSoGB7tFHnlpd2bIDNoib
 R5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738666093; x=1739270893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4hATsIhAPEZ088vEoX0wRpa5znwmory8rQu1kxTiuaM=;
 b=l6wB9sEGDEJRj6bFqeDjeKwpPladNzSgG/+qigMTSBrFiq+NKLbv90cxUXkn/rDuhy
 mFmHWvzkzBdrGdnaCtGxbDsj4CEDf0JuGEOj6oAhM/Gx+2kYfqhFvs5aZIPYuY3afGfq
 t5smsOoOWA65KYGnuOLkk8SAaLnvivNTl3Zu+XO3Y3pRXuUaoo66nHjGlmjlpGWRzQov
 tHBdMkZr5p7sm1CQN9c/G7Sv4XU3hjEjNM5alri4ABXWJgyDae+1rK9pWzri0RDpZo3d
 EnE3W5MxrVQCR01mwYa6kOnU0bWg4L5MTFx7EDM3cAuwVlrQUCqSzmMsx5PnTjoLim9t
 +54Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNfMAYj3dr2Kc+tPzsLOKGsRmt02InTShWkGPX+WVrLJq+OTwRn/nDkJP+ZpVIGjDQ3WuTM4v3U1/M@nongnu.org
X-Gm-Message-State: AOJu0YznKwwoU2wOf7o+u4CIOZJCcaLI0ADp7gtSFDke7UlpGL4wwgOU
 bygzeG7a9oqp7/THuZ4FsAnBL2Mc7YCPArWGtXXe6uE7pHr1Z/tNbqKNoyz3zfg=
X-Gm-Gg: ASbGncuRIK/R1kjD7ENEyAZwERc9nSh8DtgxAORMktaUnXfRKkmJP3TVgMh6WKPqhBq
 2bRvqNHR/m6/BTjhAvfKWVE81zlLztIj4q5C6aJduL3UKi4vkykyF49YmLOHt/eMTQ9GnMmWtw/
 1TJEV0dnUKiLW48KZXHSp2nvNl9T3WK5JC7lm6NySmFLBN9KneMVyeSu9IUl5+gK24EBH7B/X60
 METq9lnE/giJzu2ZawtChhp6F2cRFbpvjekjtxYcar52MuGR0VnqqPiO+Hi4CFw/JcNKrK2OE23
 FDyycgWe7gQmSwyYPeEhqG+3DzVAWbztx9dV0X3b5laGidLOCbmRtA==
X-Google-Smtp-Source: AGHT+IFFiKgC/r4IEwG8B5YHkgiXLjbxAbGsXv2FjurSHxT9Hqm874wbeDOkDWebiML/nA+8Z0aIeQ==
X-Received: by 2002:a05:600c:ccc:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-438e07cd868mr179529545e9.21.1738666092864; 
 Tue, 04 Feb 2025 02:48:12 -0800 (PST)
Received: from [10.53.21.213] (88.171.88.92.rev.sfr.net. [92.88.171.88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42dfsm189380995e9.4.2025.02.04.02.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 02:48:12 -0800 (PST)
Message-ID: <18ebe0c3-7ae6-4ba4-92f1-452a613d2c8d@linaro.org>
Date: Tue, 4 Feb 2025 11:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <Z6HklNsu0Mzgh7bC@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6HklNsu0Mzgh7bC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/2/25 10:57, Daniel P. Berrangé wrote:
> On Tue, Feb 04, 2025 at 10:51:04AM +0100, Philippe Mathieu-Daudé wrote:
>> On 4/2/25 10:22, Peter Maydell wrote:
>>> On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> All previous raspi machines can be created using the
>>>> generic machine. Deprecate the old names to maintain
>>>> a single one. Update the tests.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>>> index 4a3c302962a..c9a11a52f78 100644
>>>> --- a/docs/about/deprecated.rst
>>>> +++ b/docs/about/deprecated.rst
>>>> @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
>>>>    Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
>>>>    CPUs. Big endian support is not tested.
>>>>
>>>> +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and ``raspi4b`` machines (since 10.0)
>>>> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>>> +
>>>> +The Raspberry Pi machines have been unified under the generic ``raspi`` machine,
>>>> +which takes the model as argument.
>>>> +
>>>> +    - `raspi0`` is now an alias for ``raspi,model=Zero``
>>>> +    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
>>>> +    - `raspi2b`` is now an alias for ``raspi,model=2B``
>>>> +    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
>>>> +    - `raspi3b`` is now an alias for ``raspi,model=3B``
>>>> +    - `raspi4b`` is now an alias for ``raspi,model=4B``
>>>
>>> This is not how we typically handle "we have a bunch
>>> of different devboards in one family". What's wrong with the
>>> existing set of machine names?
>>
>> Zoltan and you don't want to add more machine names, then you
>> don't want a generic machine. This is very confusing.
> 
> IMHO we can have distinct machines for each model, but
> *NOT* have further machines for each RAM size within a
> model.

Got it. Unfortunately I spent more than my hobbyist time credit
doing this, so if I find the motivation to revisit, it'll be later.

Still, having machine memory size depending on the host config was
a bad design choice IMHO, as we test different setup depending on
the host being used, so not really a "reproducible" setup.


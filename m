Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA88D3ABEF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXNA-0002hK-0G; Mon, 08 Dec 2025 04:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vSXN7-0002ga-JM
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vSXN6-0001SD-1H
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765185451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mMfOm0Le5aQnjsxyV555d1Y15Qv24lf+9uf2JyhTpsc=;
 b=c/pjghXQauT9pr/X/cnpmZNY6KV13tElUbqVJdkEoLpGMr0iV2r5l8vF4addWp4V8nDNWI
 1M+NkiNTwTnTLZIjuI5Tulxa60p2X5VogGuX7KLKrq77pxSTiqQEy0iOFjjeXKat7ECHvb
 NhKKfNwbBj8uXAJak+TQOOUauDJibMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-Wueet2n4PHuUsp_duuvuYQ-1; Mon, 08 Dec 2025 04:17:28 -0500
X-MC-Unique: Wueet2n4PHuUsp_duuvuYQ-1
X-Mimecast-MFC-AGG-ID: Wueet2n4PHuUsp_duuvuYQ_1765185448
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so46714325e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765185447; x=1765790247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mMfOm0Le5aQnjsxyV555d1Y15Qv24lf+9uf2JyhTpsc=;
 b=lfRn0L9iGBectal+J5vFu4BxtjKoEjbIKUHYPLxQD/5KLlwD/DbDSSpYTwUInWstWf
 Mhz2ZpxsO7CtT/WIzeqrB40ALt7pz91xDTEhA5udYv6bB3Cf4q1QuJK7CrKpuk984i8Z
 UG2HXLcK6b3GSqGr69UITCdZU68H4RzK0ovMQeyEUwLObskYqCZwfUtU9x51HqnHhmcN
 TpuVDjOOxblXVK3nUqpFeTJ/VxGdWohn20CFU38ZD7NTcC8tAF3/Ry912ofGDhQndLn0
 gyPL2gTDEz7MO8XwFwrgXejOxVmaR335hX/DS0S38UVMggUOYQc33cUO/qMLQ8lHYZZO
 RFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765185447; x=1765790247;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMfOm0Le5aQnjsxyV555d1Y15Qv24lf+9uf2JyhTpsc=;
 b=u+RH80mYB2olnGvTNa9wqfrgAQrriKYXVisAW/QeDX+mkAs6cTBeJtI3Z4F2p1tPs+
 sEV3B3HpnEY3nSMR4iubP77iUSXQp5HyiIbYKo8rbbwSmqVxyDgeJCl+T2nLLxSvRE4Q
 wL2gQske7YhaXVEoTJxdGpdsg0s6WLVbb7RjCHPm4G3pvSJbwBbBcPMwpN9HLy4lQHKr
 ytlT5OWNvY7hTXLsOotDoCs5t4uaaqLjkNbh3f151ABeUAtzVkwIqfmq9hOzwxrZe9F9
 +nVh1xU+qg4UmheRlthMaVa5pPd5ipcMcAYopr0MdvCx2hPn/qeEXzWUuVUjeDhLGeiv
 LeUQ==
X-Gm-Message-State: AOJu0YyGbLt9+AF/lRUm+LCrwmxPRKyuFNwz4rFuiCXIGM3GSiEdmnmi
 YMcxLLNy48zQXViTGDzbmohgQf+lRb+eA8ZVvuS9LcFwoVAyoputN+GaOKs3Vsaqlmzh93qb1Ek
 FYhZM1+Mvms7cOJ0zf+nNbtoeTucDTMYzejYJQYNP5VFevkdoYDXKK7Qz
X-Gm-Gg: ASbGncsL2XK9P2Xqc1a+fgHONWK3q4rSSiDaaVimWp3TKDyREgjYKOW42+aQLqJtvx9
 YR5Cdi1HoC7TlPBmirqHnijFLZhcYn+MragGzYXbeMd85Y+om/pW0UhzKOBAT2wIzI/6FbzpVKI
 JsVLmIUrCAOcxLAoc2/zYXf470gMNtdyZekuoRyZoF/pp1U8OpA5sxpAUXQFRokp3PeLtRZkkjY
 x/s/ROJv9Q4XokyeknAPSOhtMSTu+N6p3mnQxqIPMDDB+KtSmiFnrpuiDxTCtnSQR7Z5PSCN898
 N2tKIydGG7Imvh5EK+U2WrtmMd8d/m/cJ9XMRDh6TUxrhmzIz8+34oj/05CvA028y4mASJ4TXiv
 uMgO5o2w=
X-Received: by 2002:a05:600c:3b07:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-47939e242f1mr79396745e9.17.1765185447585; 
 Mon, 08 Dec 2025 01:17:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuOPa9OP20mU/p7l/NCVgn+7uarGMEGww/IoZGOWxGExVH6mNgJR1K03qjRmIGkaPUhQ9uqg==
X-Received: by 2002:a05:600c:3b07:b0:477:1af2:f40a with SMTP id
 5b1f17b1804b1-47939e242f1mr79396475e9.17.1765185447124; 
 Mon, 08 Dec 2025 01:17:27 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47936f651dfsm181005235e9.5.2025.12.08.01.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:17:26 -0800 (PST)
Message-ID: <c212c31b-e927-4083-a3a9-977625a3d30d@redhat.com>
Date: Mon, 8 Dec 2025 10:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] tests/lcitool: add nettle to the minimal deps
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-6-alex.bennee@linaro.org>
 <f077e5e1-53b7-42d8-b457-90fdf775c71b@redhat.com>
 <87a4zxrt5y.fsf@draig.linaro.org> <aTaWTJTWcAXO11Mc@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aTaWTJTWcAXO11Mc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 08/12/2025 10.11, Daniel P. Berrangé wrote:
> On Fri, Dec 05, 2025 at 12:48:25PM +0000, Alex Bennée wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 04/12/2025 20.48, Alex Bennée wrote:
>>>> Technically we don't need a crypto library to do the base build but
>>>> I couldn't see an easy way to skip iotests which would otherwise fail.
>>>> Besides libnettle is a fairly small library even if its not the
>>>> fastest crypto implementation.
>>>
>>> I think we added checks to some of the iotests in the past already to
>>> skip if the crypto stuff is not available? So I think it might be
>>> better to fix the related iotests instead.
> 
> We have _require_working_luks called by "_supported_fmt luks"
> in the shell tests, and iotests.verify_working_luks called
> in the python tests. Possibly we didn't call them in all the
> required places ? Or there is a non-luks related test that
> uses crypto we missed ?

It's about non-luks related tests, see the patch here:

https://lore.kernel.org/qemu-devel/6333f8d4-3feb-43c7-8d11-98a7c3cbe0c4@redhat.com/T/#t

  Thomas



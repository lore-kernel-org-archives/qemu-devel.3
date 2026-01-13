Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EA8D29DE8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 08:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZP3-0003uB-Uk; Tue, 13 Jan 2026 03:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfZOt-0003gr-L9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfZOr-00031s-M2
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 03:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768291511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BWPOlvCE8hWZ6iq9F9Fb+RmfERjRvlMzKwrQ3No+8bs=;
 b=UeEthMUYYsHw/JNLwR49iKpt3QsbuYYXjkbwMtS1TXZAeSZc2k5WHN5w4r6wnjEi4YPT1E
 zcZbkV9Y1bdsK65dGT3aAltxtyoZ1f51Nx9XybY1lS6AmsmLWXFEo/2y9sVZtxcruk6Rto
 WKHyk/ijOzxlSyiAICSxppYGUBENcOE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ekKCCXc2MtesSR9MZ5yWyg-1; Tue, 13 Jan 2026 03:05:09 -0500
X-MC-Unique: ekKCCXc2MtesSR9MZ5yWyg-1
X-Mimecast-MFC-AGG-ID: ekKCCXc2MtesSR9MZ5yWyg_1768291508
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b874c325d10so4307666b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 00:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768291508; x=1768896308; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BWPOlvCE8hWZ6iq9F9Fb+RmfERjRvlMzKwrQ3No+8bs=;
 b=NFPgNdiU0Vn7hEJk9mLPO9biQ3Q+n2ef2z4vW/KT4f2GFGc1yUBm+PlWGu/E8f2yxV
 ccf7DtPUGGbCw0rS/IMB5miuLRaFjOqbuucUWXC1tmdyJ2cIYqbf4sSeM8KjDhDYNZ4n
 5XAKNvEgUpWzGvZ+FNY+X2D4A8LUNnKjzJs3hQJ+ODGEUoTzxIyB/sw89E7vgTm70NBd
 PPo2vinZoQ4F5Mh0LnR3dE58S7cmBT32L9+ayXIW1ovQkk/tPfPgoYBK0HjCHUINi0Kg
 Bs5bteEAOIUVaubW8+ne1gq/ZssCUZWxsDntKH5DJQDtzkihF1gaTFMavdF23mNDKqG4
 79tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768291508; x=1768896308;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWPOlvCE8hWZ6iq9F9Fb+RmfERjRvlMzKwrQ3No+8bs=;
 b=LyUk8tElaFh00aQd0NAf3eNGJ4QfD0supR0YU9adaQzuhC2EW7SVNevblA/v7SdF5x
 yRJeQMi3Dj/8HLInWaIvvx3iKrhyxJFQO0yaz/ORTeWM0/e7QS7CyJQNOJZxdrInoh5q
 fvJbyWIMSnGol44I4JeThXmbG6Zr26kei8x0uzELVolyqcs+x8PdgKR157aBifvORk54
 3Yhrrdl9Fvf3TlK7tYiqj3gnP/vO4rUa2QZerKMrye0ayMIb5rcY3XCJdBxOxc9lCe4C
 8fVvgKGwUqM0uC2J3fQQabDPAThKzVshjWwn3M9eQoeY1XzRrdWqlQuGyYv7hm5TNlOI
 FbSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7AosPXuZQWQRzGbvbILBh2wwXqNzQDylbfczrTISqOP75uO+RHkQdvmB24kIV0iTDFtnICRDXHzdl@nongnu.org
X-Gm-Message-State: AOJu0YyB5c9a4Mijl8n86ewjDTYOJfF3bWsu1lvC4CG0gRxShSVzlqja
 gptvNV14XuPg00u7EJv1igUL8A3m0Nop0NOJ69jWpKGQxuSAALE2FWVUhVVxvhVVGE0EJJJPxrl
 gleJM7FNsCdhXAeIT45jm3mT2pgqQRBa0aWk8363HaRsHzQ7ueZRgva3D
X-Gm-Gg: AY/fxX5P/6tLvnFFE19YNbXZBOrY2fwQLcdWzlHpIArPqxEyudgS2tkhlwGBQTqZHIy
 YRN9sX+SdgUuQ1uH0PT16m0poP+F9oonsBpB4ALBVF1oquOrATzfnomH2vJG2rsaNYRj1N+SNKr
 ec+eaHk7ZPVrau/MqOz15pOtza4VfAuevpygZw9d0BjLhGVzN8mEAc1qeLoNhiRcozuQG9TrZ3o
 Isgs2fiAkftgyiPKZMW2O/L4va2BEVYjCMrhKcEk5bc0gAIBnddlV2sn18dJWHvvVHEOPFdcqVb
 jnD+0GcOItFLwnP0w82mb7gtOH0csa5TNJQpy9zEHELTkJ10hdXz7qUiH2xutOH/SGrTBV1suDk
 xClUO+NI=
X-Received: by 2002:a17:907:3f92:b0:b87:3740:dd87 with SMTP id
 a640c23a62f3a-b873740dfd2mr145861866b.26.1768291508515; 
 Tue, 13 Jan 2026 00:05:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9+H8537DQ/nbdp+915Q/EYzzk438sQCrIj8cjV//k+9FVQKN6grcwjJpl5PXMxUbrbPwtRg==
X-Received: by 2002:a17:907:3f92:b0:b87:3740:dd87 with SMTP id
 a640c23a62f3a-b873740dfd2mr145859766b.26.1768291508060; 
 Tue, 13 Jan 2026 00:05:08 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe76sm2126687866b.40.2026.01.13.00.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 00:05:07 -0800 (PST)
Message-ID: <18ce478c-c934-4c9d-8c5d-6451c81e40c3@redhat.com>
Date: Tue, 13 Jan 2026 09:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] tests: remove redundant meson suite for iotests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-4-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> If a test is in the 'block-slow' or 'block-thorough' suite, there is no
> need to also add it to the 'slow' or 'thorough' suites.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index d7bae71ced..bf588cc2c9 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -33,7 +33,7 @@ foreach format, speed: qemu_iotests_formats
>     if speed == 'quick'
>       suites = 'block'
>     else
> -    suites = ['block-' + speed, speed]
> +    suites = ['block-' + speed]
>     endif

Oh, weird, I was pretty sure that this was necessary at one point in time in 
the past ... but I just checked, and it now seems to work without this, 
indeed, so:

Tested-by: Thomas Huth <thuth@redhat.com>

By the way, we've got the same thing in tests/functional/meson.build, too...

  Thomas



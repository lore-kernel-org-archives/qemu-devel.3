Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFB7D5A6FD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 08:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFrNs-0004t8-A9; Tue, 26 Nov 2024 03:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFrNq-0004sy-87
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:57:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFrNo-0004ED-G2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 03:57:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so47049855e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 00:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732611439; x=1733216239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OOwYVSNXwf+GftpLqSCiKrXJoRjYLwIkd9viYelAz74=;
 b=kWDAYaw1J1sU4qlSZMmUb6mAZkbtwW0Enj7UqXKaxpEsYC6YxLBmWP0iQ3bEO1oxnl
 f+Zj+BttE1eMfKXgaZsmaW/wYrGHfXPW+xMRmDfDCFbbMVR51VCsBCDXgn7WTuUM8Ax1
 QHefNoaIejtNluituSo1Sgy6QuyrQpMEkfzgJ4+VI7Iq76adBn9kn4yZNbbTYWQjaqd6
 lEpFWX8lz6JP2w5Ch//tgcmLxtE+dUOZt07DpmqAbxgCAYpcYP88P1K7WQCucOypyB22
 3mesKH0oCRXur2+SPI6VsCF1IYf02k3QAFUbkEr1vkUuPcjygolIXjVbE8vY55w9ZDE9
 1MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732611439; x=1733216239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OOwYVSNXwf+GftpLqSCiKrXJoRjYLwIkd9viYelAz74=;
 b=hOjaQ4iAMKBzw2L0Quske4x8zJeTWFqGvXBzdOkQn0BU9TCjXD51McYdAFghBcn7+c
 Xes9a/QvKGBK521Z//4LJm/4ErDwm7UhkYjErN+2YS7wB92XddfZVnIYZggNZxNlyH84
 QHBwD9K5gNpgo3HreWQhyDCvjAmyjxF9YwgDMjGlHiCkwK8sYkbcXmzTKOWS9k4nmFR9
 OjHmRNSYYM066n1Ibe41NNr67LGM7s1MdoWQ8TNHiaNaJdX0iXK4Rxh27W1cbqmDkSg6
 pWUqHntVcfUZTv0sXfosdU5TDm9TV9GyZsaYmj7ZQnBln7Ow3+A6Q7rcUk0PDK9chjqA
 QPcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT1vWBp/SfjkDB4XNWLpDu9P0gg6xOwEBK0xmtzXz7lkJX1NLjptWElCFxEJ3Fz2DfGODSp1DX2lbl@nongnu.org
X-Gm-Message-State: AOJu0YynjGDk2PqCTmG+hVcYiJpdzAvPVB0aX4jqf1j8fMHHEN2hvz+E
 jyTB06Y6LutfTXEUXzw9huHDIMtohpPsiohYLBL3KZAwLE424bqvP2j+v53M+Uo=
X-Gm-Gg: ASbGncvUEub6JvcM+dVoKgE2jbYv9EGbKVImDgydgArBHbVwyybYZ8gnAGQnI49Rstg
 ZEu+18x+6mBr3f8NHI+5UISIJEFOKU6kFNSZuiaQy45byYU4+rX9Jvy1EiHyEgF3cf1yR8qk1ZX
 mleMZKW6JTuPUXftpCD/yOECZdIjTlpyOtdV+y01A0WZstRcnQMD4J/Wa5CzPcZp8wnTgdMkMO9
 NUQeJPb/lVhkFUVyQt2cBsr+fV/ktQiqfNgc0mGw7WcxK1gbAQlC31se6b8OM5yuQ==
X-Google-Smtp-Source: AGHT+IGe0kw9XA+s/lRc44G6kd8/bmbDmFUFQaekGwUSiB61qDD8liAWk1NjM8VufpIrXSdyet0EXg==
X-Received: by 2002:a05:600c:3b9b:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-433ce4258e6mr145984165e9.12.1732611437519; 
 Tue, 26 Nov 2024 00:57:17 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a5d5656bsm8475665e9.0.2024.11.26.00.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 00:57:17 -0800 (PST)
Message-ID: <6f883a0f-3fdb-4326-8262-c0482e30ea32@linaro.org>
Date: Tue, 26 Nov 2024 09:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Refuse XCode versions < v15.0
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241126081054.244365-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241126081054.244365-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 26/11/24 09:10, Thomas Huth wrote:
> According to our support policy, we only support the two latest
> major versions of macOS, and we already removed compatibility code
> for older versions. However, it's still possible that people install
> an older version of XCode on a recent version of macOS - which won't
> be able to compile QEMU anymore, see for example the ticket here:
> 
>   https://gitlab.com/qemu-project/qemu/-/issues/2694

Wondering about this issue, it is possible to install concurrent
XCode versions, which is useful i.e. when you build an application
targeting multiple (and older) App Store releases. See:
https://xcodereleases.com/

Maybe we need to clarify our support policy that we only support
the XCode released with the 2 latest major macOS versions?

> Thus let's set the expectations right and refuse older versions of
> XCode that do not match the two latest versions of macOS anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index e0b880e4e1..a290dbfa33 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -315,8 +315,8 @@ foreach lang : all_languages
>       # ok
>     elif compiler.get_id() == 'clang' and compiler.compiles('''
>         #ifdef __apple_build_version__
> -      # if __clang_major__ < 12 || (__clang_major__ == 12 && __clang_minor__ < 0)
> -      #  error You need at least XCode Clang v12.0 to compile QEMU
> +      # if __clang_major__ < 15 || (__clang_major__ == 15 && __clang_minor__ < 0)
> +      #  error You need at least XCode Clang v15.0 to compile QEMU
>         # endif
>         #else
>         # if __clang_major__ < 10 || (__clang_major__ == 10 && __clang_minor__ < 0)
> @@ -325,7 +325,7 @@ foreach lang : all_languages
>         #endif''')
>       # ok
>     else
> -    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v12.0) to compile QEMU')
> +    error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')

BTW apparently CentOS 8 (which we don't support anymore IIRC)
provides Clang 12.0.1, and also Ubuntu 22.04, Alpine 3.16.

I wonder if the relation with XCode __apple_build_version__ is
always __clang_major__ + 3...

>     endif
>   endforeach
>   



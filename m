Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6120BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OYm-0001wW-RI; Wed, 24 Sep 2025 08:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OYX-0001mR-0F
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:25:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OYN-0000j2-EU
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:25:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso680148f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758716693; x=1759321493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iNSO2LqqC7261WxFTjQQ87pA9qXbLg8WM16oO+4AvT4=;
 b=FvX7glTM17PkyCTOYrx07dzsrNfXNVzpcch9Gjkrirj8Ao87NKDhLjgDjeicvxmOtm
 n26zM0cTyGoJWgewiX+x1pH9x6TQ64aRtlUOu0jRJN2YTgAQXqeD0ekaRALqZSv4bH0U
 spXkssQxa3OH998G3IG6mGPP+FGRXE/4f0gSvJDCGsPo0NTbR/67iDFRJhA4HVZZNdql
 XZh8IrYsIsDhe8jy09OqOIWbOLxgZw/44SVPXOIoUdmV1tz5HcZf8+g6rqeOnDbESqfc
 y62BT0OW7E0LmWqZ29El5Hy2iohb2k357bjeQG6PaHUlEjbZgouCXKFcp3EpJ6mzQv/O
 kBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758716693; x=1759321493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iNSO2LqqC7261WxFTjQQ87pA9qXbLg8WM16oO+4AvT4=;
 b=kzIjtwM0rIXFlc+Cwt2q/11CQHKod+RhwaBG/i5xiLaj0r/AA+KkQAC0hG3+8+QUKu
 xCtgIFDUNdUYp4NocQYIIJrxCul1J8ffFP577XHMCOXheFKb1ZstZwUJcW/2RWXgNsSe
 UXsqJcBq/386WQvCXn0CSsYpMTciEZaLAkJdMYwUIy1l2tHHawiMInrONLgv6m8q+YeW
 MyxWntLAG9tm/fdlxUlQM9DnB8sbF45res6GzxxIFUIWVuHHjOuMv/JoN9epzcwu+aQC
 rWpO6NxrMTUYYfHK/yxdgtk2Y2FkXqAwHQuf/4768+jf0U4q12SmDYDqpbqRoXbVmZSD
 rCWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Xzknv/pHXEnO8bvxek3Yc2zG74OseDs/L1AV4Ww6Vh2rJTQ9/bn88M6Us3hNu8/vfMvjSz4WLG25@nongnu.org
X-Gm-Message-State: AOJu0Yw0nE+PRXccCU3N7BRLDJEJhnmotdccShVQvy4krP5c2uKhDpCI
 omJJIB8R72KpQ4SZ0A7bgNg3MICvjPjw+xRW6HGbDSbqVq0oJ1W7+NAI7dJMLc+yCfY=
X-Gm-Gg: ASbGncuwUvZOagfrw01gT4t0W9DfPoWCmcTHO9EVAbyuRkajJ3GRh84ZwKVFEj0Lpgi
 MI31on4SIxQpYTcIa7AobUZ4z7KHr0JoWwCrBdQPs5mG1i0uvxbH31z/Hg5IaaRO6oaWRddcRGU
 g0v3mOWUvL6dOVT392WUeq2AhF+u6KCVkEvvVNP5pg7cg9fLQvxTFLtQ5PPD6d0pvZw7lgmdQoo
 oVJtV5BGFqitaojBMHwUeuARkW0VA06Or6b/jrb3V8rWMVmxpolPGk4M5eVNFsowkARU9pEv7c9
 hjWdNQhKniYDrJ0yPof1SfHJ3ldY2024xUtkbMfjVQ4d7LOXRHvW7gBcHEF+33/9qTRccGpjzsf
 ygTU65wxsGC1wsSm5Lu1unKn9Q0IYkHtAs65ei+f2UoGl4RBJQ7ulRhA5TnsjOv4fSw==
X-Google-Smtp-Source: AGHT+IERXCGdLKrLt9sgzOe2aKifaV9LVcj+jFGZ5mR0vdq+6MakUr8lB2xLjUnLtMaD9GS1xJIkzQ==
X-Received: by 2002:a05:6000:2389:b0:3ea:6680:8fb9 with SMTP id
 ffacd0b85a97d-40abcc76f3cmr2338249f8f.3.1758716693213; 
 Wed, 24 Sep 2025 05:24:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407cffsm27741022f8f.16.2025.09.24.05.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 05:24:52 -0700 (PDT)
Message-ID: <e73e73c0-3c13-45ad-9818-f28ef69f2105@linaro.org>
Date: Wed, 24 Sep 2025 14:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/27] RFC: build-sys: deprecate mips host
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-26-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924120426.2158655-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/9/25 14:04, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   docs/about/build-platforms.rst | 2 --
>   docs/about/deprecated.rst      | 9 +++------
>   meson.build                    | 8 ++++++++
>   3 files changed, 11 insertions(+), 8 deletions(-)


> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index aa300bbd50..285a8354f6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -172,8 +172,8 @@ This argument has always been ignored.
>   Host Architectures
>   ------------------
>   
> -Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2, MIPS since 11.0
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Maybe just: "MIPS (since 11.0)".



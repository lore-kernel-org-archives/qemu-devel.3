Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C06C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXEV-0005e4-JJ; Mon, 27 May 2024 06:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXEQ-0005c0-OZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:05:30 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXEL-00025J-79
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:05:30 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6267778b3aso199402966b.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716804323; x=1717409123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qRydgHKQoPoIRP20QtKC8+5+akBhmpxMyyZaIz8iZCQ=;
 b=NnerhfQEI+YSTjSFvJYUNr9yJG/UX0HfkuoQbmKyiarYMFT8whJtQ7GhhNn+EbpJgz
 GaivX2rbIzv+tgcqodm9J36mFAZRounKdOLTH+Gr9ojHuIB4KZqpb0DNSbT/YNTFyLFd
 PEzj76+kBjpnAMG0YnXJmivT/TkmaEhuK32gWdeHypMhwm3ga94rl6sXnUDg80V1ttdG
 xNaJUrXdw/DLe/rlboLd9dAXcxBz7GZOOwrOAIZ2dcLY0tfB60d4lqtygRj2jlud8jj6
 +ffLVDSwNtO05bb3Ohj6DRZSBzw7aPaTOPN2hYjPEuhWtiGS+xVcp9600Au0CDn4CiGQ
 rvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716804323; x=1717409123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRydgHKQoPoIRP20QtKC8+5+akBhmpxMyyZaIz8iZCQ=;
 b=p1u22nm6ATMyXCyLkBoFR0gwVr4vnENLuwXJ4cHiopeE0LR7HCOjGmur7njEse+5kF
 YLSWr55MY1Y/bklBI0GwkDmIZLGcYBj7v36zM5zkbYqgv/ml/gOvKRuHahodifOxmy61
 EdzOTRtofKeybJDQO5Bq8xbiPLh+Q/NL7n67DZ+VMid3MEwog07e+E1nd6KnTDEQpV8R
 0aE46fMMRKBqDNNifI+0fwZxW4x2lD0lSV2fWAzaM/x2xPISL53R9B5OP1Q1xdpN2Qf8
 u7OiizS8RIA/kjx1JiAUicMskAtyorOB6aDraLOOIAoh9iwgIxvgZ3snrmPbCcaIPxlM
 IpIw==
X-Gm-Message-State: AOJu0YzLvoQwyvCOhaYHBg/LGEKCB0enSCY7SeeIXBXszncu/QCZiXy2
 q1Sx/iIR3eYtsiwQGP5WNR86FpiEordzLbBi1VH49CQRPAf5RM6TKObytzVi2Zg=
X-Google-Smtp-Source: AGHT+IFD/NlYXFEp8PJ7oOfevGu5LA3rPW6mg3nfkZ3uGAbhvFF4rOxB4+wbHXjRPvK0KxPKY1oO6w==
X-Received: by 2002:a17:906:8920:b0:a61:c462:c612 with SMTP id
 a640c23a62f3a-a626512868dmr480844366b.53.1716804323276; 
 Mon, 27 May 2024 03:05:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda7a0fsm474201166b.212.2024.05.27.03.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:05:22 -0700 (PDT)
Message-ID: <0c2e3dc5-7358-45f0-954f-1196f4c0625f@linaro.org>
Date: Mon, 27 May 2024 12:05:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] meson: Pass objects to declare_dependency()
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev
 <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
 <20240524-objects-v1-1-07cbbe96166b@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240524-objects-v1-1-07cbbe96166b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/5/24 10:00, Akihiko Odaki wrote:
> We used to request declare_dependency() to link_whole static libraries.
> If a static library is a thin archive, GNU ld needs to open all object
> files referenced by the archieve, and sometimes reaches to the open

"archive"

> file limit.
> 
> Another problem with link_whole is that it does not propagate
> dependencies. In particular, gnutls, a dependency of crypto, is not
> propagated to its users, and we currently workaround the issue by
> declaring gnutls as a dependency for each crypto user.
> 
> Instead of using link_whole, extract objects included in static
> libraries and pass them to declare_dependency(). This requires Meson
> 1.1.0 or later.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   docs/devel/build-system.rst           |  2 +-
>   meson.build                           | 27 ++++++++++++++-------------
>   gdbstub/meson.build                   |  4 ++--
>   subprojects/libvhost-user/meson.build |  2 +-
>   tests/qtest/libqos/meson.build        |  2 +-
>   5 files changed, 19 insertions(+), 18 deletions(-)



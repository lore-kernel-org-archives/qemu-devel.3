Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A2EE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNs3O-00037i-MA; Wed, 18 Dec 2024 06:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNs3N-00033A-3c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:17:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNs3K-00086R-7f
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:17:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436341f575fso50631925e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734520635; x=1735125435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+DB6N73yHGvsAXmUommk/ZUinIeBiSObIv3EDMmrBc=;
 b=DvgxtCf8qbud83AuklimUURy8pEUd4rDBSqpoYQgu5J2I/uwdrgA+wq2pSbjwQtBuM
 05SfkgO4hccdUYcGTru5/djL0A/U8R+SFvfOX5IdGbi0IMiRUawD/68Zjh3yNdt0dv6o
 g62YlW+huFOEf5sPTx5P1J7iPeHcmc2RqecdHi+oRDWxMvdsBOvhqsCrk9ng/0xK7EWu
 F07j7aiJcdzxuDDskzN2yd2opqw8SML20L6gd0/no+VJfTuuW9ohhEu+upBWSDpJJ69Q
 tzV3/TjgMz4AEd/djy6a9znSK617cdJ7etOtMGVvZ70J4vawMw5j8XAxACgaWcBKlMR9
 Vdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734520635; x=1735125435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S+DB6N73yHGvsAXmUommk/ZUinIeBiSObIv3EDMmrBc=;
 b=J+7BWAXy3wGPA3x2fxpGQ1pOcLANBrJ3toj7amLnT5RUFiaQSuU9M4qUuioqoPihyQ
 zoxe0ZcxRLv/OoLolq1VhZWPaqi/P/MVonqPpDNqlB0UlOBnLzAbs9mbT2xtgCW/moTt
 J5Zx5mYE86AAS79pcAyKty2mPIuaM+suLenC8f0P/SP/V57U92RJfeRFD8j+jMyoTkpo
 CgXoOTkGb+eu58EJ8jQkQ3qEiqukK8PbYAkAlALD32Bu8RMMEcMH0gOORavWDGYYpf6y
 p1FwL61cLwUgCEcXCgjG9gzbTw1/Ifqrbltdkoyhbcq53O9JCeLaCRC40oaIsKHt2a3B
 YOSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlQKYpzoTMccaq+3AB2CT7xSvarLP7Pv5fdZZ9nLii+Imxb8j5JliRlFvCA+Rxon+sv8uFnS8ymy13@nongnu.org
X-Gm-Message-State: AOJu0Yw1AHBK54NL/SKhpqTZKInTdab2rE7kXNLIXKxjsAqeexhu3C1Q
 P+3oTN1sdDNJLGi+hJgnlgnOiUMZY5BrQceM0QTnW2LG/pSnWrvxs8NOzAMfXuE=
X-Gm-Gg: ASbGncsfyeMHO3VjWApbjIJdDFzRLisYrTONQzEciQQM5/pC0DbPUTuN6sdg3pHsLPa
 /yySzsh05TttCCeiDJBWy+WPsQMHC2C7oNmCEILYr4qc9WrcvP5JuJtAfITWbxPgPIY6hhaE2nK
 oKnCCMfdbhod45LeZ7fN2NSNjfM4W2cY0kC32dGQ+Mdz8ReH6HZ7/pIa6G/hWkSx/Yoe6Fc3dL/
 euWExyxN26Hkb0oBW6TmTOY2Khe58bUm2zlftt8R0M4dcxd7lL5GD0DVZUr8yvoa53uCC1b
X-Google-Smtp-Source: AGHT+IGbWE0XttpHCE/SxeKtb2o43ZYzjwwHRxUlBlCCjHUwO3Qcs+aRXoJ+9uhRfvcCUGr4NB/K8Q==
X-Received: by 2002:a05:6000:2a4:b0:385:f66a:4271 with SMTP id
 ffacd0b85a97d-388e4d6a338mr1994183f8f.4.1734520634899; 
 Wed, 18 Dec 2024 03:17:14 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a487sm14070763f8f.45.2024.12.18.03.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 03:17:14 -0800 (PST)
Message-ID: <ecac6a6d-163d-42ba-83f5-e4e5980c9ee3@linaro.org>
Date: Wed, 18 Dec 2024 12:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] rust: pl011: bug fixes
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/12/24 18:21, Paolo Bonzini wrote:
> While preparing the comparison at
> https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html,
> I noticed some bugs in the code.  These are the corresponding fixes.
> 
> CCing Philippe because he expressed interest in bringing the Rust
> version on par with the C version of the pl011 device.

Also cc'ing Zhao.

> Paolo Bonzini (7):
>    rust: pl011: fix declaration of LineControl bits
>    rust: pl011: match break logic of C version
>    rust: pl011: always use reset() method on registers
>    rust: pl011: fix break errors and definition of Data struct
>    rust: pl011: extend registers to 32 bits
>    rust: pl011: fix migration stream
>    rust: pl011: simplify handling of the FIFO enabled bit in LCR
> 
>   rust/hw/char/pl011/src/device.rs       | 119 +++++++++++-------
>   rust/hw/char/pl011/src/device_class.rs |   8 +-
>   rust/hw/char/pl011/src/lib.rs          | 161 +++++++++++++------------
>   rust/qemu-api/src/vmstate.rs           |  22 ----
>   4 files changed, 160 insertions(+), 150 deletions(-)
> 



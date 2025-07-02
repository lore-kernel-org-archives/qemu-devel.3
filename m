Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFFFC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX57W-0005tQ-Bd; Wed, 02 Jul 2025 17:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX57T-0005sW-JI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:35:56 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX57Q-0001aE-Aq
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:35:53 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-235e1d710d8so87808735ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751492150; x=1752096950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hg0qj/WAsIhSzKk50qSOHcs9sPB5yADg/xMC/cighLg=;
 b=VShev2Bgswsak1U9dIXIR+omQlL9ImjF/GwpKQ5kQ6jN1dVBj3IPXshQVraSWJU8mt
 Q0kTdqj0n5EyT4uggJXjzNdjcmJQ0KXUGViXe8bdaczRRQFQRNBb2Aw9/bau7s/SezYa
 LNp/yqbVOwhYWvcs7zKLnMeYqwGsjQxH3+BhLWwIYtKjSsbg9QNLneQJ82gOnJZd6SV1
 LlKQm3z4tEMwD3bMoQcoHVbMks+pEp8jjSfE561GrpEXGrvuEKodLEEy8ocWPHfuCzsm
 yk1XQtMqawKyy3HJ3cN9zp8VI+qOlIJFtEleqt0Ie+Vp41ZoQyMhl3GWZzr02jwXnYjd
 afsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751492150; x=1752096950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hg0qj/WAsIhSzKk50qSOHcs9sPB5yADg/xMC/cighLg=;
 b=sYvjDC1ICwOtj65nzNsVbDMwtTtC/kFrb90hehI5Hy9utt5W+Miym48F3aj6810U8N
 QUeREuMRa+Z96aVcy1h8c9ij8Q46Zp1I8YvOrtrN1LRAg2YaC/4rKl0sj69tDISugj02
 nFZDlLrnz7fzpkocQHE/zrfnU8lzBoKnL3Z5UpnKBB9AFGm2kwIw3pXWW5tRfWO/UNeQ
 K5xAKESEfVWO+APRu3ayv+jFoaKEglohXK03wncdnk2TMSbwhNDsLSyBscoD5CFRkDwO
 24cnkjTpGDM/Kni2navWvPrcLpP0+9o5BDZrx3Sij0xGf+lsKGMDu+3GNsdnrNKUSB8u
 XzVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXpYBwKRgmCyAv5lDI8pV9+KxaKWKKT9Ic2q9o1RCdaAScEwXgX8rQuHK+Ra1r1SPIHSOUaTTvqP2b@nongnu.org
X-Gm-Message-State: AOJu0YzCRW7GoktrJEd+KR/TKhFEB0qtcuxmCJLPySdxdEnDh3VJq33o
 6k8qg+iYo3U0peOssDd5aJ2uUqZ3Omb6E8p7BZxWnfPr3yRU8raz1LsWTqdQoEVfwUo=
X-Gm-Gg: ASbGncv+5zOgxdmGzFndiYUg8OPf+vUzjmLFjqqTTV6+Y1j2V5d0AD0D2lsGanGFWTy
 dG1j7nJwlPDcDy67AZZAGCJLATmR7H0ohBXBl1BN+y05k69XGZiO3qjfcxTwhq4L3T62Q1SJj49
 W8zroUrZpy1e7jn+FIxS8lffmWT5blU3YYBOYYpX7ZXG1lvh0Q1lUbXXAo7UOD//uwnjo9IfK1n
 VSBVry+kwbhF6Nkx85bl5jnWGf/NqCyGXmJfqnHdGpAZvfnT6fRonqjXLXkmZTzEyikOF2umweP
 1nkpahhxa6y3NWGMq0q/nTzkqDVY8Rkjy73y6fCMqkb0ovV+MMOa47pq2jW8tu23P2lIuh5xyGY
 =
X-Google-Smtp-Source: AGHT+IGpscWHzvkBGYWVvFV40B4JDIxA1z+rgMXJn4WUCElOgiG44deUfbMutc97UiUsHwDJJULrfg==
X-Received: by 2002:a17:903:b8d:b0:233:ab04:27a with SMTP id
 d9443c01a7336-23c6e5f389emr81341945ad.53.1751492150010; 
 Wed, 02 Jul 2025 14:35:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39b93fsm136116685ad.119.2025.07.02.14.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:35:49 -0700 (PDT)
Message-ID: <0ab88797-7466-4b83-95d8-efdb04369664@linaro.org>
Date: Wed, 2 Jul 2025 14:35:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 59/65] accel: Always register
 AccelOpsClass::get_virtual_clock() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-60-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-60-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> In order to dispatch over AccelOpsClass::get_virtual_clock(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_virtual_clock() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h        | 2 ++
>   accel/hvf/hvf-accel-ops.c         | 1 +
>   accel/kvm/kvm-accel-ops.c         | 1 +
>   accel/tcg/tcg-accel-ops.c         | 2 ++
>   accel/xen/xen-all.c               | 1 +
>   system/cpus.c                     | 7 ++++---
>   target/i386/nvmm/nvmm-accel-ops.c | 1 +
>   target/i386/whpx/whpx-accel-ops.c | 1 +
>   8 files changed, 13 insertions(+), 3 deletions(-)

Seeing the pattern in last 3 commits, I have a question regarding QOM.
Is that possible to get a constructor called for parent type 
(TYPE_ACCEL_OPS), where all default values would be set, and so every 
child class (specialized accelerator) would just need to override the 
field they want with their own method?

It would be more easy than explicitely setting default values in all sub 
classes, but maybe QOM design is limited to that.


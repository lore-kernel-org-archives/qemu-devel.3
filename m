Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9E1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 20:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v19Jz-0004co-Qu; Tue, 23 Sep 2025 16:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v19Jg-0004YP-Gr
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:08:51 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v19Jc-0005oB-BC
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 16:08:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b55115148b4so3922467a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758658121; x=1759262921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+A870irlUyzIlTjkl7PKvI9+jV2CUJnu1PK217zi+M=;
 b=dRSeQlnPEDEwPgWwDg5F7g4LwNKZuEwnYEtOliE7USLB0jOEG0gqUoIUEL5QjQZwet
 QPK25CQtJWpchUsRXF8o7pZxxXYM89aE953Rak2wwSdjGLL2AwI3er0+xwcD3SQ+7F9X
 lr2IAFL+c9KacWsdojuLqfgL4XdKtN3rBqzlNyNS/zUBhnpARz36LheOpSBvk1N6y2ic
 eobtuhATxQs8F5qRSaZjd1st1FevXneO+gkDKaysx2wrmUeVYBbDgKldVJU4zzrSqmr0
 +rY4ufkJb9T77E8WKz4B4HooSwCDJI4FHOGBzsvDFcXR/Xhw43+TdmUdQRnsrzoAvLbs
 TgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758658121; x=1759262921;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L+A870irlUyzIlTjkl7PKvI9+jV2CUJnu1PK217zi+M=;
 b=OAtXKqUwYSnMhEa6XBtGxOBUo1S9vTGy5kLeepDhCJscFw9JA2nYtYZawj0PNSrsq8
 seu8/IN/aQVDIzMlWqH32AVsqUWCrsYJ7mW46zr5+LNVnKdDzO/a33P7Q3lUatKbnQ5P
 KQyXp7E+4ZAql6kZdxbpy/rqIU6JtEwtXNvWw99U+J4EFBK1uETrzWciGpclm1MhhOQK
 PaNNwOgOM7Mc9WhS9wR79fmCirkKAMWvzNTVLg6Up8edEw5yc295QwlPbNuQu+BiS8Y7
 jLBx6MvDj3RcYqCbP4O+NPAWNbr/FJJuXO2S2JwsVRQYVntXgtQba1N8mmRfjy3VCQlg
 2ezw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMGzowTOzwnXOu2xoJ+nBaNB0d4eeZfvl6E4fZXiTK7iZUXIO3k11l3oEYHozSvrvkR7+o2Hoddw/W@nongnu.org
X-Gm-Message-State: AOJu0Yws0DQMiknHYNiMpDmtTWICqYk005yKKM0hk0rZjEvOyzxf+X0e
 4EzCpQXCrJiQseHA5DutNdntlwhm6Llb7f+6NOqJ+Am+kQEomV7lJGTVA//nA2hQqXcotGDYuKB
 uK00l
X-Gm-Gg: ASbGncscCVJsvv1FgHBPzx4Wa4LB2bT2MKG3XHKTutkECZau/VJB7Zbdx/UCU9bSlAy
 nizuUQknmKg7+JczBvV+NoaVh6taFCR6S9MnVb9TlNYy5YnpLJ7RHugxuH3IcRkjBTDdgL4BLLw
 dDkGBLP46X3ygz0plvMs9lhH6TE41xtn4MwRu2Z8VyRDecmB+Ch6PsFxkhJGooWdxMwDLeSQBIx
 hEWZVE04wC6ehG3VF457Ocmq4KqWtR2cuItGhni5H9Rxrl9zcCtzkprQwB9bEeTWeZleemMS6Z+
 cMc2lMLV6oDTM4VjlGlzeM/DiEpweIbSIYOtgf9xDVqiZXl1uNmRrYvZZjkkq81Sn5ge8FszKE8
 EZJLZCe1SkzByOuQw+3Yj5L+3lpgvuFXf2Us+
X-Google-Smtp-Source: AGHT+IFGJ4d2E0v3lW32Kclb1pxxEn7rcJk0mlGTWRriQWqKSlqObk7D+mf2fjZIJV7b0jkzS/7OnQ==
X-Received: by 2002:a17:902:e88b:b0:276:305b:14a7 with SMTP id
 d9443c01a7336-27cc5a06cfbmr48977945ad.33.1758658120852; 
 Tue, 23 Sep 2025 13:08:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26980053dc8sm171070535ad.13.2025.09.23.13.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 13:08:40 -0700 (PDT)
Message-ID: <ea5c9843-527a-410c-9c7d-12f3a5264f9e@linaro.org>
Date: Tue, 23 Sep 2025 13:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/arm: Implement ID_AA64PFR2_EL1
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250923175751.966795-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250923175751.966795-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 9/23/25 10:57, Peter Maydell wrote:
> The ID register ID_AA64PFR2_EL1 is in the space previously reserved
> in the system register ID space, but recent versions of the
> architecture have started to define fields in it to advertise the
> presence of new architectural features. We don't implement any
> of those new features yet, but will need to do so at some point.
> (Notably, the GICv5 EAC spec defines a field in this register
> to advertise the GICv5 CPU interface.)
> 
> This patchset gives ID_AA64PFR2_EL1 a backing field in the CPU
> ID regs struct, defines the field names, and reads it from KVM if
> it's present there. The only visible behaviour change is the
> name we present to the user via the gdbstub.
> 
> Commit 1 is a code movement one to clear some more stuff out
> of cpu.h that doesn't need to be there; it's mostly because of that
> that I'm sending this patchset rather than holding on to it until
> I have some GICv5 patches ready to send.
> 
> (Compare commit f7ddd7b6a1f90c from last year which added the
> ID_AA64MMFR3_EL1 register.)
> 
> v2 here is just a rebase which updates the patchset to handle
> the new array-based storage we're using for ID register values.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    target/arm: Move ID register field defs to cpu-features.h
>    target/arm: Implement ID_AA64PFR2_EL1
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


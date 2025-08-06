Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4183AC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 06:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujXqG-0007HU-U8; Wed, 06 Aug 2025 02:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXqE-0007GG-Mc
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:41:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXqB-0003oi-Uw
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:41:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso39383645e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754462494; x=1755067294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Qt+eug0h86j0yWuF7BVqKm/dcYHS8LW1wSkDD2sulU=;
 b=rBU9rwGcFyO6tUv9+1Ic89vfsYCNPwrLsX17TT/ZfvSlM+tpxO2Gv/94HjLbfE0BCx
 seO9elTLCAkUx64pW/bIg8SPZ6m86PXyD50biJBy4XDMvq8wuFUvxTLXdJr70PkeSBgA
 QVmXFw52nMo4qvGVHr5waBbijiuBpc6Vbesu6Lh3SbGQfGD4qYli+4kFUmnjVZPobumv
 scagCt7IBVUfljvgY+Kgwdfrjo5m7BOHQIAVAvwPMrPdldpUkxc7RKkG/ngm/oFyHOnS
 cQODtE08x/1WTeKv/bSIkzXWWw0UzAdO1mqWeRw/Jzmku1trUq70QGelN3Fngev3zqM7
 oKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754462494; x=1755067294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Qt+eug0h86j0yWuF7BVqKm/dcYHS8LW1wSkDD2sulU=;
 b=w8UT2VP2qJVmi6eYwRNu9di9MKl1BFjlzUOBHzpvSsn4wH7MyZvON9w/VtA04soVT8
 b+2fmFDhP3ocZqG2x6VaL+C1rei/CR5ecTCt25flRF+BT6b7l/d1oGgxYQdJqOenmRaj
 XHHrlANLgvPumsQNacjvKtVU3fFne3Q82zcJp9IQO3DveskxU6rAKct6SEM+/Das9ZMP
 7//PP78r0hAjqExNCqNud3k+KnvMEaijEuFAAhqrwoOD7RULwN116QO7qXAuC3ZJGoOS
 MhTru2xOAIj85lofEp4tR3hoQOMQi2aNq7j/Km8iSuwX5Q6m21UakEjnTObsS+s01pos
 oVbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtG7lxNG3EJ7jj7Ra7+s3TU3n6VVdjjEhP5OVEFAZ2Iuu6cp7ZAoLoHE+pu5zOWrKe2FJP0C06Ilm/@nongnu.org
X-Gm-Message-State: AOJu0YySENrfojJ9LTNDZ18JXGgzHeUoOfeBCvaiF2PhzsfW34grfdlw
 2u9c6xg7EajEQ5RgWRgCxkAMwon1Q5vOZYisDepvYYz6WJKGesMhW4uNeuRTXUGr9gA=
X-Gm-Gg: ASbGncttph/4OC7Ugel+PCgfT99xBBvSLjmahLjrb7X4pf2I1tUIm2ijVNHzRk4Q6aY
 dAFW2/8HCZX/k57z8ubhnziG76+6xSiUViVHx0PTilfCuuZ3fecmeBsf1cAFrm5uFELLj8i+qNf
 TEMACw9MNUi5dCfYM0o+hl3UHREW9Lp6SlPxfgdDkL+zYi+AAUmE0WOErxBYgziIkwuUAgPvs/B
 B5/oNCIZC5rs+/WWttSbqEBsWACfaEvcVum0yC2K8fPs1r83PPAVRC+UgmNPhMrIF4uxXxC0fZc
 RD0zcnEn8yXLyPTG6lg0ordOYyQyJ1OljzOKVrwuTrbMVgwQNlJY5qyPu8NX0P4IjWNHsII5m/k
 vrURe4ieLdzgHr4x9i56mOQ7CcG13qvRoyRn2nLhOkxb6p4lH/3kPbB8gTIJSk/R1PA==
X-Google-Smtp-Source: AGHT+IG41H7bClF4Q0juvT9pARqsJwyuwu8sMLVLbqKGhpFtZd7rwv+YMTcL3OAxfxMZaj1cHgtLdw==
X-Received: by 2002:a05:600c:4f4c:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-459e95af955mr4331695e9.21.1754462493743; 
 Tue, 05 Aug 2025 23:41:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58400f5sm32839855e9.2.2025.08.05.23.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 23:41:33 -0700 (PDT)
Message-ID: <95cd67ab-fbaf-4720-bda0-25356ea6ba49@linaro.org>
Date: Wed, 6 Aug 2025 08:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/loongarch_pch_pic: Fix ubsan warning and
 endianness issue
To: Thomas Huth <thuth@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20250801060152.22224-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801060152.22224-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 1/8/25 08:01, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When booting the Linux kernel from tests/functional/test_loongarch64_virt.py
> with a QEMU that has been compiled with --enable-ubsan, there is
> a warning like this:
> 
>   .../hw/intc/loongarch_pch_pic.c:171:46: runtime error: index 512 out of
>    bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
>    .../hw/intc/loongarch_pch_pic.c:171:46
>   .../hw/intc/loongarch_pch_pic.c:175:45: runtime error: index 256 out of
>    bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
>    .../hw/intc/loongarch_pch_pic.c:175:45
> 
> It happens because "addr" is added first before substracting the base
> (PCH_PIC_HTMSI_VEC or PCH_PIC_ROUTE_ENTRY).
> Additionally, this code looks like it is not endianness safe, since
> it uses a 64-bit pointer to write values into an array of 8-bit values.
> 
> Thus rework the code to use the stq_le_p / ldq_le_p helpers here
> and make sure that we do not create pointers with undefined behavior
> by accident.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/intc/loongarch_pch_pic.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



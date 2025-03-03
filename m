Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C123C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp59Q-0000pe-8S; Mon, 03 Mar 2025 07:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp59F-0000g3-Ah
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:43:55 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp599-0001oE-Px
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:43:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc6a6aaf7so4394545e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 04:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741005825; x=1741610625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKhlo7WDyCR0prgI702h3dkcLsNG+H7aJJCG6nZFhTU=;
 b=G0lYynBuiZngSvID13uHcXDbhJ9TZvm1KJc8nJ6OZLSOE25dMYBVkDh9xGax9R8bzw
 oobeW5GkylAwDZ6P5W0+iScfo2tiUfmzRt+gyBC7xKp4rMnAgah5ON64Tt1ts8EQqLNc
 t6+IQEcrdYw/9sftbnDwnsQF3EuyYYYk5XLax0JOHnxBJUYwG+I25KQw7pYQ/ZaIvmX3
 JmXEF9Hit1Fn3fLR1qEtb6rGAKYD6oGTVpvgwc3soKMU5r8sA9LcXkJ8P0KqTFPoNWjq
 M/+Vch2AT5jMCJzXPjATmEDoKLd4pV1QaAoH4xQi9lYAo3UIGHuMdqC9k/VP4INHBMWy
 T9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005825; x=1741610625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKhlo7WDyCR0prgI702h3dkcLsNG+H7aJJCG6nZFhTU=;
 b=god0lLVGeVpaz8P61nBfd35rJjXOFyiToweOzBZqdZUyKAWFY7PLFe3+5LXhQrV5lB
 3eNRyl295DQ4Gubb1kMuPtr9LXzcvqpDw6eqireg3AhxHayyqRkk+MXIAxIZIlwMwwKc
 fNGt1vc4NniozDPAlq2wF6j30Uvrke1xYKCdr3jW+exynbEzOXuLnQBYH6mzQDpfu3EZ
 47kkQuYJLOv05hLsmbOxzexokG7bHsVwvehyISjOH688/i0X1SvYsa5pbqUS5PqhQAGw
 ejrx21VOnJpvrffYfh8rBDVPkm/5Cp7rt9GXhnSWsUNMeMFeouJ+/mGk9bhwmtO7ovLo
 8s5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrwnXB2RXjcftZHMOep1y+hXYjTzRx+TOo9Vm2ZaK3O/ScgkOEzc0ebtJ48TEUujYU5p2pSGDK6Olt@nongnu.org
X-Gm-Message-State: AOJu0YwMAJK5KD+GN6LQO1ahQ8M0yCLzvdiSrIfK9d/FWOqG44IeSEmq
 AGm9LH8LWdF+RWrgd7ONgal7m2G/T6I8ZltbohroU2SfddYO8GAuyy1RWHxcZaA=
X-Gm-Gg: ASbGncskXBOgDbqJH8ORDXuet9OgMtIWklr13dxqe8LpZYIlHF58pdhEp1GdB2m9994
 ij/MDVW+tMLyDtvGPTnXSwoYbomQYbxVy6sfQrRI3OwBJQEmbdnHXQjm2xMMqM2dgDbDodCaUYr
 2bLk6eHERh1bZ3zgJFNKYPp4bZY5eayt2rRHk7fx6FMTegIdqEOPKYf+7vbpcmrvt1ZMy4ZiVgK
 wlSlKMlFt4kzlo/hdu098yVsqvasAKm/BXBjFLydNXXaFNPFfSkqtehujdCSfHUZCM3vQSq70UM
 pd24DXdglKAMjRKC9vJVYJpqsd3neZRIrccvOlp35YgOmyfOP/EG9o/kN2JY1Bz9F8lRALDNyi1
 uJY04cBtGcvnD
X-Google-Smtp-Source: AGHT+IEWMVkVVGJzpqzJRPwmCZDm/T/+qMdRtGeEwHoefd3em0AtJM4+jQrvHV3E7eN387JQdzwnWg==
X-Received: by 2002:a05:600c:5248:b0:439:84f8:60d7 with SMTP id
 5b1f17b1804b1-43bac7a3101mr94142225e9.10.1741005825278; 
 Mon, 03 Mar 2025 04:43:45 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc63877desm13720465e9.1.2025.03.03.04.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 04:43:44 -0800 (PST)
Message-ID: <05a71d37-6504-496f-8285-ce4f48e4806d@linaro.org>
Date: Mon, 3 Mar 2025 13:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Misc eeprom_at24c clean ups
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1740839457.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/3/25 15:35, BALATON Zoltan wrote:
> These are some small misc clean ups in hw/nvram/eeprom_at24c.

> BALATON Zoltan (4):
>    hw/nvram/eeprom_at24c: Use OBJECT_DECLARE_SIMPLE_TYPE
>    hw/nvram/eeprom_at24c: Remove ERR macro that calls fprintf to stderr
>    hw/nvram/eeprom_at24c: Remove memset after g_malloc0
>    hw/nvram/eeprom_at24c: Reorganise init to avoid overwriting values

Thanks, series queued.


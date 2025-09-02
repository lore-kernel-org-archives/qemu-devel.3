Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC5CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOX3-000878-Om; Tue, 02 Sep 2025 06:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOX1-00085b-Mi
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:46:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOWz-0002hh-GD
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:46:31 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3d44d734cabso1690160f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756809987; x=1757414787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEiHQIGlRJ6Sj5wIFF4qDACPjox2v/CBmFEmEPfHJ3o=;
 b=WJGnKFlY4GWXuyh2VNfNID3qBGOnHRDBFdu3ApKM0FhU7hxwIMTSO+nKKV4nY6KZx5
 2vaWzUk99s3kj/lzEjmK598NxgbyyQiNzrawLJ4qqGjQXxCKFqOqo89zZLxbdA6VZwS2
 OT/LQxuGFDRLljAI2Hzv2kpUJAFY1qsZDN9KFWg8M8JnYaTTuVGagAnktTJiY2SdyGBC
 zxJjHatlyFIJ/0LjlKmN6qTAkRgy8ZYsLRoDtvSQNaCqfgis+ul6dBJc3Pl/RkBun74o
 /bK7nAl4gosqiTLUAxj5pMpcrhNQIAmB5JUiVyVf3TrQhp6WgojACjV9enE99ba2MxNk
 JT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809987; x=1757414787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DEiHQIGlRJ6Sj5wIFF4qDACPjox2v/CBmFEmEPfHJ3o=;
 b=sK+1ycbWp86kvSBldsaaM4WX4l3YlTSDcgoRiYe3CRcgbWYBG/6gEglN3RMU/wLKPo
 wc3XBSDMhAM8u8QdRdewZzulo3wZPx/qFWp5SYX6FuM8cGHYTskySuYP5UksXdUIMQ68
 KsD/OLYOsR38QczwkVT5f70BJcJGMRNmToUxhlCa6GUl+JAzR0/Z8OAfGdGapvwSEEnp
 HLsxNZNrxprXNXDIQB7l7WDOb/QSPUD9npDa1c6qoC7+Af1fPJbub+Cskc8n+kqci8/s
 NkJAnjZJyRjYGBpqqzGQsvnl4LSoEclitouPIWz4Xhtq7ZoyiNRvAswJF/FyB2Vjii7I
 2KAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+/TC9l3GxiTpUWeVcn73ksrM3PnUdOT/iS9KJHt+ULWTRb8gb4A8pZ9gNa1ESAu/VE3slsjBGys7A@nongnu.org
X-Gm-Message-State: AOJu0YzpCn7g4DsxbkqPawadUn/Td+BkPgQIE9zZ+UZvnOCaoGeDd8Wv
 sflqptKGymvFgUpH5ketqXaWZLbyyJT7WiTmk5/7qO9n1dZsdGPRt5DTd7zDbRGg4YKcdjoGzkt
 NkZ/o
X-Gm-Gg: ASbGncsplEwNNmUTo7F/wizQhIChJbegDxkv7jZyii0rx/4zzLOD32XveocRHs9ATPJ
 RobbEKiTwdIYvF5Ej6rdgUURGKyjh+gQTKyV+4Zvx7AWiyo6b6Kf2ulyO/j7Onx2YMJSwH9uflq
 4d3fpdcJKv2uzZV+fXSRn1jAvO9Pmc3zsVuTkfP5G4Lrz+zLwmVMECbky33o0SeYA+m0FSxZ9eF
 NJEtscDcl2pAXP2QiJWqQvhFlzSm5QnvFjL1y5wBTnFVvI1E/xWNGHNIaDYHQAnMk/9KHj0/kWM
 RUF3kS7jeA1eS/J4Zertx7nr6YaSpbVTsjFcW08MUUaNs5cs5m4xQY7LF+eeKlaBbGPL0EbH1rk
 tdgbAuoSPDZXuH6d5G/73uSvOtVZJ+aY5swTJdwaDBuIPJA4MgJWgqWpQ4KaLNQ8bRu+v34V+Rs
 zeZD0h87rdNl4=
X-Google-Smtp-Source: AGHT+IGODMoR8FCEV2IXVVGHbZ2ievzzVA4Ge+gU982bkXoKl/jBYRT/eZ7khUeuyvTjG/kVb0WYPQ==
X-Received: by 2002:a5d:64cd:0:b0:3ce:16d3:7bd1 with SMTP id
 ffacd0b85a97d-3d1d9ac1cdamr8178739f8f.0.1756809987484; 
 Tue, 02 Sep 2025 03:46:27 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d66b013b7dsm8416581f8f.28.2025.09.02.03.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:46:26 -0700 (PDT)
Message-ID: <e89ecfee-196e-4b5d-9a24-7856303cb84f@linaro.org>
Date: Tue, 2 Sep 2025 12:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/mips/malta: Include 'system/system.h'
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250901064631.530723-1-clg@redhat.com>
 <20250901064631.530723-5-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901064631.530723-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 1/9/25 08:46, Cédric Le Goater wrote:
> Files using serial_hd() should include 'system/system.h'. Fix that.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/mips/malta.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


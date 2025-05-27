Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE91BC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuih-0006WN-5s; Tue, 27 May 2025 09:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuic-0006Vg-UF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:51:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuiZ-0004gW-UZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:51:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so29098885e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748353903; x=1748958703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lvBzAQDdAeg8F+HvRSjvG6+nVOEZlomyt25mGxJsUls=;
 b=rG1duiTVQhgVF95xZYCoFyTZI3ZookGmkg7jOGOXpXevavo/9X58O4au35dki7ZC94
 hR2rOP1zi8gwx2ejaWDrlbTGtg9cvlcBuMS56qvA354EfmR8PkzuXuOazFr0awY/4Eb7
 dUZlD9sqP4LC9n25WLFDkM7uIdLhHYf2S1xOcm8UvcvwswAhXadc6QsOl5Bn6/Cechqo
 AJOksPzxcmW93WFDpMI1CEc1B/f4vFGhrCDyjbUUPjY+Z83+WsnXlKvV9b1EI+1NJ3X6
 ExHECSxJ5xDvVQ+IJXf8HwhxD2DJO3eQzeU2uu8LoPiQBERfxqEgyjezfKpkeZf/CLEa
 F+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748353903; x=1748958703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lvBzAQDdAeg8F+HvRSjvG6+nVOEZlomyt25mGxJsUls=;
 b=KXPxI98Y6ecHrHFGuqmEvC3EsLS/auUBeJ8IdopkW52wZaOX1svynlPsxckkc+8EcO
 KoNM3Bh/yg+YzZuFhy0x7eWEKXeTJ00+HwHticJJuKB7cbRG1fxWvmpS+o83YaFP20Mn
 oXYsDdW+KVH0b6KjkxmnBZbZI8K10ec3puElzfQSPfc7pATncK8rAXxzuQiztny8K+q9
 X8SuJrgUlHBeqmHICOXmQ45I3WRIFOaPQEXn3q24bdAawe6ZEiMWuP1nCmDh41h4+pcE
 3/J3R12b7jR/s0Jf0sswAdIfa5ADEHhM+h8Y5pNXlHRX+ya+Ba3drXlUDgZl2BahlVf2
 XP4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX06HdJXFTyiTq8vx8zirMeQyJtCuKFrP+1aneX1YLLeaDQaJ/5oBCi88CL0+xKojtDOdQ9xMNnzNP4@nongnu.org
X-Gm-Message-State: AOJu0YzF/YnRkJN/o/44Eesp3Lu3qw1gXPxUHGiJIo7tgp+FcMWPUOQO
 u7J0x3Ec9TSA80VEURDDHjpkApVgTkr0aZPkIfZsOJNM8GY7Ils2ohxRz1Tq1hlaZ2k=
X-Gm-Gg: ASbGncvqvX31GihWIKaqSerK/foONXeiEgG5SlaXUjZdjx6O8t8edfoMZYYZ5r2qf8B
 bBHg2G8QLqC/UickPD9urP+corPSk9simkYhkP9gFXrjIiG+jzlvqDSqNaToPNPi0tUrgSyIASR
 k6/aJQDR8GV/K+c254Uycv/QZ4JUa+nuDBjdu6aifedLm+AsMN5WLaE++RY99EOWLXee9RgFRgg
 tu2eitjibqvAxJthdC8kKopzfxKDk0rb0NF8EjNh8unLsmm/FPo5AgdnWs7ifjA9KU7OH79cUPh
 T3dGtUVdjJyF6P56U387yugiyt7K/BIECa2VC61ccYjeDs/VtiOpxGRNOrWT0i+XECcx2d+6isU
 whCiX2uC4fVeTAY43IZAlFyMMoKdjWwGWcG8=
X-Google-Smtp-Source: AGHT+IEDfPkUZziVDgNJEbqXyh1iuruGLpk0r1BC13PKGTasuuqAGoXA27UiP9Gzir9djIIy1mgt2Q==
X-Received: by 2002:a05:6000:178d:b0:3a3:64d2:cee2 with SMTP id
 ffacd0b85a97d-3a4cb49b22amr10593942f8f.45.1748353902698; 
 Tue, 27 May 2025 06:51:42 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29633sm283482575e9.8.2025.05.27.06.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:51:42 -0700 (PDT)
Message-ID: <5c9d044d-cba9-4eef-ae00-0204939da985@linaro.org>
Date: Tue, 27 May 2025 15:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of
 ml605 and xlnx-zynqmp-pmu
To: Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250515132019.569365-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 15/5/25 15:20, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Both machines were added with little-endian in mind only (the
> "endianness" CPU property was hard-wired to "true", see commits
> 133d23b3ad1 and a88bbb006a52), so the variants that showed up
> on the big endian target likely never worked. We deprecated these
> non-working machine variants two releases ago, and so far nobody
> complained, so it should be fine now to disable them. Hard-wire
> the machines to little endian now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst           |  6 ------
>   docs/about/removed-features.rst     |  9 +++++++++
>   hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
>   hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
>   4 files changed, 14 insertions(+), 23 deletions(-)

\o/ :~)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A72F9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcKs-0004re-Co; Tue, 14 Apr 2026 07:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcKr-0004rN-EH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:53:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcKp-00025N-89
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:53:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso33002875e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776167617; x=1776772417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sya6TlpsOda6KIV+hWvvYKea9jRr9NPJhmjkerfAYzQ=;
 b=w8/T8/Cwt5rdYPhXxI1NpN0dtA79eQ5qkS/hSvxGxI3BZYsBFi7XL0LiUYwmqhhD46
 Tbn1Q5G8irDLVnIaeEEgxruxUbnwy0w0J+cqXzMvhtDBjHcW+W/1rQu2yKBnI//1sBts
 mm3leVN1RWqs3xD4ziP5vwUj8e8DjGHCWTf01ORXHjJ7axQaYR97ov8Ojehxt2+AQpMQ
 c63X2v2prwR9cFJOh1Owiq82VkOAyUyhuzS2NI5oiCZdeKILA4ry/2hXh+FI3nZx7F8w
 h/puzRlQZm9cn7wuFeuDbVfxVtE2AfAgsSJQTttqL26zQaGGNIAFQl7dEQifNyT7ttB+
 Tveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776167617; x=1776772417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sya6TlpsOda6KIV+hWvvYKea9jRr9NPJhmjkerfAYzQ=;
 b=afroWmQYH8OYsqTciIN7L3Zl0mIr8qW9ROR9iNoD0Ik6zac1g8vctT3efaklegBnx2
 NQ/kK+kwoOzwC2r30znGVxPZRHvMaSfGd/bhsXWaIJTFXfQcl1FlLWQm+8ye2viAueqP
 Mx1XyYIPvgSSGp231Q38FJrQu6qG0FCw+Z7u7UNB3dHSM8f2xOomFiC0iyLUHvEp6Fvc
 4+4iJ/rRNtE19fsP/Va/i9Tp1Rre+XPdyNpmd1f3klZnfjTv59LctW0SbajPy+IVYQ2q
 QXEpmT8p1OfX3ddqiBLNT9XGwzO0XDDmG394yuulKZRVNLZllAKp81aGmszCnzYlGnWX
 YvUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RfDgp9pOFrZRk2Bw4Gy8NZ1yA5slWjrK3Kzb+L+3SZcc+YS68A1UUL5+VQ7GHSuUNevf58Dq4FJlI@nongnu.org
X-Gm-Message-State: AOJu0YxfHI3M0PcwWJy3HocoH6np2SpjQHFBspYMBgsFcTqPPuE6A3EV
 3Fe8TYvmTEDRpVbTrgMB5Ny/8tlvuTSU2WVg/ROXzcRcd7bgd5S7WOK7U7q9EVKRe8Q=
X-Gm-Gg: AeBDieuH+RqPA7zkjO+7A3IYqJSwFJX7bjvShqNWtVNgG23EY9v9pAYEst6WBtszCVr
 q1AoX3N9zTE3wzGQkrEV/YODCKw383m+uEgkjxkycYYTbfnwZn2+26sO2AuqmGFOs1Y2wVNabJV
 L6dROf3edDTOIfpLkwj6g/TN5mLUvqA+c2vi8Zd7aDRMb75IYwISVXYFs0nePDUqakQ4IztWh/p
 bNrRL1z4FqoAnf4bLEbLL7j0cmaoKkTHYesR/pT9CWKyyI2aPAfoTB0nIjfsaLgKdGt71O+E8bt
 cfXTz75Yr1n8OdmiobWkGLQEKQQylMt5LXq7Cdo6IByF72UP9v8GQk2pqPz1WzhmE8uNRud5Fgv
 0OUaZRvd3Fnl+3bVl6nyTQdHyerAV8EutSImnOyVl9U8cfmAofLuPongE34iShAk4b3qyznxmtJ
 uvYNylzqe1YX2YzY2z3tYjLQTqnOrA27HJ0flURCdv+8hruoM1CkijUMHIy/D3+97kZg==
X-Received: by 2002:a05:600c:a411:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-488d67ec72cmr187904215e9.5.1776167616992; 
 Tue, 14 Apr 2026 04:53:36 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019e44sm78591245e9.15.2026.04.14.04.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 04:53:36 -0700 (PDT)
Message-ID: <457318b9-94a6-4b91-a963-295bbf44c7e2@linaro.org>
Date: Tue, 14 Apr 2026 13:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/65] hw/intc/arm_gicv5: Create inbound GPIO lines for
 SPIs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-9-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/3/26 12:16, Peter Maydell wrote:
> The GICv5 IRS may have inbound GPIO lines corresponding to SPIs
> (shared peripheral interrupts).  Unlike the GICv3, it does not deal
> with PPIs (private peripheral interrupts, i.e.  per-CPU interrupts):
> in a GICv5 system those are handled entirely within the CPU
> interface.  The inbound GPIO array is therefore a simple sequence of
> one GPIO per SPI that this IRS handles.
> 
> Create the GPIO input array in gicv5_common_init_irqs_and_mmio().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/intc/arm_gicv5.c                | 11 ++++++++++-
>   hw/intc/arm_gicv5_common.c         |  5 +++++
>   hw/intc/trace-events               |  1 +
>   include/hw/intc/arm_gicv5_common.h |  4 ++++
>   4 files changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


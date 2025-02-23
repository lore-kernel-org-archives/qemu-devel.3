Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6BDC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 18:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmGKb-0000kf-TF; Sun, 23 Feb 2025 13:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGKD-0000Zg-LE
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:03:38 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGKC-0002PM-37
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:03:33 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220ca204d04so56119225ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 10:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740333810; x=1740938610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2p5ItlP4IjhUUNE51b2bR1CHi07WnXqwWOQvomjfRms=;
 b=dxiiktJhrQaDDNSJW6kfdieFOYUcISvYCzkcBl4ksV9btwdmt1gxsrj6THpX9EBb8B
 6sRNptjq6F02AVEOl9CbqIYCnQqIaWgBavAfYE/8VWLd8hC3s4T5tY/uZasMKIOk05Ix
 g9zHSW0jnKElJbWDwGv4BaSerh45w5HMXdABNI4Vha0A5IrpeAZgRdmmqV9RYrmKb3eM
 JcPuSVVMeNFVcipn67vYWsR9tYZC8//ipbrTMPd9H3/OrWdUe85MY1FTZJkWHPRhje/2
 zT7HuOkWmtD1mxYEAaCndHFyonAgbEUQh6UJi2AM6jSaPQM69haUZG0C7ZpVf8AVNTK5
 L7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740333810; x=1740938610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2p5ItlP4IjhUUNE51b2bR1CHi07WnXqwWOQvomjfRms=;
 b=HRR0OR4xwAtmH9uDbQf71YfrWgPX97gEqM2qgH9/PiydUKY9hX4rmgxPiRvsYkBh2m
 GeENTXrKbXdDv2TF5gL0F3GB+h9t6wLw5BXLnhsxdzXjJ93KYFk3o8EUyuJNa0yQv+sj
 mc6O/3uYR2d/qrcQRDCGNjaLjneQaoFqQF98tB1QbiMFxfcc+S2y1oqpgDjWi3+6hVs0
 3fYurotxILi9Veafs+cqlPVGdTNXA7U94PVZoAqa02Zd1qz/6J2Bt5U2KaSia7X2DlNd
 XNCSQrKLQsO4Z/lGOy9N575SC5f08hQTUHmuXoZV8eYxOULm34SU5/4mKc77wExU4wpN
 hBQg==
X-Gm-Message-State: AOJu0YzB6Wo2nhluPSPyu29zjOzZ89qrecSLxDdSEVShcESMa/tCKaIg
 L8HYQ5KdyP8Xot+AJ8K/1S9/WL1coKAvqMbJMwP5UlSh+KXmnHhghyJ5HAjvt5RpiUAtQFle0Ao
 T
X-Gm-Gg: ASbGnctBunlXv2C8ELNBF/h/8hytg2yDE2bTUYXeL1ihYgf+p0OpUQ+OeVSSB1AlQ2h
 jTSbNpxO2PMt42aTTU+X6kRluLGOmN3kV4OZcog1XhNq+PLc+wwaCcCLP0PHaysWQxYuTN7+qh0
 sFkQ9uCexLeq3GhrHtoWSMsyzrcwhXQutYF88NLe88r1+5c9zhUp7tMeUNYK8LivOsntMhZ1Nqj
 4BVZ3AqET8bljXN7bPEW0i63EVFe3VO4bMlIGBao6DGXQvdsQEgfHQBRPufmmSJ+cyAIEJQJ0nz
 a7jXZsvczTJ7Td2N3rDlflfF4Qt3SurpuzgSWb02Hh+DZngyUt8L4K0m1+3vR76Qz7ocnSaTZfc
 mhhN4eyk=
X-Google-Smtp-Source: AGHT+IG/8HQ1tUUlSxmUw+Wt91HeehZqAbm6osjCa2Zm3e1wHDRTm/YtZXpi7E81ow2ln4gvYM70lg==
X-Received: by 2002:a17:902:d4ce:b0:21c:1140:136c with SMTP id
 d9443c01a7336-2219ff2605dmr147276245ad.3.1740333810374; 
 Sun, 23 Feb 2025 10:03:30 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb09f6e0sm5011312a91.44.2025.02.23.10.03.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 10:03:29 -0800 (PST)
Message-ID: <9ee38c1c-b32c-4dc0-9b3b-6e0ed3900b56@linaro.org>
Date: Sun, 23 Feb 2025 10:03:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] hw/char/imx_serial: Really use RX FIFO depth
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/20/25 01:28, Philippe Mathieu-Daudé wrote:
> While we model a 32-elements RX FIFO since the IMX serial
> model was introduced in commit 988f2442971 ("hw/char/imx_serial:
> Implement receive FIFO and ageing timer") we only read 1 char
> at a time!
> 
> Have the IOCanReadHandler handler return how many elements are
> available, and use that in the IOReadHandler handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/imx_serial.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C41C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcATo-0004yb-Sa; Sun, 26 Jan 2025 16:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcATJ-0004v0-37
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:47:22 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcATH-0004TP-HQ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:47:12 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21680814d42so60580485ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737928029; x=1738532829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=imZ1Zaabk+KE61lGOTKaP2ss4dUQkXJD8fp9UAK2Abs=;
 b=fn0H6irlZq/gX98OjNthpipil9jxBCmHmVxbinqSW1YBtg7ANS2mkQrA7GEOPz9DD/
 oEuANBWVlHFylYYWRf54IF8HqlQx11Qj3TmfBGT+laYzXiSPvxgOd332TA9G1gkJ4J1/
 aTy5pvnS0mA1ZprhUX396rq/yQM9Ps2ot4EXVpudRQKr9q753Bn8BGHNlL9obFG23Hnf
 /dA/bCk4U0XYeEZU19uclwgKXrN8kOM4rcjIi2JGvzjg+3WZBvvFgVzgThtnSoIJiG7y
 kpUy9EoEP6ET0Mp6G+Y1DJeZnGozRWzIdwv4xVD//gFqP2l5YuVlzixHFIEIpZyq1oAy
 2T5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737928029; x=1738532829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=imZ1Zaabk+KE61lGOTKaP2ss4dUQkXJD8fp9UAK2Abs=;
 b=r0YSWLvP4KCFRMfdG7K5tBpZlGt4YQSFe8YCnin4cXuGckj6a1DaE77wX4FtPy1GUg
 Mimt6LxIdZz+kWmC65ak5plyBOYhj2azvUaIeU9eFtLOq7xj+jrBV7999Ps/kveu4wQ5
 G+pZ1eT5H5ExwwT3fNBxGncMYo5OLKd95PUROIMyySqc+7MNcgPVyg5v813ZKKNTvYWV
 4HMW3fAKzSOEvJTRHJysHWJC9+UVWAb/XL0dWV9Hk9g8BdAVFhJyJOUKtt29Z4m/6/R+
 yfX6AEMRb+t/lkk7ZSCcocFs+ZV8csHj59ySDxBH9ao6DIgyTZdR9Fni3X4USe3vYotz
 zD2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmgMtduK7N9a0kXv1jY3UIENHr1Y7UvM2zzbsEAMZU4Bvvr8C2Es3iTrKWet1K1/tT6LNsR47Q8LlT@nongnu.org
X-Gm-Message-State: AOJu0YzObe26d8n2GJ985ZrymrjGfKobyxWXM/a665rZp2uBn2LVzWis
 z/ZX+NGW63o2Bao02oWxCq6+YeileNNE7RWLgFqa5c0oO2X5nUNhLK9lzY4vPp4=
X-Gm-Gg: ASbGncvp/TvuG5jJhNZSLomFkGrN1v1u0B8ihC9b45uNUV+FRhqEaWmAqzRm1didXct
 mnfxOXU7xcNtFZ2ukdxt5Sw0o5GgtzeklmSF6Plh6QZfl5SB7nvmowalp9Z37sQRpIVDWYqfibT
 dsNhJd7udHuHCjICb4aWC9juehRFDz1merJCpTryRILvCWXcCw1PjZbZf3I19qnoShVC2pObvcM
 +9cAtvtbJw1TjV1mujZVXbOXqhE9g4ZMfOk1IsB64vU2oI5+3U0r1i2UKfOci9M6GOtkAlGRqPX
 ELDePU5AV+dy+yTlUTDMUxvw9L2ePBDcU4yFp8M7SkVhNiI=
X-Google-Smtp-Source: AGHT+IGQAkHN3tYg1fN5NUvzz86rTfgCG+HlkmoSrq8xYOmBwetZG8kESiXUHlQIaT/sm6d/+iC+Cg==
X-Received: by 2002:a17:90b:2dd2:b0:2ee:ab29:1a65 with SMTP id
 98e67ed59e1d1-2f782c65a2amr54279603a91.4.1737928029398; 
 Sun, 26 Jan 2025 13:47:09 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa6a725sm6287238a91.21.2025.01.26.13.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:47:09 -0800 (PST)
Message-ID: <c7eb9a1d-00ff-43f5-ade6-8b8de93e2f7e@linaro.org>
Date: Sun, 26 Jan 2025 13:47:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125181343.59151-1-philmd@linaro.org>
 <20250125181343.59151-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125181343.59151-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 10:13, Philippe Mathieu-Daudé wrote:
> Some TYPE_SYS_BUS_DEVICEs can be optionally dynamically
> plugged on the TYPE_PLATFORM_BUS_DEVICE.
> Rather than sometimes noting that with comment around
> the 'user_creatable = true' line in each DeviceRealize
> handler, introduce an abstract TYPE_DYNAMIC_SYS_BUS_DEVICE
> class.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/sysbus.h |  2 ++
>   hw/core/sysbus.c    | 14 ++++++++++++++
>   2 files changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


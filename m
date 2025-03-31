Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C567C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDCU-0004UL-Np; Mon, 31 Mar 2025 07:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDCQ-0004Jm-MX
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:21:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDCP-0005Zk-6a
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:21:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso2460491f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743420059; x=1744024859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=19QQKGK0k/Vn5NqbyH+tqJ21Kn6WG9tfDwjmE3CyB+8=;
 b=K9OoHEjB6ujHbd5dM+WH/ezsc9ZWh9uN4OTq4OrW+A0iSySggJALee8rthccbEMfNW
 Mrb7oPTseAlRFgsgqpJEDboceTr+fRWQVn3Wil7g8OOFD6QSnbXXfX3YZcuY1kV1fzDx
 DsmHnTgsUeSLK/RdACtPQaR04UwAzZfdbYTCIF4eFoWKCMNWI1ru4+5SIWbraE/vdYSM
 ZWto/V1L/zh79QJZdlipxGV83PkjzU+cA6qJqFX5jBI6cKdpnEUBFrg/z6db+7iJRm/L
 n0QOs1Kap8X/61iiIE5R6Lkr3cMzfq4qufY/GiyvXcOUkdMexRotlM+7Xm1xU+6zwXaU
 sQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743420059; x=1744024859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=19QQKGK0k/Vn5NqbyH+tqJ21Kn6WG9tfDwjmE3CyB+8=;
 b=f7OHJaH+D4Wpn2sg53nygpn0SlhayoB0Bq+zEGA/H5hNGNdTSewXOyidE3uKnO3mFX
 Cu6r4jXDVFEflexgvy4s+KZmZFduvLYQgSKa6OpnwgXUJFHbqkxMy4FfMjuBbfI/g7FD
 OhugAcZQoh9uoSjavFPc3q93oRBpL5zF1qC8s71lF97Hh4N4JgE7a48dnbAYVA7JTvNG
 UH712PQ8m34oe2+RniNKdMvhiaRJHSCz2h/VwrN3Cyt+74KYkW83tg72DBmBjhiulTOT
 YK9fIQSBTm+k17K4yy9e4azA57BPqERw5xiTgUfAYDILeq3t4zOJciM7usJIsZ3UC55h
 E6gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU45x+BeAxcVN591hStkiDU0KrW6/xkj3Sr5GZvzDj0qEEzvSU6jnlO2FwajsiuADapPlXn6+pFD2QQ@nongnu.org
X-Gm-Message-State: AOJu0Ywq8WDEbEU4QSc0j9p4F07Etu+g3OvmOoxrMvT7OQwvjY/EOfkR
 d8EYymZvSQ3/MQlk1sRxBIdMX5CTQQyAtORpM3rXy2x1Sjv5nYpnoez8hISbPAWnW5wKeYxywDE
 g
X-Gm-Gg: ASbGncsokq62qg/BgUSW5OmonR2RLg55jdGns59Z10oxDvcN9z1UuOGGbHx3ENzVUp9
 tDgpVdZHfTTtTobedcF7BoQFvNKAm8yXUcRmajdbDe8ASNXLFr2eeDu0sfCm35On5srMUM8C8f8
 sL7nvdjlvyUJYrcB7pmuNjHRLueGBJA5puMU1cdLEEOvDG0XO9jRVMBkCzbly1EfpEE49Z7+xUV
 WVBid52QweFhiY63Aixky8l5g/ny8J+FneH344kp8xjYUDnCUt3x1y6P7NrUqVxTHP6fPm3LSSz
 mMmSka+UaMptSzFEo6plyH84+/CLSN8NrQRhWvowUOUspa4DrNJqrX34EV/UlcXH4+h7G9CrcNX
 TIa+KdfFGhw3xlRKXlqP4iXY=
X-Google-Smtp-Source: AGHT+IF4Sl7+vRkx7ltuIIwjKStn4k6MTbLnS3RJgCGmMsyUldT+O/0/bpg5KspAaJYhBFzkuSqiJA==
X-Received: by 2002:a05:6000:4287:b0:39c:1a86:e473 with SMTP id
 ffacd0b85a97d-39c1a86e5d3mr3031636f8f.56.1743420059229; 
 Mon, 31 Mar 2025 04:20:59 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4200sm11137825f8f.96.2025.03.31.04.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 04:20:58 -0700 (PDT)
Message-ID: <d4f8ce06-932b-4a77-8301-32975737d88b@linaro.org>
Date: Mon, 31 Mar 2025 13:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdhci: free irq on exit
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <09ddf42b-a6db-42d5-954b-148d09d8d6cc@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <09ddf42b-a6db-42d5-954b-148d09d8d6cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 28/3/25 10:49, Zheng Huang wrote:
> Hi,
> 
> This patch fixes a memory leak bug in `sdhci_pci_realize()`. `s->irq` is
> not freed in `sdhci_pci_exit()`.
> 
> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> 
> ---
>   hw/sd/sdhci-pci.c | 2 ++
>   1 file changed, 2 insertions(+)

Queued to hw-misc, thanks!


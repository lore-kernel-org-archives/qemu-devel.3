Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F497D2B925
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JXJ-0007PU-5J; Tue, 05 Nov 2024 08:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JXH-0007PA-49
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:23:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8JXF-0006O7-9F
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:23:54 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso3508203f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730813031; x=1731417831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gEVOSGyr4CEMfq10EsfxiyK7DzRDk4E6HJn04Ru9LMg=;
 b=ajSTERh15Lr0JpNZ4bIygWuCMzIhHeyoHou0ny627YpkztlBO2aRk4O/xUD8YDbUsq
 401pKEAna2EY2zEYsesNWbUamBNzJZvBmpiNeqBzlYBzh0BHBoO6pvq2EqOmOg/RmSkb
 80MjHBJZ54bR1nEAIsrB9YHP5uZmypPl+AN1huCuyP5y6ba+I7+0CjtOMLTCR9STu3wt
 hOI/Hyiztwmjh8lmCiABXu16528O/5GMr8jr0HqLsau4I+XP+2IESzh+jF8Apvf9NWJI
 jhAvRVPamBBbTxS+ol3lu19Cpm5rUzuqOy5toI2YcEBPSrbFYw0BvMGapI7YcFmFa1+K
 6ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813031; x=1731417831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEVOSGyr4CEMfq10EsfxiyK7DzRDk4E6HJn04Ru9LMg=;
 b=PO/yUGz414ZDK1zhwnvJQ2uxolEp8EYcJUuW97sfQ76b9qBdjafl5dIzvMFwasmSvI
 UHx/+JdiRdJXmVmI692lo51XlOIdlWkWEP1addalNv2ntHsWy9htCgfxMgkz+VodxRUB
 s3lgbcJLWWHG+1lusjb4YorWU3+qfiN6/rxPGdaTea/AyNOz3HevZVSBwVK7ub+AwG/M
 XpsjICfrrWv10d6mkDoPCucEUM00b9SKf7O34DRDCDZCXHiru0H/ACKkvw2Wv0xwK/mk
 hSRLcx2VHJ/1j6T3CQmhktWDX98tn+v+G2s2WRlo3mhGbOZIyH53QiHg9yBem6MtKRYJ
 6sbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVryGqVkFE9M5fouO6BDgxg6ufxtWZgA9AjVjuyBhxwVj+Bxh9iBooe7OfB8hTb8GsLqXqU+Zerdljf@nongnu.org
X-Gm-Message-State: AOJu0YyrWRgqUvf82m5FUlL08cZDAH/iKXJxkkLIcYPxBvm4HlIxg1t+
 Agj3yd0fAeDeKaqzHRhBa13G67AEj71LEeDUfHFx5bzAtGcUQZ6M0CO5gR1VNsc=
X-Google-Smtp-Source: AGHT+IExwQrkauGoN8kMhTolO+XD04hN9lvxNbHXHlvCKPIRwhf6E0NXVfp0221lLUMo45gpe6TXvQ==
X-Received: by 2002:adf:a450:0:b0:37d:4ebe:1644 with SMTP id
 ffacd0b85a97d-380611e34b4mr23919641f8f.43.1730813031571; 
 Tue, 05 Nov 2024 05:23:51 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b8csm16371166f8f.5.2024.11.05.05.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:23:51 -0800 (PST)
Message-ID: <64a0969a-453e-402c-9677-3309d8fd1b74@linaro.org>
Date: Tue, 5 Nov 2024 13:23:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] hw/microblaze: Fix MemoryRegionOps coding style
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> Fix few MemoryRegionOps style before adding new fields
> in the following commits.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/char/xilinx_uartlite.c | 4 ++--
>   hw/intc/xilinx_intc.c     | 4 ++--
>   hw/net/xilinx_ethlite.c   | 4 ++--
>   hw/timer/xilinx_timer.c   | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


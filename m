Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C4CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL24G-0005TO-8E; Mon, 17 Nov 2025 11:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL24D-0005SP-B1
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:27:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL24B-0007Fw-Qb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:27:01 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b427cda88so3216313f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763396817; x=1764001617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EtL1yPRzRFJOyeu0MdFDP29cEIK5H5s4qaLsSZR9XCE=;
 b=Rph5LC3AKvXRq27Ey2TqTAQDfud3PcvHftrH9JfOu9IylKuMkBwPqldBPFmyxahlBE
 yaojRZpCjL7XKcdd4/0XE9k4Uo38RmqW5hegWhDEaVEhGPIfgRZM7UVO6flvwjDUxCwq
 8PO4WiRd6GcUUTvO/CBGSQ6VdcefsciuBiufAW9BNg/qHLxK5MoBsxbLApeKjuOmpxaO
 SP0ENJf1x/AA9FWq8xo47jQ1cFKgKPKbta78UHW2s+4lMZRw+M29qhBiLEUu68jNWhUs
 ka7Zazh6oSKo4RwGxsCT1rO8kITgHES/4DsckjbVyORNMRxhlGzSQfs/l5yGbSqtdesc
 6ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763396817; x=1764001617;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EtL1yPRzRFJOyeu0MdFDP29cEIK5H5s4qaLsSZR9XCE=;
 b=Q1+Yudi18xsWw/opsbYvAZdwSq+f/8wHn2QmPsJnVFxktrlcKpFcEJ+oJWJXZOsi3U
 PBUyw9D2IC313LSzoBZazYWCXa5FLRm0w3GyJgtE1scBvr7kZ0c5M/TCW9XMknt9Zowm
 PvYRY73pE8Vvu3zVeaGUhoNMh7a9IzOpGouqmNXuKpB8yXfsFsfxTmvIL+n/YxilEAWh
 o/vzaNguFW7n1+4RjP1QVn7Knyrwb5V1qp80clPQL0gPfsSFjz3zOZUHRJWejBqTyjQB
 5FMmUNMMXkdhxIlVdEmRAQUbixsR0ibLg9J2gU9PKFQigYatJfg8TvEG1Jl0hz9EfSj8
 IAQA==
X-Gm-Message-State: AOJu0Ywf2kEGpA+Vk1agtIC14gyjIrAUIT6GCaddsiwDK6oSB7y02ASF
 aPMQjl1o7qCyvhIIqu1OLwhi033W6xKeuYJysBaqp6cyrkBAdX/pIh7JEuCLGxWYu9oUR6zLQC1
 ld4vwVwo=
X-Gm-Gg: ASbGncvfRT1bXCxkNKbGAyzG2VKf4RUwvWDPMj9TPyA5glkTJDlBAY9XQWCZ+TGpTG4
 5m0GlwC+yVb+/uPaw4ndEyJJ8v7q6KPXptZGZREKZSAH45W403gFdwqLZzxHwiY55QUqynXT8sY
 XdO0N3VkVFsnTPJsXr6qB45BtpQggoJOHlGLTDSGMWel+Ocq4diQ8JA0uvCWAgXLuTBOspaO9a2
 U0sbo1OeUOPet0utlDnTShh9gEhgwieAJflj99cqMKPMZAHOUyAArfCx6IlzCrASBnKc8DFQ7jg
 moHvTosXjyHPj2kiV7PbCMjtBItJdb58h1zifz7rLsszno2e8cnz4mrSARijL3Nr46jO0EQdtdD
 6wOl71fI47XOJCWIpGtPFH7iC4BhmGMTUVAKTIzHWy2GINpoUJA5sOZ2kBE/9BOz4/HZevyX4Ge
 iEVl49fHLOrrx7eVsZaGsvy4/YHVxsP79Iqh6May1fsyxQpqlnBqt//VuwB9r2
X-Google-Smtp-Source: AGHT+IHokMC+SSq7vr0KJH6xw/a5H9oIMUgtp3HpsI36zTEXsnAZQjbvgYpm24bHdSFsuy6BNRzrlw==
X-Received: by 2002:a05:6000:2f83:b0:429:d3e9:694 with SMTP id
 ffacd0b85a97d-42b5932360dmr11698978f8f.5.1763396817137; 
 Mon, 17 Nov 2025 08:26:57 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e845bdsm26164210f8f.12.2025.11.17.08.26.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 08:26:56 -0800 (PST)
Message-ID: <b7d5b2dd-bdb2-49f5-8345-d55d5d74a65a@linaro.org>
Date: Mon, 17 Nov 2025 17:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 07/10] target/arm: ldg on canonical tag loads the
 tag
To: qemu-devel@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-7-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-7-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> @@ -444,6 +449,11 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
>           return 0;
>       }
>   
> +    if (mtx_check(env, extract64(ptr, 55, 1))) {
> +        shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
> +        return (~0) << shift;
> +    }

This should load the canonical tag, which is 0 for bit55==0.

The ~0 is wrong because it's not 64-bit.
The field also needs to be bound by gm_bs.
Something like

   return MAKE_64BIT_MASK(shift, shift + (2 << gm_bs));


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE71CC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMWy-00014T-VE; Thu, 19 Jun 2025 17:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMWy-000146-0Z
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:10:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uSMWw-00088F-EN
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:10:43 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b31cd61b2a9so798699a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367441; x=1750972241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=doispcLdjhgjFj+m8tI7JL9j3VjtVrSPgU7tqYOuvFw=;
 b=YAAgZtEYrUHBGyq6KsoqUXTDzjXwaaNTAklOlGATX5oCUIrGPp4u1sHsb3Za1XWdRQ
 1FMWCjkwcKzqJ8cBp+0k0iCNhR/vmJZ/V2BhbOwVd7bzIhGT8LO/sKPYwYRiLsWZ2Kfv
 FvrNUo4okI+DaYeRkf6mnVBiQ9lcrZgf4NyvvZOo+/7/uWXuOJUhFH1YnNhGVH4tb1qi
 PMF+jcoFPbd805jYtdYFywwcObGerDjlu26Mdpy0ULPvMI1QrPT1ga/6DgDoHnVL+Bnc
 xO5252URTO8oZlfiX1+Y8+obg+tz4XzOwdfavDY85EILcNb28tKx8dh2TZdJMMty7LVU
 kbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367441; x=1750972241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doispcLdjhgjFj+m8tI7JL9j3VjtVrSPgU7tqYOuvFw=;
 b=vq9fVGv5SE9l2W+620v41zwsveGzRuVkV3krNv0GuHWe2RKYOq39YyzCN0mJVaCk5k
 USD8TQ5rK59Th/u+jcUtoE+OXWUTcMwBNMGCcaQ6bC2oOfcfngf5WEUy6ExKebzP6OIQ
 P2h5xhFTxL/OV84MURTUGeAmr92rZ8sMqNZB2VWWvZhKLEhLFuAxYtSoiKrX8CdP4Ymu
 0YkdWHVNJeLEpaxgw8iG8vZ0oiXhVzXKs9yeLh4oypDzeVFsqtIBMl4Ra6D81rzYZOK+
 pITfBBuuZfypkQ9fhqginNIMnLZUY507W7y096S6SHUcCzUrd9C+CM77Rhv36oYxi/Lm
 JDWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYYRZ295ZUEaxgm9zewgT+SUYPGK9aPZilrmYSU0zrXJRVoahfqaLqN6RBiEXugEtqkVlF9jCZJbNK@nongnu.org
X-Gm-Message-State: AOJu0YyySr+/jufl/I+qboAEDyOmoOsDrKdpSDGQ8da+lya8Nxs3DzdF
 oH/wHJhrFCZsPzIm8rFy1fqZticiE4jtPd2Tt2AGKe3CfwWT+nZk9hGYk5xdmT9QyK6dgcXG3Eo
 tcyZ5nkI=
X-Gm-Gg: ASbGncuSRun9KcknbpF5exZUj3ztOHTrW/RHVqHIv096PSkzhqsaeQT+sPMyvgGhKqj
 l89Rq6ZWUJ4a3zuE+OWe3gZcQvVqtG2aVlqZF2lc5yogJuqQGFMN5DoatD5eX+Vvv9HidzF+x0f
 CHBL/3FXV52vfriOP8r/2tIQeurysJ9obckdD3VvU1harhMakuSqdd8omZfQj3YE2lPPOal3Qlj
 iEf4DGp+KtULqonFUDInKyRUKRNh5VSTnwrXCW7oCVeHUQvf3c96bWcJQwukxjQINmfLHOLJfgg
 EyEhzCGLUSXp7CqmtaUJN2vrZ7FDvo1Q3qM9hkJBzBnEV11xNhfYqAJk3MgO5Md7NXZkhwFBCkH
 5EScF052jmkb/lop1nhDV+yHtfdCL
X-Google-Smtp-Source: AGHT+IG1f26UpClk6R3bXEhT1MAsIekyfEDr3B3APMjv3xe9Dm03IF3ZGtnie/Vjs8pNtFzGlrnA1g==
X-Received: by 2002:a17:90b:1d47:b0:313:2754:5910 with SMTP id
 98e67ed59e1d1-3159d6803ecmr994104a91.15.1750367440786; 
 Thu, 19 Jun 2025 14:10:40 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159e06a78csm175186a91.34.2025.06.19.14.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:10:40 -0700 (PDT)
Message-ID: <e089943e-a6d4-464f-adae-c972eab453c0@linaro.org>
Date: Thu, 19 Jun 2025 14:10:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] target/arm: Reduce arm_cpu_post_init() declaration
 scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250619131319.47301-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 6/19/25 06:13, Philippe Mathieu-Daudé wrote:
> arm_cpu_post_init() is only used within the same file unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.h | 2 --
>   target/arm/cpu.c | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3029CF885B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swpLk-0006I5-7s; Fri, 04 Oct 2024 16:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swpLh-0006HC-FO
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:56:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swpLg-0002Z9-10
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:56:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20aff65aa37so22800075ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728075386; x=1728680186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8PPpPO75T5twVmipYB2GHROw3cq2g4c24z0SB0DpNc=;
 b=IRmHcFQVK16fGgGsamQiwFkgxwC7R+Ur/8JEKElA1cPXs2wYRPa23gavliJNKGCSjK
 2bfcZnbaLE2WO0D0sxAEkKs2Hpd4D2wRydYQiiVnDU5nCQ5j8Wg1IQHNCQOimF6BYEhk
 kiDwVjQruPb1R5xs6wTkty2Iylayhs06N9lCGhj+T4BroERQhQp4LK+VwYE1goG2dY/V
 UtF/hjncgPeYLuvmS0IJLMscN2UlvaBy7YScMvMUOToB8mvC4ccXNQVfWw9s+aoHI03p
 BMtK1hW75igIlldTAteR4NKNpmqKuvhW+BJDx/nVdmwH2Btcx4MbUDkkUJDvoL9KnI0a
 9AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728075386; x=1728680186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8PPpPO75T5twVmipYB2GHROw3cq2g4c24z0SB0DpNc=;
 b=En8kVBX6wKesawnz3gXvs/HpZOC3toqTEyeHKhpzBJoha554vLY540EkcX2E1U/YuV
 ic/Xbdcs7QCGqfZYHc6CqgSqO3/Jlap+t+u7L1GlBZj1gwCyfUQj7crKHIFFEm4SiOgp
 x8+p6eASMVZcdvJghKg1k2a6ssiR1TmB3UdvFuhEQndpNzeuh9juY7KSKZV6G0pP/4oC
 bpOH0iYm6ye1vg/A5xsIx9TluN1Co9eOImlDsT3D2UMWQtc8wlYFvbwlApfgHGusGcww
 mFC6UaK86nQbfBa3WxESd0B/k7984rqkC+jM5pY6ELzqW9YLXCklxT7SnKTOp9P524eF
 1Qow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaXWcB+BMFE0MCGfeZpvNkcx+Zo0f+DrnCpAoRmdb7RRPy0Eo/kT9frv5uAzG1bZ+6LayRw0ZQ6pE6@nongnu.org
X-Gm-Message-State: AOJu0YwrBbXCUhnsk0y4JU3tY4BSW/dO4e+EPiiMG9yYXPhvkviUij+a
 SsYOplai6R04U3rtILE53l3NV3F9l4JdGYWMMf+hb4kAZMsaq5NwEqnb7vGBaUOMTQfgzx6dTR1
 v
X-Google-Smtp-Source: AGHT+IE8zXkRv+tCD3HsVnekooIMmJQN7t+99nb1VCfviFeIXdCbhggu20SBYNhprJgbKzcjRB7jEA==
X-Received: by 2002:a17:902:d484:b0:20b:8d7f:d13 with SMTP id
 d9443c01a7336-20bff18bcdemr64744765ad.58.1728075386505; 
 Fri, 04 Oct 2024 13:56:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f681f0dcsm423968a12.24.2024.10.04.13.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 13:56:25 -0700 (PDT)
Message-ID: <31d6bd79-99a0-4d91-9dbf-7a8b3c51d039@linaro.org>
Date: Fri, 4 Oct 2024 13:56:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/tricore: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20241004202621.4321-1-philmd@linaro.org>
 <20241004202621.4321-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004202621.4321-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/4/24 13:26, Philippe Mathieu-Daudé wrote:
> Directly use tcg_constant_tl() for constant integer,
> this save a call to tcg_gen_movi_tl().
> 
> Inspired-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


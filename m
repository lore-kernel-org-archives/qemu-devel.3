Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0D8CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7HPA-0006zT-5q; Fri, 10 Oct 2025 13:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7HP7-0006yp-DY
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:59:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7HP0-0004QY-6h
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:59:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-793021f348fso2246155b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760119167; x=1760723967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXkpxOQHOop/5dkGVdqRrr2lY0lEAVdOsea04T29UBc=;
 b=tQTmWpv9L27QQ1snp+wkB+lbpnlUhInPm2k+ZIPnXSESDWA+rcfU/o2I1WJoHuNurT
 38jR8G8YqKr6FTlI+iqnr2pucFyB+r5F6bDFc9uR+oo5h3uvEX1nmRq+k4KVN9HG0nzQ
 F8FTzV20KrL2H7z3fp4z0FHaXhfa7vm3ZH8zRv5xbe4MiIKZ4v5c6uFPfAUHNt59h7WG
 4Ek/RKWEDUiCM6xQDOj1v/SXK7aQn9qiikjzOrggCVfChi6Iy6Y8x9SIZfYs65WQvSDN
 1vW6SZTnfEUfTdwN9qD4Uij6EplwYEbLDS9dBgBiLIgMt0fBSQcdStWtjCkXxoOcxu5Y
 ByeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760119167; x=1760723967;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXkpxOQHOop/5dkGVdqRrr2lY0lEAVdOsea04T29UBc=;
 b=i3xNmqEghoktQPVl5wcwZeuX++DMH+Vz8Rdy7fCNKRd+VcSERHyrRYtVZ4gObKQHeh
 RuSIEY/r3iMn/czFhA8lou26QlQCSxXk2rNPH/v92i0J91S94VxBaWu+Ij6QV4gA2wys
 Gm4TTOOnGUbpnRHjJvBlKJW1awgv/9SLIR910blgDs8z91+TIZ6iYoc3HXZ0Bs5AhM1M
 +CZ7hVK+iP1lx8Icuah/glOIwr35NbRG6FVbhKXpeLW+2GhRhoW9CqdJ6NWRkrZMOZ/j
 C9Cgx/PcY1b0rNOiZm4593DaAqAIweU5o7/YOvVVtluGZvAhPr3MjBZC0GjPPvg6U+dh
 oO3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmMlRYtADuuWArSWEwvHHadSX839dGrYz+6kYshsv533XknOW3cDyqMWrr15PS2QgKhUvOqQe4+kLw@nongnu.org
X-Gm-Message-State: AOJu0YyoVJ8DZ1K7tinTWPCEdvnTcpDBSvMyIQlvv6g2ClVQPxIYln6N
 89GewSzbVMVDO/s9xn+E1uRxWxeio9pVwyfjpCYDoSDR+HOmVzJaDFqaJtbOALlWLLkUA8UVDme
 SsCkH3xA=
X-Gm-Gg: ASbGncuNoV/Qg/p0YCuG2K8yPHwZIa6hfIqCWSNEnKNTlRUGBOr7uPKyBNYraHKAwtq
 difA2ias+5zVZCxiBCfNAuyPK4zZv287T6HYVQmGnw4oODzsAuF082RSu8PCvGAdEa22iUwMmW5
 Qr4X8DdnSgUQrkyOUmuyk1UXuG2V2GQLE2CH7I3Ru4RpOpaY9gs7fMi4tiPbQk+4/RoOjsOWgHz
 GmOMRGtU4VSBzqKWDQZyJ51awOGRfTwf7HC8F8NthTCGza7vQkPcI7aIzNmp4Llcj8PJC1AiYRN
 xqB0T+KxY3LwyUkbAXcuzzhBjj1BE41DLlFk1KWFTD2Qfbd3X2sKjxSEkvEIy9YR2gDvncybblV
 ZnhibL8H2a+JI5UiactLwi5/Vo6EE4ahSWY6/yFiZBgsNNtjr2PvzEa+dzjc=
X-Google-Smtp-Source: AGHT+IEr6yP75zs2d7E5+uD+BU3DYKMQZAznwx5FXVCG0Dz1JJkoeBmtXIWclkrSYskCKv9oi1rhKQ==
X-Received: by 2002:a05:6a20:7490:b0:301:5784:8ccc with SMTP id
 adf61e73a8af0-32da817d12dmr17657232637.14.1760119167493; 
 Fri, 10 Oct 2025 10:59:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0e2ab3sm3587660b3a.64.2025.10.10.10.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:59:27 -0700 (PDT)
Message-ID: <1a13bab5-6e63-4626-ac9c-f31d16bb9356@linaro.org>
Date: Fri, 10 Oct 2025 10:59:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hw/hppa: Move CPU::initrd_base/end ->
 Machine::boot_info.gr22/23
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
References: <20251010061836.45739-1-philmd@linaro.org>
 <20251010061836.45739-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010061836.45739-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 23:18, Philippe Mathieu-Daudé wrote:
> These variables don't belong to CPUHPPAState, they depend on how
> the machine is started, and only apply to the first CPU.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/cpu.h |  2 --
>   hw/hppa/machine.c | 12 ++++++------
>   2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


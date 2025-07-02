Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595FEC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzZ4-0004D4-Ue; Wed, 02 Jul 2025 11:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzYp-000494-Vv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:39:51 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzYn-0000Aw-2a
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:39:47 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73a5c3e1b7aso2343501a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470782; x=1752075582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jCYqsYcRG56I7WrAO2911LvJwyYGf1+kkqiu6NmgJ7M=;
 b=hyTCtPa4PYmh3U0+W15/Nw0khKaDKnTn261CmTyPaOeeEfeSfOT9GhAL8aoVwy9RU8
 UdwJKR+XfKFvxaC6c1mlj5sbPEWPaGOxySZXdJy73fWKrD+ukyJ0/c7rsWos2f0cVnKM
 r0MJ+AENoD12wGvZJUd/zbHynXKE/RGtVsJWxtzBkxYeD13XRRvaqQ+YO7D5giikd8Uc
 YEeIK2au8M4dLeKAusjt7s7oM0LTVm2hEfIGJlAQPZj3XZU6ON7a4ooz3jXMVnlmf/Kd
 Dl16/yRSCUZ7GaLbm23wSKA06NSoaLWhG5Ox19gEqOr1Ytd5BHfXodiGHz+cyy3IScQZ
 Ibdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470782; x=1752075582;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCYqsYcRG56I7WrAO2911LvJwyYGf1+kkqiu6NmgJ7M=;
 b=miGQqwf5X5R+37GOjucavhhulHoKDg0AwUcEokDBMKAewhxMxClqjwKt7FZoGHbhEl
 qJbHwDbgTjUmCij2X4ASQIwuzNi6iPqS1K1kTvfmZ/vLOUYkpWTpLBDmJsRe7bNEfqJc
 FZLEymCLXZvBp4/gDb5d4rHFl7V5nXgQ54P1IJzE9jkeAUcOLhkewx8iKN9iFA/uBm8N
 eghO3yDXFt5S6EA5mylDLjdf+o/XI4yE19XN1Pa+tSHnMqh4Z4CSZ3/vo3N359BhYvLs
 5Aeiq+8t5bh0P01HlnDIvj6HT2A+nms8VCd3Z4FQy8+GUSorrpSslYmARhnc6YPitQgv
 OBfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVXne/6tOiLu6n9whELgaG/sIs11FONVtqvzHtwbIx5DD482zNLZZnFEXsweY/+mZWcGs6egs3W7W0@nongnu.org
X-Gm-Message-State: AOJu0YxZvx1PGNR/KWd0v+lEnuzY7OO0H2QyV1ZdopFiCc2Csa7P2zph
 02bY0s/r09g3mxIwTHXyYpdgfwJKaZXGVS2C00R2iMQ6QSZ7V8sNw9S4k5FySBTIRzs=
X-Gm-Gg: ASbGnctxvfqdWxE3rBk0aicMoYZMzzA7BsybW1V/Xi6PaokFPCKIPkInURLZ1q/Ljdw
 sFNLZwGi0DELXn6Zj/kbBWhL4NZgNng8uGGhs3zzXAkcPhq8M+1S31grBoHG6t14NrV1YS0nncJ
 wepiA1d3QKftsnAQ101iJSnKhQrp0on9bjH8rZJFgHqydYOMzORPONhBVsAx0C+NCy5QQ9nY9Qo
 e6ppV4UdthX6H5uGtlzQ5qsoCOqnq+TNZID/aDVISON43oafyF+yGFWrtGtiWdNNC7pLgY3A1Nc
 LFm3IN67p5PL04PdlIY0rvdJKu07nYpLpWwegqod1Ixt1tYcqUdNBT3m6h4v88PHOa7QNjl3kkd
 k
X-Google-Smtp-Source: AGHT+IGWYVMmG3FnQMbqD3he7mClggbeHjKsQ60WJGyxMGPbGJb6n6e2ebnvJzvZLggU79hTcpjH9g==
X-Received: by 2002:a05:6830:488c:b0:73b:32bb:7a06 with SMTP id
 46e09a7af769-73b4d1a87eemr2674197a34.20.1751470781908; 
 Wed, 02 Jul 2025 08:39:41 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb01d79csm2581656a34.28.2025.07.02.08.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:39:41 -0700 (PDT)
Message-ID: <35f046ce-59a5-4574-9911-e4db0deef86f@linaro.org>
Date: Wed, 2 Jul 2025 09:39:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 60/68] accel/tcg: Factor rr_cpu_exec() out for re-use
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-61-philmd@linaro.org>
 <a357c2ae-ca68-48c8-ad66-65a04c66c730@linaro.org>
Content-Language: en-US
In-Reply-To: <a357c2ae-ca68-48c8-ad66-65a04c66c730@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

On 7/2/25 09:37, Richard Henderson wrote:
> On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   accel/tcg/tcg-accel-ops-rr.h |  2 ++
>>   accel/tcg/tcg-accel-ops-rr.c | 31 ++++++++++++++++++++-----------
>>   2 files changed, 22 insertions(+), 11 deletions(-)
> 
> I guess this is just completeness in matching mttcg, not that rr_cpu_exec will *ever* be 
> called from outside tcg-accel-ops-rr.c.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>

Alternately, split out the function but make it static; do *not* register it in patch 64.


r~


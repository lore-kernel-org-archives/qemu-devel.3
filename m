Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB6ED68B2B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBawQ-0007VI-VB; Thu, 14 Nov 2024 09:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBawO-0007Tr-QM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:35:25 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBawH-000583-Vg
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:35:23 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cedea84d77so1010010a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594916; x=1732199716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v5qlJ+m4KZwPAkGIRTIMA1mUf2/wA0DGqiDePTHl+3Q=;
 b=qs2fURy2CtEC83meramJr9EjxT8rmiFl2UvJrwDy+jDpZJ7gZidGUBaFtvhtiVpOlY
 Mv7CWTdik8FdmBA1+kUpd9UN54uQrKOYgcfpPqJ1Q5vv6BNw74QBkTKSlb1+U1lTNyiu
 MSxUOTXTGVC6O1+4/DJ1wdF++ktNDZbl+omfpTo9HDrrhVMtDqN3z28oJUQQfR0TKuc/
 4DJTyb8Grd+OrWtQIZXSLfxCf9/Ll1t8AR01o+DRiH1798EoS7MfSUVfTsnBVW1evmY5
 MbrrznnOk9k1rmgiwlzHVzEY61M65RE9UntJ2FrY5S3chCs5VE4gQMFrt0gTQoE+SpMs
 7rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594916; x=1732199716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5qlJ+m4KZwPAkGIRTIMA1mUf2/wA0DGqiDePTHl+3Q=;
 b=DxCEV2xIEwiWebxguDesyOJKj8m/2YAVuBMIGuqpmi93j5nnY3Dsm8IihpFiCDdfsu
 UN04pw7W/xBfCj0e88N/SDotWe9a3gn1UFKPvM2q0MLnlZBxrTE04qxKF6AaJ8mQSyYa
 k85P4hgJp15UqhpKUdoGqmCKOEkkiyGo1syxRkDgq6Mm+DxsHkkx1jF83IH5MPfJYgfs
 GeLOODy6iwgwUKphJjs7fvUB5rqZQob/P6ksEvvLpCDsZP5klOcjqeh99fHklG1v9J/R
 YtYSfSLJuQBfqCKn0aC7Kb0kc1VeME7x64mKOpWrnopbmQcHyzFkOjCOcQE7VyRV7OFJ
 4g7w==
X-Gm-Message-State: AOJu0YyN3H0Wn1qRufW1MnuQ46Pos1Tm+PB3w2WeemANrDzmPeVBt9nl
 iApaHQGUIvKGb3+HfIpnuGeCgG1mZ//uymsoLf8+D4NYjjGG5sonqOrDfd4xjU9rUzSjqaEGQAb
 f
X-Google-Smtp-Source: AGHT+IHj+SX/0CaG57mtK4ohddIQtBVE+6NEaw4fcSUB31tis5RWtg+2FXoXkJ2apaQPcvbfjkh33g==
X-Received: by 2002:a17:906:9c82:b0:a9e:2e72:f8f4 with SMTP id
 a640c23a62f3a-aa1f8041e19mr660525566b.1.1731594916017; 
 Thu, 14 Nov 2024 06:35:16 -0800 (PST)
Received: from [192.168.69.174] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e003fcfsm69999566b.128.2024.11.14.06.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 06:35:15 -0800 (PST)
Message-ID: <7b8586e7-137d-44b3-bff8-307b81bea17d@linaro.org>
Date: Thu, 14 Nov 2024 15:35:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/openpic: Avoid taking address of out-of-bounds
 array index
To: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
References: <20241105180205.3074071-1-peter.maydell@linaro.org>
 <dae49b9c-0d47-4811-bd48-fdd401594609@ilande.co.uk>
 <CAFEAcA82rYdZduR73CjJr7hYWG7N5e4Dqmx5j1O=3FT_BqboNQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA82rYdZduR73CjJr7hYWG7N5e4Dqmx5j1O=3FT_BqboNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 14/11/24 13:22, Peter Maydell wrote:
> On Wed, 6 Nov 2024 at 11:58, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 05/11/2024 18:02, Peter Maydell wrote:
>>
>>> The clang sanitizer complains about the code in the EOI handling
>>> of openpic_cpu_write_internal():
>>>
>>> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
>>> ../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
>>> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in
>>>
>>> This is because we do
>>>     src = &opp->src[n_IRQ];$
>>
>> Extra $ symbol at the end of the line here?
> 
> Yep (cut-n-paste from an editor that marks end-of-lines).
> 
>>> when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
>>> is -1 then we don't do anything with the src pointer, but it is
>>> undefined behaviour. (This has been present since this device
>>> was first added to QEMU.)
>>>
>>> Rearrange the code so we only do the array index when n_IRQ is not -1.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> Arguable whether it's worth the stable backport or not...
>>> ---
>>>    hw/intc/openpic.c | 15 ++++++++-------
>>>    1 file changed, 8 insertions(+), 7 deletions(-)


>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Thanks. I can take this via target-arm.next, or does anybody
> have a different preference?

I had it tagged for my next hw-misc PR but was busy focused on
other things so haven't taken the time for it yet. Better you
take it, thanks!

Phil.


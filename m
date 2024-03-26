Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A690ACD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6fo-0004b3-TA; Tue, 26 Mar 2024 09:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6fi-0004Yz-4q
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:16:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6fc-0000Np-FY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:16:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ed4d8e9edso4072805f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711459009; x=1712063809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzNNAWRjVpk11jBRrLqvs/9vVdb0R7Y61XJMf031xHE=;
 b=CsNYYcEaHj+cbursj7+Mi/f64pqO/7uLIPjfPXzTrbbzqQcTLNbY5ySYu6Q1CroAgk
 KfUbo504kA4uKVwmBeTN/H8q1ghJg4I5dbTqiK7DX3dNIgscFHYtdrbSGDhN6wwycbpn
 E0hoZOuijZODaEW8LKFILK7fjup8PzfytOWZXUqc3VlGrjqzlFZRk/G5x7tl++moxw0j
 g7Nw+GvgU37AsNtmmXmbHeno6imOn4veIWST6IBS2pPG4Z2LyIIUzWZf0vH2ewi2RKUF
 20KAcugXna2EofAcJUnxCCGk/0bCsPIpWhnYBpoXsBtpPYiP6Q0ycu6Ih6jxFyqfcueP
 qMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459009; x=1712063809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SzNNAWRjVpk11jBRrLqvs/9vVdb0R7Y61XJMf031xHE=;
 b=YwENcpvK70ip1vhwLOAUPGSl8F8LoDDqgVqGg8WnK7JrqhUCHniOXQKU5oL9SVEuwL
 pUhFOmsq9I06iPV7sybh1h/0Gm0cLwrjJKnr4wMCEKSoHyytLop8umNOqPwutZbI/dWJ
 162jsv9PMlAkInhY0jPK6tQGgZoGeNfCuGN76REVtZEqT8oNstFPJ6yEPJWHCHAQF087
 abny5oeGMwt8hdUDQFtt9s7D7BLSh3ZkqlnT0UdQpTlbZIF5Iwb/+rXRcllkNSvXkW/x
 HTnpiH7JP/DnodQRQzKsCsgyiiftp+/VB8vLTb8SW92kdVV9LGvCDwFHvul9cmmQpMh8
 KY3w==
X-Gm-Message-State: AOJu0Yxl5gEHHMcManoVTlJsQp2TBL4CR8X1vQ0l2+xvu6//FKb1EMXa
 OVzMiO+vW3zKXya6+lw/DN+vi4PnjGJKRfGr46NSV1xKZGOycse4IZVKnoqLEsurE3RukyMepoc
 p
X-Google-Smtp-Source: AGHT+IEWK8YxzMK/MnJ8nBkzy6EptjHH7oBztv5x2yYA8FptfqgGSV9G4tcwY/ttL8s5aLhqLHVbGA==
X-Received: by 2002:a5d:5f90:0:b0:341:d811:b573 with SMTP id
 dr16-20020a5d5f90000000b00341d811b573mr1492388wrb.23.1711459008744; 
 Tue, 26 Mar 2024 06:16:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 bl40-20020adfe268000000b0033e03d37685sm12095958wrb.55.2024.03.26.06.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 06:16:48 -0700 (PDT)
Message-ID: <b4b250a9-184e-4744-8948-38f1bc72b25d@linaro.org>
Date: Tue, 26 Mar 2024 14:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v3 0/3] hw/clock: Propagate clock changes when
 STM32L4X5 MUX is updated
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, Peter Maydell
 <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>
References: <20240325152827.73817-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240325152827.73817-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 25/3/24 16:28, Philippe Mathieu-Daudé wrote:

> Per https://www.qemu.org/docs/master/devel/clocks.html#clock-multiplier-and-divider-settings:
> 
>    Note that clock_set_mul_div() does not automatically call
>    clock_propagate(). If you make a runtime change to the
>    multiplier or divider you must call clock_propagate() yourself.
> 
> Fix what we forgot to do that in recent commit ec7d83acbd
> ("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")
> 
> Arnaud Minier (1):
>    hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock
> 
> Philippe Mathieu-Daudé (2):
>    hw/clock: Let clock_set_mul_div() return a boolean value
>    hw/misc/stm32l4x5_rcc: Inline clock_update() in clock_mux_update()

Series queued (thanks Alistair!).


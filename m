Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8058AD59F5E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kpF-0002cO-R3; Wed, 06 Nov 2024 13:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8kpE-0002bT-B8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:32:16 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8kpC-0005Lb-So
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:32:16 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so9833766b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730917933; x=1731522733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7LfplvjCJAPk/OT2I2MNlohSk6Ems/0s8t35ms5sJs8=;
 b=jtIDlQDcXEAdHv+I2uct2Q1z0a8C7pnBbQmTwVCylH1cGnrFUaXLD1Hp3+y5zyjADM
 YdESDCz9sa8USN5zP870w2c4O2qj0LYeNwvjBE/PvWWyR4UqqhsO/fFHo8mz5J37J+PH
 jl4nIcpKjwRfmPcWyzBsDD3ELwVf385ON9W4/l4XBi/jOtVQu8RvcnI+2GJftoRmKolT
 auFRr4On8EPYdwdcpusDNiHlINNJdr1sJNlqBlpdRAtidBHsFVFjkO7AYQrUhol3eZAF
 Sq5Lb0QCdIUOE56Lu6PWciVDHEwvR+Flu8/s4m/4+YmsR8jWFIeYWTNBsjSAK7kbbz+3
 X4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730917933; x=1731522733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LfplvjCJAPk/OT2I2MNlohSk6Ems/0s8t35ms5sJs8=;
 b=bwWlFUHA3F1cxZvcPIeCHR/bZGW9hby1w7L/cpz2VD9pW0rJZ4roUFEfKJLxTsfFky
 Z6EaImfkh/zZ2X7xKVWymr3z73ZP5iUAMtKnRrB/VtEfHTqv8AhrG9F6V2QLdwiB/xBe
 qtYF2IP8CorSUtxTWi1luw8PmQeqwYRyNnH+SDzP0FxtFmN3n5Jf48KcZrLQxwNI1s25
 bmeBrqjELq7QNVsM1lWQo7+l4AVrvgwlss30RwctCZg7OmfyhlsDHs7YejD20lldcwBJ
 vkG0DZ+hVHOERR9RS1PntPhdypoVbF44t6dRsBHEAbPoyy0pTPT2qL/SMyiTQCRS92Nm
 cELA==
X-Gm-Message-State: AOJu0Yx27Ir3vqZ5XEalwHan9jOm3UnOKtm6dPoKskLpeJwWSs4NyW6S
 7TsJCb0YwImqeoS2+oSGmNoHIOPn4lVhLwDXAzidl7FAWZvUUQDYiP0lU7gRW5A=
X-Google-Smtp-Source: AGHT+IFJzVKanbKkIH7tWXA5efwO+bcIZvRs+dx+guzEVd/p/KZjmDaDPhMxlgjRc7JMEhvEOeZNgw==
X-Received: by 2002:a17:907:7205:b0:a9a:558:3929 with SMTP id
 a640c23a62f3a-a9e50b56a29mr2431011566b.48.1730917932943; 
 Wed, 06 Nov 2024 10:32:12 -0800 (PST)
Received: from [172.20.143.32] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17d705bsm315255466b.95.2024.11.06.10.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 10:32:12 -0800 (PST)
Message-ID: <91f2315b-daaa-4e5f-88cf-e001cf10c9c1@linaro.org>
Date: Wed, 6 Nov 2024 18:32:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd: Remove legacy sd_enable()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-3-philmd@linaro.org>
 <CAFEAcA-Ny03OHMHFKu8kSbPSJsiJRqR+qmhDOg6jsM9HtT6FCw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-Ny03OHMHFKu8kSbPSJsiJRqR+qmhDOg6jsM9HtT6FCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 9/9/24 16:26, Peter Maydell wrote:
> On Tue, 3 Sept 2024 at 21:04, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> sd_enable() was only used by omap_mmc_enable() which
>> got recently removed. Time to remove it.
>>
>> Since the SDState::enable boolean is now always %true,
>> we can remove it and simplify.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> @@ -2328,7 +2327,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>>   {
>>       int i;
>>
>> -    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
>> +    if (!sd->blk || !blk_is_inserted(sd->blk))
>>           return;
>>
>>       if (sd->state != sd_receivingdata_state) {
>> @@ -2460,7 +2459,7 @@ uint8_t sd_read_byte(SDState *sd)
>>       uint8_t ret;
>>       uint32_t io_len;
>>
>> -    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
>> +    if (!sd->blk || !blk_is_inserted(sd->blk))
>>           return dummy_byte;
>>
>>       if (sd->state != sd_sendingdata_state) {
> 
> Maybe add the { } that coding style wants to these if()s
> since we're editing them anyway?

Sure, I didn't notice.

> Either way,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, patch queued.


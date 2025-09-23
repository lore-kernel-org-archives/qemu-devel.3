Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8F0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v11HV-0002mV-80; Tue, 23 Sep 2025 07:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v11HR-0002k0-IP
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v11HC-0007HW-DS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758627215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HzNegaDg4L1UFjng9PexCkaDFjXaClf2q9B9cJK+Mzc=;
 b=W85T6lfCLwGiIndKHL2ljfxIknNgPXSF7474KHhbeF1wgrIPPhNBfergVQRaSwS1zUnnWr
 ki8rb5C4tqrsRLajLzfK3iwc3ngue7IeL5uvEvOJQALvXUxsiLkatYq3ZzlHRxX7QctGyX
 BhAvU2XbMapliFZ97jFcW4G6GdUbl3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-l67HieaoPv6K7raSWnwynw-1; Tue, 23 Sep 2025 07:33:33 -0400
X-MC-Unique: l67HieaoPv6K7raSWnwynw-1
X-Mimecast-MFC-AGG-ID: l67HieaoPv6K7raSWnwynw_1758627213
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ccd58af2bbso2611728f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 04:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758627212; x=1759232012;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzNegaDg4L1UFjng9PexCkaDFjXaClf2q9B9cJK+Mzc=;
 b=bDpa2HGNqCqPHLUnW6XL+WCDXwuWbKptNRwyKBqNJx9bAO48r1uVYNw7KVrFpuTZUL
 /o7Uenx8nNuzuoHrVJ4XFQ/a7KDuN+zzgSYIpvajroELblc25BANm/Hbo9hKWmCmNR+t
 rx3DMvYU55wA53s3fcI9lqgyzxbXthJ7mEmptWegU+IB5kTlPAAz36Q6mZ16EmQlYeFF
 zjDVtmvbCiI9ljwoRoVDX2eTjCgEiAIMHYhWoxg0gOk2b09dWnF4YeSadfobhzwmTWeK
 euAIrRnSAKHhd8MxaOgqSnr6abgCSdQv9lhMRF9irAbnsgD2nZm/od7q6F6wG7P0dgvC
 p37A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXpiE4CVUGQm0yNpctFzSo5nV96GXFvf3pKnwu0u2Gmdz5EDYBXc8M21Ts16/vPoy9kL0Fp2YrG9zI@nongnu.org
X-Gm-Message-State: AOJu0Yzci6mPb+S6PbJZSCPTFFEEjrm9QVQisk/+Au6dsclapdZc3FQB
 zYEuBf57npUDU5N7F6qF0KzAWuIHUS1Um9LYryz02VtiaVZeTewhI8HkMlVCtBeHEcxgP+sfkDK
 GFH0BAJxn4g7Gvt39FL+vW1RcszVpsg357RLoUD87bGrWpgy7VGgQCkCV
X-Gm-Gg: ASbGncte1zaL2SnsdxOU72PRejUQtj6Dj3lQ56vUsBXKIjTk0gCqFbR2a4BPGLiF5OV
 McLo/Yayo9E0DMSoNInZz3rFW/VgreqEuOGoChVwYeXQpqh9q0PfRN6kzQXVw1vOeeSbuApDBcX
 D6GBhtGnR7N5lGA0r4d7FwU7D78DJS264wMsi+dMx9ntgheH8GO+NrPJjroFt8AWeBsY12L3M0K
 4wiVS+9NfLfrENAwT36i/MxV8e4R04On1gHA7EvsQ16G5xYA16lkNqsXPsKqByth46NgnDVwwuG
 D6H8cRHlc2BTz4QqgyKn+bJnqVz5zq3uVz+NRSfPBUaWEB0V02vO3/q6zJMg4XN6Oak0CeJDcml
 dbdQ=
X-Received: by 2002:a5d:5f92:0:b0:3f1:aff4:1c77 with SMTP id
 ffacd0b85a97d-405cf9c1bcdmr2002126f8f.16.1758627212400; 
 Tue, 23 Sep 2025 04:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENdOR6XRJrrpmrPvUTc8isJe5KnSdThs65YF9XJBIUxkoLYnuDnTUBTod//mW3UvkLKqcHmA==
X-Received: by 2002:a5d:5f92:0:b0:3f1:aff4:1c77 with SMTP id
 ffacd0b85a97d-405cf9c1bcdmr2002095f8f.16.1758627212000; 
 Tue, 23 Sep 2025 04:33:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1b578ac3sm42738895e9.9.2025.09.23.04.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 04:33:31 -0700 (PDT)
Message-ID: <5003d6ba-bf7e-4bdc-9c22-7360024536cf@redhat.com>
Date: Tue, 23 Sep 2025 13:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP and
 ensure correct device realization order
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-9-jamin_lin@aspeedtech.com>
 <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
 <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Jamin,

On 9/23/25 10:31, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP
>> and ensure correct device realization order
>>
>> On 7/17/25 05:40, Jamin Lin wrote:
>>> AST2700 has a single SCU hardware block, memory-mapped at
>>> 0x12C02000–0x12C03FFF from the perspective of the main CA35 processor
>>> (PSP). The SSP coprocessor accesses this same SCU block at a different
>> address: 0x72C02000–0x72C03FFF.
>>>
>>> To support this shared SCU model, this commit introduces
>>> "ssp.scu_mr_alias", a "MemoryRegion" alias of the original SCU region
>>> ("s->scu.iomem"). The alias is realized during SSP SoC setup and mapped into
>> the SSP's SoC memory map.
>>>
>>> Additionally, because the SCU must be realized before the SSP can
>>> create an alias to it, the device realization order is explicitly managed:
>>> "aspeed_soc_ast2700_ssp_realize()" is invoked after the SCU is initialized.
>>>
>>> This ensures that PSP and SSP access a consistent SCU state, as expected by
>> hardware.
>>
>> The SCU model of the main SoC could be passed as a link to the coprocessor
>> models, like done for the timer model. But the problem is elsewhere.
>> I think we need to rework the coprocessor models.
>>
>> Currently, Aspeed27x0TSPSoCState and Aspeed27x0SSPSoCState inherit from
>> AspeedSoCState and looking at the aspeed_soc_ast27x0{t,s}sp_init handlers, it
>> seems clear that AspeedSoCState has too much state. We need a simplified
>> version of AspeedSoCState for the coprocessors.
>>
>> Please rethink the proposal with that in mind.
>>
> This rework is quite large. To make review easier and avoid an oversized series, I plan to split it into 3 separate patch series:
> 
> Series A
> 1. Move the boot ROM helper from aspeed.c to aspeed_soc_common.c and declare it in aspeed_soc.h, so all ASPEED boards can reuse it.
> 2. Support vbootrom with coprocessor.

This should be quickly merged.

> 
> Series B
> 3. Migrate all ASPEED coprocessors (e.g. SSP/TSP) to a common AspeedCoprocessorState.

Is 'AspeedCoprocessorState' a new model structure minimizing the number
of sub controllers ? if so, looks good. Could be merged fairly quickly.

> Series C
> 4. Introduce an FC SoC class.
> 5. Refactor SSP/TSP to share common controllers (e.g. SRAM/SCU) with PSP.
> 6. Gate SSP/TSP CPU power via the SCU

OK That's the long term goal. Let's plan it for QEMU 10.2.

Thanks,

C.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242B5C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOx4i-0005vE-Ga; Wed, 03 Jul 2024 06:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOx4g-0005ue-Mb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:18:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOx4e-0007zC-9j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:18:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3651ee582cfso2879819f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720001930; x=1720606730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+Za4OZV4iGlBv4Td+EAG1s1wAKssugjf7cdglVy8zM=;
 b=h/rBuNIsdDCrQv17CjgDADHcXul2Elle8qwlyArmqI+LUbaKrGR/GH3S0lRv8S+3D2
 wpwfdHWnAIFH/A1qyto6ROVSkGOqIqzlOX/EFyCRPCBxArGvjOKPFqS/qXyDQIxj/3Iv
 cnZxSWwZn+ARi/TtwfQGiBz6JYFBuSHUV4G3OKajDZdtAbGJZZx5jgHMvipgG9tbG9qY
 BSTKPlgfr0NGSqJQA/OIuZSwK96BTzLbHU6O3X6bhguD57sFZALk5VIoNuTdyi09YKo3
 33tXgEAidPq5NUJgSYOkV21gU0519CeR8dAysilPd9wp+NRyKtZ4fyQryjV/a6DGJwKm
 amKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720001930; x=1720606730;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+Za4OZV4iGlBv4Td+EAG1s1wAKssugjf7cdglVy8zM=;
 b=VdDlRCG2GvOImHyhTJrffgngj2v3HiyX1jy0fpbXM4OHhshWO4So63jJgtkqV4vSep
 t6SWK3jariqvbkmfBdZfcSbRoAa9q9XcYNdyI5swW2wZpeIBY8WgXa4BP0uCU4r8DO6+
 l9tOvZk/BLRH9XzyHaVUI4yRJuYwKEBQ6krwNiJl4Sa62aBxmi2fbCf8Hk3bXHOvdPYj
 0mlH+a0KluheaXO+CwkgSSROn7d4H61iYdx7rq/1GPh73lNVltUKUJbBc2A3QHYWQeVB
 YtPM/JPmIvHqRZupP7F1ebKVqSilltPUrCigj03cjYEDe0pVyYU/PlyKh0xUOOlcf5rt
 K6pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEPgsKb2lPP55t+hHQifUMGpDdkNQCd9hnzuUhVT8Lq5taNwORNprygwZ5xeWrxe46RdrftkOvUJZgy0AEPGdeAbk7YaA=
X-Gm-Message-State: AOJu0YyNjTRZHWrII84owdvXyqaeteMQxmk2DlPJ0JgI8HKdA/S2Mn3G
 GAd5jbYlfCYxtIm6rUcWTijDOUsubsTuEqdXqKvBrb6fZDvihtCtU7gf12bMxb4=
X-Google-Smtp-Source: AGHT+IGDLBAa2FwJgaRca0w84XxLI6cq9BW/mb0IkaWVx3v68moi57fW/quPqBLZEiA3/QY7BSw4Wg==
X-Received: by 2002:a5d:65d1:0:b0:367:926a:7413 with SMTP id
 ffacd0b85a97d-367926a75a1mr1157464f8f.63.1720001929684; 
 Wed, 03 Jul 2024 03:18:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1046f2sm15403984f8f.112.2024.07.03.03.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 03:18:49 -0700 (PDT)
Message-ID: <f90d9d31-e466-4214-92ca-1ee7cfae4aa3@linaro.org>
Date: Wed, 3 Jul 2024 12:18:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
 <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
 <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
 <2b425f32-41de-4057-a8d0-79411f2519b4@linaro.org>
 <aa9bd7c7-1b4c-4f3a-975d-1ee7931be422@kaod.org>
 <dedc8d45-42cf-4474-ad33-9af44701dcb8@linaro.org>
Content-Language: en-US
In-Reply-To: <dedc8d45-42cf-4474-ad33-9af44701dcb8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 2/7/24 22:05, Philippe Mathieu-Daudé wrote:
> On 2/7/24 18:21, Cédric Le Goater wrote:
>> On 7/2/24 6:15 PM, Philippe Mathieu-Daudé wrote:
>>> On 2/7/24 07:06, Andrew Jeffery wrote:
>>>> On Fri, 2024-06-28 at 11:16 +0200, Cédric Le Goater wrote:
>>>>> On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
>>>>>> When booting U-boot/Linux on Aspeed boards via eMMC,
>>>>>> some commands don't behave as expected from the spec.
>>>>>>
>>>>>> Add the 'x-aspeed-emmc-kludge' property to allow non
>>>>>> standard uses until we figure out the reasons.
>>>>>
>>>>> I am not aware of any singularity in the eMMC logic provided by 
>>>>> Aspeed.
>>>>> U-Boot and Linux drivers seem very generic. May be others can tell.
>>>>
>>>> I'm not aware of any command kludges. The main problem I had when I
>>>> wrote the Linux driver for the Aspeed controller was the phase tuning,
>>>> but that doesn't sound related.
>>>
>>> Yeah I don't think anything Aspeed nor U-boot related, we
>>> model CSD/CID registers per the SD spec, not MMC. Various
>>> fields are identical, but few differ, this might be the
>>> problem.
>>>
>>> I rather respect the spec by default, so until we figure
>>> the issue, are you OK to use a 'x-emmc-kludge' property
>>> and set it on the Aspeed boards?
>>
>> If these differences are eMMC related, why not simply test :
>>
>>      if (sd_is_emmc(sd)) ...
>>
>> in commands ALL_SEND_CID and APP_CMD ? The extra property looks
>> ambiguous to me.
> 
> I'd like to keep the sd_is_emmc() check for code respecting
> the eMMC spec. I believe the commands in sd_proto_emmc[] in
> this series do respect it, modulo some register field
> definitions that are SD specific. So 'x-emmc-kludge' would
> be a property to allow eMMC use -- without delaying it further
> --, by bypassing a *bug* in our current model. I'm willing to
> figure out the problem and fix it, but /after/ the 9.1 release.
> We are too close of the soft freeze and trying to fix that
> before is too much pressure on my right now.

The problem is in the still unreviewed patch #86 of this series
"hw/sd/sdcard: Add emmc_cmd_SEND_OP_COND handler (CMD1)".

SEND_OP_COND should put the card in READY state. We are not
considering the BOOT_PARTITION_ENABLE feature:

   > When BOOT_PARTITION_ENABLE bits are set and master send
   > CMD1 (SEND_OP_COND), slave must enter Card Identification
   > Mode and respond to the command.
   > If the slave does not support boot operation mode, which
   > is compliant with v4.2 or before, or BOOT_PARTITION_ENABLE
   > bit is cleared, slave automatically enter Idle State after
   > power-on.

Then we don't need the change in the next patch (#91) in
ALL_SEND_CID.

And likely neither we need #92 (APP_CMD ) but I still need
to confirm that.


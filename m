Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF07C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1j2-0007or-5D; Thu, 06 Feb 2025 08:15:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1if-00079U-6l
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:15:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1ic-0000Cj-Pz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:15:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38daf14018eso640586f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847697; x=1739452497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iBsfRTBbili60dM4p145yHA5F02QK7y1Ngn8bKt0Bvk=;
 b=KcHX/sFY9dL8Njj3VA0kYthm/kI2hB0PI/ttIfwOFmygzPfT1gFVBdPRRvjYuplCRu
 JFTdeD2Yl0n7MYJG5MozlGvdGbXmmuySQ3zv5OdQwM93FtwSW3PRJkZgH9jCKTJl49lc
 mbN3MJ0DTwI2r8fcoB6E8FrOkZkEmooMYHvGdHStaSzyLNvLcinUCZAQVzZY5kCBH7Nt
 1n6Nu18y18aLGL0+G7KfTBWhu6DPsvfaYkEjYfuODoWp3ZT7Kco1zMOI0pPVlJ9pyIwj
 q2cUN787MCsVfKe3ZZ88IZ4PoVJ81iBYg/O4jiPvgekMKlUZx1hXCpljnxu3mBaV9ZpY
 tyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847697; x=1739452497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBsfRTBbili60dM4p145yHA5F02QK7y1Ngn8bKt0Bvk=;
 b=e1STUPVP//Iu4f6cSTVTQiD3DwTJzxgsPJnUZ2z9X6ROV2S/kqmc7Uvllu2r9LCgcU
 hOWYWkn0eYekUr5lM3BM/Rp/wyCl+hLT30R+RHpfHjwnNe8htwf1S2KgsufKwHO0XXfF
 tPp7DKRdYCyM7GZDxDTxk1j/B3OuS/gdU02d8R4Ad5sgEV4z9BlgBZseRlNH6DYFyKwi
 QnVBtEew4lNAuNZCY9iKMZ+DnXhDs6PO3SQUTmx46CFARvCMqDRbdmOFXI1ZBQrKtuSK
 3ChNOB1QUNGnX1F7UZ2sN56aRkkcd/018px3yHFltj+Yl0apezp5YswMDViYmVtwE7gs
 xoew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv1N2jdhlL1fg9gtECXy8Q5MUzyhB3EI3T1L2/6TDD3LDiuladVkW+lJkTWTp0zwU6ulEkoQgzyCLi@nongnu.org
X-Gm-Message-State: AOJu0Yzoc3DhktRsuWK85tCb9N/e7bGMv6EJPOsc2UK6giBT/YOJNh8k
 oz5rEtdFwkLPQJbzU0W1CK0Pahd6i+HFWjYhH9pYlkKPFLlE2WK8qqwP+jHfcDk=
X-Gm-Gg: ASbGncufvnvcSb2Wdxqan/9A5NWCCGarJoa3+T8StIuTL8COJSHVGmIgVJsUj9qjm5l
 EAvCLzG3ll9e/PAPLi+JdwM3uEOx1ZrZRtWdLMl8LkXebHi0qLSWiHZ0YI+OpC3iHkE/PEpI5jj
 f5hNzxKNlGYOr3OjsfmBP01XUnlw83l4gZiNaE3hLseWxzKwm10jtQK/rb75g34ZV+R9esMFjJj
 iWOpkewOz6o6+v+udDsqnW1XVf3ZVQ8ozdU0+SCy2fU6pjqyNHbJupoq24ian3SfP0inJgI7P22
 b3Xo3yPHWv9oPp81Dmf+ZmoeK/Im2RLPqKpb407iczcQRwXpt4MYtu1JDCo=
X-Google-Smtp-Source: AGHT+IF/aNY9wHBQdMdImNhR8k70ElcOPtXSH8WBudVDQgBMyWBWeRB71v5j6MO5bYEb8V8MXBedwQ==
X-Received: by 2002:a5d:47a9:0:b0:38d:bd82:2f9 with SMTP id
 ffacd0b85a97d-38dbd820401mr1701240f8f.43.1738847696738; 
 Thu, 06 Feb 2025 05:14:56 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1dcc7sm1686667f8f.88.2025.02.06.05.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 05:14:56 -0800 (PST)
Message-ID: <7b3a7826-f24b-4e72-acbc-297f25d0d4dd@linaro.org>
Date: Thu, 6 Feb 2025 14:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-5-philmd@linaro.org> <87a5b07u1d.fsf@pond.sub.org>
 <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
 <65a115a0-a2be-1c5f-f11a-e8b5f89c3ce4@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <65a115a0-a2be-1c5f-f11a-e8b5f89c3ce4@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 6/2/25 13:56, BALATON Zoltan wrote:
> On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
>> On 5/2/25 08:03, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> MachineClass::auto_create_sdcard is only useful to automatically
>>>> create a SD card, attach a IF_SD block drive to it and plug the
>>>> card onto a SD bus. Only the ARM and RISCV targets use such
>>>> feature:
>>>>
>>>>   $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>>>>   hw/arm
>>>>   hw/riscv
>>>>   $
>>>>
>>>> Remove all other uses.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> Impact?
>>>
>>> As far as I can tell, this stops creation of the if=sd default drive
>>> these machines don't actually use.  Correct?
>>>
>>
>> Yes, since these machines don't expose a SD-bus, the drive can
>> not be attached and always triggers the same error:
>>
>> $ qemu-system-hppa -sd /bin/sh
>> qemu-system-hppa: -sd /bin/sh: machine type does not support 
>> if=sd,bus=0,unit=0
> 
> And how is this error improved after this series? This seems to be a 
> meaningful error already.
> 
> In any case, if you plan to merge this, could you please cut down on 
> adding nonsense defaults to every machine that are then removed again? 
> Maybe only confine it to hw/arm where most of the machines are, for the 
> rest you can point to an earlier version of the series in the cover 
> letter to show how did you end up with the list of the machines to help 
> review but the final version merged in master maybe does not have to 
> have all the temporary changes to avoid excessive churn. Or was that the 
> plan already?

No, I plan to merge v4 as is. If you disagree, feel free to post a v5;
I won't object to it, I simply spent a huge amount of time to remove
this dumb field, and there are still 6 other fields to do:

     unsigned int no_serial:1,
         no_parallel:1,
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;

Regards,

Phil.

